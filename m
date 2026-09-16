Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D79509EE2
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566541; cv=none; b=fm9xEF6zPHslfZlHEcELaPZvIG2+BECEKhnJtBTb9dmPknmORSIXJFA/M+y0lIIbcG7oo0pDkdZH1cq6ch7Bw2d9AzTRSNm8bqfSqTg1nepLokW7YVUn6yoIgekKP3un7CKnDnB7KniGgTds9x+0p9reAOag9yD1Hy9PXEwNimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566541; c=relaxed/simple;
	bh=7lB+s5yhRfL8HZrL1Ai8WTa0pZBQe1yrBx4vhLwrhNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+U33Og5T1GJ7qJZgDGwFsHhXfXBDiJZYEwpwpShwluSgPYS8ZenGf3Kj4dZyWMqGf5PcBThaQ/bKtgXsqI60BcRNMkeW6yA7JEY4oro6VfDgiYktc0pw30YKbCdoPcmwmDK0AFH4SUHxPg6RtYuJJwQhuoAC8+qpHbfw0bzR88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/qFvAYQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/qFvAYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FEC1F0089A;
	Wed, 16 Sep 2026 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566535;
	bh=aEnjYJNpLHpjzKawEmFO84vCAtGd0ogLcehP9Jh92yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J/qFvAYQZeGp7HvZ811NpCl/oFLQv9KnAzA5FiCTF77NeoME6Gac4kTNSK3+POq8J
	 cbLl9xRdpuOWYz4mnh5Y5SdCeBbeFvsFmA/InlRSI/DPYvh/n4BXQ7Q9Rax4SwPak5
	 CbqdCM4+PA4RnMHUG6X+dFO9Lpn6YhkNTcnip9EOJK270wkmhrxakuiGUePfd7W66X
	 ZRuBNMX8io7ROBc7VdFCb0XRCxs6rKHYy/D4A2WEmn0V0Q2waist/ZMAP8b335lotS
	 ltbim4X5Ovkuai9jqdWaaYd23zlP3veOTm7AoHfKWu88+71IGsntC3rCkf+axGwXeS
	 /4kTV17ZCH4Ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] tracing: Fix memory corruption from a "STACKTRACE" histogram key
Date: Wed, 16 Sep 2026 09:48:53 -0400
Message-ID: <20260916134853.2725775-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091629-carload-gala-1e37@gregkh>
References: <2026091629-carload-gala-1e37@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

[ Upstream commit 7f711e62355bb3123a2ca2f97a2facbfebc678c6 ]

"cpu", "CPU", "stacktrace" and "STACKTRACE" are generic fields, defined
with an offset and a size of zero so that the filter code can match them
by name. parse_field() maps them onto their common_* equivalents for
backward compatibility, but unlike the common_* names it hands the
placeholder back to the caller instead of NULL.

create_hist_field() takes a non-NULL field as a promise that the record
carries a stacktrace and picks HIST_FIELD_FN_STACK, so the __data_loc
word is read from offset 0, that is from common_type, and its low 16
bits are followed as an offset into the record. What is found there
becomes the length of an unbounded memcpy. Pick an event whose id is
small enough that the offset stays inside its own record and the length
is a kernel text address:

  # cd /sys/kernel/tracing
  # echo 'hist:keys=STACKTRACE' > events/ftrace/print/trigger
  # echo hello > trace_marker

  Oops: general protection fault, probably for non-canonical address
  RIP: 0010:rb_next+0x23/0x60
   </IRQ>
  RIP: 0010:memcpy+0xc/0x30
   event_hist_trigger+0x2e7/0x12c0
  Kernel panic - not syncing: Fatal exception in interrupt

Leave the field NULL, which is what the comment above the branch says
the code does and what common_stacktrace already does. FILTER_CPU and
FILTER_COMM are left alone, their create_hist_field() branches never
look at the field.

Cc: stable@vger.kernel.org
Fixes: 4b512860bdbd ("tracing: Rename stacktrace field to common_stacktrace")
Link: https://patch.msgid.link/20260907155045.692664-3-donggeunyoo.kernel@gmail.com
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[ Adjusted context for the missing FILTER_COMM branch in parse_field(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f3899430a2fb5..d5f688a26e4ac 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2390,6 +2390,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 				*flags |= HIST_FIELD_FL_CPU;
 			} else if (field && field->filter_type == FILTER_STACKTRACE) {
 				*flags |= HIST_FIELD_FL_STACKTRACE;
+				field = NULL;
 			} else {
 				hist_err(tr, HIST_ERR_FIELD_NOT_FOUND,
 					 errpos(field_name));
-- 
2.53.0


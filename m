Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C75377A8E
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566159; cv=none; b=oVZUTVoda5Kv8PJmcfeee6iF6CsN7TB37G58SYIxV8HnbILXOTwduIGpp2zV4f2ubgCNqvx2XvI73eZ2Nv9eMEokGe8hSkydpaprtZ6HvcW7/blkNTbllVSsDrwheIpwj71dF8IEqx6DnQ2SQg0+lY1v6nreR0uy3+V6r28RdmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566159; c=relaxed/simple;
	bh=7lB+s5yhRfL8HZrL1Ai8WTa0pZBQe1yrBx4vhLwrhNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBm1Aj1tx1jvWShylFlWxxJhxsldcPZ8lCBIZUyYuw9BkXfP26ng2UAM/kbz7O4uO4eHUo/Z8EQ38iIh17Q05bJzeX3rxtBuHwsoym9gg4+h+n3/FUpUri1W5HtfKzmyoiukMXUX9EuKV5pA/IQSajO5j1flw/UUMpjuQXzduz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/8A5vHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/8A5vHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33191F000FF;
	Wed, 16 Sep 2026 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566145;
	bh=aEnjYJNpLHpjzKawEmFO84vCAtGd0ogLcehP9Jh92yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R/8A5vHs3g4psYS/Zt5QjyKdniW358j7ar/knwHae40MoEI6xbSJ7V9YqlXFnujwL
	 U4wJn3un8KN/aUKopr1FkEQzTSg1JSsMzC9gx79hbUfFHBGbiGHSH7B4VZ12HuEVD6
	 j7BWURdejkD8ox6O2XI5GC3ViTCU6G8+1VnhJFRP/VgLOMA1GtFOU3pf7Vhn64+Zwx
	 4pzRbxfaV4sx5NUIMzouXx6Ch6ciCsV42t7svKPrxNtaHtRWvt77V7YEW8ZQkYqIfi
	 Xw3usv/WcXGB+uu1o+IUv7GAl5bSQ14OPOMO/P1NcT22edQyloGC1epU/up63JoAgf
	 ptpfhIrLw3AiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] tracing: Fix memory corruption from a "STACKTRACE" histogram key
Date: Wed, 16 Sep 2026 09:42:23 -0400
Message-ID: <20260916134223.2709969-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091641-chop-science-9213@gregkh>
References: <2026091641-chop-science-9213@gregkh>
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6BB4F4757
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569262; cv=none; b=usuzKg9qFsErvDKQklhJjaARf+cr+7oIxyJ/5fex0NpVNJbksAj41WZ2AdOSocf3Y1IgeGqUBUkwt00VC4LUC4qPMphY+4y/+ukAYUX2XcQpwpIhaGAWYkUpyThVg24Cbjd6cGzmEQo4rydBYd62iF2N338Jv7x6lARr1mCiyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569262; c=relaxed/simple;
	bh=qQvgoi5f3HF1plnAcKoS9rqJrrAgsAj5qVoGrK+98CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNrXjP5Xdq4ps2Sz9Nkk1ngzP7ywcDuNCvRKn3wZqKD+YeyNuZyfhvKl3NaO2caTDYnNL2rP47Foajy1FQoNl5W4WNO6TYtWKxG47sGtjmVLkfE+stKCR6rHyHdV+jz8BmEruLpsXKBFrZMGknBMavm+MJ+Ktxb/YPMVjkF6o+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEwuSxlp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEwuSxlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BCE1F000FF;
	Wed, 16 Sep 2026 14:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569261;
	bh=Q/FBO+3uqgcX18eJSLSzle5PwJJcShIpTOC+PWZkKEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fEwuSxlpiI8OvAMlx3amgLEZszIxWpg7exrjpRP9s9CM34DkrvpBgYlfeQCeDLseD
	 Jm9ceX3SbTJNLPcaiPaCY4hyBQmsO5S23k0m0S+DKxL/Ac1W+zMHm5agxYkoPkgzTJ
	 5nfDUpuZMtQ2kNlxUGUwpWwaOu36MzL1aOvls0AshjaS0DgZs3FYCWHjzxVLCWwWea
	 GEhZ1mF4ZUusVXh6pxNUWOpukrgRDVKQHO4JKGy6SdimSVV7lnkOhbAt3AoG71sXrk
	 VxzjPjVhZpmuMooi7d3Gf6qNcoSz8IOw2YVi1SCHJrihXAdhCx+gcDEwJ2fek6RFkt
	 xOBoIif4V345g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tracing: Fix memory corruption from a "STACKTRACE" histogram key
Date: Wed, 16 Sep 2026 10:34:19 -0400
Message-ID: <20260916143419.3351460-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091630-multiply-subfloor-93e7@gregkh>
References: <2026091630-multiply-subfloor-93e7@gregkh>
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
index d7e8018559938..0abb487a5d281 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2397,6 +2397,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 				*flags |= HIST_FIELD_FL_CPU;
 			} else if (field && field->filter_type == FILTER_STACKTRACE) {
 				*flags |= HIST_FIELD_FL_STACKTRACE;
+				field = NULL;
 			} else {
 				hist_err(tr, HIST_ERR_FIELD_NOT_FOUND,
 					 errpos(field_name));
-- 
2.53.0


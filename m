Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4323E35F
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546548; cv=none; b=qr2evK+p33mi8beTHhyYFIjeMQf+ZAnGQbLjgJxkXrul6l7XoqJdPbXQWT7KwkNfiQAiNLk3v6sE283WavNoRLILMjHA9NKuXLi+zfTPPRZf/NpJUAq+rcz00GdKqCOHgCCB2QfbaKQ7JxiWH9XmEV3TDyLOuXcQMOgwRTumrvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546548; c=relaxed/simple;
	bh=9hTNuTBzDXfi+iupvRAPh58gYtJDMSm4Akad3v2yDHU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=esx0GG+YzUPZLRKctkQXREQRc7iUDuSzL2hKDsLBZryCZuxKak+eAJ4huWfLrk0TTOlLO+mpmQYK19rAk1QcaMhSLbe15pJMVgZ66JYk04HLp9Jdhlkeg+Y7sTtjhZ9LMrgbHz6Uk93ffjyB8WhDLDppuIYreLTJDMPPjwtxnG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F49cxT5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F49cxT5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD4D1F00893;
	Wed, 16 Sep 2026 08:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789546538;
	bh=X+1/1kh36RsaZKpRGQxbfkedn9TjVBwWxHqp8rbSIEk=;
	h=Subject:To:Cc:From:Date;
	b=F49cxT5gMK4KzxHMhNpB/AkWBPck9QdRUfjbEXWe565pjMo6IZc4HRRKwJUkkLu/r
	 VVTnJoSe+7qtRTYG6edKrEAuRaHyrkU03KJICJRXlGudu1KpwVh+sjSrewlSUATOBs
	 xrEyd5uTVp/3jCsNAsh/iXK4NPIMoaoyiGc7A0VA=
Subject: FAILED: patch "[PATCH] tracing: Fix memory corruption from a "STACKTRACE" histogram" failed to apply to 6.12-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 09:13:41 +0100
Message-ID: <2026091641-chop-science-9213@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7f711e62355bb3123a2ca2f97a2facbfebc678c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091641-chop-science-9213@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f711e62355bb3123a2ca2f97a2facbfebc678c6 Mon Sep 17 00:00:00 2001
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Date: Tue, 8 Sep 2026 00:50:45 +0900
Subject: [PATCH] tracing: Fix memory corruption from a "STACKTRACE" histogram
 key

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

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9bc829c1e876..8af97fd4ee2d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2404,6 +2404,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 				*flags |= HIST_FIELD_FL_CPU;
 			} else if (field && field->filter_type == FILTER_STACKTRACE) {
 				*flags |= HIST_FIELD_FL_STACKTRACE;
+				field = NULL;
 			} else if (field && field->filter_type == FILTER_COMM) {
 				*flags |= HIST_FIELD_FL_COMM | HIST_FIELD_FL_STRING;
 			} else {


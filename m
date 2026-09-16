Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7EB279903
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546778; cv=none; b=if4bG2CjgPqyVYryM/12affSDEBmkBrEL/O6VPrGuJiLuW1I0SsiabhrED8WoKanx/iwxtDsIY0oNub4qQ/V9NAMTMAC6sVKzvjRxQC0P+wuDo998oRKqKUeaLA1/OX0pFJ1NDH0ZD/MOoox6Ys+OeVN74mlmyGwDAyL4KRFqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546778; c=relaxed/simple;
	bh=ngj3tVsidCcxrir1fuNuIm8yDcnzNaijTiFI9SyUUrs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KKP10qUuqCs/FhBnHOlW/EeLNfwvzQDQK1URDhR2hhkOqNAl4L5Ddh92tMpjcMUVpo+z23YL/+9lvTdql4bB4FRaBxJsaylgFE2i8srSTFw7y5E60KQlWxUQPbZx6c+qyXrsvwTk5hDD/9o0nlfbH2Px66yw0byGs5H+sRd/HH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yX6xUzW6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yX6xUzW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309F71F000FF;
	Wed, 16 Sep 2026 08:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789546771;
	bh=9cKyYVfedbixlOj1dGPSnoxQdKaam25Jp4ijy9jtzfA=;
	h=Subject:To:Cc:From:Date;
	b=yX6xUzW6DZCFGkQW9KgBzM8bRoOhHQi/1WpyNFahOV6vbyHI95IA9oymSomm4As1X
	 GO1lPIh+uwXTawnfhDEI6BEY8v2mVIO5INh3Ah9xE1iTOsCsp6sUm+ClxJZwY2fWn0
	 S9DPpglG2xDHLRCBFzewfTvkzpGKOGYozkG9xB08=
Subject: FAILED: patch "[PATCH] tracing: Fix memory corruption from a "STACKTRACE" histogram" failed to apply to 6.6-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 09:17:30 +0100
Message-ID: <2026091630-multiply-subfloor-93e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7f711e62355bb3123a2ca2f97a2facbfebc678c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091630-multiply-subfloor-93e7@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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


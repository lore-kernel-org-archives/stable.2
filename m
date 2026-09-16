Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFB73B7B70
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546772; cv=none; b=GEUyfpk1CF0cbNDstaPGncHToC0Rm3EiVXKlfl57b42ZecysD6gfu4e2OFkWueEeUuhPA2HZs8EZ3tbiWwuP3nOqXID0x/Ae2Ew5T32fRahZVtCfvtRb9vnASA7tt4vWddf+tr563DqZIYTljmo4w7zE9pb/j2Z0MFJym1h5HQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546772; c=relaxed/simple;
	bh=u1oueHauhE3+Uhx480P+4dZE9p/F4wS108WFEQTPS9w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AqlWn2B4cUkPb107gX/SnNRhTQ6G3Rbd9QUrgQvfIUYp9InNJr0YA9E3o2ppCVpuMbflM17d8i70qTrgDIpcd7SWLxeeXOB4gak3wvK7GdHuqzp/aYw1HIlftDR7yL6h5otdOchJGw2yxus3NK+O3TKrdBYuFsVmyIMURANRS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wtevdsHG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wtevdsHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371B21F00893;
	Wed, 16 Sep 2026 08:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789546762;
	bh=MUEy9soqafXw0M3I3Hu5+5MEcECXhkRKVnhmntQzJU0=;
	h=Subject:To:Cc:From:Date;
	b=wtevdsHGFsZdqpmPpDT/5d+1C56vsVI9xMSyv8dYA8O0HGCWYqy0wY/r+7xHIXlXs
	 dQgfE02kHRwukYgy+m4V5pZcIzXCRHtXWFeFFY/nrfx+4zUpaEIXdQ7jYXADX6KH6Z
	 iQ0nMqBEvpZ/BVFoVErgYVXulwgs9AkdobTmiotQ=
Subject: FAILED: patch "[PATCH] tracing: Fix memory corruption from a "STACKTRACE" histogram" failed to apply to 6.12-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 09:17:29 +0100
Message-ID: <2026091629-carload-gala-1e37@gregkh>
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
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091629-carload-gala-1e37@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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


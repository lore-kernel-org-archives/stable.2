Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3C472523
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195222; cv=none; b=UWN+Bmcy/zL/fCbg+wi3IrG5fmqDURIFdHTxe4cRfy/Ven8Rb9Ae9Us81s3H8g4onJ5W+3WE/kw78fDZl5TV6Wpa4xTOlDrKiP7wZBxwaZ44MVbX02gXxXHXhVtrT+W3pbPg2g6hU0oFhoeKa5Dckrbq14LML1ofG7lKQEoyiV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195222; c=relaxed/simple;
	bh=VgpJNz46NJ357YYRoIzpbvhYHypW1MRGOvGe0NLxUBw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fIQ0wW50IReUU2OdZjR0NNDgI4fsn6gQvVHyc+TqW8Ee8jPrRjCZl+JFOYLNG2Sv2DrnmtRRl2z1ZKdoC3PdoMsBHcNORIakDR1TbfKRTKVTPID61/+aPrkuBGGgU0tpsrhQUkdHzUhCQn/UqYPsk3Ic9jzI9aYm9JU+E3zAXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xYdjo9XE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xYdjo9XE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244171F000FF;
	Mon,  5 Oct 2026 10:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195220;
	bh=KuRMkpfld3FLAuNVIHwX3RIC9LWRGJsb2pmSanScOTw=;
	h=Subject:To:Cc:From:Date;
	b=xYdjo9XEMRaykqvxZn6uMf2xzzY3tsHOloQIXyujNc1l36RathH4o7bLJBUzl8ZyQ
	 60xF3/tfXBAP+u4WoyEgL7yBeePc1EMlLRE/yh45y/QBAnTRP/KgrEXDn6j9ES6J5y
	 Rq31h+YmLJbDj4c2pLI9QVAXIj8qEQ8xWgMl1jIA=
Subject: FAILED: patch "[PATCH] perf: Require kernel access for text poke events" failed to apply to 6.6-stable tree
To: zcliangcn@gmail.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:13:17 +0200
Message-ID: <2026100517-unfixed-scale-50cd@gregkh>
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
git cherry-pick -x 357e8a77a501d96c9517f01f4a211eed5e9c9184
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100517-unfixed-scale-50cd@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 357e8a77a501d96c9517f01f4a211eed5e9c9184 Mon Sep 17 00:00:00 2001
From: Zhengchuan Liang <zcliangcn@gmail.com>
Date: Mon, 28 Sep 2026 10:59:35 -0700
Subject: [PATCH] perf: Require kernel access for text poke events

Perf events with exclude_kernel=1 can be opened without kernel perf
access. However, exclude_kernel does not suppress text-poke sideband
records. Every PERF_RECORD_TEXT_POKE is marked PERF_RECORD_MISC_KERNEL
and contains a raw kernel instruction address.

An unprivileged task can therefore open and mmap a task-local software
event with text_poke=1. Both opening a count-only tracepoint event and
configuring UDP GRO for ESP-in-UDP cause updates to inline static calls;
the observer receives the relocated addresses of the modified instructions.
For a known kernel image, any such address reveals the runtime kernel
text base despite KASLR.

Call perf_allow_kernel() whenever attr.text_poke is set, regardless of
exclude_kernel. Events that neither monitor kernel execution nor request
text-poke records retain their existing permissions.

Fixes: e17d43b93e54 ("perf: Add perf text poke event")
Assisted-by: LLM
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/99131354c41e23188f778b92f90363775b482395.1790573390.git.zcliangcn@gmail.com

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3aa223595e7d..7846d70be57f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13906,7 +13906,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel ||
+	if (!attr.exclude_kernel || attr.text_poke ||
 	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
 	     !attr.exclude_callchain_kernel)) {
 		err = perf_allow_kernel();


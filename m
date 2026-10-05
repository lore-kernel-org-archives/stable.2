Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7D146D0B9
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195219; cv=none; b=XNybWoNhJCNYLf6ItjdUWXjcMkNJxVX+Jl/7eGmmXx+Z/NZhHPwivR5gIIIsaYeGqqa2zWGnlH1dV65eu+HYz7esBLYQh6myO/4W7gXEyOmHNcQyy4szDjqqGKNcQiBy3JJ8qCJfqS23+q4S/r/yDLpSKAcnXWx/wsnurcVYCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195219; c=relaxed/simple;
	bh=9ZLp+QZxZt1GID1ojLfB2V7qyju1eTiuirokuesGELM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kZPdU97+xJe+EfcFU86LDXo9fjWiwzJsM0ziUq9ZYZrnp2vi13XwCsjTNJa9HnaCDNYtSFdK8oklqWDMtl6Qc+uAOfZ++HuRNGGWetz2SvxsdQqoaLiMnbKC27N+ng5bJ3FpPBC/T5qKugpAcVeIE2ya+kzh6WyrfFyNnAMDkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jCI+w+cC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jCI+w+cC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC361F00893;
	Mon,  5 Oct 2026 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195217;
	bh=py0Fu0LvMZBlKn3Wp0S+a/jEL4C8YZZRfsLT3Xv4Gy4=;
	h=Subject:To:Cc:From:Date;
	b=jCI+w+cCSKSS201DVmYd95e8kr6HcOyq/QmCG2ad//NxzHInMWwNq+EsjjM3afdHG
	 L5po/Tt57gXCvJPfKEaISR67v329ibFr5p2lppiRm1oCl3W1MfurFKV1KVc/9zNOC6
	 UjMBnFhLuPs7fhI4cYZFOsHHq4tEf94odqHBw9lo=
Subject: FAILED: patch "[PATCH] perf: Require kernel access for text poke events" failed to apply to 7.2-stable tree
To: zcliangcn@gmail.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:13:16 +0200
Message-ID: <2026100516-douche-preview-30a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 357e8a77a501d96c9517f01f4a211eed5e9c9184
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100516-douche-preview-30a6@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

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


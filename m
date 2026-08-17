Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24464415F07
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971014; cv=none; b=gLH5GibOv5WzEDhNgMQ8bIHhtwUiRdKfpA+0mT4MXq/uYHUHFZXNbb9ecgZw7G8VX/ta+kr2IWFSeXfwdc078fQCI5VsExFcbDarjRCsnud9gz8fx17xgd5gwhudcLb/qJDaIv3DTCLf5t7+0w4mRzEiR+6piZPod34OkJqK7Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971014; c=relaxed/simple;
	bh=p3PhRI4/PPor/WZE+6rA3W1C41gvMQwvCKKxP3fOdmU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nbdEZexP832jtW/jFCPy3/5vXiG737hlTT2QP2K1zcV0KpjBF3LOyQUroQ7mn2IDeRpNlxQdNhS6/NdBzUyqSSRQ2tNtLcnKMd3tO4ZQEGL20TzRZzVMhfZ7LG2j2XVHkMiP06ktRzuLCsO5yrCa068H8yN/3IpD3zlzl5OyAp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KF3fRv2P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KF3fRv2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22201F000E9;
	Mon, 17 Aug 2026 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786971012;
	bh=9z3IjBswAPkRnojvxF+oWSxXGhcQFVL2CbjCLwopeus=;
	h=Subject:To:Cc:From:Date;
	b=KF3fRv2PZoc3S3B8ckl4A/hUlvI79darjaardLtLZnW1c+WiExE0sEiLZTWIHDOmN
	 /uYW3LDC5ZPqcZhwbF0AgyQEqMad3ssW2unMNVBfmF/UlOc58mZj3aViYy5cEDxsHI
	 i6VmKv19OKIzU2hIGpZzorSPUR8P/9+Tne5/Eecw=
Subject: FAILED: patch "[PATCH] ring-buffer: Prevent resizing of persistent ring buffer" failed to apply to 6.18-stable tree
To: vdonnefort@google.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:50:09 +0200
Message-ID: <2026081708-platonic-evade-02c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7c727dfce6be04dd009b29091a4a17d952dbfe03
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081708-platonic-evade-02c3@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7c727dfce6be04dd009b29091a4a17d952dbfe03 Mon Sep 17 00:00:00 2001
From: Vincent Donnefort <vdonnefort@google.com>
Date: Thu, 6 Aug 2026 22:13:01 +0100
Subject: [PATCH] ring-buffer: Prevent resizing of persistent ring buffer

Dynamically resizing a persistent ring buffer is not possible. Disable
the feature.

Cc: stable@vger.kernel.org
Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
Link: https://patch.msgid.link/20260806211306.3704194-2-vdonnefort@google.com
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 58dc8995a88d..09d502ef4c55 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2528,6 +2528,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		if (cpu_buffer->ring_meta->head_buffer)
 			rb_meta_buffer_update(cpu_buffer, bpage);
 		bpage->range = 1;
+
+		atomic_inc(&cpu_buffer->resize_disabled);
 	} else if (buffer->remote) {
 		struct ring_buffer_desc *desc = ring_buffer_desc(buffer->remote->desc, cpu);
 


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC84BB5B9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446479; cv=none; b=FYpkm4PQ8gDc/H6diiaNw5f9lInx6hH42sBaltsrU+ChE/Lv/BTYdavCFne2DAlctjWNlCFxzhyyKwxeQEaRWa8qsiYZHzr/KnKZTWGYkNdssX2lOo5+Fh6v7U3Bbe9geQiqHapTskBRBdfTFVJhoUOWR+s4OlS/n/0HIdUzT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446479; c=relaxed/simple;
	bh=H0h1fAtTpNyRsN+yqYdrMHCjrl2/hz4wstIrxKeV2n0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c0p/nbknKydJTLAk9A/PSPAJyyNCRGfqiIBgG57PtjAErpDEmmJUBPbk8zTeDcDoyep1uNqtKEfwOr0sELO1q8WeQWnBvdy0zIe2SMB1fy5/bsE1uFrcYF60lIkYGEJoSnH6314+YN6XzggwPW2JtratZED0jzJRHhv5VqdHCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HD9NGFog; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HD9NGFog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0372D1F00A3D;
	Thu,  3 Sep 2026 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788446473;
	bh=yJ+4sayB6118YP6HhU1Sfob4QpRMJkVciwD94q7TTvQ=;
	h=Subject:To:Cc:From:Date;
	b=HD9NGFogidgg0yFb0OTNQ1tXscQtHc2XUzOQrGfon7RwXa6QSi+H+LO9BZFJJW8c5
	 pH/PHNE0DM3XauEuyGkkqqz4jHLOH8RAIXlVAi2/WYUoj+JA7xUAJ0F1M+kFLxoO6W
	 KQWqOAA9iSLivVMyfcfDqLeVi2msis2tdBrzR1Rg=
Subject: FAILED: patch "[PATCH] ring-buffer: Fix subbuf resize race with" failed to apply to 6.12-stable tree
To: vdonnefort@google.com,rostedt@goodmis.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:22:52 +0200
Message-ID: <2026090352-announcer-magnify-98b4@gregkh>
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
git cherry-pick -x e743527c5bfdceda1095bc0a9e596e2aebb6a9c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090352-announcer-magnify-98b4@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e743527c5bfdceda1095bc0a9e596e2aebb6a9c3 Mon Sep 17 00:00:00 2001
From: Vincent Donnefort <vdonnefort@google.com>
Date: Thu, 13 Aug 2026 14:11:47 +0100
Subject: [PATCH] ring-buffer: Fix subbuf resize race with
 ring_buffer_alloc_read_page()

ring_buffer_alloc_read_page() is racy with ring_buffer_subbuf_order_set,
it can allocate a reader page with an outdated order. This isn't a big
issue, the user can still re-allocate a new reader page and try again.

However, what is more problematic is if the value of subbuf_order
changes in the middle of ring_buffer_alloc_read_page(). In that case,
bpage->order might not match the actual allocated memory.

Use bpage->order for the allocation to prevent this race.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260813131152.3589632-6-vdonnefort@google.com
Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e436793ed5c1..796c10319d6a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7018,7 +7018,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage->data) {
 		rb_init_data_page(bpage->data);
 	} else {
-		bpage->data = alloc_cpu_data(cpu, cpu_buffer->buffer->subbuf_order);
+		bpage->data = alloc_cpu_data(cpu, bpage->order);
 		if (!bpage->data) {
 			kfree(bpage);
 			return ERR_PTR(-ENOMEM);


Received: from va-2-19.ptr.blmpb.com (va-2-19.ptr.blmpb.com [209.127.231.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6175D3B9DBF
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788152148; cv=none; b=UW0XjEYbXF6HETYNEsKCBy8derEGJEdKw3VvLHIfbxNetZvfJ/Yua5ociyfGZWpZisxjMsfagGOFHtjyHAi6L9ImNRcho5w2vQqd32IFgU55jXhTd4cwCJUfwdHYsRI5kthpTVwZasmXvfxY9lFBv6P0t/1kXlP/MPuTn6Voimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788152148; c=relaxed/simple;
	bh=Ax64etgIAtuiMSY9v0hJJ+Zy8ZscVg0ooBhAR4GMufM=;
	h=Date:To:Content-Type:From:Subject:Mime-Version:Cc:Message-Id; b=oOGtD/f6FS6tSFJQqyX8c1VpsmQMp/pydf0PhuPRNj2/YfcSfbZBQOS6UPL2oqB12xumfXq6DqspTfmOqPm1nJOkNv0F/WsfZH1XMe82oRuA4oOmkmoDddcMawgXXVnr0iFulvSyq5c3HxBBRRUhrnkgY1mV36qRl+Qn/Infzdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=Y37iTFxD; arc=none smtp.client-ip=209.127.231.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="Y37iTFxD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1788152133; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JTNBYzTVvEFBkVlvhYr+tJv6fEBe1dkT+9DimDVSK0U=;
 b=Y37iTFxDgy266GXCcKQQApdWhoWvqVDz00PXimcy94eEbjNdGtHBXPFyRrBZv3NOkYDX74
 R/CANjOx8Kq5YsCKHGwAkM5mNYPXRo9wov2t6FOOnn1d1UQtm9zXJQmbG6iPt8YzSYIgSA
 eI44Ps0AJwWxlb3hQv/fUgnF9uReON2EqmagClyI1/wg8MrWFyK8H/OqrArsZ5GJpYeEwQ
 7Q5sOOTH1PKrAoPIWpP6rXwmhDG5QIWYxhXM3NJ2bS+xAJT0x1VhqHKo3vnpUVu1hs1G/b
 B2ah/huySN0tdtn4JJQYblsi7/BQ9ZgAnBAk2iqfYBJDYjmU5Uli36nA+H0yYQ==
Date: Mon, 31 Aug 2026 12:55:06 +0800
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Mon, 31 Aug 2026 12:55:30 +0800
X-Mailer: git-send-email 2.34.1
To: <tiwai@suse.com>, <perex@perex.cz>
Content-Type: text/plain; charset=UTF-8
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
Subject: [PATCH] ALSA: pcm: Serialize PCM mmap with buffer reallocation to fix page UAF
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <linux-sound@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Kimi Security Team" <bug-report@moonshot.ai>
Message-Id: <20260831045506.889070-1-yilinzhang@moonshot.ai>
X-Lms-Return-Path: <lba+26a950943+78c6d3+vger.kernel.org+yilinzhang@moonshot.ai>

snd_pcm_hw_params() and snd_pcm_hw_free() guard buffer reallocation
with an mmap_count check performed under the PCM stream lock, but the
lock is released long before the buffer is actually freed:
snd_pcm_sync_stop(), constraint refinement and do_free_pages() all
happen in between.  snd_pcm_mmap_data(), on the other hand, takes no
lock at all: it validates against the old buffer's state and
dma_bytes, remaps its pages into the VMA, and only then increments
mmap_count.

A concurrent mmap() can therefore slip in between the check and the
free.  remap_pfn_range() installs writable PTEs for the old buffer's
pages without taking page references, and the subsequent
do_free_pages() returns those pages to the page allocator while the
VMA still maps them.  This leaves a stale, writable mapping of freed
pages: a page-level use-after-free that can be leveraged for local
privilege escalation.

Make snd_pcm_mmap_data() participate in the buffer-access scheme
introduced for hw_params/hw_free: acquire runtime->buffer_accessing
before validating and remapping, and release it afterwards.  Buffer
reallocation already fails with -EBUSY while accessors are active,
and the mmap side now fails with -EBUSY while a reallocation is in
progress, so the validate/remap sequence and the check/free sequence
can no longer interleave.

A reproducer that turns this race into a stale writable mapping of
the freed DMA buffer pages is available on request.

Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Fixes: 92ee3c60ec9f ("ALSA: pcm: Fix races among concurrent hw_params and hw_free calls")
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
---
 sound/core/pcm_native.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3937,20 +3937,33 @@
 			return -EINVAL;
 	}
 	runtime = substream->runtime;
-	if (runtime->state == SNDRV_PCM_STATE_OPEN)
-		return -EBADFD;
-	if (!(runtime->info & SNDRV_PCM_INFO_MMAP))
-		return -ENXIO;
+	/* don't race with buffer reallocation in hw_params/hw_free */
+	if (!atomic_inc_unless_negative(&runtime->buffer_accessing))
+		return -EBUSY;
+	if (runtime->state == SNDRV_PCM_STATE_OPEN) {
+		err = -EBADFD;
+		goto out;
+	}
+	if (!(runtime->info & SNDRV_PCM_INFO_MMAP)) {
+		err = -ENXIO;
+		goto out;
+	}
 	if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
-	    runtime->access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED)
-		return -EINVAL;
+	    runtime->access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED) {
+		err = -EINVAL;
+		goto out;
+	}
 	size = area->vm_end - area->vm_start;
 	offset = area->vm_pgoff << PAGE_SHIFT;
 	dma_bytes = PAGE_ALIGN(runtime->dma_bytes);
-	if ((size_t)size > dma_bytes)
-		return -EINVAL;
-	if (offset > dma_bytes - size)
-		return -EINVAL;
+	if ((size_t)size > dma_bytes) {
+		err = -EINVAL;
+		goto out;
+	}
+	if (offset > dma_bytes - size) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	area->vm_ops = &snd_pcm_vm_ops_data;
 	area->vm_private_data = substream;
@@ -3960,6 +3973,8 @@
 		err = snd_pcm_lib_default_mmap(substream, area);
 	if (!err)
 		atomic_inc(&substream->mmap_count);
+out:
+	atomic_dec(&runtime->buffer_accessing);
 	return err;
 }
 EXPORT_SYMBOL(snd_pcm_mmap_data);
-- 
2.43.0

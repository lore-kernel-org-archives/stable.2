Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393055;
	b=odcxE7yY6fDV4/8Cpuf8K/Du8h6I/1PQD6KT1fsw/qEEdr3kqiiyhyN7jXRudSYbjDEv
	 216B6IOBDBpkejAwaGU96mcS8W2xYf0RHr6y+WaTXHgU0zFuCjCc+jRR5P6zahceevBm2
	 ZA5NbHmNTxGZBMsM2sTTeBLnBqB7NZkmyzJiwQgNiKzUnxr8R5mP8qdS4pcPmuleqrg4q
	 gI+KPUumssZOpF2K25foMvAikZz66qq6cfb3+WK4DjFOUNAEbqWOUAcHk7fphwxpnDCUx
	 DsZdKTu3GsuXi2igj+q/DbvZLMbnoMwH5oF2ibTUPcYdRohGBnHyMQsGdDtbdeMn/4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:MIME-Version:X-Received:Date:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=DSlnmf5Y/dE13YqistFiwJnejRPeyo3JQxaBXnk1KRU=;
	b=vK/HWb+F3selBIsG8c4/qClJKwAEFxlR33+nL/P2Exn0xCuwXpA2/84XFYTgY3Bi7xJX
	 PH0MLXYaqxZcR/teZiiGlo/QnkIXfQWnfCjA6mQvki6MH6Jp8nVASPymVqVRv2il8NAYT
	 Wv8wDgUlxZvc3ezaRFOzX1npQKt+wHB1U1JF9pRJd83ikAb2PV1R8WdF+7NIPH4q0Rpfl
	 bgJ59SkLPbP50nZphCbTuz/ME/2NUJ/ih6LbO5crEM7twrIdOL4uxIPgMVRBsLOH3FAzb
	 njsRTd46jxLTDfznpA/F02nmucGEM+j/ZLds/uyCTyaTXWeB1GPQOzpIG9AIlbZPKHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dO0sjXln;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D348606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 20:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D348606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dO0sjXln
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3552883bd19so4550333eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 13:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793393053; x=1793997853; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:date:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DSlnmf5Y/dE13YqistFiwJnejRPeyo3JQxaBXnk1KRU=;
        b=dO0sjXlnleCUcLpXi4+J7kx552VHUv3qYnTZRcKFzzAjQ4dRRR2Ba6LuU27hNlQ1JV
         JlalXKTeXaFSrzThp8x2nmql5ZlmONx2sDiJ0EmI+ifOtl5g/5Svkp5H4Mci3//1MHA1
         Cr/gYxCNxsmOOvRKGvD7Ktlh40fzNHZAuq4L+T4t1cn6L/q/c1iSYRN0RwTSQ7hIQCrT
         5DonK0tJrj8qtidPs8Rtddg8VPDn4C6dNpAHhvTI0UIH4D6eed+Qq5fLFTCCf12bg+X3
         5lP0WR8pcNUn7kEY+y8WMr2VHal9LR/fdqGLIPmknc/QkLhnZNVorwoamROB+qzMP3/0
         v2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793393053; x=1793997853;
        h=content-type:cc:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DSlnmf5Y/dE13YqistFiwJnejRPeyo3JQxaBXnk1KRU=;
        b=NUwTXK9k5EesP31HSvYi1diTbPG3TXD0RJVBbdNtt73501VON9fK5tBlkODW07u8AX
         azafzvdeaXG8Xi6Bw30atXlaY+elZvXKEkasYVViU5TH3gemg06mhvH4IKNk8Ki/i6nk
         ZHohBJamGFUkWBal+AP5u1CBn5AuEucR7lc2tZRhztFzFvYBerNbwWabQbpVbPZdYRnv
         LlcZY1RpAedgvJEgnBIVEl0iy5duANo66TRKqikesnF8dBR4Kt2iyFs/HAjT+kOs723E
         LWYBbgyuVMiLZmYbtTcMMd+ljbXd+2jTNCSw8FfxoBYy9TdYso6hP/9E4MPWMc9c2mt3
         SGRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTnylUAdCehAJakJ3kJYbyxTplcWfXyM7CDaGu5UIyK3nC3H2klEcdpJ827tXmu8cMV6Pdk9Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZHtGjYdCYVgUhYdvRwUwTyO/eXlV2T8aKRLT97zYkc01dHz3E
	tA3Qfcy64jWUZ4qKYFw3grKy6jztUxAWnM+1ECPQTP0iwXs8fqLjNlsa+2MVESqoARbOwJ94a3j
	2m7jdp3mF4KdPvqHyIytw8slaT1CTGw==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: from dyaz18-n1.prod.google.com ([2002:a05:693c:6392:10b0:36a:15cf:f589])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:88cb:20b0:343:9eb1:9940 with SMTP id 5a478bee46e88-36a423e8150mr4993140eec.26.1793393052930;
 Fri, 30 Oct 2026 13:44:12 -0700 (PDT)
Date: Fri, 30 Oct 2026 20:44:12 GMT
Message-ID: <18e3697ad6321d35.3137322e32332e3235332e313736.e98e6.0000sendgmr@google.com>
Subject: [PATCH] dma-buf: system_heap: Reject private mappings in system_heap_mmap()
From: Chris Wiseman <chriswiseman@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, "T.J. Mercier" <tjmercier@google.com>, 
	John Stultz <jstultz@google.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Philipp Stanner <phasta@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Chris Wiseman <chriswiseman@google.com>
Content-Type: text/plain; charset="UTF-8"

When commit 381295758792 ("dma-buf: system_heap: Rework system heap to
use sgtables instead of pagelists") stopped using heap_helpers.c and
added a custom system_heap_mmap(), the check rejecting private mappings
was dropped.

Other exporters and buffer allocators reject private or copy-on-write
mappings in their mmap handlers: cma_heap_mmap() and mmap_udmabuf()
check that VM_SHARED or VM_MAYSHARE is set, and drm_gem_shmem_mmap()
and ttm_bo_mmap_obj() reject vma_is_cow_mapping(vma).

However, system_heap_mmap() omits this check and calls remap_pfn_range()
even when userspace requests MAP_PRIVATE with PROT_WRITE. As a result,
subsequent CPU writes to a MAP_PRIVATE mapping of a system heap buffer
fault into do_wp_page() -> wp_page_copy(), silently allocating private
anonymous copy-on-write pages whose writes never reach the underlying
system heap buffer pages.

Reject non-shared mappings in system_heap_mmap() with -EINVAL to match
cma_heap_mmap() and mmap_udmabuf().

Fixes: 381295758792 ("dma-buf: system_heap: Rework system heap to use sgtables instead of pagelists")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Wiseman <chriswiseman@google.com>
---
 drivers/dma-buf/heaps/system_heap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 1ef1bb3acbf1..f668dc8cb54a 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -235,6 +235,9 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 	pgprot_t prot;
 	int i, ret;
 
+	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+		return -EINVAL;
+
 	prot = vma->vm_page_prot;
 	if (cc_shared_buffer(buffer))
 		prot = pgprot_decrypted(prot);
-- 
2.56.0.317.g454f8302e1-goog

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795188664;
	b=qa6tmiBHvAZp6/ptUZ7CdEelLB0RtbNw2N3ZEz3wBjkSBFwOSD7Nwyd65jQdLNkNlDjW
	 uI6sYyZ42CX7gzzkRyYukUzbc9/epQI0/donGYjhGnSzAWs3uOGF8qTf1utxP6SfDVqxO
	 CPlxhUEDt4/p4mSfscV/osTKjVHKqcd5xQlp+4gk7/Ur/emLBtWq2tvcgjPy/89Wi6JE3
	 Q+RF8dHWWIqvaLYtnEbxzwcJlaU5wpGtKAFVr/D1Nl9K5ODuQlQDh8kkFwY5fwXSFL80v
	 w8cPtBz2N5hS4da3mhavSwMFn57l1ow/TQxXIFimdx0YngrZM1F5P5d4W1/p5trjOqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188664;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ic/Tkesv9swqUgqf5iFVky14aDs798pTEmP4wTv+sGw=;
	b=ycn5mGSoRppTb8eGUvdJ7q7mdItUn+XQdZCiukk/fkM3gwqEdV7+ZHARKYr5mwNJ2o6h
	 NCug7RjhmekRCQhKPr5neS0Ye5TVy8V4vm+Pq/Ef4cmIXorR0QK2fj4JQ+PvisQWRqe+7
	 ywy8MGw06215+D6J94pkQKzvwJz5e677pL3wLfGuZ4/AzVnxt/47WnY0Dy0gH3WANC3OK
	 QSg2+H9wPz14zrb9Eo+q79VKaSD07cXKO/qpOb+ovq+Oc2MMK4hMRhymUwRoTis6fo4rK
	 3/n0SjsxSiNGjSHmZue/fvwpssXLX7NiElDrKXnigkb2Pb51pUBer3/+/AcshUbCoLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFXWRAbD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B58606A320;
	Fri, 20 Nov 2026 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFXWRAbD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795188664;
	b=2Sr5qRwqiJogqUwmNPr94QqJinb9l9DOwhXT97/ytYIvjOh5v756+Y8b/hW4KqU8diFq
	 GTbVd6o/8x8N1R7HvQuadcXlTK1bbi+ov5SGd5EBkFwGSe4I0OXWintgclidniwMJDw0g
	 ucwcQW8dwdN7xwZ1hnvrSB3V9Ratdlr0L5699H/q2FhNdorHut+91mKvzpH43sawNCzv+
	 4JBd7fLAI68Noe+7H95/DkpVBAil2vebDRF3ZdrWh0wYxkU8CtV+QfRWryJwYVdS0fR6G
	 o0rcNwnzpUtyxJJ/OwoQzXF7+vpLhFTT4l1Vy//641S2i8B6Oy3TmCIfPHdrN4KCSpA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795188664;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ic/Tkesv9swqUgqf5iFVky14aDs798pTEmP4wTv+sGw=;
	b=2mghJqf5BBy0DBpoyja+CVjfDKeifQzpXzu+RjlbAWN2n2FJfkTj6++HcIee35cLuLgF
	 /2buvZ43PNwnJcfTUU+k4jWpV3fy9USGKh5HAThBO4Phllu3xtyTD1VBj4m6rTRijdm4S
	 kBfA5rkabuU6YV18QRpPT0xzoksLgD89LTFRiDpaHT8e/GgcwgCjGY1KG0yS9rLJrcfbX
	 hVeFjeqBXtq4CfiNDxiuAyRsEIht/PIF5cDQjXrbaCUSzAZrA8cz6QnMuX2k6JCk3gwJO
	 arDNrKPI8tcvASRSEvBf6DmMdGXu2yb5toAPE+HNeLxTPoyXL4Z6O7+kbAoRBk3KTYQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4D9961F000EC;
	Fri, 20 Nov 2026 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795188664;
	bh=Ic/Tkesv9swqUgqf5iFVky14aDs798pTEmP4wTv+sGw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=PFXWRAbDHnVeDhOsbJ/YOzYlq3EGhCPm/TXcy5PrFKNI1WIo6ziKoBF4MJwNLEqHg
	 c3X/sjGTAOe9pngXh9jDEWRv5zKGM7+2g7yFU6nZwWK6YCJqW6ICzbl1qmIf2VfNO5
	 axGxQTMeebuWN//Qia/eUC2bw+UmWzStUZrsoskQ2WfXxMrHQYyxbNi101j5dy3aYY
	 jNEINEDD6lHawMaYR2cO6SxU5Sn8qe658eiegQDQCT/HN0twJYhDjFoRt3soE2QGFy
	 QVVPluX5hYFY7YgeBXXxtVOFaQf/BqFEy3R+Q6Fsd6xWjCz4panHK4v3igR11yXHsi
	 P6O1vTk08HzvQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CD6AC49904;
	Fri, 20 Nov 2026 15:30:55 +0000 (UTC)
From: Zhendong Liu via B4 Relay <devnull+yzddmr6.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 23:30:53 +0800
Subject: [PATCH v2] dma: swiotlb: Allocate the restricted DMA pool slot
 array with kvzalloc()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-upstream2-swiotlb-rmem-kvzalloc-v2-1-cc5732dddb6b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKxnAGsC/42OzQ6DIBCEX6Xh3G0Vo4k99T0aD4CL0oIYQPpjf
 PeiJj03e5qdyTczE49OoSeXw0wcRuWVHZKgxwMRPRs6BNUmTWhGqzynGUyjDw6ZoeCfygbNwRk
 08IgfprUVICvBKyExq1lBEmV0KNVra7g1u/YTv6MIK3ZNcOYRuGOD6NfXr+C8Ga1hsANStFc+W
 Pfe1sZ8Rf4/LOaQTpSy5mVWUFpcO8OUPglrSLMsyxcnCgudCwEAAA==
X-Change-ID: 20261120-upstream2-swiotlb-rmem-kvzalloc-f6cb6cfe09a3
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Zhendong Liu <yzddmr6@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795188654; l=4063;
 i=yzddmr6@gmail.com; s=20261028; h=from:subject:message-id;
 bh=n5WsBNFSSTY++xySoe4Lh6qAZ7+HFLIrorjS4M0Xd3I=;
 b=qpNujyU5LVEecmTJsbr9Kv82yZ6BGA0fvstIKHTLBgxAXuO2n1vVfjnSaVCkcTzNapi2xhZoB
 Al43Wdsl6TdBBXvUugeeZ3oEFCh7YVWtS23i5e3Kcyo3VGK3DL4+EXO
X-Developer-Key: i=yzddmr6@gmail.com; a=ed25519;
 pk=QLT2mwairk4R38oU379hkHynqjoLrlqd0Cl1ERUqIqY=
X-Endpoint-Received: by B4 Relay for yzddmr6@gmail.com/20261028 with
 auth_id=1489
X-Original-From: Zhendong Liu <yzddmr6@gmail.com>
Reply-To: yzddmr6@gmail.com
Content-Transfer-Encoding: 7bit

From: Zhendong Liu <yzddmr6@gmail.com>

rmem_swiotlb_device_init() allocates one struct io_tlb_slot per 2 KiB
slot of a restricted DMA pool with kzalloc(). The struct is 24 bytes on
64-bit, so with 4 KiB pages and the default MAX_PAGE_ORDER of 10 the
array is larger than KMALLOC_MAX_SIZE (4 MiB) for any pool above about
341 MiB. For such a pool kzalloc() refuses the request with a
WARN_ON_ONCE() in ___kmalloc_large_node(), the pool is not set up, and
of_dma_set_restricted_buffer() warns that it failed to initialise the
pool. The devices assigned to it then lose the restriction without
their probe failing, and use the default DMA path.

The slot array is only accessed by the CPU and does not need to be
physically contiguous. Allocate it with kvzalloc_objs() and free it with
kvfree(). The other pools are not affected: the slot array of the
default pool comes from memblock, and the buffers of late and dynamic
pools are limited to MAX_PAGE_ORDER, which keeps their slot arrays
small.

Pools of this size are needed when large buffers go through the pool
for their whole lifetime: this was hit with an arm64 Gunyah protected
VM whose virtio-gpu resources stay mapped in the pool, and a desktop at
3392x2400 needed more than 341 MiB.

The problem was analysed and this change written with the help of an
AI coding assistant.

Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Zhendong Liu <yzddmr6@gmail.com>
---
Reproduced in QEMU on the base commit below (arm64 defconfig, 4 KiB
pages): virt machine with 2 GiB, a 512 MiB restricted-dma-pool added to
the DT and referenced by every virtio_mmio node, one virtio-rng device
with iommu_platform=on (modern virtio-mmio, so VIRTIO_F_ACCESS_PLATFORM
is negotiated), and swiotlb=track_hiwater. Without this patch the WARN in
___kmalloc_large_node() fires, every transport reports "failed to
initialise "restricted-dma-pool" memory node", no debugfs directory is
created for the pool, and reading /dev/hwrng works without any bounce
(io_tlb_used_hiwater of the default pool stays 0). With it there is no
warning, every transport is assigned the pool, and its debugfs
directory shows 262144 slots, with io_tlb_used_hiwater already at 17
once virtio-rng has probed. W=1 shows no new warnings in kernel/dma/.

The change is also used in the guest kernel of the Gunyah VMs
mentioned above.

I used an AI coding assistant for this work. It analysed the failure,
wrote this patch and changelog and set up the QEMU reproducer. I have
reviewed the change.
---
Changes in v2:
- Use my legal name in the From: and Signed-off-by: lines, as requested.
- Link to v1: https://patch.msgid.link/20261120-upstream2-swiotlb-rmem-kvzalloc-v1-1-1c5f9b503223@gmail.com
---
 kernel/dma/swiotlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 786954bc5e6a..51c7c064b62f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -2042,7 +2042,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 			return -ENOMEM;
 		pool = &mem->defpool;
 
-		pool->slots = kzalloc_objs(*pool->slots, nslabs);
+		pool->slots = kvzalloc_objs(*pool->slots, nslabs);
 		if (!pool->slots) {
 			kfree(mem);
 			return -ENOMEM;
@@ -2050,7 +2050,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 
 		pool->areas = kzalloc_objs(*pool->areas, nareas);
 		if (!pool->areas) {
-			kfree(pool->slots);
+			kvfree(pool->slots);
 			kfree(mem);
 			return -ENOMEM;
 		}
@@ -2067,7 +2067,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 			if (ret) {
 				dev_err(dev, "Failed to decrypt restricted DMA pool\n");
 				kfree(pool->areas);
-				kfree(pool->slots);
+				kvfree(pool->slots);
 				kfree(mem);
 				return ret;
 			}

---
base-commit: 14866e632fa48a0b4c385ab0121526575eb8f88c
change-id: 20261120-upstream2-swiotlb-rmem-kvzalloc-f6cb6cfe09a3

Best regards,
--  
Zhendong Liu <yzddmr6@gmail.com>



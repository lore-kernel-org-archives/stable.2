Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795180298;
	b=phTBGskDFR5fLW3F4G/muyrI7QNGhBl0aLVPW+IVwVRQUx7wZolVMWY9Fj9Mki0t9BIc
	 53R/EljT5N65/FXH0nTMobqWuuZS2RcFJSBJOiOr5TnZkiAvPM4uQXWsraKpwuhm/2Ddk
	 5F9I1xf9u7V24ZwU5yMQT6LTYXc4g7PX9RFRj7E9fPqqHPgvnaI2nUJASiuEWOt0j6rY9
	 y30eHEhQ4107BFjPk3hdZXjvdhObZndBk9T86YoFBvWe4draIlZ3tNo3F1MxSBRXfjCx6
	 yvgNV3sGImGmiAAu1GGyi18OOohUwvUgkuJkq/Bw+AB1dbjQqk/BnnuLvHiFzeYfCsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180298;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=r5sxciWCo7v2VAXzZQULk4EuonewNOnE8AqN/lZoMRU=;
	b=miXoTPcLVPipPmOvr1qj/EGg0olSCiUzvzQPidrKfHWnjHRdT5ALa0hHBZPOByGMbTLN
	 BSo86/op9NFOkY3eyHNdo5XZH2zSrOcxSvYUX24vXTDgQMSqfCVOIPNRqXr45biZ55Na6
	 o+cH9P+syzyqgIy6vjDrtu2pXHWRC9pknOF4bUS5hIced8lcsLbzFVF2m2qJn07rFIK1S
	 biEDLL3DtFSdPkzk2V98ETmrjqzUDwwDe/b8+ALErlCyTqS+yKr7wS4RVoymqdWtSQ9Z8
	 WWfRK57EyGTZfyCE0aGIhu+klDmeGfgP+dKmP+GG24JSJSablP+Vs2fdjzpNx3g4x2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCchoCdH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD160A6F6D;
	Fri, 20 Nov 2026 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCchoCdH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795180298;
	b=MTrvmyyNLWXIahLmReicF2gk1r6caBkUZdfvwBYYsOn7dJIY9HIDEfxQ6qaj3/rbzAAf
	 De1eZhI83hV8+Q5utBD/Q+7O/cCa4N2mRInaXNkurDBLzObK9hWoKEBSEmZ7KBgppwmF9
	 AO1sqquHU5xx8Xwn+vPMRvp1fHHQLa9nBKolm0JPLeuWVQrDJqeUxgwjOnZD50GDQZ+cx
	 zGdkTCPReFiubCM3zh0KrX4OoEleIN+16Avfbu21iOzmhKfHBQm1TJxWx2ZMFrA+qKVPn
	 uqYpe00fMpZtz+PfSb4o26RjkO9YapItRuTxCieq+in93/hgFfoQRc+1LF/9vY7E5Rg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180298;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=r5sxciWCo7v2VAXzZQULk4EuonewNOnE8AqN/lZoMRU=;
	b=YvvYfqfzDS8ukC2pnCuFrPNNXb0yuSdU+c/JrxhFfXrxCiPy4J6+nvWSO2HFd4Yxvyl3
	 c4likxGt/RoH8zXlxc/XFFTEQoq2GwpnH0dI1GeYqbzCiw5rJego8mfUb7haowsjUjfo5
	 jzTWoXcJ5eqqem76E+KyhGRIlJoZEPy26wnJZOGIOBZKWQIWZquIwaX2iTSR0UGnplVc+
	 Iw9+eiFouwkpIxwkQ+9W8qBprf5t34mHE+3wi3z5CyBBZjof+A/zA6ghY9HewSBtHb5ZU
	 ELJVhJej6/wYsEHXJTB0Zo9a0rspupVVhvD+lFnt3lit4xt12rz0ncMar/EbuN0OjbQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D67791F000D4;
	Fri, 20 Nov 2026 13:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180298;
	bh=r5sxciWCo7v2VAXzZQULk4EuonewNOnE8AqN/lZoMRU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=DCchoCdH+cA81E5Z1/i/2X7b/GqaU33H/+HCwiZ0o3Q1wwcUF8hMuAeQGYg6LUAFy
	 9ibmTNu45aNqq7Yv3cTjLsBNpORhsMgWfSMtE/fRI2ywK1qgzn7Ac9yWeLPZjCor/4
	 LsRBqL2h1FcZkbJ8/wYX3bA3Gl0pjc3vUWRfLXXYOd6UPUI7DBcp+iSqBIb+/w1OZJ
	 UoB2m2z573DViCfS8wcrpocGMWjEiqOHB+AxuhxuB+S5SQ8jxpZSKxE0Q7R3BzLbkH
	 ubL62lTc2+19MEHkRVjapmUzxu9dilH/XMpDAt8EPppKF3Eb8xu+Q3bfOxnXRjwjiO
	 OITo+tLLE+jXg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 677A4498A2;
	Fri, 20 Nov 2026 13:11:16 +0000 (UTC)
From: yzddMr6 via B4 Relay <devnull+yzddmr6.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 21:11:13 +0800
Subject: [PATCH] dma: swiotlb: Allocate the restricted DMA pool slot array
 with kvzalloc()
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
Message-Id: <20261120-upstream2-swiotlb-rmem-kvzalloc-v1-1-1c5f9b503223@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPBGAGsC/z2NwQ6CMBBEf4X07MZSkyb6K8bDtixSpYV0CxgJ/
 24Licc3M3mzCqboiMWtWkWk2bEbQob6VAnbYXgSuCazUFLpulYSppFTJPQKeHFD6g1ETx7e8xf
 7frDQamu0bUle8SKyZYzUus/+cH8czJN5kU1FWxYGmcBEDLYr0f/gvBeNRzgE2/YDw9xPX64AA
 AA=
X-Change-ID: 20261120-upstream2-swiotlb-rmem-kvzalloc-f6cb6cfe09a3
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 yzddMr6 <yzddmr6@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795180275; l=3849;
 i=yzddmr6@gmail.com; s=20261028; h=from:subject:message-id;
 bh=CPGhP9PgqwLV82rbpKPFM4Th44lDe4QRFF5asZn42MY=;
 b=Ow366SDm/ZOCDPPCbunnu6HYWImiPaNgVhqeHKHadkj4UG2OwV+IbW2/7CKSoXvr/sm2/5n7/
 U3bfDna9DUaAt7hbd45wHa8yrBoGwuijQD5CrTrXNcyUlbohgoKgUfW
X-Developer-Key: i=yzddmr6@gmail.com; a=ed25519;
 pk=QLT2mwairk4R38oU379hkHynqjoLrlqd0Cl1ERUqIqY=
X-Endpoint-Received: by B4 Relay for yzddmr6@gmail.com/20261028 with
 auth_id=1489
X-Original-From: yzddMr6 <yzddmr6@gmail.com>
Reply-To: yzddmr6@gmail.com
Content-Transfer-Encoding: 7bit

From: yzddMr6 <yzddmr6@gmail.com>

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
Signed-off-by: yzddMr6 <yzddmr6@gmail.com>
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
yzddMr6 <yzddmr6@gmail.com>



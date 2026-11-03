Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740276;
	b=HrkcGMNyc5F7BYQIclB93vyGXAXVyEAsy1Vu4AUsg6/1XGumfbNfVYmN0RPUAv10Go7C
	 L/0aw667v+S9rz2PM+fDPPDpoQnS6xxH/4EtHegpQXh5CVU1cPeHJtgHNM11XCdBeb/SP
	 e3bbR5josISTw1Pvr12VSaOLEc0TY6j9wFgUxs83TBZU7yHjHQ9ukvtjHQH3nvAqpI+pu
	 ebPqgUC/uUCin5swVtaKRL2XRbAu3L4G5nafyCvcFut8AGAcM784OUuhS5s/tSptGu5w+
	 VjCaB2VBI4mBN7HnFhVpBYJHtqdBGqbrSzGe+PPC+7TJGLVpXRjEGnJoCsDPSqqmWsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740276;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=eJJVuhl4n2+xTwsYuhQYz93TuoaKy2ORnidb9QdBqIg=;
	b=x+0P+PodHpzL1d2TXLqtTaLFzhJX9ZWHX7xuFrqJKJNPTo8wPBY0YzdRa9WW7qXx4GjU
	 IQmlvLABHuRPdYa7+y//Kzk5e8JnigIVOIE6LS8O1IPJmgq6Up6xbYn7vPRJVArWytzik
	 vzz8JU4JHt7kYXout3KJ3sSXANLG+n0+ApFZQz2yddSLN8fL2+9aPG7GMtn3uduCk3PFk
	 p0CkYk6wc4+14QhOyHrcsLJs58u1MFAlpvakVHbIglkb1JToiI7p32HGxmLXqOVBg9gqz
	 K1WbmBYBuOIPAXWIh/pe5QMBgn+RGAXHFbd15byD9/I6+OrfWektJx/9zE5NeaPp2PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=ajLJqRlM;
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E90606A338
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E90606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=ajLJqRlM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793740273; x=1793999473;
	bh=eJJVuhl4n2+xTwsYuhQYz93TuoaKy2ORnidb9QdBqIg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ajLJqRlMzQWPFv1FVIbHdsMCVI3czS7uTg4II/ArVNpeP4F5BwOp16HRLuyqZuqN9
	 IkD539Zo47bBCI04uuHw7Hi4AnT1e/H870Ocid4RMK58S6cmJD/pppOcdavnaZKlOY
	 9Q1wX31IyhTZs977oD81YBHOY812V5tHOOFTqv0FfWhDtjnnoKtb40kIUYozo/xvPb
	 puijTcM143gnt+HC+nnwDfNxkv1aRk2Qs1w707hhE5xdb63dfwuYSNnYqY2CZUL59c
	 jlboMkKy4tLhAAhXFggD7phRKKcixMrhBaopexITc8NRyzmnGTy4QZzUTpjUnuByNK
	 3HpVC8cpNdGng==
Date: Tue, 03 Nov 2026 21:11:07 +0000
To: Sakari Ailus <sakari.ailus@linux.intel.com>
From: Valerii Sokolov <valerii.sokolov@pm.me>
Cc: Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Antti Laakso <antti.laakso@linux.intel.com>, Sarang Sapre <sarang.sapre@intel.com>, Divyamani Tripathi <divyamani.tripathi@intel.com>, Manik Bajpai <manik.bajpai@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Valerii Sokolov <valerii.sokolov@pm.me>, stable@vger.kernel.org
Subject: [PATCH v2 08/11] media: intel/ipu6: return an error from ipu6_dma_map_sg() on failure
Message-ID: <20261103211031.1573726-9-valerii.sokolov@pm.me>
In-Reply-To: <20261103211031.1573726-1-valerii.sokolov@pm.me>
References: <20261103211031.1573726-1-valerii.sokolov@pm.me>
Feedback-ID: 17117034:user:proton
X-Pm-Message-ID: 118b9f70d4215e105e5af749043bcafe1eb3a6a1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ipu6_dma_map_sg() returns negative error codes (-EFAULT, -ENOMEM) on its
early failure paths, and ipu6_dma_map_sgtable() only treats negative
return values as errors. However, when ipu6_mmu_map() fails in the loop,
ipu6_dma_map_sg() returns 0 instead of the negative error code from
ipu6_mmu_map(). As a result, ipu6_dma_map_sgtable() sets sgt->nents to 0
and returns success, and callers such as ipu6_isys_buf_init() and
ipu6_map_fw_region() go on to hand the hardware an address that is not
mapped in the IPU MMU.

Return the negative error code from ipu6_mmu_map() when mapping fails in
ipu6_dma_map_sg().

Fixes: daabc5c64703 ("media: ipu6: not override the dma_ops of device in dr=
iver")
Cc: stable@vger.kernel.org
Signed-off-by: Valerii Sokolov <valerii.sokolov@pm.me>
---
Changes in v2:
- Return the negative error code from ipu6_dma_map_sg() instead of
  checking for 0 in ipu6_dma_map_sgtable() (Sakari Ailus).

 drivers/media/pci/intel/ipu6/ipu6-dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6-dma.c b/drivers/media/pci/in=
tel/ipu6/ipu6-dma.c
index a923a1e4bd..91c3c97838 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-dma.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-dma.c
@@ -392,7 +392,7 @@ int ipu6_dma_map_sg(struct ipu6_bus_device *sys, struct=
 scatterlist *sglist,
 =09struct iova *iova;
 =09size_t npages =3D 0;
 =09unsigned long iova_addr;
-=09int i;
+=09int i, ret;
=20
 =09for_each_sg(sglist, sg, nents, i) {
 =09=09if (sg->offset) {
@@ -422,7 +422,6 @@ int ipu6_dma_map_sg(struct ipu6_bus_device *sys, struct=
 scatterlist *sglist,
 =09iova_addr =3D iova->pfn_lo;
 =09for_each_sg(sglist, sg, nents, i) {
 =09=09phys_addr_t iova_pa;
-=09=09int ret;
=20
 =09=09iova_pa =3D PFN_PHYS(iova_addr);
 =09=09dev_dbg(dev, "mapping entry %d: iova %pap phy %pap size %d\n",
@@ -449,7 +448,7 @@ int ipu6_dma_map_sg(struct ipu6_bus_device *sys, struct=
 scatterlist *sglist,
 =09else
 =09=09__free_iova(&mmu->dmap->iovad, iova);
=20
-=09return 0;
+=09return ret;
 }
 EXPORT_SYMBOL_NS_GPL(ipu6_dma_map_sg, "INTEL_IPU6");
=20
--=20
2.56.0



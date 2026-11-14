Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794615267;
	b=NfKLInlfxkx6zbeSNZ6Lufq2mUc9CBROJprQx0mTx9v7WO9XqI/XumxQMWHce06a/SCF
	 1hXlbZy9nxb6RWh91oqF8q38IRrOBiNAVq5Qg3+jKvk+th8fHp6rMRNM1LYE2y/M/rPWH
	 G1RYEeOZTbJaK0e6qzod3zJZmZPwe+Y9AGtOmZf0xljYkO/zGdBA9se8CCeKZLzGdmjP1
	 8i5UeSfq8HS/0GKspD9hfHRQc25q+AlR6/gcRBlOYmR6e+jkYnEwX5/twbWmJWaGnYa0L
	 G2pIFIhGVUmMHYlHJOGujbVqnqLh+AvpNT1Yu8/tvDUtGym/ENcse8YHQ4gwSaP5acA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615267;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UXbTmWHNTfAA6e3l0mxbozyHsgmFBhFYAaPslzunooI=;
	b=a/odzVO/WvPJ9Cth+/ofaeRiyRNdXfG2VGpfYCmoeVJLuih1CkdS3M05Es0NLTUTfFdu
	 QTukwOndN4BtRmcjusStdgMk+2lpcWRAfU9laVIlg+PAFTS4d/IttWSsRqGM6QUmC/g8i
	 /xwT1lca46t9Nf+IbqfrlG7gLR9vWRGZnyhjhnXVj0JZVDinRODLeR0/UQ2/vxP7/SEMG
	 p5c2eQa9J1Letf7q0LlzabzrkPz5BwzuQ45lFKHc8N3qK7itgSTlun8LObxPJ3/scXC4e
	 YMU7aPZowvmB8gbzupEpCes+LuBDml6CCcDuq0K2F47uxMgOiKjB3at5D8vzcNhXsGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzxLNsl8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D760A262E;
	Sat, 14 Nov 2026 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzxLNsl8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794615266;
	b=rTVBjmOum7ourHzQcDvTJzNHQBe/dLGy8JONfNxk77Mri6DVcFK1KfnPJxh5eVUNa3JY
	 NpeyXpVc1mAK7sOJ7VnT0ovc63GGaR7jjJrQOjULNIUEtf7L9BWwr+Q+i7oqhAgUiTDTX
	 V7YFUC7F34xeyOlNO3XSorG/OZFm7v8OWVmFr+kh0oiels59DVWn8rFBsY+3nNwfsjfD9
	 AaNNKll1yosqaltmNz4LZ88v/80+ggasAnXCeHP1K+0eJLTCbvbJ8ouMjnpbDmhsLwi3p
	 eH7EkgWrOkKxs+AsgbQUJEPmqd8QrU+4E85sj6g27OrRB7HP1uiryshbHSE3DDiVacw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615266;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UXbTmWHNTfAA6e3l0mxbozyHsgmFBhFYAaPslzunooI=;
	b=F3MhIM5yN4dpFYcmqCswPVPi5YKV8o5TyvnNBBJn8JMXQg1f1PTiXiFwAYHCEnwI9NJm
	 KgdeuGwV5Y1riMj1niys7pIIQCMGtNyjqKEdLQWCZh0wHmw6FwDJJQZeelGlx7VRgI4ru
	 BNrLvxXlrzu+rucUdCx58YH8wUUk89ruE6tHSSUqpjKljo5fAa8S5gFrwjWUhzebJjLUk
	 hgiBormwDElZNlV6JS3bmSOkTyZakivtXZzQJV8vTz4QD9sEy3S4HY9OcLRs2cBH6av7T
	 6n7uVq4bg1bFQGJuLXVBzqZ83Qt0VftneTYrxO0qc7Idsp2Vl7fDIujMmSPgUjt5VZA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C09321F00923;
	Sat, 14 Nov 2026 00:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615266;
	bh=UXbTmWHNTfAA6e3l0mxbozyHsgmFBhFYAaPslzunooI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FzxLNsl8o7R4v1ypVkK4zAXza03tEFz6lhkzA401MixcvItJot0iFvDYzId4SYheL
	 QyUSRK8OySDZ4TjgcdHhokDTmkmGxQBun57gV4zVlQ8L8ogI/3+U9PsnVJv1vf2ewi
	 riiNSm01qskn6tmBK6vJAbZZQQNLE658NR/2SGEnc9azbQb6VsWuUvVKHu6wDqDB5g
	 /RPenTVbIqQhFWGp4Kom3x/IwLbtEO6nrfH4jaxW15cm//P+Zx7duEOQVzrUeuCXUl
	 RnZZe3RCyNx+A4C/ZcVdVSMYOL5t4p9p/W1LE4nYJya1JU0NCkBdBexTC0Btg7Dw6H
	 rEseIWYMh3h2A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 52CAC49BCF;
	Sat, 14 Nov 2026 00:14:25 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 00:14:25 +0000
Subject: [PATCH 1/3] iommu/vsi: Don't use the identity domain as a paging
 domain
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
Message-Id: <20261114-iommu-vsi-fixes-v1-1-1fc7728dfd35@gmail.com>
References: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>
In-Reply-To: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794615264; l=3745;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=sUt1OgHP0kX/1e6KhlOzrX0uX6XICHM9fBwJZI98X+k=;
 b=uwaCK8K9u9ZhwRI7dzRczNhhRHpb3x40sz/aIThFPBAhP/hv/DTgCm1MNIOdBdTUcUnvkUANP
 si7JTA8ZdmTCN9E4fybO5+Ib64C9bgY0t7FkHdotG7PRbOxD9tdRooc
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

vsi_identity_domain is a bare struct iommu_domain, but identity attach
and resume pass it to to_vsi_domain() and take the lock of that
vsi_iommu_domain, which is memory past the static domain. Identity
attach also unlinks the IOMMU from its old domain's list without that
domain's lock.

Take the old paging domain's lock to unlink the IOMMU, and only the
IOMMU lock otherwise. Resume touches neither the page tables nor the
domain's list, so it needs only the IOMMU lock.

Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261113-vsi-iommu-pm-ref-v1-0-fd917eebdf18@gmail.com?part=1
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/vsi-iommu.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
index 3dec58224953..5156e8a2e7fc 100644
--- a/drivers/iommu/vsi-iommu.c
+++ b/drivers/iommu/vsi-iommu.c
@@ -497,31 +497,42 @@ static void vsi_iommu_disable(struct vsi_iommu *iommu)
 	iommu->enable = false;
 }
 
+/* Take the IOMMU off the list of its paging domain, if it has one. */
+static void vsi_iommu_list_del(struct vsi_iommu *iommu)
+{
+	struct vsi_iommu_domain *vsi_domain;
+	unsigned long flags;
+
+	if (!iommu->domain || iommu->domain == &vsi_identity_domain)
+		return;
+
+	vsi_domain = to_vsi_domain(iommu->domain);
+	spin_lock_irqsave(&vsi_domain->lock, flags);
+	list_del_init(&iommu->node);
+	spin_unlock_irqrestore(&vsi_domain->lock, flags);
+}
+
 static int vsi_iommu_identity_attach(struct iommu_domain *domain,
 				     struct device *dev, struct iommu_domain *old)
 {
 	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
-	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
 	unsigned long flags;
 	int ret;
 
+	if (iommu->domain == domain)
+		return 0;
+
 	ret = pm_runtime_resume_and_get(iommu->dev);
 	if (ret < 0)
 		return ret;
 
-	spin_lock_irqsave(&vsi_domain->lock, flags);
-	spin_lock(&iommu->lock);
-	if (iommu->domain == domain)
-		goto unlock;
+	vsi_iommu_list_del(iommu);
 
+	spin_lock_irqsave(&iommu->lock, flags);
 	vsi_iommu_disable(iommu);
-	list_del_init(&iommu->node);
-
 	iommu->domain = domain;
+	spin_unlock_irqrestore(&iommu->lock, flags);
 
-unlock:
-	spin_unlock(&iommu->lock);
-	spin_unlock_irqrestore(&vsi_domain->lock, flags);
 	pm_runtime_put_autosuspend(iommu->dev);
 	return 0;
 }
@@ -537,11 +548,12 @@ static struct iommu_domain vsi_identity_domain = {
 
 static void vsi_iommu_enable(struct vsi_iommu *iommu, struct iommu_domain *domain)
 {
-	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
+	struct vsi_iommu_domain *vsi_domain;
 
 	if (domain == &vsi_identity_domain)
 		return;
 
+	vsi_domain = to_vsi_domain(domain);
 	writel(vsi_domain->pta_dma, iommu->regs + VSI_MMU_AHB_TLB_ARRAY_BASE_L_BASE);
 	writel(VSI_MMU_OUT_OF_BOUND, iommu->regs + VSI_MMU_CONFIG1_BASE);
 	writel(VSI_MMU_BIT_ENABLE, iommu->regs + VSI_MMU_AHB_EXCEPTION_BASE);
@@ -758,15 +770,10 @@ static int __maybe_unused vsi_iommu_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (iommu->domain) {
-		struct vsi_iommu_domain *vsi_domain = to_vsi_domain(iommu->domain);
-
-		spin_lock_irqsave(&vsi_domain->lock, flags);
-		spin_lock(&iommu->lock);
+	spin_lock_irqsave(&iommu->lock, flags);
+	if (iommu->domain)
 		vsi_iommu_enable(iommu, iommu->domain);
-		spin_unlock(&iommu->lock);
-		spin_unlock_irqrestore(&vsi_domain->lock, flags);
-	}
+	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return 0;
 }

-- 
2.55.0



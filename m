Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794615266;
	b=OmCpHLDeBYHoMv/GjXLyTUU5XONAh3HbXjsOkP/qCIon+cVi0hA2U09b39fs877qWixm
	 vguGnoG4xJ9hG43OS6UweHVhvaNG8Lku0bTyZEdFjX4SN280B5MJSi9ooM3U1A2yFvkfi
	 4+RI3qSCcW3sBNIJqR6l4OK0p697Gdlxx8JWIShKaUHz6/PAWZ85eqVS0ovJmiW8fokL3
	 Hzxh8ozD6+tgi7gbjV2knJepjmwfjyKzueNG/RHqD4T8If1HG2ep26zXmKdip5tdZbjyb
	 RG0T47V0j0jpyv7TlKNpvi3Oz6CBgtyD9qklENLZwkLv903zj0LrJ8KhgrTRRvPAHow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615266;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=EEE9bB9K2DCW7KL6LHJFbhKe8RM9wDKWB9b7e5VdtGE=;
	b=tQz9LYY9TOB7tGZmgd/PxPldYlE1jMCUi3ExOga6BG9Z8ay+uufnvAl8zpRqqSbGqTXQ
	 RmuncSFI0oNvrFNhyQ8PrU1JxpVSlLqjTXpucXu1JBK0EM0oWZph6E8qeBYNjlRibwWRv
	 r8kUEoRKUYCq+vn7+uUuI7+JFzaf+RP42YeRdqod8s7uqpmGiiGHnA9tdvbBFSrzWrPCs
	 MEbTouu6eLrPi/CIT6JEhgs5JfZuV1iWFF+4p3SLhPNpKnvnZ1ExPEr0DopNOkpB230eV
	 OJCObedqUBg9jp0APxSWyy+um4XIPmHyA1B/SwSAnCCR5BSbKQGpURCMQaJKE4hE7oA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDnH0AuX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EAD606A88B;
	Sat, 14 Nov 2026 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDnH0AuX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794615266;
	b=eJupdazqZg7PEQMZvH1e2+alfYb50Lb7tMVrII3+Mtx5D+9qk3ek5OYEXt/8duWA392Z
	 Ag/yI6TGqbhy0P7B4GIpD292+KKG3n1NIElg24gdg3eY5sxIyPhyiGBRpwC/5nAlKc2Eq
	 kiyJjoi9UG4+k3xn3FO3s2WrHRfZVVx2yfxsprpC7fHWHOtNBrqDN9VfmZlugRsJDZdZN
	 tpaVY972baokjpq5NJpNMDeRNeniYb1Id2wNrtuoHgKd+BuJX0VBDuraY9qml2X4Gh0dZ
	 +YTCdhjf1Bj6SwkAjFcxtxbntFgR9wJNyHr5t9SXgkRk5ZAeLmTvf5UcMFr0ueaJ61w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615266;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=EEE9bB9K2DCW7KL6LHJFbhKe8RM9wDKWB9b7e5VdtGE=;
	b=S0Tj8CZ9czghulqnNSRor4THl+bqqncu0T8LIvmRAzEMuO9hnAXo0be59FnMYdhCIoef
	 Sp6PjSwbRp9ucEQ7A0bxJiJqzK7HRYp9s6MylIbEQmYYJ0XtjoseF+WBZHIIFj075YN7S
	 YyT2J5/60ybmY/b81FCWo/U2wxRByLftjFkaBudQNWDKe+Zb2pZYpex9AMG9Ow5Vl2OMH
	 WGydXtPIiTCfUwhi0/6AeFzghXZXBpDPjJEyvIf1rVPa6uRcWauarPN09XbtDfOqVOZqD
	 2iD99Fk2QQwzyZOWhyzYbC0jOevx9UBL15P5XIv/XFwNYRFIhOnj3OGpUWebsrk9NTQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D5EDB1F00925;
	Sat, 14 Nov 2026 00:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615266;
	bh=EEE9bB9K2DCW7KL6LHJFbhKe8RM9wDKWB9b7e5VdtGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bDnH0AuXlEnl5buZlaBnI7xzDt655yteUAMEx0QuE1uPNArbRtKTSMhqmZtDjDohW
	 7itZ3Cw7Ueg4wB0wi+fZcEoUChLd3N/cmbMCyKM8gZtLl1ZIOF22H+GzsG6pM/ulR+
	 L4+6d0/bhA+DA0fZJa8sOyxrq8K8thVwdfldJ6urrre6mF3Gpktsou5EPIgORq8egm
	 4xabw4xyA654c7xsCa3wvyCzTFx/VuqmobGU9s5Vjm7uCzOZHYEyyMjPdQ0mTqvqHg
	 MEe8QTish0s+fWvcY8AOPYNOteLZVsGEKhAHi92943iFohkhWdgixzLJBjPITXdFm5
	 OyC8Rq56yOO+g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6816E49BCB;
	Sat, 14 Nov 2026 00:14:25 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 00:14:26 +0000
Subject: [PATCH 2/3] iommu/vsi: Unlink the IOMMU from its old domain under
 that domain's lock
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
Message-Id: <20261114-iommu-vsi-fixes-v1-2-1fc7728dfd35@gmail.com>
References: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>
In-Reply-To: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794615264; l=1234;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=kspvKLgpotcfNu/d6d7HQui+izuIuODftxK9VojqQOs=;
 b=CmLw+MPs+6LaMoyRA5j4mUiHfYHHT2bNWj/ceD2ckX33Nt/dSBE3K89W2t2yW4zHy7jVTscFc
 Y2i5pFmAXoTCdmX80mSiR2pwibESzDrwUv/DKCgWQED+De3WSdFo6Tc
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Attaching a paging domain moves iommu->node to the new domain's list
holding only the new domain's lock. A concurrent map or unmap on the old
domain walks the old list in vsi_iommu_flush_tlb() and can follow the
moved node into the new list.

Unlink the IOMMU under the old domain's lock first.

Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-206639@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/vsi-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
index 5156e8a2e7fc..8a0f253f2017 100644
--- a/drivers/iommu/vsi-iommu.c
+++ b/drivers/iommu/vsi-iommu.c
@@ -575,12 +575,13 @@ static int vsi_iommu_attach_device(struct iommu_domain *domain,
 	if (ret < 0)
 		return ret;
 
+	vsi_iommu_list_del(iommu);
+
 	spin_lock_irqsave(&vsi_domain->lock, flags);
 	spin_lock(&iommu->lock);
 
 	vsi_iommu_enable(iommu, domain);
 
-	list_del_init(&iommu->node);
 	list_add_tail(&iommu->node, &vsi_domain->iommus);
 
 	iommu->domain = domain;

-- 
2.55.0



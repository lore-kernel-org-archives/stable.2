Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.143.211.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596107;
	b=SGY7wpz1HGE9xwq/6HNcgk/sqA737vNbP5l4BPdYGbf0qjIbLoWZgS23iMGwglGoQYVe
	 dOW4fbdKrg8a6X7dk6dJyEQ7a2VvsjkCoAENYSdaA2J9z90i3Fs0AxKI1+YakpIBe20o6
	 5FCNhEbTpbhlYe/mCSqYtIRibzLEFNTmwr8S+pD9A7bI08vKmHV1AZ3IJsoOQ9j45lVI4
	 WqXhFqWhnfy06+kLkatwJR/vCmQxMJQj9XSRZd/dbjDm+a0ShKqpE7z8IIjqj3F71lJIl
	 zYhrGt0AZLrBA74l00fDz+9x18GbHXM5ybr/PTP2z1BfbgNbGxvNlqZW2oOO4GJvxLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596107;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HRW9Qk9qeAqYq2NS8NaScJ7tOzreTijlDxilGYfObys=;
	b=vlxHEXB5tXYfHHagvPUd9lPyx7IKUKVwwu0u4awbL+6Z5l+Fy92/kPJqpjMJE7vUSP78
	 wMbGfzNmHm+3q/zxzOkKbA4MXNxyHR3PfI/UvMru+fjlUCSR+is4oaEdHwtwI2w6jTUrU
	 2jN1lmigzCoAAK1MOl+nJY4dUJlm69YQVHbjgUu0ySeX6MNMSL8eDM8Y42zh6acW7EEns
	 VNL6MCJ6TDDrFx6jA7Qt7MbHJZ2KOjS0VLmWnWzDymIRPj3QbD/lV9vYRaPPZq3S47dzv
	 xOwScb1jT9lVOtxIb4iAFaSCoe4MjIeOwuMvC29fAQ3rgsRZI1hKtQ9wL4qdk+HCAaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=swemel.ru;
	spf=pass smtp.mailfrom=swemel.ru;
	dkim=pass header.d=swemel.ru header.i=@swemel.ru header.a=rsa-sha256 header.s=mail header.b=IPMPygw2;
	arc=none smtp.remote-ip=95.143.211.150
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3A606A321;
	Wed, 25 Nov 2026 08:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5D3A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=swemel.ru header.i=@swemel.ru header.a=rsa-sha256 header.s=mail header.b=IPMPygw2
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1795596102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HRW9Qk9qeAqYq2NS8NaScJ7tOzreTijlDxilGYfObys=;
	b=IPMPygw204mopTIfa7oyuBfgNsnKSSGoOYdkR18n0pIBeor2ZugxtqSGZQGNtMQ/XZstYg
	6Q1emS53AYOfm47gXb0w8ZVX1Y+EH//Dwj04IDiqZp5YTNnZY8SU9BzG2NqZ6dr+yhApjX
	zzOQ4DITCQf9M/kpw9ww6kASUiMLR7g=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.10] iommu/amd: Check return value of mmu_notifier_register()
Date: Wed, 25 Nov 2026 11:41:40 +0300
Message-ID: <20261125084142.30679-1-arefev@swemel.ru>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Arefev <arefev@swemel.ru>

commit b09b56734fae28be9332021ae3e84c9b05020fda upstream.

Added a return value check for the function
mmu_notifier_register().

Return value of a function 'mmu_notifier_register'
called at iommu_v2.c:642 is not checked,
 but it is usually checked for this function

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
Link: https://lore.kernel.org/r/20221118104252.122809-1-arefev@swemel.ru
[joro: Fix commit message ]
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/iommu/amd/iommu_v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 16776e3c6eab..8704c2c89556 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -640,7 +640,9 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	if (pasid_state->mm == NULL)
 		goto out_free;
 
-	mmu_notifier_register(&pasid_state->mn, mm);
+	ret = mmu_notifier_register(&pasid_state->mn, mm);
+	if (ret)
+		goto out_free;
 
 	ret = set_pasid_state(dev_state, pasid_state, pasid);
 	if (ret)
-- 
2.43.0


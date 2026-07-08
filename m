Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7321292B54
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504171; cv=none; b=J+uk7ua1vr95/REQ/hpeyNZpMQJ7v8M9BfF3kMVm/aaqRZXJZajA/zFpQfbA/ArfvSKnaPBH2BlxONO9s5UPzkkRF7+rUqe1sE5Ej1V9JBCJfDj2DYxXkWqXniqEZi4bNWPICsGaSfB1hNiiwnYzeCtcCYz1tyOwCHDrG35qjIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504171; c=relaxed/simple;
	bh=kuFxI6zCr4dVGnzCYou53VWrkVBAA208Iv+yWiSAhc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wzj4aj6012aBLe6zz5LZategY1qX8mvni+wbHEsJ1KeoYz1G2A4sCSxbimrhDYic/GxRwBqWTEb5Tg4dPj307ot9q5EyL88/LHkTWR8STRgGdfdoIl8KQe6FryZT/etb069mOZFlatRF9P78t03vsPdmddRAlE8D9Qla2WVJMZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PKV7H0qD; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PKV7H0qD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783504131;
	bh=/ddKzM3gMm80IOv2mlqZS7PwC2cFb2QASKOWts7w2TI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=PKV7H0qDZRllCF2EhOE7/L7cyTiXaaQ1TxeA8dEcKqvrnBabSMdnWNzMwiprDRL1m
	 W5XTo24Lp51wZRZaNE7gc1q3eVO/uWneJQjxNG3u8LXyqO0/6JqZ5mb613rtazMneV
	 NNhMumET6xaSzDUIvzklwMGS/4slDCgwUl/S7aNw=
X-QQ-mid: zesmtpgz3t1783504112td99ea5de
X-QQ-Originating-IP: Yx/VzgTY33xSfla6hLCeVqqRMqX3fielqx8gwo+la2o=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jul 2026 17:48:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4816621095025621651
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 04/11] bonding: add ESP offload features when slaves support
Date: Wed,  8 Jul 2026 17:47:08 +0800
Message-Id: <20260708094710.27047-5-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260708094710.27047-1-guanwentao@uniontech.com>
References: <20260708094710.27047-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MdW1uYX7ZYF9ZaFC4EFdwcmYMjGOu/G9pykAOJxn/SepUOAsYO9i5NuR
	axFeLZA1HBc6mAyYKHe+6bs/HBPDXVVy3JzPmoh8pQmsFVT1u16fJclKkfF1rXOrina0yMe
	Gy7Gr9S1ZSN42sfKjMY0AScmHm4t0ozKhsCFsP358ipD5sz/uGdc2gHs58S1QeoNsKh3gR3
	c2w+HGy+dq6k8zFcRzHboJN2qk8xMRcB61b144f/GAWLxLxkw9oUmdTfFZMMwcgkaaQyuzd
	SSEEEhNEvKfDz5ksnRYFARhq3y/+mqPNtvryzeB5hwhxWGNP3zjeYOGK+c1LicQfzu2bEpQ
	KBhp3HnVMxvqPbr4QX37sSzRnOBfRiTtJOAZjzLoVaFVg61tDFN+GwTTHUxR5/NA6DRMWEp
	ASWBlrNSbPS6ZN/+8y9Q6Nfrf3X2eETFW/+/NCmHcDNPkSyRVTfKL3dA2pNNmFMEstdSldp
	JTbJ6tCEtgxI7MDOcjZPrA/TW1hEST8xRXS9YSrC8RqXiMzlqJtG277H/6zdQqYgsAOFVBq
	1+SJksh1S0PIiaEbA8JYIImtPJ2VfqCyMOrBG6gLzrTdf4LlWTC9V0Lu2GngyNOE7j71Q+M
	oCsbH28x6W1esECO8XKz5OyfVT4qFMT4wY4MmmPQ+pl/xB8tR2WJj0M7K2mjbRf3e7jJ6T3
	AJYuI3CMY3SszC30hCF9doaCz7FrPGelrxD1V9O6nNeR/b4A9FF6PJvSC1u2ZewRx8mNiLR
	u3cfISU5LSviudjlcnE2Q8pXar8nuPD+bcZlpCj8+7sU9dI9zFUcs2ULp3anvhhgtQekpsh
	S64V+PDOHH+roufMVvwpPTfUk42TSD/XShOml9Rf710ums3bSyJNr3xb6vP2CA+zJgjRQXe
	gkhokcjY0CtSlJzaye53qR60m0DM8StJTteDHmyp/ctxDAwUM4Pg+5uQGSBjDJ99t+eeLqj
	pBfE8KeYFhlBAgBuf6/kQ3DrqOsWJBNVPLEvhdEy8hZco4AlL6Anhxt6fTGlfS6zyQBjb4B
	oil8bFHavMvhaGjL7bnjuka2CV4QLTMv5uWzE4iLBxqDkxDr/UJBlclDJPg7odTtOVWAXJS
	yCAUkdzrC+IOy8nlUOi+59+dGp1zbsoJRhyFW0qgV1bvSHHZaj+cU/5uGAUToy37LGUNY6E
	WaAd
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit 4861333b42178fa3d8fd1bb4e2cfb2fedc968dba ]

Add NETIF_F_GSO_ESP bit to bond's gso_partial_features if all slaves
support it, such that ESP segmentation is handled by hardware if possible.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20241105192721.584822-1-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slave()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 999fed0236754ea6efbaa1b5304373e7761c8322)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/net/bonding/bond_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index d200909a75cfe..ec21958babe7d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1484,6 +1484,7 @@ static void bond_compute_features(struct bonding *bond)
 {
 	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
 					IFF_XMIT_DST_RELEASE_PERM;
+	netdev_features_t gso_partial_features = NETIF_F_GSO_ESP;
 	netdev_features_t vlan_features = BOND_VLAN_FEATURES;
 	netdev_features_t enc_features  = BOND_ENC_FEATURES;
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -1517,6 +1518,9 @@ static void bond_compute_features(struct bonding *bond)
 							  BOND_XFRM_FEATURES);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
+		if (slave->dev->hw_enc_features & NETIF_F_GSO_PARTIAL)
+			gso_partial_features &= slave->dev->gso_partial_features;
+
 		mpls_features = netdev_increment_features(mpls_features,
 							  slave->dev->mpls_features,
 							  BOND_MPLS_FEATURES);
@@ -1530,6 +1534,11 @@ static void bond_compute_features(struct bonding *bond)
 	}
 	bond_dev->hard_header_len = max_hard_header_len;
 
+	if (gso_partial_features & NETIF_F_GSO_ESP)
+		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
+	else
+		bond_dev->gso_partial_features &= ~NETIF_F_GSO_ESP;
+
 done:
 	bond_dev->vlan_features = vlan_features;
 	bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
-- 
2.30.2


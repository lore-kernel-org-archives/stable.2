Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDA9233923
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373101; cv=none; b=fehlAui8+7LXKAPQwD518RM6J9SLk8C5RVp2hxkPpLT03sh/Y0ct4MEWpwZ1oSxMPSU1dY4wz9iPuqsAai/hPqSk2adRSXwwCc7Y9SjFPHSlIk/uwJpD/cSuMBTDDz2ZOboG0viAYorm45RKRU5ei4HhQLyaGY8ZCL2NF1BrR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373101; c=relaxed/simple;
	bh=/BYm0lerb+HqYMLYK1un+S+JJa6M/QzGMNjvsJlO9hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNvUe3GgsJtPc+Zl283DQ3Ub0y6EgR+o1iAauEtcgyczJegDZdOBvdgnrvPNt+OQkl3VWul674ePO8Hhjzwtqvi8BQCzgtDfEWAke53XMmfaSpsPyZ0wpAPl9l4g1WisLLSCke4klgfvHdNsdtbYrxeHJ4d2Vo8TK+QelEJji4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFzFR9Sg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFzFR9Sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC371F00A3A;
	Thu, 30 Jul 2026 00:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373099;
	bh=6S6n12kZ+MYcwZe+jX9wexhl8p+aVeK+NeOpYS3rBQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VFzFR9SgR7bGanGBMfcdMJ95vAfj3m4Hx02yFd42mhtMre2THXugjijAFfYfkF1Mw
	 17BDIVqs2sU26WuWtEbNL1/wrTjy0+1kUOyYF1hr3280YV/GVnXr5lTGmLbyFvZ/Ca
	 coPEVxUFBYjAi5D99vXbzycP0mo6dggDXi1Su0gEA26o2P9U6dt7+M+xmxdOVRGFSs
	 qH9gaRBhYJ8PSX3RTTnAgCJQcsIDiYmWuoy60/AR8p685KmKFxpi8J8qwkmdtsm3td
	 jVbKSdQ/9O3yYgvupCcKdrNBlq/PTlN6TvgZOkEcp7ZsvOPnn/edkcZCX2Q2eLDgua
	 dut8Nv5ctB/UA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] Bluetooth: hci_core: Fix not accounting for BIS/CIS/PA links separately
Date: Wed, 29 Jul 2026 20:58:17 -0400
Message-ID: <20260730005817.1696365-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730005817.1696365-1-sashal@kernel.org>
References: <2026072158-wired-pamperer-25c0@gregkh>
 <20260730005817.1696365-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 9d4b01a0bf8d2163ae129c9c537cb0753ad5a2aa ]

This fixes the likes of hci_conn_num(CIS_LINK) returning the total of
ISO connection which includes BIS_LINK as well, so this splits the
iso_num into each link type and introduces hci_iso_num that can be used
in places where the total number of ISO connection still needs to be
used.

Fixes: 23205562ffc8 ("Bluetooth: separate CIS_LINK and BIS_LINK link types")
Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f660cab086e65f..34c4db7bee8c92 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -128,7 +128,9 @@ struct hci_conn_hash {
 	struct list_head list;
 	unsigned int     acl_num;
 	unsigned int     sco_num;
-	unsigned int     iso_num;
+	unsigned int     cis_num;
+	unsigned int     bis_num;
+	unsigned int     pa_num;
 	unsigned int     le_num;
 	unsigned int     le_num_peripheral;
 };
@@ -1000,9 +1002,13 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 		h->sco_num++;
 		break;
 	case CIS_LINK:
+		h->cis_num++;
+		break;
 	case BIS_LINK:
+		h->bis_num++;
+		break;
 	case PA_LINK:
-		h->iso_num++;
+		h->pa_num++;
 		break;
 	}
 }
@@ -1028,9 +1034,13 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 		h->sco_num--;
 		break;
 	case CIS_LINK:
+		h->cis_num--;
+		break;
 	case BIS_LINK:
+		h->bis_num--;
+		break;
 	case PA_LINK:
-		h->iso_num--;
+		h->pa_num--;
 		break;
 	}
 }
@@ -1047,9 +1057,11 @@ static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 	case ESCO_LINK:
 		return h->sco_num;
 	case CIS_LINK:
+		return h->cis_num;
 	case BIS_LINK:
+		return h->bis_num;
 	case PA_LINK:
-		return h->iso_num;
+		return h->pa_num;
 	default:
 		return 0;
 	}
@@ -1059,7 +1071,15 @@ static inline unsigned int hci_conn_count(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *c = &hdev->conn_hash;
 
-	return c->acl_num + c->sco_num + c->le_num + c->iso_num;
+	return c->acl_num + c->sco_num + c->le_num + c->cis_num + c->bis_num +
+		c->pa_num;
+}
+
+static inline unsigned int hci_iso_count(struct hci_dev *hdev)
+{
+	struct hci_conn_hash *c = &hdev->conn_hash;
+
+	return c->cis_num + c->bis_num;
 }
 
 static inline bool hci_conn_valid(struct hci_dev *hdev, struct hci_conn *conn)
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399C5388E74
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980496; cv=none; b=Fv/hUX8oPh+2Ss1QMKv0tpyq1O7DsyMRw7naNyJ+g3bjBevXb0FOZ5xBN5DDb3A3ysjbNw5kQ/ZriAjsJB1aFALDWNV25mFe1E1NVmbkxogGBemcA0WqQWIjNWxK1/qmkb2pNk60I+n3klK1OhF+uD2Puxn8kfWGNr3U6mhS8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980496; c=relaxed/simple;
	bh=Vi7iwyKBXA34eJQ+9jWT9HstejOvbYh3ThGLo04Razo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLYDRcWVCevzkR0iQjRS+NpEMMsDnRCFXNhzZ8AtM8ntSuItfIj1jUHh5ZO336LZipubuAbc+b43NziP/wwPZKTVFtLG3hQcI+h54LmLdWZfGIMedT4tWMRX6VNu3XLdeRz0cdJHS8OrqSatGSysCo690Q4DfnkIqBYne4uPtn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRsvKIZs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRsvKIZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5492B1F0089A;
	Wed,  9 Sep 2026 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980494;
	bh=HfEGZYcPgYUapqtWuRHUXanaBHZuJBBEHz0zSzHfdrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GRsvKIZszCW5Qkjg0wA4EqUiDIUPmE0VRR5RMAxu5pf45rG2ZqIof6JeCU5Txb7Vr
	 5GcpB3x8iZfxXKz5ZWO0pkxkzCga4cn5okfU05CBwLNFddVfqoRDhDGb52UkCUgbSH
	 i8A1o0cebWh4L+QO27zjPYZI/Zo58SPoM3/3XhRlIuHOnqd4vmCusqgeAMWyj7ZPON
	 0ZxryvC/KsuHyPKmBzPY3bOO0Viu7Td/iIH1BBHU1XANmc2kJItdumtkAnWjb61Dbp
	 02Ozsg/4sNpteAid1tYxCFxTkj6JdSjuZdzZuiC+3CaC2jmWKVEhDBAg9ZJZBTQ08m
	 GNf+ptAzDd/TA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] PCI/AER: Simplify add_error_device()
Date: Wed,  9 Sep 2026 15:01:28 -0400
Message-ID: <20260909190129.3511451-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190129.3511451-1-sashal@kernel.org>
References: <2026090327-figurine-worst-aeee@gregkh>
 <20260909190129.3511451-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit d72bae423004aa7b4d94c34a7fd0b48b64305a08 ]

Return -ENOSPC error early so the usual path through add_error_device() is
the straightline code.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://patch.msgid.link/20250522232339.1525671-18-helgaas@kernel.org
Stable-dep-of: a8bf2dd750de ("PCI/AER: Emit TLP Log only for unmasked errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c054ba827d11c..6865ece1e2270 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -818,12 +818,15 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
  */
 static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 {
-	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
-		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
-		e_info->error_dev_num++;
-		return 0;
-	}
-	return -ENOSPC;
+	int i = e_info->error_dev_num;
+
+	if (i >= AER_MAX_MULTI_ERR_DEVICES)
+		return -ENOSPC;
+
+	e_info->dev[i] = pci_dev_get(dev);
+	e_info->error_dev_num++;
+
+	return 0;
 }
 
 /**
-- 
2.53.0


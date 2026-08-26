Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AF472789
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767436; cv=none; b=ALvxxBUJlvoc2anNuxc5tncqHn1hSC2V98s0PDxkb8QxCcKCNycgBNfvhdA2zz5mp0dH7WKLeATg1HzyCjjVOZ8JiBJbQrHWJWdtxIb1dV3azo/AdQ8S3/cs4DNIRff/eaJ3IeT2kYo2Qn0brygX1Zj7UvFPs3y0+y/Rh+RaUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767436; c=relaxed/simple;
	bh=lytV5lHnp+g/FNf7OgPR9/5XBQY/Q/WrQmrWpjJ4m2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8BQPtCSyuiSNWSGDIQ9gJIWX9B1NK068VmStc8ZTJL1nMymGUbboSUFi3XJavwclgW7kzJqMht3uWt7fRKY4Xe57a2I0pg67sudDezqdEtjV9gQDxp8KNr+2P8XQQJmUbOiQJo5hCl+W76UZ2X/ExNTKKoEWkd/fKnZhJkUESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUWexdtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUWexdtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027C81F00A3A;
	Wed, 26 Aug 2026 18:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787767427;
	bh=zHCQsP3PrMfZGR5EiytNYQdzHDUouXFjIU0GuezrF4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gUWexdtkucR6ThNuf5eAnpGTxSLdihmmVav3BVHeYjHK+UzGrnF0tF4+qW614MgHc
	 8KiTLc5nfY2imdwjdxeZNxmoDC0L/1LUYWk7jaCSbtkRVZpkkD5QXUqKYEtbjPTF1j
	 6A9WoAn5XyruoYkHMm8blsH+PWLxRXEzvJXIvReuJt61VR7+ntPtygAiF+7jBA67v4
	 qePvMUvOybxq7W0IEeae2F4f6DORF9aY6kAH5kPwlx/hhTROAjZDaGGaAwySYNZCl3
	 V5TFgCfjnPvp1cWpcl1TjkTFmm6WOLSQ3Tbts4U1SjRLr2KvYEj4RhMtWc4FgMYm78
	 +r0Wdc6Q90hpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] Bluetooth: hci_sync: Use bt_dev_err() to log error message in hci_update_event_filter_sync()
Date: Wed, 26 Aug 2026 14:03:44 -0400
Message-ID: <20260826180345.2651531-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082511-scouting-bunt-8bff@gregkh>
References: <2026082511-scouting-bunt-8bff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

[ Upstream commit da0186f19a7433d3d5607b0f61e9a3de17d1f721 ]

Use bt_dev_err() instead of bt_dev_dbg() to log error message in
hci_update_event_filter_sync().

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: f57b399c4fa1 ("Bluetooth: hci_sync: Fix accept list UAF during suspend")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6a5ec74eaf25a..4139dfdc758c7 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6168,7 +6168,7 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
 						 &b->bdaddr,
 						 HCI_CONN_SETUP_AUTO_ON);
 		if (err)
-			bt_dev_dbg(hdev, "Failed to set event filter for %pMR",
+			bt_dev_err(hdev, "Failed to set event filter for %pMR",
 				   &b->bdaddr);
 		else
 			scan = SCAN_PAGE;
-- 
2.53.0


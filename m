Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505845;
	b=qMV8jqySwCVvmh1U+RBYitVpiroN/kjGLpRFCneLbJwSlNrq6NqYylDw9pq4iYb5hMsY
	 AZx6v5CNkAk7UrP1tAeE14NOn3NOqa8WYaaakKdW0KDWcIRZcj4bf+CaTo2GUXGFvgQ5A
	 QYlAolv1m/LFSnVhKvN3qlpzxmxadvChz6lavlyJTPcSS1fenWSdTGVzPdmoSKUbnDJyn
	 R+etGjZKa0xHfwTxfqInV+llHAfFNQSUKwjZrhlaomxjbJ/wacICToWRoq68pQc9hZh0x
	 oIMUd4MId8rVGzAF4eKHmIpy7vHkRHDlBNNFP7h42zR6em+JxHUTbID+78a23O0ubTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505845;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hW7rmnDn2KaDIknO8SywM2AvB2CcnzpkiVaw/vDT9w8=;
	b=GHJe5vKvCgUSI8U9vcpZTNPBIhPy/GqyMvIqqWwoIhHuLpveWSbHln4mMNhx0y+mEHJF
	 FzGf7gJr8MGPX+hVqE3NGVQoQbsS+L8gIhOnQhmvCJginFaAh08hMXEZbuc2XFtE0cGvH
	 bwU5jUx8Lwo9blYWz2ZvuhNkoOTQ1MeS1n0oKPO+UgUOnjLovpddl7px4D+jufG5LF12a
	 nLc7C/hEksuAdCCx+wvx+B9uvt0tSbL8ScbIYZE8h2EQ9+Gc7DQG3ktVRm9G9ywSnYyvm
	 dLbJPi5mUL3OUnj+DnY39gNZHC13pPg9gIX7BnobFeH46JMXX410iVdz8ViB7PyOHdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nODjgBv0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD12606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nODjgBv0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80631F000C7;
	Thu, 12 Nov 2026 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505845;
	bh=hW7rmnDn2KaDIknO8SywM2AvB2CcnzpkiVaw/vDT9w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nODjgBv0gfYFoUR+2Pv6IyCOqnG6GKesIDmkMjG6A+HLp+d5m3A24lWf9yheX65zi
	 IirkWmq3dLhH44hnls+jGlhjupjfVLHmdQVuEq2lLo1yeQfvDimpIfi9y1gFBq320q
	 aTN3ZR277Am1xT9qVI9zngqYBxJuqSKOPEAlOxGtVM1JUb7BYlKrUdfe/pe5KJvkFh
	 EP5hKz8Mq3EbyLE5u1938sAZLZgCOGTitF+6hmYI8EYYcmXN9yduFcsw2IOvGGxohh
	 LCSSWei4M+/4EInSZY77ZdCCAtYN9KrKwOoNkqnQF5XAb0TmdQNuOubAC+AzBWURq8
	 Q+VEZJyXU6+DA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/3] Bluetooth: btusb: Build the driver from multiple source files
Date: Thu, 12 Nov 2026 12:50:41 -0500
Message-ID: <20261112175017.3338563-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112175017.3338563-1-sashal@kernel.org>
References: <20261107050443-failed-7.3-df5e35f1663a@kernel.org>
 <20261112175017.3338563-1-sashal@kernel.org>
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

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

[ Upstream commit be58267a34ae562a4a6932f68f1487bceb0345d7 ]

Allow the driver to include vendor USB-transport-specific source files by:
- renaming btusb.c to btusb_main.c
- making btusb.o a composite object

Used by Qualcomm QCC2072 support.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: df5e35f1663a ("Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/Makefile                  | 2 ++
 drivers/bluetooth/{btusb.c => btusb_main.c} | 0
 2 files changed, 2 insertions(+)
 rename drivers/bluetooth/{btusb.c => btusb_main.c} (100%)

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index e6b1c1180d1dc..8b436c6de8b76 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -51,4 +51,6 @@ hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
 hci_uart-$(CONFIG_BT_HCIUART_AML)	+= hci_aml.o
 hci_uart-objs				:= $(hci_uart-y)
 
+btusb-y				:= btusb_main.o
+
 CONTEXT_ANALYSIS := y
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb_main.c
similarity index 100%
rename from drivers/bluetooth/btusb.c
rename to drivers/bluetooth/btusb_main.c
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799273;
	b=eQ2jUOgqvPe1QnSpJly9YjdhQ3jPC3h574HfOllYpfM/wh9cKaNfzEf5DwnF18n7jT0y
	 ISLV0Bd5/RyyaqeQ0x59gkUNFBUfoHpjV1J83CR/537MT+EZYbGm8/V6yNm060LtM4SuD
	 GbeQzWN6UH2nzk8lRiI8hlqnd4471LqQfiyaAk4+l78gFeKKRZYXubvz1xrlkxR5CWXbK
	 lKzWWd7+A85gkjSkTeJURMBxBh6iPRqUSqXSps7bGmXtaBZigkJLpYVk1l0lA3XYr1Kng
	 q4rCsxl+LdLG3QhGI7YR2cSVCyVN738aV6TUjJzbQJhIkxglpaIUSSvSXYYr/21RrNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799273;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YlVR+QecR+FrLV2jd0FQNdTpJ4JnlqZ+YNRXhVNLA+U=;
	b=QcKVETi/7bYHrlBfOczvTVoGeN4rWdsOKaXUo9TZAIsYGYTBVDwydv1xMeOkYegTMh0N
	 t5SdmdZbLchAzYa7GyPp9oaujAtlrGpitSkVvolLSZyW0YB5gpdnjvpev+esXxckukB1+
	 CB/rEPxNu4lIILhwFEIBARjVGOa2ohLC33oZFd3yO/8QUys3nBbM53DQZsrIb9nP/d8mb
	 1KhUqA7Cyf9w6Gq5/ieGl/Y50VhgB3dw/QQf/wSUEjhjTt9J91yWiClwJW6YfVkvyUj9y
	 uS3Q+1010iiO1LMUJBPM7bRLN2R5IrSUmQGW1MZRcRVUN/nNnsLuA8DDJVEtDf5wZFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgmTEGQu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDD0606A324;
	Fri, 27 Nov 2026 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgmTEGQu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3109A1F0089A;
	Fri, 27 Nov 2026 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799273;
	bh=YlVR+QecR+FrLV2jd0FQNdTpJ4JnlqZ+YNRXhVNLA+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WgmTEGQuAbammPMNShu+DwUdSNPku8WAJX9VlhIIDkgyTAn8W2RxTXAgqEZvmd+TT
	 AvU32W/L/ZNQKk6mbf9lpVX69OweUc4osE4FH1fhx5YJ1QMjkg+Iik7d9jdvZPMRNG
	 6c0I/fDdxBbunTDUZImm0J7SQUp53oPBbcn7LirVgWWXFrFvLj2ZcO0AURe29JUB/j
	 3jJqEisfAFCMbdJywF0gxpkrFBWtl4fxZcU/l8pN3M2/T7dh5ESk4CjLumr2Pz7V8C
	 LG2ZcubbdV6z6VDJxlx97rA1GakMk3XgyZJyNMvvqph0qt1sptuFFErF+Gt/RbxPdB
	 qSZvjjIygW+jA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 05/10] HID: roccat: pyra: Resolve USB device from parent in actual_profile
Date: Fri, 27 Nov 2026 17:06:23 +0000
Message-ID: <20261127170712.3163443-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127170712.3163443-1-lee@kernel.org>
References: <20261127170712.3163443-1-lee@kernel.org>
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

pyra_sysfs_show_actual_profile() is a sysfs attribute callback on the
roccat pyra class device, whose parent is the HID device and
grandparent is the USB interface.  While it resolves pyra via
dev->parent->parent, it passes dev directly to to_usb_interface(),
casting the HID device to a USB device and passing the corrupted
pointer into roccat_common2_receive() and usb_control_msg().

Walk up to dev->parent->parent first, matching
pyra_sysfs_show_firmware_version().

Fixes: be34380ef818 ("HID: roccat: cleanup of pyra module")
Closes: https://sashiko.dev/#/bug/linux-070d5d7b-29ab-4451-90bf-175ada0a81e9
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - No changes.

 drivers/hid/hid-roccat-pyra.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 44c2b416f2db..b3dde2998850 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -290,11 +290,14 @@ static DEVICE_ATTR(actual_cpi, 0440, pyra_sysfs_show_actual_cpi, NULL);
 static ssize_t pyra_sysfs_show_actual_profile(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct pyra_device *pyra =
-			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
+	struct pyra_device *pyra;
+	struct usb_device *usb_dev;
 	struct pyra_settings settings;
 
+	dev = dev->parent->parent;
+	pyra = hid_get_drvdata(dev_get_drvdata(dev));
+	usb_dev = interface_to_usbdev(to_usb_interface(dev));
+
 	mutex_lock(&pyra->pyra_lock);
 	roccat_common2_receive(usb_dev, PYRA_COMMAND_SETTINGS,
 			&settings, PYRA_SIZE_SETTINGS);
-- 
2.56.1.839.g22a8290db9-goog


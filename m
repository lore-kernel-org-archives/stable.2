Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1FC25B099
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728226; cv=none; b=WgH9zyT+TI1DdM2riXRTx4Ft0KWfYPW6qC+4A7QRHUSJIHtge5NYubqGks+2SwYKNYaPsHH9JhhiQgtk7f79UnbSE/Qr/ctJ4lvVLJNuFZufADyCiDPXG3XkqrCnvR4uxeSXwLIPEG2ByqkyHQThe/RnQJ8/p9nhsuoywKf4LXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728226; c=relaxed/simple;
	bh=NOjbHyQ1t9f4Hns/QwVSHdY6Xv32LpnKUSU+axkiZQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SizmUhVqN2HLJpjulpQqpLyQULNB2jlg0EZQDl416+7UFdZQnM7U2Yl2LhbkKzWFa17xKZEjJgp8+SzsBjVO2/3QT151zL7R3t7dVH2ZAdgnKo/3sMk9G9+79hgwCcinM98LjCBJMq6oR+NRlIoUG6P6booAM7u5RPS0f6Q+0VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ0s4R4J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ0s4R4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54211F000FF;
	Wed, 30 Sep 2026 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790728225;
	bh=81SoaqpI+Z1AdOpi5Pws5MSosjNYHey5yU4BCre7iUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iZ0s4R4JKam+iDzh/w2FyV/696SnVdXE/0+VBDWe40sqDcT/n4BO+r+hpI3q0Jjw2
	 UqpaJp8hDOr8LKhvgB8gNTFLLrl9c87PLlH9i1DWfZrZUq2qvr7BA6TbVQJd2iDImT
	 rrnm8AONLWrPlkUdTokRRevw711Dq18vnC5YvBppsYyVAC5nthA+Xyx0tL1/GtWFj2
	 TatJpjmlfAsBOgwrjWqEcvLGocV/Lfg+zdoe4tTPeIWLAJGkC3E2gKJ+JO8KoZ4MFg
	 blsKtTrooiOaIsCkJY+VqyoPfwi7slCMog2g8C5PKoNIoaCbDlnMRzkjxdUOl0Mzi4
	 pPUG5o49F9hsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Changcheng <chenchangcheng@kylinos.cn>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] HID: alps: unregister DualPoint Stick input device on remove
Date: Tue, 29 Sep 2026 20:30:22 -0400
Message-ID: <20260930003022.2942066-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930003022.2942066-1-sashal@kernel.org>
References: <2026092956-legwork-unhinge-11c7@gregkh>
 <20260930003022.2942066-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Changcheng <chenchangcheng@kylinos.cn>

[ Upstream commit aa9dde93e05a837645fdfd577eea71f0733f0694 ]

alps_input_configured() allocates a second input device ("DualPoint
Stick") with input_allocate_device() and registers it, but the
alps_driver struct has no .remove handler and input2 is not tracked in
hdev->inputs.  The default remove path (hid_hw_stop -> hidinput_disconnect)
only iterates hdev->inputs, so input2 is never unregistered and leaks
on every device removal.

Add a .remove handler that stops the device first (preventing URB
callbacks from touching input2 during teardown) and then unregisters
input2.

Fixes: 2562756dde55 ("HID: add Alps I2C HID Touchpad-Stick support")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-alps.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index b2966c6598e18..73de6b04022cb 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -823,6 +823,24 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return 0;
 }
 
+static void alps_remove(struct hid_device *hdev)
+{
+	struct alps_dev *data = hid_get_drvdata(hdev);
+
+	/*
+	 * input2 ("DualPoint Stick") is allocated separately and is not
+	 * tracked in hdev->inputs, so the default remove path
+	 * (hid_hw_stop -> hidinput_disconnect) does not unregister it.
+	 *
+	 * Stop the device first so that no URB callback can touch input2
+	 * while it is being unregistered, then drop it explicitly.
+	 */
+	hid_hw_stop(hdev);
+
+	if (data->input2)
+		input_unregister_device(data->input2);
+}
+
 static const struct hid_device_id alps_id[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
@@ -845,6 +863,7 @@ static struct hid_driver alps_driver = {
 	.input_configured	= alps_input_configured,
 	.resume			= pm_ptr(alps_post_resume),
 	.reset_resume		= pm_ptr(alps_post_reset),
+	.remove			= alps_remove,
 };
 
 module_hid_driver(alps_driver);
-- 
2.53.0


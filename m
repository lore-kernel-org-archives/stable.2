Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF334369A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726672; cv=none; b=TjyGC/KpxlcnDnEnsyUfeHsiYu6H/MKGfiUd52m8Xv6QEo6IY31Nad1s0RoOfIZbrLLV3wxCTU7u6OpoLHPe/rWUHWwGLUcSWukUZmG7805Tp3J0sAsS857GoCMocpkKEAPFP3/z1i9xjERIyaDpCDPVnewFyNYXid1dxS/4qJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726672; c=relaxed/simple;
	bh=TgjnKaAgfMNYv56GrV9J+Rz3F6EqPTlINUwecSzJuyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bi4UXL8GDK37uKov/l7uhR1jyPJGRoytr2YsrXxfFDkE5mqI2W0CZAMpIgT7LR01uE2TjMRXCBKjytvvERdvD2KLGRd8c34xaqcgcLE+MtVya5iEb9FT9n0IXS3kfkZI/94LSfeWogzpvxXSU7owNABp/cOwrDxdEFHl1W32820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXSUZrqv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXSUZrqv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0957F1F00893;
	Wed, 30 Sep 2026 00:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726670;
	bh=sQNALC3Df19rgmfwsrhPm5l46YbXP9eTYowDbcRsmfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LXSUZrqvLl5apKrNSbIDRD//TzIifwKZGqB0eLmq2/NsuIOPOGtLgevcRuLAp3S8R
	 cLG0swpzvwjziH6dURGJ9AjNdrBbqAaszIalzX8ieuIW2qUWi27nCJW8H+OZ5XMQgQ
	 959PqJfPgXSVCeWa0fcRjUKwyWI274dZ+4oon926Eb2+h1o5F7knRILiwGlnqUBVsY
	 UFGljQBnXbVDldanjAsnoua7viZjUv2ih15Q2CHbEOXmqKqurdtw1ai/C418hr4EFx
	 zpYRU+Od1oJRQ+2tbWW7CuHV1LYD1Gg2qfdZZ2aLFNWYHO/z7XsXxSkr3M6hq3Rj3M
	 of/MXfdH9hR/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Changcheng <chenchangcheng@kylinos.cn>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] HID: alps: unregister DualPoint Stick input device on remove
Date: Tue, 29 Sep 2026 20:04:27 -0400
Message-ID: <20260930000427.2866647-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930000427.2866647-1-sashal@kernel.org>
References: <2026092954-curled-shabby-13d3@gregkh>
 <20260930000427.2866647-1-sashal@kernel.org>
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
index 67179e3fe39b7..370635f5b7043 100644
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


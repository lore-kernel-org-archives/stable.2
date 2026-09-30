Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1240F371860
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735659; cv=none; b=gMuv2hVoxyP50OMudfPIFCYDkUBdJrOFkkM9MyfTOulkQb8xPdWy199LlXUbmwfNgB7b5w6Q14Tfm7wUo2KpEqqFnCiLCvChGyba2h6g/VJ1IvWGUcHfX+2cyiGJgpnmahbOx6fuwNhNRKfPolNCrus2Bncu89mW5H2As8GgufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735659; c=relaxed/simple;
	bh=NOjbHyQ1t9f4Hns/QwVSHdY6Xv32LpnKUSU+axkiZQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdqAmMKIrHM0HtWx4dp0Ll2yGToMifFEi4SfhwDB3WGuPfeMRIxX0gxibiibJYMtPOB90ouWBT4NTZC1xxskxnIiHbnB5BBs1LZaVsvy2J1ByL2p0l+RurabNy7aewYZ/1UqWx6NHRuiRv1b/cRUcatOQ506WdsGSkSfyGIJRc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbqnUz51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbqnUz51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6169C1F0089E;
	Wed, 30 Sep 2026 02:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735651;
	bh=81SoaqpI+Z1AdOpi5Pws5MSosjNYHey5yU4BCre7iUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jbqnUz51YwanVJ4uMKfQL47XN23ufRDUcGocFLVKvyGHf/2z/FILXll/pC/IQmmeS
	 RgzPSJ5eP6+JOO9oTYJ2U6DGh3vZdUCXu9TVcP5uLQt5rtb05oTd51DOKnV8uIe8c7
	 TIpvfqo2dD6MoXjI+Eo/+1e4l98oM1yvFL0USU84PmQfKzIVIdSxhCIXpOq0dFQALv
	 86Y/ddA61O4q7Fg5eWcm5bBem+5La4YqQylZtNeIadyDvM1er6XGttz2MeXW40GYRR
	 D9v1SMKS7XnbNIB0J4+UBInpm4Qzdbfm3BrjwcoRGCrj8HK0K04cTydzhYmpgxwDLl
	 jnwGZd2M5bLQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Changcheng <chenchangcheng@kylinos.cn>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] HID: alps: unregister DualPoint Stick input device on remove
Date: Tue, 29 Sep 2026 22:34:08 -0400
Message-ID: <20260930023408.3421577-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930023408.3421577-1-sashal@kernel.org>
References: <2026092958-confirm-underfed-6c0b@gregkh>
 <20260930023408.3421577-1-sashal@kernel.org>
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


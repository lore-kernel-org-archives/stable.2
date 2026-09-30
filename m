Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D925785C
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727633; cv=none; b=c7EsPvP2x7OYx+yy+oFJS6BZ5TbYj2XP8gICcRWybThsOAXmq8bZfiXUhO9Xpb95MkvmQgfSCG/4FNW63KDKAikqv13+HQ/1MhAlvDNME/WGWhUotqAy+Fd4uXuZaOaad87SQyDTvjZmsxMzfU1eftoc2OZzXLrM9jPt5V7BsO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727633; c=relaxed/simple;
	bh=TgjnKaAgfMNYv56GrV9J+Rz3F6EqPTlINUwecSzJuyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPITU0OtNBAqUt1LiHfbBFOomeRReFg426pz/RF2PEHujQsNp09LGI6C6Mi2FLIJhuXqNbX43cJoa9KTYqIkR28Q/VR7aR2Ix1S/2h/Vur3v3u8wfAKvFS1tXU1sQVIDzB779sIHadlsupxRkkBDU5wbpqrCwoE6Ef+rIOq5S60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb5Y/m6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb5Y/m6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F82F1F00898;
	Wed, 30 Sep 2026 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790727630;
	bh=sQNALC3Df19rgmfwsrhPm5l46YbXP9eTYowDbcRsmfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tb5Y/m6vtkNviSkhm+zCkMwe/3oIaoWYm+As27M/aKTDfx+/bSyo8b9Ct8eEiit7U
	 00zqrKbsJmx7tHccylzEIE0oIF2Oh8xuiEZXBDe+cs3IEPMngSb7kNi61/WEgtjzoj
	 BfW2lSAsbabVt/+MnjqpnWKc5/9gNhAECbJVJVhmnXyWBgnFPHrJRfXserhnGmoVd+
	 UN+5GO7lAD4EaoTrTzOMkrxU/EKFcbsYR6ze5Kx3f5CPCY+PNitzeT2X6SZioiXRpy
	 JAXDEQjaCVrOhWitXWJdFVlpySaenPETn0LHr+Fk5Q1ACIhFuCvMFjB8QGH3kaGRK4
	 /BptS7H2QRZlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Changcheng <chenchangcheng@kylinos.cn>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] HID: alps: unregister DualPoint Stick input device on remove
Date: Tue, 29 Sep 2026 20:20:27 -0400
Message-ID: <20260930002027.2934444-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930002027.2934444-1-sashal@kernel.org>
References: <2026092955-onto-scouring-df20@gregkh>
 <20260930002027.2934444-1-sashal@kernel.org>
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC23334040B
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735925; cv=none; b=qJphJPMTsNgunrf35+HNApH3RNx5dM7Lh38b/M22FELdPHlNLE5k8/XJKzq2gXcZ9qk3Rv3U5VTTwmdKhLlgCguYGADBlEgpY45ag5I1qJ9sT3mJaQeGwMgRRUdVa2MhOz7Dyu7N/hRVzyMU8eUPPSt6fellOzXptVgk8MmG1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735925; c=relaxed/simple;
	bh=D8ur4lpw64R/hOiNw5hwwYe+NMJCijBrdZ74p/Cw/40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NM3HCJyqhPQXDTuGq0z+Hqh7NG7lWP6k/lKiAgd1e1h+1GbbHkv2wCJ5+REUHihz/bfIa3RNmXnIbL37gq+8x0ZBGEj2t1g2b0zTi/bv7Gl1g/25ZWsP1ca11o9r5MKH4XrIFkMbMcaqveRHkJihEotG3bqdw7f3Jd38Qa0jvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlmFAiZV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlmFAiZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6E21F00898;
	Wed, 30 Sep 2026 02:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735924;
	bh=VAmnt6B+rQjksGDdfv7xSuAkTOD2KJxwAsFpoE/fzYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nlmFAiZVAgQJjvA2TpFXC3x901zQ4mS9GW7KV/rgoVN/ZWgd39Ar1rBMHxDLoDLoE
	 550lyw8IdKIdTd7SA6uDOGGmDcO+DiuBa5eZW17tkjR7LbNaSMHM/si0XxZYOFSbmz
	 9YpvOmFIzgHfCBKY+AB1eAe59RZ5DlduS+HgA3P7mjjZlIik4lIKzKJ5IK/+JHQ/uW
	 kGcSSgsuRLN8fdUZIK308jxasSTcbPVXyQVTa3hSqLy+fnTd/eG14C6jlFRuWkQp84
	 UMM2Ym7l6Is1WRE++JuRjwhVcucgodmHDrNiSDOvfNYiNiTKPwd6pkul7OUkZ7Vdrh
	 w3xaDJ9rJ6Cig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Changcheng <chenchangcheng@kylinos.cn>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] HID: alps: unregister DualPoint Stick input device on remove
Date: Tue, 29 Sep 2026 22:38:41 -0400
Message-ID: <20260930023841.3438294-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930023841.3438294-1-sashal@kernel.org>
References: <2026092900-radar-unrushed-0fe1@gregkh>
 <20260930023841.3438294-1-sashal@kernel.org>
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
index 6d46a4c1a200c..a83b5e9d0ac67 100644
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


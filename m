Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AE0279DB1;
	Sun, 11 Oct 2026 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700144; cv=none; b=ESMmYnIcU21KaAm3E0MvOSD8jIPdv0BjfHR9u9WJucolYeRIAIEeKhxYdYn91LlCwz9w0nIoj92DQMAaqLPpZMiUL2JNXTPdVt7iMSfHzmqUnBOGNRcQPAmF13HYYuYFWSaNWkWyJAVdXN7v13u5oJYeWN5hRMEJiljvvxBXfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700144; c=relaxed/simple;
	bh=Ztzw7tIq+F5DxzZ3zYHgJ6+Ip2a4HgploLiOOYoCT8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eyc5Vo1mwCHIkpFE69scrfTnlW9+vMCvGyaocROuJHY0Sa2dcvJKGtPyxqLEKhoYcoLBCjVhppxrzPbjT6/otd2QQdqmKJ+Vsj+fCevRcp2/ny00ShzC/5bmoH6qLG5yZ7DT94WUZQmssWBJIgdz9Pna1EwHLvjze4RO2KOIQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CIYEYSK6; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CIYEYSK6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=SS
	VvchRVLaj/Pb3fS/ZmIqZ7GV3LIWkg7RWPBl3w+iw=; b=CIYEYSK6RkP9nglEXf
	gVYda7jr9yERPtSK9Wm3/ezIbh2Ua/AsqWkD8VRs+RFMgNa+1WhAwwptcNMi3xUm
	CStGHORgg8VWcy7And7lC/8godOCBH0S6J+Z1UBZLfUjhLFrGiYEdaT9/S+MoDx8
	81gxneqrDAEvL0RaRt+tPKdkE=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBn5exyLMtqwLyuDg--.24813S4;
	Sun, 11 Oct 2026 14:28:13 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure
Date: Sun, 11 Oct 2026 14:28:01 +0800
Message-ID: <20261011062801.3163066-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBn5exyLMtqwLyuDg--.24813S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr1kGFWUWr4xtF18KFW8Xrb_yoW5WF4fpr
	45XayfGrZxXFyj9r17Xr4xX34rCry0vr13Wr1Fkw1rCw4fKry8J3y7JFy7Xw1rXrWvg3y7
	XF13JFn5ZF1Ut3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_zV1UUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC0x23wmrLLH2CHAAA3V

cs35l41_hda_probe() takes an acpi_device through
cs35l41_hda_read_acpi() and stores it in cs35l41->dacpi. It is
released in the err: label, which is reached from every later failure.

One failure is not routed there:

        ret = cs35l41_hda_read_acpi(cs35l41, device_name, id);
        if (ret)
                return dev_err_probe(cs35l41->dev, ret, ...);

cs35l41->dacpi is assigned inside cs35l41_hda_read_acpi(), before the
point where it can fail:

        adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
        ...
        cs35l41->dacpi = adev;
        ...
        ret = cs35l41_hda_parse_acpi(cs35l41, physdev, id);
        if (ret)
                return ret;

so on that path the reference taken by acpi_dev_get_first_match_dev()
is never dropped, and cs35l41->acpi_subsystem_id is leaked as well.
This is reachable on any system whose ACPI description does not match
what the driver expects.

Route the failure through a new err_acpi label that releases both.

cs35l41_hda_read_acpi() also drops the reference on its own !physdev
path while leaving cs35l41->dacpi pointing at the released device.
Clear the pointer there so the reference is not dropped a second time
from either cleanup path.

Found by code review.

Fixes: 447106e92a0c ("ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 sound/hda/codecs/side-codecs/cs35l41_hda.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index 62296be45c55..1088065f1fff 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1929,6 +1929,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	struct device *physdev __free(put_device) =
 		get_device(acpi_get_first_physical_node(adev));
 	if (!physdev) {
+		cs35l41->dacpi = NULL;
 		acpi_dev_put(adev);
 		return -ENODEV;
 	}
@@ -1986,8 +1987,10 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	dev_set_drvdata(dev, cs35l41);
 
 	ret = cs35l41_hda_read_acpi(cs35l41, device_name, id);
-	if (ret)
-		return dev_err_probe(cs35l41->dev, ret, "Platform not supported\n");
+	if (ret) {
+		dev_err_probe(cs35l41->dev, ret, "Platform not supported\n");
+		goto err_acpi;
+	}
 
 	if (IS_ERR(cs35l41->reset_gpio)) {
 		ret = PTR_ERR(cs35l41->reset_gpio);
@@ -2066,6 +2069,12 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 
 	return 0;
 
+err_acpi:
+	acpi_dev_put(cs35l41->dacpi);
+	kfree(cs35l41->acpi_subsystem_id);
+
+	return ret;
+
 err_pm:
 	pm_runtime_dont_use_autosuspend(cs35l41->dev);
 	pm_runtime_disable(cs35l41->dev);
-- 
2.43.0


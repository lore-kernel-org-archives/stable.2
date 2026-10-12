Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916C455607;
	Mon, 12 Oct 2026 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794566; cv=none; b=Nxx6o8rBn2QxL+nQhKMo/9t6Qd0crVYPFEJysz8dRlxY5S7ILDrYC9yI7oR6CcqibugetNCszPIrFACdfUY9yjbdspdPy2sjzs1+86SehisphvFLcwINVsivcL7sJJQMQYVyTHRn83omilhq1eyswXyZNnqFWdsdZiDfiddXhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794566; c=relaxed/simple;
	bh=t/NdJD5NAhn4Znk0l0sUNGnRewqktqylJ4czb2rqW8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fHpeiCaGOhKW+CaSlD4Gan6RocUtYtvjfhV80XLQHr41RRDT55xk8I0sddRvNk4F0p7t2m74Dx9+WS2NcuSg50feZ4V8lrrTxsS7ESr6jurPJUrAbpjussYwXtlhsVGxGk7zZxDqiiJIVtfdjhU2Hnu23Quke5XEzxf69Rs5ACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Yvz3t48a; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Yvz3t48a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=t5
	4og3rvACAr8tHWID93e5cauTmzfGVR2GGol7R4X2Y=; b=Yvz3t48aovTY2dzsgC
	b9hrKIhk35W7NKEzxG7CSy7zCDP2qwsnBAc1SUuHcw0qM2t3iTw/Iwd2mu5j+pYi
	ULo/n5pQXxBxOdL0syYMnFgyGII03dbmNfd2KWYB/i/dpJGaHT4Q9cqAixbKMHYP
	/PbHIzFDUP/JEZ10kJ5kAh2lo=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3F0lRncxqkmahEA--.36665S4;
	Mon, 12 Oct 2026 16:42:01 +0800 (CST)
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
Subject: [PATCH v3] ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure
Date: Mon, 12 Oct 2026 16:41:52 +0800
Message-ID: <20261012084152.3740340-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3F0lRncxqkmahEA--.36665S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFW7Zr4kXFWrWFW5GrW7Arb_yoWrJrWxpr
	4YqayfKr9xJw109rnrZF4xW348Zry0vr15Wr1Fkw4rCwsxWryrJ3y7JFy7Xr1UArWvgay7
	Xr43t3Z5ZF1jyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piVT5JUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9RlLVmrMnVlT+wAA37

cs35l41_hda_probe() takes an acpi_device through
cs35l41_hda_read_acpi() and stores it in cs35l41->dacpi. Only the
failures that happen later reach the err: label, which is where that
reference and cs35l41->acpi_subsystem_id are released, so the early
return taken when cs35l41_hda_read_acpi() fails leaves both behind.

Keep the ownership in the caller instead of dropping the reference
inside cs35l41_hda_read_acpi(). That removes the need to work out
whether a given failure path has already released it, and with it the
double put that cs35l41_hda_parse_acpi() would otherwise cause when it
fails after having released the device itself.

cs35l41_hda_parse_acpi() and the !physdev path no longer put the
reference, and the early failure enters the existing err: cleanup tail
through a new err_acpi label.

The label sits between the reset of the codec and the gpio cleanup, so
an early failure also releases the reset and chip-select descriptors
that cs35l41_hda_parse_acpi() may already have taken, while still
skipping cs35l41_safe_reset() on a codec that was never brought up.

cs35l41->dacpi comes from devm_kzalloc() and is only assigned once the
ACPI device has been found, so the put is a no-op when the lookup
itself failed.

Found by code review.

Fixes: 447106e92a0c ("ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v3:
- Modify the patch. Thanks for Takashi Iwai and Sashiko's suggestions.
Changes in v2:
- cs35l41_hda_parse_acpi() drops cs35l41->dacpi in its own err: label, so
  the err_acpi path added by v1 would have dropped that reference a second
  time. Clear cs35l41->dacpi there as well, not only on the !physdev path.
---
 sound/hda/codecs/side-codecs/cs35l41_hda.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index 62296be45c55..d50c3d8f5303 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1907,7 +1907,6 @@ int cs35l41_hda_parse_acpi(struct cs35l41_hda *cs35l41, struct device *physdev,
 	hw_cfg->valid = false;
 	hw_cfg->gpio1.valid = false;
 	hw_cfg->gpio2.valid = false;
-	acpi_dev_put(cs35l41->dacpi);
 
 	return ret;
 }
@@ -1928,10 +1927,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	cs35l41->dacpi = adev;
 	struct device *physdev __free(put_device) =
 		get_device(acpi_get_first_physical_node(adev));
-	if (!physdev) {
-		acpi_dev_put(adev);
+	if (!physdev)
 		return -ENODEV;
-	}
 
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
 	if (IS_ERR(sub))
@@ -1986,8 +1983,10 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
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
@@ -2074,6 +2073,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 err:
 	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
+err_acpi:
 	gpiod_put(cs35l41->reset_gpio);
 	gpiod_put(cs35l41->cs_gpio);
 	acpi_dev_put(cs35l41->dacpi);
-- 
2.43.0


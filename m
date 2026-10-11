Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839D3164BA;
	Sun, 11 Oct 2026 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791719035; cv=none; b=Givj5AMtzcUSpP2rAnV5hsswkhILihhut0TMj6joWqdQM+0kt3voXypywCvQqIyzFHS961rhgqe1KRoAoIBiSIaP9ma0N/Sp7Lsrdq/q7xb/cnnA3y/VEvC3er7GVDMeeJIlLCEv5NxclyQFn+4VJ//nwuXHOwFpp3DOM6ngXMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791719035; c=relaxed/simple;
	bh=7SRQi23gE+ovKFFP1Sdpc5I6EZoIbgEZy1obd4OL2to=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5doAdKExw0gcLtsTwv5ZENvdkez4DfeSWgw3D6y+WPtGsRjyzS80NfN3d0WQXhR6uRzsZAQ0AH4NvS9oO0pKc4gouzvg2k/O0Z/JMmBlb+O+qfuJ0vRsgRK9cd6e6lsLH28s6yMvsl3oZZ/m/UhiLUY+U308qVwMnAQdWZFbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=akQKVMON; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="akQKVMON"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qp
	We2zzTR2qEa81xaY4E9TVIIl9IBDwhCvMnG1NkejE=; b=akQKVMONmYc4n2i1x4
	zMkD4KJkwc6g50kVrB1o03uQ4W1dWMoetAbmY7Z8nAm6xVBNZ7TzFM2g3dHezekc
	HzfjqFM5sR8ZGHPKHUbAb/37WNrdHhxu7rylfRs2YKpJtYA3/+ONnM68SY8jdW+h
	fKDv/JLZvtlLtINzkrcSRMQNE=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3r4Y9dstqBhOCDg--.25652S4;
	Sun, 11 Oct 2026 19:43:04 +0800 (CST)
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
Subject: [PATCH v2] ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure
Date: Sun, 11 Oct 2026 19:42:51 +0800
Message-ID: <20261011114251.3257172-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3r4Y9dstqBhOCDg--.25652S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrykCr17WrWxZFW7ur43GFg_yoW5uF43pF
	4YqayrGrsxXr1j9r1DZF4xW348Cry0vr13Wr1Fkw48Jws3WryUJ3y3JFy7Xr1rZrWv93y2
	qr43tFn5Zr1Ut3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piVT5JUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9Qg9SGrLdkhzngAA36

cs35l41_hda_probe() takes an acpi_device through
cs35l41_hda_read_acpi() and stores it in cs35l41->dacpi. It is
released in the err: label, which
is reached from every later failure.

One failure is not routed there:

        ret = cs35l41_hda_read_acpi(cs35l41, device_name, id);
        if (ret)
                return dev_err_probe(cs35l41->dev, ret, "...");

cs35l41->acpi_subsystem_id is allocated inside cs35l41_hda_read_acpi()
before that point, so it is leaked whenever the function fails.

Route the failure through a new err_acpi label that releases it.

That label must not release cs35l41->dacpi a second time.  Every
failure path in cs35l41_hda_read_acpi() that can be taken after the
assignment already drops that reference: cs35l41_hda_parse_acpi() does
so in its own err: label, and the !physdev path does it directly.
Clear cs35l41->dacpi wherever it is dropped, so the pointer never
outlives the reference and the put in err_acpi is a no-op on those
paths.

Found by code review.

Fixes: 447106e92a0c ("ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v2:
- v1 released cs35l41->dacpi from the new err_acpi label, but
  cs35l41_hda_parse_acpi() already drops that reference in its own err:
  label, so the reference would have been dropped a second time.  Clear
  cs35l41->dacpi there as well, not only on the !physdev path.
  Reported by Sashiko; thanks to Takashi Iwai for pointing it out.
- The leak being fixed and the diff are otherwise unchanged from v1.
---
 sound/hda/codecs/side-codecs/cs35l41_hda.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index 62296be45c55..3a8e04f73f79 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1908,6 +1908,7 @@ int cs35l41_hda_parse_acpi(struct cs35l41_hda *cs35l41, struct device *physdev,
 	hw_cfg->gpio1.valid = false;
 	hw_cfg->gpio2.valid = false;
 	acpi_dev_put(cs35l41->dacpi);
+	cs35l41->dacpi = NULL;
 
 	return ret;
 }
@@ -1929,6 +1930,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	struct device *physdev __free(put_device) =
 		get_device(acpi_get_first_physical_node(adev));
 	if (!physdev) {
+		cs35l41->dacpi = NULL;
 		acpi_dev_put(adev);
 		return -ENODEV;
 	}
@@ -1986,8 +1988,10 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
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
@@ -2066,6 +2070,12 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 
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


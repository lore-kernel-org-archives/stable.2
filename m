Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327388;
	b=2T+Z1LmWQSBjLZ2+c8y23Y4P+lVblozlr+sZfVA1uIOwL4dw7XCJ6jO+5o64r/RZAgQx
	 MRFTNovS+5f/8DDwZw32oDGrLbm+HEp6IdzXYe9bYk3oIIXYWWznrf0ndUw12i7JLUDN8
	 u9FCVDi1433qUhBcGyGHHKx+rOQ05Xb3Kfdbzpr4SLourRBPIvBFYADQrU0jjAr3/PLuM
	 +7uCL0pXoqOUHLiOlTAx+CDpG03vTezFB6oo0t2FY7aVWBKtSwIOtKit/XZg1R+SoOTZl
	 tinMxfs/jIlguwa3MwJ/EUR2UZSBLLnWdYI6+/6T2vnPA2zOTIucWnSRoQI7gQ+ZF7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327388;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vGLOXHLRbhIe7AZPve3zl5Tte+Ap25S8OYAazcGNugI=;
	b=NKBDMl9WjLffc6MHFqFts0+9aqQSweon410engT/xTsReufyO9/XElj2cS/n+Rx11j/5
	 vRdfoTBlgALG6rvSoAS3Xc3rDUQgdCdzKC8vA8hyBcql5Av7PvH5m4srJ3CssQCCllMtr
	 JVywCUEfm6h4FVqbcwpMkXpVM00PpWl4FDIutbFBJiveSxgGjWufqEBq6ErEFAykP6xEV
	 YWmkMU6pqWNV1p1iygbXUNokL3FC2f+RY3+eP4SxB8ihlhgfmIL4Eg/uoJshtsm6hjEtU
	 lgI5UHJlRCg14BUqZbVeV7Vm/rOwJKcvnNo7fbHqXC8Ox7cfXW5hr9KXGo/Ee8m3fPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVOfvr4C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8EB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVOfvr4C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC711F008A2;
	Tue, 10 Nov 2026 16:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327387;
	bh=vGLOXHLRbhIe7AZPve3zl5Tte+Ap25S8OYAazcGNugI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YVOfvr4C7hNT1Sq68slg4VukPIe2wRnfZzIqi/SO8ctSyHUhryHwtOjafXwQYDAPO
	 R5EXIftOF/xLknZc139vws501y0yYY1fA1biSPCc1Yl6i6afDG0jsFjpRqQMrFb7Vu
	 7blGOJ8ZmHXkbGGeyHiD9I9TOgkNvInM38DKKOOpSD4lSRwqafFt86+sJaCQd4Bg+e
	 woMWz3EtRkCQTYX8HDtuAfwD+O+qy0TwGlKDWSXZuIHFxAW2CEj1gpppJxh7a4/KWn
	 PrczPIYdgiqFaP2dihSNV5NaWtmEZ7lI0ssHLBJGv83geXjZAqWEhRXlNW0waYZNqO
	 +7nteZX5ku6OA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ma Ke <make_ruc2021@163.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure
Date: Tue, 10 Nov 2026 11:16:23 -0500
Message-ID: <20261110161612.2453887-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110161612.2453887-1-sashal@kernel.org>
References: <20261107052118-failed-6.12-8d70e364e866@kernel.org>
 <20261110161612.2453887-1-sashal@kernel.org>
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

From: Ma Ke <make_ruc2021@163.com>

[ Upstream commit 8d70e364e866bdfca81eee24d0688fac9472cfb9 ]

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
Link: https://patch.msgid.link/20261012084152.3740340-1-make_ruc2021@163.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index d01691c13bf33..210cf48faceca 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1887,7 +1887,6 @@ int cs35l41_hda_parse_acpi(struct cs35l41_hda *cs35l41, struct device *physdev,
 	hw_cfg->valid = false;
 	hw_cfg->gpio1.valid = false;
 	hw_cfg->gpio2.valid = false;
-	acpi_dev_put(cs35l41->dacpi);
 
 	return ret;
 }
@@ -1908,10 +1907,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
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
@@ -1966,8 +1963,10 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
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
@@ -2055,6 +2054,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 err:
 	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
+err_acpi:
 	gpiod_put(cs35l41->reset_gpio);
 	gpiod_put(cs35l41->cs_gpio);
 	acpi_dev_put(cs35l41->dacpi);
-- 
2.53.0


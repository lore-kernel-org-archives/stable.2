Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046222;
	b=4jn6dIog6lIcWlUjv/ZOjXMyg4967nW15yMeGYJbADoTEMHfqx6CZV4/DY617SQM3D4y
	 kVgPqezBEKHceC2lvV5mHKHdzZMSOXwMDAVhkBNoVS1zWBVLG7myT1+au8wbV6vRitznh
	 L5EBw+s2fKSgSHiq+JIT0vwqkP94mtkmzQzb609h1fO5qS+O+IKAIBM4bl+BfgUi5Ub6X
	 OYcIUCOKA6OaIpCcKPxchZX+UHm49oBOPwa90holH0Kdj0E6CToLd+4PyHMiz9U+RzFmI
	 LtkWlOfkW5xu4F/UTvOL2AxCBVPRHrEZrh2M+tgkh9U9B3yG1hSZbv4yHnVJRpVzGuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046222;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A9DboqoKPVPBDEWvdJSc8tOtsH2NRsPFmfwJ6HTbVrY=;
	b=TXzrcwq31YSrlCev07XBJnTzLywjfjOifMyFwDgDnHKcPpEHREOd5tt2ehP+FG4QMNsb
	 Pb2hof6mCmu0Q7ufv9EkA1ENAnOpnw45ZpJW7D6gC3c8hRClspk4jysWtsumS1Knj2+VJ
	 NxHlri0ZHJdqK6UrDbWZDsJ2kDl1y2hBzn98upba6yXuvjMYsoJtXtt7hYearVC08rPWL
	 +5aVw7qNBH3QZuK6jZK2XKuaUXwqg2mx3G01me/byJs1Ty/idxO554mKzl3Vyn3K0kZ4v
	 bD4wjwJg5gwbwpLDtyWWKkKCOdrhdHCGkZnWdM5Lz+1b1udNCrQsvgU5LBAo8oob9wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsnaOPbk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FBF606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsnaOPbk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831621F0089F;
	Sat,  7 Nov 2026 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046221;
	bh=A9DboqoKPVPBDEWvdJSc8tOtsH2NRsPFmfwJ6HTbVrY=;
	h=From:To:Cc:Subject:Date;
	b=ZsnaOPbkLQmNQtwrxMeiu+fVxGPS6tqPDpuY/CK8W0m9HYNrt9jr7eqJDA9ShlIle
	 LPkjYhfUGCcd4f85a0lFkpr0m/wlCZnTFSIumgvtNUVUARRMU3p9Y2o1kVHNTvvqao
	 ao3iqshoDYh+YKY9kVrXC0PIiPfxSn3L5iNE+2eGrwqQrIckfDzQ01m9uC9ynV1Kkh
	 63d8puVfP96MQ3mEqrWj3ocZobVwdM/argM3N/scbnHJMniUGHo/b1VPV5vi3Snwve
	 gwNt9+FIJHkUtqJASlMcRHQR1uIPPEFZf6/2hSWRa8X1AIkwiHhvbPfcZcNK1r1uNN
	 gaWpRgswmR2kg==
From: Sasha Levin <sashal@kernel.org>
To: make_ruc2021@163.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:20 -0500
Message-ID: <20261107051020-failed-6.18-8d70e364e866@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8d70e364e866bdfca81eee24d0688fac9472cfb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051020-failed-6.18-8d70e364e866@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8d70e364e866bdfca81eee24d0688fac9472cfb9 Mon Sep 17 00:00:00 2001
From: Ma Ke <make_ruc2021@163.com>
Date: Mon, 12 Oct 2026 16:41:52 +0800
Subject: [PATCH] ALSA: hda: cs35l41: Fix ACPI device reference leak on probe
 failure

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
---
 sound/hda/codecs/side-codecs/cs35l41_hda.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index 62296be45c55e..d50c3d8f5303c 100644
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
2.53.0





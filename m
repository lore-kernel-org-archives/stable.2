Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046880;
	b=BERNkpTJ0PubtJRPl6IeyE80KjPdr8LSkBLRCO/iOYeQT3Y7vHg6D3fQ45pyegm7dOGM
	 BgFDPQDTqhgJc5VPv1P2JX5Ue6Mwx9YzPeZShrp4jSfshhT75cX6IY6Zh23meqLo92mBo
	 MlmhltTHckFbRkaXrCHch0JIJJnB89AcVXqvZPoNFXUYb3qbtl1lAFCwLr3OPp6Py7qFL
	 y0rch3m5cMBnNYfkZKinTnkaIsxugu/bjM4FGxlanQCPkInu9Vs8rivR2SLDHUJpq019T
	 gTPOe7OoQhqh7ZKw+2N4WXvnG4yZ1/b//fCyiOSLbr13L1b3wPhEdl6TDHqcCL4ABnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046880;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=m8fgnip8nVcxyuelltYqKRjRXivw14gZwgK/DvyHdVU=;
	b=CIw5CYFfxcRFraTcp5hRDnJJjW30Cp4k0WvX/s++0LmRUeCTf+0NWIO1y2r/5imyMZQg
	 pMOmRadaN2U281a8CLvbASbUub+qhqkFvAU5WX5CkKl1ATjNKhV1tDYNfnoy/xL1m+Wlh
	 UJjRvLUuIXQJhN3kuDNjdWz+Hjy8IPCfayRGyH55UXiuiw+l98S4p7ATcfYoOFvb9XU0U
	 iL96inXD21y1uIWox7UlrKNwpye11YGzfP9k3MfE9fjfy7jdfLfmIkqt+Xz4mn9XDpUAr
	 Rnlvu+n1iY8mgbqDweH628KvGz8qCsKzpYCyvQQJY/ev/HAJo6qW+E/yPp5BifX5fCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRmx2NBq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85C606D839
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRmx2NBq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7D01F008A1;
	Sat,  7 Nov 2026 10:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046879;
	bh=m8fgnip8nVcxyuelltYqKRjRXivw14gZwgK/DvyHdVU=;
	h=From:To:Cc:Subject:Date;
	b=nRmx2NBqbye4xYmivLsumVsRKvtELtAPUjHE7yRAja1iNZFFOjk+DE8IUu1fNpX1W
	 bGrOz3TxtcPlqtNjfuVpWzFRTGOF2nCitm7E6XaQiSx4mO51I5EuipqyjI4x3nBGhy
	 XhA9oOITxJVAZVhbQ7tduM0+Gw1JQY9ypv4Yqwuzcw28wQGBACo1pcKtOaImMNoOgL
	 Gs1Ic4hp+P3zrxxz92VpFY3V+a4v9VXxE5al0hecP8q8YMZoqcsm1fiTsSa2ewi7aO
	 DSf4KJjNxxpULJ057RjhgMSK9wyzKJXdpRhWDOKUmYSnEZznHLLx9AREptUbFQfRUY
	 ae7jdmd8UQ/dg==
From: Sasha Levin <sashal@kernel.org>
To: make_ruc2021@163.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:18 -0500
Message-ID: <20261107052118-failed-6.12-8d70e364e866@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8d70e364e866bdfca81eee24d0688fac9472cfb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052118-failed-6.12-8d70e364e866@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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





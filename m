Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048950;
	b=GqfWMWCdQFe1MueGBsLOcUllWbkHYPZCkIoYukKajXFw417YZal9+Tcx/rA0BL6SgAN8
	 rBUlH8NrdQUgmDgzIxOr81sr2aYYcMJdFqbQ5myr0w/Fdn43bahQi/bUaJVmUI2mw2zhz
	 O51CVRAZ6mIYOoZSDXgr1wCldbiayKgunZf80GTqsEEEHlUW2e2gXzIwSg83Zo23GEoff
	 ZUwShYdPVo3ijoDjq6Hs7DwA5YgkMLVqwfGeEjPX1Dx6oOGF4rJcwak5+L7/HggVJljCq
	 oURn3PcWU6C9m2cL2KyNj12e+HxEHpt6oCAC1FiCklnX0KV65V0IL7ma57EXy+r7+iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048950;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xwMj/5A6d+O1fc/UveCl++temrd+zr5yQSJOyrLfKE8=;
	b=qg4xHp/ld090vqBJz18ZVPaONL4caQZi4cjO4rmUhcI7wAPyZK14XSoalqXqssOs/30c
	 /PfjmCAvzLAGuwPx8mT6s8VWMVacB8BvliwfPS6XLVlMs+YtFPXYY92T7WqW6XJP6SI2W
	 osnCFbJD3j1/YpN7Roeu7Eeo8Uywb9Zv1i6kwbWVYWkIrk2EeTp8SN7a/m7uPsGVsWzaS
	 ruuaoaPjURIEE/e0E/3sDas2LFVAQyLZ2O6T8hBeiQRmRaGPZGLLhfRgfrP2RkOFdoNkf
	 jMN1peMGcUQt2kqSCGy740/RY3Dbx1WBQ/CFalhcERm/9ZvOwGFV9746c/uQDhXWx1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbEWgMCd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700E606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbEWgMCd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C1F1F008A2;
	Sat,  7 Nov 2026 10:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048950;
	bh=xwMj/5A6d+O1fc/UveCl++temrd+zr5yQSJOyrLfKE8=;
	h=From:To:Cc:Subject:Date;
	b=KbEWgMCdwuRdHivgVwLL01aBXUSiVTkggXaxDhEE1wuEEUtwmAJeA2kVrusy1hB4k
	 sEuhUFhZ7NhGW10Fc/8cdKJdet5ncxT/ORUQeoPzMo0TovHW5wzX3+BlYHane1vXOp
	 d6v9mH9/61Y64Oz1NGDu0npaMV12X47uRrVwRh6ypsT3pW1nwGK+lkVMygqh+UaYi8
	 9AxORQo+wGbgeIwef2RknTWI03YKnJq0Nw5eVsLsmVpHy9jDN3bRi6SsHsCuOZhnfU
	 /exvcyzmL0s5k9ZnYPMXDwO01/aNS8pnOYx9cDCPyPiZL29T+KNnJOTm5RGBM+Ff3x
	 LXkVZwy/seLAQ==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: hdac_hda: Restore the codec device type on unbind" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:55:48 -0500
Message-ID: <20261107055548-failed-6.1-08a44bde821d@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 08a44bde821d4fe22c0b6e63da04b3c59ac243a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055548-failed-6.1-08a44bde821d@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 08a44bde821d4fe22c0b6e63da04b3c59ac243a8 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Tue, 27 Oct 2026 10:38:39 +0200
Subject: [PATCH] ASoC: hdac_hda: Restore the codec device type on unbind

hdac_hda_codec_probe() changes the type of the codec device to
HDA_DEV_ASOC to prevent snd_hda_codec_unregister() from unregistering
the device when the card is freed.

The type is never restored, and hda_bus_match() requires the device and
driver types to be equal. After unbinding the codec driver via sysfs the
HDA_DEV_LEGACY codec drivers no longer match the device and bind fails
with -ENODEV.

Restore HDA_DEV_LEGACY with a device managed action registered before
the component, so it runs after the component and the card are gone.

Fixes: b60ee2e281b6 ("ASoC: hdac_hda: overwrite hdev type to HDA_DEV_ASOC")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20261027083840.28813-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hda.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 46617fc88277e..cae5711e979c3 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -617,6 +617,13 @@ static const struct snd_soc_component_driver hdac_hda_hdmi_codec = {
 	.endianness		= 1,
 };
 
+static void hdac_hda_restore_dev_type(void *data)
+{
+	struct hdac_device *hdev = data;
+
+	hdev->type = HDA_DEV_LEGACY;
+}
+
 static int hdac_hda_dev_probe(struct hdac_device *hdev)
 {
 	struct hdac_hda_priv *hda_pvt;
@@ -634,6 +641,11 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 		hda_pvt->need_display_power = true;
 	dev_set_drvdata(&hdev->dev, hda_pvt);
 
+	/* Allow the legacy codec driver to match again after unbind */
+	ret = devm_add_action(&hdev->dev, hdac_hda_restore_dev_type, hdev);
+	if (ret)
+		return ret;
+
 	/* hold the ref while we probe */
 	hlink = snd_hdac_ext_bus_get_hlink_by_name(hdev->bus, dev_name(&hdev->dev));
 	if (!hlink) {
-- 
2.53.0





Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049969;
	b=p7X/fFDBknRtYysbcyiAWLUZc31kuG95iRSOUPFRCsU6lkzO32Zjvs7wkec+eiu9D3St
	 geFVY9ijskGEt3/p+ILL9VtYVRuNdMyswS8NSMqEqjvk/USGmm2KFkynRCxZOlXDTGzqB
	 U2dwR8DvBNf5e2B2Zxfijz1qZGObEo3rJ+upTustiWV/emCkhVgkA/xQxwTk3f6ZdGvi5
	 2xz1nLNfLdg3ls/sLKVHH8hIYLTX9NfVh3frSlTll+ezMZ3O02xx0YW8X1+mYsAJMSpuP
	 dGXxMC1WGZ1v8viYFJ5AlTmdtM0HUfXl4BHpyflJuwo3C/fORNbrPYtJAltA5XecZDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049969;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+BRlVpAEEN+SAeMVLPVJ+K9udmDh1gGWtDzGvI/bxsw=;
	b=N4DvED83FunzdzLcWW57ORcAZ2ThcSLnBxOewHra42Ycv9+T99hzrqWh95luGvbB9GKk
	 Rvw30erG/tUbCNkR2yPE5liRsTUcGr4kAenwCg+kgsg4PUi4udjyiRf7DOKQn2K0+V9n9
	 qABhIb4w/cNzGXQZPe1HXJkZ38Q1oeKW3Tbqb+mFRDQ3/2qyCqIkJhWJDs3fmSRfMV2pG
	 vQNDGQ/FU9x6AHiyL9lUngQIXu5i6qk1H6avIpIo0XOqxaC9stUTdaQ873jPdQAJ6RUOl
	 x4B5J3nHUFWIXHnRhw3uR10qNWh5uZYu43ZVTBij3p9QZ9E2n2vNKrzsIvLhw5v3mHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8eWU30G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94270606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8eWU30G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A88F1F0089F;
	Sat,  7 Nov 2026 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049969;
	bh=+BRlVpAEEN+SAeMVLPVJ+K9udmDh1gGWtDzGvI/bxsw=;
	h=From:To:Cc:Subject:Date;
	b=a8eWU30GkaOHIBgpBkDKqDsLkMKLavJ3qtBzA8iUUIjw+cUY/ls1z4kXv0UQ1Sy0k
	 Rr6BApCRg7e4nLwwfYOvV8kztZ7p5Ye1yp+Bln4k1nnRq+pQQvyolp2cY9HSFYr9jm
	 euk/720UYlCYx7zng+pi/AuPngZdQM1lN8j5c5uH5K6kcSRKu2Y0g+xkBASUdW2VvH
	 hTGjrZwrO+2iwxGqRv6VecLS8T/YY+/KjnBzX0lErczM+ZqVFhIWgxe+hI+VSsbcoD
	 QU29VC4kqZ87tdDNFdb3wfrTJUPHDo8Raw3bjqzR5rBs/1HsO3DzjwoZrf45qgo5nC
	 Sh6naVRnBo7uw==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: hdac_hda: Restore the codec device type on unbind" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:12:47 -0500
Message-ID: <20261107061247-failed-5.15-08a44bde821d@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 08a44bde821d4fe22c0b6e63da04b3c59ac243a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061247-failed-5.15-08a44bde821d@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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





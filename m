Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050986;
	b=nQnoMI9shWM9Zuks/tEfpayPvmb9MYtMXDqguEf5XXM/Oq9f7l/dbm32SLSZ9Vek+Vr2
	 oK/raQSVIBf0kk0DBDjOBIWisM9HiKFIgeyYp8PE3tMBZMtbe9Gp3F4rfD15+d5IkVo2I
	 0Q/7B0B+lzbXhQS0UnKT8wAx6Si8Xs0VKgqMPo2XgQm8MRqggYt91ueU10L7o1uNkdbw2
	 VPVCBsKwSWO+rWjNi4dEzEevo//Z24e8GPIau4ibn4S7W1/5jbO+47mh7sxC+lzoB/E5p
	 ei9mY/bKYa00uozlDjzQJf4pIPvnLk8CgaabSPqend0KhWjrrLb1nl6Cl/ulb7WBVZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050986;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zfCj9QQXgQU1DnkFjT99Ob+dHzHT1a5B0iRYwS2SVyE=;
	b=n/+yumVdBDND9a/S1sM4N4Ir/wC9EIkv9P4fglzHTq/hDNwJ/vsz88U6O31jhpiCbsIZ
	 jLpNpHcFbSCJ6/496Zmb3br2DA4brykMTXiseWu6HmXeclUilB0hIk34ej5r/zrywXUv8
	 2O2lH/udAQj2KK5vCz2U/horEVLd6yE+1Nga9RR6CCLzM6u7S1m7JrPPN9WWEyJRH10Xc
	 bCzn7gn/Hew+95X8QFAqwf4ztaTZryH3gt7WCoUBpOlVX8PMFDWTn1Sz7wKj+fLfNAhlv
	 Zp6NKcR5BVGcewgLbHti19cF6GWzFdyjQDCPWTt/pHWjZuqNSQRXZIRYl3xBVeJZiYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpOttCsb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpOttCsb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5651F0089F;
	Sat,  7 Nov 2026 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050985;
	bh=zfCj9QQXgQU1DnkFjT99Ob+dHzHT1a5B0iRYwS2SVyE=;
	h=From:To:Cc:Subject:Date;
	b=jpOttCsbmkj2ikLOjBEB/x8+S04h5ZDKb1IGXb5Fid3ZEUusHg0shTS9GXKsBQEZN
	 57+E+dD/rFon+5eRMEF5/WTCWItlAwgB1cqJX4ddc4xWl7QmEY4gtj55NULRe2kL2I
	 7Wg8YUW8B6ttyIugpzyQ9CVH91XZoFLG0Ugrf0JWr7K5WvidS++lVT1UQOtboL0joK
	 rD/+bovwcNg2YgtoGc7PJNDl+vPchFaIC7oA8S0pje+2EzEXy+XAaUW2mVQSC3NGgn
	 AwQin2LMjlzi5hfcj4XzZvukk08/Gp4DPAiPNuqkeTTKIzb36EIb71P5LqBdxZeaxS
	 PzyQpKABpohww==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: hdac_hda: Restore the codec device type on unbind" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:44 -0500
Message-ID: <20261107062943-failed-5.10-08a44bde821d@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 08a44bde821d4fe22c0b6e63da04b3c59ac243a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062943-failed-5.10-08a44bde821d@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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





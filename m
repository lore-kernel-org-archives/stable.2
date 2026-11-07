Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045954;
	b=k22dH7qdl5QySZGEn9lMZ7JBw5vRRhmz4On6kSRYbnjIog/3bnEpFZMmip1t5njnmrkI
	 tVuHF3tUrZ3Fqn6ILU87EYZOTnMiDKL51DGXnY5qbNj0deBocDDkNgEZF0NTjx0rOi+LA
	 THPJ0OdU8y72Lb7AYzb7iPEylzj57MUBR+cEqVuUcoXeQ7JI0ICZtrdyqdZrdI+jM7eAL
	 j6iT0NYgMUG9Lz2CeRgSBdTcInFU9wGgf9pOwv8A4Pt2iuhjpS/qzpve4qXs9lSfpscco
	 hxyeKdTY0uw+3A2pm3qIocsC1NHDnsg2O2YOOMQeqskGY+yiWap5dNIovPWvcb5lA+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045954;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6QpDzk8PLwfsAZJ0C/1fw/7MW+sh3WbbGieBFqJPaE0=;
	b=wfVmUfUUmeMxqchUamhdiLxZaVuNVjXe5R9QA9oS+PMyMvcsc9weFIHoi/eYql+b2Tr3
	 peO62Nut0sfll5IHip+4G142yjJSscutMSM5Vmaqn3CK3zTvKZI5TFi3UpEV8MRVik3GW
	 M80Ll3O05iXPvcSlMXzYg0bzQIIHtt2PyhSZekMnk0LCu2jG7OM4Z3Owo1M59Z0u8b7Q/
	 Flg6Yy9TiHF3q9v92E8Qe9dsv+q2hLuA0ZdPRS9Hw+cKpX1bn+LDuwjpAMWvLcqiWiRj0
	 tbAEuz1aMLhNfZonxLNUzjCx7/0Rlq41+kyCne7qt0eNgeHehkU9yIIiUuA44u5D1xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dW6R1Lp4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C781606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dW6R1Lp4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B8A1F0089F;
	Sat,  7 Nov 2026 10:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045954;
	bh=6QpDzk8PLwfsAZJ0C/1fw/7MW+sh3WbbGieBFqJPaE0=;
	h=From:To:Cc:Subject:Date;
	b=dW6R1Lp4/Y75ypeWG2N/X+wFIuXS+xAvuiJXS7QD0ImWWnHa0jy640HPzp9s+nJHv
	 sV7T4VG+TCrnh8sal0bQaKlh5E41BbPTuDFrlA9n3NFumjvOzOgbzi8llPBEAVZJ8C
	 PqcHrkXZiFi/D5FLnHiBbabK6Kdac7q1Wlj5zVPd7yA1iXIgmoVr5/+qqg8o3J0L3C
	 fnYPZZ8wUrcCaAttbtm8JcMhvBBXzJ1RT4tztJJPv3btQvc72fqrlbJQ1BQ1/RQm80
	 2Bff9OY8LTs7gAPwfaoD+drINohIbiL0qJN/ljDv9oDw4jdnWw5BF6Tu7mOn9ADfhJ
	 o6RgTcPiUyqIg==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: hdac_hda: Restore the codec device type on unbind" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:52 -0500
Message-ID: <20261107050552-failed-7.3-08a44bde821d@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 08a44bde821d4fe22c0b6e63da04b3c59ac243a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050552-failed-7.3-08a44bde821d@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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





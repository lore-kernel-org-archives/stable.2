Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047997;
	b=G/MC08uJsGOWpwDjYShPfSR5aXrZnG81h5ijWpUwqsujKcWpGICcT65U8GbJa2cYjzyy
	 iH0Pc789O5hIUn0S3FxcXM3xYVsT5ZKEr37vFvyFX/oBTD2ZIl6AzRPV/bqSlA0E3X6ju
	 MkJnJB0qMIw3bDThMoZ703C0znW+oMzfiz4kedz/cz0J0870ZqqGnCJ+XULn+p8YEq34+
	 rFXXOSC+24h2T4egUJAqKlQdmep1HAYVeL4/EsOjCmaehHJpVkQiH7Z3SMJg77Coe1/6j
	 sm731mHmK/kK6T7s2AN0hrK3jmBtUA4WvsPXUX59/0+HUGTS2NCJZljwyMtvcHEfMpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047997;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0OX7SKOZlpxaFqexPrmiDT1KWcIj+c9weg8omDqFsoU=;
	b=iL605rPuTe1w58AAQxmF8KN5rFgCDCrYfPpr8neoJSLrawTZR8/7d3zL+xl2NQtKunx8
	 HFzb6x8suaddtc8svhF5drqzDbPfXpiSEh4Z2Wpsahp0f6Qs7Q1olg97z+mj75h+Rt+zI
	 9g9cX2lJlWXNgUDt4xz/HHHtoB4K9aqOnCgJpj6x/slgYjg8/98SJtwsTMJ1teyfj7bIt
	 oX9m21E/AGPKdYtKT47MX1nONyg/Fpi6i3uj5/2zDjWqkSFPiNqhi0tHVEUiD/ZuE9aqH
	 pZsImrkvaqm8sDfuG0M3/4wC1gGnVRAo7Y6nSEv0VjvdnWN8Ngcig4PTWgg1/zMy3hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsfdxtuF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D6606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsfdxtuF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D2F1F008A1;
	Sat,  7 Nov 2026 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047996;
	bh=0OX7SKOZlpxaFqexPrmiDT1KWcIj+c9weg8omDqFsoU=;
	h=From:To:Cc:Subject:Date;
	b=lsfdxtuF8Sb9qb78o3iGWLzDHKnL5HPoS/AONZ6HGUwyemqePQQHD1yYRiU2cWOQC
	 h00DT75L/XTtZzwerGWsnbctUJs7jYEBoW/dfHXOo8Q4lmRaUpWArsgvla5fIFTtZE
	 r5z7L8J8TPc5Wi6M48hy1YsjqxLUKxFUkWd8sX4Jqt2mB5uh6nxrWrJfWbNX4qSiCq
	 OhBwwZUqusXNJs85fquf+atbzhRvNdRXgFmlZn6Gr+NSDGcuyRzfSPaGGTMIKYhaYp
	 FzhM6FCMawG/p0H4ngY7yGQQ1/sGHg8h0xxIXVwRc+hX8gM8Sg3JEbhawBL0YwP36H
	 BEwSriHb+lgcQ==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: hdac_hda: Restore the codec device type on unbind" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:55 -0500
Message-ID: <20261107053955-failed-6.6-08a44bde821d@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 08a44bde821d4fe22c0b6e63da04b3c59ac243a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053955-failed-6.6-08a44bde821d@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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





Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047229;
	b=G+eCacCssWW+ANUI4w2mIvs6D3f4/12BVHtIfZNC1mWeFwXAROYe/o+UbcETenp4cXvn
	 SeK8eMGWhMFvXjj8tOGYmtKOSSaxIUSbyXjc3cM84PbEteieZ3U2V82AQz+o9AocUrgeP
	 9hE49FMO5eDnZl5qTYqWsIYmWwlAuySfWs37X8yYW1yz9PBgZxb3WnnhQtrsJrPfWYcwq
	 fNp5fQwYEUxqxYfAfr3MQa1DIvn26TgK/2CCDGN58rLfJVq7voa3bh06qRE6yie8ZXUp8
	 x4CVwIWTYj9ql32PZZCwAviO4GpN28uHvQUdn0FNAfz05cUBwvlbtZdAc3Q/pXklHdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047229;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kFiDDPn3f99/GkE/NmjGqQQ9anmJPjzsCf78+b8Rb6o=;
	b=ZvRlNbWGPrNKJzbdkStPhZb3a7H6cEp7RBr5rG6drWXNadOnL1jXPLJ/O72mljKR6wLL
	 6Fa7MlGvyqF6Kv0OAbbhI1xV7DHv7BbZXXLJK+IoAFExYUjmVA/K4z5zY/XUmbvLJvxGz
	 LrtosYJ75fVTlD4L4u1YaZ7jIbXNzgqKYWTRELto9CyEDqOYD40MulRQoa1S1IY7jF317
	 0bQPO3gIVXv3SAUrqtrklNFWj9xruHwAZGe4wn/E2doVwvxCQz7Qf1komG43a2GM0tuIL
	 G6T9b/QJzqtu3IaYlXIiZIMGjI0BC638YjWidV5VeJyk8k8e6pdiBfAxnR4uHPojWlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Wz6q/VVk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEDF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wz6q/VVk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7171F0089F;
	Sat,  7 Nov 2026 10:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047229;
	bh=kFiDDPn3f99/GkE/NmjGqQQ9anmJPjzsCf78+b8Rb6o=;
	h=From:To:Cc:Subject:Date;
	b=Wz6q/VVkdleWowRefeugIBta4PQWMoJCD8p2xx8qc2Fn3+5dmDLqoQh0YqQgvNtQY
	 A7WzfnCFSUabxx4JmwIDSdpUzK1vO3y2CPMqqhoQnd06OU7JXHfwjEG5wcQ4KzOoNd
	 6pU5PAgwbkw9l/Ddnb90/+9UB0mtfxTGRm4kt3xUxZhbuWz6bPvyy4OhLT0a7QoWeN
	 YNKolFfwVVYHUJA52kNRrkhRJhKl10aRy2o4WVNipsJqAVVC6yWQ6rbSrHWtwI/hiq
	 mw9YnPDEEmtkOw6psQDbR8UunqIH3B/WjySb8OJXtEDHCNRm/0dOoyOq/Ve0aGVWKA
	 f7XRrebr4DE1g==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: hdac_hda: Restore the codec device type on unbind" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:08 -0500
Message-ID: <20261107052707-failed-6.12-08a44bde821d@kernel.org>
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
git cherry-pick -x 08a44bde821d4fe22c0b6e63da04b3c59ac243a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052707-failed-6.12-08a44bde821d@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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





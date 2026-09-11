Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61DC3D331A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123295; cv=none; b=Uun2QA4Yievd7Gs0lkFshU0HyUKwhY2V3g6//yP6aLWciWAH8JeA+HnI6VZpzDtSUPppAkhTdnvFnO+OZctnyK8R8iVQeUox/p0UAEU62a3yUmiC97Dt9oF9GSNAGXrM+y5aCo9MP1gMMxy2uSy7QpjcFuBYF6CMdds+aFJxX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123295; c=relaxed/simple;
	bh=IeYZd2VeEb0yzwT9GTpxyfuf0tzgykmEtu+Y39STZ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUtiWGenFaVSsnhO3OMpQPgs23VffSkLELz7i2NgsuzcMaloI+ma01Uq9EZmqz9XE7NWR0/JlxQv05HuW1Kri1ERfzbf044ZybCu+LrRIkvh7kmPi2DM0T/9meECpDII0ufD4dArsEmReBy7AtrAvZ2tMGB/PLF0GQymD5qfYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQXBc1vZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQXBc1vZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB761F0089B;
	Fri, 11 Sep 2026 10:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123293;
	bh=I6DBDXV/7/BTyHLYJGXjT/c4ihTRK1oRB4CoXn9Rxag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQXBc1vZRN0wzv3OTOqwxH0/U5e6LtbVZvyoqH6Ckf8diqP1KOt3caCdn4/5gnbff
	 D2GjslunCWg8xuXSX75o/80RvTqcj02Iq1cnNOIJZp0kZ1NL6DsZq09bakqZPES4Ya
	 XIA3zq5NqLJTdfG1ankvRPPngKDpqrGFFW+qvbjTK/6vomO4m8vPMhi+IDFt3WZSpx
	 kPDcpC2W5YfxKP040MiCaUFUpoiNNK27rk3/08cP4XkpqOQR6XrcCzxRGfezzqTiIr
	 bM4UfZch/hUlu5AFi/moGbddf8yEZLbHMqFleOxkvE82juRucrHs0p5slxxyI7R8Uh
	 85luY5N3gVqgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] ASoC: Intel: Skylake: Introduce HDA codec init and exit routines
Date: Fri, 11 Sep 2026 06:41:27 -0400
Message-ID: <20260911104130.193213-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104130.193213-1-sashal@kernel.org>
References: <2026090904-antiques-gallantly-338c@gregkh>
 <20260911104130.193213-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit e4746d94d00c52918461bc169e009b6784a38e21 ]

Preliminary step in making snd_hda_codec_device_init() the only
constructor for struct hda_codec instances. To do that, existing usage
of hdac_ext equivalents has to be dropped.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220816111727.3218543-2-cezary.rojewski@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 6ad4892c4f5c ("ASoC: hdac_hda: Fix hlink refcount leak on component registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 46bb3b8bd5afe..e0987e2f39301 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -689,6 +689,35 @@ static void load_codec_module(struct hda_codec *codec)
 
 #endif /* CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC */
 
+static void skl_codec_device_exit(struct device *dev)
+{
+	snd_hdac_device_exit(dev_to_hdac_dev(dev));
+}
+
+static __maybe_unused struct hda_codec *skl_codec_device_init(struct hdac_bus *bus, int addr)
+{
+	struct hda_codec *codec;
+	int ret;
+
+	codec = snd_hda_codec_device_init(to_hda_bus(bus), addr, "ehdaudio%dD%d", bus->idx, addr);
+	if (IS_ERR(codec)) {
+		dev_err(bus->dev, "device init failed for hdac device\n");
+		return codec;
+	}
+
+	codec->core.type = HDA_DEV_ASOC;
+	codec->core.dev.release = skl_codec_device_exit;
+
+	ret = snd_hdac_device_register(&codec->core);
+	if (ret) {
+		dev_err(bus->dev, "failed to register hdac device\n");
+		snd_hdac_device_exit(&codec->core);
+		return ERR_PTR(ret);
+	}
+
+	return codec;
+}
+
 /*
  * Probe the given codec address
  */
-- 
2.53.0


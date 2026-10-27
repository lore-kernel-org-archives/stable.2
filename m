Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086084;
	b=eT7ltquczsjW9w2vWP2T+FJseLF4KKdCdVGwdEKUHR1V5Fyb8TsC7Fh+mEvJUYwMELa4
	 rvB67xAO/oHl//nwCsI644/NdGPQxDLXR0e3h5HDq6JzV1rXyFT6aCs4tInKVUVRufysx
	 OH0fJFaeHN0VohKyqTwQ+gIDAGoB0jPfET8S7qwcWAyz/GhYfkDskHF99QLDo88k2SRsI
	 nK3B1uEZcqk+XQHoPYXZoEsryqaLNjRcb42sm2vDO9iRxF2ueD/7Xx88SC/v4sy5c0L+/
	 65KeTNrKKU740wBAz3O4+N3jq5kgz+pXJNOpp8DFuiLxitsPx5LbTlhPtlGmB406ztA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086084;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=75wm2YXIbnVl/fubtg3fdM+uDzx3qHo4YEnJtcWiKm4=;
	b=c7UbQ5//4HWh8oH6nyG3Yyd2wHEggegu0FPaNgCCHzF5qyDV5hheEiu8sbuHwzF3lIGQ
	 0PC3pB4Foo6CM7lntGW1uVmJ80Hdc8d+pkkeGI/0fa+s1lBoLcL44fgzJjN39csuF8l/b
	 vGB0F80Fk+U/fnkiPlbDr7RDJIMF9tlDHl3I/w/OvJTXJHv6hWPlwsW//rT4+U3sEx413
	 1PZcVfMcB9JR7NfGh6TGlAHGMQu9SugWQ7koW2mmJRfl4riCWLhYgUg5hc2zFRaSMbplR
	 PRCPC8PQMWqp7vbLRy9lAiTk7dFEf4TT+QhF6xqa5umZXJjSth16T3zJBUoG2gCCLqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kJzKoBHZ;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4056606A31A;
	Tue, 27 Oct 2026 07:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4056606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kJzKoBHZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793086084; x=1824622084;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ojcxhNeVeVICdAY5qjSxhvWpD1dTM7HZlQRTbE6sk/8=;
  b=kJzKoBHZha+gH8hfQOIGvvdumrC3CBMnRGEsmPLS6r+Nn2NA0Gc9q0ie
   iSa4bEiP5UB14ulfFox2cPgU+NPBlnokbiq+obNZY70CILmWWNrxqEw89
   6Er4sJ8Cz1+50DCGU+P+037bIoT8cQ8x4dkNbBFEVBGVMt0L6PYmSMjAC
   jJZs/qp5bmkLOKNGsmfxpUJ4lfVl7GOd6CBbqvSnaOCzbNpIe7kfGGyoZ
   MQtf3GVGRpXkTkuF8DskPRV2s/oQsJxaAfPlDZ6GfXxbfyU3AG3mlg1kF
   7GJVQKrGBx4Lln4mHdZ9VTA2TIYY+gQvleXYwaoL882cDE3PA979qSaoS
   Q==;
X-CSE-ConnectionGUID: yscCaXELQeulQYLeImvI1g==
X-CSE-MsgGUID: ymzvQ31eQXOe4JkNgqvH3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1807937"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1807937"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 00:28:04 -0700
X-CSE-ConnectionGUID: oNAP/canRX2X1kyU7wz8xw==
X-CSE-MsgGUID: eeqU9LayQhaVHOKLDcvusA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4514188"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 00:28:01 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	cezary.rojewski@intel.com,
	kai.vehmanen@linux.intel.com
Subject: [PATCH] ALSA: hda: Reject codec reset on ASoC (ext_ops) buses
Date: Tue, 27 Oct 2026 09:28:35 +0200
Message-ID: <20261027072835.4796-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
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

Writing to the reconfig or clear sysfs nodes of a codec handled by ASoC
(SOF via hdac_hda, AVS via codecs/hda) hangs the writer.

snd_hda_codec_reset() sets card->shutdown and calls
device_release_driver(). With ext_ops the driver unbind unregisters the
ASoC component, which unbinds and frees the whole ASoC card:
- snd_card_disconnect() returns early as card->shutdown is already set,
  so the card's child devices are not removed and snd_card_free() waits
  for the card release forever.
- Even without that, freeing the card removes the codec's hwdep device,
  which owns the sysfs node the reset was issued from, deadlocking in
  kernfs while waiting for the active write to finish.

The legacy HDA driver keeps the card across a driver rebind, ASoC does
not, so the reset cannot be supported there. Return -EOPNOTSUPP and skip
the misleading "codec is being used" messages in the callers.

Fixes: 6bae5ea94989 ("ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222182
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/hda/common/codec.c | 6 ++++++
 sound/hda/common/sysfs.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/sound/hda/common/codec.c b/sound/hda/common/codec.c
index 31e5fad78b0f..e367cc1c6e78 100644
--- a/sound/hda/common/codec.c
+++ b/sound/hda/common/codec.c
@@ -1807,6 +1807,12 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 {
 	struct hda_bus *bus = codec->bus;
 
+	/* ASoC: driver unbind frees the card, incl. the hwdep issuing the reset */
+	if (bus->core.ext_ops) {
+		codec_err(codec, "Codec reset is not supported with ASoC\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (snd_hda_lock_devices(bus) < 0)
 		return -EBUSY;
 
diff --git a/sound/hda/common/sysfs.c b/sound/hda/common/sysfs.c
index bedf10b30885..bf65223fde10 100644
--- a/sound/hda/common/sysfs.c
+++ b/sound/hda/common/sysfs.c
@@ -117,6 +117,8 @@ static int clear_codec(struct hda_codec *codec)
 	int err;
 
 	err = snd_hda_codec_reset(codec);
+	if (err == -EOPNOTSUPP)
+		return err;
 	if (err < 0) {
 		codec_err(codec, "The codec is being used, can't free.\n");
 		return err;
@@ -132,6 +134,8 @@ static int reconfig_codec(struct hda_codec *codec)
 	CLASS(snd_hda_power, pm)(codec);
 	codec_info(codec, "hda-codec: reconfiguring\n");
 	err = snd_hda_codec_reset(codec);
+	if (err == -EOPNOTSUPP)
+		return err;
 	if (err < 0) {
 		codec_err(codec,
 			   "The codec is being used, can't reconfigure.\n");
-- 
2.56.0


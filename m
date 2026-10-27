Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112385;
	b=EyUpMESW6xUHBXWlt1elUltPbMIoG8FJnCsYjQ4MG4BwyvzHLyRUHwP+D8AOCYWedEag
	 8CWLUnLyIP+mQpzCLixCqjbZ3mhcIvnGwbyDkpIJITFTXUtuyyvmiZdl3qpYzXBbGHXaE
	 NxDjd+Vbgq2+xpZtnDWjCgmvfZFltsZTP9+kEV4XVSjvPq7tXfnOU/3kqsNqGR1K/PU3T
	 NQt9ZDjQAucJJCJgtc0eOncbOMewlDOU42YhH7sXt1HVcF6sm7OCcdRQrI+6do0hQnGuA
	 mqlR3JIjBQAwZ1SumIFxFLdoGl8XMPF0j2gN+NRpxdwF2ri3rnwq3cA0TlIMh7E7b8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112385;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IRYscKx8sG7oBga7um/aSNX4ppGTBUA5j7SQ3A1vxDM=;
	b=NgV9ADsfWVLObArXVvowzHnkR3GsaEwXUY2XZFyLEqDfQ+7tYyU39rISTerM2+J6ISbf
	 3A7BSXQpgGEYtcNq3kPRkaHGr5NdzBM5oMjTGJUusr3IBxHnrkC93IiI3Z9P3uuJ/aLP4
	 cPjDwACbpcT4IihAV16vzzZBFfeuGc/SZFNojFTvrccr/y44seFLQlIP70R+oOVToHaDM
	 H610OdXDPk1keA/NG2cJbsB7Rz+nt9BtS5XTjlvw4B9mCNhyMFm2gymueKs0ZlsBKSVSD
	 lF7vJGTOw+zJK2CwXFiFimdnwhYtOB1vm7hYK8zCcZjv7H0DTu5kfsUDPMIViqAohig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CGwLvwcP;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4EC606A31B;
	Tue, 27 Oct 2026 14:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A4EC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CGwLvwcP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793112385; x=1824648385;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gMQLtPPJ2JHiqxtyX+cp5DoM6/NIF/m1eiqWp4AjPs8=;
  b=CGwLvwcPz6RI3pyk+Mj21aFENE7JyDEqgPF5/6jyMyJgfWcbzfjVl2JB
   RztYv8WBV0kh0kdCEz3av1Vk6nqFe/BEXnfF58wLy2qvFcA+YifWJWq4b
   WBfdv1L9aQx8UC/VGmvbf5rN43R1AusdHWvh9Ae8vp/V/tA1ibVfhBY/E
   mBWl/1G+DQIHTWb632JCQShIspq/rjyh2ZnhtnNF7Hg5jJDlskhLNoYOo
   CTKnVebK8IKpndBSi+UARIyGdfHHa49RIPFerl7egAPz/qICbdKJuSaCN
   S6yB3PdyuW12m0v0A1tGJ4mV3Gk+RDOGc/qx2mw/OHzQTJYZV1rgqGjEa
   A==;
X-CSE-ConnectionGUID: +DdlmM44QfiPecPLXMuThw==
X-CSE-MsgGUID: Tms5wl0mTDCPpWd2lDPmzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1700278"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1700278"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:46:23 -0700
X-CSE-ConnectionGUID: cZDerJIdRniypspQP79I/g==
X-CSE-MsgGUID: DYQzslGQRaaARrm1oqqX7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4960476"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:46:22 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Subject: [PATCH] ASoC: hdac_hda: Keep runtime PM state in sync across codec remove/probe
Date: Tue, 27 Oct 2026 16:46:55 +0200
Message-ID: <20261027144655.31988-1-peter.ujfalusi@linux.intel.com>
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

After the codec has been removed, its runtime PM status is
RPM_SUSPENDED while hdac_hda_codec_probe() powers the codec up via
snd_hda_codec_device_new(). The pm_runtime_put()/snd_hda_power_down()
calls on probe and registration then see an already suspended device,
the codec suspend callback is not called and the codec, its HDA link and
the codec_powered bit stay set, preventing the controller from runtime
suspending.

The remove has a similar problem with the codec link accounting:
hdac_hda_codec_remove() drops the link reference taken in probe without
looking at the runtime PM state of the codec. If the codec was already
runtime suspended, the link reference has been dropped by the codec
suspend callback and the remove drops it a second time.

Resume the codec in hdac_hda_codec_remove() before disabling runtime PM
so that the link reference and the codec_powered bit are always in the
same state as after the probe, and mark the device active on probe once
the codec has been powered up.

Finally mark the codec device suspended at the end of the remove. Its
runtime PM is disabled at this point and if only the ASoC card is
unbound (e.g. by unbinding the machine driver), a following system
suspend would otherwise call the runtime suspend callback on the already
cleaned up codec via pm_runtime_force_suspend().

This is a followup patch to address Sashiko reports.

Link: https://lore.kernel.org/linux-sound/20261027083840.28813-4-peter.ujfalusi@linux.intel.com/
Fixes: c3ec8ac82105 ("ASoC: hdac_hda: fix memleak on module unload")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
Hi,

this is an incremental update for
https://lore.kernel.org/linux-sound/20261027083840.28813-4-peter.ujfalusi@linux.intel.com/

to address Sashiko concerns and validated again on hardware.

I think this is the first time the unbind/bind was used for the HDA codec
with SOF stack, so the real world impact is low, but never the less, it has
been broken eversince hdac_hda is used.

Regards,
Peter 

 sound/soc/codecs/hdac_hda.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index bd4b113401a8..48eb95973b7a 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -514,6 +514,9 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 		snd_hdac_display_power(hdev->bus,
 				       HDA_CODEC_IDX_CONTROLLER, false);
 
+	/* The codec is in D0, the status is RPM_SUSPENDED after a previous unbind */
+	pm_runtime_set_active(&hdev->dev);
+
 	/* match for forbid call in snd_hda_codec_device_new() */
 	pm_runtime_allow(&hdev->dev);
 
@@ -554,6 +557,12 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
 		return;
 	}
 
+	/*
+	 * Resume the codec to have its link reference (dropped below) and
+	 * codec_powered bit in the same state as after the probe.
+	 */
+	pm_runtime_get_sync(&hdev->dev);
+
 	/* prevent runtime PM callbacks while the link and the codec are torn down */
 	pm_runtime_disable(&hdev->dev);
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
@@ -565,6 +574,9 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
 
 	/* Balances the disable above, cleanup_for_unbind keeps runtime PM disabled */
 	pm_runtime_enable(&hdev->dev);
+	pm_runtime_put_noidle(&hdev->dev);
+	/* The codec is cleaned up, system suspend must skip it from now on */
+	pm_runtime_set_suspended(&hdev->dev);
 }
 
 static const struct snd_soc_dapm_route hdac_hda_dapm_routes[] = {
-- 
2.56.0


Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A613B058C
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019483; cv=none; b=DOAMgZagzrWrDiydjx4Tnme52fbyAgg8DLNnXmI9PoUQ0Y19lPljorsBs1ce311EJohNAdxJhneFc5KdIzwHSssHT99zIjsRVmG0gGEubjUVLkG+co5aY+CF1YgNOYp9P9m8vLsp5WgSSu4JXXfsDntlkBFTpb5ezuhs4K1tghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019483; c=relaxed/simple;
	bh=+WF0ufBR+LDxG6agMdm+AutmEyBysbg4FlgD0FxUJno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcSFSrE2K53z3yDZRCxyeZ3azW7Jh4rSNpngeHuTJ/PALEcZMTmEyB7N2xfuWI8tdYKp39fbxXM1zsXE5dERVgjnLqiqZ59JDWt9oSKsngqJU7gXJW3vNZMAl73lt1rLAFr+ue2LTwEJR5qwmAr9ivorFLfPCtn1qhxtNX44xVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=FXPGgt0d; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="FXPGgt0d"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469d249c5so2791987b3a.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790019480; x=1790624280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=38v0xzft1ji55CfZ4GZ3Vuw4C0dyByFRbLq8VXUI3wE=;
        b=FXPGgt0dasQYyN6YhoBLWCSz48K8rrRt2vBB6iUHEyNR8AkBXXz+SCYjegWzbT8fm6
         8FEXRttURSbeoZFgBfUzZavNa6aVi/OezKOStwE4M3P0VYFXjvv6cx4yaehvtogEe2va
         YisId50a7HYmsapPIPcGXrVB6Lo6OS+xEEcGTP+d1M59/AYLS3chAJKHXpHQzPD9t9Zl
         R+kxBdTvlr0SW3E2Y2/5PLVcJxRwwBYpZXj3KG+OEn1VNqH/HwUn5bMWR/4yIKeouYfK
         tAUzRYvp+9bMmU1A1Rgwgq1RbD5y/vL8AdjEwmR23gNR7F06NuCJp5JLk7ANluJlXW11
         IW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790019480; x=1790624280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=38v0xzft1ji55CfZ4GZ3Vuw4C0dyByFRbLq8VXUI3wE=;
        b=LXNrzJ58m/3wUsG5EUZjqxZiLW5Q3ctHLJD2+EPigZK9Nap7P7cXhjmcT6UqRBiSZk
         kHIPfLSBN+QaZgWJCSwJmdTF70sJFzvtJMYw0oYECbKI5m0Mg1XWl0WN1srz3Hgv2jtT
         I97sr/1Dwp+e+1uNZuGRHLe5kOUIDp/XLj1P1q4gtup73XsYGilrVEtBpR0C1QmWEl9w
         jnhMfLXcR1wr5vtzjfPJt6sPDJQbHyo9+zhiq1Se3v5agJie5syD6LXyiOnHXU1K9Eh1
         k5hi/d/XEgQ/+kA/QID5PnOnhcrZA8VAvSR0teOwQWgZ1DdGTlUQdC8D87HFQgj6xaoP
         gzYg==
X-Gm-Message-State: AFuF++nI87DFuKXLsXdLapz5NN7c9D6cXhP10gnOEgdCbzp1HySdRssG
	e/tJxlIcp3ep/Gn7mg4sQVRi7++VF/jN12s48Q5Qe1RXokuCOwEXqrnF4ps2Onc9aRoUn0Q/8H6
	xzL1rrJ8=
X-Gm-Gg: AYBFou04lQK50CCuHyecxppqdjgPCSZ6yxHiQ+SxYzYCAls1BeJLVoFl/Ecow+wvgLE
	/Cf1LZmsKXDpyLEhdaPSZeJ1cKJEyBdlCFqGHHZlQYJik6BFjfi3AabBY53pJle82zhxmdOfDmJ
	BSbzYkO4zwV3Z0NNxZi+W2a69r3LUJTs5Vmt+s+CAPxsP1GeTwnDMInO5HeHO1uXxp2//DDf2hT
	5IIcgvHBydK5EbEAeZR1you+5YgxmvQMK7mX9j/k67WIr0dV4EfMF3VCFIvh1gZ6L1StYIR0Xg+
	sz6MHpYyAx3E2lP+MLpwhw+GiDyelfEsNyIorhnLx1k6Q2l4t7XIurskL6zNLkK4QB9kXJKhuV+
	iUIIbLoPU1lYeRtP6bvi85IiLEMwGYpE7xpax+B5BfbVvO0xqqcxDfmcrK9nblwaIWR0kSpXmUp
	bX5iGSid9OuzRywH5fPoekJ5mzeNq3dCNLkAPytP+6J6WcyfXgVMtr2eykiBeP/Jgmq2eMwu8a0
	D+fjjqOWhZNI+PKjB0k+elxEIAuDhJiDPOskbzeOMcdMqR/fqe4DIidT+gYfs7loY0HgGk=
X-Received: by 2002:a05:6a20:7289:b0:3dd:a196:5393 with SMTP id adf61e73a8af0-3dda1965464mr11523095637.53.1790019480599;
        Mon, 21 Sep 2026 12:38:00 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:289a:f600:f11e:a45c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e5ebcdbd8sm288500eec.16.2026.09.21.12.37.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 12:38:00 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH 6.1.y 1/2] ASoC: SOF: avoid a NULL dereference with unsupported widgets
Date: Mon, 21 Sep 2026 15:37:47 -0400
Message-ID: <20260921193750.82134-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921193750.82134-1-artem@trailofbits.com>
References: <20260921193750.82134-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

[ Upstream commit e3720f92e0237921da537e47a0b24e27899203f8 ]

If an IPC4 topology contains an unsupported widget, its .module_info
field won't be set, then sof_ipc4_route_setup() will cause a kernel
Oops trying to dereference it. Add a check for such cases.

Cc: stable@vger.kernel.org # 6.2
Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20230329113828.28562-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>

[ Backport to 6.1.y: although the upstream stable tag names 6.2, the
  same module_info dereference is present here; the source change is
  otherwise unchanged. ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Stable submission note: patch 1/2 in the CVE-2023-54233 series for Linux
6.1.y.

CVE: CVE-2023-54233

Build: This patch was included in the x86_64 allmodconfig and
CONFIG_WERROR=y build.
It produced vmlinux and 9,075 modules; the same four baseline objtool
notices appeared, with no new warnings or errors.

 sound/soc/sof/ipc4-topology.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 49289932ba7e69..9540ba6ef659e6 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1600,6 +1600,14 @@ static int sof_ipc4_route_setup(struct snd_sof_dev *sdev, struct snd_sof_route *
 	int dst_queue = 0;
 	int ret;
 
+	if (!src_fw_module || !sink_fw_module) {
+		/* The NULL module will print as "(efault)" */
+		dev_err(sdev->dev, "source %s or sink %s widget weren't set up properly\n",
+			src_fw_module->man4_module_entry.name,
+			sink_fw_module->man4_module_entry.name);
+		return -ENODEV;
+	}
+
 	dev_dbg(sdev->dev, "bind %s -> %s\n",
 		src_widget->widget->name, sink_widget->widget->name);
 
-- 
2.39.5


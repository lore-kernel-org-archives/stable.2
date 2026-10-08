Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0253C1404
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486083; cv=none; b=WNBJp42cSLXEZDfeyCmOzwj3OHBRXQQ9w3gIXAjcDVjNfbN54ivFejuCACDl5aOKQLyEL8uuvZbJWJFqpHyTnaTl1QZZLr9CpoBLrS7ZWGbcXFtCT65bmYZ/boXfjU43dRbJSx7p3YBNpXRYkzxK5OYyb3NFAj0t/6CTk/2EnuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486083; c=relaxed/simple;
	bh=dI/ediDEtYW1zJEmi2TVBHlg+BaG4nXKtBtA6rC2rD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+1IQuEUahkM2ZnMruxw4ZEXBl5jpj2lOB583Z4XMn4KvNmJyHDrE9QCw7SJrkyzpztFXY1m91STER2M1RPX+3oNLOKFyp0Op5iPJA9SlNd71xCpgMdMBML+OPxIhm3kLmKK7BHrpfH6PrD/x+E8utYw5erojssKwNCRQ+BTvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Zv5xF3Wk; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Zv5xF3Wk"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33c2520ad38so8022896eec.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486081; x=1792090881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wH0vSAnuTtk11qs15jI11qzpg6PrfnUwzzqFGPyRMD0=;
        b=Zv5xF3Wkd20FnYuORrKy04mz5wMYsFBJ+7jgdNI/IUKP3WuIcRidiv0nziZ9eklelf
         m4oZPV4Ns24RxBDd9lgFS3gX+W2EFGdSiEWcA9qa3jZPRxFDWh3Ll/reDSr+31j6ufca
         fm/ndCCKJgFKWNshElzNnrJ9mog0lRqDBZVRIs/odfEMVE5BBsv/WOFur++/QWGGsgFL
         kjkwkyO3Sma/CZmf9mfiA7FqTyGLI/aGNIOLsYXfw7Rp8rNcUSnQyvTBJE5oyObM2gLM
         ccQ+uJJ/CKGvyTH4jwh+edS1HbO/1IUt/YxBamCaDnygjbxRioEuK1thl/iT9X1X1/HM
         9IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486081; x=1792090881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wH0vSAnuTtk11qs15jI11qzpg6PrfnUwzzqFGPyRMD0=;
        b=DdJ31zItX6IgMmKWT6/F2Ut2yjUITHLnHCxn8dh9ZE8fAQgtLLpdPq5zRCfWX8kI3K
         rOqG3w/YHz4bZ8AXK2lhCgtMZ+IXi2JSNGhh0R23haO0RMjBgldivaG4zq9QDurwqLNC
         QJ7UT0o1LyF0cWrs5jqEqOnz3D6ayXAGxiOhKSAxIKGorNs0WIq6RnqBlj9fT/nM4tbG
         5LaDGXkz/ybiofoY2dYjFgSNmnD3NptRzLHE+N1e7FEARYW5ME/Rx0wcyTBzPFiz/19P
         qbkUQfpMmlHFRyBRef7AKoTm2bbL3Pc2Wlo3snIcNJI+rEYI7tZZPCez4P42MKsmdwt0
         myQA==
X-Gm-Message-State: AFuF++nZY6o2NLv76IPN8YaQAbHF4VIxjNMDqhBVZfuQveh8TXmI0KBz
	/oTeorjI8iTAGYk7ycYxHAiDp3VTJoDOCupHYGQRta/c6bXJMsXHfau1S2ExQHiIOL0noAqZVCO
	cixqD61IgIw==
X-Gm-Gg: AYBFou2AwOKvs/5t6MZzib0R81/brU3TZ1BDYAGl7iewMgJogJnLyNrWk8yum9897wo
	P235F3MyBtchiOydYbsr4jvNZXUisfpThgfFKPL1lWCfIphHelgeplpaQou8OAsx5U3sVyIvWCa
	x2D0/9F9bvPtmGHnJvADDTBkoO5mNBVJ5utSCus9NmLDSoLT/miv5Eo3+YHlFFCltwviT/+NmRV
	azeQSf5W/fCejCnPWFm2zdhIXwY00CZQjjxM6DNbTCTVDIiqWjAG3fgi8MIThIGKBAHqDVoYt3L
	FGIuEOTjuGYyj+bkKTMw82p4FYEEEpQ82FQIGzBkGLQDs4HKE/vlxVOe0Dp7l2Aaa17m2jM2xsw
	O74SGha716dEVD/h/eLQy9TJBjjmgGduXCHV95Z0aAosnYp7jQT0iXd2JwUHgfQ8/92q3uSQ4Ga
	YQmJEbL7CH+rquffduFRFlOyTQZMaHBlpguTcsi2HhZdo8eWMy7udP6pq6XyEk/XsqgruSWitSw
	3amGh4pWAvdyAeBKpGa8+a6blE3OjS3WUUh/zWWVvEkXImORHH62qi5Qm27ZvNBOP/BRyE=
X-Received: by 2002:a05:7022:2513:b0:14b:1e78:a19f with SMTP id a92af1059eb24-161fdbedf4bmr10042490c88.6.1791486079633;
        Thu, 08 Oct 2026 12:01:19 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537b3eccebsm405691eec.12.2026.10.08.12.01.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:01:18 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH 6.6.y 2/2] ASoC: SOF: ipc4-topology: Harden loops for looking up ALH copiers
Date: Thu,  8 Oct 2026 15:01:04 -0400
Message-ID: <20261008190108.96660-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008190108.96660-1-artem@trailofbits.com>
References: <20261008190108.96660-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 6fd60136d256b3b948333ebdb3835f41a95ab7ef ]

Other, non DAI copier widgets could have the same  stream name (sname) as
the ALH copier and in that case the copier->data is NULL, no alh_data is
attached, which could lead to NULL pointer dereference.
We could check for this NULL pointer in sof_ipc4_prepare_copier_module()
and avoid the crash, but a similar loop in sof_ipc4_widget_setup_comp_dai()
will miscalculate the ALH device count, causing broken audio.

The correct fix is to harden the matching logic by making sure that the
1. widget is a DAI widget - so dai = w->private is valid
2. the dai (and thus the copier) is ALH copier

[ Backport to 6.6.y: Apply both widget-kind and ALH-type predicates to
  the target loops; the newer node_type local is absent and unused by
  this implementation. ]

Fixes: a150345aa758 ("ASoC: SOF: ipc4-topology: add SoundWire/ALH aggregation support")
Reported-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Link: https://github.com/thesofproject/sof/pull/9652
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20250206084642.14988-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 2 of 2 in the ordered 6.6.y backport series.
This change addresses CVE-2025-21870. Limits ALH aggregation searches to
DAI widgets of ALH type, preventing NULL private-data dereferences and
incorrect device counts from same-name non-DAI widgets.
Each loop checks WIDGET_IS_DAI() before interpreting w->private as a
DAI, then checks SOF_DAI_INTEL_ALH before incrementing the device
count or accessing copier data.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.

 sound/soc/sof/ipc4-topology.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 18096aefce13..8911c075251c 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -577,10 +577,16 @@ static int sof_ipc4_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 		}
 
 		list_for_each_entry(w, &sdev->widget_list, list) {
-			if (w->widget->sname &&
+			struct snd_sof_dai *alh_dai;
+
+			if (!WIDGET_IS_DAI(w->id) || !w->widget->sname ||
 			    strcmp(w->widget->sname, swidget->widget->sname))
 				continue;
 
+			alh_dai = w->private;
+			if (alh_dai->type != SOF_DAI_INTEL_ALH)
+				continue;
+
 			blob->alh_cfg.device_count++;
 		}
 
@@ -1692,11 +1698,13 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 			 */
 			i = 0;
 			list_for_each_entry(w, &sdev->widget_list, list) {
-				if (w->widget->sname &&
+				if (!WIDGET_IS_DAI(w->id) || !w->widget->sname ||
 				    strcmp(w->widget->sname, swidget->widget->sname))
 					continue;
 
 				dai = w->private;
+				if (dai->type != SOF_DAI_INTEL_ALH)
+					continue;
 				alh_copier = (struct sof_ipc4_copier *)dai->private;
 				alh_data = &alh_copier->data;
 				blob->alh_cfg.mapping[i].device = alh_data->gtw_cfg.node_id;
-- 
2.39.5

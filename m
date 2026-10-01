Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD24AB1A9
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844755; cv=none; b=Id6ut8wm2VhGvF297JoRa0SR+fO5TkiZGAkhG3za/g3a58uGKjO3Owu+YO7MfXnu3sVotP+tNigoHI7NYwSbTUEN3rqhE2IZZXQl/3NztFHuSMiirfBnPeXidDQSnzyUx89H+klbi8Oy2ejf4LUpbEr6AFg5l+LOaYmFzG0NrI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844755; c=relaxed/simple;
	bh=nmF2VGSeyFyu/xPgi2xOG62Zmzti/5jSYKINhvSPvGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2KJ3Dfq3GzCEqwymiZ5FTQR4Trl3wgFpiZKbyd3tWVF23rkOvjRoKu7dGsLspv1lXNAPdCM3xgWk9BL9YARTp30FT2gP10cbT52LedLVXVrvZof6jxsDVtIo29cFXLZ/O6mf4TsYUwvbxzYOodS2m7f1NGcSxgDzmVMP1gne0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=ew3gH/qh; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="ew3gH/qh"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20261001085220fae97cd35d000207c8
        for <stable@vger.kernel.org>;
        Thu, 01 Oct 2026 10:52:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=w6L3QaVhgFzYQ29lWW6OlEsvKNadnP7rsB1TYXpG4yQ=;
 b=ew3gH/qhLinU97JQEobLwagqDv4Cj726XeVfMqSZJsZ6MxfhgNZwyzPldU0xy39l2l2uzK
 JbOrlmYbME7Kl7maJcGCJYcBfDbBqiOvf/NyYOijEqsU2raZ1CkKhCoI0ODLCFJlyfpe4pOt
 e9ISAi9GIExZGGvEBMoDAdRi7/lSwbGQ08PS1Ne8WsOuasAE64ANXyjVLxZoOY5uouCDJaqw
 JJL7xLOIsIsEMlr/EO+y27fIvgh/eUP0h+4e13wKNLwsYPDMOEiW5m+nNGuM9huw2TcPzZqp
 KL52xEi/NU8Mta8fLGBz2GCVge49jzpWRXLGLWtzmnzonF+/v6IY4BXQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-gpio@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	Lokesh Vutla <lokeshvutla@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: single: don't leak group/function tables on consumer re-probe
Date: Thu,  1 Oct 2026 10:52:10 +0200
Message-ID: <20261001085217.1778645-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20261001085217.1778645-1-alexander.sverdlin@siemens.com>
References: <20261001085217.1778645-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

For every mapping pcs_parse_{one,bits}_in_pinctrl_entry() builds a
pcs_function, a value table, a pin array and a pingroup-name array and
registers them via pcs_add_function()/pinctrl_generic_add_group(). The
core deduplicates groups and functions by name and keeps the first
instance for the controller's lifetime, so the tables built for any later
mapping of the same node - e.g. each consumer re-probe - are dropped by
the core and leaked.

Free the redundant copies once the function turns out to be a duplicate;
the group is deduplicated together with it. Don't remove the deduplicated
instance from the core: its selector is a plain counter (num_groups /
num_functions), so removing any but the last entry corrupts the selector
space.

kmemleak stays silent because the leaked tables remain reachable from the
controller's devres list.

Fixes: 8b8b091bf07f ("pinctrl: Add one-register-per-pin type device tree based pinctrl driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/pinctrl/pinctrl-single.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index e0eb7240a9859..e75e32723100d 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1097,6 +1097,19 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	} else {
 		*num_maps = 1;
 	}
+
+	/*
+	 * The core deduplicates groups/functions by name and keeps the first
+	 * for the controller's lifetime; drop our now-redundant copies when the
+	 * node is mapped again (consumer re-probe). The group is deduplicated
+	 * together with the function, so testing the latter is enough.
+	 */
+	if (pinmux_generic_get_function(pcs->pctl, fsel)->data != function) {
+		devm_kfree(pcs->dev, pins);
+		devm_kfree(pcs->dev, vals);
+		devm_kfree(pcs->dev, function);
+		devm_kfree(pcs->dev, pgnames);
+	}
 	mutex_unlock(&pcs->mutex);
 
 	return 0;
@@ -1235,6 +1248,14 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 	(*map)->data.mux.function = np->name;
 
 	*num_maps = 1;
+
+	/* See pcs_parse_one_pinctrl_entry() for the deduplication rationale. */
+	if (pinmux_generic_get_function(pcs->pctl, fsel)->data != function) {
+		devm_kfree(pcs->dev, pins);
+		devm_kfree(pcs->dev, vals);
+		devm_kfree(pcs->dev, function);
+		devm_kfree(pcs->dev, pgnames);
+	}
 	mutex_unlock(&pcs->mutex);
 
 	return 0;
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788442;
	b=2w6kXCTgeCObVdVQ1mUnhvkerDGc20Adp68oYdYEUU8rZJATWfAnIrG95NGXDPvH4Y42
	 A6GIYQeYt/6Tj7JzlDsT73nnIu1MLrAYZ5WxiaT/GB87K2/rX2asDuqrL/u+DKDtupMJl
	 6EradefQjIQdrDTigO5H9PNkA837Sewu99INk3GwrUXZixvuc/pFw64EYpRkIkOGOViuH
	 RTNB0Hf4H4WJsjEcijvYlm+CHQ1OaO4hOjHqObGatVJyH3rrKL9ntqqZSXGQpu3y3UN+b
	 D83yRI7GPgM0xcQgRnYhsgSqPlFNQ5VE6ZDRVN/MxVLRBpcCxT3KI14ZfNAX1JiXBcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788442;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ghbq/dDyFSCGSMQHs0AQ8pCT6MelXMSKRDi+1C0qWLM=;
	b=HX/1+akIitxo6fmRDa6lAflrWQWtS7JzkmVxHYlYGrdH+ztgQ4M0WE/G2Z2N+37YDR7V
	 EqV3SPCQyv6x7d3Ojqw7VfXcfTuoYNwTqCyNFl2+4ROlUfCZ0rEQWV03A4wRsDdlnebwl
	 rfkPLbi0QOko9lQ28hWx4drdwqW3f8YUkzSVkltXZge+rk3RichjBYAhUKMQ/APVgq/Zx
	 j00KsplRIFvH1/v3lbGs1E/C46gkPZj+VZJSqW15iaORBXudKCRzt9v2sHCOynu0DDttD
	 h4celj5DP5tqvK0yIlfI/5BE4/orCrArHoiT7cq5L8B4jrrCGRXMx+8CiUdSwKocC/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2vOVVIJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271A606A338;
	Fri, 27 Nov 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2vOVVIJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8B61F000C1;
	Fri, 27 Nov 2026 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788441;
	bh=Ghbq/dDyFSCGSMQHs0AQ8pCT6MelXMSKRDi+1C0qWLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E2vOVVIJvQMatkBo7AQIG795loKV0qTCVJgg8V2SmJOguJ5ESWwnUb8TscuWaDU49
	 dT0md96xtQM2pfAGw+tygc17DnusriitvJBLuJGb1Nt88uFe4YMeRTysm2xw3aHYCe
	 mRYYsEMwTaKrvU/b6itZPY+wyKNpx+N0YxOvE4tYGi85n2SYpqFjHLx2eHBSyNCkfS
	 BoNrFbYDGVxb394mleOiCRyi1FZd+hKaJXti635q3sIwo1Zaqv9pcbLo52QujIERBX
	 MpMaWuIoq32aM4Dpxo9Gkkkc4HK9he9ZXVicDUNRiFzKQI1DltY575EdBN37EWLfhb
	 q1BcdK0cvVOZQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 10/12] pinctrl: single: Free pinconf settings array with pinctrl_utils_free_map()
Date: Fri, 27 Nov 2026 14:04:58 +0000
Message-ID: <20261127140602.2790001-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127140602.2790001-1-lee@kernel.org>
References: <20261127140602.2790001-1-lee@kernel.org>
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

pcs_parse_pinconf() allocates a per-map settings array and attaches it
to map[i].data.configs.configs, while pcs_dt_node_to_map() allocates
*map itself, both via devm_kzalloc_objs() on pcs->dev.

When a consumer device unbinds and re-probes, pcs_dt_free_map() only
frees map and leaks the settings array on pcs->dev.  Moreover, because
pcs_probe() registers the pinctrl device with devres before pinctrl
hogs or consumers call pcs_dt_node_to_map(), devres teardown on
pcs->dev unbind frees *map and settings before
devm_pinctrl_dev_release() invokes .dt_free_map().

Allocate *map and settings with unmanaged kzalloc_objs() and wire
.dt_free_map directly to pinctrl_utils_free_map(), dropping the custom
pcs_dt_free_map() callback.

Fixes: 8f773bfbdd42 ("pinctrl: single: fix possible memory leak when pinctrl_enable() fails")
Fixes: 9dddb4df90d1 ("pinctrl: single: support generic pinconf")
Closes: https://sashiko.dev/#/bug/linux-fcedec46-4487-4392-a882-3d3bef07e56f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v2 => v3:
 - Allocate the pinconf settings array with kzalloc_objs() and wire .dt_free_map directly to pinctrl_utils_free_map(), dropping pcs_dt_free_map(), per Alexander Sverdlin's review.
 - Update the first Fixes tag to commit 8f773bfbdd42 ("pinctrl: single: fix possible memory leak when pinctrl_enable() fails").

 drivers/pinctrl/pinctrl-single.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 6f5113dcdb4b..3f756796c792 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -32,6 +32,7 @@
 #include "core.h"
 #include "devicetree.h"
 #include "pinconf.h"
+#include "pinctrl-utils.h"
 #include "pinmux.h"
 
 #define DRIVER_NAME			"pinctrl-single"
@@ -308,15 +309,6 @@ static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
 	seq_printf(s, "%zx %08x %s ", pa, val, DRIVER_NAME);
 }
 
-static void pcs_dt_free_map(struct pinctrl_dev *pctldev,
-				struct pinctrl_map *map, unsigned num_maps)
-{
-	struct pcs_device *pcs;
-
-	pcs = pinctrl_dev_get_drvdata(pctldev);
-	devm_kfree(pcs->dev, map);
-}
-
 static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 				struct device_node *np_config,
 				struct pinctrl_map **map, unsigned *num_maps);
@@ -327,7 +319,7 @@ static const struct pinctrl_ops pcs_pinctrl_ops = {
 	.get_group_pins = pinctrl_generic_get_group_pins,
 	.pin_dbg_show = pcs_pin_dbg_show,
 	.dt_node_to_map = pcs_dt_node_to_map,
-	.dt_free_map = pcs_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int pcs_get_function(struct pinctrl_dev *pctldev, unsigned pin,
@@ -960,7 +952,7 @@ static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
 	func->nconfs = nconfs;
 	conf = &(func->conf[0]);
 	m++;
-	settings = devm_kzalloc_objs(pcs->dev, unsigned long, nconfs);
+	settings = kzalloc_objs(unsigned long, nconfs);
 	if (!settings)
 		return -ENOMEM;
 	s = &settings[0];
@@ -1284,7 +1276,7 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 	pcs = pinctrl_dev_get_drvdata(pctldev);
 
 	/* create 2 maps. One is for pinmux, and the other is for pinconf. */
-	*map = devm_kzalloc_objs(pcs->dev, **map, 2);
+	*map = kzalloc_objs(**map, 2);
 	if (!*map)
 		return -ENOMEM;
 
@@ -1319,7 +1311,7 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 free_pgnames:
 	devm_kfree(pcs->dev, pgnames);
 free_map:
-	devm_kfree(pcs->dev, *map);
+	kfree(*map);
 
 	return ret;
 }
-- 
2.56.1.839.g22a8290db9-goog


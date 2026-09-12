Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38BF33F5A7
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222856; cv=none; b=ntM6OJdarSifCfxo0xwuo+JEeEbFFSdNFrpBvrcqa47JbC6B2WxwoXqVOfsIdyOyPE2PQ95kkihUFE+cDEpT+d+tD66/xcWSiS+NCbf8yMiZRi6hEm4fCP4HW8ffUdZ4aLcB4wIVV1rKmywhVG1sfx/wWbS2xsMJQLJMRu8bEuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222856; c=relaxed/simple;
	bh=peu0gk6IMy5p68Kl5LsiJdj/CqVdoqRIXc5STxuTm3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f30n0Uh+Jle6o6bajjbH8uvxPUJNy/ZCeWjmXxsfzh2qxgv17vSzM5Vno+71h9drkqXRKZymbpIGj8K9W66xkGtG6sOKgKQCq4Voa0O51Z6N5ogCd1UN4OxO8+zIkb/Sq+uPUXsOWazuRHQSBtd1SHsiQdJ810z0ZptVoOrw67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIy9Huq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIy9Huq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF15B1F00898;
	Sat, 12 Sep 2026 14:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789222854;
	bh=efGsY/cNr9zY8QeDBNkdepUd4zBZ9u39I8JUcIOEcKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cIy9Huq34RTOggteUs9LKZwbE+ZQVUaabgNqXa6mzvNwn8F0G3r0vTwsQIlk1CaZ2
	 8TtTcIKMKhI/dhWgc3Dn8btjAIrfDBdc+pCgWC3dd01g7sjLIpd4+IpYrsAXTsWwDr
	 0xOf59H2n1h0/ue01A4HrmEkC7/4lmqIfYNUDb/0c7haEh+VFsqNEuovxvfETqxAOR
	 8/NG6vKqjN1FEUtOu5bcIlp2dR5DGhUq6vnVs/rlNKJ0Q6eUaO7unfu6XZExJiXxpV
	 E8OdoqCPJidyGd8lNORrH9Lg3gwZKl9Qcthyrzhabjf8dUsxQCO/SJiIK3HK/0CYjw
	 uJPeXN6y3COOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] drm/panel-edp: fix i2c adapter leak on probe failure
Date: Sat, 12 Sep 2026 10:20:51 -0400
Message-ID: <20260912142051.2911653-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912142051.2911653-1-sashal@kernel.org>
References: <2026090912-bulginess-yearning-759f@gregkh>
 <20260912142051.2911653-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit e2a9e291275a74e309a21cbb1def6296a72d6aed ]

Make sure to drop the i2c adapter reference on probe failure (e.g.
probe deferral) and on driver unbind also if a devicetree redundantly
uses the 'ddc-i2c-bus' property to point to the aux ddc bus.

Fixes: cc5a3fc041f0 ("drm/panel: panel-simple: Stash DP AUX bus; allow using it for DDC")
Cc: stable@vger.kernel.org	# 5.15
Reported-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/CAD=FV=VZPhzHU+Pet2m3L+Pqc7mOPfZC-f5p0OuNL79wNZPxRg@mail.gmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patch.msgid.link/20260717143119.1815106-2-johan@kernel.org
[ Replaced panel-edp.c’s managed cleanup helper with a ddc_ref flag in panel-simple.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 539b58af565ee..addad8c81b92c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -187,6 +187,7 @@ struct panel_simple {
 
 	struct regulator *supply;
 	struct i2c_adapter *ddc;
+	bool ddc_ref;
 	struct drm_dp_aux *aux;
 
 	struct gpio_desc *enable_gpio;
@@ -712,6 +713,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc,
 
 		if (!panel->ddc)
 			return -EPROBE_DEFER;
+		panel->ddc_ref = true;
 	} else if (aux) {
 		panel->ddc = &aux->ddc;
 	}
@@ -816,7 +818,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc,
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 free_ddc:
-	if (panel->ddc && (!panel->aux || panel->ddc != &panel->aux->ddc))
+	if (panel->ddc_ref)
 		put_device(&panel->ddc->dev);
 
 	return err;
@@ -832,7 +834,7 @@ static int panel_simple_remove(struct device *dev)
 
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
-	if (panel->ddc && (!panel->aux || panel->ddc != &panel->aux->ddc))
+	if (panel->ddc_ref)
 		put_device(&panel->ddc->dev);
 
 	return 0;
-- 
2.53.0


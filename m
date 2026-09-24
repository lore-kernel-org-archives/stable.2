Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCB43E44F6
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279741; cv=none; b=MJvxosTS33JC+SoyL4MZ01voUQ7RPFNuRMBgKMaY7ylQIKkDoDoGoe9KNrFWpuEnVpTRhFbpw3WQn5jjYJBv2Ae2KzsOAQmMlfeLwxoNC3nx6J121IohPCVAA0oMl5qRXyL/+IR15sX9qh/jR6H5iRXBGVykXvAQ8sMI66bmJtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279741; c=relaxed/simple;
	bh=D7keJcwSqQOp0NdseY0wgS/ZtqGq5arWxyNwX4kPY/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyf9azLTcCerCnHA1kncw1OsnxO5I5IMdmsAafwphbVlcy9MKZ3Uk4O3wQ2pn9EmRmZ5QIZk/G8+KrGxCrnLtRSAMcPAvm3+ppBnnlAcsbw40HTAjNhlWKhehN+WxUmK81XMErfXOoVooDPYKAxCFsNzEiBOwzP+UJjGSrALrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2ffVWZT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2ffVWZT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so1509935e9.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790279735; x=1790884535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=enCFhbXwk6dv8V+Qy1/Wb32GY2e39ckcjINn4OP9c1c=;
        b=T2ffVWZTjlXPmKdN31mN2kxJ4x/5mXymv4ikfd6E22R1vjZeaF1eLaUr96Io7vQp4j
         4K4CtDcMiiHlQ60CgKcSwXFH8vpTH4j/EDOzPH3Hyun+ZhdgN0IBm9Iv54ust0QaI4tj
         Wn6QN2zc/O2eDpDtlYeLZPR07XM7oUX/rW42MVVYVvGDce6tGTGXX7OuMYnHrCg4UaGH
         wVjku4mUnKRKg/9W/8I0x3BbKBFEoCIhQGkopqw4AFaEqKtXy+l398U+No5UqSvMG8G6
         +HEr2VOP+MJKeM/lWjs2nAc4lw6ZJzpwR8eLScMFs4vH7hOQwhXPBESnUnMemNH7yeWF
         13KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790279735; x=1790884535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=enCFhbXwk6dv8V+Qy1/Wb32GY2e39ckcjINn4OP9c1c=;
        b=H6DgKG5JW15rd8wZ3MN7dPgfTZnPsstLlSQAaU0i0TyKkIVnaLfmC1du1JWlaAuURc
         arFw2m8Yte9NomqQS9qiRZFo1Wg03xBj05G30DRTm/yLB8ynXAK8wQQTf3g7/o4V9xoS
         jKaSKTrsEeQsitzAFvvklMfqHc9T8miWqnwk5GDm3fh8nC1qTQyy+wpV1FYPLhlN0ns/
         lseEQfmo83k8zutkhOAmlf2PO3cQivfvq6bYIaPN/H8iV70xZlPvZuNfGQFptiURfRnG
         QaNCfnVesBvFhzfwY4jRs/lL3MA41MFc97vS6WEwzUySOhcD9Do/OTwCkqWSyhbBNsLj
         LzZA==
X-Forwarded-Encrypted: i=1; AKwUvBz1xZVMwKFVEQONsORDZILZpo5fPqidzjuFzezd4lDXnO4mNTewXmCf4di+Rtc9wHgDMn3CLtA=@vger.kernel.org
X-Gm-Message-State: AFuF++l1wjWBufYM+pQ8wY+W/66AN0yO0hLkSMFC3XfBJd+0xKkLjDYc
	UIjXM2HKvXsFZ7JYIl7PVg6inSZ2MaHxebqMqWd9vWat45Uvc9eEyDjm
X-Gm-Gg: AYBFou3DCT/vJP19RC18kEpxjKlmFnnnM2gJ+mqUlhsyUOey/I010AzfVOx8nPlmaT6
	Ya9Ojdlb2/kEXPYYkrxUVO5aWhpDZJgLcutKQHJzvOsUk0nmopgAWXyZ5OY4OdKrLBC/NYrAfPz
	yqrnNIf8+9fXzUrJ480NkzdbjmTUIwEKWpNCHX0FDYKUR2geml+KoyNthqxbXpgTQ4iikpzghH4
	cnn0ZOJt+XozSiiIyT0KJPdaJ9lk/AEaabqcToN2MkQ4O2bfiu5PgvwWosFADqlt45NQOzU12hc
	NfjTJQWQFUfB4q+bs1tCw9qCNq9ePuk77nwgTPXQekOZ5aeYzkhF907gqigALGYEHmPJyzc1jDJ
	eeF79bvsToU89PvQ4sV2yymLLf0eb0lH+1Ldx2ZOYucjp/i6PBno8ba6n8ngP8YMR8wcRZx0jQV
	B5XK/pH+Oz+fnvICFaO9IdyhFMMTicNhci89C67J5DQhIvP9cw3WNeV/UMgAJVZ/wbuoQ2A5FuO
	jdoRquQv5JqGsHntrdiQ8GmQjg6uFaxaDil93LFTD012X7leFNQ
X-Received: by 2002:a05:600c:6290:b0:49e:799a:8969 with SMTP id 5b1f17b1804b1-49fe6707bb7mr68120475e9.30.1790279735177;
        Thu, 24 Sep 2026 12:55:35 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff06cbd2dsm1277235e9.12.2026.09.24.12.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:55:34 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sam Ravnborg <sam@ravnborg.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] drm/panel: tdo-tl070wsh30: Remove panel on attach failure
Date: Fri, 25 Sep 2026 00:55:12 +0500
Message-ID: <20260924195512.336690-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <message-id-of-your-v1-email>
References: <message-id-of-your-v1-email>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tdo_tl070wsh30_panel_add() calls drm_panel_add() to link the panel
into the global panel_list before tdo_tl070wsh30_panel_probe() calls
mipi_dsi_attach(). The panel object itself is allocated with
devm_drm_panel_alloc(), which only arranges for an automatic
drm_panel_put() (via devm_add_action_or_reset()) when the DSI device
is torn down; unlike devm_drm_panel_add(), it does not call
drm_panel_remove() for you.

If mipi_dsi_attach() fails, probe() returns the error directly:

        return mipi_dsi_attach(dsi);

Once probe() returns an error, the driver core releases devres
resources for the device, which drops the allocation's own
reference. But drm_panel_add() had already taken its own reference
and linked panel->list into the global panel_list, and nothing
undoes that. The panel is left registered in panel_list pointing at
a device that failed to bind, where it can still be found and
dereferenced by later lookups/iterations such as
of_drm_find_panel() or find_panel_by_fwnode().

Switch to devm_mipi_dsi_attach() so mipi_dsi_detach() is handled
automatically on unbind and tdo_tl070wsh30_panel_remove() no longer
needs the manual call. It still returns directly on failure without
touching panel_list, so drm_panel_remove() stays on that path.

Fixes: cf40c6600592 ("drm: panel: add TDO tl070wsh30 panel driver")
Cc: stable@vger.kernel.org
Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v2:
- Switch to devm_mipi_dsi_attach(), as suggested by Neil. Drop the
  now-redundant mipi_dsi_detach() call from remove().
- Keep drm_panel_remove() on the attach failure path, since
  devm_mipi_dsi_attach() doesn't touch panel_list on its own.

 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index fa961abdd2d7..ea59d4993ff5 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -179,17 +179,16 @@ static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	return mipi_dsi_attach(dsi);
+	err = devm_mipi_dsi_attach(&dsi->dev, dsi);
+	if (err < 0)
+		drm_panel_remove(&tdo_tl070wsh30->base);
+
+	return err;
 }
 
 static void tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
 {
 	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
-	int err;
-
-	err = mipi_dsi_detach(dsi);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
 
 	drm_panel_remove(&tdo_tl070wsh30->base);
 }
--
2.55.0

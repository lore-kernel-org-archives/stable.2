Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BDD49DB9C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954644; cv=none; b=LOZ6NgoxN4MMq1MyMVkaLl3Jp+KqerrJflQ36shdiM3k6GH6ustigcHhym1TymQyIpMNSXEEDKEY8g4ErZ5Nppq99EnSPBYn3NZNJp21ezkU3JJvvGwZyY+kCL6uZCAu9pHCoap7+z3ayqg7JIYk5olXWL0tv7msLKjEo0fAi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954644; c=relaxed/simple;
	bh=rKVmF5XPcO5dKsf050FHG2su2bpQUSihDzZPUj8NEHI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G0oNDUxCOwGDBfbYqt97iRU40zB1n+C/JNNs3SUwpwYY9OX3IrLC7Rf9o1znA+O+56CDo5ypYoRblTgGRKXPeA1cqMIkdAYR/C75AIOXFT/pLI9RzD37N8dN6XOZZkC+grIxN6PhI9ruO4aSMKZLdIAaPdS6Hlxs6sp77CrYMzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KjpZNu5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KjpZNu5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BF31F00A3A;
	Wed,  9 Sep 2026 11:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954642;
	bh=vaxMQRfhv6kY6Ik6Ct4VT4EIRJrfHQ8vLOy5yZFUgys=;
	h=Subject:To:Cc:From:Date;
	b=KjpZNu5MWoNjVvme6Eht5A7BZL+oV2wuLYLTzOMYMFD+pUXHFm+rUEJIj1fRVrwnB
	 FBZwXtcN9FV6KI795SywBQMpEwOCts/h++eznXfok4GSqzIeTKzT1KE/zGgPx7CnSS
	 +MS+MB2hexHQculKUWJELgHXn3wUqcZsEdMOZFVw=
Subject: FAILED: patch "[PATCH] drm/panel-edp: fix i2c adapter leak on probe failure" failed to apply to 5.15-stable tree
To: johan@kernel.org,dianders@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:39:12 +0200
Message-ID: <2026090912-bulginess-yearning-759f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e2a9e291275a74e309a21cbb1def6296a72d6aed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090912-bulginess-yearning-759f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e2a9e291275a74e309a21cbb1def6296a72d6aed Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 17 Jul 2026 16:31:18 +0200
Subject: [PATCH] drm/panel-edp: fix i2c adapter leak on probe failure

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

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index df7286679446..ff99fa3d0b59 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -832,6 +832,13 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	return 0;
 }
 
+static void panel_edp_put_adapter(void *_adap)
+{
+	struct i2c_adapter *adap = _adap;
+
+	put_device(&adap->dev);
+}
+
 static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 			   struct drm_dp_aux *aux)
 {
@@ -879,6 +886,11 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 
 		if (!panel->ddc)
 			return -EPROBE_DEFER;
+
+		err = devm_add_action_or_reset(dev, panel_edp_put_adapter,
+					       panel->ddc);
+		if (err)
+			return err;
 	} else if (aux) {
 		panel->ddc = &aux->ddc;
 	}
@@ -890,7 +902,7 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 
 	err = drm_panel_of_backlight(&panel->base);
 	if (err)
-		goto err_finished_ddc_init;
+		return err;
 
 	/*
 	 * We use runtime PM for prepare / unprepare since those power the panel
@@ -937,9 +949,6 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 err_finished_pm_runtime:
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
-err_finished_ddc_init:
-	if (panel->ddc && (!panel->aux || panel->ddc != &panel->aux->ddc))
-		put_device(&panel->ddc->dev);
 
 	return err;
 }
@@ -983,8 +992,6 @@ static void panel_edp_remove(struct device *dev)
 
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
-	if (panel->ddc && (!panel->aux || panel->ddc != &panel->aux->ddc))
-		put_device(&panel->ddc->dev);
 
 	drm_edid_free(panel->drm_edid);
 	panel->drm_edid = NULL;


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0653AAF7D
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342094; cv=none; b=NGeyGOYHnN2Hm1eevSIrpxhkyusiLUsrcEf0vuBk9dV2TcdDKKhJCsQRtehrLIWfBdAujdp3ruI2T9ql5uqSH+PAjlz/WRGIid8YRW/IamfAJhxJPUrWJwFtqiQPLJCh0SefsRqPRW5+dJq8kwzx5oic1RU8Eie9oLJUxg3Tmi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342094; c=relaxed/simple;
	bh=u2CjxLUVWR26MnKeHarClRpsIRkMOIMRIXrq0UbI0Mc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=em7ZwyA6/u80Cz2PNdbOHaBOFkW/6xzLFpXFUf8S/F5ZkIy3Pf/7o242ek7Ty+GteANMmmiXoS0qHJ0PZUXq1ZaK/hIcpA7TodVAPD9rRXFOH30MjQqoGeyqAE6upFWzfhdYgPv1obraNujmWr7qqCkv6h2sUGt/efVnOQHbzk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PP2nurlt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PP2nurlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E221F000E9;
	Wed, 29 Jul 2026 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785342092;
	bh=wqQAswVh1t7zeFPlYajPg21KbLIoSQlAxkHGWk2wHw4=;
	h=Subject:To:Cc:From:Date;
	b=PP2nurltZbUr57bxi3rBun89W0Wn6mHRxaJHmYohL4k7dLxW8hfEyp2QnojIwpqcg
	 f4udUDIv8TIFRzKYR+cZCeFfBXK3X8eef9y5uDKKtbLfKhtN1Sye02DJcTME+4b+aK
	 rJJIGQCeJG24C6N3Gkb1ltMY6PZv6qA6ZJkZ5PpM=
Subject: FAILED: patch "[PATCH] drm/i915/bios: range check LFP Data Block panel_type2" failed to apply to 6.1-stable tree
To: jani.nikula@intel.com,animesh.manna@intel.com,joonas.lahtinen@linux.intel.com,martin.hodo@intel.com,michal.grzelak@intel.com,ville.syrjala@intel.com,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 18:21:11 +0200
Message-ID: <2026072911-stoneware-animosity-c41f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2084503f2d087bf956198e7f6eb25b03a7049cb2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072911-stoneware-animosity-c41f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2084503f2d087bf956198e7f6eb25b03a7049cb2 Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 26 Jun 2026 17:01:55 +0300
Subject: [PATCH] drm/i915/bios: range check LFP Data Block panel_type2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While the panel_type from LFP Data Block is range checked, panel_type2
is not. Add a few helpers for range checking, and use them to not only
check panel_type2, but also improve clarity and correctness in the panel
type selection.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

v2:
- Fix commit message typo (Michał)
- Add is_panel_type_pnp() (Ville)

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: 6434cf630086 ("drm/i915/bios: calculate panel type as per child device index in VBT")
Cc: stable@vger.kernel.org # v6.0+
Cc: Animesh Manna <animesh.manna@intel.com>
Cc: Ville Syrjälä <ville.syrjala@intel.com>
Reviewed-by: Michał Grzelak <michal.grzelak@intel.com> # v1
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/20260626140155.1389655-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit c9ebe5d2f25729d6cfbbb1235d640bf67f9275df)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index b6fe87c29aa7..ded2ee497bbf 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -623,6 +623,21 @@ get_lfp_data_tail(const struct bdb_lfp_data *data,
 		return NULL;
 }
 
+static bool is_panel_type_valid(int panel_type)
+{
+	return panel_type >= 0 && panel_type < 16;
+}
+
+static bool is_panel_type_pnp(int panel_type)
+{
+	return panel_type == 0xff;
+}
+
+static bool is_panel_type_valid_or_pnp(int panel_type)
+{
+	return is_panel_type_valid(panel_type) || is_panel_type_pnp(panel_type);
+}
+
 static int opregion_get_panel_type(struct intel_display *display,
 				   const struct intel_bios_encoder_data *devdata,
 				   const struct drm_edid *drm_edid, bool use_fallback)
@@ -640,15 +655,21 @@ static int vbt_get_panel_type(struct intel_display *display,
 	if (!lfp_options)
 		return -1;
 
-	if (lfp_options->panel_type > 0xf &&
-	    lfp_options->panel_type != 0xff) {
+	if (!is_panel_type_valid_or_pnp(lfp_options->panel_type)) {
 		drm_dbg_kms(display->drm, "Invalid VBT panel type 0x%x\n",
 			    lfp_options->panel_type);
 		return -1;
 	}
 
-	if (devdata && devdata->child.handle == DEVICE_HANDLE_LFP2)
+	if (devdata && devdata->child.handle == DEVICE_HANDLE_LFP2) {
+		if (!is_panel_type_valid_or_pnp(lfp_options->panel_type2)) {
+			drm_dbg_kms(display->drm, "Invalid VBT panel type 2 0x%x\n",
+				    lfp_options->panel_type2);
+			return -1;
+		}
+
 		return lfp_options->panel_type2;
+	}
 
 	drm_WARN_ON(display->drm,
 		    devdata && devdata->child.handle != DEVICE_HANDLE_LFP1);
@@ -762,13 +783,12 @@ static int get_panel_type(struct intel_display *display,
 				    panel_types[i].name, panel_types[i].panel_type);
 	}
 
-	if (panel_types[PANEL_TYPE_OPREGION].panel_type >= 0)
+	if (is_panel_type_valid(panel_types[PANEL_TYPE_OPREGION].panel_type))
 		i = PANEL_TYPE_OPREGION;
-	else if (panel_types[PANEL_TYPE_VBT].panel_type == 0xff &&
-		 panel_types[PANEL_TYPE_PNPID].panel_type >= 0)
+	else if (is_panel_type_pnp(panel_types[PANEL_TYPE_VBT].panel_type) &&
+		 is_panel_type_valid(panel_types[PANEL_TYPE_PNPID].panel_type))
 		i = PANEL_TYPE_PNPID;
-	else if (panel_types[PANEL_TYPE_VBT].panel_type != 0xff &&
-		 panel_types[PANEL_TYPE_VBT].panel_type >= 0)
+	else if (is_panel_type_valid(panel_types[PANEL_TYPE_VBT].panel_type))
 		i = PANEL_TYPE_VBT;
 	else
 		i = PANEL_TYPE_FALLBACK;


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E93545DAC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955011; cv=none; b=Gtuz39yg+d7onNS9iqDemV97GLL8kFCh6he9oQMrt6LeOpVQto8fEIk4kGkdxplMo1yGZtkXbPzi48yebK29e03yrwB3q9O/VByjX6syNi38h14kRkrA76gLNmJY+/UDhiRR4PgPD2voJyDxg+W/2wIXCHk2pGjwASOWQXSW/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955011; c=relaxed/simple;
	bh=gsioJODuGpXR/wagDeX2UES/e2N9G4QWIDjwrbUUl7c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jH6/sW9ffnzAwNJZlT9OPjM3QYv4AMF7u+5+drJXHa4ranLZ1zpkaHyTLOH5b7z2blw2W7ApgaUxWKngLCYV6fpzE5eBFgof9vkP8P++hy5YW2zzrrKpjtFy13i/fhFMAVgXIjw/juAYKV7nFxcZ1rlKQkLIAGl9xi6AAoqdSHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pKv6CJN1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pKv6CJN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461F21F00A3A;
	Wed,  9 Sep 2026 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955009;
	bh=K34B4rEcuSlGt9C8N6TuWoxwTuHmXkSOob239lVoqhQ=;
	h=Subject:To:Cc:From:Date;
	b=pKv6CJN1COj2OGf241szc5vdMLVhDjCk6uSjXfyQvTKSfJrxkkmCIkH0diDXdoYMK
	 YVdpNeTQ84IYt9NuKZNfTzc+wQZjz62iCz5XxlVRu0Gg9ihwX/7tNOpB5c6nakZMVL
	 c+YXQ6EhyT8E+wrDDbYDYmlT4EwWdDZ53B6W/bSw=
Subject: FAILED: patch "[PATCH] drm/msm/dsi: round 6G byte clock rate to the PLL-achievable" failed to apply to 5.10-stable tree
To: kavansmith82@gmail.com,daniel@zonque.org,dmitry.baryshkov@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:54:10 +0200
Message-ID: <2026090910-activist-busily-77c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6cd33b6f4155efc20485929fd0b56bb704641db9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090910-activist-busily-77c5@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6cd33b6f4155efc20485929fd0b56bb704641db9 Mon Sep 17 00:00:00 2001
From: Kavan Smith <kavansmith82@gmail.com>
Date: Mon, 6 Jul 2026 18:32:40 -0700
Subject: [PATCH] drm/msm/dsi: round 6G byte clock rate to the PLL-achievable
 value

MSM8916 runtime DSI commands still go through
msm_dsi_host_xfer_prepare(), which re-applies the link clock rate before
enabling the link clocks. That is fine in principle, but on DSI 6G the
requested byte clock rate often does not exactly match the DSI PHY PLL's
realizable rate. For example, the driver can request 56250000 Hz while the
PLL actually runs at 56246337 Hz.

Because the requested and actual rates differ slightly, every later
link_clk_set_rate() call is treated as a real clock change and re-locks
the PLL. On a video-mode panel without an internal timing generator, such
as samsung,s6d7aa0 / lsl080al03 on MSM8916, that live-clock glitch makes
the panel lose pixel lock and visibly corrupts scanout on each runtime DCS
command, including backlight writes.

Fix this by rounding the computed 6G byte clock rate up front, before it is
stored in msm_host->byte_clk_rate and reused by later transfers. Once the
host carries the PLL-achievable rate instead of the idealized one,
repeated link_clk_set_rate() calls become no-ops in the common clock
framework and no longer re-lock the PLL.

This keeps the normal transfer callback sequencing intact, preserves the
OPP vote path in link_clk_set_rate(), and matches the fix direction
suggested in the original 2018 discussion.

Reported-by: Daniel Mack <daniel@zonque.org>
Closes: https://lore.kernel.org/all/1a682c5b-7fc9-3aaa-120b-64b239a355a3@zonque.org/
Fixes: 6b16f05aa39f ("drm/msm/dsi: Split clk rate setting and enable")
Cc: stable@vger.kernel.org
Signed-off-by: Kavan Smith <kavansmith82@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/738234/
Link: https://lore.kernel.org/r/20260707013240.681012-1-kavansmith82@gmail.com
[DB: dropped extra chunk from the patch]
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 982abaaac00d..5e1b313f04c0 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -670,12 +670,24 @@ static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 
 int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 {
+	long rounded_byte_clk_rate;
+
 	if (!msm_host->mode) {
 		pr_err("%s: mode not set\n", __func__);
 		return -EINVAL;
 	}
 
 	dsi_calc_pclk(msm_host, is_bonded_dsi);
+
+	rounded_byte_clk_rate = clk_round_rate(msm_host->byte_clk,
+					       msm_host->byte_clk_rate);
+	if (rounded_byte_clk_rate < 0) {
+		pr_err("%s: failed to round byte clock rate, %ld\n",
+		       __func__, rounded_byte_clk_rate);
+		return rounded_byte_clk_rate;
+	}
+
+	msm_host->byte_clk_rate = rounded_byte_clk_rate;
 	msm_host->esc_clk_rate = clk_get_rate(msm_host->esc_clk);
 	return 0;
 }


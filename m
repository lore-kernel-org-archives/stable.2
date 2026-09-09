Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548B454529C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955008; cv=none; b=er3nLgVnwoAUdtYQy4m4cIr3+JcmO/b7ZE2vIbomd5Fd64jK/ic5/mFQoUP9ogh4MjWhnCBswC3G+q34TFmWl2E+Tx7H5BK2eGk0t/dAQHzMC5b3TgN288W8RubIVLnIP0XXKaTkRFCwao2cy4ogFdIvuOkgq0t/zoCVpmHQs2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955008; c=relaxed/simple;
	bh=9/WY8FD/R55qc+sNeOwqCDY0+5Nhq6HAb+NAADV6Sc8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QG7lYGw0+vThi/Cubz1k2VLn+w4MQrjy1lhV1r2B7QpCthkAcnPz8bdtoujchc9UmawfqbIYmsvxgn+1TkXHwU/LmbFVaAzf5J/IEJd8YeVXUZbOpHKhTVzLBVDLJmFSq541ZD9DyItSRdsaTI8u2Ufcxo2mK+T3GfwO8oygD7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vQ2gYIZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vQ2gYIZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7235F1F00A3A;
	Wed,  9 Sep 2026 11:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955007;
	bh=CG3G7r+ewnkDYG5FUu/1MGpuyixJcWCj11r8aV+Jg7g=;
	h=Subject:To:Cc:From:Date;
	b=vQ2gYIZSiBq5cprgztRg9+cASQW8aBqYS1ZfWh4FvpRyA/83F+xMiLTjsduT1znI0
	 C5Nnn13hucZPIrsDY3FgciIgLbXhsoAj0/6zmbN1SEsvltcq75rnAyAPaolAoAOY+R
	 zv4AIvyDN65llOK2sqY1wN9vVdwc7FJ7uN8/S9hk=
Subject: FAILED: patch "[PATCH] drm/amd/display: Scale custom brightness curve from full" failed to apply to 7.2-stable tree
To: zhitaevakh@gmail.com,alexander.deucher@amd.com,mario.limonciello@amd.com,superm1@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:53:00 +0200
Message-ID: <2026090900-astrology-gallery-8428@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 6fd83a1c2cdea48c396f600795217fbdfb8124f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090900-astrology-gallery-8428@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6fd83a1c2cdea48c396f600795217fbdfb8124f6 Mon Sep 17 00:00:00 2001
From: Akhmed Zhitaev <zhitaevakh@gmail.com>
Date: Thu, 13 Aug 2026 22:09:59 +0500
Subject: [PATCH] drm/amd/display: Scale custom brightness curve from full
 range

Custom brightness curves use an 8-bit input signal.  After exporting the
full PWM range to userspace, the curve normalizer still divides requests
by the physical PWM span.  On panels with a nonzero minimum PWM level,
this can produce a curve input greater than 255 and send an invalid
backlight level to DC.

Scale the userspace [0..max] range to the curve's [0..255] range
instead.  This retains the full advertised range and keeps the reverse
readback conversion unchanged.

Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
(Move to amdgpu_dm_backlight.c)
Link: https://patch.msgid.link/20260813170959.22073-1-zhitaevakh@gmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index b66ca60e697d..e61bbc310f33 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -106,10 +106,10 @@ int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 }
 EXPORT_IF_KUNIT(get_brightness_range);
 
-/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
-static inline u32 scale_input_to_fw(int min, int max, u64 input)
+/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
+static inline u32 scale_input_to_fw(int max, u64 input)
 {
-	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
+	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
 }
 
 /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
@@ -123,7 +123,7 @@ void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
 			       unsigned int min, unsigned int max,
 			       uint32_t *user_brightness)
 {
-	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
+	u32 brightness = scale_input_to_fw(max, *user_brightness);
 	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
 	int left, right;
 


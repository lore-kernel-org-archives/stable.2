Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E725427ED
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955005; cv=none; b=FTeUJkzi/+grDKYEF1ZKRjGrHXx06HQ2Zm5FuMpJjp4sLR0ggfuxlTzG7IH8B29ndm+lSjG2GX2uPnVy19lTD0HU75NZzr+WQSeinaCgc09cGeX93BKQJL58LStLPcJ1TKB8GxQ9elmfr+FPxD6dGtx6VyFz6b8JKScaYm+zL2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955005; c=relaxed/simple;
	bh=TlwHV13d/OiowqVv+Ia4pSRv/P/NfOgB/N6qS6OQLBI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K6r9JKzqiP9mj/2gEnRE47Z0aD/oKd67cvOeQE6xvyT0tyxgDGaniyyy6mhZhobDGRqnQIbvfJyBo8vmYrTLX1nPYbenZ9m2UOeyJxEJNvYKgCMxO+SC0hBt9YeL+VNO82lFpSVF4FMTUk2MwjdcEL6etd1ZW5kSeWtS8W+cy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0/4R7DAX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0/4R7DAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F601F00A3A;
	Wed,  9 Sep 2026 11:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955004;
	bh=GeJpZm/0fcZOcxldBJaGEfVOg+x+DGm+x3S+k2IH4Uo=;
	h=Subject:To:Cc:From:Date;
	b=0/4R7DAXi1GwI5FiZ7szxRSu7qF7/OYiPmbRNOX1QWQSn2MLvQSU6wEMSGqfJL9Re
	 bQHE9meXKVyGg88sR41L11eDTSCQoNMJV4x9L9TXqVW8HGBpv+8A3mDPjhISSXHjCS
	 6fMkDKI4t6RU/nCjQGFRcpINgMUryUdfYg4ncKGo=
Subject: FAILED: patch "[PATCH] drm/amd/display: Scale custom brightness curve from full" failed to apply to 6.18-stable tree
To: zhitaevakh@gmail.com,alexander.deucher@amd.com,mario.limonciello@amd.com,superm1@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:53:00 +0200
Message-ID: <2026090900-lip-ribbon-1726@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 6fd83a1c2cdea48c396f600795217fbdfb8124f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090900-lip-ribbon-1726@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 


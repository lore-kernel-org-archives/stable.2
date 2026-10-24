Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792805627;
	b=dEO5KiKIGYMTmNejrLQP6Dbie7r4GZLtzvpOO+wRsr3huykXAIoqmUHN18jLJpnmplN2
	 AUfQx8YPIYKS3y1h7FtoF/zet0yUa3Ththp1JT3ALd3BcN7e66yssnv5PrxeBQn3/8dPP
	 3VhYG4UoxBSeL+Bbk+5lWzIFnbzYF1THnXEhYq/Hq8Xkx7XfQo/pxcFvXtRHktyJZQP2V
	 SJq6mHPgHMr0XE0pA7lWCMSLXNPcFp8YMR4psqxbujV5/o14pO11i0w9RlmKE2xl6bNpa
	 H630lAfMZTS/DqGp2f3FweKZoC3LswISZz2fUnpNs6fBvQHNi9+tmhayCAHvZCIsWKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792805627;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=U20DJXdLZgpHltsupjTkKgbtDLL46fdvXL7lze6YrJk=;
	b=H+mk5ukm4Tv9SoKq7yUPhgOtTY0mjUvxk6tC3Yt/oy5EVcp5GVgTZjcdAAWtgg5uR4l4
	 HZRYuIba7sCHH63VuXjUdQq3hNu9DCsXwTu363TOqKpRGU8Au586RgbYQXQkuwfcPSxVy
	 SUfI2FqOaKm7eulbZWyke/zibosyY+LMn0ITTMzx6HooiuLehnuN0yYnDgGzGrGmw3fdA
	 MzetS32tVXG8CyBsC58ErnGj01Tj5rVM9Gi29DIfe2vulZkltiOu0R535OjKEvN101oKg
	 VgB0mNGJ3XrOtPRyiV15aoD+FXBeocb19LBTOTaFpMM9VmW0fTlqHSb940rLchTBVqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=empyreal.works;
	spf=pass smtp.mailfrom=empyreal.works;
	dkim=pass header.d=empyreal.works header.i=@empyreal.works header.a=rsa-sha256 header.s=protonmail2 header.b=LIwHqmqw;
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D1606A31A;
	Sat, 24 Oct 2026 01:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 331D1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=empyreal.works
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=empyreal.works
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=empyreal.works header.i=@empyreal.works header.a=rsa-sha256 header.s=protonmail2 header.b=LIwHqmqw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=empyreal.works;
	s=protonmail2; t=1792805623; x=1793064823;
	bh=U20DJXdLZgpHltsupjTkKgbtDLL46fdvXL7lze6YrJk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LIwHqmqwPpPjGD78UxeXLJiJ3iKRFjbdhrr2nzUR5+enicE02l2RdkMM1qaZ/TaOb
	 QOfS03bsZTSKBoNIuWFnImgoxfy/7ACRuA44nxmd27dawksNnd8jLdpYKPNBSP2Of3
	 pg+5pr1+rSKH2XGDVBSSHUZrqdMWrT2Vrzg91hJa4ac1td6h3AuvZRer0GIeM0SDlc
	 3sK1CRJmyrssT/yWDqjT4rfcjrPmTD0LN3wJJksgN/AXcTkTqoTKM0t1VsJutvpo3n
	 3KNu4pCD7h0iJgv+V1A9uxZo6sGyiGQqhhYmmOiu1goMaZNAxIpji9TskIvCFydsm0
	 ucPBt91ueKwRQ==
Date: Sat, 24 Oct 2026 01:33:38 +0000
To: amd-gfx@lists.freedesktop.org
From: Andrei Rusu de Castro <arc@empyreal.works>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com, mario.limonciello@amd.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, chen-yu.chen@amd.com, ray.wu@amd.com, stable@vger.kernel.org
Subject: [PATCH v3 1/2] drm/amd/display: keep custom brightness curve in userspace domain
Message-ID: <ba2699e51bc48bc673e3bac85a6788734d61cc92.1792805565.git.arc@empyreal.works>
In-Reply-To: <cover.1792805565.git.arc@empyreal.works>
References: <20260902-brightness-cover-abf809f2@empyreal.works> <cover.1788388049.git.arc@empyreal.works> <cover.1792805565.git.arc@empyreal.works>
Feedback-ID: 182420409:user:proton
X-Pm-Message-ID: 6ea466e04b99f6b5a3b9b9af7bea70f55c6c35b8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

convert_brightness_from_user() expects convert_custom_brightness() to
reshape a value in the userspace [0..max] domain before the caller maps
it once into the firmware [min..max] domain.

Commit 8dbd72cb7900 ("drm/amd/display: Export full brightness range to
userspace") instead made convert_custom_brightness() call
scale_fw_to_input(min, max, ...). That helper adds min and scales by the
firmware span, entering the firmware domain before the caller applies
the same span and minimum again.

With the default PWM range, min is 3084 and max is 65535. A zero request
through any custom curve consequently returns 6023 instead of 3084, so
the darkest 2939 firmware levels are unreachable. AUX panels with a
custom curve lose their lowest levels the same way.

Keep the curve result in [0..max]. scale_fw_to_input() then becomes the
inverse of scale_input_to_fw(), and the caller remains the sole owner of
the userspace-to-firmware conversion. The linear path is unchanged.

Since commit "drm/amd/display: map PWM brightness through custom
backlight curve", PWM panels no longer reach this helper. AUX panels
still do through convert_brightness_from_user(), and stable kernels
predating the power module still use it on PWM panels.

Commit 6fd83a1c2cde ("drm/amd/display: Scale custom brightness curve from
full range") fixed the corresponding input-side domain error. This
completes the output side of the same conversion.

Source and arithmetic analysis identified the duplicate domain
conversion. KUnit coverage for a non-zero firmware minimum is added
separately.

Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to user=
space")
Cc: stable@vger.kernel.org # 6.17.x: 6fd83a1c2cde: drm/amd/display: Scale c=
ustom brightness curve from full range
Cc: stable@vger.kernel.org # 6.17.x
Cc: stable@vger.kernel.org # before 7.3 this code is in amdgpu_dm.c; drop t=
he header and test hunks
Assisted-by: LLM
Signed-off-by: Andrei Rusu de Castro <arc@empyreal.works>
---
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   | 13 ++++----
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |  3 +-
 .../tests/amdgpu_dm_backlight_test.c          | 30 +++++++++----------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 27546febf..cd8be50bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -122,10 +122,10 @@ static inline u32 scale_input_to_fw(int max, u64 inpu=
t)
 =09return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
 }
=20
-/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
-static inline u32 scale_fw_to_input(int min, int max, u64 input)
+/* Rescale the firmware curve's [0..AMDGPU_MAX_BL_LEVEL] back to userspace=
 [0..max]. */
+static inline u32 scale_fw_to_input(int max, u64 input)
 {
-=09return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_L=
EVEL);
+=09return DIV_ROUND_CLOSEST_ULL(input * max, AMDGPU_MAX_BL_LEVEL);
 }
=20
 static u32 backlight_signal_to_luminance(const struct amdgpu_dm_backlight_=
caps *caps,
@@ -192,8 +192,7 @@ static u32 convert_brightness_to_millipercent(const str=
uct amdgpu_dm_backlight_c
=20
 STATIC_IFN_KUNIT
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps=
,
-=09=09=09       unsigned int min, unsigned int max,
-=09=09=09       uint32_t *user_brightness)
+=09=09=09       unsigned int max, uint32_t *user_brightness)
 {
 =09u32 brightness =3D scale_input_to_fw(max, *user_brightness);
 =09u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
@@ -251,7 +250,7 @@ void convert_custom_brightness(const struct amdgpu_dm_b=
acklight_caps *caps,
 =09=09=09=09=09=09    (brightness - lower_signal),
 =09=09=09=09=09=09    upper_signal - lower_signal);
 scale:
-=09*user_brightness =3D scale_fw_to_input(min, max,
+=09*user_brightness =3D scale_fw_to_input(max,
 =09=09=09=09=09     DIV_ROUND_CLOSEST(lum * brightness, 101));
 }
=20
@@ -266,7 +265,7 @@ u32 convert_brightness_from_user(const struct amdgpu_dm=
_backlight_caps *caps,
 =09if (!get_brightness_range(caps, &min, &max))
 =09=09return brightness;
=20
-=09convert_custom_brightness(caps, min, max, &brightness);
+=09convert_custom_brightness(caps, max, &brightness);
=20
 =09/* Rescale 0..max to min..max */
 =09return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 9ad888d3a..32ba2f8ef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -68,8 +68,7 @@ ssize_t panel_power_savings_store(struct device *device,
 int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 =09=09=09 unsigned int *min, unsigned int *max);
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps=
,
-=09=09=09       unsigned int min, unsigned int max,
-=09=09=09       uint32_t *user_brightness);
+=09=09=09       unsigned int max, uint32_t *user_brightness);
 u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *ca=
ps,
 =09=09=09=09 uint32_t brightness);
 u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps=
,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backligh=
t_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_=
test.c
index 5221050de..5ff074497 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.=
c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.=
c
@@ -1054,7 +1054,7 @@ static void dm_test_custom_brightness_no_data_points(=
struct kunit *test)
=20
 =09caps.data_points =3D 0;
=20
-=09convert_custom_brightness(&caps, 3084, 65535, &brightness);
+=09convert_custom_brightness(&caps, 65535, &brightness);
=20
 =09/* No data points =E2=86=92 no-op */
 =09KUNIT_EXPECT_EQ(test, brightness, saved);
@@ -1078,7 +1078,7 @@ static void dm_test_custom_brightness_debug_mask_disa=
bles(struct kunit *test)
 =09/* Set the disable flag */
 =09amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() | DC_DISABLE_=
CUSTOM_BRIGHTNESS_CURVE);
=20
-=09convert_custom_brightness(&caps, 3084, 65535, &brightness);
+=09convert_custom_brightness(&caps, 65535, &brightness);
=20
 =09/* Should be no-op due to debug mask */
 =09KUNIT_EXPECT_EQ(test, brightness, saved);
@@ -1121,14 +1121,14 @@ static void dm_test_custom_brightness_exact_match(s=
truct kunit *test)
 =09 */
 =09brightness =3D 32896;
=20
-=09convert_custom_brightness(&caps, min, max, &brightness);
+=09convert_custom_brightness(&caps, max, &brightness);
=20
 =09/*
 =09 * Exact match: lum=3D50, brightness_scaled=3D128
-=09 * result =3D scale_fw_to_input(min, max, DIV_ROUND_CLOSEST(50*128, 101=
))
-=09 *        =3D scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(6400, 101))
-=09 *        =3D scale_fw_to_input(0, 65535, 63)
-=09 *        =3D 0 + DIV_ROUND_CLOSEST(63 * 65535, 255) =3D 16191 (approx)
+=09 * result =3D scale_fw_to_input(max, DIV_ROUND_CLOSEST(50*128, 101))
+=09 *        =3D scale_fw_to_input(65535, DIV_ROUND_CLOSEST(6400, 101))
+=09 *        =3D scale_fw_to_input(65535, 63)
+=09 *        =3D DIV_ROUND_CLOSEST(63 * 65535, 255) =3D 16191 (approx)
 =09 */
 =09KUNIT_EXPECT_TRUE(test, brightness !=3D 32896);
 =09KUNIT_EXPECT_TRUE(test, brightness < 32896);
@@ -1167,13 +1167,13 @@ static void dm_test_custom_brightness_below_first(s=
truct kunit *test)
 =09 */
 =09brightness =3D 12850;
=20
-=09convert_custom_brightness(&caps, min, max, &brightness);
+=09convert_custom_brightness(&caps, max, &brightness);
=20
 =09/*
 =09 * Below first data point: lum =3D DIV_ROUND_CLOSEST(40 * 50, 100) =3D =
20
-=09 * Then: scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(20 * 50, 101))
-=09 *      =3D scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(1000, 101))
-=09 *      =3D scale_fw_to_input(0, 65535, 10)
+=09 * Then: scale_fw_to_input(65535, DIV_ROUND_CLOSEST(20 * 50, 101))
+=09 *      =3D scale_fw_to_input(65535, DIV_ROUND_CLOSEST(1000, 101))
+=09 *      =3D scale_fw_to_input(65535, 10)
 =09 * The output should be significantly less than input.
 =09 */
 =09KUNIT_EXPECT_TRUE(test, brightness < 12850);
@@ -1211,7 +1211,7 @@ static void dm_test_custom_brightness_interpolation(s=
truct kunit *test)
 =09 */
 =09brightness =3D 32125;
=20
-=09convert_custom_brightness(&caps, min, max, &brightness);
+=09convert_custom_brightness(&caps, max, &brightness);
=20
 =09/*
 =09 * The function should interpolate between data points and produce
@@ -1254,7 +1254,7 @@ static void dm_test_custom_brightness_above_last(stru=
ct kunit *test)
 =09 */
 =09brightness =3D 56533;
=20
-=09convert_custom_brightness(&caps, min, max, &brightness);
+=09convert_custom_brightness(&caps, max, &brightness);
=20
 =09/* Output should differ from input (remapped via curve) */
 =09KUNIT_EXPECT_TRUE(test, brightness !=3D 56533);
@@ -1292,7 +1292,7 @@ static void dm_test_custom_brightness_single_data_poi=
nt(struct kunit *test)
 =09 */
 =09brightness =3D 16448;
=20
-=09convert_custom_brightness(&caps, min, max, &brightness);
+=09convert_custom_brightness(&caps, max, &brightness);
=20
 =09KUNIT_EXPECT_TRUE(test, brightness < 16448);
=20
@@ -1330,7 +1330,7 @@ static void dm_test_custom_brightness_lower_lum_zero(=
struct kunit *test)
 =09 */
 =09brightness =3D 32125;
=20
-=09convert_custom_brightness(&caps, min, max, &brightness);
+=09convert_custom_brightness(&caps, max, &brightness);
=20
 =09/* Should remap; result should differ from input */
 =09KUNIT_EXPECT_TRUE(test, brightness !=3D 32125);
--=20
2.56.0



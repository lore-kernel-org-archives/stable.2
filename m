Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218A477998
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329332; cv=none; b=GbG+donVqbQyjPZwYzoP4kPGHX/Fawhk3KaUP3gpQ8/NFvLgj+foAs5tndBLfKRC2+7GBvtXxbssX0BTEusg7rudcfcHAVJ/x8C1oeumdFGq9OhlhNO+xLyRmCHG81N0prjUXqiW7JyNdEr5RJscrF5/D8mpjB+Lz5JvyW4NrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329332; c=relaxed/simple;
	bh=b7OvXV1yLHyxNTaram4OdXGB5aEU9R3BB6PjRexZrjM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BoujMrBamSbGtPIfJkaKntrjsvNukY9mAxGL4Uobqa/yIwGfKbEc99fH4HzchhV6fVoLnN1C0KWRBfYCXSpTgUlYNLiCmCUkRLg2gK1qg6xrlhEK1iFlU46VmZLg33ypQW7hvaQ9i35+f3H5a0YNSk6xPeJnuIlH4ful7Y7s0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yMLWcE0+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yMLWcE0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333FF1F000E9;
	Wed, 29 Jul 2026 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329330;
	bh=8W8arBxmtd/nWx0aBEO7OazLovx8Uy2d5YbGIQ1/5w0=;
	h=Subject:To:Cc:From:Date;
	b=yMLWcE0+bx7QOaJ9mKXrUoH1aQyMbBQ3/dIKgGpEEBz5FbUE6oXT+Vzh+5yOBHTnz
	 2T+WgGoUVc2nIzPrVd3sKXrOzJ3bBVRLtcaGZlMgMUMWla2QH5YpQdisjqBmZ10FJq
	 YwzTFKIJeF58q67W+tmo+DjrEo3Bx0z+TrYjC/sQ=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix __udivdi3 link error" failed to apply to 6.12-stable tree
To: yanglinlin@kylinos.cn,alexander.deucher@amd.com,kernel-bot@kylinos.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:48:28 +0200
Message-ID: <2026072928-subduing-rename-9823@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 54d4dee9f89e1dac1a6c2618de0bb2e3f35cc2f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072928-subduing-rename-9823@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 54d4dee9f89e1dac1a6c2618de0bb2e3f35cc2f0 Mon Sep 17 00:00:00 2001
From: yanglinlin <yanglinlin@kylinos.cn>
Date: Mon, 13 Jul 2026 11:12:28 +0800
Subject: [PATCH] drm/amd/display: fix __udivdi3 link error

When compiling the AMDGPU display driver for 32-bit architectures,
the linker reports undefined reference to `__udivdi3` in functions
get_dp_dto_frequency_100hz() and dcn401_get_dp_dto_frequency_100hz().

This is because the code uses 64-bit division (/) on 32-bit systems,
which GCC cannot handle directly and instead tries to call the missing
__udivdi3 helper function.

Replace the raw division with div_u64(), the kernel's standard 64-bit
division helper, to avoid the link error.

Signed-off-by: Linlin Yang <yanglinlin@kylinos.cn>
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 0421fc6ab3a8514e99156ff3c2cee13ee9af3fa7)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 7c293917e6fd..ecb8493ec523 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1229,9 +1229,9 @@ static bool get_dp_dto_frequency_100hz(
 			 */
 			modulo_hz = REG_READ(MODULO[inst]);
 			if (modulo_hz) {
-				temp = div_u64((uint64_t)clock_hz * dp_dto_ref_khz * 10, modulo_hz);
-				ASSERT(temp / 100 <= 0xFFFFFFFFUL);
-				*pixel_clk_100hz = (unsigned int)(temp / 100);
+				temp = clock_hz * dp_dto_ref_khz * 10;
+				ASSERT(temp <= UINT_MAX * modulo_hz * 100ULL);
+				*pixel_clk_100hz = div_u64(temp, modulo_hz * 100);
 			} else
 				*pixel_clk_100hz = 0;
 		} else {
@@ -1285,13 +1285,12 @@ static bool dcn401_get_dp_dto_frequency_100hz(const struct clock_source *clock_s
 		 *     - target pix_clk_hz = (DPDTO INTEGER * DPDTO MODULO + DPDTO PHASE)
 		 */
 		temp = (unsigned long long)dp_dto_integer * modulo_hz + phase_hz;
-
-		if (temp / 100 > 0xFFFFFFFFUL) {
+		if (temp > (UINT_MAX * 100ULL)) {
 			/* pixel rate 100hz should never be this high, if it is, throw an assert and return 0  */
 			BREAK_TO_DEBUGGER();
 			*pixel_clk_100hz = 0;
 		} else {
-			*pixel_clk_100hz = (unsigned int)(temp / 100);
+			*pixel_clk_100hz = div_u64(temp, 100);
 		}
 
 		return true;


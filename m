Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471F511E78
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568619; cv=none; b=ZQ+Ol4MXSIAicG2OEY0aKvDf35Dkmv5AS0c7c3xzGg6nBEL39EfoQs22tIsMY7sFtKYQJgdkjVYznNHxUIsG0eQSwDYSE6oHodnxmSnlLEN0pf0M3U6Nodwr7CmV1jwgY/2U5MY4e95FjfSIQKA/hyhQexyTPvhKxcYAvhqcvKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568619; c=relaxed/simple;
	bh=AKt9EBG2sN//YZXz7OJRbcZoWgw3MVBMUuQ0ohJ+fn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5ZKsQgnkNSOdJ4VuABxk3au8Z/NjoBvaMOnCWLhBcieadA9NGZ70fpsWIGZIf6oGBtmok7hgF8pk2wWgWCi/B0pdyOr/4DC1gMMXejSmBDQViGlJJmatqc2O2n6SvshPsjJk27RjKItcVrU4xVHP7blSTp8++p+T8GjT9tdQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S82RQ5bJ; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S82RQ5bJ"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f56039dso149306166b.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789568616; x=1790173416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B6QT3yGLHL6iAKp7l+6TCtIqZRata/HBJzcHAfxOozE=;
        b=S82RQ5bJFrDX8fCe32ln4IrcTX4Ow8QhBonXvXldB78Scevz5jLTofi2DGR69HVmxc
         L7mV6OjJiuus3oI6zx2QDse6QQ7O2nmpmqSOBt+5pkhnuFA5CHboUKGF08Uok10e66R5
         /gcoOUpUblZksqckJ7WLvgwP5TPk9hwgW0ZrDIQItPd8J/AKoz7iS17QqexRfDwL0ZtQ
         tjW16mO4fuG/X5cqB/czkqz6Luxh/uRMWTtE4pmJAk6eB0FON1V4x1WxyXLFZLu1u7k1
         l9o+RBcLRNpomTYLcLjJ7Dfm8l38VORMllOFS8R8j+72WrixzgRhkLzzfj3h60F3a1A2
         gHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789568616; x=1790173416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B6QT3yGLHL6iAKp7l+6TCtIqZRata/HBJzcHAfxOozE=;
        b=jrbvTOFZUY5oCaXC/vw/TxE//0UwKrJsfImyvHH6lNqfHK1cfYhipd1d7/JZmZjkQp
         edVbTa5ULx3QM3fkruOlGThhFhmwHqun4xMFXV4SIQ+nv9HYZsu/r5T5Md8DQ4UuS4TM
         xl+UdHz2ASNheBH6ZwMekklfBEfQC/ChSqKy3wmmh0c7f2287/ne4d46wz77BLaSrnh8
         W9bR3b7BdReWFOyEsPZ3cFf9gT4aszSMjanFgxSPaQ1zP4ANIBk+5pMWUT9FJJRDbAde
         3wGXbRcYJaSozzh0xXTgLHlrabq2WXxGqZOocq62jiL8YrH+bbm2AZYwbdm9HsY1Yu+e
         jxsA==
X-Forwarded-Encrypted: i=1; AKwUvBxCOXeCe/SSh9/MJCKQrNDAh76y5Kz1hgxTbwB1GjpZo1lA9deG0zUb4ywB6x/GzAJlHspYm+0=@vger.kernel.org
X-Gm-Message-State: AFuF++lZ/u1ZnPiLbUqI0ygMxoix4Y9+aL5FwmUO0vLjo66OTitT9cRK
	aiQsewrK7O6qcuQkeJvkx/DBMg9P7l05MHG59rJnLNJ0lVT3fyUDk3/i
X-Gm-Gg: AYBFou2LzMykJw/fCH0WNzxuj8qqlC6abrXIm5fpPSOsaKPHAP7iqBGd8h2te8R6OgQ
	l6p+y1z3dSiKo9sr9AVjfY73Y9nHozCC24iKjyaycLWXj1tZ32Je6T0YGgclRTtqmtp/RJkuols
	jb9kxIFMoEtHtg/pbtL1yE1PoBAvXoPqraZXQYKkgoY5Kf9tkFW0DoZ88HOVwPcNSkO5KwTN9Sl
	UdaSPXaC7pGminzbyNkbjjvn5Ns1SBQ2obnLKTvUDwI8tu5xgtXTIBe/D+ERgXkzJOFVn6l+39Z
	Vtw/IS4EO6U0faM+PMR5P+GakdXkebYK6Ee2BkP3w9h32voh0mHwrTduwG4uaBG09kvdiPmKOgq
	P9R6SZ/LApfT/P6vcupK9lzSSgTLCn7obJu5r8VxKALW8yYrNLWY1NoaFmxbw/uy4gF0neGTx2J
	h0No4SmuCXAo7wSEPNWPZ0Fow/dyiZcnKWPT0pBNanUUlGrrBHHN3bcRmgSxsRbDebyvZa5W2M6
	mBPXzMw1RCw/KS2jKvwgHsfMk0zHc1kYZTJ1XUJ5cj91s15yzY/udQhe4go
X-Received: by 2002:a17:907:7241:b0:c26:19de:9138 with SMTP id a640c23a62f3a-c29e5351a04mr213058866b.43.1789568615501;
        Wed, 16 Sep 2026 07:23:35 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-1562-51d1-d5f-82bb.fixed6.kpn.net. [2a02:a463:a071:0:1562:51d1:d5f:82bb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29e801cdfesm105216566b.58.2026.09.16.07.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:23:34 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	hersenxs.wu@amd.com,
	Jerry.Zuo@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Hari Mishal <harimishal1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: guard dc_sink dereferences in MST mode validation
Date: Wed, 16 Sep 2026 16:23:32 +0200
Message-ID: <20260916142332.10394-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dm_dp_mst_is_port_support_mode() reads
aconnector->dc_sink->dsc_caps... for the DSC branch-throughput check,
and get_conv_frl_bw()'s HDMI-PCON FRL-bandwidth path reads
aconnector->dc_sink->edid_caps.max_frl_rate, both without a NULL
check. dc_sink is cleared asynchronously on MST unplug, and both
functions run from paths that the driver's own comments document as
racing that teardown: the connector probe worker's ->mode_valid
callback and a compositor's atomic check, neither of which holds the
MST manager lock that the teardown path uses. The former does have an
existing dsc_aux NULL check, but dsc_aux isn't reliably cleared in
every path that clears dc_sink, so it doesn't cover this.

Fail the port-support check and skip the FRL conversion path when the
sink is already gone.

Fixes: f04d275d94e1 ("drm/amd/display: add mst port output bw check")
Fixes: 5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm")
Cc: stable@vger.kernel.org
Assisted-by: gkh_clanker_t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 045a7f88b754..7261317d4c0f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1231,7 +1231,8 @@ static bool get_conv_frl_bw(struct amdgpu_dm_connector *aconnector,
 	unsigned int max_sink_bw_in_kbps = 0;
 	unsigned int dsc_max_sink_bw_in_kbps = 0;
 
-	if (aconnector->dc_link->dc->caps.dp_hdmi21_pcon_support &&
+	if (aconnector->dc_sink &&
+	    aconnector->dc_link->dc->caps.dp_hdmi21_pcon_support &&
 	    aconnector->mst_downstream_port_caps.bytes.byte0.bits.DWN_STRM_PORTX_TYPE == DOWN_STREAM_DETAILED_HDMI) {
 		max_conv_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(
 				aconnector->dc_link->dc,
@@ -1996,6 +1997,9 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 	struct dc_dsc_config_options dsc_options = {0};
 	uint32_t stream_kbps;
 
+	if (!aconnector->dc_sink)
+		return DC_FAIL_BANDWIDTH_VALIDATE;
+
 	/* DSC unnecessary case
 	 * Check if timing could be supported within end-to-end BW
 	 */
-- 
2.43.0


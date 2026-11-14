Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679375;
	b=Qx3R+VNj1vSmZvIQBDRrcGwU076JU6Wj5CRvzau4eUlMxQkyeAWR7KWIUgKnBPNbN6FP
	 noDA6HJPayEaCswDgo4HscNUeK2wEEhPPWpoZgX4C09GOMcsvXaxKER6N1+xwUhBZ9AJ+
	 rB7x8YpSzwSep5+y2906v4dEVVJ5iQNCQrTCfZ4hkjzcJF6+AOhLElrkQluMNmBeP00wa
	 QaPqMQHTdXROGG+Lah6gh66xybjJ6uRxriRtWtT2J7o974bw5dPFlzcenrG3JKfizcoX1
	 K/JZjVuy+rO2+jIEQLF04s+P3dtD+GL8dHpgsxK64TNuKhmm61z+GqPgsWcNR4uVQfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679375;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BQ1A7JDg3EVpzCoFdjXC0wQ+e6nRiQE0kzNipIbtpA8=;
	b=DfaabGe/GH1TG7YW6Vh8ejG/iDAvPfGoydv1TjPjz5/DhYkkzq6v6V4ZY1ukW1LndR4n
	 y/GCu8kZq70pBhvfd/XDeiGP0SMRwunuCuLkytTZ385fnIepqJf9vTs2nxeb3oNwTg9bN
	 qbm1GZhsfyuf2xYMnWvsLpVecpVmVUK3/11LI/aBEhMcp9dQGgrLThDa9v4nY0lLNu22m
	 j6HbynEuszpVMhIDmgByvEXerAm3MMTD5N5X4HyxsP+yz0dLyT5qy8ke0aSI8mVXd3E3W
	 A0quyMmXbNCfHzHr3k11XcyfSQWAISjcKZz9oZ9TIPvfazqUdTKBN7roK0sCXJHL+wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFJG7mHT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0447606A331
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFJG7mHT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0BA1F000C4;
	Sat, 14 Nov 2026 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794679374;
	bh=BQ1A7JDg3EVpzCoFdjXC0wQ+e6nRiQE0kzNipIbtpA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZFJG7mHTX0gjMs00vWKdiBJR3JDwaZGUMIlu6XaWpwIANBIKJK97R3othB28BAO+J
	 PLFaHGZ7Z3kW5is//vRcQ3ddhGVr5pOJi8HveN/ylf9l+IY9lc4BOSMYji5NrgAW5T
	 9UD8R32CuJqF1ayrzGt2DPJoanZx+fPzrOnwHstba6s922RfloS3K/OvP4Akgep7Rw
	 PN3E6VZIiH7/lnLh6A03hU2kSSgnpJlZFT8KENa1QK4oh8SjJ+t3vgYUivNZlo1RaR
	 rrTueC/Wzsr8ErjYCmJQq6SXFaG8mX+mOtKcYOTzs5ejiFU3HXqLaeoadGQ/+/KVU+
	 k5su5Vxhh6P4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lucas Tanure <lucas.tanure@neat.no>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/vc4: hdmi: enable scrambling before the TMDS clock starts
Date: Sat, 14 Nov 2026 13:02:53 -0500
Message-ID: <20261114180240.176778-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202040-failed-5.15-81383bd290a1@kernel.org>
References: <20261109202040-failed-5.15-81383bd290a1@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lucas Tanure <lucas.tanure@neat.no>

[ Upstream commit 81383bd290a18f06ccf9b0bfb29e1a3ef73d9357 ]

HDMI 2.0 requires a source to suspend the TMDS clock, write the
TMDS_Bit_Clock_Ratio bit in the sink's SCDC registers, wait at least
1 ms and only then resume the clock. vc4 does the opposite: the PHY
starts at the new rate first, and the SCDC bits are written tens of
milliseconds later, at the very end of the enable sequence, together
with the source side scrambler. On disable the bits are cleared while
the clock is still running.

Some sinks sample the bit only when the clock appears. One HDMI 2.0
sink we tested then sets up its receiver for a 1/10 clock and never
recovers: a Raspberry Pi 5 at 3840x2160@60 shows no picture, while
1080p60 and 4K30 work and other sources work at 4K60 on the same sink.
Writing the bit by hand before enabling the output makes the same mode
lock every time.

Enable scrambling, on the sink and in the controller, before the PHY is
started, and disable it only after the PHY has been stopped. The SCDC
helper already waits the required time after writing the ratio bit.

Cc: stable@vger.kernel.org
Fixes: c85695a2016e ("drm/vc4: hdmi: Enable the scrambler")
Link: https://github.com/raspberrypi/linux/issues/7693
Assisted-by: LLM
Signed-off-by: Lucas Tanure <lucas.tanure@neat.no>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Link: https://patch.msgid.link/20261026164028.78792-4-lucas.tanure@neat.no
Signed-off-by: Maíra Canal <mcanal@igalia.com>
[ sashal: adjusted context around the scrambling calls for missing upstream locking, device guards, and newer hardware checks ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 9b540728b8fae..81b12b7c7a7d4 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -622,7 +622,6 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
 
 	HDMI_WRITE(HDMI_VID_CTL,
 		   HDMI_READ(HDMI_VID_CTL) & ~VC4_HD_VID_CTL_ENABLE);
-	vc4_hdmi_disable_scrambling(encoder);
 }
 
 static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder,
@@ -637,6 +636,8 @@ static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder,
 	if (vc4_hdmi->variant->phy_disable)
 		vc4_hdmi->variant->phy_disable(vc4_hdmi);
 
+	vc4_hdmi_disable_scrambling(encoder);
+
 	clk_disable_unprepare(vc4_hdmi->pixel_bvb_clock);
 	clk_disable_unprepare(vc4_hdmi->pixel_clock);
 
@@ -976,6 +977,8 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
 		goto err_disable_pixel_clock;
 	}
 
+	vc4_hdmi_enable_scrambling(encoder);
+
 	if (vc4_hdmi->variant->phy_init)
 		vc4_hdmi->variant->phy_init(vc4_hdmi, vc4_conn_state);
 
@@ -1078,7 +1081,6 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 	}
 
 	vc4_hdmi_recenter_fifo(vc4_hdmi);
-	vc4_hdmi_enable_scrambling(encoder);
 }
 
 static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
-- 
2.53.0


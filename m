Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629624;
	b=o5QLVAsmlzDpdByA99QXqe6H/7tDaGfdPM8Hpgkd/dEwvSa+MScfNtXCG8UwI2WAWxxh
	 vVr6GO0O2kJ3Al6+5vRq9Pecvy0gdKvHRj9f6abjW+zhhkwDlsgGaruyl/CQqOjynF74s
	 Y+37HNpk+1c6oGTOs0HY/mL+edKHo1j9Y1i4cgycvR+CisX5PrhJiJ9KyzIeL1DS0cCzs
	 /eGxIl77xP6p21xSjuVdm0p04n9MyBnRUdXdbVbXY9VpbIU7IZ4YstNf7nGnhVGlLNjrh
	 ntqzA4W8s2WjJf5ClyRP62kDAZBJJBno++62i730t2Czn+sdjr1XMcA1vNx+FjVmpmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629624;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LUzNh4yz5ic5VintqVEeUAaeYEWyZJSwFEUN8cBMGuk=;
	b=ANNd3NDubCfqJpZ11ehABaYTMKyyLFuW12WIlhZbe3cukhCBFwMB3cNQPEdtDUHLFrT3
	 TYxCYWWD4XkQU8NTehaupuV/DkuW7jq8MfAy6piMZQ3uFys7h36Fku0dJlYOgsiOWyg82
	 L3GhfaVKE4zRFexzVHKNkwCEncSFxpO3TK8D4OxSGc2kWOMu1ZFttAqJdTyGONfOUNiXa
	 NgA5pYNzTe/4x+g8C5/oe966xuWn7jrr5fwigmXZpC9IjkvgFT7kJh3eucBVtNtQ6z6T/
	 XIL152JsX5gRI/rcix46NWC89GmVuAY9a7LH5CIyJPiAXgRPKL63k0fB1VM7F5e2EUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SvOnXbWu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1E5606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SvOnXbWu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4271F000C4;
	Sat, 14 Nov 2026 04:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794629624;
	bh=LUzNh4yz5ic5VintqVEeUAaeYEWyZJSwFEUN8cBMGuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SvOnXbWu5OOjf1SnRQcQllr6whWJ39J/EEz91SJEjEctIJ2ZPd/NhZklAFojMIj3R
	 uJagp6g+tsWU3k+Y3vAS0MgfRlniyW6GmloSYptQLB4LaNqNvYpS25tYWfnulTBCCH
	 rKDQDA5Ya1/0SE/T9wG4ZQPemAOaQtjg0CI6Ry8cwAY6ISDcBtixOoiPg53CQUwh4r
	 p+viu9tJQjPy8SBpBxygzskzF4nhCq+GKwbhGv2e4KaNwxIqiK6PkCdKoeOvn/xSyh
	 STC710zmXIfR2JPFe9o5iOAB5cE+WUQKEdKwTyRo80Xml2bCN6gIKHFOb41Y1+0vFC
	 tshvsNKmX/Hxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Misha Nasledov <misha@nasledov.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amd/display: Drop clock requirements on DCN32 when no displays are active
Date: Fri, 13 Nov 2026 23:13:42 -0500
Message-ID: <20261114041304.2801472-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201419-failed-6.6-bba4dc330648@kernel.org>
References: <20261109201419-failed-6.6-bba4dc330648@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Misha Nasledov <misha@nasledov.com>

[ Upstream commit bba4dc3306483335ddbe065c05b2d8359ec387a4 ]

amdgpu_dm builds the new dc_state as a copy of the old one. When the last
stream is removed, dml1_validate() returns early on pipe_cnt == 0 and
never reaches dcn32_calculate_dlg_params(), so bw.dcn.clk keeps the
dramclk/dcfclk/fclk requirements of the display that was just turned off.
dcn32_update_clocks() then keeps those hard minimums applied.

On an RX 7900 XTX this leaves UCLK at 456 MHz and DCFCLK at 637 MHz with
the monitor off, and the board idles at 28.4 W. With this change they
drop to 96 MHz and 145 MHz and board power falls to 15.3 W.

Reset the clock requirements in that case, as calculate_dlg_params()
already does when no HUBP is active and as the DML2 path does for
stream_count == 0.

Signed-off-by: Misha Nasledov <misha@nasledov.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 0261a0ef89f37ef962fbc9dbc724ebf65fe681cf)
Cc: stable@vger.kernel.org
[ sashal: Adapted the dml1_validate() change to dcn32_validate_bandwidth() after its existing MALL state restore. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index ab6b4f44f537c..f85672062af30 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1860,8 +1860,21 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 	if (fast_validate)
 		dcn32_restore_mall_state(dc, context, &mall_temp_config);
 
-	if (pipe_cnt == 0)
+	if (pipe_cnt == 0) {
+		/* The context is a copy of the previous state, so without this the
+		 * clocks the last display needed stay applied with all displays off.
+		 */
+		context->bw_ctx.bw.dcn.clk.socclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dramclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.fclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = true;
+		context->bw_ctx.bw.dcn.clk.num_ways = 0;
 		goto validate_out;
+	}
 
 	if (!out)
 		goto validate_fail;
-- 
2.53.0


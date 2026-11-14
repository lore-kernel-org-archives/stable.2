Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794631392;
	b=LiyJc+pupwSJ7m9BaUJs+OadsK3AaiGF4Uro8CrXfM45wAQE9xdza4dHV/8nLIgwqLpP
	 8N2tn+r5QKcozggdN0uEY1I8V03jSIMrpWIYgYn2EJEfOFqTslUxcvPxAocX8EB/sWLua
	 MOszfkhHUv5yCN2U9jXE9ip6T4WvuRw+DtmQVe2p67ULqM7gRAtuu3oj2E1o4xPYJ9By8
	 LmzkBqzgJ/ZjaK+nWQfH7ov4RhlcH1hHbFwBK7nWU6zSveJwHXSQSeX0PcSCQFMD9m2+j
	 4E/5cVpC/3A6SSOkOxdIjnn2TznXCkxdP2tME9n59dO+j9hYxqnnezpKqgT9ts9sP5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794631392;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rKi8yYYVtSnfS6ryEqVMufvuvaferXyW9UbHfZcmAMk=;
	b=yfVy2dKZ3ur2jYTkxyg0jgQp1m1XA7iCdY6o/XD8BHMonRstumcAP5JWNMd68LYdQoBb
	 e7GxIG+I97X8DnRpQ1V6T7OXn3ESrPAyaYYA92nvFgF5X228uxuf/RUmE/lsy0wjw0DSP
	 7U58uJBhIL20NFInDltCyzzDtoUI1XznhcQjX6NMWvTLnAt7xMqoiK/pBh/fzGVF5noD6
	 oYCJqS9FDpqxXJAgyyybTXLtdCnxxpEWNeOlyJMKHKj+w+9qcgSIIFgT6Dv9+5/n3yvil
	 6FHYchj//Hg5i+eUr1Y1xwR6KnpDBm6BtiOGzyWvPYLF0xxKq73GLz1Njn2EVZvAMcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEhE7Kh1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF590606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEhE7Kh1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6EA1F000C4;
	Sat, 14 Nov 2026 04:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794631391;
	bh=rKi8yYYVtSnfS6ryEqVMufvuvaferXyW9UbHfZcmAMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WEhE7Kh1j4r8pAUWptz/ksVvzTIDObQKFGowGspE2HR5mZztqQMH1RqShKco3sz2N
	 B5mtxUWYvSwd9Xj02GXP/VtCTbcUkohitFno1IwSDULP7aG9zzLOWmzoNebAignHxY
	 dysAd9fl5dKVW83U4bgfp6kf2/sgzkP/TjpXWSoAoDjbr2vu+DGmJtfPE6w84uLvIJ
	 rHbZFwJK57BGz5f0m47VWSgEg1XN2Sgam84PHjhApCIe5I04xXMhKw8JFpqj2H2Plt
	 jfJnBDzJr+McfR9FzwY9MMx9Mw6vMwR2za6WotDFE+wM/D+ZwYq7f1eLd1COoGdW+t
	 XIQr6Xegr5K0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Misha Nasledov <misha@nasledov.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amd/display: Drop clock requirements on DCN32 when no displays are active
Date: Fri, 13 Nov 2026 23:43:09 -0500
Message-ID: <20261114044246.2910453-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201918-failed-6.1-bba4dc330648@kernel.org>
References: <20261109201918-failed-6.1-bba4dc330648@kernel.org>
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
[ sashal: applied the change in dcn32_validate_bandwidth() instead of dml1_validate() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 9f5425e6474fb..3195fe12fc1b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1870,8 +1870,21 @@ bool dcn32_validate_bandwidth(struct dc *dc,
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


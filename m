Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273866;
	b=FGDTaMKz3hIZhoGFKOs3UK8wKl+BK+F8xb+oC8pK3D6+cyJP6Z/Cg01IG41qpL72Gz2L
	 BCgozflr6u5+cuwYCxdOF6qz9/Dd/t+EI/F2bHoPn8l0Vs1eUDDdmgsQ1IXihZGzZo7Ly
	 /sQ0PxNyEVlCoC9VlBbdao8VaoJUJr5EyMvcJFNJ0GNx2obCDWQb82ovNNtnEt4kLxA93
	 Xsfb9NtdZtPJiDdTN50DhhHC2APA04GBCMCzen12QJTpDeM/il80GbLPOk+qKu5tdtaHa
	 KnRDuhRApFIyk2aAP3WF3eucK9nTkti7WiwX7gjEsyiImLba0xhGB/+x+JGXgH8XIxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273866;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eAJe+WjBYToebhkFyTK43by3vhckE02PzbcYel/DnBs=;
	b=QZONyrnCSqajHfVgNMgsr8scoZ4JSQB0t5oCHI61Xfm3LivpyOUccYsbs+02Rsls8dme
	 TH2acN6KbznbtWWSZf7k0SWTUAa443YfK1IUu9ue4+EhtcdNnvsk26quoq2yNX4gH1c2H
	 584QpM44r+j3HqdP3B7yaO/RgwVSaZf8dCJ5x8B7fUs0F1gIkHLjthkD0NGsrPwq2JTG0
	 xG6pfTZo88wneqfdH1shNxefOR4oKtDZ/o43AfyuJU0xDH2TMABDcPC3Gp8R+TndipkR5
	 g6Zq9I6RWRy51wfiETnG6wItEtiJtWQhUHJLwXDNubUk3Oz7iRh7JFRnT0giWK5WsKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BR0tnx6+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA260A381D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BR0tnx6+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F6B1F0089F;
	Tue, 10 Nov 2026 01:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273865;
	bh=eAJe+WjBYToebhkFyTK43by3vhckE02PzbcYel/DnBs=;
	h=From:To:Cc:Subject:Date;
	b=BR0tnx6+gk1C35eGFeT5R5tgMtNbYRk9sP2qD8sqXLU8E1eRUxVvJxR7e1bmmvBJA
	 UDAlRfLn5jcyjOwHJYh/Mpod7BmfRsf5y87d2QGnsqtA+cfItn7XCYIGg0HJReGkxO
	 oWzfMc30EDU6Cpp9zIZtwjCZobwXBpdyYe0kWvJNDqkWAhUZ2wgfBiogNXyIg0ZKsu
	 UhG5TIuCYffGbt+rpL6oIzq+xui9/MMNAtbDvl52qfRQ2qMKVG5AVbh3Oqdk+zuNbv
	 Tzt2jrWZPphK2INY3/rX83pOvhh9FQv7vEOAXMe/m13xW0xRIHkRoH6HLA6c2LdzvN
	 dTZNgK49rbwHg==
From: Sasha Levin <sashal@kernel.org>
To: misha@nasledov.com,
	alex.hung@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: Drop clock requirements on DCN32 when no displays are active" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:23 -0500
Message-ID: <20261109202423-failed-5.15-bba4dc330648@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bba4dc3306483335ddbe065c05b2d8359ec387a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202423-failed-5.15-bba4dc330648@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bba4dc3306483335ddbe065c05b2d8359ec387a4 Mon Sep 17 00:00:00 2001
From: Misha Nasledov <misha@nasledov.com>
Date: Mon, 19 Oct 2026 16:42:32 -0700
Subject: [PATCH] drm/amd/display: Drop clock requirements on DCN32 when no
 displays are active

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
---
 .../display/dc/resource/dcn32/dcn32_resource.c    | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 3a6a489388435..619b9b3362fc6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1941,8 +1941,21 @@ static bool dml1_validate(struct dc *dc, struct dc_state *context, enum dc_valid
 	out = dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, validate_mode);
 	DC_FP_END();
 
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





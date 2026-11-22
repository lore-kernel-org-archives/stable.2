Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795391078;
	b=E9zmDgyENaMwG2M+x64yvxxCNuUszYBJbBv5E8JYWkWXs+3ooeEyVoHutAO03OzorU2T
	 Ybb0FbIOmxrMc7GmJxCRvo20P460tpy5YetwGa/ACAQWm/LYWEOUoV/3+tCRBrQ9s/JTo
	 0IsM3YRajtVo9hXOVd/14JuZaaWGigZx1zApNrjhK33AHNxBX21mfkLE3XvTuOPq71e/4
	 8vsFlNbZM3gabpr5mSPMhjtDrUjpHYq0I01X4FR29WxJETFMvzQDFM2X39DZBO1fC0Kt3
	 NSQl9tXDIcdxdzLGey14WF+2DFoWhjbJm1xvs8AcIQXzvahiw2LAQg3v2E1OKif7lcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795391078;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=k/T26OxvbNctIsKGzjvokIqLK02u3kx0ZSGmrsNkkuI=;
	b=t0nzQS24zFrsoyNYaRw/OWDzctoslSNYUdnTNhqaCJSeLQSOQYReSddzqQKHar07xaA5
	 o8TiziCIpF1C4XXWKCw47WUDl1uPDNT97aHQ5RPh1w/gUbe1OH2c2z4JZjxZ3LYoA0joR
	 wRpxrAu0oBKwMqmgqCuw/vS0zEQz8WA0SdgM18kIX4I0vMWq/p+XcunO/g2eSwogvUwxE
	 JQJ7/haCdOj4YPspWwwZTwWBW0OWRlx0sgMGNB/2UuWrun8plmAwRrB4V7y4nGQd8sBej
	 yfabBfzwyRJ2pAJyLp9Qpdx6R4rXaeg0AHGCYVCo268EqyyQb+IAthv9vssGUEBVR6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=exultantmonkey.co.uk;
	spf=pass smtp.mailfrom=exultantmonkey.co.uk;
	dkim=pass header.d=exultantmonkey.co.uk header.i=@exultantmonkey.co.uk header.a=rsa-sha256 header.s=fm2 header.b=D67+4kaC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=g4iG4yrV;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA6606A31A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 23:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBDA6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exultantmonkey.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exultantmonkey.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=exultantmonkey.co.uk header.i=@exultantmonkey.co.uk header.a=rsa-sha256 header.s=fm2 header.b=D67+4kaC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=g4iG4yrV
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D3831400295
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 18:44:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 22 Nov 2026 18:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	exultantmonkey.co.uk; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1795391077; x=1795477477; bh=k/T26OxvbNctIsKGzjvok
	IqLK02u3kx0ZSGmrsNkkuI=; b=D67+4kaCUB6PKAk8c1gJm/oZmZOr/RB+rPh5J
	f8fIcQmctfEQpwN3mJfYNp6fLrtxWBw85i5iBpZRk9sjb6LjfmHxbQMTr8FYaiBN
	nUhK8F2E2qOTPLIxhKkOmrqhyMkRkjbum+j06+oe02WWy+M4/B7ytYq/7RGezdcU
	aOwFr2ZH8YB/FDCMLx/x0LpMQrTKTKByiZa/cI8DNs2CDEdLs5yJu3Y3lI+Hwlxx
	Vu26qaCmcTsd8KsQKNgFQuPdCQDbxX7W/uWo5KMspU5sVhVOn551f/Rq8KTpejzb
	0A0VHFdcaUQI6PiNMX1ARn/i5drFvMC0R3f7TFbOnViA7e5Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795391077; x=1795477477; bh=k
	/T26OxvbNctIsKGzjvokIqLK02u3kx0ZSGmrsNkkuI=; b=g4iG4yrVJCC9uDwPU
	+gyqPN/KHa2UchUfCnTEee/pK/z1i1vtppq9g2B3xMYOl6zDguE+1qbI3Sh2ZmAD
	6Y3g/wAstksosnwufQMUJuhT2z+Ol35S1S2XZNLiLkRMx+hoSLyLGBJ8ij+Lg3ly
	Agr/R8qporWuZtz4My5I/TpMsMyjpahbrr98KTNevGluI8qJWXqrLmUNUkGHyX0F
	pGXvieNokZ4kJZtcMkMv5VWC4ncbj19+x6XP+Kv5ZFik1ry6XlBLQm9xST50ko11
	xZYKtYh3ktZelIQbXIvHjyPGOwn41cGl4SGPpJcQDd0LtRIfojt1Tl4RpE8CpnMG
	F/a4A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=exultantmonkey.co.uk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795391077; d=exultantmonkey.co.uk;
	mf=PGRhdmlkQGV4dWx0YW50bW9ua2V5LmNvLnVrPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fOfw5FXlAdDOQrBGw8qu9boC5ELu96FQkCAxolWfs1mdW4k
	zEpuxag1B//2Y3Z1xUDy5wLohPKPXM+Yb2ZupLyaKL8p+qsMmscL892EsWuK9VgX
	KfuxsCggCiHMAtJBltIWMYQbyhSGzPHI56DtRWC/PCOTLDR07aVb60OoGd1AeQ+X
	u5bS6EBDkD4vrQX8CCt6URWhvhW81Pc3rppA1lz0VFsu16L5R6HwUfMPwlSgUzqS
	E0EV/S/2G0p/KeH0SvsI9+BbuyV3RSvnC6/xdl1pWXYVi3B5BHfX3oesOh0iYU0R
	Z6ZfApJqEeTL+Ige58YqIBkATv20pGjTbcSWMiw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fOHYAzEW3P8qkxybIoh1URCJLF9/pIbGOREh8QGWm2o=:Bsl5btFfgbKOsXe6vKvtpw4Mv+QDBq2MsHuGMUSy+lE=;
X-ME-Sender: <xms:ZX4Da0c7YYDp6UhbfPHXlIif3NZ7eqngsIB92BgCIVnSAlMykvlazg>
    <xme:ZX4Da7K8qEmnpHYlZDNuY0RgecGJudBiD-uyGwpABxzYsfQ03PioMJFBAorTz6Umn
    hWSC2B6sZNzHGB83B1ecaWfywl0AftMVZsTwhTQq8hFNNHOC020Gxr7>
X-ME-Received: <xmr:ZX4Da5xz-McJOwekptPfj0SiS_OZRJsmvk_TSs_4CdjCh6E7Y90lMtn9YR5NdQjToE4ikIQ>
X-ME-Proxy-Cause: dmFkZTFYWImQZD5h/0h2BDkRJnm+1ULP7PkoTxZhqi02ukXjOFk6st1R0JV8LW2xp1xXP0
    wRcoRn0ncjlsgSsEIAgRXwIjEpdInNWiVEMD9fRNCUNSeUr8+a5+eJy1V6xfO8svGHH2yB
    UBtKsYeRWOSpt7VUzUt3iNrDbnN4BhWbJaewO8TVpMsRJu+soneOayUFOSwnPp6rWhSaiO
    01mPGmQ4Oc7OCJQwmyj0tlNE1MMUqSm3H3ql7tpcvgCqeqaRLbThRg+awU2v9uZyU91X4Z
    EiHXN5mNQmdKYzryyECRusQIuGEaLnSFobRPZxOVqPXkidXO8Zkzg64BPQkKbv55yPs/qL
    XcTC3gxQtkTN3vQW94Auz3bwr7pwxNRUtYMC8geQNquYBjaThWtJ4pxjPsYOY+XoEVALLF
    mpkMsGW8TN/FIkITzEhPMjuVUivTSd43+m7kfTf/2ktJ76mSPMKnJVKnXy4d8ImZg2TkGc
    H4mm70pc6NuaRoUbz3jUUuJdnGBi8xj5j0jT9q1qPg0HhXP5PhuZ3LVzKLXXf8sAKhjlcv
    hDX7IiSusiUx1kvD6eUdDOZ2u66/gg1n4R6E+B4HZprNoKqg7luz/5eHd1LUT2YGa3ZqqD
    JSiJcQfN0tVoX2BW2knpxeXhhD+kp8R4NOCsxgiADgebCxUeL6YyKXUCUW4g
X-ME-Proxy: <xmx:ZX4Da5sXGUphvoFjDyXBzNRULa-w3TtLXrl0rKWRGdHBs5a2MOPPhw>
    <xmx:ZX4Da0BLzw0baDk7pLWOsvIGGPsPVAlDr0Ygpb047rjMNNYxAhgYEw>
    <xmx:ZX4DazFxqnV8gHkKWbRm80ZAgJqndqoYMyAt4GJ_iO9JR6kKeUDXVw>
    <xmx:ZX4Da8BwFobpUS1r8IgThpka2NmXUdqRVfeOM8gkDBGQRj14lnl2-g>
    <xmx:ZX4DayJh92SnY0rrQh5ruKzRfe5DND5pxCX7jOICFIBKpxO-LfhwBSql>
Feedback-ID: i8d5147ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 18:44:36 -0500 (EST)
From: David William Richmond Davies-Jones <david@exultantmonkey.co.uk>
To: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Krishna Chomal <krishna.chomal108@gmail.com>,
	Julien ROBIN <julien.robin28@free.fr>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David William Richmond Davies-Jones <david@exultantmonkey.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] platform/x86: hp-wmi: Move OMEN 15-en1xxx (board 88D2) to feature board list
Date: Sun, 22 Nov 2026 23:43:51 +0000
Message-ID: <20261122234351.278694-3-david@exultantmonkey.co.uk>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122234351.278694-1-david@exultantmonkey.co.uk>
References: <20261122234351.278694-1-david@exultantmonkey.co.uk>
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

On the OMEN 15-en1xxx (board 88D2) the GPU power limit stays at its
80 W default in every platform profile, including performance, and
manual fan control is not available.

The board is only listed in omen_thermal_profile_boards[], so the
driver uses the Omen path and sets the profile with SET_PERFORMANCE_MODE
alone. The firmware's handler for that (GM1A) stores the mode byte in
EC register 0x95 (HPCM) and enables NVIDIA cTGP only for the v0
performance value 0x01. The board reports thermal policy v1, so the
driver sends 0x31 and cTGP stays off.

HPCM has no other consumer in the DSDT or the SSDTs. On v1 the firmware
expects cTGP and Dynamic Boost to be set with SET_GPU_THERMAL_MODES
(GM22), which writes NPCF.CTGP and NPCF.DTGP directly. NPCF only
reports the cTGP offset (ACBT = 0xA0, i.e. +20 W) when CTGP is set, and
Dynamic Boost only when DTGP is set. The firmware also implements the
fan speed get/set and fan table methods (GM2D, GM2E, GM2F).

Drop 88D2 from omen_thermal_profile_boards[] and add it to
hp_wmi_feature_boards[] with the omen_v1_legacy thermal parameters,
matching the HPCM offset at 0x95. The board then uses the Victus S
profile path, which sets cTGP and Dynamic Boost according to the
profile, reads the profile back from the EC, and enables manual fan
control and the fan table.

The firmware's SET_POWER_LIMITS handler applies HP_POWER_LIMIT_DEFAULT
as a 0 W CPU limit, which held the CPU at its minimum clock on battery
in the performance profile, so set no_power_limit_reset for this board.

As on the other feature boards, the available profiles change from
cool/balanced/performance to low-power/balanced/performance.

Tested on an OMEN Laptop 15-en1xxx (board 88D2, BIOS F.20, Ryzen 7
5800H, RTX 3070 Laptop GPU). On AC, nvidia-smi reports a 100 W power
limit in performance and 80 W in balanced and low-power, and each
profile reads back correctly. Manual PWM, maximum and automatic fan
modes work through hwmon. Under full CPU load in performance, package
power is about 25 W on battery and returns to about 50 W on AC. Without
no_power_limit_reset it drops below 5 W at 399 MHz on battery.

The firmware analysis and this patch were prepared with the help of an
AI coding assistant (Claude Opus 5.5 in Claude Code). The result was
reviewed and tested on the hardware by the submitter.

Link: https://lore.kernel.org/platform-driver-x86/CA+LW3S2g4E971by7WhfFZGuyLT47141_Zn+eJ=wyqxB_+4G95A@mail.gmail.com/
Fixes: 286e937efbc7 ("platform/x86: hp-wmi: support omen thermal profile policy v1")
Cc: stable@vger.kernel.org
Signed-off-by: David William Richmond Davies-Jones <david@exultantmonkey.co.uk>
---
 drivers/platform/x86/hp/hp-wmi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index c7960de7ac0f..f29bdf9639b7 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -184,6 +184,12 @@ static const struct hp_wmi_board_params omen_v1_legacy_board_params = {
 	.fan_profile		= &victus_s_fan_profile_params,
 };
 
+static const struct hp_wmi_board_params omen_v1_legacy_no_pl_reset_board_params = {
+	.thermal_profile	= &omen_v1_legacy_thermal_params,
+	.fan_profile		= &victus_s_fan_profile_params,
+	.no_power_limit_reset	= true,
+};
+
 static const struct hp_wmi_board_params omen_v1_no_ec_board_params = {
 	.thermal_profile	= &omen_v1_no_ec_thermal_params,
 	.fan_profile		= &victus_s_fan_profile_params,
@@ -214,7 +220,7 @@ static const char * const omen_thermal_profile_boards[] = {
 	"8600", "8601", "8602", "8603", "8604", "8605", "8606", "8607", "860A",
 	"8746", "8747", "8748", "8749", "874A", "8786", "8787", "8788", "878A",
 	"878B", "878C", "87B5",
-	"886B", "886C", "88C8", "88CB", "88D1", "88D2", "88F4", "88F5", "88F6",
+	"886B", "886C", "88C8", "88CB", "88D1", "88F4", "88F5", "88F6",
 	"88F7", "88FD", "88FE", "88FF",
 	"8900", "8901", "8902", "8912", "8917", "8918", "8949", "894A", "89EB",
 	"8A15", "8A17", "8A18", "8A42", "8A43",
@@ -251,6 +257,10 @@ static const char * const victus_thermal_profile_boards[] = {
 
 /* DMI board-specific feature data for Omen and Victus laptops. */
 static const struct dmi_system_id hp_wmi_feature_boards[] __initconst = {
+	{
+		.matches = { DMI_MATCH(DMI_BOARD_NAME, "88D2") },
+		.driver_data = (void *)&omen_v1_legacy_no_pl_reset_board_params,
+	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8902") },
 		.driver_data = (void *)&omen_v1_legacy_board_params,
-- 
2.56.1


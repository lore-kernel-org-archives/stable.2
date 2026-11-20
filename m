Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168247;
	b=Z74X5abjvZvQOh3pRXUF9wHY2Z/yzVrVYd3BpcNsKLsoxxgwjj8G7wGPhR5i441Nb8Vl
	 0a4sSURA2EWeiRGSzH7TYPhkslNL3MuHcunv/wbXizNIP2jfhMoA8CTGCPD1mVQbo0hdn
	 PsA/UeImwQkqnMMPqTI8T3jIM5Je/yyFpuTuMNMzZPqawYPyDiLULncfWdtflpnVCmXkn
	 kZqUeVGE9OmbxkJm+pTN+mXsXbHoVLrOWBB6dkYepBuxhshXpp3yW1Nk18O9wOOuIXJWa
	 jbqFvHyVkP4ltt8tN3N24hSKgtfgM3ReO5MXF8sDW7Leth1Bh3OlnxI0efwhFonF7Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WOQs529wfwZg9+FQPgn5SX1Fg1ItGESbnuJKD7SUyuI=;
	b=vGuWFXUiaYB5Fvne38kBCG1i0kObk/Xuzur0ft1X2Ur3U3CpAq1W8dc4o30IgOq0WWsb
	 FO+Bg/gaa506z5DerQ90RvJ1VfokeLtjavCO6ClcKCQ0ynExkf1vftHtESg9yJa9gkOaf
	 OSu5Vz2kLpOkJJQB1COdUqANTlK2JSRnRL5tYFqfIasNOJF0UbcwTmOkV5YHQN/CvTI7C
	 /UbUD+/qGlnzqL2ZnPtdRHv21DptjIGwAGEoBx5NvmJlLK9mhu6kaCCTDlCPGfFwa+WLy
	 w72nN/+VOWWX5ZDQhP4YE/f2ME88r+yclgcqm9kmuTuIkqbdvcoP7nocl2+kwvb1GiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aMA+t3x4;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345D606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B345D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aMA+t3x4
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c1c0c8d61aso340749e87.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795168245; x=1795773045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WOQs529wfwZg9+FQPgn5SX1Fg1ItGESbnuJKD7SUyuI=;
        b=aMA+t3x4Kwd5kHHjoafAEiy1AHYI4fIKiG5ZJxIxzHB1Rgv4fB0e48p9hk/rr/zUiU
         Xy+kdQ4WG10SttfUxlEEZ2XSZv62P7eq6EID1fJJBVOrHAT550D8mLSyt6br/TDY3T19
         XJgaDpsh9Rx4hb/F+xjSB65F78Yy94qckNSFpNbX00Z3zS8zub5GvTTRcfWGhiwIxHFC
         V4V8Rgj5DOAcKyTv2tK4UDgda7vup1fRRnP2ta5GjzU7+GhNBF7gp1d4miqpwgS82Isx
         9/2iJgTihbdX+btD6yQySINakP6JmyiaUW0xWiZ1ojl27wZZRIKGVQ6LaR8lL7Bl7Mry
         rekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795168245; x=1795773045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WOQs529wfwZg9+FQPgn5SX1Fg1ItGESbnuJKD7SUyuI=;
        b=di5GmXssrCpIjy44P36pC5ybR1CQQt2T0wpP86eJCxXUjNNEJkYk+/q6j5Kb8pJfkB
         m6zQ1LZumA/7PYh4bLp9N/IZtIObzoviMidcqMnh2WCtTOCkY0rsi+EpKlb+l68VG6Yw
         7TT/iGioYvHhlleeN//0272Iupu4l0PZopcDJDQ4merOUsoTaePFCe591taol9pXJ937
         VrGCf83hWHLatCJAppK4yUVyZHjVoo+j9kPcu7/gqCddL3/vqypMQidSwPfF2stpCzW9
         Q5TaaSgBGOKHelP0bYEpThaTq4WhwAHuawCeFJpYEr02/BfdRgy112X2V0J+4SDlGnjD
         I+Bg==
X-Gm-Message-State: APuU4Z9ScdpEA0IxLJ+rbg3Y8VTw1KNuXUoSk+Vt12I8n/VegmPQc6S4
	8FKuisb9/5/rjm1FAwV2Cuaj3mvKwLpxE8PYStPl8zBCQfpsl4WF0hpso063Nw6Q6WQa3XSe
X-Gm-Gg: AZFdTZe9kcgFY14lzM+sWrVSz1v+Lq3+zg30NC8mFHC1PDI0u/xk1044KF8+/E7ASIy
	N6RyEYYAz3RQ1EInXezsgl0iPlexkYVqFlEkD6/FSFAgqQWGZfxWqszspCJ5+kqetvufQ2S/Wmx
	zfkH6Irf8W27Y2S5nNp9I1+SbgRega+X/xl+5BhP9Hy2wYDUlZIbHvusrjVwhgS7kE3SM989Z0H
	e5CFPgMg1rCv0IE8jRTM3AqqoCNqWHZKIBIsC1zabyntQhACkNMMySGSeK3Pm4ahGxv//WYspU2
	aboc/S6wMAZD/I4hu+sBY8ExPBbHNE9qBwvHvmn8bkmzUw+u6r9GgzdW7Ka4YPfAnqk1oyvflmm
	Cy8YdvEzPd3peTZdEYQQvjB8sz6UDb75POpa0X/prmX9VmNgQMxNbAf/VQmlQ7do1QM4jc9jKqy
	wTrmWuFc5ut+phjeznjT265S4we3MpGubwOd4hIfQnDrmeVYIGpBA81IO8Z0+13lDp7G+bQb6Cx
	PmII+5cpO0/dH2wIu0lX+spaFYNV+FTN2JHiQK1fG9Jx53KayjFBd+Z2zfYIxB0a9IuWhUbf3+o
	wxiJtS6zC1fV/FTfJ10xds0WTsmtpOcmI2jAmJwxB86dPYYOalBUPC17Z5t8kuoyLirCMMYVYWO
	Cy2ptBwoWl+bNeTNvAQg1/2x3vWM=
X-Received: by 2002:a05:6512:2c9b:b0:5c1:57b6:c791 with SMTP id 2adb3069b0e04-5c1bc554b54mr849853e87.0.1795168244589;
        Fri, 20 Nov 2026 01:50:44 -0800 (PST)
Received: from DESKTOP-DIIS71I ([5.18.141.223])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd017803sm434489e87.38.2026.11.20.01.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:50:44 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	lvc-project@linuxtesting.org,
	deeb.rand@confident.ru,
	shda@confident.ru,
	kernel test robot <lkp@intel.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH 6.6.y] drm/msm/dp: Avoid division by zero in msm_dp_ctrl_config_msa()
Date: Fri, 20 Nov 2026 12:50:40 +0300
Message-ID: <20261120095040.453-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit f185076da44c774241a16a82a7773ece3c1c607b ]

An (admittedly problematic) optimization change in LLVM 20 [1] turns
known division by zero into the equivalent of __builtin_unreachable(),
which invokes undefined behavior if it is encountered in a control flow
graph, destroying code generation. When compile testing for x86_64,
objtool flags an instance of this optimization triggering in
msm_dp_ctrl_config_msa(), inlined into msm_dp_ctrl_on_stream():

  drivers/gpu/drm/msm/msm.o: warning: objtool: msm_dp_ctrl_on_stream(): unexpected end of section .text.msm_dp_ctrl_on_stream

The zero division happens if the else branch in the first if statement
in msm_dp_ctrl_config_msa() is taken because pixel_div is initialized to
zero and it is not possible for LLVM to eliminate the else branch since
rate is still not known after inlining into msm_dp_ctrl_on_stream().

Transform the if statements into a switch statement with a default case
with the existing error print and an early return to avoid the invalid
division. Add a comment to note this helps the compiler, even though the
case is known to be unreachable. With this, pixel_dev's default zero
initialization can be dropped, as it is dead with this change.

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Link: https://github.com/llvm/llvm-project/commit/37932643abab699e8bb1def08b7eb4eae7ff1448 [1]
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601081959.9UVJEOfP-lkp@intel.com/
Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/698355/
Link: https://lore.kernel.org/r/20260113-drm-msm-dp_ctrl-avoid-zero-div-v2-1-f1aa67bf6e8e@kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
[ The function is still dp_catalog_ctrl_config_msa() in dp_catalog.c in
  this tree; same change applied there. ]
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 5142aeb70..1b240b54b 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -445,7 +445,7 @@ void dp_catalog_ctrl_config_msa(struct dp_catalog *dp_catalog,
 					bool fixed_nvid)
 {
 	u32 pixel_m, pixel_n;
-	u32 mvid, nvid, pixel_div = 0, dispcc_input_rate;
+	u32 mvid, nvid, pixel_div, dispcc_input_rate;
 	u32 const nvid_fixed = DP_LINK_CONSTANT_N_VALUE;
 	u32 const link_rate_hbr2 = 540000;
 	u32 const link_rate_hbr3 = 810000;
@@ -454,14 +454,26 @@ void dp_catalog_ctrl_config_msa(struct dp_catalog *dp_catalog,
 	struct dp_catalog_private *catalog = container_of(dp_catalog,
 				struct dp_catalog_private, dp_catalog);
 
-	if (rate == link_rate_hbr3)
+	switch (rate) {
+	case link_rate_hbr3:
 		pixel_div = 6;
-	else if (rate == 162000 || rate == 270000)
-		pixel_div = 2;
-	else if (rate == link_rate_hbr2)
+		break;
+	case link_rate_hbr2:
 		pixel_div = 4;
-	else
+		break;
+	case 162000:
+	case 270000:
+		pixel_div = 2;
+		break;
+	default:
+		/*
+		 * This cannot be reached but the compiler is not able to know
+		 * that statically so return early to avoid a possibly invalid
+		 * division.
+		 */
 		DRM_ERROR("Invalid pixel mux divider\n");
+		return;
+	}
 
 	dispcc_input_rate = (rate * 10) / pixel_div;
 

base-commit: 5139929c698c273e07cb0635732f6a918a7b8e78
-- 
2.39.5


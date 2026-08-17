Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349683B05B0;
	Mon, 17 Aug 2026 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958035; cv=none; b=WzuKUsXbZSCg+c+ajPXxEzbLDGnsGTkmuZ4L1WD5H+GEZkXg9F+winr8Rhk5x09qA0jHnNGCij3bXkX5CpdvKfBkuIK3DcnjS1aoFdBK7uJ2hJYXTC8WENKJLZe6S7RMJ6NjPjK/cJJConm6Zz9LGcpRJflFB9nTuS8CKvN9+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958035; c=relaxed/simple;
	bh=5Om0KDafbxct0D1SbRb8mK7y4FLagftx9IrB+Xdqzks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uxUL15gdpovTaIWDmNvGKPMvEXicj8P9eYcl/cvAYlkpLsAEzUSCVaZ+tAv9dgPIjGpNWyqYB38OwgQtqxG+ZrgcsjSjJdMaIN7CJw4ck86RKPimDUNLLDBk4ywCA7dhtHh46aSEAGX0k+mJoTxiVSNTjGtXjVBiWb5hpuRT4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hq2Ov5UN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq2Ov5UN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0012C2BCF4;
	Mon, 17 Aug 2026 09:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786958034;
	bh=5Om0KDafbxct0D1SbRb8mK7y4FLagftx9IrB+Xdqzks=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=hq2Ov5UNVMJY+CGvqDvucK0CfSQhJb25EhSVg+3cmWSPgsivj+5fZleDPqPXWhDse
	 ZKPzHLi7c96L0irooFzzPT84MHstnRvP1A4/Yh+gUJQOgY3U+RkX4UHUDuFzTBLc0s
	 Hz1A1bg+gD0xHu7Ch4wHgFvHnQPqmofthLQ63B+jf3gtOjmDb5FThcX4L8lKN8Y/t/
	 eJ+XkT84psx231pJbZt5VTtlyfDEmzS5JNTs2B7+p5jZDbCzOEk3PG6tPt3AVbV3U3
	 LxRJyHyJohL9TgSK0nigqPxbqcaIqbbQDrr5oZMJLQfv0e4Tm6WnrLiuFU2porJPyB
	 N0GaYJY3RRRNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84581C5DF70;
	Mon, 17 Aug 2026 09:13:54 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Mon, 17 Aug 2026 17:13:53 +0800
Subject: [PATCH] staging: sm750fb: do not program the PLL from an
 uninitialized value
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-sm750-fixes-v1-1-978c617e5a20@outlook.com>
X-B4-Tracking: v=1; b=H4sIANDQgmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0Nz3eJcc1MD3bTMitRiXRMzMwsTy5TEtLTUZCWgjoKiVLAEUEN0bG0
 tAHPAqKhdAAAA
X-Change-ID: 20260817-sm750-fixes-466849daffec
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, 
 Teddy Wang <teddy.wang@siliconmotion.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=HRMgLoAPLRsSpD1hPS4ZSJd8u0h8YfDKEqXGyACQ3KI=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrKYLF7+ZplxYUJTrlGCg+81odz9f3BKDHbNut7Mu+
 iG7vlOizryjlIVBjItBVkyR5XjBpW8Wvlt0t/hsSYaZw8oEMoSBi1MAJpJ4ipFhrV/XRqlP5zV/
 r9CNe7M75Nnd6e+TVv6Y0lm4Ye6BTg51DUaG21+/N/kUh97OmvvB46iYR4ChVFHRtWVsnJNjd1U
 J3JBnBwBydUz9
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

sm750_calc_pll_value() writes pll->M, N, OD and POD only when its search
loop finds a divider combination with 0 < M < 256, and returns 0 when
there is none. ddk750_set_mode_timing() discards that return value and
calls program_mode_registers() regardless, so sm750_format_pll_reg()
reads the four members uninitialized and pokes them into PANEL_PLL_CTRL
or CRT_PLL_CTRL. Nothing bounds var->pixclock on the way in, so a mode
set can ask for a clock the loop cannot represent.

Consume the return value and reject the mode; hw_sm750_crtc_set_mode()
already propagates a non-zero return. Initialize the structure as well:
sm750_calc_pll_value() returns early for SM750LE without writing the
members, and returns non-zero on that path.

Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 7163232c0701..5ff5226fe77a 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -205,12 +205,14 @@ static void program_mode_registers(struct mode_parameter *mode_param,
 
 int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
 {
-	struct pll_value pll;
+	struct pll_value pll = {};
 
 	pll.input_freq = DEFAULT_INPUT_CLOCK;
 	pll.clock_type = clock;
 
-	sm750_calc_pll_value(parm->pixel_clock, &pll);
+	if (!sm750_calc_pll_value(parm->pixel_clock, &pll))
+		return -EINVAL;
+
 	if (sm750_get_chip_type() == SM750LE) {
 		/* set graphic mode via IO method */
 		outb_p(0x88, 0x3d4);

---
base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
change-id: 20260817-sm750-fixes-466849daffec

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>



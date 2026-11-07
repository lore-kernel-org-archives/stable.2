Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050881;
	b=z31Z1kBYT7WL075a+CBb+4qoKKH6YFT4hHH5tuu4RLM6Qlx+L/Il9KUQ66KUHOcA4adv
	 4C9PfCErovGeZehGC5yCbDeccSYRpNu16jRZhoFixqVLunSB+S4LKNsvg5KNUgEVGBMjL
	 y2oHd+g1ueNdQhv2yyN4VbuRkzQOdn2TBwkbjyoxLnycZ5hLaBKujwL6+bcjhayhxcdJp
	 4pts40jkH9eubnWjrr00Mi4dz511e3qeNd/c+7IhhtqhZFQwT+4nyLWQKnLSJI1CNE6kC
	 BkIR8VQawLUJkaksZ1DKFOBaJqMnRI8aD0/m+6Tp87xexoNyaZsqvCKs6UHSYbyCSqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050881;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=35uncV3b4N4JkRM0yYItd1NgRbOpzVMRxU+UNa3RpxA=;
	b=xIczRJvIU6N6wa93NtaPyKq+MJfQQhFySykql+Doy9TtWpXAb1IBSmRbYp2OXvp0umLI
	 mzf+cFf8WTA2BRde81vWiFbz7hWDX55qilIMu+TSU8EzAPa9GiuZ7sXsfja3GHv8XMeWW
	 ucLtm1NCoBAjxLU3WGBzNn85sYDW2Pv9sHX+4XzABBbvNWbtrLvAmIx/eg4oKPF/jdmb+
	 EKUFj0zqhNx1d+KQNnCQCFDLWYEdyyRXPAWiIMfPc06TnH4z26mMlE5xRMvyZATxLr+7T
	 oIAaK/Rl5xAVGSThw9BoU14/yQ8+SApj3mVT3MwyPM4fvv/jlgd95qsjpEFqehfYRow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuAGgQnH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB6606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuAGgQnH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681121F0089F;
	Sat,  7 Nov 2026 11:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050880;
	bh=35uncV3b4N4JkRM0yYItd1NgRbOpzVMRxU+UNa3RpxA=;
	h=From:To:Cc:Subject:Date;
	b=kuAGgQnHwxflSmkc9InhDtSX5Cq20dTwWyRPEK7BVVsSp+s0CH30GkJ7EZh1WG/yU
	 tHH2h3BIKc2PvaB/jzUrY1yjCa8MlgoL9mKy+QS5K2B1Tjj82SdT1pcfBd+rIMGbbG
	 uf2tzaF+XYS2D42WkwjLDLiJf0nwjZDl/Gdtq+R/Ob3BnP04m+SBjIsjaf/x+YPLIr
	 ADpsQRKPtOy97qQxJig2J46Asjsf+ki2M5KOnfa1g1MIgNo0t0AI8a5MepOQZw+SbE
	 XCJ934CJONYh8B/fPNqz9kmZBo/rLbu24vodh+nVx6Geqn8yjrHZh200RhHg+RViIy
	 i+rjdtCrRot7A==
From: Sasha Levin <sashal@kernel.org>
To: a.kazinsky@ideco.ru,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:27:58 -0500
Message-ID: <20261107062758-failed-5.10-8cf9607d2d85@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8cf9607d2d855629260fc78e6b54ea7a98525708
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062758-failed-5.10-8cf9607d2d85@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8cf9607d2d855629260fc78e6b54ea7a98525708 Mon Sep 17 00:00:00 2001
From: Alex Kazinsky <a.kazinsky@ideco.ru>
Date: Fri, 23 Oct 2026 17:08:52 +0400
Subject: [PATCH] ASoC: tlv320aic32x4: Prevent division by zero in divider
 callbacks

A zero rate requested through clk_set_rate() or clk_round_rate() reaches
clk_aic32x4_div_determine_rate() when the minimum rate is zero. Clamping
the requested rate to the allowed range leaves it unchanged, causing
division by zero when calculating the divisor.

A zero parent rate can also cause division by zero in determine_rate().
For example, if reading a parent divider's register fails,
clk_aic32x4_div_recalc_rate() returns zero, which the clock framework
caches as the parent's rate. A subsequent rate request for a child
divider receives this value in best_parent_rate. With a nonzero requested
rate, the calculated divisor is zero. It passes the existing upper-bound
check and causes division by zero in the resulting rate calculation.

The set_rate callback can receive a zero rate when an ancestor's rate
changes. clk_calc_subtree() calculates descendant rates through
recalc_rate() without calling their determine_rate callbacks. If reading
a descendant divider's register fails, clk_aic32x4_div_recalc_rate()
returns zero. This becomes the descendant's new_rate, which
clk_change_rate() passes to clk_aic32x4_div_set_rate(), causing division
by zero.

Reject zero rates in both callbacks and reject a zero divisor in
clk_aic32x4_div_determine_rate().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a51b50062091 ("ASoC: tlv320aic32x4: Model DAC/ADC dividers in CCF")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
Link: https://patch.msgid.link/20261023130854.93639-1-a.kazinsky@ideco.ru
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index ad15ce9c60791..27d186c72315e 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -318,6 +318,9 @@ static int clk_aic32x4_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_aic32x4 *div = to_clk_aic32x4(hw);
 	u8 divisor;
 
+	if (!rate)
+		return -EINVAL;
+
 	divisor = DIV_ROUND_UP(parent_rate, rate);
 	if (divisor > AIC32X4_DIV_MAX)
 		return -EINVAL;
@@ -331,8 +334,11 @@ static int clk_aic32x4_div_determine_rate(struct clk_hw *hw,
 {
 	unsigned long divisor;
 
+	if (!req->rate)
+		return -EINVAL;
+
 	divisor = DIV_ROUND_UP(req->best_parent_rate, req->rate);
-	if (divisor > AIC32X4_DIV_MAX)
+	if (!divisor || divisor > AIC32X4_DIV_MAX)
 		return -EINVAL;
 
 	req->rate = DIV_ROUND_UP(req->best_parent_rate, divisor);
-- 
2.53.0





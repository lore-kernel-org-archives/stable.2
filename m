Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBAE3B42EB
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909990; cv=none; b=JhPa8g9S8QWuX3GbQKuKmKytuQX5lnKLAEdIRAQAuiSrMP/R4nGf9HgPpZMM68eO8GivSYsBswMtaDnM6jgzgnvD/MvIv9AYOr5mjraBvo3CJdgSRnia5m0kUgbXrg3cQEeWUREMu+9RJjBWk3oDN9wwqY6ydaGTWJqvxQXHm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909990; c=relaxed/simple;
	bh=RD+oTohkTRRLS3idQ7xFsvvlEtc2j4K6WcRpGq9VigI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=twyXUPYd9HlPGs3C/WgzntXBU5kRgkvI+Z/ji3xacTtLoDnTlFlhq0tD9fnN6LLPZpSwWyA6OQtosXRxC3BgbgJVQyEgAZhPrTrZrKHzaiiBxqDsuTAAMx217pzW7na+t2TxTVcoxCdzV5QaH8W0NQai7icQzpTNRMtzQ0nFHP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=GWI4cTyl; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="GWI4cTyl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1780909980;
	bh=gkEGl6klor+eq4IPgefmvgOhe0uBLMOYG1nnW7uhDxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GWI4cTylkYtZZWPOHcZMlO1z4FIl7xtCFxBAbaNp10kIWnINLKZHNNJ3hRLRS/M7H
	 74zm/KPXMbIcoSBypmlRV2Max1FoXUkZRQjsd6O/k+9n4MrEKoBd+iIZC75WmOj2kE
	 CuZZSRRLoFR5PfGCLvOKjxUCepLUPIHxtLWX9g2c=
Received: from chafi-Matebook-Ubuntu.. ([117.25.98.102])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 32F830C7; Mon, 08 Jun 2026 17:12:47 +0800
X-QQ-mid: xmsmtpt1780909979t5qps3k3l
Message-ID: <tencent_F96A6D2FFEB6459BF167B2F2F27E8B016C06@qq.com>
X-QQ-XMAILINFO: NsH3EniEpYuY++gQphxxtp/UKwZBf4XhDzLzDtrRZifbrTQvBxvaNEq0FlYZbL
	 3qBQKHdMw5W4QsLhqXaGMdfm39g98LLduA+c5gFDTrPAGre/FTj/68z2V3QbOvIWEea1Tml0OYKZ
	 0e2K0fuB8TX3h6PpQi0C9D7H31XmQ+DZb4aQau/sAOvyZEe8/KhklLVHUhrGU+PG/kFAlSMvPowR
	 jKJZ90m8aAcjQP2iDOjwCaQjyu8Mp4U+YL0SVLENDPsSQ6yIxDrOMLobvM3TghuPDgN/y1s5TnGu
	 iPm5Oo4hmGU98luxc2/4W6z0URNdTbKCeD1f0FP76Qk00QJGb9kN7h9FjPW5o1QuJpCX4xIGyF7Z
	 XF5yA+vE+9N1kw0ul2cnJnI4Q312pwmS5kDolmJ6kyUVznoE6OZbxmREmMNSL3RnKxT3iJM0NlC/
	 7PfR0q2aWT25nZ3ycYymyACUujfkLtsu4QRzCA2fMkBtD46b+xVpiMHiDDljU79PrH8KsxODZ+/u
	 w7on4AMawXrIO+0SURa/Gq4N0DNlhp9Dpc6WiIdhd6uD6xeVsOkscOM5KeKKrDRg33GSZ/wtcyr7
	 vqyzmRCjxwDyWacQ80+lTJ64PJ+OFZNKRas8FrcqWNKDkGeTzlyViWMY1upQZoYOJ64OODUntFVd
	 ZA08suZCY/AvfTBoy1ughid9o6a0TKe/ie1nErLzvBnoPIrlbFS+x68XNCIL0+QvzP015TZD9XL+
	 05fjlVyFgcP3KDwiLGhTSGiDcTDICKMxHtUcVyHVH51M/Yf8i0NTHXw3SJw4BUqlCSfYp5Eng1J9
	 r/l/HINXICrBL2IBjilcbeenPxfF5aNMLX/JUpcCQrNRL5UeiByLqbAD3WYBf5jF3mUwzFIAT3G2
	 7FqyNNYCVnsKJBOOskMH9NoCcTOqyn+dKYtTw5woI+fxNyeugH5YE9lfeIbiry01q47d3z/XAh8x
	 PdqWtk9xgbG/TXJnDNRWQ6N/qvfqcNn1DCJShy80Whwe1HCUlNwwfEoXdrHKsceeZIJ2qwHLxV1z
	 /DqzRI52XYpXnlmqga7620aSnnqZ6Kc+/edfo7951LHBZuTexx
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: chafi <chafiprc@foxmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Yu Zhang <chafiprc@foxmail.com>
Subject: [PATCH 3/3] drm/i915/dsi: Fix TE pin configuration for dual-link DSI
Date: Mon,  8 Jun 2026 17:12:44 +0800
X-OQ-MSGID: <20260608091245.462464-3-chafiprc@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608091245.462464-1-chafiprc@foxmail.com>
References: <20260608091245.462464-1-chafiprc@foxmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Zhang <chafiprc@foxmail.com>

gen11_dsi_config_util_pin() skips UTIL_PIN configuration for any port
mask that includes PORT_B. For dual-link (PORT_A | PORT_B), PORT_A
still needs UTIL_PIN as TE (Tearing Effect) input. Without it, vblank
interrupts never fire and flip_done operations time out on command
mode dual-link panels.

Only PORT_B-only configurations should skip this step, as TE comes
from the slave DSI1 through GPIO in that case.

Fixes: 963bbdb32b47 ("drm/i915/dsi: add support for ICL+ native MIPI GPIO sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <chafiprc@foxmail.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index f579cba28..cb60aad92 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1113,7 +1113,7 @@ static void gen11_dsi_config_util_pin(struct intel_encoder *encoder,
 	 * for dual link/DSI1 TE is from slave DSI1
 	 * through GPIO.
 	 */
-	if (is_vid_mode(intel_dsi) || (intel_dsi->ports & BIT(PORT_B)))
+	if (is_vid_mode(intel_dsi) || intel_dsi->ports == BIT(PORT_B))
 		return;
 
 	tmp = intel_de_read(display, UTIL_PIN_CTL);
-- 
2.43.0


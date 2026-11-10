Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355172;
	b=X27jxB7MxlPrXvkKOHfqO2gNUYQX+XB3S+JeYuNhB6j/DjkUdwC7ksCI2WcgpgG+XgdO
	 Ldqf9KS5N6i2Y22sSkHCtKjUrjNsO0iief/rndqGuqWBujov5jguCTRV9UsALXdiE6y2c
	 FAape8BbBVMzo2rVeH0lmdAF3laigT4Ro3GC+2dARbwqV6WmUClUxsyzuE0TOH+/ppmDD
	 ya5tF7XWQ1kXmlEcf4J6AEJVu948IBcHKSXUnZQJmmngzCxovQrzN5AvSLMPBAA9mFSzp
	 TeLvoJ9+vaj/TTF1p7Q9KGPxKHgf/RZ5HriIf51OWnXaSKPbpFHJRIoWpqs7+ErNigw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355172;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kd3WHtYBe0p/JEd1nYrwGS9G9hl17mtDaDCHfouK9qY=;
	b=kvJMxqAmazLew6biEZ/16soRJg0iJtwAD0HE9O/IKKJLfT8k+F0yDOPpkxoTteGz5CJP
	 AJBL8UdOlSAo4mhtWhyAzUphtQfC60H/8jv9TdSblouHLDRzIJe1l+cDRvkdxCHIfELtc
	 S+S7eweVWWfSE8KhRSLUOgV+QAvHPVQ3PTQsgWL92Q74huFG3VNxFNenXQgnawpck0kP5
	 a9Y81U+hVkcXT6vTPTeuhe2eo8dWyS94pRUcd8636z3+kLJp53Yg8wUlbA1Pgi2Gp73+O
	 WFcOqWjkqQnWU0sKsObqBCCW/hA7JyNQ6HP21ldhddr9dnoAB2nYRo4XLXJcOTfFR4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgYpFPFu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EF5606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgYpFPFu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689DE1F0093C;
	Tue, 10 Nov 2026 23:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355172;
	bh=kd3WHtYBe0p/JEd1nYrwGS9G9hl17mtDaDCHfouK9qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jgYpFPFu2rwnw9Ye+/Gy8I5zZBBIKguZwkdCTJ+yuWcqvb23EKBQpn0xHRH7p3m8t
	 g9S0Ykchu8nIsoO4OOmfLScBHuMKrWS+NDhxIYHSA1XKm70g6T7/Au1L5T/hrOiQrp
	 SzEZO3d4IABt2Hj1WFBe8GoetioFPre0mGluZGngJ7irMO4T/O6Hz4WFm+0wqJ8vS+
	 464U46fQUbHxE6BRKAYVuCrap4wUiyXNKrBOmI/Z7FNCm9D64P2jqCnX3ff5M5M3uS
	 KjsjmruF2rV2ustEb+HEBHbUf8LwcAanKquAigTFbCYw3La6BSUFqVMrqXVHx4/7Z8
	 iIs1jZvGhVvdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Yiqi <yaoyiqi3@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] fbcon: Retry rotated font allocation after failure
Date: Tue, 10 Nov 2026 18:59:30 -0500
Message-ID: <20261110235712.204610-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051327-failed-6.18-7935db1a4a0f@kernel.org>
References: <20261107051327-failed-6.18-7935db1a4a0f@kernel.org>
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

From: Yao Yiqi <yaoyiqi3@huawei.com>

[ Upstream commit 7935db1a4a0f83a63590a222500e5016e2f6c85e ]

fbcon_rotate_font() records the font, its geometry and the rotation in
par->rotated before calling font_data_rotate(). If the allocation
fails, the error path clears par->rotated.buf, but the recorded key
already looks up to date, so the next call takes the early-out and
never retries. The rotated putcs/cursor ops keep returning early on
the NULL buffer, and the console stays blank even after memory is
available again.

Also test par->rotated.buf in the early-out, so a failed allocation
is retried on the next call: at the next fbcon_switch(),
fbcon_modechanged() or font change.

Fixes: e4ef723d8975 ("fbcon: Avoid OOB font access if console rotation fails")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>
[ sashal: Adapted the par->rotated.buf check to use par->fontbuffer in the existing cache condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon_rotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index a3f507825eed8..3105682075c87 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -27,7 +27,8 @@ static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	u8 *dst;
 
 	if (vc->vc_font.data == par->fontdata &&
-	    par->p->con_rotate == par->cur_rotate)
+	    par->p->con_rotate == par->cur_rotate &&
+	    par->fontbuffer)
 		goto finished;
 
 	src = par->fontdata = vc->vc_font.data;
-- 
2.53.0


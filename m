Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362600;
	b=DzibUOzL9uKWckO3a52X7Hee++awR5+8D3tSCGSuKHf5eX7eqe0Ty9Igg73ObSB1Hv5Q
	 rmlGn++yQ55eA3sSmM0QlNZ2gSIvlRlRfCydxUgsPUWhLQhXyiseY/8lo7ikA3GCigFSw
	 WehBVmcWX5txmJ6BqLq55DnpkXlhTKVT77eqCUYSAokREA/EEskq35QZK38Cu/qEVe29y
	 bUmUCP6We3CFlytXxQDjnUPNxRAgfpRxvDkcn4OFQbpVCLywf3nMsdb2GDcwnRYDSR0RN
	 3QCpjp/wQ40zxsF3nJRwXiqW0PHnARXJZJ5PAKdOYL1U3An1hP3KXxoyqwR4WN/veqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362600;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D3PpyLZaGEoiWGM2WCPnLb2/hJzojF25hrbkezybz6Y=;
	b=VaFtJTSupq4PTK9aU3E6MhXFybjQOWHocOKz7Y3sGQ5QUQVNlUrn4YBllg14pKpKLyDu
	 ExPtW/3AakBdSKAuMYBDGERYy8aCWc1tCuNkHqMnSKiEw4MS3W7Sdig3YCzubCP5acaWw
	 2lnKEgLoAIff5+jkyOaUA48+73JzwHhwPEbW6uBGMySdnmrqc4k2QlDAOtAXrD6QAx84D
	 XZyO0RVxw0xgnGP5ed52fFL6wpBtHPGnrEdU6rAvmeXTjU0J9JHySuFdII2gXYLcu3/Ad
	 ea+B4WhrDLuoI2c5/Ns0AanpHGbAqvgdKwiYN9mHSM1tPBRDy0J5rtYuuclyCsEeW/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3xjxm5a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A0606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3xjxm5a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96C31F0093C;
	Wed, 11 Nov 2026 02:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362600;
	bh=D3PpyLZaGEoiWGM2WCPnLb2/hJzojF25hrbkezybz6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3xjxm5aze/P6n4sRbv9eNOOc8ZBFTfunDi2imqRaOYSMNtMa6YMaPwvnaPWoZPhw
	 bIc2jzrfltqKvg7N0rsmgCKqiz5eYIsuinY/wRqNFIOBXvA/2L+ZTSlbP2H5eEiFOc
	 rADhZnbSw1WqGZ0SzxpWd85Vrm0/3dSZLZUGIXOSOZfvnqb15sYc2wFRSvpDL9Exra
	 htlKTC+XRClqZLmn3ThNQZxe80PoVKOs5LouoODGcRgACd4cpJbLmIQpbH87jkUsTh
	 UwVEGIwPhfLU6pliNK6cMDqaYnBxkaYfZR2gBwMzy8tIrTYE7DX+AAytjbKA/Yzhnx
	 yYZSssVNDtYag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Yiqi <yaoyiqi3@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fbcon: Retry rotated font allocation after failure
Date: Tue, 10 Nov 2026 21:03:18 -0500
Message-ID: <20261111020136.362023-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062716-failed-5.10-7935db1a4a0f@kernel.org>
References: <20261107062716-failed-5.10-7935db1a4a0f@kernel.org>
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
[ sashal: Adapted the par->rotated.buf check to use ops->fontbuffer. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon_rotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index c1beb4a837081..d5ef2babc2bc8 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -27,7 +27,8 @@ static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	u8 *dst;
 
 	if (vc->vc_font.data == ops->fontdata &&
-	    ops->p->con_rotate == ops->cur_rotate)
+	    ops->p->con_rotate == ops->cur_rotate &&
+	    ops->fontbuffer)
 		goto finished;
 
 	src = ops->fontdata = vc->vc_font.data;
-- 
2.53.0


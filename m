Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355836;
	b=1yro09CsmQgSTQ7gqHLyod9Gr32LOoDsEDdAB95246k3fEtaKgVL9WxO8pMao3m18oIl
	 tckVmPlK7WlLskYA7cHV4BeN21J9WPd9BhtWzAaMSJDPZtAbNO4ALCJAYhcJj9fWsrlm3
	 nfVnU8Lpb1NjwyxbMGHx9Uvob6Dy3lVh6SohEUhX7nLz9F/fVKiqi18o5xB2yd+wWUclU
	 dV5mlsbnrUSswLYoQ2rs78owutgGXdP5up157ma+pHyjgnskOTTRIxy332Fh2E2z+Va6+
	 R0NYySOiLWAQXtqWSMNP8F7lIliZDgyXT67XIG7XArJf655bEMqIqGDq9d9XxVPXImw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355836;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sXnm0synk8SJf2LLKEj8qYtgukfZksNBK90/UmXZ5cY=;
	b=HbxgQC+7SAfTxB8TOMu0Khun9aQFf89JEK8aSOPPOUQhDDcYLVdgP0dQgiEmq3VNKKJF
	 6EFnnnQlQ6zvGMc8BFf0m/8hHJ1xS6OZewuHg3SChZqcrnRtTz2UBNNPFSDRK+rmcaHXm
	 pzgd/UGGlCyzQ69dQihbYEzQ5uKdKcHgn4X+Iy0wHC7PrMYoO8VYniCulZn7Y9euQzfuI
	 wg3MAsH8zbLgmCUcd/8H6ky+sds07bKW/eXRpkjuXXbPoTJLUA1e2eEN4ydRcQ7U6krec
	 pfeAgSxOYnBJl8/Bm7Zu2DetOLSu2Ejlej0IdWuNGYGSL/Px0Gt9/7CrPalaDomVT/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGrdZ6VA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B763606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGrdZ6VA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0918E1F0089F;
	Wed, 11 Nov 2026 00:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355835;
	bh=sXnm0synk8SJf2LLKEj8qYtgukfZksNBK90/UmXZ5cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XGrdZ6VAmHHAyvkqQKb0ULhpz/msdA1HzTIZYjR7gnhpMFlNeA9cUMHGydQdAysis
	 k2IaON4Hzwefq2ragaLM85Dd13uBPNbf3hWdLC3I1XGi4OYQnBbTzyCkkfK4Z+KJkB
	 dMTPm6IHWGGTV6h52U38mowGPhExlXqH5sOMxMvbNu1pnuXtjjj41liE+eVrMCk+7+
	 pK8KEqPj0FY/NFy0Uo6+TJ/VnRKzwo98uK24Lz/h01rg7j57hStdsOxhRyvjpbRLw6
	 Ak5yizqYp3SwIEs508Lg3Q57lmEP4fAVEw+r+QU+FaXPLm3/WfuFrl4BYYz2D7sFbq
	 Y8YjKwVpSIm/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Yiqi <yaoyiqi3@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fbcon: Retry rotated font allocation after failure
Date: Tue, 10 Nov 2026 19:10:33 -0500
Message-ID: <20261111001015.236122-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053754-failed-6.6-7935db1a4a0f@kernel.org>
References: <20261107053754-failed-6.6-7935db1a4a0f@kernel.org>
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
[ sashal: adapted the buffer check to use par->fontbuffer in the existing font cache condition ]
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


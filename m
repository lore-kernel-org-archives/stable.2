Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356221;
	b=rbZTsJva28khG9d8S9bTvAWHOf7w63ZdIvPdC4MsAUO9xVemldYaxL784pX+XY3l9nY9
	 wKdnSq/z95ktXLUwYvEc7TCRhwzD6NN50ReW4q0s/sscbmj64IfFhni7MM9plLFbktOuA
	 KfogC3/BBBpHYQsvhgA+xClSSDAVCvoxCJcElZPFzyEysHni/DkIelERrsh2ekZ2zliyz
	 o1TFqL4dsk37cbjAa8mkHGkiFZZfQx1UbCT05FsWx/46ozeOpaZQiulDYjLPkZDCUdkG3
	 8EVkM+QNoZvk/qozoegZw/s9BylU6KxSuAfn3Zo88dcL2HAAlTVtIPtpkNA0zGnIibA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356221;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XpoQqLCJ8vMXJ5BP0HDkQ9BXMb+kcRw+DpmEVdYrTJA=;
	b=fRMS3eKmLwU+OW9Z2YTpC5gSZzZFbJqJ7TlMs/d/POUlTy9pUMWT+HaD0osO45rsvZog
	 hxduDB47HE4ZzE8RHAn5KrRKAyvwkipN2dpNFAaTRB4egQlXMwd9TBtA3nwTPnvs74koY
	 rmYtmWJK3dWgt9WhoLmK4CB0Dh+IRAEqXea6dD8WlozVXLid/BQvZpVJgKQnE2tjEAVYY
	 KTbt9a4Ip9JMkD3TIaYLvxV07MVh23/oNyqQid2MEZhhdFJst2F7NccKPGzYGbdpfwsTE
	 ZE7Nzmm0Sb/P3CPS6hYqLF68pgTXAhfeqFvsIi1YIqKIfnczaCql0LxbkSCj0hLyrtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWjZg3YE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1F606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWjZg3YE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158D31F0093C;
	Wed, 11 Nov 2026 00:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356221;
	bh=XpoQqLCJ8vMXJ5BP0HDkQ9BXMb+kcRw+DpmEVdYrTJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XWjZg3YELi7rNnOaHQ2Kh3F3C70zdSIcV/E5YB7kmu8rzXTUD6Kl5WVzQ8YVg7DoC
	 ubn7xorZ98aR4bKRfhnp1d1HX8ilYNANGbi3Lqu/FvM073Fwr4JtXxJyzo5dg8L4wT
	 yyE8yjGFRCWONXSPa+YyfVe2193wSmpNSjNHDL0yu1Lo+AMd+KgL3iXzpLKUaobutZ
	 HcqZgN/ELOCo0QKALSLyOkpikbCnor7DM8N5CYem5p/xA/PRAmkpEPQPy1umui6XFo
	 KBnbK6HCHKKK+6cdaOnS4cQXoIkGOTwg5NGQ1z/OSFNrv+FONC+G6KqaQsye1Lg/+w
	 aTDRjRzUvQCXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Yiqi <yaoyiqi3@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fbcon: Retry rotated font allocation after failure
Date: Tue, 10 Nov 2026 19:16:59 -0500
Message-ID: <20261111001441.242430-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055256-failed-6.1-7935db1a4a0f@kernel.org>
References: <20261107055256-failed-6.1-7935db1a4a0f@kernel.org>
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
[ sashal: adapted the buffer check from par->rotated.buf to par->fontbuffer ]
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


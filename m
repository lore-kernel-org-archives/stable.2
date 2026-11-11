Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359216;
	b=xBqwn5qbGkfL9Oe6OEzVw8EBbVnIr4FO9qHy5IT9bb3Rr2l07GPW5IJmvg/iGoGoSSD2
	 dE2cBxY42qdcXauqN9aKvG2scS3cvW7CE3VsR38s5/iMWtjH0Xwh0pyS6V4TtqzbONLD/
	 eMlDDvY75T+PcAsEFZ3lLKonwxJe3HA9GVS+qk4CWAfpzkKlt9qLgH6JyWq0ecxwPPBnW
	 RHm3wprTHs1LA/bgSKsUxUCOiZ/eFxJMweoFtpwxKMnrGzM/KwjWSqU/AoO3u5Fc7MH+P
	 SUIxzHGmFusqihKvmtGlVwMMHyIRgQ4MJ4QW6AJd9A06CEQAymrB/qJlAcydrL8/1UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359216;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3lS+fcTJ/rxkgSn2y2UzaOZAnG1NGJotoj6dabRKv/0=;
	b=gw/Q3pbUX3MaZY4gXBlzFZgYLizB2bRQ78mr08YQVH9BDl9Nq6kXEjdFvi23kGLQhw1p
	 7oB+FOR2T3IYX3lVrmBWZleP9q38Vdkj/XyCgQMAj87QLKwmEzZOcojwBIIhbPq/akTjH
	 xJEBVyo8lQnu/chM0o5ZxVI0bPYMukW62ZKc5Js7S6+wbdD5pDYmpkmNMf0jws7KTS9V9
	 kMdq0YN+Cm12s6zbSynkyNnCuL3WFB5Knc6p8IqE5h1y6j4of06FdHBQIStVVDR91YHEl
	 e4qy0FcBEXiWts4wiFJ825h2bDlrJUjQy98OmMRBCCZJ7K85H8ew3YcklFBeEKy2XtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHmAlPa0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249F606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHmAlPa0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335D91F0089F;
	Wed, 11 Nov 2026 01:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794359215;
	bh=3lS+fcTJ/rxkgSn2y2UzaOZAnG1NGJotoj6dabRKv/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YHmAlPa04QSTX0ThuM+wqm1tT1wpAFmESyUFOVM8amfuEi9YhCcxDPdScZCPO4uoG
	 ac6TUg4C250MWChlYZDXByMsCqkmHNtH/i3y8klKCbbCAJk6J42NmQUJXG2nF2h0Yn
	 lPEmg9FerGNZETokogtVILJdHGsGMpoJmueS3W71X9vlzkkGQwq2F1a5A5mmcmbDoj
	 XLhIMvfQNaUKdOd6OASQtc4MsdRztTH7R3DTEMd/KQCODKJyNvn4dgZxSYwmk4pVSf
	 Y/eACvCEsVQq7XGL4XLRptv/S9thmUqrPL8ygghZtxG8GT+7aTJashoqURfeoNvTMg
	 rUL2qLsZhwUVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yao Yiqi <yaoyiqi3@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fbcon: Retry rotated font allocation after failure
Date: Tue, 10 Nov 2026 20:06:53 -0500
Message-ID: <20261111010437.260243-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061006-failed-5.15-7935db1a4a0f@kernel.org>
References: <20261107061006-failed-5.15-7935db1a4a0f@kernel.org>
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
[ sashal: Adapted the cached buffer check from par->rotated.buf to par->fontbuffer in the existing font cache condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon_rotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 66b35613368e1..f7e03c17f94be 100644
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


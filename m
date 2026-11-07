Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049809;
	b=nCwFopu536dSEpKoHPw4tNi/SjSOa+KGQ0xDYvM1xjTEWXRZ8QVZmNm3llcqHjf9FVyw
	 XntiWRdfNaJ/UlGfsTQSDcC30Wv9fOFhi4zSwvlUtHCc2zf9sGj+YDJwwCHxaHvMdeD7u
	 awqom1iHqjaFoo4+5MkNjEMmgb7Qieo7kEy3maCx+hgcH3nVWqEv1U2JaBsGO8saMVNFS
	 x7/D4VjIllyWGFdT0DgFU5CDOTIXdCMiFExNbZnRH/UOHADexBfgXcLESC3367zSB8Rvw
	 ukmHMsugmmny3JgI7uX5lvHIlnuRdzVIUa/bqZ9282A+DxSMLjtWj5cXJwx0p/SrtTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049809;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dEwbFXTSbWq9jorAIHx8k9mOT2i2hky71ik7Ocnfji0=;
	b=q4/YlEsu1B+DRZqbjs9YSUOvmvgK9C4gjTAqSQP/oEACod1iv4saqhbS1AR/P3X3kZVR
	 sEWHTskU7rpwar4KtbcLcbD3f9WWs6DXLqx9Q/iM43Q5GwKkoJwY+I8SyB3397boHI0Fe
	 v3AslNoOqgUU2qIzWiq0ToIgS68D16xoGNF02j39qdHygBnC3lymf8Cq0RXvsigH04beZ
	 rATGHcIjC57MoAr4mlEqWYFroaOR4FhgzOpU3nN1F6YdDZQu7sGM6e0PZm6SQf+L5Fhgs
	 lKFdUzEww+YgEsq9C3Q1qSvihxds1tzNvPsxuQTsZaDFBroSSPIOd2GpKpEq/tBVSgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3vsRp9Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5EE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3vsRp9Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1801F008A1;
	Sat,  7 Nov 2026 11:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049808;
	bh=dEwbFXTSbWq9jorAIHx8k9mOT2i2hky71ik7Ocnfji0=;
	h=From:To:Cc:Subject:Date;
	b=l3vsRp9ZryLESFsaw2rjLK95CydbaiCHS6bDPKAXBDubYfqh/xO7LosH3ViuTVqpN
	 0QqiH1T+DierN5Kg1bofbRelIPk+SLOGjgzzayU5Y8G657+QNNa8iN2o7OMIqKhUHU
	 K6Tcjsl9HJovtDEg7dmHS+sGgx961udYG07f+9fqmLJ0Bd8VbOIbs99zrRsBYIK1Uw
	 bf8o7NfBveR8kwoI+gclAZ0hwny0F1KjVEqtasVuNAuG3x4TQIx36NH9bEybKxUGxY
	 gxmjmYKm9hhKDx4cLU8xGGG2qfijiywcD7ZLNGm5GgQnTaYLowYEy2RQI30sKfq+r1
	 Ml+kp9JgL634g==
From: Sasha Levin <sashal@kernel.org>
To: yaoyiqi3@huawei.com,
	tzimmermann@suse.de,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbcon: Retry rotated font allocation after failure" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:06 -0500
Message-ID: <20261107061006-failed-5.15-7935db1a4a0f@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7935db1a4a0f83a63590a222500e5016e2f6c85e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061006-failed-5.15-7935db1a4a0f@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7935db1a4a0f83a63590a222500e5016e2f6c85e Mon Sep 17 00:00:00 2001
From: Yao Yiqi <yaoyiqi3@huawei.com>
Date: Mon, 19 Oct 2026 17:43:31 +0800
Subject: [PATCH] fbcon: Retry rotated font allocation after failure

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
---
 drivers/video/fbdev/core/fbcon_rotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 660a3fa81baed..7afd63dcee7be 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -25,7 +25,8 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	    par->rotate == par->rotated.buf_rotate &&
 	    vc->vc_font.width == par->rotated.buf_width &&
 	    vc->vc_font.height == par->rotated.buf_height &&
-	    vc->vc_font.charcount == par->rotated.buf_charcount)
+	    vc->vc_font.charcount == par->rotated.buf_charcount &&
+	    par->rotated.buf)
 		return 0;
 
 	par->rotated.fontdata = par->p->fontdata;
-- 
2.53.0





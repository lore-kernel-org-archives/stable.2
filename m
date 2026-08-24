Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8E36197E
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583671; cv=none; b=ivOjSkmGFXZXFcGS83YnsW4ng/6laKsZPMPR53Oo9xjf1DwGwOko45v53xMoEg8FpV5gP1KQDWThizgA/CJic8TGnqaRvSIHeLBZ0zgUTBsNVvMozQ/mNbJS36GTDvVop0DUyPIbcRT8jPOGE8cOwuFE4KwnzfcgIJH7A6ts9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583671; c=relaxed/simple;
	bh=kjb9p1QucN9g2LA4iv0SyVzsIRPipadsH7VkA/Kgj6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mToDn/yUekpS2MwjQsz+yFe0QukuDyMgn1oNPcmuiU3dhVkzPLXOBnMrZ7zhcrFxrJe9YHJ1gSNMy0pneoWXBDmk83pYsCuU4iTyN+jtXWM5A4j8VCWfoyqa8Ja6VyFL70ycpCAWD9hVGGISq4VnfsbO9DAXozCvKADgFXfc5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5TPK4QZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5TPK4QZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C4F1F00A3D;
	Mon, 24 Aug 2026 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583669;
	bh=iPDoNyX2Bm+fhas0TYGejFnd0lGEzIckX1mSOYgvBHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l5TPK4QZXRF4Cc6YHtegw/BNqx0pUKocKrR0VAHeUIrnj/DFE/HQ/xgYuq4Gy+Mya
	 ZQV7ixt4hRfAf2TqZMoLdR7i+bFh4ATQoztCzLHPmT7OYgTOJUL0x4cckIkbwv2+l0
	 iuPwuUKcX5Jd5CuyYqfxD5sSit0MBZ7msXJbV64Hr18nI3FEkJi7QnZY/OiooP7hOi
	 zAxfv5flrsC3VPOis75bhc/t2XQmY4+1rNrtVnKgaI+SRrlG2z3nnkSOKzgXNP7F45
	 7I1ye92WMcT7ITjtwfSVRmvmOWfU+DdQq41dVIanCCydNTic6xmgSKuAS1tEw6GLpV
	 OxFK7pyrgnKMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linmao Li <lilinmao@kylinos.cn>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] Input: byd - synchronize timer deletion before freeing private data
Date: Mon, 24 Aug 2026 11:01:07 -0400
Message-ID: <20260824150107.3723664-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082045-whoopee-batboy-8ace@gregkh>
References: <2026082045-whoopee-batboy-8ace@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Linmao Li <lilinmao@kylinos.cn>

[ Upstream commit c83e79c0842ed29860648bcce5022ef0ba5001c6 ]

byd_disconnect() uses timer_delete() before freeing the driver's private
data.  This does not wait for a running byd_clear_touch() callback, which
dereferences the private data and its psmouse pointer.  A callback racing
with disconnect can therefore access the private data after it has been
freed.  The timer can also still be re-armed by byd_process_byte() while
the disconnect is in progress.

Use timer_shutdown_sync() before freeing the private data: it waits for
a running callback and turns any later re-arm attempt into a no-op.

Fixes: 2d5f5611dd0d ("Input: byd - enable absolute mode")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
Link: https://patch.msgid.link/20260720061259.1601281-1-lilinmao@kylinos.cn
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[ changed `del_timer()` to `timer_shutdown_sync()` since 6.12 predates the `del_timer()` → `timer_delete()` rename ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/byd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index 221a553f45cd8..cb49f38883020 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -426,7 +426,7 @@ static void byd_disconnect(struct psmouse *psmouse)
 	struct byd_data *priv = psmouse->private;
 
 	if (priv) {
-		del_timer(&priv->timer);
+		timer_shutdown_sync(&priv->timer);
 		kfree(psmouse->private);
 		psmouse->private = NULL;
 	}
-- 
2.53.0


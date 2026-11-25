Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626454;
	b=vr16ew609NYqsyvBoXFKI7v40Knjn2tFHapGknLPbfR92Zm1LQNnlLVFDo1z+lO/FAPu
	 HQGrZxgsSOUSjQQCjKrXbkKR4QjLC3zsOZTY/IHdJYI7GUSZlzm1Oi+LJJNjp6p6Ijdei
	 i+ePyQ1FkuWPBrsMKmN+Klh7xMHhtEhPZG9bhLhBz0g2Wx1eRT6DeTvhR2rG5PSVRyFdd
	 xvAVCmYcWG8327C8cn2gdH0YhAUHE2j+80ESF28/2PD80PbaGAAhQvxM1Mv7YPrG7aSsR
	 DyZiY5mU3KLU8ZmSMWqOxv5zJKQjRWyppLu1zkCCwmwmm+vRgbkpr98clQky5/O0K4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626454;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hy1qi/Eg+sI6xTZtp6w/wZ3TJrK71QyArAjoHoybMkM=;
	b=SghFPo96ykeXSsYk6PrjtYbwS+M3jRezD+D4kU1soROYxM2m1vnewFa6qo+rhWXS32gP
	 DQBUAwgYLrTFYvNvuuzVYTccwxBAVEKypmnNe7oZfH8sB2ougBK1mv0Lno51ny9vUZNmp
	 JziL1sR/TGq6Q+uUQRHG8YIPEb9pAepdzXxrgQXO+xyd6KGHsrIolCJR+1rC8GxATD1BX
	 BOsZbuBbqc4F6YKVduyvOH3PU1GGNhSySz8//rciLgmRwKtkprE6HzNaTU8KqI/TabFQw
	 0zjm6Lt7om1FizBmq7XO3iQRfizN0B23beCLXUSlrJ7TM5CXtiYbEaFkdC0oYUqO/qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlgVGoQd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66531606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlgVGoQd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B09F1F000D1;
	Wed, 25 Nov 2026 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626453;
	bh=hy1qi/Eg+sI6xTZtp6w/wZ3TJrK71QyArAjoHoybMkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZlgVGoQdVt6ohKEEHrgokivpLa8zgjcMDraHuuqZD83TQrv1nf8BSaU5LvfJ3D/6j
	 BvOUmHHn/d0y98xdNbFu9WapdYSZY2KZ+/UK3JCNS0SPphWC+Vvorw4qw63zNx4Wo0
	 8y/qDOcdH3VWzcM0r8Rbhg3fTVoEdHBzGonL02g+OLf3lOAtWospn8/0rpIX6aS+qN
	 djpbiUgJYhCLSlb4LwSpbAbJGdjqC1DRG/VtWUJ8HgjwjEe5tEdgdXvY3kRZink3+Q
	 10zOSn/p6AT90c33wrPBhem1yabm/pSBI6Mrsd2KcvZiwmKQRIhq2bvOagjUqmTxk4
	 qpl+7ByC18PqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] watchdog: rzv2h: Use pm_runtime_put_sync()
Date: Wed, 25 Nov 2026 12:07:30 -0500
Message-ID: <20261125170724.923268-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125170724.923268-1-sashal@kernel.org>
References: <2026112533-carton-removal-6b77@gregkh>
 <20261125170724.923268-1-sashal@kernel.org>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit ca800e625d18a9f5b19f94ab837ceb3fccdca22f ]

pm_runtime_put() may trigger the idle check after pm_runtime_disable()
is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
runtime PM active.

Use pm_runtime_put_sync() to ensure the idle check runs synchronously.

Fixes: f6febd0a30b6e ("watchdog: Add Watchdog Timer driver for RZ/V2H(P)")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20261001165201.763882-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/rzv2h_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 83540dd9a37b6..057b890de0b05 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -174,7 +174,7 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
 	if (priv->of_data->wdtdcr)
 		rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	pm_runtime_put(wdev->parent);
+	pm_runtime_put_sync(wdev->parent);
 
 	return 0;
 }
@@ -268,7 +268,7 @@ static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 
 	rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 
 	return 0;
 }
-- 
2.53.0


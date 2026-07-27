Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF269412BE7;
	Mon, 27 Jul 2026 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158364; cv=none; b=ESxXyRHVBTUzhQfJVI4cKj0i8K3ePRMdr/JDhbMuokjldw2fiIYrEReA6F67Fig5+PFZ6nKDjceRwMK0N9mQWhVcOozxV5GADb46GTCvrmx5VDVPxmw3dHHTC0ymlLRITvHuzeSSU1hoZJVhmgG3ElBVMe74kd8ZgIKYYWtzPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158364; c=relaxed/simple;
	bh=jyAFNCAff7ONHFxb/FIrT3odoLHFfMrGUvGh9kBzBcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ah8GDfePH0kDfPUMp+y4UrEw+L22j+naZWxA0JJcacKVgn4I21Ggh0ODh+BxyFybelPTfkCBYtgLvWVfAf7gwUbpAy+eIWjDcgO6vNDqyAq8KBSvfxeKGrXYRokUDwe/Sn8c5WET7V7dQuQN25cnuJ11KFBc5uj2DPklHjiLGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=jFqJZ33+; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=jFqJZ33+; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="jFqJZ33+";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="jFqJZ33+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158355; bh=jyAFNCAff7ONHFxb/FIrT3odoLHFfMrGUvGh9kBzBcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFqJZ33+EK/wtLp1/Le/Xf5wB8zK76uiViXw5cnYBcdV3uJPkK8NGBfJ3ujFQkpEf
	 CMU6sEPzF0LQh4t7oJPMEuHhFZJmga2Vaw90ylrFY+6Z6CqkXN78TJfitNwoqcuKwY
	 1gq06t19XundoiqmCpalCues+vKRIjpainKF84Mxj4g9ABDRAKthOFU+Tq7XOkfx+Q
	 fTk4vcUJRMbaoaZEY2B+UtFDnP0WARfjeDGjADp6PZYkAFLN4huiC6x8CS6tfuJ7CR
	 LVf2S8Iapg16L1FVOM243xBrt+vCAITdUlnUe9YTeFcBYpzJNIt+tzgQEcbSdcYX1b
	 qiCgpugUXqppw==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id EBA7342540; Mon, 27 Jul 2026 14:19:15 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158355; bh=jyAFNCAff7ONHFxb/FIrT3odoLHFfMrGUvGh9kBzBcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFqJZ33+EK/wtLp1/Le/Xf5wB8zK76uiViXw5cnYBcdV3uJPkK8NGBfJ3ujFQkpEf
	 CMU6sEPzF0LQh4t7oJPMEuHhFZJmga2Vaw90ylrFY+6Z6CqkXN78TJfitNwoqcuKwY
	 1gq06t19XundoiqmCpalCues+vKRIjpainKF84Mxj4g9ABDRAKthOFU+Tq7XOkfx+Q
	 fTk4vcUJRMbaoaZEY2B+UtFDnP0WARfjeDGjADp6PZYkAFLN4huiC6x8CS6tfuJ7CR
	 LVf2S8Iapg16L1FVOM243xBrt+vCAITdUlnUe9YTeFcBYpzJNIt+tzgQEcbSdcYX1b
	 qiCgpugUXqppw==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id BD6A74252E;
	Mon, 27 Jul 2026 14:19:14 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/15] media: sunxi-cir: Ensure no more interrupts can occur before free
Date: Mon, 27 Jul 2026 14:18:49 +0100
Message-ID: <9c73eb433ce34de243d5be7a5e81e38fe26d39c5.1785158244.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785158244.git.sean@mess.org>
References: <cover.1785158244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only call rc_free_device() once the hardware has been stopped.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/sunxi-cir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index 28e840a7e5b8..af1ee08ffdbe 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -374,8 +374,8 @@ static void sunxi_ir_remove(struct platform_device *pdev)
 	struct sunxi_ir *ir = platform_get_drvdata(pdev);
 
 	rc_unregister_device(ir->rc);
-	rc_free_device(ir->rc);
 	sunxi_ir_hw_exit(&pdev->dev);
+	rc_free_device(ir->rc);
 }
 
 static void sunxi_ir_shutdown(struct platform_device *pdev)
-- 
2.55.0


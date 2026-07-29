Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F314D2EEC;
	Wed, 29 Jul 2026 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338599; cv=none; b=mxzNlubu7jpl/mF1rSf2EimiIb5CrzyQq23zHFpwPZrwui6/WnINuNccRcipQQeimPWLDRz/Ovr8ULneeNlkpEBSYb4DKsNRdBTkrkbfWv1RCuGp4LUfvBKz6jeob8T3dK/jsTADk4MnYWOs/jsuUBiUKthHNjmF4E3220g11nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338599; c=relaxed/simple;
	bh=jyAFNCAff7ONHFxb/FIrT3odoLHFfMrGUvGh9kBzBcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvBDg3d8HS/9PlmoKet/OD99qLvJQ5Zgso1EEDqzzOuux4ef7VLsAVMaQkKaa29IQmfibhY5Rd05tkfWoWVhlp6936y0S6iWJ+W5h/u4zHTPJ2HQggFjOmDaOy2yzcNqBf534heOlFwp4rj0KyYuaUC8dU8pVnA7hDmVfGjHeXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=W0o2E3Ic; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=m0l850kX; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="W0o2E3Ic";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="m0l850kX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338593; bh=jyAFNCAff7ONHFxb/FIrT3odoLHFfMrGUvGh9kBzBcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0o2E3IcHUPcqjHRulLpkwmEad+b0z+jEKoSlYZ0KUVRCzb7ZgA6dkP6b3X2wqKo1
	 L3a3qBGUlBCIEMlkAFksukQZnYzQ0Xn6TjFH01SWkbKPKNcTf0KPK+neIvpCuA68nx
	 hFO87IOOc78Y0bynDu6l2jcmJlmwPJmRyLJBORtBNYw3vwk1d5xw4/h2vdaTKsu0Wi
	 Y89lm1YIB2ZoG0tyP0tXK77ARbKyLWsu13LjiTOlcmqN81iSXqXjKRwLC1hW/WZVmQ
	 Q55XEu9H5ZdbOTbZ+uOXlF2zjlVmegmm2pLEFVZYUXcZqmT8AQRavGjjvuE3extGru
	 2BDUnhCy5F0oA==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 7C3074254C; Wed, 29 Jul 2026 16:23:13 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338592; bh=jyAFNCAff7ONHFxb/FIrT3odoLHFfMrGUvGh9kBzBcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m0l850kXaZmCw8zaVg9tUIrPXj7WRgopm7tAw+Iam+5Pzh/vt5z94AM5i/EvBzYp2
	 I7ccCtN1ZTXiGFFYp9sKIls9+YkwU/+aHvDbnR9K1gk71m04rsV/LLi/qF5+936AD5
	 9KS7Z61nA9mOHdDIuLtPOCV+LPR5XSk50d49lBCfOXZ4efjaw3HMI3B0YACYfTc19U
	 bL0tAMcEIeCxvlgkapt6RvZdSKokA1W3xc6WkhccEHe1FhRIwpDmHCT13q+bjVz4ix
	 9bxf+WxC7LSipQf4k8Ew5oriQPyvLLEAqn07hCXTXOJtXDXsdl4gkurGPt6gWmbRqF
	 09pGN+gl53mWQ==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 619344017A;
	Wed, 29 Jul 2026 16:23:12 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/15] media: sunxi-cir: Ensure no more interrupts can occur before free
Date: Wed, 29 Jul 2026 16:22:44 +0100
Message-ID: <ca5cac44353fdae4d664b22de709cc45837414ee.1785338381.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785338381.git.sean@mess.org>
References: <cover.1785338381.git.sean@mess.org>
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


Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AC7413797;
	Mon, 27 Jul 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158365; cv=none; b=KgyZkPnz2KXdHRVvFzAitLRlmrL2AXK4qjtWu+stXdAHPpFmQoLiwknQxrbO8WyCvw2eMoqCXFj55JoCHaF5OVhvQfDbVcTyFGYiWR69xTzFL2CsgVc7EBvmL1Ro8JMZ2Oer8Expu6BqgGjPqZezwZK+5K/opMecUy3HkjVvQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158365; c=relaxed/simple;
	bh=MjWQ07Kksq4lkvfRIc1nFy1BvBlXTzQS5OL4pj1+KgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=On+oJAFbSlzSj2U4p7h7raK8x3TPjph+q/+x9tOpybh4onJ0cErLeT4UdE00VQxIXRn6yaQ6BHRet5QGsWt8btlCXlQBrxgW9JV/bZ5u0CDTCGzDa2mzw3H55qiAEs2jqHxPx2jRqC3gvL216la/ddgomW+DPNowVSoHfKghO9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=YI4OE07D; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=lstHC8/m; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="YI4OE07D";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="lstHC8/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158357; bh=MjWQ07Kksq4lkvfRIc1nFy1BvBlXTzQS5OL4pj1+KgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YI4OE07DBYkJZrFRURRjrgAHMhXA+Cek9gBQP+crgcuBx+AGpVskpq+ucjfLBXSRa
	 FJHXRe/mOQj8QdIjCK3UIkYSlQNIdYbnHydePkAKqM33i/U/iFMnzToESmJJZRYtAO
	 yd6ocLjedA4adhU2Hxm9/wtSwiAQMg6axwXWzDZQ90qZUXtW/WpkKJ1cXZHJvXHJ8f
	 f2RvC7Jo3j5zCkXSUewKm8mtgkqBK+1Nhf6VtI9VyudbVizwS7+Y5nzeDccF2gSTv3
	 rYXiPdZHgiqy3D6kN0DgEsgZMq+m41x+LYKNIDjCj0wa9p7MlgcVo6KLG1tt18NIX8
	 qQNp8xjHp00cA==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id E36B342534; Mon, 27 Jul 2026 14:19:17 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158356; bh=MjWQ07Kksq4lkvfRIc1nFy1BvBlXTzQS5OL4pj1+KgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lstHC8/mp0d0iKpjM5tnpW0QnO2ajuwI0hwTQOYMewCQSqmHg1ieANEyLAfs37uFs
	 4P1f5xaSr3YLDZLDx8jzcypexUgBoV67UUhpO5N2PH6u07UgsU3Yeu0vvFKc5sIO0q
	 N7Q7tUEWr17XdbbwIWCaGDxiLJDteNUROSwHJp6TtD9GUdjT8N9Y+XdX2WyXqhIDG7
	 Oymifu9He5wiT76AZK07OqxYkm/8cUcgcqc7yJjwvo02RVmsGM64h4JdgHujai72xg
	 LyirARdi0FXk7AtfpLVOM46+/mGLWTc6tTyPmsTF0W4LPaoIFY1bMUPejBswW1Dw3z
	 +5pk7bRkmcNWQ==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 283EA42534;
	Mon, 27 Jul 2026 14:19:16 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Cc: stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/15] media: meson-ir-tx: Ensure rc_free_device() is called on unbind
Date: Mon, 27 Jul 2026 14:18:51 +0100
Message-ID: <4674de80dfb7ab8c4a66282be26260ce4e7c9055.1785158244.git.sean@mess.org>
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

Make rc_dev devm managed.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/meson-ir-tx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index e7bb107e6a84..abb107d19e8c 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -345,7 +345,7 @@ static int meson_irtx_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "irq request failed\n");
 
-	rc = rc_allocate_device(RC_DRIVER_IR_RAW_TX);
+	rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW_TX);
 	if (!rc)
 		return -ENOMEM;
 
@@ -358,10 +358,8 @@ static int meson_irtx_probe(struct platform_device *pdev)
 	rc->s_tx_duty_cycle = meson_irtx_set_duty_cycle;
 
 	ret = devm_rc_register_device(dev, rc);
-	if (ret < 0) {
-		rc_free_device(rc);
+	if (ret < 0)
 		return dev_err_probe(dev, ret, "rc_dev registration failed\n");
-	}
 
 	return 0;
 }
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933569;
	b=lvcV/fgy2Xvr7bTowV0+m2GupY4khfOmDhPcons/4rnrCzZ+IX8VMDNb7ShwXmwmvw30
	 LX52FquqSAz44jmx8YrWCk4l2XPU8JSAEBBN0ScitLl+ZcCN1542Rg14FPWZ2Ob2gPHwC
	 hrmCRj8Nrc1xZ7M8iqE3P9ZvKCcbxlTWKsB9l1ZElEI5jJBUtK/MkhZCFihrg4LZ3XtVl
	 UPOAhhnzAPf/KtZIlems/w2dCEThFAgmXz0htp1j5OJGWdl+YJ8lTrMbG4fthVF8dJJuz
	 MjE455/IETQTJitwFEQd1KjSjK9iTF6Lalj+sLbPyfyOXsE80BSP6gdJQu0SL+ImoEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933569;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sGJi7hvXe3a9OqGC6JOAa78jR+ZgfQUCIcX0WKJpETc=;
	b=xptnMQ/ncyTcIbXvghIMOSiDHpoLHyvaEQTa3X8WtYq80y3u4eZQlk6X17Ajz27Ha4+x
	 dhOT5JyHNG4uFFrPrYkC3eoszofKsMkO3HyEAhNwiGAe7LvTNGewNza82pD8tzEwBeycg
	 gSoLO3p/9wOxyODmgviotnoMndLsrh7WXwZkb72fpYYuMsshLCFyVWKnnjNMEYpvab7D8
	 yS0cSi6EpIzl17cbltA8FBcCUAPnPO7ZZAY1RkpOnELvGlWizdbtzlwERHy3uG7SYHH89
	 rg1ZvXwiuWrhOgt3Wi1ghpZox107xg0Z+U0z3Zq/mZQUAUOj+R3QBhEXWP5OsQMEJSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ix3+7jXq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2CD606A33D;
	Tue, 17 Nov 2026 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ix3+7jXq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0E91F000C5;
	Tue, 17 Nov 2026 16:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794933569;
	bh=sGJi7hvXe3a9OqGC6JOAa78jR+ZgfQUCIcX0WKJpETc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ix3+7jXqXudtB+1zTjW4xONci8jKWPa+RA6oGqMF9Fj57RiQ8yseN0leNB9IOZgxJ
	 YMnbA+4Dr2/eOCl2axK2oCsTiq8flid1cOaFMdmJOMGLJeqhBchE06cmddr0bfoOwv
	 +cD5PsUmbTO3FQNgx9CCGtB607oUzvJQTBKt2c12NQIOmpETm/D6zcxt9dFZ+kv2sn
	 +cRyT2uHb0stV6iOhFaCuswwDg0UDNCElLvBOjdXjnV3NZXrpRN2LrgE0zfyXVYqXf
	 zHtBJVmieO+cEWqpm1UWCl2ONfUcOY1FD0RuHyYJmQJkTEd2C1OXlnM1Bf90m3L6TA
	 HUbwteYWjP94A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Paul Cercueil <paul@crapouillou.net>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Alex Smith <alex@alex-smith.me.uk>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 10/11] dmaengine: jz4780: Fix descriptor cleanup on hwdesc setup failure
Date: Tue, 17 Nov 2026 16:37:11 +0000
Message-ID: <20261117163809.622249-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261117163809.622249-1-lee@kernel.org>
References: <20261117163809.622249-1-lee@kernel.org>
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

When jz4780_dma_setup_hwdesc() fails in jz4780_dma_prep_slave_sg() or
jz4780_dma_prep_dma_cyclic(), the error paths pass &jzchan->desc->vdesc
to jz4780_dma_desc_free() instead of the newly allocated &desc->vdesc.
This leaks the newly allocated descriptor and either dereferences NULL
when jzchan->desc is NULL or frees the currently active descriptor while
it is still in flight.  Furthermore, jz4780_dma_desc_free() derives
jzchan from vdesc->tx.chan, which is not yet initialised before
vchan_tx_prep() is called.

Initialise desc->vdesc.tx.chan in jz4780_dma_desc_alloc() and pass
&desc->vdesc to jz4780_dma_desc_free() in the preparation error paths.

Fixes: fc878efe84c3 ("dmaengine: jz4780: fix resource leaks on error exit return")
Closes: https://sashiko.dev/#/bug/linux-b39121ef-5ffb-401a-9d04-0afccd467bde
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: Correct the Fixes: tag to fc878efe84c3

 drivers/dma/dma-jz4780.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index ac2094e65ecf..c3974c825ba7 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -248,6 +248,7 @@ jz4780_dma_desc_alloc(struct jz4780_dma_chan *jzchan, unsigned int count,
 		return NULL;
 	}
 
+	desc->vdesc.tx.chan = &jzchan->vchan.chan;
 	desc->count = count;
 	desc->type = type;
 
@@ -379,7 +380,7 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_slave_sg(
 					      sg_dma_len(&sgl[i]),
 					      direction);
 		if (err < 0) {
-			jz4780_dma_desc_free(&jzchan->desc->vdesc);
+			jz4780_dma_desc_free(&desc->vdesc);
 			return NULL;
 		}
 
@@ -426,7 +427,7 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_dma_cyclic(
 		err = jz4780_dma_setup_hwdesc(jzchan, &desc->desc[i], buf_addr,
 					      period_len, direction);
 		if (err < 0) {
-			jz4780_dma_desc_free(&jzchan->desc->vdesc);
+			jz4780_dma_desc_free(&desc->vdesc);
 			return NULL;
 		}
 
-- 
2.56.0.679.gc527c65306-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933532;
	b=MQ+uM7HGNncM3JUGP50A0qhmWGfeCLwZBOXR4qQmzUa8j6regsBqMMCLcvWbyQmkoPNd
	 UIoFKujXVQFJXcJuhzuU6FnefrOMBp3Af4vxId0pijvEbEzeekB4VjRX5qwjNSwy6E814
	 cBlhWcsZXlT2Sv8wxATNjhYPAUy50Ituh6Y/nH//43K/IQ0jl3k2/fTirgFuA0WEMH5uv
	 jo+586exxrP32MJCnw984yhk8yVvPaad5AEqX0twUR54X9cSovKREUUr4UcGnlx3iX/YI
	 T/j0urESxxj5Vq6U2hCFD4z56WZ6rM3Ygc1Z3kPomy7NqeMLsagXQORhi6Rx3HYHWjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933532;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=inYPwFWtz6Fhbb0Ds7p/Mg4vtxJtzdBV5nXwHlDvwmI=;
	b=XCgnRy4biL/IaqAQ1UTx6UCro1Uk8CJkNAZ0j2k5MhBsKhywD9GXVs9/8a9X4Qy0EoXk
	 COUCNM1QxBVpH21mI5GosSPIG/efktmeM0oq6m8lfV3PnixHqr/kJwN4Pr9Eb8V3AOdZ4
	 DDeEiGbUkJWTygrrEB1zRk5pTZLUIBUeyoEog6YXQzJqCt7MEDpHrM4OrPOdpdKN2iH98
	 H77Q3yEyJ69En4abcpeymtApCrsPg/b5tAsev/zsXkLa9w11PgHuaF5M3lRAqLelh5vgo
	 mkibI7beT55vUAIUJnk2aJXcHMUvqDr0p7dOQE7Xi6QBTRz18k4grNeqhD12JLAwQPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQ4ILVz9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F925606A332;
	Tue, 17 Nov 2026 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQ4ILVz9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B688B1F000C6;
	Tue, 17 Nov 2026 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794933532;
	bh=inYPwFWtz6Fhbb0Ds7p/Mg4vtxJtzdBV5nXwHlDvwmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DQ4ILVz9dlD4rNMm1TFFLMK0m98Qy/YwJIh9ac+prQe9HGnH30DP99R5WKNfzuXY3
	 o0gtxbIM7sngwXJaO1H8rLXIZ6Kih+puCmU1wtwvwnFjibhM+xbDCbivkOiF+0xC5a
	 gK5AIxx9rlMA3l5Lap4rLaiBwmv6M6o8BotuwI7OglZI+Cc+J6dZwjrCRVEylrENhR
	 PP6zqXuDUXe2KpLa1C/SYJK29lkOSZpFA/XQudDrNV11w3hSdb4PgV5M3+fHQqkmfM
	 KWJtfLTYKDLD9qPu+I7Wrh6ShgWEB9puOKEegdUIQUKfTW/9tZ/RCs/lUFnJhMdwBg
	 VKLaRH8dJMlUQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Gary R Hook <gary.hook@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 05/11] dmaengine: ptdma: Remove completed descriptor under vc.lock in pt_cmd_callback_work()
Date: Tue, 17 Nov 2026 16:37:06 +0000
Message-ID: <20261117163809.622249-6-lee@kernel.org>
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

pt_cmd_callback_work() drops chan->vc.lock before calling
list_del(&desc->vd.node), racing with concurrent virt-dma list
operations such as pt_terminate_all().

Move list_del(&desc->vd.node) inside the chan->vc.lock critical section,
matching pt_handle_active_desc().

Fixes: 656543989457 ("dmaengine: ptdma: Utilize the AE4DMA engine's multi-queue functionality")
Closes: https://sashiko.dev/#/bug/linux-55f1563b-5563-492a-a291-1a5b772ffd42
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: No changes

 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index a0a1c7ec2ae5..a75a9a316e83 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -365,6 +365,7 @@ static void pt_cmd_callback_work(void *data, int err)
 
 		dma_cookie_complete(tx_desc);
 		dma_descriptor_unmap(tx_desc);
+		list_del(&desc->vd.node);
 	} else {
 		tx_desc = NULL;
 	}
@@ -373,7 +374,6 @@ static void pt_cmd_callback_work(void *data, int err)
 	if (tx_desc) {
 		dmaengine_desc_get_callback_invoke(tx_desc, NULL);
 		dma_run_dependencies(tx_desc);
-		list_del(&desc->vd.node);
 		vchan_vdesc_fini(vd);
 	}
 }
-- 
2.56.0.679.gc527c65306-goog


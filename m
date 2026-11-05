Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840714;
	b=1djQVTi0FKCqXQBMmI8ozN+FObewsmvwMYhcLhWeUn70NhoWSRII0PRvM/8D4DzIDeRa
	 AcUyM6AseL5/hGokCtrpH5d9HmeOZzCESzV7elf7SOZGh7ddD4UA25pqlt8awTTrbvryW
	 yTBWRz0wSlJqRCZ6fJ24wBOPdsUoiWH0dKuMok0H3wTbgP4ThlSiV1Oko9sehIt6rnwOq
	 5jzNMe2yCHtMSpoZAikHQLa7FgZLihdbKnVGSEmtM1lKKmpEU2ck/wI4PJJRgRJaX/qVI
	 0jX4xeVwXMhfW6iDik76TqrWCY7ZC6590tRZDjK0Y1+VVcP047TEsghEhObXwVnna/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840714;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6TMe2Ccnv5qjbtBbc8Ely43sy+kQVkJJ/fNbvF1VPYQ=;
	b=GGgIVctuMCOxl4C9ZX4HyAXAF1MJD9CuJ1U90Y2/iepJkne7Z/x2vU+6Lglz/uL8TpD3
	 9rBcw3skuG5KibD9gBfgvUnHGDwFwXx+jbX7sjPS7yl9rk4VREPt8hqL9BplTEnI0qbfa
	 n2Z7NcQwiu7DUg5GYhhY6OfKGdz+CgHdBLEfc4UX72LXckcJB9JyAuWZcYVRKcN20b+vW
	 lHIHgUmLLVdU/2vgzNdjBTOlr0M1qf0rBxAxpSSE6gSc+vp21oqETFkXG9t5yyH+NEMGo
	 ybZNaMTuUtw2ELDNb8RoY9/Vdt4+Fweb0JF9OC9iU5ZdhsObR2vot3mw3ShtaKao2Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHHNdrsv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65EA606A333
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHHNdrsv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB281F00A02;
	Thu,  5 Nov 2026 01:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840713;
	bh=6TMe2Ccnv5qjbtBbc8Ely43sy+kQVkJJ/fNbvF1VPYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oHHNdrsvp98TUgJ7TqiS6Ro2ABwaAx/wTu4G+7Ij9LOnSz+RfV9OK4CJJDO1Lbzbl
	 xOL9J0PpDFvIqTptqp/TgJi0lHLcbi629XoiaQmYeUG1/+s2+L6TbZDEJ+iBLr9D7W
	 iO33D62K1RJUGTTni7hJIesGEI3yZ9n3A98sbErWmk6AGZ0Vw9MwLLwBj5IYygXOOu
	 S1fnTuvQJy2ecq4xzwerFZLLMYqaCBzhLY5qQjt5fq1m6U53mlzBtYniVFWBff8oTD
	 EA2nu0afHnoXWr+F7vbRx0iVZZfBCxGta7DtFtQEbiXpSElAaOigDp+CQeRs8lVOqQ
	 WKh10J5FRQ8Og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
Date: Wed,  4 Nov 2026 20:05:12 -0500
Message-ID: <20261105010459.1096550-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110455-abacus-sitting-9c3b@gregkh>
References: <2026110455-abacus-sitting-9c3b@gregkh>
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

From: Sean Young <sean@mess.org>

[ Upstream commit b3f5daf3222999d3f92f606a4eb5e35ab90fd0e4 ]

Mark the device as unregistered before tearing down raw IR/bpf
state, so that racing bpf(BPF_PROG_{ATTACH,DETACH,QUERY}) calls
cannot slip in between ir_raw_event_unregister() completing and
dev->registered being cleared.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/rc-main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 2eaacfa1e29eb..9ee1ea13550bd 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -2030,18 +2030,18 @@ void rc_unregister_device(struct rc_dev *dev)
 	if (!dev)
 		return;
 
+	mutex_lock(&dev->lock);
+	dev->registered = false;
+	if (dev->users && dev->close)
+		dev->close(dev);
+	mutex_unlock(&dev->lock);
+
 	if (dev->driver_type == RC_DRIVER_IR_RAW)
 		ir_raw_event_unregister(dev);
 
 	del_timer_sync(&dev->timer_keyup);
 	del_timer_sync(&dev->timer_repeat);
 
-	mutex_lock(&dev->lock);
-	if (dev->users && dev->close)
-		dev->close(dev);
-	dev->registered = false;
-	mutex_unlock(&dev->lock);
-
 	rc_free_rx_device(dev);
 
 	/*
-- 
2.53.0


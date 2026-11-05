Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840335;
	b=4Y+of/hSCJbRORFRcjyw1vluK++7LfiFBSRzzgKXBrEtvGf2xh50R67qiVnR3QaKwe2I
	 doqWLnI4nwFNCaHevu19zYZhH0ltJbv2T3gGtR9C6rHn4vIJwUrFADlIAseKUI7Usu3W7
	 dBenoVfzg5yWLNquaFNF8zhyd0/ENdROmiirtIXs2Kjnwado1FKAOfBS/eQhpFc2w2LHk
	 DmvK6QTxf3MQuHL1d7Y9HZ5iC71vtXv3ioenF+Nt/eyoGIkWGBRywqIIy3jX6fR99fQ+s
	 adSZ5c429W2FKkJOREaC6vIoxNIOJ+UDJQ6Ldc08e343NxMvTFZklUMnVamLv5SZCGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840335;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=E0KD7sIRBBStP7RwymxXXksRx9Y/l87eJmkf8YUIm/s=;
	b=sBXotRuXG/XQcM+KXp1nBV4AeIEZQL2L4BqfWkpLI0Gn5f76EcmjES1hatSE+/rpROxt
	 A2SIsQInit7NqyERZZ5MX8eIZGbjvh1AU6QXtPGCTrUXGEUrkcqtYL1UoHb9bhaAihY20
	 aA3SO3eUeVA6XpEJB9WQKlIELn0y+dSxaIDxZQDd7FK/KpGKYxFKpO2EaHmM51CSKg1XP
	 KHiwk0LhINJwiOIQDJlet53GX3171QfC6ROKi4rpGUOVpQhpzs2Nzp0ntWxcpE0KoJokJ
	 D/VXhCWFbs2SkTP1vpR7pRsnf/GeGlYopn1cBjFhgDREIAN+4xr0qD8Xs7F3dors6pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i/KV48Au";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC03606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i/KV48Au
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAD41F000C1;
	Thu,  5 Nov 2026 00:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840335;
	bh=E0KD7sIRBBStP7RwymxXXksRx9Y/l87eJmkf8YUIm/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i/KV48AuY3F8DyCBB1sd+1dh9WSwKgXJD9H8ZTQ7SkFjUzcsAXJrkHuaIyVcRqP+q
	 Q+2KEQqekkWPB49LspsF8CwscDLTQ4ggrtCWkQ3snrEsqR/yzzfehTUoa58UlMwkYZ
	 +FYqqWgQQ0GhxRq2BSNnpkRnHpKVnjg0R8XVz5IY31JfRXIVLZ593Uw4YWsCS84+Zz
	 cTAmH5457GQdetPCIZwQeUxtJs43WgLjS9CtsomzxqThr+g5yCRGcPtsaKsPnWHQHx
	 NM/3hc7elwkLueWQmjQgQAfgxdCGHIH79bDwq9AEf22yLu8v5ZN2VFlRN9H8uAtNL1
	 5VDID88Nqc+2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
Date: Wed,  4 Nov 2026 19:58:53 -0500
Message-ID: <20261105005847.1080650-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110454-prepaid-repulsion-f27a@gregkh>
References: <2026110454-prepaid-repulsion-f27a@gregkh>
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
index fb52ed2d4ef6b..eb19ee6765dfb 100644
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


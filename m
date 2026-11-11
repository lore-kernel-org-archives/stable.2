Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409678;
	b=3KW78g3ACNzqhYwAJrHM7j0Qsvv14VQqSTv+bIHHgPt6brpW8+zGctK7o01Y8aFuXMj2
	 Xrxdj+mwIc7bPnUV4TSOqFCIuWFYHcfWQlvgOqj/sV1SFtl0XhKlPYSkNlh3h3l8sOUL9
	 BznPIXIgFHjcQ68PY3VQeVPQviFPFnWA2cWqlfaJZ5ibQm1ayAMi3N3yo0NY/uK2p7ckG
	 g6PIHF93O6HQ2308VebsLIiDV9S2pqQykSoO0Bu8278kxWx+OjUoD8LDEiXip2yDrAOvg
	 bViRRC2u0RIujNDI1TdJ7jxOYQlXw1iOTes74f+EV10ZQE09TTjkp9lrLB7aNuzBDDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409678;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jTg4NwvYWDU6YdIr8WyNrufRY3Ef/ygRz2H0XAtJx2Q=;
	b=h0TiqA9fHQCGhUbqH3+aZW05iWTCSQ5tQ5+wYhSw4/oPTieZsZlkCeIp3RehRTEDOZf/
	 kqi3DHOTujLA+zLqlhAKaz1Ik0ALmarEjJnST4gmMa7UjyTrBWXKe5VUw2bY/IDBqY+00
	 Q6VxnZ4x8cSUC8S/iWFXt1/l/L7iM1db82n0+2/mYgvvj07tzRFc9q9QPathThQ3bKMaD
	 ILCSKYykNkbv2SVp5rACX/fwIxxyHov5KCBxFjqPbwijJIw//o3fKmQzcfL5VZmU1wmav
	 ME6WPxzoUV11xvIG/K8bCQ4UrlblBal1vY6DxyQPuvx3qy6bV9u989I1zV4tCW7L1Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AK32ScvS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BCD606A331
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AK32ScvS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9CA1F00AD6;
	Wed, 11 Nov 2026 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409678;
	bh=jTg4NwvYWDU6YdIr8WyNrufRY3Ef/ygRz2H0XAtJx2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AK32ScvSFzpwHcpMcOeqT8xEhzWQ6pLvlYCML99g20x1439tsL2NuOqjkFgbs/nGm
	 J3M/9VKjGn7mVfb5SnZXOdkKBGYRigWKFkqZ7mKHZscOqFnFvWhF2ddvJmW9ucsVnN
	 LHmBZBOCy4VTrTkm0aYCHmuwcIvCeotPyXsmt4TdjCnfAGyFAurx5uLH3CVCkMhKn4
	 5dctRMPzZOIWobVwyGOGYOoSZuSTC4v7WDzuAQDxPo0tHGZLMheMekfFHNYIL/Cp+X
	 00kaO5jakvecK6N1U5g8POHeNZd0p0ofn7Bq265yWz5K1q8EW9MH9NDoTVMAo5rOVJ
	 bdlcYLnN+c8Lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: serial_ir: Fix race condition where timer can be re-armed
Date: Wed, 11 Nov 2026 10:07:56 -0500
Message-ID: <20261111150738.2590511-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052952-failed-6.6-d74ac4016ba6@kernel.org>
References: <20261107052952-failed-6.6-d74ac4016ba6@kernel.org>
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

[ Upstream commit d74ac4016ba64cb3b20f395511d0b18025ca0ba9 ]

Ensure the timer cannot be re-armed.

Fixes: 2940c7e49775 ("[media] serial_ir: generate timeout")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: replaced the existing del_timer_sync() call instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/serial_ir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index 96ae0294ac102..dac341c68b2bb 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -797,7 +797,7 @@ static int __init serial_ir_init_module(void)
 
 static void __exit serial_ir_exit_module(void)
 {
-	del_timer_sync(&serial_ir.timeout_timer);
+	timer_shutdown_sync(&serial_ir.timeout_timer);
 	serial_ir_exit();
 }
 
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BA23FC5AA
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195290; cv=none; b=J5SD5y2Wkx0ef3Z+ki6sITNEz3i0IBM7zhahnKMvCf/NtwryN90YQzJYmphF1lF9889mITlJdePUkg4IKDTCVG8RF5DD3rn03v5GlcIeuSaRxGmY7R9o9eZmFw4dRyc0SICKL7IHYbVABB4r10s3TYVpsd1QzbCcqMw5e6a+3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195290; c=relaxed/simple;
	bh=j58ZsVWGfWYB1n8k0Rgv40JnKYRg9i2/WC+9oI9hYPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYWpCXhH4Z0jiFkgR2lO1h5zyt3DOupiug7+JNPkzvDV1uJq6RPzQ92TrCQoOxhprihdQjDjHR4AQ+C5Ga98BoI/cJntGOKfVr9SdM1X36RNxBX4cXxrucs/gbFDaEKbnmmicQPLf14BYwNJXrxA2UKJqSANFH8Uz3yl4I7ThEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAAFlL8m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAAFlL8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92391F00A3F;
	Mon, 27 Jul 2026 23:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195289;
	bh=TeZK3TOEP0lAH3z/NhiOR8WaVfkwjEpo6f6SZajqfuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jAAFlL8mybxHnAtbsWSfvipW3Hpi1ftvb2R42I4oloButPJgjEQXrZbUmrxJQxnS2
	 EEnY0pTC09S8XIyBrG6divR9SaknptZao9VNTPbBUx4FSkQlLvKf73Ej/Sbb0KNZWV
	 g/werOoCqexl6A9MqVZtOQf7fnq5bU5mWPR+ep6VrLUV+Re0mXV2x8dgWqkycp2LsX
	 5KgiedJDr9RRB6MEBc9ZVo+H5dJUfPOFxD/yjJHp/P9Qop3+MDsYMjPtRHMatIXG6U
	 mk/wzHDiKO7oYU62dLtGDG8LaIXf8F254g5RRz418xHLcGZLjDDmETovl//Yme2uRY
	 +bGO3g1NNh7cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH 6.12.y 3/3] mmc: vub300: fix use-after-free on probe failure
Date: Mon, 27 Jul 2026 19:34:44 -0400
Message-ID: <20260727233445.2426041-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727233445.2426041-1-sashal@kernel.org>
References: <2026072046-octane-riverside-49ce@gregkh>
 <20260727233445.2426041-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

The vub300 driver lifetime-manages its controller state using
vub300->kref, with vub300_delete() freeing the mmc host when the last
reference is dropped. The probe error path after the inactivity timer has
been armed still bypasses that lifetime rule, however, and falls through
to mmc_free_host() directly if mmc_add_host() fails.

The race window is between arming the inactivity timer and reaching the
probe error unwind after mmc_add_host() fails:

        probe thread                     timer/workqueue
        ------------                     ---------------
        kref_init(&vub300->kref)         ref = 1
        kref_get(&vub300->kref)          ref = 2, timer ref
        add_timer(inactivity_timer)      fires after one second
        |
        |   race window
        |<---------------------------------------------------->
        |
        mmc_add_host(mmc)
                                         inactivity timer fires
                                         vub300_queue_dead_work()
                                           kref_get()          ref = 3
                                           queue_work(deadwork)
        mmc_add_host() fails
        timer_delete_sync()
        mmc_free_host(mmc)
          frees vub300
                                         deadwork runs
                                           use-after-free

The inactivity timeout is one second, so this would require
mmc_add_host() to both fail and take more than one second to do so. This
is unlikely to happen in practice, but the error path is still wrong.

timer_delete_sync() only waits for the timer callback itself. It does
not flush deadwork that the callback may already have queued. As a
result, queued deadwork can still hold a kref while the probe error path
directly frees the backing mmc host, including the vub300 storage.

Fix this by using the same lifetime mechanism as disconnect. Clear
vub300->interface so that the timer callback and any queued deadwork
return early and drop their references, then drop the initial probe
reference and return without falling through to err_free_host.

Fixes: 0613ad2401f8 ("mmc: vub300: fix return value check of mmc_add_host()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
(cherry picked from commit a3b5f242997a3be7404112fd48784881560aea57)
---
 drivers/mmc/host/vub300.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index caf19051ebb483..225f2be2a7bca6 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2343,12 +2343,16 @@ static int vub300_probe(struct usb_interface *interface,
 			 interface_to_InterfaceNumber(interface));
 	retval = mmc_add_host(mmc);
 	if (retval)
-		goto err_delete_timer;
+		goto err_stop_io;
 
 	return 0;
 
-err_delete_timer:
-	timer_delete_sync(&vub300->inactivity_timer);
+err_stop_io:
+	vub300->interface = NULL;
+	kref_put(&vub300->kref, vub300_delete);
+
+	return retval;
+
 err_free_host:
 	mmc_free_host(mmc);
 	/*
-- 
2.53.0


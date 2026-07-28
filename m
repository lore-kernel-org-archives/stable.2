Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7162F2914
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 02:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206805; cv=none; b=UfrlnW6MYPxZoi0ODBoCZanO9IWyUaVu4vZdlEzTjOIEb5adAPKbcosz5TfGDA402pwCYpuIPV1rJRSZ+ulE3GXWcGOd9lz6i9m7OtcgHTCETVGXIQJMXO/ilCpUr34vSHHZgMqxShpn1hVlEVo53SL+tbU37p4hSRORhNba1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206805; c=relaxed/simple;
	bh=/fwfhtVAJ8xIVA5moMPIw7jz37EJz/ueISszu3sBiSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBErnwL5Ml3mNWdigooqcbH3g19U2eYxO9or56UsBsLLTP2aPbJzGxva0bjyj7BfptuTHAQ3mnfm4QMkkc/HLPWUzYZOPWp4HWH3aLRtewdknxTHNKZpKknGY3aInwTMAW4YlRkG+3UFaU5tlfxmpOt3GZgCfOacg8RB5RLot1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqSJ+BGP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqSJ+BGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5C81F00A3E;
	Tue, 28 Jul 2026 02:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785206804;
	bh=M02JqQrPLAh8Sj9naY5A9VXQuLrhRKKZ0xCWaXC1rSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BqSJ+BGPPF9WeUKjqhYti8NF53jMebLWobJRqCzrPvQnMkaoL8f5c3D/jICMZId5i
	 IgjxY+DfyjZzunhGK2bOBNeU1rc1BOFpzAuXTdRgujt+bXYf+q6L4chWRnl247ffcU
	 GZisQE91Beapf2wZrzxtmVsiC8K1QItBz7ahLXJKQxv6flYNYEcA7jBoEzT7YwKfsm
	 bnFjmmOb5PVAD1UaSKzPwrT63sLPm9lT39En7B3/DyJ8aJU4Dau0wzGFLGB8eX752n
	 7S7LdlQ/5KRnQgeswpv+vDabx3IvttQWkTUd2GmCmhcYDEy+CgvANkCRJ4cx4IME++
	 WaidMCq5pY+Tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH 6.1.y 3/3] mmc: vub300: fix use-after-free on probe failure
Date: Mon, 27 Jul 2026 22:46:40 -0400
Message-ID: <20260728024640.3058357-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728024640.3058357-1-sashal@kernel.org>
References: <2026072047-sliver-vagrantly-00bf@gregkh>
 <20260728024640.3058357-1-sashal@kernel.org>
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
index 63286a3a7905ea..a3f285d3253f6c 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2345,12 +2345,16 @@ static int vub300_probe(struct usb_interface *interface,
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


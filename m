Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F333A1A3B
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190850; cv=none; b=grAS6A5LnvfQBFwhYJx1U6RK1otNZ0Kp3zn8lb2ByRx9U5qql+kmiTvEeHExXnPkYnR8otT7sG01iafE2pJZvnGR0D7KlUXLBx/uN2uIwTpnNmhz6pSq7OZTNPEEuBWWfk0ntDSkZxO/qkaTJnvR90zxEYswOqsTM6LlSRXwhq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190850; c=relaxed/simple;
	bh=95yl25xoZxABhktu02cYjY8Wl/wbPR0THNiJhV/TE6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTTyP9tJF5hC/hONRupd3NoPumk39Vu4IEwLq6bVC0Gzn4JVEW+LvOqNgdj0xwPQ+4ZhpyRYYYXxqjK4gVX9yVnWITxTCmDcfKbgkmQq/ao2ljl/UXjo1SJXGUpRkQqZQ+cEYC6bzwJDHjZOQHi6S7ZZdO7CswHlJzyp88CBu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp39j7ho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp39j7ho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A861F00A3A;
	Mon, 27 Jul 2026 22:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190849;
	bh=lcGVyhp9krDQk8k3DfawR8qu9Aw2kmgvF/Hb+noblK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mp39j7hoWIlSUDY1Z+zP4N8rizkq7RWP+g4CKhvNLkxIcn/SXLzTh5gXRw6kfDL62
	 st+WbcZ/ft/Ogmj2l0pq80gZkip7MWrmj04THjahIeYIjxuApC+AnYsWedf9ZyahcN
	 ikg0kgGnSoACXtRsU5ZeiXEbpjjnMTRlNLO8PfxccJCzx6kYL8jh4+exCBr5UmHvSD
	 rR8Ch/fWFGaJZY+TuZRIdYNrML0NTQrgU/qYoBZ2cCSDabnj9jJvhgCuGzUcs4brzy
	 GcmDMgxujWnhAEefZH8AYfqdgGTxbKPZ1h5/zYuG0ehqs0lkVSIDtAn4tiMexrXsJi
	 q8aBEkCgNqVIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] mmc: vub300: fix use-after-free on probe failure
Date: Mon, 27 Jul 2026 18:20:45 -0400
Message-ID: <20260727222045.2118748-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727222045.2118748-1-sashal@kernel.org>
References: <2026072045-starboard-ferment-23aa@gregkh>
 <20260727222045.2118748-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit a3b5f242997a3be7404112fd48784881560aea57 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/vub300.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 9a864369598160..1614e9995ee68c 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2344,12 +2344,16 @@ static int vub300_probe(struct usb_interface *interface,
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


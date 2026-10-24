Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792857415;
	b=cLmB3luGeOwUsv+Xhw7bmM9usmhQf5YMcDnLCISAIa09R/fX3tmH8IePmXcFicbWOjIw
	 3wn0ErX4BKT5LiA8lLedRtJTrAi91RwgIK4rDKXgE0ita5vUR2gv+DuaURIMDlgFPW1AT
	 OLCFX3PFLr3q7rg6fJXCFSR53bVOpSrFchoxUAiyJdkzogMSG/ftyLavqvjWgLcXtL5FD
	 2ATR17PF4h76uvlRIblHI7wK51fRKNOiF2X/0un/4oFlYSkwdk/XNe8MPLNqf/TmFJMX7
	 bydX0m9rb99LB1gsTSfUFpnDBLYAE94BoCGERaG+GU6QFbrBVcr2xJfKdX/fvLGugrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792857415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4IGEtUDUP8hIGn1B6H6glwiRUGb2LO/zEIMANk76MHE=;
	b=Iv+2OXwTvtg0mmUQ/ozO0Wqq4RPU7GXlbj3yjxg8v6FbjCNc88bn4OaCs64LJ1QUOobS
	 oNeLL6u8vfH/ojgjjdfxm10SiuCpMbdRR6qrfT7XljhEBq1Qh+4AAw3Ign0qdc4kVAUAt
	 XPj7m90WgfaKvKBERLt2e4o83wx7gH8/UE2ow/rKorMpcCHBU3SSdlyHvefgNu2bOtoxh
	 pRn8ndRJHxhRmwWKQbyIPcQyfzCydJe+PFS7Y0hGU8ERW/Co0RUyhVs3m1R/ibpVKnJT5
	 FuTH2CuTEdbI1lFt/GBLh5ooQTz2fwmn5c4dNWekXftLRSDyMr5/3jb1GN+0s2W3g3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="cJ/chxiA";
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C6606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 15:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D2C6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cJ/chxiA
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be3cff0f6cso1114799e87.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792857413; x=1793462213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4IGEtUDUP8hIGn1B6H6glwiRUGb2LO/zEIMANk76MHE=;
        b=cJ/chxiAGQdCLJ7qIgX4jKU3DfB4TEGMxUrjXMK3Cpc23TyIwLB+pczz6G6eNaItEE
         4IopNSI8HH2LZSX1BPlG+NShrscu+D+4Tdupw7beFLq3wBIIS3BRvi+orn2WW9gUpnuC
         jDyHVIvW3SYt4sb6iOW3Mh8DpFq/T0WVoavGq5sGELjnu3mZsfoDcZrB4XO72nHAO7aT
         0ifhjkq8x/Rtcu7FFdZfpFMXABvAgkTufOTaE6YL8UkY3mpWnx6/gj1GTgl3T1g4t+Fb
         eQSHldZTJGVlABideEsHp/GYLYmMFU3hXzIXGQFkFRLXSpTK0TG6dOCqRLA9YvJMqUeJ
         yyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792857413; x=1793462213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4IGEtUDUP8hIGn1B6H6glwiRUGb2LO/zEIMANk76MHE=;
        b=LnuILJ32VYv5JNgFIFuHgk7tOFd4qulNjVNSLcRFUDsF+7fFqdl8DZuFOvFjk+c3dd
         VU8LFw2++X6+nsryGC9I/NzVjocEU09V9Bi626YuTmEjebfehniYxPX24HCaYuMJYT5I
         23Fz3XO4yR7efOPKv0V/+1vH7AoUf3RHTkTxjtRlYiZF83t+WkRszOWh2yl2OqQTMMhH
         05TLCmaBNh0QKqVXjDURDDrhKCFkNraIjH7W15nlT3Zl+VcHHnOnMDiYC2o1LWyqRrha
         CLrnc2MxFN0uEpEP5+lo/TYGQenRCI1t8MXA86g16/CFt9+L2UvT7EiALRZDIFvcIJOU
         a3tQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhe7Yi6z8jSNFkbq2NUv1us7/rjwE3bf6ecy926WCjaZCHB1G9WoWFwHL1G5Go+uggr4HP2fc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWrl3k6PaRWlvIYAz8TTABImQo/rBIJ0VXlqtgRvEx5basHIlf
	mUm0/q8y7Ji61a9olx/wUyXqkH0j10HxTr5L0YDGSGgIzn7wwYtcgbtq
X-Gm-Gg: AYBFou3OmoPHdxd/NV/pPYyBMa0HtvqNbg7YDpvv8FfyjJIdIlSjsoCK8gXrkrW4k+R
	85Y8A6zqSY3/9RtNFmsK0t/RW/YK+OjhP970K6ZgdWCY9/7eJG23DKKpKE8SvgYUrxUlcFY38vV
	Ttqamlw8WvKjfsoqAurTvlLpzN6pLhNTdK7njklIp3a6gqdZS63QBK937bSciRNCQiq53HVLGOl
	gtprC5M5nP0kBsyHd6WsQ1C66J0k6jH3aJmBj83jQaigR/62MV0i5PUdNhT/PZX0rMTSAMvGX4q
	Sj7E3U0q0xHDy7w6Y4Jlrl6+8AjH/TRPq0kG2au64L4IhfhBgQPgObnoh1cC83Xa7W3yt32GvYu
	I531zRzVYr6NmP9IEFu47wv32I6djNY8ig82n93GO6PFTOIKFBdfFGU1/CPLDob6GF8J4StAasB
	1jneKME1xtgbz2UlhyoKy3u1xPbd2JEWZ7W/cGlMklGZAi2zw1thvBwdotz3cHP8Pk4UKXmhjkJ
	gBDXUBiFWDLSrQeYTMmV15KKxT5WVzawYao4m+wGlB+uPQ5B1ynFzzL2fya2UlzfwFRSfcTEQkg
	27ZkCsLMF3vBVlrSG8A8tMtZxqP+0YRNLGlhDUIIu48bbkjvpICYw9NzAmA19oGYWzkqZSDtGgJ
	FtRRPHg==
X-Received: by 2002:a05:6512:128d:b0:5be:51d0:e355 with SMTP id 2adb3069b0e04-5bfb719e481mr754446e87.11.1792857412423;
        Sat, 24 Oct 2026 08:56:52 -0700 (PDT)
Received: from x870steellegend.lan (95-25-165-240.broadband.corbina.ru. [95.25.165.240])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7d7d6fcsm459298e87.20.2026.10.24.08.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 08:56:52 -0700 (PDT)
From: Igor Putko <igorpetindev@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Tejun Heo <tj@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com,
	Igor Putko <igorpetindev@gmail.com>
Subject: [PATCH v3] usb: core: hcd: flush giveback work on stop
Date: Sat, 24 Oct 2026 18:56:14 +0300
Message-ID: <20261024155614.2732-1-igorpetindev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023174015.54793-1-igorpetindev@gmail.com>
References: <20261023174015.54793-1-igorpetindev@gmail.com>
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

When an HCD is stopped/removed (either during module unload, driver
unbind, or an error path in probe), pending URBs are unlinked and
completed. However, for root hubs or HCDs with giveback done in BH
context, the work function usb_giveback_urb_bh() may still be executing
on another CPU after __usb_hcd_giveback_urb() drops the URB use_count
and wakes up waiters in usb_kill_urb().

Since the caller may immediately free the struct usb_hcd via usb_put_hcd()
after usb_stop_hcd() or usb_remove_hcd(), the running worker accesses
the embedded giveback_urb_bh structure in its epilogue (e.g. clearing
completing_ep or clearing the running flag) after the memory has been
freed, triggering a slab-use-after-free write detected by KASAN.

Ensure all giveback work has fully completed in usb_stop_hcd() by calling
flush_work() on both high and low priority BHs before deallocating.
Also remove the misleading comment in usb_remove_hcd() claiming
flush_work() is unneeded, and document the queue emptiness in the
usb_stop_hcd() kerneldoc.

Fixes: 8fea0c8fda30 ("usb: core: hcd: Convert from tasklet to BH workqueue")
Reported-by: syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspotmail.com/bug?extid=a5b220cacb0618384d5a
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Igor Putko <igorpetindev@gmail.com>
---
v2 -> v3:
- Remove obsolete comment in usb_remove_hcd() regarding flush_work().
- Add comment in usb_stop_hcd() explaining why flush_work() is needed.
- Update kerneldoc for usb_stop_hcd() to state giveback queues are empty.
v1 -> v2:
- Use flush_work() instead of cancel_work_sync() as suggested by Alan Stern.

 drivers/usb/core/hcd.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 8e8a5f59b319..f403795b17ba 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2773,6 +2773,8 @@ static void usb_put_invalidate_rhdev(struct usb_hcd *hcd)
  * usb_stop_hcd - Halt the HCD
  * @hcd: the usb_hcd that has to be halted
  *
+ * The two giveback queues should be entirely empty when this runs.
+ *
  * Stop the root-hub polling timer and invoke the HCD's ->stop callback.
  */
 static void usb_stop_hcd(struct usb_hcd *hcd)
@@ -2787,6 +2789,13 @@ static void usb_stop_hcd(struct usb_hcd *hcd)
 	/* In case the HCD restarted the timer, stop it again. */
 	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 	timer_delete_sync(&hcd->rh_timer);
+
+	/*
+	 * Even though all URBs have been given back, the work routine itself
+	 * may still be finishing up and accessing the usb_hcd structure.
+	 */
+	flush_work(&hcd->high_prio_bh.bh);
+	flush_work(&hcd->low_prio_bh.bh);
 }
 
 /**
@@ -3059,16 +3068,6 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 		usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
 	mutex_unlock(&usb_bus_idr_lock);
 
-	/*
-	 * flush_work() isn't needed here because:
-	 * - driver's disconnect() called from usb_disconnect() should
-	 *   make sure its URBs are completed during the disconnect()
-	 *   callback
-	 *
-	 * - it is too late to run complete() here since driver may have
-	 *   been removed already now
-	 */
-
 	/* Prevent any more root-hub status calls from the timer.
 	 * The HCD might still restart the timer (if a port status change
 	 * interrupt occurs), but usb_hcd_poll_rh_status() won't invoke
-- 
2.47.3


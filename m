Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114423;
	b=qcMS6tNdNK5tdrodKfBhnK9xgbVKQTefBBGvO3/XRk1MAzzfyAEH+hcPWMjHQLWnj07P
	 uBna1lnGlY5RUczFXbeMZOlVC+1JYRWg/Fv/qCls6aYa98tW0jDBzMMWlQskYgX8tRLdF
	 Yx4HvbtXFbfLCk4IhhzR/OhuYSfdYVzQs9C5JQxXGtv1Cb27sprxmU8qurt2+BB0R4baB
	 zFeO1AA1futYn/drY9LD8pEbdx1EajopmA7QC9Ww+gREGvs2nlJQa49r20BM8fXlVzdEV
	 0ZzvgIyr/LImdYaiQl+yS2iGbLVtdnxld+m0pejMlAQJLsl6gj6xYnv1Hie/LFUpQLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=0PqfAHGAd40i5XU0M5mf2whuKeErQOslns64xb65bJg=;
	b=Nz/SN/B+b89Ff2dyTTUcYkSNnnQ0siLqL1XmXL66MRuxI3HR12j1ay75336q8IFMCJfk
	 6exipS4JLRH1aeHIX6A22SdTTK2+minB8yAvnEw252P6B1m/ZI9hx1nunfzWdNpUh38rb
	 AvUw4KvmPZxPg1YEk99gt5KH7XCs8ho5ddyQAYOoQxHIFWSHjSMxVPyw5oeTO8o1NdIhf
	 Zw/T7kwnscT3Impzty81YutxZc1/gvHmHfs+QPVTG4OneDHLnWa0kVPIZGmcEFyazLoPU
	 pL4iY1FE63t3bz4Xe2DK5Y2EPXlqpL1ORQZAm/cU79BMA0vVONXpJvpApXnBishIqRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nexthop.ai;
	spf=pass smtp.mailfrom=nexthop.ai;
	dkim=pass header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=Cj5y3NEm;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B89606AA9E
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 18:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53B89606AA9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=Cj5y3NEm
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a2af4c8d00so152966c88.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1795114422; x=1795719222; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0PqfAHGAd40i5XU0M5mf2whuKeErQOslns64xb65bJg=;
        b=Cj5y3NEmnnoPK29eW4kQ27l/Aev8gQX4z66CRL0ihkeUZgXoX8iwlW1jwaLwQvENvY
         vEs86qiji7C+gKneuVtoeWvfuiPM1MZXi78a+OkNyaL+333hPj92Pa5rpbmbEaSaWhCt
         QeqF7dLl/EQHrjx6NhVdYAK5eeKo+BXBHmVlkRiZZ+kEWTlzoXL0zRSNo0uCyHr4Ku3c
         T/rvEZmghqVcbENmxJoD2zzWvKhkoDThxCr9kMK7/ceYi6Q6G+KahER3kmes+taZZyw5
         ozO3Jd85wkGUlc47B7yYcfwW2eYcDkv506tnpnVLKYApwUXE9Eq/cL6sHfd6+yU+fWFp
         Dfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114422; x=1795719222;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0PqfAHGAd40i5XU0M5mf2whuKeErQOslns64xb65bJg=;
        b=Ob/9lpdWijQDk0UpArFX9VKw2H0UmGy/kwm3M35kO0VSx6VhzIm40oUtvl5aaHcQi1
         0gyOx0YaMGA/ZGm47nCognGLVWS/EoDe9rbCm2I7N7ByU3iFhs3Kt5XTNrZQuURjEyjr
         DOWvDFx/dGNwsJK8ClONMqPrbrifcmA9W4JCA0sFMO2yU7/yPs7O0DEh5XwOr6GWQJxS
         IHHlI+ONcUYMGUDVdgry82vQDRDMyqO8UY+uuhxBJYGOUjI+dyBvl6v2YjDWf1hMLrUf
         gixPPgwKFok1jqa1YTna22roVvJJbe9lpOOdMiL3wz2yWdVA2gPSOcy2BMelXnvkjKSN
         f/YQ==
X-Forwarded-Encrypted: i=1; AL+hErHUR5MhoHQo0lDhgJ4gABPNhNS1wxdDORVtbCQjSPckiFUKJO1wuPnduRTVGGhP0RmRf6bAKmU=@vger.kernel.org
X-Gm-Message-State: APuU4Z95TNjfORgJVKURj5Ecn4xAdWHx/j+QJr4yAvqxFBjrABUxr45b
	7nUjpTCQI6gXChmHBmdVbEmCwO9QK7EMC826nsgvhtLCXBLifaSvHMSgIKmoXW0/i9E=
X-Gm-Gg: AYBFou0i6gFJVdjnk03BJFQZsaLjECjkfS6+1a8VAnjvZ3m60XDABC3Lt5TX4h4tOkl
	rkNbUY/s1W6Z4FRWCPtwnsYwdMwLn6O9Tvc0tphHUCxEuSdCCo+mQnAC9UMcn68YWZem0wG98fk
	IBMlB8YJHSiqhcvBGtJvVMjcpCZN8ByXalpcrLuc5ngbwYcm74FCCx3tBGtZXkjf4f93Lf873fy
	wLKAN3HoUUCs2PP8KxDsAtu1aL4YSrAbNmRAbgP/VIVO2j5cP3Pi/9dUYvPPns16bDo6kDSAXIC
	0UcO8zsJEcJ41EUI6PQHVKoV2ha298Db8wweJPZWfem3WuAisp/+JanQszSAxlVmcL8p8BLxjlZ
	Ufmkdi2eL2QALeVJulq3pWrBm4nnBYy8PHrKL5H+/ik4tJIdxovSha3GMy82mbPFzMVA35gKhPK
	BzTDaReehrBX8kivYL3n189nBz8+mCqD28ig4C2Ww4yYQYOWKWegaRUHZ7i4Q+JNGO7eh29Uau0
	/FNzVgYPRNMMVfJT5WGUUF67nfEm7i6vKiHkPsI8dphbl0IdDiUADkEGEDxyVuEyzGSjYH11vba
	7Qrkwb2gzXCKEyHwm7mAe+LghjvbZZDD/nEYykKHiJBYa0bVnPaZxe3lxfBadhU0ZTXc3FwZVWB
	79m9ZGU+Nk1jYF70lGavLvOc7CO+zlJZ0TEI2Pw==
X-Received: by 2002:a05:701b:204e:20b0:1b5:2717:61df with SMTP id a92af1059eb24-1b556913aadmr513093c88.41.1795114422151;
        Thu, 19 Nov 2026 10:53:42 -0800 (PST)
Received: from [127.0.1.1] ([23.145.140.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556831d45sm1243475c88.11.2026.11.19.10.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 10:53:41 -0800 (PST)
From: Deepak Gudiseva <deepakgudiseva@nexthop.ai>
Date: Thu, 19 Nov 2026 18:53:39 +0000
Subject: [PATCH] ipmi:ssif: Stop the thread before shutting down the timers
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-ipmi-add-smi-races-v1-1-3b8b3648c512@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIALJF/2oC/yXMSwqEMBBF0a1IjbsgiRCCW5Ee5FNqCdqSUhHEv
 Rvt0eMM3j1BKDMJNNUJmXYW/s0F+lNBHPzcE3IqBqOM1Vo75GVi9CmhlM0+kqAKLkQy1jpVQzk
 umTo+3mj7/Vu2MFJcnxJc1w0g/PubdgAAAA==
X-Change-ID: 20261118-ipmi-add-smi-races-0b8bce266803
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Deepak Gudiseva <deepakgudiseva@nexthop.ai>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2996;
 i=deepakgudiseva@nexthop.ai; h=from:subject:message-id;
 bh=+JEXlaWP/zh5alnV9fcLemqg2jKzFJudCgjLXAhu3f0=;
 b=owGbwMvMwCW2K69T+nFg7EvG02pJDFn/Xbcecoia3+78cMrRHtc/lVYny8t/Od+T4/l3+Mb1S
 5KeZ+xKOkpZGMS4GGTFFFmi3nNsVTsnmfyTbaYGzBxWJpAhDFycAjCRAH9GhjUrypctFf90M25X
 79uwRcYnekLNxBnLgjxq/0r3czdf0WP4p1BcGMIZv+XhjOcM3/7V/vPqkawrztJ+e1inJ6Z2wno
 hDgA=
X-Developer-Key: i=deepakgudiseva@nexthop.ai; a=openpgp;
 fpr=5AEF08B526CE1963F9069928BA6E891BE3515DE9

shutdown_ssif() deletes retry_timer and watch_timer and only then stops
the kssif thread. The wait at the start of shutdown_ssif() only waits
for ssif_state to become SSIF_IDLE, but a normal message is sent in
SSIF_IDLE with curr_msg set (see IS_SSIF_IDLE()), so the thread may
still be sending one. If that write fails, msg_written_handler() arms
retry_timer again after timer_delete_sync() has returned. The caller
then frees ssif_info with the timer pending, and the timer fires on
freed memory.

We hit this on a kernel without commit 88f65f903d25 ("ipmi:ssif:
Improve detecting during probing"), with a BMC that NAKs every SSIF
request: registration failed and the interface was shut down while a
request was still being retried. When the freed slot had been reused,
call_timer_fn() jumped to whatever was then in timer->function:

  kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
  BUG: unable to handle page fault for address: ffff888101f30900
  RIP: 0010:0xffff888101f30900
  Call Trace:
   <IRQ>
   call_timer_fn+0x24/0xf0
   __run_timers+0x197/0x200

Since that commit the probe gives up on such a BMC. On current mainline
this needs a BMC that stops answering after the probe, for example
while it resets, and an unbind or unload of ipmi_ssif while a request
to it is being retried.

Checking ->stopping before that mod_timer(), as the other retry_timer
users do, would not close the window: shutdown_ssif() can set ->stopping
and delete the timer between the check and the mod_timer(). Stop the
thread first, then shut the timers down with timer_shutdown_sync(), so
that nothing can arm them again.

Fixes: 00bb7e763ec9 ("ipmi:ssif: Add a timer between request retries")
Cc: stable@vger.kernel.org
Signed-off-by: Deepak Gudiseva <deepakgudiseva@nexthop.ai>
---
Not reproduced on mainline; the trace is from an older kernel, where
the fix was tested on hardware. Mainline is build-tested (W=1) only.

If this does not apply to older stable trees, I can send backports.
---
 drivers/char/ipmi/ipmi_ssif.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 3a11fc4f35..10393aca05 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1285,12 +1285,13 @@ static void shutdown_ssif(void *send_info)
 		schedule_timeout(1);
 
 	ssif_info->stopping = true;
-	timer_delete_sync(&ssif_info->watch_timer);
-	timer_delete_sync(&ssif_info->retry_timer);
 	if (ssif_info->thread) {
 		kthread_stop(ssif_info->thread);
 		ssif_info->thread = NULL;
 	}
+
+	timer_shutdown_sync(&ssif_info->watch_timer);
+	timer_shutdown_sync(&ssif_info->retry_timer);
 }
 
 static void ssif_remove(struct i2c_client *client)

---
base-commit: 63fdb511c27afcebce797e3db580b3534ddfa639
change-id: 20261118-ipmi-add-smi-races-0b8bce266803

Best regards,
--  
Deepak Gudiseva <deepakgudiseva@nexthop.ai>


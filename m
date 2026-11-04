Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793770449;
	b=ZZF5MYrGPLhDKjCxVIPHuqM9fdDFZDW+cMvndhW0MXiMuqNj6Xi7c/a2Zcd6/IB+EMta
	 c3Fg6l3xQ5EGeteGYs/l7Ua/SeHXT+uVLvdHrXPcyfSoUIP3fiU0295vsScQ65qNZ8PdS
	 gJEI3Er7bO6RmniTMRuH1rQXYjrT+7mFYWiPnShFBt0O9XKlymLNh5ModOnGutm0Sleoj
	 0QUXeP+qJPOLEV7Wbj98GyD/ZD2GSmkMnI3BFZR3k77vwERjv/SjLhdkkeptYpVReqKgM
	 D5mEUOS6NsGpVZ63eoqZmcZ/4VevCEeno4dX8gTk4FpgbpobFNMqsBAsZ6oBgBDu1DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793770449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NaPAIDGDHTTSnPgiyoGnXRPKLlfc2mJQHfqQ2f481xg=;
	b=ERRuhhbIduE/8/QoOcWkiP7qKn4t7MeTFb4YnOcca4xttJvH9mKUyMAipqV2bkRoknzo
	 iSQgJE/K7ssAAuM3PzyRBQ+9i4KQi8G0xeNg0f5wPqQjHnXBIqPBFWc8aag9dtONA/aYF
	 anpdC9goQfip/v3PhSH/IcqM2qwu0Y/VwMsPs+AfGnmVylF7uXuZnZet52z/YiMP2wqfg
	 TvnCGJToCNtazGzUTM06f1hWog7hzG2OiIxEnxE1XgjzLyL1sNofqfrmbudWN9IvtyD57
	 nin6ewaC0+tf2CXV56O469h9yov2tgG8hDvkDWUEONpNk99NuP3j/7nOVQ4etPpnRTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cfss1h09;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3D606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 05:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAA3D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cfss1h09
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1af971cd9f9so27460c88.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 21:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793770448; x=1794375248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NaPAIDGDHTTSnPgiyoGnXRPKLlfc2mJQHfqQ2f481xg=;
        b=cfss1h0964nVXzPW6asKCRWluZW36QCD/VgbvvklOprt1lgHuRdHrEFRuqMLE1KVaJ
         zwQJbWZOMLVSjireD60gaeys/K8rzKFR+zYGTCC+q1mlI3M0pdkuipAyJCmYWxbZPgsk
         VtmOYUa+V+8WvgeCXMcEmO1KXh39n3mI967aPOnEGnJmL+0/7chaW7OrR5eF2f33dNy4
         Rwr/7HxvOtuOMGdLAc5rakRd+PjIbkFS3CQ6A2pTFnv/jwcgQUGiz+INamfg+PSJjvd5
         NdAXVlv/nI9c2mvFO5R8WIAp+2RA8Di22xf1Ml4R/X3h8q6dZe0G1BHwNc2LGNgtCfKV
         GvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793770448; x=1794375248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NaPAIDGDHTTSnPgiyoGnXRPKLlfc2mJQHfqQ2f481xg=;
        b=XEocfbRRUBgkzFjYpLiLvdbELICkXPsQXQ7xtrVmOlWduHpAwCobRDS1yoESGjqqxr
         dXFkc6Jp8Bes5FEsndiweNVo00FxU0YNoZCH/KwtzioqhphD/dpGrD8iBF4IqoFIl1vf
         X55Pd/XQdw0eggUVhAt9mfVS+MaQ+rXY7KOI6wc6tIoQUezNjDtseLXPJLnnmn0KWpRG
         L8AxLGdd890KBSSctGY9VfMHdCzULLCkUOrdq8dxasJOq+C0MUMlWQ5rDeawSN4Pzb00
         b0ZTrYqjcWqhwZURBTjXur/6XClo7ZlUcObUTIiKO/OQRPkD4bIz/z7k/UI3qZt8sBCP
         UcBQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8aF8RNm5sGhQjShI58Fvu5GSgU6tM+l8EtbxOCs+y1y51ql8pMSG4JTFOUmzQ3JnxHhPkv8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rXBtyDL6wrWH5YLxdxEtiP0rSR45zBcm1yiFPvLtk220A+Q+k
	OzQQ+D/sEFdhrIluxNR2miY0Ufx7N0DH5NDcsGlwSJB6xw81522QeuDK
X-Gm-Gg: AYBFou1nMw5ca1YcJKh78ZJNEDZpBJvIv1h50e/aHmmHE6rNmqy83oHU+pQjoHo5BrV
	//qO4KcDWSGO3yyQBMR/4WbiN8PRMdokImW/WMnDEtM5A4gxuHXmpVcI164uJo86WPv1O4AE9SJ
	S2vocE6IU7f+4FvB3620DIvPxsHIgn7x1+V3EmYOf2BS8Bf7cGkEHrfE4FIb74LGhGDC15nSywT
	SicTTTK+8a1zEmGzkEQ1qEw+kBKb2ChEKqFzWtxw8Iu0FUT2Gyc0UZN1iYeH2JP9xCQpv5p4Tpp
	TDk3EMVetxxLzsl1CwM5HTTJ9F9SfAUdKXlX8bEmMTw5H2M9RABLvYWARtH0Q6BKVIS2rYp0wFl
	4NC8eyU7dKCL4OCtPF2bWoSpEMGXC9uRYaqT2bj7psD54Z6ncpBQ9QkksAxxjGBCbgutnR7kycL
	JCSfVrr6iONEZn125XxXX4Q82XuN5Aw0pIf+c8fpHivSfCfI8dyw7tly4P/DNPnhbPWozwNYjn2
	IiMswjEk8vOKusMh/ft6Ii1KaMhhzYho5LiQdFJRhdFeJjHxn7SE7Nse7TOw5P21flIBp36JOlU
	avzx3kBOBnu98vPRDWjvIpHVOR0a6oShco6zIGIcHwI=
X-Received: by 2002:a05:701b:428f:10b0:143:5c2a:e45f with SMTP id a92af1059eb24-1ac4f91ef0emr37439969c88.0.1793770447458;
        Tue, 03 Nov 2026 21:34:07 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1bcedsm4263001c88.7.2026.11.03.21.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 21:34:07 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: sudeep.holla@kernel.org
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: fix deadlock between reboot notifier and forceful work
Date: Wed,  4 Nov 2026 13:33:59 +0800
Message-Id: <20261104053359.1613991-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
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

scmi_reboot_notifier() calls cancel_delayed_work_sync() while holding
sc->state_mtx, but the work it waits on - scmi_forceful_work_func() -
takes the same mutex.  If a forceful transition work is in flight when
the reboot notifier fires, the notifier holds the lock and waits for
the callback while the callback waits for the lock: deadlock, and the
reboot wedges.

Moving the cancel outside the lock is not sufficient on its own, as the
callback also calls unregister_reboot_notifier() unconditionally, which
blocks on the reboot chain rwsem (down_write vs. the in-progress
chain's down_read) while the notifier waits for the callback - the
deadlock would just move to a different lock.  Fix both sides:

- Notifier: compute the decision under state_mtx, drop the lock, then
  cancel.  A callback that slips in between sees state ==
  SCMI_SYSPOWER_REBOOTING (not IN_PROGRESS), skips the forceful
  request and finishes, so the cancel cannot miss it.  (The callback's
  own system_state early-return does not cover a work item that
  started before the reboot began: kernel_restart_prepare() runs the
  notifier chain before setting system_state.)

- Callback: only unregister the reboot notifier when actually forcing
  the transition - that is the only case that needs it, because the
  forceful kernel_restart()/kernel_power_off() would otherwise
  re-enter scmi_reboot_notifier and self-deadlock on state_mtx.  When
  the state is not IN_PROGRESS there is nothing to force, and skipping
  the unregister keeps the callback from blocking on the reboot chain
  rwsem while the notifier waits for it.

Found by static analysis.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 .../firmware/arm_scmi/scmi_power_control.c    | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c b/drivers/firmware/arm_scmi/scmi_power_control.c
index 9557363360..b5a0b71505 100644
--- a/drivers/firmware/arm_scmi/scmi_power_control.c
+++ b/drivers/firmware/arm_scmi/scmi_power_control.c
@@ -121,6 +121,7 @@ static int scmi_reboot_notifier(struct notifier_block *nb,
 				unsigned long reason, void *__unused)
 {
 	struct scmi_syspower_conf *sc = reboot_nb_to_sconf(nb);
+	bool cancel_work;
 
 	mutex_lock(&sc->state_mtx);
 	switch (reason) {
@@ -138,11 +139,18 @@ static int scmi_reboot_notifier(struct notifier_block *nb,
 		break;
 	}
 
-	if (sc->state == SCMI_SYSPOWER_REBOOTING) {
+	cancel_work = sc->state == SCMI_SYSPOWER_REBOOTING;
+	mutex_unlock(&sc->state_mtx);
+
+	if (cancel_work) {
 		dev_dbg(sc->dev, "Reboot in progress...cancel delayed work.\n");
+		/*
+		 * cancel_delayed_work_sync() waits for a running
+		 * scmi_forceful_work_func(), which takes state_mtx - it must
+		 * not be called with the lock held.
+		 */
 		cancel_delayed_work_sync(&sc->forceful_work);
 	}
-	mutex_unlock(&sc->state_mtx);
 
 	return NOTIFY_OK;
 }
@@ -190,10 +198,11 @@ static void scmi_forceful_work_func(struct work_struct *work)
 
 	dev_dbg(sc->dev, "Graceful request timed out...forcing !\n");
 	mutex_lock(&sc->state_mtx);
-	/* avoid deadlock by unregistering reboot notifier first */
-	unregister_reboot_notifier(&sc->reboot_nb);
-	if (sc->state == SCMI_SYSPOWER_IN_PROGRESS)
+	if (sc->state == SCMI_SYSPOWER_IN_PROGRESS) {
+		/* avoid deadlock by unregistering reboot notifier first */
+		unregister_reboot_notifier(&sc->reboot_nb);
 		scmi_request_forceful_transition(sc);
+	}
 	mutex_unlock(&sc->state_mtx);
 }
 
-- 
2.25.1


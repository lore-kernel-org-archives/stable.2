Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792435746;
	b=dNVAB43+/BSHEMsN1wO8vG61BUPjZK35svlJjwzuKxp5z/jM040rXLcoNIc0Huf5Xe1v
	 DYmTWA8RiM6moLvDGN+/ApAl4ir8Q1lNBRrIOKfZMurVkq/R/c+UxxxagjNP6uuQgN+iR
	 Cr7xwmMsmyVGla/pwTMHhtr/LZN3DXIZ5WiP7808gA+tqAX5y3OeBw/ORnoio0Yy6tnHv
	 FCw3we5fRWJ9ffb+6ZWZvVF4X6Mo5EaxilbfYPffFd1Y8+hBhcvDgFEcEZ7hctGVbW+yK
	 hXocFDbOr0lMhwLqehjB6e9Nn9mRRxEowgErMPM77zuDj6yKZOlVp4AB94oeyD51Wcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GAXZCV5m9JMQykLn0Ukn1ebbST4LlX+DTEB51yMeYSo=;
	b=g/Wtobvrx0tHRCf/qQRZ48Im4zrlp3MRTkqVLkJNpCSzdAPv7p4/XnltJXx1Y9DJ2Psp
	 Dn60Esu3f6wN4LPELEjKkDE5EzmV72fsEysKe0Ceu2bZzYJNiaKXvEUzoU/tDLrVLm4SN
	 4/8IAOvZciiKUg5ahvUl4YjxUOUt+udj7KMSV6XXXlIAMSvtz9B79PsIIRPQEGGjCuATL
	 SvDauyv47+yzf7Fb82WgiJSx9DciAntzlYzjUptpY1SDIoVlvG479cxGSLSNMMJ5Yux46
	 oZRisfPMstaeYFQIzTWFiCV3K6f/J0AdtvH1sISGy22luGuCLW3y+RLFrigZfANp8PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RJJP8MSy;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5C606A31A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EF5C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RJJP8MSy
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7ba2ee12f65so61993137.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792435745; x=1793040545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GAXZCV5m9JMQykLn0Ukn1ebbST4LlX+DTEB51yMeYSo=;
        b=RJJP8MSyqk6+vTmNLG6J3fudmf63oXBxtb4bAw28vBZ/T6JPfC0jcs6qLshzy7gXzI
         2B4yDwx7cSLLIjBVELGhYNcnsQ4Bs9FYBd2eGuwhZYD12RTpG48BuEB81wFPCvPqCryY
         YoL/kf+FMxFHCDrd5T4PFE12geD+FKi4gUmkKbNWN3Ack543k/k0AVyYvmSVqP0ks0wq
         A3XtxUZtGaxE0o4GHDJ4oPDv03kUrYH9JZWjblYVrSEGOIRKOTOq5iBU1OK2pJyqSEaT
         seUn9rQ3Beo73B78IiOhVBFjCQQqenodUU+T2Gll9LFTnsC2JEcKlKxNJxquu88x95mZ
         rtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792435745; x=1793040545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GAXZCV5m9JMQykLn0Ukn1ebbST4LlX+DTEB51yMeYSo=;
        b=2gaCAjHK2mAo0Wm/J4Ug2LIqPuw52HXTaYrDQ250e5Ph1/upxY9EJ/ZxcpiBb1jXGR
         GnXehKcLkgLzXsBmMfomdzBargFjVah3rQ7bg9wSIRm+Qgyko3RLCCmAmRzoxAVc4LNK
         liN8lExssMv3KDYwuuuAD/T9D/60l//TdpyS6Ur0CJbosA0lpPeTTP9wws5IW75NQvDw
         DB2d3hK4MeZbBId0J78Yv0i0smFb+kFnemQlQg5UCr3NYPl5v1QkUBS8+2lEheIgcVHT
         nqju0/Y1jSGhAfUv1Ag8QvZ2mnKjX/vIH52yVHEIP24v9/BrzhtSRqFfHE6YlH1L65ek
         cNEg==
X-Forwarded-Encrypted: i=1; AKwUvBwbGmcftTV5OeQrqcDhdWL6VAXIav42cHfw7k40zdKfx7YosWlYxrFRkDmX01CAwIz6BLnYJZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuEbg/J+ouArXRtHbMt6xmOX1vCjL/KmUxezQrFllrc3Rguza5
	DxZIlFUSe1XJotRDZU05iMPp5L8caR9P1FB46WuF5gJq3qdegrOQ1Snx
X-Gm-Gg: AYBFou3RGuqbexBWy3QS+5kSVFVnXhQJ+kNmoYIkMO9Qnsm1SzQqIBWRKI4gvTT4gur
	NNtHTSF4I1b3w+Ho94CFWChyfFpBMol6SX9WBMzL/ficBegYH23gW5di61dBKrFFO3+NV0AHWRe
	HzDyakTxJcVG00qUszHLx6kC2Pq1K4OILlXZy1+aNNGfsI4ggQxq2kKvrYCgia53Yp53vxlvSwZ
	MLVCkh6Gr7irzUu2wdF3cMo/oxKApFtppPL3DeE6UZyAfG5yX+UpTl1hkQKktWqpREJGfRbJWNQ
	jfAih3l2v225x474bjgBnoPIxHgptO2JRveK9cYuzgsOo7hqaMbW0nCbBN7tL9AxKhBFrHAi/Gq
	q4i9U3NihKd83DRJ7iB0nWykCNsMmZ64i0XHC5eb94l4X6XGaUWrbOyFp9JyvXKtsV9yFtEE3Tt
	GIvpw26kQnxYlspys6RpdB0Dp6xrwwc9BwosNB+Y7cuH2fkRpYX2NHVSGlXjptBz6Oh8T3ui+qe
	GUrOLzbqp3BGpt4y7bva+yRmANoVXOCqCpgOMGa6FoJxhaQuFNEi3w3wPYeps0bm+m/llfljr25
	6n3CnEpIWcq9TAMO/xA=
X-Received: by 2002:a05:6122:8107:b0:5ea:b7b5:454 with SMTP id 71dfb90a1353d-5eab7b5070bmr1354058e0c.1.1792435745253;
        Mon, 19 Oct 2026 11:49:05 -0700 (PDT)
Received: from localhost.localdomain ([132.170.205.109])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b53cfdfsm10488632e0c.15.2026.10.19.11.49.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 11:49:02 -0700 (PDT)
From: Sanan Hasanov <sanan.hasanou@gmail.com>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+b2b8d04ec4914f618d23@syzkaller.appspotmail.com,
	Sanan Hasanov <sanan.hasanov@ucf.edu>,
	stable@vger.kernel.org
Subject: [PATCH] dlm: don't put an uninitialized lockspace kobject on error
Date: Mon, 19 Oct 2026 14:48:49 -0400
Message-ID: <20261019184849.24422-1-sanan.hasanou@gmail.com>
X-Mailer: git-send-email 2.48.1
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

From: Sanan Hasanov <sanan.hasanov@ucf.edu>

Commit 8a4cf500f1dd ("dlm: drop kobject release callback handling")
dropped the do_unreg flag from new_lockspace() and made the out_lsfree
error label call kobject_put(&ls->ls_kobj) unconditionally. But ls_kobj
is only initialized by kobject_init_and_add() after the callback
workqueue and dlm_recoverd have been started, so every failure before
that point puts a kobject that was never initialized:

  dlm: ls_6035_1: can't start dlm_callback -12
  kobject: '(null)' (ffff888027a28088): is not initialized, yet kobject_put() is being called.
  WARNING: lib/kobject.c:736 at kobject_put+0x66/0x550 lib/kobject.c:734
  Call Trace:
   new_lockspace fs/dlm/lockspace.c:617 [inline]
   __dlm_new_lockspace+0x1714/0x1cd0 fs/dlm/lockspace.c:638
   device_create_lockspace+0xc7/0x350 fs/dlm/user.c:414
   device_write+0x872/0xed0 fs/dlm/user.c:606
   vfs_write+0x296/0xba0 fs/read_write.c:685

syzbot hits this by sending SIGKILL to a task creating a lockspace
through /dev/dlm-control, so that alloc_ordered_workqueue() in
dlm_callback_start() fails to create its rescuer thread. The same
happens if rhashtable_init(), the ls_recover_buf allocation or
dlm_recoverd_start() fail.

Bring the flag back so the kobject is only put once
kobject_init_and_add() has been called. Since the kobject no longer
frees the lockspace, kfree(ls) still runs on every error path.

Fixes: 8a4cf500f1dd ("dlm: drop kobject release callback handling")
Reported-by: syzbot+b2b8d04ec4914f618d23@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b2b8d04ec4914f618d23
Cc: stable@vger.kernel.org
Signed-off-by: Sanan Hasanov <sanan.hasanov@ucf.edu>
---
 fs/dlm/lockspace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index a9c98b4f37..443421e945 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -364,6 +364,7 @@ static int new_lockspace(const char *name, const char *cluster,
 			 int *ops_result, dlm_lockspace_t **lockspace)
 {
 	struct dlm_ls *ls;
+	int do_unreg = 0;
 	int namelen = strlen(name);
 	int error;
 
@@ -567,6 +568,9 @@ static int new_lockspace(const char *name, const char *cluster,
 	wait_event(ls->ls_recover_lock_wait,
 		   test_bit(LSFL_RECOVER_LOCK, &ls->ls_flags));
 
+	/* ls_kobj must only be put once kobject_init_and_add() ran */
+	do_unreg = 1;
+
 	ls->ls_kobj.kset = dlm_kset;
 	error = kobject_init_and_add(&ls->ls_kobj, &dlm_ktype, NULL,
 				     "%s", ls->ls_name);
@@ -614,7 +618,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	xa_destroy(&ls->ls_lkbxa);
 	rhashtable_destroy(&ls->ls_rsbtbl);
  out_lsfree:
-	kobject_put(&ls->ls_kobj);
+	if (do_unreg)
+		kobject_put(&ls->ls_kobj);
 	kfree(ls);
  out:
 	module_put(THIS_MODULE);
-- 
2.34.1


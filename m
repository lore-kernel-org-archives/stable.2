Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA947080D
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787417038; cv=none; b=dPpRh8S95I396jZAKF4VgudqNQFZAQo0G//uO77RElRFvfEqqwDFl3ztzvB7TaAR/IHpytNekw6Hm2weDLKZh8Asz874zwmjdl2Eyu2sLfB+qtQXPFsmh//jb14Y6UjdbYfNbwwMXnL1C8TZ3wTROZIDfxf7s3ny82T/hKYAWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787417038; c=relaxed/simple;
	bh=mwQAzqbsY34MJJJ//jyRmVtC88MoO19pi+kZvnQm+bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YwHCRdoJUS7fF+yuKWOwogm1GK+CzMfgXFsPuLPWoB8FZxrzrRGhgcd3+ojn/WDHC1vgqHbgAvUMrvrw1lTUBivAJLBLdF+MeggoTOvoHwQblCV7WjvsHQA95smkR550PETfcVqskbjL8IR8nqpPTos3JHpnOrTJ3Mr7d5krSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKSGbup5; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKSGbup5"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-384c94c9423so226350a91.2
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787417034; x=1788021834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QqQxHcVBopXEQ06zq5Skt24LbTPkQa3qzjdve2v5WwY=;
        b=BKSGbup5VgXRKacbKtm4fajZg+qXV8xw79abf67R6tZehbRksAP1JTLJuejQhjJqmY
         5muyjXzgpAEfo86gRamCsNtC7ldeNmL1NDIzY6vYIths5rt9w9fLRZLFVkZMmF1iDWKs
         a8dKU/+3ubFFgrzSh3ugTSAXS7Z060Q89ibH4dT7GgAyTsrbXnNZt2CuRW9Kx8J8EnGa
         u5iP6XKtBsO3Pd3lhKOVlMM0qyJSX6KSJo+9MAtX6FUktMOa2gc3ns5MJcsgaMPzaA9d
         5vZcVoqhKXrTW7hauH7hB7EEXRT3wJh0rnmdyBD4Hp+e4aplrY/P0vNh1FHkkZPtUc02
         yjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787417034; x=1788021834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QqQxHcVBopXEQ06zq5Skt24LbTPkQa3qzjdve2v5WwY=;
        b=qj2iVBcic8RbnbGaMU3K4rw1xrq3Vmnku0WzjZ7BhdWCUgc5JYgboix7G7ge1t6sl+
         QpZpaNEAWwm32MTc+2+B/kFSkMeJZiU6hIITWCodmUlrhGE9n+sgRkutvSZV5SZKG2Z3
         I6ZHLSwAPN/5yTYoeu78IQWAO+Q7iQYT5IZF2iGCdaaICoxu1mkVN97j5t280SN+o4Xe
         /Jj6rNjE1asenvADR6E1GJ5VsQ42uG85EwFwo7BSpYICsDIsv3QQF9fCuq0PQRc/I8la
         mPYqliqcdY/f67mrxpE31XcfCYQzGnv2oigOmTHrI3lCGK25YVyrEIW72Aq2xZPavhvz
         K3Dw==
X-Forwarded-Encrypted: i=1; AHgh+RpTHo9SRXWZsQLh0F6uVrAVqmIzZLVNaCMQvYuabu81dwjFyk+fCm/zbOEhp7NtK+FuFwYHtfY=@vger.kernel.org
X-Gm-Message-State: AFuF++nzGBKtyoDklUduqDB73TmHC3LUuzo4C+b6zs9WymlD2sNKeEzB
	NXsGHl/X8/T/iZe9dVDBZisavjnbkMy7sCouIvmcQqyzws5zII1ZuFBr
X-Gm-Gg: AR+sD11/ng85wYsit7Wz4jI6JSAd/5tTf9PQP5fIu8c0LQPZqbiqv+5LECycuBuoJaQ
	X95bDekluIllWRty8ZkVaG8wT/lUJO8sBvNuycIZv/0H6Ta4hi7TCqx3OU5cEiN5wQS4C17RIyW
	1OtiGfIBSP4akwe6OtbeVHvR+KsHwWj1NpgYb4QBzfkMfJ2nBx531V1r+v9SLJLDma1uUejzZkf
	FviVfGfdQg2F1mQXYm+IWfE4L7q5xc6h6dH/j18aBwFZXP8nwXoEQezx2un12Q25NUdOOxpdKzU
	cbnvW6GXswfSW+LhCtjrA5fr2rthMjgW2NDu+8EZQZOWI+zfdI2BXYUOYf2Ai5cvmUVkIJH+yMT
	RNhEM09EQdGQ9jqqfcAgxHE7xaIkSCBSVOw3mbOfX/vxVYuueHnlS6t9aIwWfcnZniZndLTZGaR
	xvGGi4C6D0l0Aimpx5WfsRBKpUVn76vw7i1iv6C8/A/+dGxrkhlheFw0V8W9quhQUsnR942oiRK
	itkADN5I51PSRM7HVizG1fhdh5QGwASBSwL2RpxwRXVGZd8SuOvc44=
X-Received: by 2002:a17:903:1b65:b0:2d5:3f09:4126 with SMTP id d9443c01a7336-2d64b13195dmr134623425ad.4.1787417033874;
        Sat, 22 Aug 2026 09:43:53 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0dd3sm8622622eec.7.2026.08.22.09.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 09:43:53 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	Ali Ahmet Memis <ali@iusegentoo.com>,
	Tim Bird <tim.bird@sony.com>,
	SeungJu Cheon <suunj1331@gmail.com>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: serialize security confirmation handling
Date: Sun, 23 Aug 2026 00:43:41 +0800
Message-ID: <20260822164341.3750491-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_security_cfm() looks up a session on session_list and then walks
its DLC list without holding rfcomm_mutex. Since RFCOMM session teardown
uses rfcomm_mutex, krfcommd can close and free the same session and DLCs
concurrently:

  hci_rx_work                    krfcommd
  -----------                    ---------
  rfcomm_session_get()
                                 rfcomm_lock()
                                 rfcomm_session_close()
                                   rfcomm_dlc_unlink()
                                   rfcomm_session_del()
                                     kfree(s)
                                 rfcomm_unlock()
  walk s->dlcs

The callback can then read a freed session list head and touch freed DLCs
while updating their flags or timers.

Serialize the session lookup and DLC traversal in rfcomm_security_cfm()
with rfcomm_mutex. This matches the existing RFCOMM session lifetime
rules and prevents concurrent rfcomm_session_del() / rfcomm_dlc_unlink()
from tearing the objects down while the callback is using them.

KASAN reported:

  BUG: KASAN: slab-use-after-free in rfcomm_security_cfm+0x41c/0x440
  Read of size 8 at addr ffff888111fb3960 by task kworker/u17:1/89
  Workqueue: hci0 hci_rx_work
  Call Trace:
   rfcomm_security_cfm+0x41c/0x440
   hci_encrypt_cfm+0x139/0x590
   hci_encrypt_change_evt+0x37b/0xc40
   hci_event_packet+0x71b/0xb20
   hci_rx_work+0x293/0x730
  Allocated by task 69:
   rfcomm_session_add+0x9e/0x2f0
   rfcomm_run+0x44b/0x41e0
  Freed by task 69:
   kfree+0x131/0x3c0
   rfcomm_session_del+0x188/0x220
   rfcomm_run+0x1985/0x41e0

Fixes: 08c30aca9e698faddebd34f81e1196295f9dc063 ("Bluetooth: Remove RFCOMM session refcnt")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/rfcomm/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 9cdfea666a2c..5d150e8623d5 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2213,9 +2213,13 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 
 	BT_DBG("conn %p status 0x%02x encrypt 0x%02x", conn, status, encrypt);
 
+	rfcomm_lock();
+
 	s = rfcomm_session_get(&conn->hdev->bdaddr, &conn->dst);
-	if (!s)
+	if (!s) {
+		rfcomm_unlock();
 		return;
+	}
 
 	list_for_each_entry_safe(d, n, &s->dlcs, list) {
 		if (test_and_clear_bit(RFCOMM_SEC_PENDING, &d->flags)) {
@@ -2247,6 +2251,8 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
 	}
 
+	rfcomm_unlock();
+
 	rfcomm_schedule();
 }
 
-- 
2.43.0


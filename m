Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406077;
	b=Stqud2TL1tx6ccNOE1iT+ZO+q/exr6ZT7dzUruZTtvSIV8rnPZyTMNMMcFOJ+yNaplxE
	 daaJGAvMBcNE3pp/AIKe0qf7L51jxA94iLT9hpwG6+26gVZ21PdsornbWmlM4w56T3loD
	 jSR0+l6bEshSgLz2N/KBtqyLPMOXBUgrpeEDZbjFTgEz62RirRIdPKTToBro3Q1gmDTMY
	 7/syvIn1JVOBOBhhG493j/LRp5Ct7Mol31+Ivw1EPZjRq175OxsfN1UYRoouZMEQtiMNr
	 rpp+/g/9dndgjOGLlomfSVsxZTRM8kdl1v8+VEZJ0Ob5h90Dft4zf5+wZZTUBs1MfOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x3RzAiD1nujkrt0dHPNnUah2YzBZvBSykZZIS7z7tfI=;
	b=VBh5SWVLrN7VBwfW1OWBb0HtSGf+mwqmLR3RF3w5fxE8Uiu1PmOIDyjuzQ98FdJKrI0C
	 YhDUox1PgrkEvPq7dAhwRihOfobMoGmeYBDnE6gNFIWaU4cxRC6zomKkgPnVuUOMjYsD1
	 XoB4pedMdHCjoZcaYpIydSB/T0fmFFGPC79l3QrDCCDpNkcQd5LeLwXBoPX1UTKDKXZRU
	 D9GMPXgItZwdZj8ue29y0y7U6O9JrjFd635/OizFnxCJimEjcotTxVx2Rmfb82nFr/1h6
	 6mXeEbDeNhARCWa1eT82dgwaxdnIws8QtZ0EwtrRb9Io6wG8vlG+37D0mAHKMIZMLXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0jHmWFmL;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685DA606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 685DA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0jHmWFmL
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so33850645e9.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794406076; x=1795010876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x3RzAiD1nujkrt0dHPNnUah2YzBZvBSykZZIS7z7tfI=;
        b=0jHmWFmL+mjVKXkBf91l1p/raM2AnZkpHV8i4q2vXdFbY3+PaUXqy8/KmAp7KqFHSE
         IyxcEK9/vehSsQkmsmLj3msSWubMucdIiPisoyi+BuV5RzgaTEJdc2txumPDCZ7t67pH
         4cEffI4fm73Y1hakW74woj9tCWbLL9HQNxhLPoVuIzrGwAMdw8Q/7jJxi0nedAcrTM5C
         U91bC+N2px+kXzuMlqA0YV2xA7wmAkD+5+bhqLfAN4unqpIruYPcffdl/r0XcOsXViQ+
         PhJbC7SbjWuxWRCAJ8O39Jy9zjZKZvcI6VV1pfxVFTf5OKbDH9KU0RkowO1BJJKSqS+9
         cn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794406076; x=1795010876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x3RzAiD1nujkrt0dHPNnUah2YzBZvBSykZZIS7z7tfI=;
        b=R9bNvQJUZQ5t6cgwhr1eMv8wjl3exbFb0rr19v0ZfBUNrRXP8zTc2INDFdN705IPpO
         ROGTYGvl27TybuR4+/NFUiyyPgxUgPvF/M/MlU2M7RdaRNtAE9y7DTc72yyjTy3527Es
         kObjvnWHn+hWkZFtqlapnhCTZT52etrvSXB1qXYKQMioeNyb4zaLBJ3Big9Y+DSz6Ajp
         imdf0Uxpb3a18WWvIgonSR+PallUe4ed3dq5Av3R9RG8HyEEhuee2sFfzPKTPnfcTKLF
         qOfDj32MJUONn0A9FlcvsjeNYBtOz+8XJYvKkWKkvHrTjjymf8m3RFJHPqbLl5tf2Pqj
         x9Rw==
X-Forwarded-Encrypted: i=1; AL+hErHHmikIW4O03tHva/Xkh3acyVgblw1aLwRH60jvWx6Emn/6B3UHOMUJLq4xfu0K/SAdnrAY6w4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vIwVwODy1aY4g8rdKYVvAjvDHNDWQIZuZPYBxaSrDpYX+b+tm
	866gQJjwLJt/qmcg/h9dS2Gq0Gs3HSof1nS0upgRKOnBs2vl08lPWbk=
X-Gm-Gg: AYBFou3a97y2Y1vuArneCVpgUmNjcobCHKVn0w7U4gDePToNYI07/U0LaVdl0R0F5zI
	SGCpY2IoniltxqleXRlz7m0Ffo+PJj1RezxoVQ89S6BRwT1QohtG1Fp3gylcdzbL9+X6b9teB05
	t2959lcwHcbfJoBC6XZk+4wfXXQuLolPueKqCu1H8hVtqftqxiLb/vpYIbG6TAaXGBFwUorWj1f
	dU6IAdVkWOoGQV8i6PaHYLCN9dVPV/EDDMQQ0lM56FTzwarQDIq2xoWUKcxu/Z4/k1K61kdVB65
	UodTLVCLNQ5lO0gDp2FoTOGKoyh7JTQHSfNC+6pvIUeSXAzksLiZ1V9A6hEfhwCiY1m35jJHlPM
	idhYh+Rh68KFSKNEmZVdY0JcJFKW18/1GRSVernhq6N6B5fdAyULIODeTWZ+DUhlnkWdjDI9FHX
	KNMTPJ05quGghUnpbnOVJ4pHxOkm8UTA6LJGEdebruihOhoz7rTZCwM6m2WCevrpMrpqd87ZMfV
	qiGM1qvoy2hn46jN3/XW9mgOsom5rbKQXDY0cVeVJU3X4sGgxjMvPXAeVkY6gg6Fgmf0JN6zxTj
	ZtL3gQPCx8xGafk=
X-Received: by 2002:a05:6000:2201:b0:48e:5cd4:aa60 with SMTP id ffacd0b85a97d-499c9dad952mr4864181f8f.42.1794406075481;
        Wed, 11 Nov 2026 06:07:55 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983284c990sm10604532f8f.3.2026.11.11.06.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:07:55 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: Zheng Wang <zyytlz.wz@163.com>,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] nfc: st-nci: use timer_shutdown_sync in ndlc_remove
Date: Wed, 11 Nov 2026 14:07:46 +0000
Message-ID: <20261111140746.375923-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

ndlc_remove() uses timer_delete_sync() to stop t1_timer and t2_timer
before cancel_work_sync(). However, the timer callbacks
ndlc_t1_timeout() and ndlc_t2_timeout() schedule sm_work, and
llt_ndlc_sm_work() re-arms the timers via mod_timer(). This creates a
circular rearm: after timer_delete_sync() returns, sm_work can still
re-arm the timer, which fires again after cancel_work_sync() completes.

Use timer_shutdown_sync() instead, which prevents the timers from being
re-armed by mod_timer() calls in the work function, breaking the
circular dependency.

Fixes: 5000fe6c27827 ("nfc: st-nci: Fix use after free bug in ndlc_remove due to race condition")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/nfc/st-nci/ndlc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/st-nci/ndlc.c b/drivers/nfc/st-nci/ndlc.c
index be4808859cfa9..14e1213d76c9b 100644
--- a/drivers/nfc/st-nci/ndlc.c
+++ b/drivers/nfc/st-nci/ndlc.c
@@ -283,8 +283,8 @@ EXPORT_SYMBOL(ndlc_probe);
 void ndlc_remove(struct llt_ndlc *ndlc)
 {
 	/* cancel timers */
-	timer_delete_sync(&ndlc->t1_timer);
-	timer_delete_sync(&ndlc->t2_timer);
+	timer_shutdown_sync(&ndlc->t1_timer);
+	timer_shutdown_sync(&ndlc->t2_timer);
 	ndlc->t2_active = false;
 	ndlc->t1_active = false;
 	/* cancel work */
-- 
2.47.3


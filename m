Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620158;
	b=QwCztCtQL80906DnospePe+qdVau4PDASM1tp+mK7D3XFxQnlzbVNQ0SuHMVFQ64UCpz
	 ZC8em0qTqINU5JRwSmcgGC0U+DS4iuBdtSV+FcmI6CKsYOOUa9vBV2EYZ2gNetfBhdI/9
	 89ejs1NyVjeMmk6UhD13FcizGqer4b1YLHPLll5qcMAvrHfDy9fOyb9NcXwbRTDrzf01M
	 yLLkPNz2W4nD5UeYrqQYMhEw5mDxSLuBSYy9fEmoDfg+xuDInuLEGNSYazZ+Ib/bihbQe
	 fgCcAwsB4Vcr0/AQdqDHRUfsj1r1CiIkpcC0TWS4IW2umSHj4UaKV//1RQUmTrI9erw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bEF8M/s3yAdvW6UfQALPsy2Yfd220r/9bf/yWk6z0O8=;
	b=cY3stxzm4SctxnacUykOIL7CUhHg6gHtqGB1XAS09XQC90GAO7YETpRrZ3ZfKblYwwNF
	 ANyvdoF9d5VgpG//v7fjT071ImaCO27sGWyS1PRN5w3H9DtlVPg2XiDoWTTkC/CyjMbN5
	 65BSQtfkQEVx6pcceA98OgEjFO/sADC4l+GJEonBAYhwPSEm8LQyo04j/FLo5tsrTJ5NQ
	 i+WhYD7DB2JFmOLiCW5TFaW9sC7uUq4RM86FyESTkkUjgsHEOoqUdY4SCETAvkOh8wZa0
	 99xEvL5IUwpnJTePfI/y9k5htHLLxMFp1Cf4aCu/Vq7qxNIPdZPcOosSmyUHYMkxKUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShO+44dG;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C791606A692
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C791606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShO+44dG
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso2366466b3a.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620158; x=1796224958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bEF8M/s3yAdvW6UfQALPsy2Yfd220r/9bf/yWk6z0O8=;
        b=ShO+44dG0IqJ9GlcQQUQyr5sqsbBZOqrweihS+Lubx454FRXo6ifAMN052TN+6RZkQ
         C/iT2Bkw3SkKdCJSOog+BFVNnWi1PWrKxx88XWByDjB1iZWloDF2DIBuLRWZyqaomLsQ
         gXyc15GKvu1cZuxd89Mqz8oi5C8JW39qsjH6LmuvQsQ4kXMF6Y9y6snP7UgbrY8ZIrQM
         Lx48RmPVjH1c6FORxuOe7zV+55jEL4a6WHAUP/QcY5aKjIEZClaHfp3pIaJz9W5ijhJj
         sGtancB+OMFFChas8fYlEz5E/UEqa1uqpQ+4aoCRHqgXLXRpvpfyPybA7lNbm0CrbsXe
         Fw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620158; x=1796224958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bEF8M/s3yAdvW6UfQALPsy2Yfd220r/9bf/yWk6z0O8=;
        b=VJd8rCt/DoYGdXF/9gLq5P7+wwiIFd1JAgZds9tvTwjHe0Kk8D86acIztnYAwUKwiI
         uL5MKMnr+M3I+dc4Cs6bbpfVYUHgN+XMDKe3fJjzoUKL6aUFA4k9/8Gv3mTA/KscIyZQ
         3jCULPxfXY+O+C3TUq3rlltkql5k/zWbJjuOLrSn555PX4cgIMz74c/KfVIXRDQc+QVP
         hJs2SOM9ZG497u8LOkdPy7xoupFtfg4vGDczmvnrEr9Apihm+dBBG3VjSsPWHN76gXQx
         8tmMwZvFoy4N3gi8cQZJwUlm0r48zblgOlnUtURiwoQySw8S0Q4M34Fk9XCBv/hg3IJp
         H16A==
X-Forwarded-Encrypted: i=1; AL+hErHLwFzDhOETupTjvVo+AokNmyp9yUnj6Ld5x/QVc2uSpYMso2Qnt7UV/SlZuXulgLbnMIb0ilU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eNtomckR95ih27vUgtbMzWp1CIcNdD6Y1wFShYt/Zl7szCUay
	RBSymyRVt4E/mTKwtqo2IXiMa91GeVBH/59+MLcLzgwVL03Peh/cKdOu
X-Gm-Gg: AZFdTZf4Z3cWE3Qr2yrtet8TC6b2c6l/MHILmyTKsHECG+lT5UCjPsjGyoxT7OdTTF/
	7e7g3X7m7ZraXah8T5XjwKRy2Oe1mgbTpEZKqac+V1qW1gGvvj+51eyrCFlbqBizTtk3RH3bo4/
	NSKH+lzG+4w9sICNCFRDhgDC1s8w0/N2xKbb3JvglyqmiRj4qbWnDDrqFHPR4PdAhIYJkNVpG22
	hE3le9iqAc8eo/f2noKSJ112cCDCTIxyI3nqpnlthyDYCum8C/+TjoDArdbpUvLHQo0Q3RpiLcY
	lTlre3mikG8IDPrEcgYsrcs8MsYsJBU2QBUhPemhpJXr/q4BuDLnGqp3opgkG5tNDYPIfh7VmyI
	vWjOl6ahW6wU3AVFTCpORef8bzDt4ZjEM9vh8nrCgXgeXp4s1Pao3xP/1ZS7Evz8fnedt8BjkXJ
	CgN7ejwVbl/cG4peO7+yCqJ/y6xQTexPHfJx1cnlyYJvWjccZAL/bAzfcW9ANl2OcnJH6HierBW
	T/exFE04P7FGnMInBapzs92JOYFZXF8NDM7krUwXHPFqJQ9tDSvx6pX+YzXlT4KO7CdsGSWfDcm
	WcfphswvoCpjBJJQo+mElyEu
X-Received: by 2002:a05:6a00:4b0c:b0:89d:5a80:5256 with SMTP id d2e1a72fcca58-8c87bdb6bc8mr17944929b3a.9.1795620157634;
        Wed, 25 Nov 2026 07:22:37 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077a058sm9221775b3a.8.2026.11.25.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:22:37 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 2/2] Bluetooth: RFCOMM: Close DLC on TTY registration failure
Date: Wed, 25 Nov 2026 23:22:18 +0800
Message-Id: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-0@gmail.com>
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

The TTY takes ownership of the DLC before tty_port_register_device().
If registration fails, dropping the port references detaches the device
but leaves the DLC open. In the reuse case the original socket is
already BT_CLOSED, so it will not close the DLC on release.

Start DLC teardown while the registration reference still pins the
port and its DLC. Purge any unconsumed receive data when the port is
finally destroyed, after detaching the device as the DLC owner.

Commit 77bc0f253ff9f ("Bluetooth: RFCOMM: serialize RFCOMM_CONNINFO
 dlc->session dereference") moved session reads under rfcomm_mutex.
The handoff therefore no longer needs to wait on the socket lock for
RFCOMM_CONNINFO. Use WRITE_ONCE() to publish BT_CLOSED. The DLC lock
continues to serialize that update with the old socket state callback.

Fixes: 56bc551ef79c ("Bluetooth: RFCOMM: Close the socket before transferring its DLC")
Link: https://lkml.iu.edu/hypermail/linux/kernel/2611.2/24606.html
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/rfcomm/tty.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 745cf1e4bb2c3..43a03837e371b 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -96,6 +96,7 @@ static void rfcomm_dev_destruct(struct tty_port *port)
 	list_del(&dev->list);
 	mutex_unlock(&rfcomm_dev_lock);
 
+	skb_queue_purge(&dev->pending);
 	kfree(dev);
 
 	/* It's safe to call module_put() here because socket still
@@ -293,12 +294,8 @@ static struct rfcomm_dev *__rfcomm_dev_add(struct rfcomm_dev_req *req,
 			atomic_sub(skb->len, &sk->sk_rmem_alloc);
 		}
 
-		/* Finish RFCOMM_CONNINFO before replacing the callback
-		 * which serializes session teardown with the socket.
-		 */
-		lock_sock(sk);
-		sk->sk_state = BT_CLOSED;
-		release_sock(sk);
+		/* Serialize with the DLC state callback. */
+		WRITE_ONCE(sk->sk_state, BT_CLOSED);
 	}
 
 	dlc->data_ready   = rfcomm_dev_data_ready;
@@ -347,6 +344,8 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 			dev->id, NULL);
 	if (IS_ERR(tty)) {
 		err = PTR_ERR(tty);
+		/* Close the DLC while the port still pins it. */
+		rfcomm_dlc_close(dlc, 0);
 		if (!test_and_set_bit(RFCOMM_TTY_OWNED, &dev->status))
 			tty_port_put(&dev->port); /* Drop the initial reference. */
 		tty_port_put(&dev->port); /* Drop the registration reference. */

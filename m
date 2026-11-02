Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634309;
	b=3QYWPZQdV8F2aALE8Lb8rkWzRCCJE4xMno0vS9RfFZifRGiU8moabZyAMMUxHsig/5AD
	 c09lTkRL+z0JK0E7TaDCxllX8OG1PnkZ+V2tYHn76WtKeAvLHM5mUHLe/mC1fcKPrGHrX
	 /tGCsO02j53gNYj45Qy2WH9RjKX7ShaxCP3UVXB/Ga3Sdp6W09cG9ViTZ4oXO4CD6hDu/
	 c8rI7s3ShB6rAa19Nor241iKmGKDKL8O9zUVd2lcAI+N+OsZKyVB9imIWEHumk6Gkcpw6
	 7mPQ2QjYy6YTacQAqT4uYMVZ6YVgU/qTcPo69ns+q+QhaTV72lTexB72nNSXjLvt2Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G+Ul4wYB7F7GOHeOHYfi0XFFmYlVfK1p/QtFcQWKlB8=;
	b=j7EkjMks7ovLXv50fprYIv0iIrdeIzmY61F/ABdi+t1LI9ZYjrQ8aFCuvjQVN65bf6+3
	 gwaLJE2swyxxonoLTpXfXbYlydp+rALanDvlJKdZZJoMnfQ89ejG+a2qxeS+kB4HD9ejX
	 ssbhAl5U6i+Lq36BwiOjO131z1d7YW7+axjE2Jfcmc6q1gohFH66DoQoE/BlLcnDcKRCN
	 Uk2JUGwZtN2REX3x7HJ5N3bb+zVsgcbvwkNdzaVXjnhzH3VeQneIWRRpnl79ycob7P41D
	 6Lo2kdvvt9WuSpF6RRF87pAwYaUMno3cazIQsCSn7zgsCeXbI6aKXuLm2HtWeh0za2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jOO+oafD;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D9606DE8E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D8D9606DE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jOO+oafD
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso36600035e9.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 07:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793634307; x=1794239107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+Ul4wYB7F7GOHeOHYfi0XFFmYlVfK1p/QtFcQWKlB8=;
        b=jOO+oafDQ2vni9CZUtj423urEKRJ69jfP7P1rtCT/lLRYDjvDPw7FUFoXbbgyPo8Cn
         yt1Oy8naqRqTtH3YENpB/KwgK30dNfiycT12ytLnYPpQA/NKOZ7+zH9XwYEkbtFZA8pu
         PzdFUh2YdT3h094VfP2ntYWTCzRKfIiB//63Arvj88EkMwFfT+eONgMw6ezvUPafMq4W
         /x+wSF+8Wt4Vrq7+dGVFU6mzMu7ZRjPOjH/4lXWmJVjTVU04IEkrGL33E6/Vh2NMWgzu
         cm7A711XcMoQEQf7wAxa+nuf3xplO/L2OK0TCcjTAm0u0in5AiXnE8ypOWmvIUKr888X
         GPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634307; x=1794239107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+Ul4wYB7F7GOHeOHYfi0XFFmYlVfK1p/QtFcQWKlB8=;
        b=TiDEagak7sIYRTkvar14143CdT/lZe2q4QME+IzFTcHW1RRKATdxy6a1BCkcu/45jE
         pHKBz5Deqvg2/c/0RCN9Djh7tjctf4+cC4lR5BKn1z7sYwvv5pRv4j4F7VpGuaGCJ8Sh
         BRg4gsKlzxEhPtwhbzJq8M+e03K2z6BF26PJL8XtHgMSuyy/xE8IyGGyRkaWywSHkwoD
         6kj2O7VHJt3SjEw2XWJcn3Qpz8mVscIyaXDX6GqAk+a9KJ/EN0cbHSHIDXzM192hiTHr
         3Dzmlz88agJIPAQ5Uo5dunsJ4w4EDaJdlOXahUdHi20yz8xT89AMFLP3Y6Enh+UjWtN+
         81lA==
X-Forwarded-Encrypted: i=1; AKwUvBzrYYROkrTEFhGQb9RFiUKzEUR9/JtsZ97KtZpaIXpHcHNgIoKcpLKIut2IahpQbArhmvzlBuU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxTgZGm4Sijervs9VGXwi+E+ooGHfbXu9MdgkLtdGCgT0RkBCu
	x7hTX/5zvgv6oY+aHAZaHdSCedAmyxg13FOUrlGhKhOERR3YXyxHmHxKIryM
X-Gm-Gg: AYBFou3jrDsQOOPHwCI8LoFvcpCuqSCpuBI5Y4oJQ399mf912ZP6G9sFvAM9+mjR+5n
	pamNA3pN4Kdc0XacJNEDTdEg9cBTtZgLZjpVjes3BcVy1VmzUbfxnJ+dEK2vTSmfiIxnA/A6jl1
	axQB7W3UH94vXWuLuu7f/OG0NoGogEzUS25PWs1mE/2Xi8p9LyKwoQ2Qbd3UeBmopFP/kKulBiO
	AvMfpCajamfMz6rqXaZ+1uO+BX9gJYI5x3tg7B6yyul7JBEVVkZSPWdlAbiolfwfV5qcrFyrn4F
	BMJBaP6D65FK4OCXtl8QYf8SCwQieqCoAix9quZDwyb6jzRbBAaJPkFC/WaOCIib4kIvyydgUTV
	7lP+TqTgDbGvG2BnE8hBbQU+hO+Y1VDv8weD4VCJS0RiNcVyXTQn27Dyj7BPhG9vB+4E+XLwHg+
	tURIsk0GmJa1VvaFTNXnriBVy7j7gOYlYS1TvkSVhghjZTItarkLAkE9Y3WSWY6ju1knXq9WZQV
	UrFnSh+yOuwqHDP6p854MtfIr7zjrlx7OmmD2SvOIjTzAYNLlwx0RWpMWBRFSPAckU85mr4Uy7Q
	oht2X4PPuNWkg1vbSFs+BIoPsLL99FWS
X-Received: by 2002:a05:600c:8b04:b0:4a1:db17:c7e6 with SMTP id 5b1f17b1804b1-4ac150b2044mr235626945e9.2.1793634307242;
        Mon, 02 Nov 2026 07:45:07 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896ecsm369026565e9.9.2026.11.02.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:45:06 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: mchehab@kernel.org
Cc: linma@zju.edu.cn,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] media: dvbdev: fix dangling minor pointer in dvb_register_device() error paths
Date: Mon,  2 Nov 2026 15:45:05 +0000
Message-ID: <20261102154505.1224791-1-tristan@talencesecurity.com>
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

dvb_register_device() stores the dvb_device in the global dvb_minors[]
array via dvb_device_get() and releases minor_rwsem before calling
dvb_register_media_device() and device_create(). If either of these
fails, the error paths call kfree() on dvbdev without clearing the
dvb_minors[minor] entry and without going through dvb_device_put().
This leaves a stale pointer in the array that dvb_device_open() can
dereference under minor_rwsem, and bypasses the reference count
established by dvb_device_get().

Fix both error paths by:

1. Clearing dvb_minors[minor] under minor_rwsem and calling
   dvb_device_put() to release the array reference.
2. Replacing the direct kfree() with dvb_device_put() to release
   the initial reference and allow the release callback to free
   the object when the count reaches zero.

This mirrors the cleanup sequence in dvb_unregister_device().

Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/media/dvb-core/dvbdev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d753d329502a6..c931c467d4c52 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -551,6 +551,10 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	if (ret) {
 		pr_err("%s: dvb_register_media_device failed to create the mediagraph\n",
 		       __func__);
+		down_write(&minor_rwsem);
+		dvb_minors[minor] = NULL;
+		dvb_device_put(dvbdev);
+		up_write(&minor_rwsem);
 		if (new_node) {
 			list_del(&new_node->list_head);
 			kfree(dvbdevfops);
@@ -558,7 +562,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		}
 		dvb_media_device_free(dvbdev);
 		list_del(&dvbdev->list_head);
-		kfree(dvbdev);
+		dvb_device_put(dvbdev);
 		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
@@ -570,6 +574,10 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	if (IS_ERR(clsdev)) {
 		pr_err("%s: failed to create device dvb%d.%s%d (%pe)\n",
 		       __func__, adap->num, dnames[type], id, clsdev);
+		down_write(&minor_rwsem);
+		dvb_minors[minor] = NULL;
+		dvb_device_put(dvbdev);
+		up_write(&minor_rwsem);
 		if (new_node) {
 			list_del(&new_node->list_head);
 			kfree(dvbdevfops);
@@ -577,7 +585,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		}
 		dvb_media_device_free(dvbdev);
 		list_del(&dvbdev->list_head);
-		kfree(dvbdev);
+		dvb_device_put(dvbdev);
 		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return PTR_ERR(clsdev);
-- 
2.47.3


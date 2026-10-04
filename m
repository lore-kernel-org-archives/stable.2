Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F6841441D
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791108473; cv=none; b=bZix+9MGtuVHzsea0UaOqF0weuehchklF+YsgVCEU/0nl6tmWd/GXfgCj6c7TUg3w+EmOP8lhyhheOPmcsLVcgGyjJvQGOCZcGlQidEPqplH7JKx6DJHgZYeoO9p5CRJD+QFqiBC3IAFWEHBuufHO2jwigf0lMFAc1BnuRTa3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791108473; c=relaxed/simple;
	bh=V8p7f+anGnSoL+KBB359kqfJ1ldhGnObhu2HYkCbO4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdux6zwZQLCuaASwJtA943HJAMmLGz1XOyhFSykbNf6HXDCXkNGRXXBbW4cGb867xp3rbtRZIZSyJUgWks1Qw3fAZenxqiQnZRuOFs7ZmtKVC5NsdLpF5I4K2AuqECNNO7SYi8ZEpPVxU3gvN1277hc/72ZDregk+msmKQnHXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpPkL3Qp; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpPkL3Qp"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48afd5b1678so426583f8f.2
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 03:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791108470; x=1791713270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yr4Xk59A6nBEe9AXu0gZsAXZVCEOldu1UBAKss+kKik=;
        b=SpPkL3Qprtmbmc4Y8rw7hbFhv2TP8pNJxHxSGjVB96GKlOKRzzW4da+H/fvEGJvzvX
         5pPv8lImD/oRoQ2vsZRjPxm23C1zuOAv42N1zStE3rSKOx214agHIPgTyTTsrbXL1ckg
         9IPdx0zJSy92FuKGVeS9rQpCCheGNZ77if9KXZxzskJe7mZwMzvBglPuGcOzrbDT/mrH
         Zk3PYJp9uAgYuT519Akj4DXRYhGToDhsbtOQukmdUZTIUmccLl0k2rODJ+5CnbGS9S2z
         M+f1ig/9JZP/gvsvCtxa2jqmBXOY6+HUI7j8oXDAU9n7vsdbC9Hm1ybCYL+TD2LWT29V
         HB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791108470; x=1791713270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yr4Xk59A6nBEe9AXu0gZsAXZVCEOldu1UBAKss+kKik=;
        b=t2LUTXIxnbcoa6U4/yCD3aejhamW6xIZTpwh8elpdLV+t+rgmJu7NZeZzL8MlnSR4U
         jqFqemR/HGD3bwLb9nnScarxsnnM4HaN0cav27eD/qwiM00khCheIN227w2blFoRObCN
         SiigDn7nsSbELfFgxqPk08DNZAZzgoY0NQU7KH1YkxKAv28TxI0zoEKbAeaa5ObKTNft
         njlbr/WaWXtdnUHK0dHLxHZ63YiEMm7lTGDBQhptPYYRqATEIB/dWZQbCGHd+n6XXn3D
         8dov4ztRrZuQ3LUGXWStaPC3NllH9OLDrzvN0Nmp3L5bif+MlPKtvYC0b2S+rqvAA2Uh
         Hx7A==
X-Forwarded-Encrypted: i=1; AKwUvBzvBr35lkSpE6k5/J2TjvKlzsxiL0iPKLclpxY/vCjYGbJc9BRuqafhUi+/kPRq35+KsSBcaAE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqVoB6qv84FTFfxk/d5pHhaT2revTpxlavm3lthNj9n+yxVwu2
	zfn2oxWpujn3PwT1rt1maygH7H6GiQWssvKlO8yVIh3d2rq9/LsTJ8D5
X-Gm-Gg: AYBFou1MAOxLRlYXun2kK8jbPejVbzjKXNlF6UHnzKgUBC5ZoQouk87IvSjIKQ/VK+O
	oxJ6FcSRIQVRBFh240VkhCked42TyuvcZKhrrwn7307nJwr27fO+U01eeq2duOLrIVzSr5f0Hro
	Q/2x9SUa7T551qR1OFQM78EBGscEKPgCdOCP+z2tjGu2NGvcT0pwnM7i+r4YvPYczqGpDJ8t3oi
	q17qczvv+JeTNTN6mwDRGLXtV/5sX8Ik992tU/fuD2op5lheNu99mJI2dO9j9KCmjdhF7Wia0WK
	5cy+6yJ+au4K9dhwWXBuwjyn5y+21Ggy5dB8Hx0A2Dy3C2tTTbn01PpiJgQrBsbSoAORGlT54us
	oqbMhI8w1CzSbdfbtMQoKKAFe8b2XGstuhOllZtQAq3osH15Lk8khBQPVKCdxBXchWlQq3fdYc5
	NK54GpCP+xIt60YfplCGCs6ziIDx6g+nEaEayyUoO7Uad/7xEEecbpGSomsqlEtlU9dJL6vo2jP
	rTa5l7sLa+aaID3zDDbb41A4JD4IRWTjdEwio44YVjKq7q7uLkjNHekKvwYkoA1xQajmp7zrcN6
	284R+b6Gqv7npoVHWiGwAawEj6WFhvutRDP5F+fSejkHsQsSbjxURfWXY0R35JtG+fQbmftz7g3
	pvExj6PyQIuxRhMPVBTfD
X-Received: by 2002:a05:6000:260e:b0:48b:161:ff26 with SMTP id ffacd0b85a97d-48b12749fabmr13400933f8f.29.1791108469910;
        Sun, 04 Oct 2026 03:07:49 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a00-1028-c000-0ddf-b17d-de75-1ac4-0a1a.ipv6.o2.cz. [2a00:1028:c000:ddf:b17d:de75:1ac4:a1a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104602sm18136032f8f.26.2026.10.04.03.07.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 04 Oct 2026 03:07:49 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/6] media: az6007: fix CAM status polling after disconnect
Date: Sun,  4 Oct 2026 12:07:36 +0200
Message-ID: <20261004100741.71711-2-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261004100741.71711-1-pepe.schlehofer@gmail.com>
References: <20261004100741.71711-1-pepe.schlehofer@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

az6007_ci_poll_slot_status() returns -EIO when the status request fails.
dvb_ca_en50221 treats the return value as a bitmask, so -EIO is
interpreted as CAM_PRESENT|CAM_CHANGED. The CA state machine then
handles a CAM change for every failed poll, without sleeping in between.

After an unplug, every poll fails this way and the CA thread can spin
forever in dvb_ca_en50221_thread_state_machine(), preventing the USB
disconnect from completing. This happened when unplugging a TechniSat
CableStar Combo HD CI with a CAM inserted, and rcu_sched reported a
stall.

Report no CAM when the status request or buffer allocation fails, and
only inspect the status byte when the request returned data. A read
error while a CAM is present is then treated as a removal and the CAM is
reinitialised after the next successful poll.

Fixes: 962f8f67e486 ("[media] Add CI support to az6007 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
 drivers/media/usb/dvb-usb-v2/az6007.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 65ef045b74ca..4ce1afe01c3b 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -526,7 +526,7 @@ static int az6007_ci_poll_slot_status(struct dvb_ca_en50221 *ca, int slot, int o
 
 	b = kmalloc(12, GFP_KERNEL);
 	if (!b)
-		return -ENOMEM;
+		return 0;
 	mutex_lock(&state->ca_mutex);
 
 	req = 0xC5;
@@ -535,16 +535,18 @@ static int az6007_ci_poll_slot_status(struct dvb_ca_en50221 *ca, int slot, int o
 	blen = 1;
 
 	ret = az6007_read(d, req, value, index, b, blen);
-	if (ret < 0) {
+	if (ret < 0)
 		pr_warn("usb in operation failed. (%d)\n", ret);
-		ret = -EIO;
-	} else
-		ret = 0;
 
-	if (!ret && b[0] == 1) {
+	/*
+	 * The return value is a mask of DVB_CA_EN50221_POLL_* flags, not an
+	 * error code, so report no CAM when the status cannot be read.
+	 */
+	if (ret > 0 && b[0] == 1)
 		ret = DVB_CA_EN50221_POLL_CAM_PRESENT |
 		      DVB_CA_EN50221_POLL_CAM_READY;
-	}
+	else
+		ret = 0;
 
 	mutex_unlock(&state->ca_mutex);
 	kfree(b);
-- 
2.54.0 (Apple Git-157)


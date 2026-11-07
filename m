Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033424;
	b=qCK4F6V3JKvRD8POZomfRKVZ7OSwPPE4mxbHgD/vYFt8KCtFlApzlE8/0VgBUJfAN9Jr
	 ZCEk/1gMwaesT3n6wihGTwsdplxUbcSyBBB9WqI9/g8eL0lr0pR5ajdcuKJDeADoe3Hqn
	 dKUXwGjga91bFoXGW/zZDKql0HqLhZX3N89NsN++GwkGW8dDEVghHhr08jSJCuqE4qSnw
	 2j49sFOZErkleAb9GJba2YNOb0OrtMTWme2aY++WEo3SOhljhVOiNS4Ue1jY/9YWjp/XR
	 S9XKuM4Hep+59NDUoniEi1LWoNx2ma4eFIaUU/XvsMyhyucIJjYriVt4p3el+UgfhEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Nfma+fKmOvB8Kb+wDc6iuXdg0uKJemcmpk9R9n5B7+o=;
	b=EDHOkOWWYIObT+ifmrtygXCVEorgiRsV5COhnUaTGCumDLsI2VcHfv+SE9IZOOw8FkB7
	 5ntT44bDxAWWGtuf6t0HUUSgVMtTPlKEd8BYLsfee8+Qs/FR6aUo0jNb7Aq045IS8IDf7
	 9cWtJwOypsG3z407ue/2GfaWnf7P/QU6Pchr0gcq0/Q0gbr/CnRK8LWPy9NrU+GB5Y5GS
	 GvSh0AT4nR3u62JOYU93pOw9LzrsSJKCWYUCJ/WAKoCBJ3b/Q8Dv4NOz5hVfgXcKeYWjm
	 fvQEwAu4ABdiaXzPNACg0SCzgnDuf0B86voST58KJ72xFZFoT/Yog95l0Ttxs5Bqa/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cOzjfxWL;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B0606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 06:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A3B0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cOzjfxWL
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed2b4348fcso5302325ad.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 22:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794033422; x=1794638222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nfma+fKmOvB8Kb+wDc6iuXdg0uKJemcmpk9R9n5B7+o=;
        b=cOzjfxWL+j9lSpENTzhuwl27q9nHgq3B7LCdrsD34x25y4TBbS2/8Vsl29m2s8uwEE
         vqyuph5P2EplS/EpcfLSJEvAL/ujYPVeG3HiMR7R/6bM36fg8FddRBep3gYnW/rZj+wW
         7HcQ4iOEaWpB8JzQKogSwuS4hv70LY574AIYyYZa5QzADQbdBpmr7q8KDLL8h2GwSSCV
         lVVDlHUnIu6eAlQhBprgS3bcwylYKMlec59qSPMXEj7bOy1k/VO3LvWlWVnguFHZKEWU
         yyhVX+KYGY8tJPtNzxB4QDcMiIQmzQE7qEZfyrkFMauESXp+Epvt5xHlVSTQdvrY6VJo
         UOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794033422; x=1794638222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nfma+fKmOvB8Kb+wDc6iuXdg0uKJemcmpk9R9n5B7+o=;
        b=jypJxR/8oHYGoBYexX4aSJhnIBJvcIzRkmTKJ34DIz17wX8+RHpcWD0mmT9pjmz1cx
         ui3rUG2Ib+DqZY10zREHCLXjZs/GDnsTs8NtlHlqv1MJR2CM7+pXfTsGiemvn/+MHSD/
         kr4wLDDTt84K1wDkXwcCbhhHTaUXHRt5tg8NDg6uyowzWAA+CTgyItvTKEeBX1zyG5qA
         Vqa2+XHLz3vXKx7CFOtym6xUi2rt5sBDetIVJENzfCqAkGIiay+1wnh2v9gKMyN6xri0
         /mPu06e450ik9hEgDevLsHjyQYiM2xpjNcmkIazP/ujeWCHCOFktcFRGci2V5eJ9QtBE
         6zZQ==
X-Forwarded-Encrypted: i=1; AL+hErGrOYNr2Q9HxVQN+i6Wn1NrJthFUEZUcxdv/CxFD+DHVBZjMcfQomR6N6j8vTDGkKBa4ldAWac=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ehxAcoaS4Y/GyQNmmt3XOEjB4oRfzX/ogmTSaAgtIABZWnlay
	hiPC/eHhaIwF7EDKkf5phu7wA+GrvhM+v80Wln5hGjvUR+xxMSH+KSiy3MBlhAOn
X-Gm-Gg: AYBFou0N0hafdhxNvHZc9qmMF5QkQvsUpkEBD0Ni+b724CrOu/ESaEEg7dhdK3GOdR0
	SliaWlj7/SzT2pVPvyH79tTWWZAG/B+6BJBG2zb91ZnFd33Ac1dnJmN5aJHM6zbKBVUe4Uy34nl
	yTUNC9TeeLUJymyT+PWkHQAcjsrj4oruoX+4PIWVNKCniKCFCRv6DMrt7hJuhNNbciJBPFTVxsq
	1Wybdhlur+rXetu3IwS7Q7oM5KlJr43binSFl57FaEt3XzAlagNn1LE84ttqvYom4Vok7M2OacM
	TldWHZ81/x7Y20mF4LPwKBZC+8xzGyTjXB4YdwOWLAY+ShF5Ff0FCNY2PWmmNbmpyNSdru9X4Ee
	qzT7+QI1UJpzhjkYzZ0dvX0ml8T+SDd2sByqWlS4vBBIavkT0BJxr8yWjqliaTxbpPnIDnJe0uN
	oI0fISWNMhLEXuvS9qMjb4A+08VC4SqyAra7YNPR53lMJ9MxhBndiU5lBThbpVabJXDVbf5cAiG
	NYR4tuj5DeGMGMbwc6+TeN9kfTTil4FZ6N4Qvxl5aBCqWGvYfgSNr1xEPuAqIOb0zWX+Nm79COr
	nqOD2Fi/1zc5gCJpCQxh+LbENM8RHds9xNiB/QVjpyYokWle
X-Received: by 2002:a17:902:d503:b0:2e9:79db:449c with SMTP id d9443c01a7336-2ed40deee43mr57053455ad.47.1794033422254;
        Fri, 06 Nov 2026 22:37:02 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f792sm11115735ad.47.2026.11.06.22.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:37:01 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: pch_udc: drain vbus GPIO works before freeing the device
Date: Sat,  7 Nov 2026 15:36:52 +0900
Message-ID: <20261107063652.3387873-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

pch_vbus_gpio_irq() schedules dev->vbus_gpio.irq_work_fall /
irq_work_rise (pch_vbus_gpio_work_fall/_rise), whose handlers obtain the
pch_udc_dev via container_of() and dereference it.

pch_vbus_gpio_free() frees the VBUS GPIO interrupt on teardown but never
cancels those works:

	if (dev->vbus_gpio.intr)
		free_irq(dev->vbus_gpio.intr, dev);

free_irq() only waits for the interrupt handler to finish; it does not
cancel a work the handler has already queued. dev is allocated with
devm_kzalloc() and is freed by devres after pch_udc_remove() returns, so
a VBUS GPIO interrupt arriving shortly before removal can leave
irq_work_fall/rise pending and have pch_vbus_gpio_work_fall()/_rise() run
against the freed pch_udc_dev -> use-after-free.

Cancel both works after free_irq() (so the interrupt can no longer
re-queue them) and before dev is freed. Both are INIT_WORK()'d on the
path that sets vbus_gpio.intr, so the existing intr guard also covers the
cancels.

Found by code review; not reproduced (needs the EG20T/ML7213 pch_udc
hardware with a VBUS detection GPIO and an interrupt racing device
removal).

Fixes: 637b78eb31e0 ("usb: gadget: pch_udc: Detecting VBUS through GPIO with interrupt")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/usb/gadget/udc/pch_udc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 99b3ce2..5531094 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -1406,8 +1406,11 @@ static int pch_vbus_gpio_init(struct pch_udc_dev *dev)
  */
 static void pch_vbus_gpio_free(struct pch_udc_dev *dev)
 {
-	if (dev->vbus_gpio.intr)
+	if (dev->vbus_gpio.intr) {
 		free_irq(dev->vbus_gpio.intr, dev);
+		cancel_work_sync(&dev->vbus_gpio.irq_work_fall);
+		cancel_work_sync(&dev->vbus_gpio.irq_work_rise);
+	}
 }
 
 /**
-- 
2.43.0


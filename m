Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795062443;
	b=gtcM0qewT5Y3tusAtEx48ljh/SzbpcqSzimX7UxwgsNgyTNqGrkJvJ5WFvp5E0BDD+pA
	 c+/D7XrAufMAIkIhVOu/lMpWNXsxykLQjdPYhlDFV9HMj4DyzM/0LKeWaTcxhTc3Bzh17
	 qZDAT0gghtz1LwGRZpXf/uW8zWqsXb1C0V1N+K4xMI3d3cEyjOwddGpog0OraB2KpmfIR
	 HwD84lOCkPZ24v4aKo+3oDMWjNPtG91MnIoYg4pmAoGEytr2PrbN83Ev0wM387E1ys/ur
	 KYYVwo6pfhLY5QJs+A5pqHhzrgwVrJPGEUxvXtIodCVIx8RJYO4z4VPHaLoCa4JGn5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795062443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3Hxcc3mWV4vpK8u9zPUdfbWlyMV/Lx3auErCWtJ/vww=;
	b=o+EHfV7UzzVLQubpeDljp9VVhoIldja5q/R7LCL1Z6Jca/Ey2KRX1B2Js6BSSb64VJ1z
	 MQQmDkPYaFyDitBhu6gq/M+lq8M9EqDEzu4qVnfIIasBGl2rJPM0MGhBR31C9h9saeAY5
	 L7CIV0u23wDhSBTNoUVqSl/yQTuoVzkNpGQpgq4tU+DWb454jVl6NKOc43kQEvHbkcSWu
	 62xeQ9W1MB56eWg1N6nwIrYoke18yrpAwGk/7JZX81qVrVCHvS7TRNb5edOC46lWIDeox
	 tRrY1LiKCWdjZYUHyDLIQgK+LRixl7LuWEAqBvk++D/4ZiBvcxb9tXR27IfMrcJ6CGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bdZ5luSc;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D071606A330
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D071606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bdZ5luSc
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so1409322b3a.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 20:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795062442; x=1795667242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Hxcc3mWV4vpK8u9zPUdfbWlyMV/Lx3auErCWtJ/vww=;
        b=bdZ5luScc7SG3YNewnCwCgsSUxO4L668OOhIJJW+3KnwrEKUzPXmaSbigfrzIcBnmx
         KSSVyoP2KeqXVWwDmBezvL61+GjMSe5jcv1IZ3far/x5lRc83bqAxViV0F4PAEXwxPKL
         c1u1XZLNxpy68zHWWUf1R50aWbfH2GW5QDf10KXIb/BEDYi/a/FbdDYN187YRU2YMrN9
         3OO0SSj2PDmW3LtQ2oRzhDhpjoLpJ88j/9KCYJQv/9E//M1g5b0AYOtCWcAwR7EVpmgi
         /AuSMNFGnNZ+OqO1BMWddOQU0ex6UIrbgjooIM/z8mfpUy56tsAX+bwPOpNgxnPwt896
         Z4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795062442; x=1795667242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Hxcc3mWV4vpK8u9zPUdfbWlyMV/Lx3auErCWtJ/vww=;
        b=bmhIbboPlSSyoLWJBb4Toeh5p/DVRekEhO2y0b5lIs5buAOI0SY11O4tnLXdJGwZio
         JcAcy27hvnbDuAGT7hwl2gGrSWia+2JlTgsnSKzeqRS4hlcacr7FiNa20cJVp/HMnvBy
         Y53R89/U8+8SDM80HEtAJGMUokQI1SreOiZarFheg7w1okeA9KEdOKlfbmfNa4eMSRJT
         rnOxlGLDz1b7T0rRjs8dkfa4zHiKqtfILfpwfE9DaewGkzYPkatiR+TguXs7oDtg8EW4
         LwkKS2Q5TeVhBXt6+mIVSn+qR0yWYDYhDPVzUUkQhpLe5oRIo5CMOrBF+s4F2DlrypAD
         YEqA==
X-Forwarded-Encrypted: i=1; AL+hErH2Qu+OyqMNAZ4rL5txw0TP6dQn4nuwfGui8uA5ZotYGgRTXMxDi0CXHRThPovydG4MpScC89I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+F0dsjQbxc4YWHPqH4yXBH4IHAh5LyE/PxwgeiXBg5Kc5ZyMwL
	CUcM2E1THJE24oTpzKKf8dtF1+ZRXC+71ZPmjRiz/P+UY4FI+YsS3My7
X-Gm-Gg: AYBFou2ah8B3r/2wSmAeb/OGt7fmhbN9qoEIfV6FIXWOj9pUHv5W6ZrdWeb9TspI5XI
	6AjMe7ko4nOVZBnQT2RrfCFW4pZ8keDJAtJOgmBTRHxyewKgk4gaH7vlp37jFSe4t9qaGpHbOX5
	pSNftsyKA1xreV/PcCPwARxdUclfeaWOOqLTW3/YcpaZnUtgfz99XBpRjLpX/aO2oQ79+7JKLY7
	KHlQQWAxf5QjIoIcANjDJedIri3SECRiU1kf4p7WM9rHW06dvmvCMuTtnCZQ6dw+uPX+zVeebQV
	Rh8QYHyAQ2HcDwOZETPHaTnu/qyGYfAHLwnwhpQxojKLyx9xl9M3k/v465nMFiwemUGA4KNrmxW
	aW084KqhubnsPyihIjHwLIhyCVhfNo4zQ4i4j5DXjV8ZRGgOQQbq7eh6ERtG3agjjLGIiMtFoFg
	c6xO0XnuPkNTPp84IAvQUt0cmgODpjD39Jd80jlj625dVeWnBw080pCpESA18HVY8T7AsqLddqw
	DgnyNImOhUNdqAUxq/fVf5JEEZPEY79tawvNy2LydgJWC4iGW3/yI1xyPKepaESvBWI41lSNDqf
	+57qKDQtPeKmUF3Z
X-Received: by 2002:a05:6a00:4c17:b0:89d:eb23:4e83 with SMTP id d2e1a72fcca58-8c5d3d12f10mr4182188b3a.30.1795062441855;
        Wed, 18 Nov 2026 20:27:21 -0800 (PST)
Received: from x1.hs.local ([2601:600:a482:7d70::5e59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cb35830bsm2077636b3a.33.2026.11.18.20.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 20:27:21 -0800 (PST)
From: David Westen <davidlwesten@gmail.com>
To: netdev@vger.kernel.org
Cc: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	m.chetan.kumar@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mail@maciej.szmigiero.name,
	nihaal@cse.iitm.ac.in,
	David Westen <davidlwesten@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: wwan: iosm: cancel the ADB timer on cleanup
Date: Wed, 18 Nov 2026 20:27:13 -0800
Message-ID: <20261119042714.505405-1-davidlwesten@gmail.com>
X-Mailer: git-send-email 2.56.0
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

ipc_imem_cleanup() cancels the other imem hrtimers but not adb_timer,
which the UL aggregation path arms for 500 us. If it is still pending
when the device is removed, its callback queues a task that finishes
the ADB on the freed MUX, and the hrtimer itself is freed with the
imem.

Cancel it along with the other timers.

Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
Cc: stable@vger.kernel.org
Signed-off-by: David Westen <davidlwesten@gmail.com>
---

Notes:
    Build-tested, and run as part of this series on an XMM7360 that uses
    MUX aggregation, so the timer is armed there. I haven't reproduced the
    race itself.
    
    It comes before the S3 fix in the next patch, which makes this teardown
    run on every S3.

 drivers/net/wwan/iosm/iosm_ipc_imem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 4405c8531888..20f8da53a3ea 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -1239,6 +1239,7 @@ void ipc_imem_cleanup(struct iosm_imem *ipc_imem)
 	hrtimer_cancel(&ipc_imem->tdupdate_timer);
 	hrtimer_cancel(&ipc_imem->fast_update_timer);
 	hrtimer_cancel(&ipc_imem->startup_timer);
+	hrtimer_cancel(&ipc_imem->adb_timer);
 
 	/* cancel the workqueue */
 	cancel_work_sync(&ipc_imem->run_state_worker);

base-commit: e203d8a4751d48aa00eda31e3b320ba8e0d47dbf
-- 
2.56.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824258;
	b=ui5wtRMzQMl2QtIWgw1GKAaRXsTFnmzMoZJPxVCXDbvYefylL4y1pK4G0TTfysg2l4oo
	 Lke4tbnb6ZvNvdnWVwuOLEd58nRQyIiKVqc6SGEOhwkvn2vyLZssikiN/MPrQ1yCJpqBC
	 3ypuXQQ1fj8jbNddNQbxGjMYirhm5ysvf0OfD8dr4M2F3yNGY5wM9/qzBd91dKSLJcm2c
	 rY0EVFYmEv9XWH29fENn2+qjbwECLqd1+SVcBa2/ihcryEgV1RAHl7sSd0LWGkcyFkgIe
	 ctxOBVaZb/cmXIc290BY5nROBDyxBnHIJashc7g1d5RaRtHjU8r58TnX8mHYTG/m46g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=huPVslj+kM9c+WtCioU3Ljzu+t0gbVdPL3W1oxXh1oM=;
	b=iRWcQ8NiatsRWtegWXeScQMpoh50bqpvJDlSR/lTjjpgAwp67P2Z4AQwB+wDP2ECh2uy
	 +NoJRS2vQy2AfwTBXWzhPsMNXzJ2Be/JH4cQHyCylslJJdKp7fOt94kLH2bLzJAs4nUuH
	 65nwo95yZsxXwMq0j16jQM8UK8rPkTIPFx9f7MVDDTIz6JENTEkEeckDWoJBSChAC3adh
	 SlLfxvg/9C0gIRcTEo7g60kSvIAxde+JdzsHDStGG26BDdQe4dtfheGPKQZOq5hZ75l9L
	 f+yatZnW7Vr/LwNKJjBAMuqKmIcOWfN5v1Pt7sb9DFtFXloQcBhJyNi0YHRqKGknRnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=LXvS2106;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298D606AE0E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 20:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9298D606AE0E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=LXvS2106
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e47347279so694380f8f.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 12:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1793824256; x=1794429056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=huPVslj+kM9c+WtCioU3Ljzu+t0gbVdPL3W1oxXh1oM=;
        b=LXvS2106f7G3x7PVtW2Uc/j2I076hzP3YOxsuP76p3ihKo81neXfgxoLSaWA0vp3h+
         gWSdTzowhKTy6g5f0gIpElccxgYx8aRj2B7hEl6SVWOIyxPO6u5Ad1bTjKJlSelVHU3x
         1uO7bI2o6Nsw4ANPDdQX3Utt9eLr9hwcEl5g0+AKoOGU69CtkbHqDU5D+jJBkGGTtpAx
         jJz6OKIqx8DHqGm+vI1zjxRND6y1mwn9cbbb1xshHUv9acUPbjeh3EfMqM+CoXQS45ie
         H1fqZgQhvXZRz6rU7Y0Ib9iPzdGBJJ+Q+Oz4BD1ENFyvEXZi26Ji2irgcfO8yioZbvnt
         FtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793824256; x=1794429056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=huPVslj+kM9c+WtCioU3Ljzu+t0gbVdPL3W1oxXh1oM=;
        b=ui5zHpwTs3Nx26xdfoP38bFpNqnO6Zl7Rzg6DvsevtNWIVBKcpWAAQnLJH/2EBGd2x
         LmWF1IuA9musjO/QT7gE6/vuaJLimEnueQu37Z/AMSHzvGhQoZsnkaKzL5ZYNHiuU/kI
         e1IWExFW2xxqBMyin/3h+pWTooR6efg3g9VIVDOrRRNpyJM/H3HTR5o2lfZWwvzCieNt
         iydxcJydiMU5JNSZlXHYteJQ1xyAfF/7kiKGwOOLaaKbZI/gTyh67glb69SR36N4EXJI
         CpmMrZU6a1w0mInqOLKhJJk8YRUkAeUsIlYixn7QnCo9ykhRC9c6Wff+qnRbD5apYskR
         pS8A==
X-Forwarded-Encrypted: i=1; AKwUvBwG/mumSryg3+0ys4yufPtnqO1ZP2vFACldtzs6Zv43wljOE8xrQdmKdrmyTtgQAC1xQyhZQKw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aBs2BLc2dC8r5ReEhyLQtUw6ZJ/axTr8kW/7GB4ANeWYixvwD
	hmkkT/83106fZaY8mN3EK183l8/7HaihmqIEtMUtAtej/O07uydueh4udZKWqR0Yw5jBC4kvCGx
	xt71Rai0=
X-Gm-Gg: AYBFou2/35QhhsIrZafZkg/pE33nJEj68tahYmH9cOD7FIxYdZ9rA5JBOyFTlvBEegX
	Qn66cDmITsX+FDzW30g+aTrsmZDvkKvQo/VF0BZEVxI7o522ggoHKKa/tise7hq7bK79IxTTbCv
	ULxVNLaWL6IzTEFPIhJfjLmnG/cf8gYnDZUM0Jr22jE4MY+RhSd3IbqViiMJXQ9IcAppVuzKZU1
	3fzDpI6kGNoqLB6gPQ5+qbfctv+MYr79Q/RVG+gonpZJ/t6fbDZeLkSGjlKej6/JT/Uw+eLGDdZ
	Qg/g5285U/J1BRiJP0ZDPQSqHJBgncOyoNWvMrbMyhXlX8f2Dqlje2ye0IUgskRxXotgBaaBd54
	a6zOFoF7HzxIcq2hf9rzKAQKVSPpOrVLtub0bExSXmo5K5k3Q+WX9dqD68R2bbk+YY5MjazeU3k
	ophcj1uIqmj9tR8KgSRQ+QK4+zvgh2VSeiMF02BCjiVGwYnE/msLEi/Cz/GEj2lTePwX5whaYU3
	3BQAjWIrzbhNngQRR9cbd2OkEf4Ltxtun5DZnbX0dZoj1lhOIxX7Z5DgaYPCWGU6kU10TO4UMuW
	xbcdveNNPCUuqmyX76PHPzMi
X-Received: by 2002:a05:6000:40ca:b0:48c:5304:5e50 with SMTP id ffacd0b85a97d-48e6e2620d8mr39868997f8f.0.1793824256006;
        Wed, 04 Nov 2026 12:30:56 -0800 (PST)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda207d8sm5431164f8f.52.2026.11.04.12.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:30:54 -0800 (PST)
From: Andrey Misiurov <amisiurov@cloudlinux.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Drivers: hv: util: Fix transport teardown on util_probe() failure
Date: Wed,  4 Nov 2026 21:30:49 +0100
Message-ID: <20261104203049.1031148-1-amisiurov@cloudlinux.com>
X-Mailer: git-send-email 2.43.7
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

Commit 07a756a49f4b ("Drivers: hv: util: Avoid accessing a ringbuffer
not initialized yet") moved the creation of the KVP and VSS transports
after vmbus_open(). util_probe() still calls srv->util_deinit() when
vmbus_open() or util_init_transport() fails, and hv_kvp_deinit() and
hv_vss_deinit() destroy hvt unconditionally.

On the first probe, or when hvutil_transport_init() has failed, hvt is
NULL and hvutil_transport_destroy() dereferences it.  After an unbind,
hvt still points to the transport freed by util_remove(), so a failed
re-probe frees it a second time.

Skip the destroy when there is no transport and clear hvt after it.

Found while reviewing a backport of commit 07a756a49f4b.
Not reproduced at runtime.

Fixes: 07a756a49f4b ("Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>
---
 drivers/hv/hv_kvp.c      | 5 ++++-
 drivers/hv/hv_snapshot.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 336b278..813bec5 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -825,5 +825,8 @@ void hv_kvp_deinit(void)
 
 	hv_kvp_cancel_work();
 
-	hvutil_transport_destroy(hvt);
+	if (hvt) {
+		hvutil_transport_destroy(hvt);
+		hvt = NULL;
+	}
 }
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 847dc69..a827cef 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -456,5 +456,8 @@ void hv_vss_deinit(void)
 
 	hv_vss_cancel_work();
 
-	hvutil_transport_destroy(hvt);
+	if (hvt) {
+		hvutil_transport_destroy(hvt);
+		hvt = NULL;
+	}
 }
-- 
2.43.7


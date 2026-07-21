Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABC143F4D5
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622095; cv=none; b=Wqyfu49jWyNl6TzDg+XFIc3sySat5BmSmFRBBt9545DzL5NTXB2dni+9ufOqEi2Av0q1D4mgsN1syW2XaeBLMxjcT5e/45Fwey5OTYGaDJqKN1KakJ4WuFRYkzLRo0yhLHeP8Eo98TOlUdHxvDP/Ml4aqTsg4p9O31vVYnFxK+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622095; c=relaxed/simple;
	bh=ctu2JAjDb4vEv2Ofqw5ZSiuq7IdmtEWY9UJl9tqds/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1HdeLFCpwrS1mCw+yENGxDlNzUhoCEJOsBmnaqDerP2ePJ6yAtD5SAyA60mBHql1dhYIujuqCCRAIPE/0pTf43K2OccpYF+HBaF5tA776IpkrgYkjzrxTN7nHMsRidADRy59DLE2GFDmuWxuNaYa7dRmY7EEfXYEa8V6z4p+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kyt04m/P; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyt04m/P"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15ba5b151dso1064015266b.3
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784622092; x=1785226892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yOwKc54gLFklrg6TasEGy36BkhC9F73PBQa2PoKh7F4=;
        b=kyt04m/P2r5oxEC7ywbWuP+tmSyEzFkvUV4fMlHCNbYNb3aTEbUQv1kqASeYNC7dna
         IOnCzpSojBAZmUw9/E2NyK8rtUjW2Y3KOoHJ0ijDBeebq6OIioBCzOr4gikWeyyUDggQ
         Yy4QJ7WZ0fitLw27yTQv8sJXKsi60zpDAIY664OzPPb58JWLojqSXrNKl2sUyFQyJ0d/
         IpF5qOaAHm15UraZee/UkvRiTeM4eZbRe6iVi6TUGrglPuicP8EkK387LJ3hZVeL7sfh
         Fmd8V1RF5NstAAK9428gdb1lO2WwJp8CkE+BfaIBQoKGjloYrwd1Phf0h0n/TujIZQM5
         UKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784622092; x=1785226892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yOwKc54gLFklrg6TasEGy36BkhC9F73PBQa2PoKh7F4=;
        b=B+w17qv0p7AOqUguBMjUleVMT9N24CNz8Hb1LsGSJ+CadE2n9rOhR1gTvK/1bHyVzL
         V4IqFip+pBTRT/7+7SSQNx/d5EiXLC6zBQH5+ATvtSeMPKlBsBUC6d/lSlNn/Mr1hHNO
         3xGC7zPJO8fPuRHnPk645SuLQy50APYHgk2LFx9GctijE7IwnoJx3A31mQZCMaeouGmH
         hNeAZuL6d8HBb7az3ac3WMkTuG35XgcF0YnQwyc5ycxa4ufphCUT7HfujVsX8BpIp6ND
         COTcui8KzVePKyhvLLWAnN0h3y7VmOi7QzRjU1luzf3cu67c005xcTxW4aWbVs1TzA6j
         WXUA==
X-Forwarded-Encrypted: i=1; AHgh+Rqq7CvYTt/HoTNsonoY0chWL92+xEybEMPPLjNXZlUC5iLA97VVhYWcz6X5Ai5tg+79GWIIdlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFbyfWeY596D3qMGsvFhk7iylUe65CdCmcPyZpWEE46p1ORKd
	V50yORenLUkSsf8H7xReFyY18bkMtumhz7IOJz5/owhGA0yAlQHufGi47l6Y07q2btum0ZD19Og
	OBlWpTzE=
X-Gm-Gg: AfdE7cl4UU0pqNXrnwnGXK2a+Wv0d/cBwTKM3fuNB5CF0AIwDyt/s4rJwVvk+ijFG0H
	/K3nGO0N58UwwuawM62Mun1N6DRZm7ogMOPIZEiDXQMEAEYm0+P7ZQAQDEyFN/nY8ouKCPsPLcq
	TikQKoArbr4XIkqMsJd+RKY0SsS+cs9l+AVsXiR7hzSNfp31phvvq0U02hytCgI57rZnfzfBLXk
	K/++6rRZU80EONcZi91sEttJAYn66JZincsfcQfudw0AVwXBiiUICd9KOgHvSd6kYmkMsKYQSt0
	s4H9478odVv6eevoseKNU+6ZA8Ysihw+kappMAb2djRPEvtf6TOgTwXJTag0Yx+1Bq09x5hxmpa
	kctXQ322hbck45ibf9bslLEsYWY2pOyUv0mbGC1S/ikNb5zfw8xHn6y/z5yVBDmAOEPstU8O5Qy
	qM4rDuQ1q7QTMlo/7Lf5IGoy6Q8wn7VmRGbfU1SEw4qOE+b/n3aZzx+gzrLufiJCcxKw==
X-Received: by 2002:a17:907:c5c5:b0:c12:f81:661f with SMTP id a640c23a62f3a-c16b4833e24mr638733366b.51.1784622092166;
        Tue, 21 Jul 2026 01:21:32 -0700 (PDT)
Received: from puffmais2.c.googlers.com (185.155.90.34.bc.googleusercontent.com. [34.90.155.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1724f50b72sm564725066b.48.2026.07.21.01.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:21:31 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 21 Jul 2026 09:21:27 +0100
Subject: [PATCH v3 2/2] drm/drm_crtc: fix race with dma_fence_signal() in
 ::get_driver_name()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260721-linux-drm_crtc_fix2-v3-2-afa8c71506e6@linaro.org>
References: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
In-Reply-To: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Sean Paul <seanpaul@chromium.org>, 
 Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, Simona Vetter <simona.vetter@ffwll.ch>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Since commit 541c8f2468b9 ("dma-buf: detach fence ops on signal v3"),
I'm seeing the BUG_ON() triggering in drm_crtc's fence_to_crtc() via
drm_crtc_fence_get_driver_name() regularly:

    Call trace:
     panic+0x58/0x5c
     die+0x160/0x178
     bug_brk_handler+0x70/0xa4
     call_el1_break_hook+0x3c/0x1a0
     do_el1_brk64+0x24/0x74
     el1_brk64+0x34/0x54
     el1h_64_sync_handler+0x80/0xfc
     el1h_64_sync+0x84/0x88
     drm_crtc_fence_get_driver_name+0x60/0x68 (P)
     sync_file_get_name+0x184/0x45c
     sync_file_ioctl+0x404/0xf70
     __arm64_sys_ioctl+0x124/0x1dc

This looks to be caused by a code flow similar to the following:

+++ snip +++
thread A                             thread B

                                     ioctl(SYNC_IOC_FILE_INFO)
                                     sync_file_ioctl()
                                     sync_file_get_name()
dma_fence_signal_timestamp_locked()  dma_fence_driver_name()
                                       ops = rcu_dereference(fence->ops)
                                       if (!dma_fence_test_signaled_flag())
                                         ops->get_driver_name(fence) i.e.
                                         drm_crtc_fence_get_driver_name()
test_and_set_bit(SIGNALED)
RCU_INIT_POINTER(fence->ops, NULL)
                                     drm_crtc_fence_get_driver_name()
                                       BUG_ON(rcu_access_pointer(fence->ops)
                                              != &drm_crtc_fence_ops)
+++ snap +++

In other words, a fence's ops pointer can now change to NULL on signal,
which wasn't the case before the culprit commit and hence the BUG_ON()
triggers.

Simply drop the BUG_ON() as it's usage of fence ops is invalid now, and
because using BUG_ON() and friends to take down the system is an
unacceptable way to handle a failure.

Note that the adjacent drm_crtc_fence_get_timeline_name() has the same
problem and is fixed by this patch as well.

Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
Cc: stable@vger.kernel.org
Reviewed-by: Philipp Stanner <phasta@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v3:
- Philipp:
  - shorten commit message
  - explicitly Cc: stable
  - collect tag

v2:
- don't turn fence_to_crtc() into macro
- update commit message to include reference to unacceptable use of BUG
---
 drivers/gpu/drm/drm_crtc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index e8e80c936852..5295ec122e0d 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -154,11 +154,8 @@ static void drm_crtc_crc_fini(struct drm_crtc *crtc)
 #endif
 }
 
-static const struct dma_fence_ops drm_crtc_fence_ops;
-
 static struct drm_crtc *fence_to_crtc(struct dma_fence *fence)
 {
-	BUG_ON(rcu_access_pointer(fence->ops) != &drm_crtc_fence_ops);
 	return container_of(fence->extern_lock, struct drm_crtc, fence_lock);
 }
 

-- 
2.55.0.229.g6434b31f56-goog


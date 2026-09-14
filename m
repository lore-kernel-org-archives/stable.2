Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0EF311968
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789351819; cv=none; b=iV/5XbULVzAcOTNIB3DvqNA31I1LMA52tlU/OiUjEfVOIZIN8L/Wp48yPj57T3M6LGqTxE4N/X+04qg6pN1TCNVpZ+uKfiJigx59sZXhfRl4Lr5z2iVVTTJqyWAaRhKUgB18hPwRXKqKadStFSO+4chwdYAuVdpb3bZjS5ahxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789351819; c=relaxed/simple;
	bh=9Yo6q3xRbzehVoYANIYWHpMZD6dLjaFxkE9BuO/bq+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jqj63KsE9UJMjJLkjsCYMovjM1yZmk8zyYsiEMw1ZLvEpZALmQIeI0ssdK3yYSnFxiEbV0TDVqFqIdUS/8nHo8smhjI6zYFFle054qmIzXHR93pW8vzuJU66pEvIa8VByfhe5KMjjBecuzFLBAbfSkPToqzfIsib9R10hTALahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IizFMY7H; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IizFMY7H"
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-448a12ddfb4so1329942fac.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789351816; x=1789956616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ens4tvOvZUZ2shdZ+y3dfNiHm8kjjJbg0o+rL2d/6o=;
        b=IizFMY7HDN0B/1QgLywToSaQHiZJO2JaS4TjhwMgygCbXEKUJJYxElpAQPh+M7gJiS
         hJjqvhS8hh6PUDBK8eUQXNv0XAcwA2df1/UmFCUAOAdZ8ZuAxdn+Z9MQEd7cjHuKxP9B
         /0+pVtJH127m0SIWyQ0Qxt1/NI7CsaVMUysRzenqndHjPoYMnZ1QckeeCqp7tm8xuhRS
         aycoChCdY9yloEa12prCaebfua+sRUH52I+q6J6NJB5yRBm32LqLFu3LawdkNPHmA8p7
         XmNDr3MQCLlW30uW6VQkJJIGJbg19/HXMkrGriv1jFtCg0ZgCb+97aHN0X2wf6GAQ5Jj
         iKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789351816; x=1789956616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ens4tvOvZUZ2shdZ+y3dfNiHm8kjjJbg0o+rL2d/6o=;
        b=rUsrcOUv9pZZqXhckWxGlhSCskNXfr+ZfuFGieaVkDtdOR6fJmx+sEgJAGqhH9E3J4
         ESp0+ozfT8GAoE8hsZ7vKKY1FiT5d7AljvpRvjWI4mHXjy4yLCMHnHkke4F691PoIx+K
         7bAJZvqTri5WzR9qDnweJzOvMr42QFCwuumUVVZREMMwXBR9TuzZQBqkRDVrNiP1VOkH
         WQGaDzMXjUgX06Fzs0GI8aF8zC+aXjyt20dSsp5Xjyh2dU7KDMcEi7Gp+f1oP5SC10NT
         wqH7LaFWLVBhlo9YfFcFSrG/dEwSiSxIgnQyIPKvAmx19MhdgqsvB8TqFvfejlngQRym
         5frQ==
X-Forwarded-Encrypted: i=1; AKwUvBzkjHQSieBSN2xBqqZPhRKsctg/OmToD83+FJG3tKPJFZNQtIxhXrc2ZBDLDAEKgQ/QyR4dPtM=@vger.kernel.org
X-Gm-Message-State: AFuF++kACl+RiT73zL0DmzqMiCOUaatAaSsGxy2P4/UXPO4aTBHMW+2n
	i70gbz5kc2aKvuxG6err/V/yoUWgM11CikuByLihKROcjMHLbsTtyd3k
X-Gm-Gg: AYBFou11vMS2m7t1ubbBGAHAhJPw87RgeOHVTllXT58lyrlSJck1TIbTqMQBWicyeUH
	dQcc6ZOubT8ErZ70O5mvfKCbXAqs4M71xFTUe/mXH+hlMdnszPdPNAn52YpRQ3wg0vvaSFOlg+T
	xNrN/JnHK7B+lbR0nmg7b34CEqkz9OJSWRUmF6H0jKY5Z6M7cnIshKu0m0PGn8BZost95IvF7cs
	3YyYR03dTushg/Cliqv+q6M72RpFeUv6cMhKuZ/CqWN2uZL3kEYkECKXMUX7wMnu/WHSh68lOfB
	Nd0EB9F37P3L95IuBJxI9GbFWUHWEqNCdgYV2wO38sjKNuJwciowOpOOi81yfGDWw/GTsHlHdJW
	5VZbZJAwMTRfBSuUGuNf7IbyZ90Zqxl5DJJFR2RGAE24zx7W1VKAKZH7Uu6TCxPgxE67ValTVRZ
	RlAJAwCGkwY+WOkMQ9GQ+KssNPThQfIW2z979mEz1wUrw62fyYm6CWSMd+H4u12IXpn5k=
X-Received: by 2002:a05:6830:2a86:b0:7f8:4ebe:2854 with SMTP id 46e09a7af769-8089759c582mr369256a34.4.1789351816652;
        Sun, 13 Sep 2026 19:10:16 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f5ffd82bsm9788713a34.11.2026.09.13.19.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 19:10:14 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 13 Sep 2026 21:09:54 -0500
Subject: [PATCH v3 3/4] drm/imagination: stop the watchdog before tearing
 the device down
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-3-674b907d0652@gmail.com>
References: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
In-Reply-To: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789351801; l=2128;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=9Yo6q3xRbzehVoYANIYWHpMZD6dLjaFxkE9BuO/bq+o=;
 b=rNNUnHpmGFQsgkJLLWq00R5uggWAjk/JjRny6l6FmNcxSrvItWpKCt0tt45OW+Nttk7zpXs9V
 CL+mYayaXpQCG8DD49sK5/ANbS97EdXH8RzYP1gZE0ybzlmJMLQpnO0
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

pvr_remove() runs pvr_watchdog_fini() after pvr_device_fini(), so the
watchdog work can still be queued while pvr_fw_fini() unmaps the
fwif_osdata it reads. The pm_runtime_suspend() earlier in remove
normally cancels the work on its way through pvr_power_fw_disable(), but
it returns -EAGAIN without calling the callback when the usage count is
raised, and -EINVAL when the device is in runtime_error, and then
nothing has cancelled the watchdog since the last pvr_power_fw_enable():

  echo on > /sys/devices/platform/soc/13000000.gpu/power/control
  echo 13000000.gpu > /sys/bus/platform/drivers/powervr/unbind

The worker fires within 500ms of the free and reads freed memory.

Cancel it first, before the unplug: the worker is one of the callers of
pvr_device_lost(), so waiting for it here also means the pvr_dev->lost
test that guards the unplug cannot race it.

Fixes: 727538a4bbff ("drm/imagination: Implement power management")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index fc92a82a7208..20b27a468327 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1469,6 +1469,9 @@ static void pvr_remove(struct platform_device *plat_dev)
 	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
 
+	/* Stop the watchdog before anything it reads is freed. */
+	pvr_watchdog_fini(pvr_dev);
+
 	/*
 	 * Unplug before freeing anything, so no ioctl is still inside
 	 * drm_dev_enter(). pvr_device_lost() may already have done it, and
@@ -1486,7 +1489,6 @@ static void pvr_remove(struct platform_device *plat_dev)
 	xa_destroy(&pvr_dev->free_list_ids);
 
 	pvr_device_fini(pvr_dev);
-	pvr_watchdog_fini(pvr_dev);
 	pvr_queue_device_fini(pvr_dev);
 	pvr_context_device_fini(pvr_dev);
 	pvr_power_domains_fini(pvr_dev);

-- 
2.55.0


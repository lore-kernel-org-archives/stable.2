Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17028400967
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407756; cv=none; b=tZmr+uvy+VEsv4cLA1VyDzqR/WW2O244bgCAnfAlKor/EUodXGHdYHgXyJKH+KQ9HfxD2RZfb/LYt0xHJ+xpCDhzZ7IzuHkFS2VpxFHv+EMjIA8pnGBESyPkeYSYmE5YGQmPAKckJ7+wO8Kc+RaMu533H4K5CmGsyaequK3SAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407756; c=relaxed/simple;
	bh=r0raIDOSW17CYITUQZE9QsucbRWZGq3BFAKaOnaT8tU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4rLILKWA70NaM43qlafFCk6UCQN+dw1LNJaJdqQVemae1G8EGdpOpreDTgGgLDqnmVX7D4HU4lSwmguLbDqJsQmpfL/1eHz1NwqmWYucQBzSssDfUp0bv5hHN2JAfQwd5Ot1GIJJ8pJqfxfYjTibXbLybwz95SD2fyvAReLr+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxBzzepw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxBzzepw"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cad85b7b5aso1834895ad.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 03:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785407754; x=1786012554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sHxSCxHA6CRR2S+Pj+AQgpaHzJeXKMKhiOowZI1U4SU=;
        b=DxBzzepwp4lwNvY1bmkJeFQudlzqlXb78PtOmL70vInV+KoNfjmqWpvVmFHgTiZbkO
         pAbosZk9g1kp7CibwYRn/CIGPimdZswwgq7122bWo/x/hyWk0VnvSgxKE3UZtGCYIlDD
         hyMD/iLH/dXr6YrYlQFjOA47kQoq1HagrgF/38lMjklt25sQQbBJdpErQ8XLpIQPiqrB
         llHKGeCQtYY3V/PVn1BYZPoT6GFqJ4X91sitJ3rXTAlTJFbv80SnoGA/2s29xqk8vyU8
         ZXMpgnrxw+zuPlHTcfSCTkovCKQQKQrOnNTVOd1gQ/5Q9k0byCxrIgfFnSjINUHlNTtN
         b8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785407754; x=1786012554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sHxSCxHA6CRR2S+Pj+AQgpaHzJeXKMKhiOowZI1U4SU=;
        b=KZOUCOQoqtI8JicjwL2qCKpWfa9uyPCBzgREBWR+gmDs5hX+l4s02UsrL+OyIK0Po1
         reFSch65d1In312PpZY205EVzUw5ZzBtXlqk34fZvH87BNPsrB3u7wmNaYqvGQJS6+rf
         WqayKwgDVi+kmzW0uKv1Soulg+MrLQWJA6QaPTWq6xxG4XBLd8kLBUGXhwah5MKLzLvP
         C6dix0mQLBrtewa9KFOeP+UFWKBRLXxmgas6SNm4ysDcoveMSh0PWI5AKmq7uexqjQVv
         ucNzKAZwBwIXLf6MYCFxKH6gwRvd1fi/XTSyx2NdpCkNT/UzFpF2CCoKrc1IdiId+DWD
         5FYA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5+m7xrRRUM+sSVSdz7xOQJr4sTdAHMi+ZN9dHPP8135w6rMUmB/xPPerg1rb9YXnYrRXeZg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqkLaQi/8QUpOnfAVGHu6GfnVmnwNqCa6pn9aN6dpeYBFYzbp
	rx4KptuQBnsUwkIs6E1L1C/g1D/Z/sdcoiUlB6cUGijsTORVZ/uBMh87
X-Gm-Gg: AR+sD13wpy5NjY7fpv/m2Xd4h5Vg0MkwgXDM42csgwo78HV2Oib7kd2JYq59ndtcc/Y
	rL/268XNME5HPvqCZEKkDd1ajSccm3g1KPI2VbkMTONRmJANSJEDehRxIMPVlHte/LKAtfgkcfa
	iMD500D0qICPlUMeY4qpWLgPCkGEaZ2ATN+IUiqpGFVFMgM8wZv4v8Z7v/+qbP4EWQkf/uLzA7H
	VvlsFyBLce6Zpsf7DqNjzh1pif7WMjjA/E2OAPtEjKTCwZDT3on8PnVOv140d0eETKOwXVMfgsy
	D6DstqRvPzL7l4YXxg2Xy1sdCgMn70VU3WLa0fsuJJivQPf3tHF9FOWubFMWFv6BwqSe3DRIRMe
	XhnFzK35ymkMovYmuYAH2msbgSnPGP3Tnz9ujtsxyuQQVPwsWlEpYTakTu4ZJHW077PFL0DxgXn
	ZRBuBsxjcRFoBBR4cUIoNlGmYbG38dFzA+CK8koQ5h3g21nl0pjB+NZrdvQQ+UIryceJCMDLtze
	a+qSXz1R437nUreg7yg4nq1U6gFHUD+sd+qU2GmwwPcqtPZXMeIxEwvEF9K9lvdHg==
X-Received: by 2002:a17:903:1211:b0:2c9:fbde:ab68 with SMTP id d9443c01a7336-2d035cdecabmr28046445ad.3.1785407754242;
        Thu, 30 Jul 2026 03:35:54 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc63fesm18235788eec.15.2026.07.30.03.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 03:35:53 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfrm: serialize state GC with device state flush
Date: Thu, 30 Jul 2026 18:35:43 +0800
Message-ID: <20260730103543.2077749-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The deferred-device pass in xfrm_dev_state_flush() finds states under
xfrm_state_dev_gc_lock, but drops the lock before calling
xfrm_dev_state_free() because the driver callback may sleep.  The device
GC list does not hold an xfrm_state reference, so the state GC worker can
destroy the same state concurrently.

The race can proceed as follows:

  CPU 0                               CPU 1
  find x on the device GC list
  drop xfrm_state_dev_gc_lock
  read x->xso.dev
                                      xfrm_state_gc_destroy(x)
                                      xfrm_dev_state_free(x)
                                      xfrm_state_free(x)
  continue xfrm_dev_state_free(x)

Both paths can invoke the driver callback and drop the device reference.
CPU 0 can also access the xfrm_state after CPU 1 has freed it.

KASAN reported:

  BUG: KASAN: slab-use-after-free in xfrm_dev_state_free+0x24c/0x2a0
  Read of size 8 at addr ffff88810bbaa960 by task poc/102

  Call Trace:
   xfrm_dev_state_free+0x24c/0x2a0
   xfrm_dev_state_flush+0x353/0x400
   xfrm_dev_event+0x26d/0x3a0
   notifier_call_chain+0xc0/0x280
   __dev_notify_flags+0x169/0x250
   netif_change_flags+0xe7/0x160
   dev_change_flags+0x96/0x220
   devinet_ioctl+0x7f4/0x1880

  Allocated by task 87:
   xfrm_state_alloc+0x1e/0x5c0
   xfrm_add_sa+0xe7f/0x5820
   xfrm_user_rcv_msg+0x4f3/0x940

  Freed by task 57:
   kmem_cache_free+0xcb/0x3d0
   xfrm_state_gc_task+0x4a8/0x650
   process_one_work+0x63a/0x1070

Serialize xfrm_state destruction against the deferred-device pass with a
mutex.  Keep xfrm_state_dev_gc_lock limited to list operations and retain
the existing callback and device-reference release ordering.

Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/xfrm/xfrm_state.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 36a4f6793ede..de097bba803b 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -226,6 +226,7 @@ static struct xfrm_state_afinfo __rcu *xfrm_state_afinfo[NPROTO];
 
 static DEFINE_SPINLOCK(xfrm_state_gc_lock);
 static DEFINE_SPINLOCK(xfrm_state_dev_gc_lock);
+static DEFINE_MUTEX(xfrm_state_gc_mutex);
 
 int __xfrm_state_delete(struct xfrm_state *x);
 
@@ -632,8 +633,10 @@ static void xfrm_state_gc_task(struct work_struct *work)
 
 	synchronize_rcu();
 
+	mutex_lock(&xfrm_state_gc_mutex);
 	hlist_for_each_entry_safe(x, tmp, &gc_list, gclist)
 		xfrm_state_gc_destroy(x);
+	mutex_unlock(&xfrm_state_gc_mutex);
 }
 
 static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
@@ -1000,6 +1003,7 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 out:
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
+	mutex_lock(&xfrm_state_gc_mutex);
 	spin_lock_bh(&xfrm_state_dev_gc_lock);
 restart_gc:
 	hlist_for_each_entry_safe(x, tmp, &xfrm_state_dev_gc_list, dev_gclist) {
@@ -1014,6 +1018,7 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 
 	}
 	spin_unlock_bh(&xfrm_state_dev_gc_lock);
+	mutex_unlock(&xfrm_state_gc_mutex);
 
 	xfrm_flush_gc();
 
-- 
2.43.0


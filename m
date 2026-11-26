Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700545;
	b=OoLB9bars0DzTdYevOK+bVtrCXmID2ArngZRW9Nx153wG2pHa5tRKy1ysaY8BqhMocrw
	 XIxsiGd9Jv8K/K0pzMNFs9j0Hp2U2XLNL+YBtXgEkHDbb37VfRPRHjlsXEWuIf8li+Adn
	 c6ZgJrEE/0l0JDxNlrUlYsZvwY5IQcBLammgCqVyXZKNcPBRHSCALbCxVabJQVlF04T5+
	 pfOv5wCzvDkCWtkYBjKXywkhtjLgjlk+1rpRCiNsRjql3HfC7emdEO3rEsdEmE7BMcChd
	 wgdlJML/2RpQXfPT/jhnISQMqTZmoKRGbrxf84VawIgJfRly1jv8URsbXMrzWAk8t+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NSvDUdhiPsT9wujlLJTCQMGtMq3JsdUlTo3B/+Qtxs8=;
	b=HZsfM/OyTQsXUgBrc4W0kdptI7LzPN5RTAMXniYRXsYL5rjYSrz3AqQe9rw/W+1DAYvK
	 bTP7JThevo73kRqwinYCGvuVdAlJkWsVadpmC56lRiyas6580nKiRINIeNGmDqkciFmrK
	 7UOhcLxWeksPsoVyjLBFJ31q7hggHNiBKH96vM+56p2ZF8tWnR2JC2V3yOqYh5C4lVT2d
	 YztDGhPqCWkAd+akY6x56EJjeC3JuREeHm/E3uFzDhfDQE1FA+5OuhhgrAgZ5Ngm/uvDP
	 /xNiYbVXbsBjw7NeGrkUuL8eUd1FFpnh/WWvUnV8b2GtfcdPs6m9lKMqOTocv7LDV6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FCUZiapw;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BA5606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73BA5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FCUZiapw
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f05b465cd1so38615635ad.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795700545; x=1796305345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NSvDUdhiPsT9wujlLJTCQMGtMq3JsdUlTo3B/+Qtxs8=;
        b=FCUZiapwgCV0NccPRLyMCz4v4T3XpjsQ58JWuphME0mUW8OpcSdTyNG/jVc3LUuJeG
         dH79/1sR2huCmlp+7eUAAg2rfvZPvZhtpYVZq/9ug5QRHVjg55ZnJBko7FkuNdIPVMhF
         HOa+dPa/fmrCXJadGANy2s7Dqjo63MxwR6elwkxJhc9fCc3oSoeJ4GYWWFm5qeB5aGCn
         Bqb0sm1NQXR+/7/3wmYqvv8ZAbJYkeDivTZZdTQIArstf2JiPgIzwQ/RYXq7CQPGg+mh
         jgAD0iMRtkuetLcq3g0OpUqK0Bl8yfGXCF5bnJuiXiN+mr8eFBNeJEyQE/0Vr6uilDae
         pYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795700545; x=1796305345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NSvDUdhiPsT9wujlLJTCQMGtMq3JsdUlTo3B/+Qtxs8=;
        b=n75YMRZ/MtBVkRzEOt6znhStCxgEHkJzp5QSWxVkbTTfxR80ebaeSIKim+u/I9PFfG
         KoGZXXXigS+dxHvLgzWJrhxxlDqzjBnw9iTZyQeZLxAyF40eT4l7c7cv0hxvpks0PZp8
         ikkAnQYCSmnIAmtIMdCXa9CSDdfeIanKkznLZBP+zSOs+AGgeYBatupOmABF/VQkYlrH
         fPyYb1nYkJbPc9nqjVvYEx4LXv81gmrJx0REfluAbBxCSm5AdGTKtCby7ffrJcJ6+9L7
         tluPOhoWvndshJxKs/Q9Yn5IhO6d5ZKqIERYrdHrnaTZwGtZFUGN12+gPsNO8CuJe8qX
         RQOA==
X-Forwarded-Encrypted: i=1; AL+hErFaN4XGwign/Jvoed1gSxhVkuRL8zNsDomGDX1EhxcwBSwIt2KQymtprxlI4B5r0tesan8QjgY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/in9ltdm5/O168wWFJvf82eINNPDOsNH+F65SdKGIWwulPTH3P
	15NZlSTsZIYxJ68T5JzvTStRDmxSicJmsG142Aiq/dk2P05QmLtg36I=
X-Gm-Gg: AZFdTZfs6qtM/Mie3kBxo6OXuGLIQmMis3ZUAyo5GixPbPHiMLef1YiTnurvr4saVIw
	LvTDmbkcbAVQMWGyCclbeKie0tnBGdqO3w+u8ynNcJMthZabH/Ssw38PsI7Um5LbK7ACXO7/Yk3
	T8jp7Jsrg4vWXjPEsWKPLj6mn9K47bZsAW1Kuj2C4q5RlMHB/oYmKSPUhKeyACdcezNeVAwrlJd
	0VBbWmX4SvvMC2ssmKdjgEM16v5UR5EJHnjlikus0PKhfphgoDftk7+aZRcX55KqWT8kLU2aXh9
	Xsfa9exq8Q56nha44Gh3XrOM0Mbt2FiAlXepPcDMvK40LjufSZN/oSm/3YLK+aUS6+XMssRStKM
	26aYJ/K6ctb0cSn2hRXa6UtWA7PORWz74iKvu/Q94IjzM5gdH/dkcpUSBVxn//hYKPZgNboiKfn
	iV+tjtULCzPVnvrCJ9NY3d/xD5uUTg/mvZf9vwGY+HN6t3GRIJVZ2hQdAfV/Pcfs7sLDSW6ablq
	t50oG8IgFdWCS583tkVUwPxbsVqKePtKaFgfoRiC3Ua6q8LniBOvHVBRYsX0yvNUIuD7+P7mWxZ
	pGJiPy1Sg5eKhthxRJM3hOPRgumlJG8Lhfj8Ko7oizLCaOvuNqbcB3FdTbzs8qqaGaY=
X-Received: by 2002:a17:902:e551:b0:2ed:ff4a:6d21 with SMTP id d9443c01a7336-2f03f1beef6mr206550255ad.73.1795700544707;
        Thu, 26 Nov 2026 05:42:24 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a06e:23f:85ed:4cfe])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84294sm102467265ad.9.2026.11.26.05.42.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 05:42:24 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Chas Williams <3chas3@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net] atm: Fix atm_dev reference leak on VCC close for built-in drivers
Date: Thu, 26 Nov 2026 21:42:16 +0800
Message-ID: <rc-b1-20261110-vc-164-2a437f3c5ecd@gmail.com>
X-Mailer: git-send-email 2.50.1
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

vcc_connect() takes a reference on the atm_dev, and __vcc_connect()
stores the device in vcc->dev together with a reference on
dev->ops->owner. vcc_destroy_socket() drops both only when
dev->ops->owner is non-NULL. usbatm and solos-pci set .owner to
THIS_MODULE, which is NULL when they are built in, so in that
configuration every connected PVC leaks one atm_dev reference on close.
After atm_dev_deregister() the count then never reaches zero, so
->dev_close() is not called and the atm_dev, and for usbatm the driver
instance, are never freed.

The owner check was added so that static meta devices such as
lecatm_dev and sigd_dev, which were attached without a reference, were
not put. The last of them was removed by commit aa582dc25ace ("atm:
remove SVC socket support and the signaling daemon interface"), and
__vcc_connect() is now the only place that sets vcc->dev, always with a
reference held. Drop the reference whenever vcc->dev is set.
module_put(NULL) is a no-op, so modular drivers still get exactly one
module_put() and one atm_dev_put() per close.

Kernels before 7.2 still have the meta devices, so a backport there
must keep skipping atm_dev_put() for them.

Fixes: 93a2014afbac ("atm: fix a UAF in lec_arp_clear_vccs()")
Cc: stable@vger.kernel.org # 7.2.x
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, defconfig + CONFIG_COMPILE_TEST=y, CONFIG_ATM=y (net/atm/common.o; no new warnings vs base).
Runtime-tested in QEMU (arm64 virt, KASAN, kmemleak) on a model: a test module that registers an atm_dev with ops->owner == NULL stands in for a built-in driver. Before the patch each connect/close cycle leaves one more reference and the device is never released after deregistration; after it the count returns to 1 and the device is released. A device with ops->owner == THIS_MODULE sees no double put. No hardware test.
Triggered by close() of a PF_ATMPVC socket that was connected to a usbatm or solos-pci device built into the kernel; the leak shows once the device is removed.

Stable is limited to 7.2.x because before aa582dc25ace (v7.2-rc1) the static meta devices still reach vcc_destroy_socket() without a reference, and this change would put them.
A real built-in usbatm or solos device (USB unplug) was not tested.

 net/atm/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/atm/common.c b/net/atm/common.c
index 8119572..f68bf8d 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -184,7 +184,7 @@ static void vcc_destroy_socket(struct sock *sk)
 		kfree_skb(skb);
 	}
 
-	if (vcc->dev && vcc->dev->ops->owner) {
+	if (vcc->dev) {
 		module_put(vcc->dev->ops->owner);
 		atm_dev_put(vcc->dev);
 	}


base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47

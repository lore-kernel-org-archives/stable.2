Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879247;
	b=VSPh5oQcbwvWA7R8aWxrPUz1Esd2z26Dn0AloWPt/K9zyVzMIUQ5g1XDK8I7+wSG7P+V
	 wAF8mC2fsNeePLODrRQyixVWPZoecWUHDC3QKHMG5AMUK4BYFq5wzoaU7zq2MyRr8DH7Q
	 z4Z1j5J+WQpHBLziT00q24WOktAqeHp+xI8cx6uXMmM9tbjiH5rUxO/pt7jnIdEUnuVXt
	 I13VE1MH4DAdyAbaKIP2s6E0QY1pW3fqyQt0Fxh9qMVZV2LCaGb2zLFg1mKXr0wSAVuJD
	 2UrPKbE+rb9rFrYFFjORokgjCShMB+LpxDi/dYsalWKNmc8fCfxDT+2kg6c1vVQ6SeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gvWI/tdBBMelOS87owt2y2j7vRTweXagYLYewMb7XOg=;
	b=g9YwS7hFjU/r2YsgSI+RioWKGrHb9iR097BHAXqwK0Cxqfg8G1OObWOBpghUy7kmYGLt
	 edxbOnHP8lktCW0zKoladBppMo/JielGFexp+OErD3M6rMdtHaKuMNj+aWEnydn3tgrTX
	 KGe5+EDXf5j5r6tiBeCHDg6iB2TVrhWWk7J1dQh+OudJTt5d8WDTuqf1WQVu9yXfxkXpk
	 yKokeC3coATKY+fxFR5f3MMwzuCuMCncCrc5wHLNQhhazJ/4AaeubAdRU83GUkjiGYbyn
	 vo1LVv9LPrCFdctDnYijqR/a/xHLuYchyR2b9x3N3weapibRwMx7pnJXolmWSTuWbTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eWeVK3LF;
	arc=none smtp.remote-ip=74.125.231.138
Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A5606A33C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 11:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 538A5606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eWeVK3LF
Received: by mail-oo2-f10.google.com with SMTP id 46e09a7af769-820ff812cd8so372557a34.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 03:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793879246; x=1794484046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvWI/tdBBMelOS87owt2y2j7vRTweXagYLYewMb7XOg=;
        b=eWeVK3LFJ67QiftlI+LA5YLEgkdaFNdTRJZrztVnh6C7RDAo44BhSxcxj4Uq3UsVcK
         4mVxBxvQCy3s0aIt8tSYBTsEhlnYRW97lokXN7VOYA/M/cLhyBdK0WSjPJyAYJw9hHqr
         VEzntUbo/Q2l2o3PS3Mkl5Pt3EG1eWo/X+BQxdThJaFnuAAVRVw/Xl7uQbJqWf+v39kZ
         inOg1mTIR7wUCJ5i7bOFm1eOlgDUVGyaAzmamPKknll6xyyjeosf80xSo69Xq0Yq8sIi
         zh62ZvvUlz7uWy2pic/AEW5PKX1UjCevVXfPBkfn2oVmiGmBoTS4v0c1r7bbaxb9ReRy
         02fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879246; x=1794484046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvWI/tdBBMelOS87owt2y2j7vRTweXagYLYewMb7XOg=;
        b=ZjZue1zY8h4D3+pcn1Jm/4WS+gXOAefyhbppAtqQagPmBtBdFA2vBA1tO59c4LEgOv
         DqlhSupfIdQzJ9aOs3AyII3ZbPvmR2gm0JNZf0G/gCnlHjwaRjvChjqTHqnHLhykGhzG
         zRrBAnUrkEt0+Jop1nALfiorlmkYt8YCgnx0LchJsCWFSvQnkxNRdhHy3dsMqYGNdXHL
         jOfN0DWyKYPoASRBCFB7qWYLFuVPECMEXPMILkZKGoRKSQitxg/CldVcdZ4NEl8rjbpm
         JuxiOHr5CleW0MOwCPUjaBm1LuSTGDvy5ia/c15yOHN9edOkYFuZaC7e0/18bVlga/15
         yFKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOdrwxzOMtWHHKbi7KaXMtiIYhcgICskS3g1HhfV7na5ZLfKPWSWLom/RnG7gzWdS45K92Ebg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Pba9qwmeNkKC/mNZuvXFI4lMlzDdYRN6e9tYizcXBh55fv+BR
	2WEsGP4nFKuURcgOj+3eHlAqCENvoKLa6Uk8/g9bKNJXYElssHhDKYS5
X-Gm-Gg: AYBFou1LTHH3IF8Pik8C1iQpjYeSLNeNwlZI7ZRg0gUgcP6ybVqWEi0IwLHUs3ULu9x
	l0qwxsG9hqeCu1XIgt+qzVu5F+wSnMlrt87uzMAuUjOVqBDAesGT31AFiXX+e7bs4vcTwYE0j/t
	wt14kLQ+xsQWGt7mdh8JHPj2V36Da7jI+/ObrpsvQmxX3ZfVg7JwT1/Vl+YLJ2vo9b3oladGwX6
	kCtOqVQ9z8jxbuo20Q4Vlrc/hjsvNdYbo0UwVXyhkMyXeegRNcdKYa6qbCZC+G5BE5sv1+wCoog
	sskczBVM0HGLiqLwe2yjHcnrVmIkxq0PC2DOiciiVkq+F0+WcQIsAjAHlVgCf3YhEFBAf0qd5+y
	Vu5agFk7XToYcOsPMveliyP2gBEJRfhG44Y1745S87JcL1v+xxTq5303FLWOJ4rBuBFVkuGTI2g
	pPeTIKmFMIxL4n9g+4yZZeE/FNo7399Of2ZEyVMeU//KCIHFoM0W2d+8wUS36HvxJ8FsqYcA+2G
	AYyHmQrvMf1FBw9l41rOClq0/E4+opB8s0n3LVwBipGXi+d1zhtiFkyClpWKlgX4GRpo3o6PfSp
	qEYsQwYjf5+aLAN3tX4I0Zbl6yu67MOcs67nbflJMHN05mk0Pz9FgxGt0E20G0CEvhjW
X-Received: by 2002:a05:6830:719f:b0:83b:3feb:4f04 with SMTP id 46e09a7af769-85d36298d84mr14347881a34.4.1793879246149;
        Thu, 05 Nov 2026 03:47:26 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.33])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef37dc277sm4735727a34.0.2026.11.05.03.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:47:24 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	namangulati@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] nexthop: fix null-deref in nexthop_flush_dev on UNREGISTER rebroadcast
Date: Thu,  5 Nov 2026 19:47:07 +0800
Message-ID: <20261105114707.3030737-1-bsdhenrymartin@gmail.com>
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

A device unregistered outside its netns teardown can be stuck in
netdev_wait_allrefs_any() while the pernet exit handlers of its
netns run to completion.  nexthop_net_exit() frees devhash and
sets it to NULL.  The rebroadcasts then hit nexthop_flush_dev(),
which dereferences the NULL pointer, e.g. on mainline v7.4-rc1
(KASAN build):

    Oops: general protection fault, probably for non-canonical
    address 0xdffffc0000000004: 0000 [#1] SMP KASAN NOPTI
    KASAN: null-ptr-deref in range [0x0000000000000020-0x27]
    RIP: 0010:nexthop_flush_dev+0xb8/0x240
    Call Trace:
     nh_netdev_event+0x250/0x330
     netdev_run_todo+0xaa2/0xef0
     rtnl_dellink+0x35f/0xa90

The faulting task holds RTNL, so the network stack is left wedged.

Skip the rebroadcasts, which are the only NETDEV_UNREGISTER events
delivered with reg_state == NETREG_UNREGISTERED.  This mirrors
commit fd0909e963ed8 ("netdev-genl: ignore NETDEV_UNREGISTER
rebroadcasts").

This issue was discovered by Tencent CodeBuddy Security.

Fixes: 8a4fc54b07d75 ("net: get rid of rtnl_lock_unregistering()")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/ipv4/nexthop.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 42e55b5a755ee..1eba7026abcae 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3996,7 +3996,16 @@ static int nh_netdev_event(struct notifier_block *this,
 
 	switch (event) {
 	case NETDEV_DOWN:
+		nexthop_flush_dev(dev, event);
+		break;
 	case NETDEV_UNREGISTER:
+		/* netdev_wait_allrefs_any() rebroadcasts NETDEV_UNREGISTER
+		 * while waiting for the last references to be dropped; the
+		 * netns and its nexthop pernet state may already be torn
+		 * down by then.
+		 */
+		if (READ_ONCE(dev->reg_state) == NETREG_UNREGISTERED)
+			break;
 		nexthop_flush_dev(dev, event);
 		break;
 	case NETDEV_CHANGE:
-- 
2.43.7


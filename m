Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4B3DD864
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929909; cv=none; b=s+iRpxYom/KTmwR8kY2bBvBFxKx7OjLczXiuIFsWAMVqvR280l0WBy8xwyFuAjgGOEPxnyjUCV8nzm+vRjXdAAWxW1KgtXh/dfWXSxpDKF5lLpy9AVJL5JpVYWVH4SHIMzyS1vx2XcdTxk60HpwDFEAYVMohtaUf3htQneADwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929909; c=relaxed/simple;
	bh=TtwzUePYBB0fe6C2btS90QFO48NdmxKYZXm6ZV8wtmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLF8efuR7j2qNhLuufP/DmkWNpG2sY/6OqfTedukFxqBeMyABY4v6GIkEG/c1c2btrXUk0dSjNzOFK35NQAW22e5EKouJ1m3wY4dPI4jzM9WRbzZNVOlh1rcDD8Ut3f+EcnmWlsMNwxgZXlGAF2W7baWJpBrz/W6e8AKCg/XbH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW57Hmdh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW57Hmdh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490a78b0c8fso3261355e9.3
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780929906; x=1781534706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cROChVtUMlBOZjOAs4b3kSSichf3rGSm2eer0rPlUJ0=;
        b=RW57HmdhlF+dYWsukrQJeZx4gykIArzl9T0Bq+uMKsLXV2gSa5sdGUq9qC2s3g0eF/
         UoYpvm02gBO4WLnsQnROElbLiUST6JFxB+HQD9mDWUgN3bfihFdEY8vBtGk4O65JAU3P
         BjARC3kqy6MIfkl6Wc1zZtZLBe+0zYJgQN1IwoeNDNJCz163FRmlua0Fc9OTghPrD1C2
         mgO9kMuDACE+faE3xM6hD+EH8NZO9RnDffwQIYxyRZLpv2ksO91+jSQsBbRPpAbbzOQr
         aapo1ZgS/msu9U3TWbANq0z6oTuWc7U0W5wnAwRlyhQogdoTaP9O3sVLnww1Vdwj7XN/
         QnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780929906; x=1781534706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cROChVtUMlBOZjOAs4b3kSSichf3rGSm2eer0rPlUJ0=;
        b=ON4d6cigtosIoPPn1Vecs+ISiW6ZffDbkcnpwbDMxknoxYEY5RN9nLP94mKO3243mT
         5tWSkV6PGX8ztGKlRLZxnvhFjwahiEkybpvneqCdY6ytWfTG5oAjDYFLYpkVJMV60c4N
         L2uCCMzuR0Ix7F7w0tkWFtjd2bF35bwaU0kKPyoBTdBbOPO2DiC8TqWNmcW97fsk64HX
         qYKV1QSKwfg2of6SIBZBpwgTxqHG/baQ3J0HQ9LS6hnkVvBJnMsgtmm3HoVg28jeV3KA
         oOnvC7hIl58vZ14ZfLXbc+pP48kGO6gjsdnl0mguRjNxtmTgfgB+I5YCNescvQ/r1X+1
         EHOw==
X-Forwarded-Encrypted: i=1; AFNElJ+PKHvZ68UcAoQU/CAcxuv2j3eSmPIO1IGhxY9G1h+OIv0dGE6MEEb8FiuqIzSLaTggjljVoQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlAKjEebzX57tx+MI5CFt7os5vBAr2+RZ7iwnCToHBP/+TCyCZ
	iXo9Pmu0fkls14YNhYFBGGYl+P/Yj0mp6ER6zV+1WXC61JFl2hTWwI25
X-Gm-Gg: Acq92OG++I5J2GwQZPpfgxuyVT3T/INmyASBa6D/IZMTGH9U6r0/8ijI8UFpdwQFiuJ
	PzeblEgM5/qHZcYWcDcedQ7OqXj9Lek5OjsbtjB5oV1vDJu4l4xRfswIaPP0vo/GHZOxGhdpx/O
	eY0e+FbTNpcURGJUf/k26XnkH53nkgblUmsSG+zKnoN0KT5j3ambIV8J42AcUM+4uiduw6oCTR2
	WKRqXHH7D0AZQuua7f544/ZWXpVMpIzDVry6u8/2tGZgttYroDzTgiJ8hFpT7cWtknYio69JZnb
	2tb2RtV5hmi4lroWTbMP8Ps1+afARxE7slipqeZmNQpJtiKeuTbexS8oIgQEaByal+GILZljXE6
	Ci8X7+euDo6yBQBb+Cx71MI1u1VK88UqwonapfNsxae32mqiCM15Aftucacq1XOagaE7c067Mxe
	DUdkTtNMT4npVIk3rVnDcOEheo3N9v2dkDoBUsQBy8IPShzKUhYK4eM7HlV+vMMlKPYRiaxUEAf
	dyJIeEwipjn4ipibQ==
X-Received: by 2002:a05:600c:a011:b0:488:7e7b:dbc2 with SMTP id 5b1f17b1804b1-490c25dcc9bmr112364045e9.3.1780929906001;
        Mon, 08 Jun 2026 07:45:06 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm409212995e9.6.2026.06.08.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:45:05 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Zijing Yin <yzjaurora@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: af_key: initialize alg_key_len for IPComp states
Date: Mon,  8 Jun 2026 07:44:41 -0700
Message-ID: <20260608144453.3553219-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pfkey_msg2xfrm_state() handles the IPComp (SADB_X_SATYPE_IPCOMP) case by
allocating x->calg and copying only the algorithm name:

	x->calg = kmalloc_obj(*x->calg);
	if (!x->calg) {
		err = -ENOMEM;
		goto out;
	}
	strcpy(x->calg->alg_name, a->name);
	x->props.calgo = sa->sadb_sa_encrypt;

Unlike the authentication (x->aalg) and encryption (x->ealg) branches of
the same function, the compression branch never initializes
calg->alg_key_len.  IPComp carries no key and the allocation only
reserves sizeof(struct xfrm_algo) (i.e. no room for a key), so the field
is left containing uninitialized slab data.

calg->alg_key_len is later used as a length by xfrm_algo_clone() when an
IPComp state is cloned during XFRM_MSG_MIGRATE:

	xfrm_state_migrate()
	  xfrm_state_clone_and_setup()
	    x->calg = xfrm_algo_clone(orig->calg);
	      kmemdup(orig, xfrm_alg_len(orig));

where xfrm_alg_len() returns sizeof(*alg) + (alg_key_len + 7) / 8.  With
a non-zero garbage alg_key_len, kmemdup() reads past the end of the
68-byte calg object.  Adding an IPComp SA via PF_KEY and then migrating
it triggers (net-next, KASAN, init_on_alloc=0):

  BUG: KASAN: slab-out-of-bounds in kmemdup_noprof+0x44/0x60
  Read of size 4164 at addr ff11000025a74980 by task diag2/9287
  CPU: 3 UID: 0 PID: 9287 Comm: diag2 7.1.0-rc6-g903db046d557 #1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x10e/0x1f0
   print_report+0xf7/0x600
   kasan_report+0xe4/0x120
   kasan_check_range+0x105/0x1b0
   __asan_memcpy+0x23/0x60
   kmemdup_noprof+0x44/0x60
   xfrm_state_migrate+0x70a/0x1da0
   xfrm_migrate+0x753/0x18a0
   xfrm_do_migrate+0xb47/0xf10
   xfrm_user_rcv_msg+0x411/0xb50
   netlink_rcv_skb+0x158/0x420
   xfrm_netlink_rcv+0x71/0x90
   netlink_unicast+0x584/0x850
   netlink_sendmsg+0x8b0/0xdc0
   ____sys_sendmsg+0x9f7/0xb90
   ___sys_sendmsg+0x134/0x1d0
   __sys_sendmsg+0x16d/0x220
   do_syscall_64+0x116/0x7d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  Allocated by task 9287:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0xaa/0xb0
   pfkey_add+0x2652/0x2ea0
   pfkey_process+0x6d0/0x830
   pfkey_sendmsg+0x42c/0x850
   __sys_sendto+0x461/0x4b0
   __x64_sys_sendto+0xe0/0x1c0
   do_syscall_64+0x116/0x7d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  The buggy address belongs to the object at ff11000025a74980
   which belongs to the cache kmalloc-96 of size 96
  The buggy address is located 0 bytes inside of
   allocated 68-byte region [ff11000025a74980, ff11000025a749c4)

Depending on the uninitialized value the same field can instead request
an oversized kmemdup() allocation and make the migration clone fail.

The XFRM netlink path is not affected: verify_one_alg() rejects an
XFRMA_ALG_COMP attribute shorter than xfrm_alg_len(), so a calg added via
XFRM_MSG_NEWSA is always self-consistent.

Initialize calg->alg_key_len to 0, matching the aalg/ealg branches.

Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")
Cc: stable@vger.kernel.org
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
v2:
 fix some typos. 

Link to v1: https://lore.kernel.org/all/20260607210119.2437752-1-yzjaurora@gmail.com/

 net/key/af_key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 9cffeef18..3216f897a 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1218,6 +1218,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 				goto out;
 			}
 			strcpy(x->calg->alg_name, a->name);
+			x->calg->alg_key_len = 0;
 			x->props.calgo = sa->sadb_sa_encrypt;
 		} else {
 			int keysize = 0;
-- 
2.43.0


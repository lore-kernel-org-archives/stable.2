Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629593EFFBA
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585021; cv=none; b=lbVcetvC9gjN3paTeFYtBFnyFkeyBrnB70vwy1wfpGF/kU4upK/cqoEGfEDCHmgp1KGlvwf6/hxOW07MMpHen3vXjidRmHG8KUuzOFNKEQMm+5zHUpOr8+vTTGknVO1prtk2ecvMlpeB6TEDbfu0Vdz3RiU2q647INtTDj3HBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585021; c=relaxed/simple;
	bh=hYw7cY7OvliXTsXG2DhqQQpoKZ04lNep+PHc/o1u//s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWjoYYsRLvgXIVvdvim0Dnff9CorlxlWcYqhXKD0udrzOWKrG1uKyfqg3pJ9VfUkTRKypcHT5KXlB+mAd36Lswb5Olg2u7T1O9bBppJ58sKRFPPekiMAsxRxFjf4A7rhRnTeDcbpkhRAy2gnBCXzG79L/X9ZKQTZc3C5TBPBR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8fz4OEx; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8fz4OEx"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-669bcef451aso395701d50.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787585019; x=1788189819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ApOsiVTZO2JtdB21Z6pP35hGptW3NA1WFLKYP2hHn7c=;
        b=e8fz4OExPhrQpoLn3q3MmA6nw/X+OJPmzd7JtS1SI8dGWdAkUGd1MS+XPWoQzbpfPd
         TaKn6cvR2BqqmNO7EsDF2WBZNCciq/QrdMMCjJaDxClAmYdFs1CtB9UeBrPBx6XPuCnk
         +Ray11mrTzbruMD9GLQwtCq5fIJKo7OBitNVYcWhsZkwu3P9jZ8dyPs6QcRyF+rSvboe
         FMF74xxUKlW9LADegKDY6wIzqkuFGxAZm9uyWJYNaSHcHhs2XW/pxF2SwwiwXt2cV8UL
         jIXKOtrNATNqKpq/qvCUOgzcesM1Vwn5SkiZrR9QBGUy0DNieH8YpIk0hKyPs5XAVFPC
         q8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585019; x=1788189819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ApOsiVTZO2JtdB21Z6pP35hGptW3NA1WFLKYP2hHn7c=;
        b=A6Nui5HnTLSKkXl/cOSlaVLo8ce1plTRYysQKJ0U23s0gCijFtZet9zrbnkTjGkqeP
         nJZbQQo10zsmFFNNZaUtg0FgXIwJQWD1tDOTx7j+i5LVUjbFb55epou2Tz2mLkSuDwR2
         4uW05ipZWDWrsMbLcPPHhFOzxxLQZlekCquf4WlsmjAXGAJ0BLdrhttAkMnkxbIT46G6
         Gtjb8At/j87acAgDl7/xSO9BLn84YPeVkwHigoElvjbZikkbjgxpAtAzBwBYKydKnvxp
         EbLjfacaspa/VsXaGlI3Tsvbkfp9qGpqm27tNZbinTW7LRoNWhiNPafZs//j0x1MURQV
         q6cA==
X-Forwarded-Encrypted: i=1; AHgh+RpcAsxOHeWoNti92mPw6iyOirBYdmj6QNRUzkAgfyxyIzTvJ3M/a2Lw7utI4a6FsPmdGbyPYrE=@vger.kernel.org
X-Gm-Message-State: AFuF++kMxGxArpk/4Ucjuk0586Jh1vyTj5ncbpl+VuGuXCcnLW9xPWYA
	sV9aDG5+nN/88q5S4W/G0TL8MOwTErAw0dfS1B+SSmFFG3UrHIVWmIm1
X-Gm-Gg: AR+sD11moE4g10Bf/jpReZk3wXnNbUfs6HTyrDOPD3b/RcBqmnzIjne6RCliL3pdU7N
	0F2ptqzQxG6gwUNVow5pMVxa4Iua7V7R41enqzW1S4u+p8/5DJDPO0T8HAeuMhzVJlRvZqx4lB5
	56gai9qlbn96LUzc65Ud2hDjd+VuNgYXMWlC68AA8MfIgsAZEjQazurWohOH3x5ZBB2mafX0cOG
	WHhTC7xvDfFSWXAuQey8vScOogDjbZ61HqtcpzjkX+Xl8s7WwjtsX6c+lI4XhDM2cFpPvkR8Gyt
	wlhwDWC1rNPwricX0p5HgNOyb5GuIlWM4vaWLHyuW93ciKTYe/VPbE4380L5ER59Hk9xVv7lcpP
	f5y/i0gQ5KzF7S8mBW8ifArhoXP6ujh6fBRYSDx9Z4ghfJeJabYx5TrRhGGtUGcMvUDRJhP01hl
	eRQZFFU7y0PAD/PqYbVP7SIGn4FNHOeUPV70cX6OPJefkEZFIdz98H1Q1nV2FmraxtgyI88Gevm
	yKZljSvyApb+VLMzczDyGY16CxrdtkRZ3fIHZs+Au150DROotUFqs2mbe3S
X-Received: by 2002:a05:690e:80d:10b0:66b:2964:eb0a with SMTP id 956f58d0204a3-66ce4ae6f92mr6238565d50.3.1787585019068;
        Mon, 24 Aug 2026 08:23:39 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cfb3671f5sm3062475d50.15.2026.08.24.08.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:23:38 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Qi Zhang <marsy12010123@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Florian Westphal <fw@strlen.de>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: pktgen: keep device lookup under RCU protection
Date: Mon, 24 Aug 2026 23:23:31 +0800
Message-ID: <20260824152331.216494-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pktgen_find_dev() releases its RCU read-side critical section before
returning pkt_dev. __pktgen_NN_threads() then sets removal_mark through
that unprotected pointer.

The worker can concurrently remove the device and queue it for RCU
freeing:

  CPU 0 (netdevice unregister)     CPU 1 (kpktgend)
  rcu_read_lock()
  find pkt_dev
  rcu_read_unlock()
                                   list_del_rcu(&pkt_dev->list)
                                   kfree_rcu(pkt_dev, rcu)
                                   RCU grace period ends
  pkt_dev->removal_mark = 1

The mutex held by CPU 0 does not cover the worker and does not delay an
RCU grace period, so the final write can access freed memory. KASAN
reported:

  BUG: KASAN: slab-use-after-free in __pktgen_NN_threads+0x241/0x280
  Write of size 4 at addr ffff88810dab804c
  Call Trace:
   __pktgen_NN_threads+0x241/0x280
   pktgen_device_event+0x24e/0x3d0
   unregister_netdevice_many_notify+0xde8/0x1ec0
   rtnl_dellink+0x35d/0xa90
  Allocated by task 92:
   __kasan_kmalloc+0x8f/0xa0
   pktgen_thread_write+0x498/0x14e0
  Freed by task 0:
   __kasan_slab_free+0x43/0x70
   rcu_core+0x50a/0x1850

Move the existing RCU read lock into the sole caller and release it only
after setting removal_mark. The object therefore remains alive through
the dereference, while lookup order and control handling remain
unchanged.

Fixes: 8788370a1d4b ("pktgen: RCU-ify "if_list" to remove lock in next_to_run()")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/core/pktgen.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 7f81aed46672..4fb1853589b3 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2032,14 +2032,17 @@ static struct pktgen_dev *__pktgen_NN_threads(const struct pktgen_net *pn,
 	bool exact = (remove == FIND);
 
 	list_for_each_entry(t, &pn->pktgen_threads, th_list) {
+		rcu_read_lock();
 		pkt_dev = pktgen_find_dev(t, ifname, exact);
 		if (pkt_dev) {
 			if (remove) {
 				pkt_dev->removal_mark = 1;
 				t->control |= T_REMDEV;
 			}
-			break;
 		}
+		rcu_read_unlock();
+		if (pkt_dev)
+			break;
 	}
 	return pkt_dev;
 }
@@ -3776,7 +3779,6 @@ static struct pktgen_dev *pktgen_find_dev(struct pktgen_thread *t,
 	struct pktgen_dev *p, *pkt_dev = NULL;
 	size_t len = strlen(ifname);
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(p, &t->if_list, list)
 		if (strncmp(p->odevname, ifname, len) == 0) {
 			if (p->odevname[len]) {
@@ -3787,7 +3789,6 @@ static struct pktgen_dev *pktgen_find_dev(struct pktgen_thread *t,
 			break;
 		}
 
-	rcu_read_unlock();
 	pr_debug("find_dev(%s) returning %p\n", ifname, pkt_dev);
 	return pkt_dev;
 }
-- 
2.43.0


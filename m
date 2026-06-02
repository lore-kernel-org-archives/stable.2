Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62F3F6603
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420606; cv=none; b=rnafU5Dbhs7ge8WyEL2GVfsRnWcwdy3RLSeE4gm/n+XljPxr5w67S+yKXK9N20HEFnaSE3hX5So+s7M5Qm4mP7S9c7k/gwLH6TzMV5KilZDMO2WcT81O7vnSi/SKMiXm/BJzw9lHw3NXYpQNc8isCoGeGW738nWak2+eVxLOvng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420606; c=relaxed/simple;
	bh=aChVinTtW06DYJMgsEjII6deRz2m7lW+ZvBbR/sgFp0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YwQkesUx+zJrDL/PLxMzNPu+lCMSvzhyM44VlutWq6F4UYxRPEUzCc+2mCf8vj2L6smkkYgJ/iQSkgQD1elZAJRg50wb35fXJtrW9dQqCH111NISklVZ7Tus3G6b83n/O7q4tepnEZmDiWLiexv2NybRuArNya3u1rrn8k/FfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/g2TYcQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/g2TYcQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4908b92904fso64317755e9.0
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780420603; x=1781025403; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gv92Sloivp2yvi05t2PfMcNMHYPgBL5QlmVi6nWQAxs=;
        b=C/g2TYcQ7E373WeF2fovbXhoO9+zp8KqKPOaF/ZYOs2ezuMYr0oKzHOC9mxGiJTGlV
         mfW6hLwOGcIcNirCEGrdtb3VEJT3dOB8wrm3/QOqe88ZwND826HLNoUK/hBAGSPKv4jR
         FItFrpXXdMz1QJoqI3YPuUKVXuBxbI3prf+dSrBSfttu18o6Lodr6xlG5XulDFTxFfqE
         4hxn6nBmBm+4BfoAGOuqpbk1hdK+JgeW/PoUKSRpWvQqwj5xV8+volXlqRtK/fYUnA75
         G1ZMuh87aCdgPf3galDntMv8MLZmIO2HfT+nmTr6iLumafkUiIpx/+E60M/qr/v9O9W7
         CsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420603; x=1781025403;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gv92Sloivp2yvi05t2PfMcNMHYPgBL5QlmVi6nWQAxs=;
        b=n1TKd3EEi2y8CvDyukoqXM3Xir821ralPITzsWfl7kZWAII3dDN2E5H/oFUXazuDx2
         ctTNxHmy8BgXctib69wVCkTby2/Kx7yjWyuIcbBy8bVpklQVbATSlBcwnZvnKyGnDT+c
         ymlHRGzo4Opwo6rqvXXlr9zjhfNfALRatSqwcJMABnvFSBtMlo+KZQRdQQPRpE/MXLvg
         JP6CtPfS0kGh4Mb/lvG86+JyXTyvDGHUmKsfgw8Q4f9bxJL0vTr0ppSd2mzt+/iMQVkB
         JwUGF38KVz+qSP3mv4zyZPEtBrwt9waFQ+HMjgEeRAxdHwQJLUXkqcOImXuZyepNHs7+
         kEVA==
X-Forwarded-Encrypted: i=1; AFNElJ9bYEzJ9Jzjfb2CYnYskZCWbcO13Jvbb0OA2PQ6p5kzCT9P9Mh3mu2ay5eNHyQ6tURt7B8XwGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxY9z09BWbx6RR+dbpRLcPFIP6xcrLfaqN7D42EO7Xy0UuNaZS
	MefeFKot+e+eL/eFgAoY5orm9wDN7xJk7SIl+N19mtAcTWAL9k2Svc8=
X-Gm-Gg: Acq92OGDVO2G+ppYJq7pa75YobnoT+I0VVCms571mGObSWHJECqzyfhXB86PlDIQ0QZ
	JC8idDQXlQS8HLkksqQhFdiIQtdKy94sYJuDISSUvsW9E99nVxu4rPiveRn8oSVHf33jW1i01XL
	avEw2O+cthb7ggigsR33Ie+d6ugkBh17QCw5o8VGGpKSG4JpDD7byg7SslMXli8mIe948A9nhF3
	6z+pYICQxkvPveThLRBJMPFvyfCutdXLB8ZWPfIRSEcHPwu0vN3ublSjZ+2UYfobVAIw7upoBkt
	P+zOGZsRn+9KQZbqL+bLc2uYg63AYQ9YLt9yi209OSF1iejbPCsxuyhSdf2xpXmTe/J/YyKcmv9
	K8RTb7/Jl7B5t5dlkcDKdD1BDmJV+3GBRxAQFz4r/9v1RqjZnEV0IkPVcbmPiVmh8lXI/RA9ymd
	cGAm0937oSQADVxw==
X-Received: by 2002:a05:600c:3f0d:b0:490:6e11:c303 with SMTP id 5b1f17b1804b1-490b50800dcmr11794235e9.13.1780420603115;
        Tue, 02 Jun 2026 10:16:43 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b575aaa4sm544745e9.3.2026.06.02.10.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:16:42 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, chopps@labn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] xfrm: iptfs: fix ABBA deadlock in iptfs_destroy_state()
Date: Tue, 02 Jun 2026 17:16:41 -0000
Message-ID: <178042060186.32887.17301018074622852112@talencesecurity.com>
In-Reply-To: <ah6rCd7up8i6173I@secunet.com>
References: <20260528160318.2631699-1-tristan@talencesecurity.com>
 <ah6rCd7up8i6173I@secunet.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Steffen,

You are right - the lock/unlock pair around the drop_timer cancel was
only needed to serialize with the timer callback, which hrtimer_cancel()
already handles. Since the xfrm state refcount has reached zero by the
time the destructor runs, no concurrent iptfs_input() can be accessing
drop_lock-protected state either. The empty lock/unlock is dead code.

v2 below removes it entirely.

---

From: Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] xfrm: iptfs: fix ABBA deadlock in iptfs_destroy_state()

iptfs_destroy_state() calls hrtimer_cancel() while holding a spinlock
that the timer callback also acquires, leading to an ABBA deadlock on
SMP systems.

For the output timer (iptfs_timer):
  - iptfs_destroy_state() holds x->lock, calls hrtimer_cancel()
  - iptfs_delay_timer() callback takes x->lock

For the drop timer (drop_timer):
  - iptfs_destroy_state() holds drop_lock, calls hrtimer_cancel()
  - iptfs_drop_timer() callback takes drop_lock

Both timers use HRTIMER_MODE_REL_SOFT, so their callbacks run in softirq
context.  When hrtimer_cancel() is called for a soft timer that is
currently executing on another CPU, hrtimer_cancel_wait_running() spins
on softirq_expiry_lock -- the same lock held by the softirq running the
callback.  If the callback is blocked waiting for the spinlock held by
the caller of hrtimer_cancel(), a circular dependency forms:

  CPU 0: holds lock_A -> waits for softirq_expiry_lock
  CPU 1: holds softirq_expiry_lock -> waits for lock_A

Fix by calling hrtimer_cancel() before acquiring the respective locks.
hrtimer_cancel() is safe to call without holding any lock and will wait
for any in-progress callback to complete.  For the output timer, the
lock is still acquired afterwards to drain the packet queue.  For the
drop timer, the lock/unlock pair is removed entirely since it only
existed to serialize with the timer callback, which hrtimer_cancel()
already guarantees.

Found by source code audit.

Fixes: 4b3faf610cc6 ("xfrm: iptfs: add new iptfs xfrm mode impl")
Cc: Christian Hopps <chopps@labn.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v2: remove the now-useless empty drop_lock/unlock pair (Steffen)
---
 net/xfrm/xfrm_iptfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 97bc979e55baf..82c52bbf25e1a 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2708,8 +2708,9 @@ static void iptfs_destroy_state(struct xfrm_state *x)
 	if (!xtfs)
 		return;
 
-	spin_lock_bh(&xtfs->x->lock);
 	hrtimer_cancel(&xtfs->iptfs_timer);
+
+	spin_lock_bh(&xtfs->x->lock);
 	__skb_queue_head_init(&list);
 	skb_queue_splice_init(&xtfs->queue, &list);
 	spin_unlock_bh(&xtfs->x->lock);
@@ -2717,9 +2718,7 @@ static void iptfs_destroy_state(struct xfrm_state *x)
 	while ((skb = __skb_dequeue(&list)))
 		kfree_skb(skb);
 
-	spin_lock_bh(&xtfs->drop_lock);
 	hrtimer_cancel(&xtfs->drop_timer);
-	spin_unlock_bh(&xtfs->drop_lock);
 
 	if (xtfs->ra_newskb)
 		kfree_skb(xtfs->ra_newskb);
-- 
2.47.3

Best,
Tristan

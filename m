Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414013B3884
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786446290; cv=none; b=K3DvcYqz5eqizKLZG6ick2qDlwgBiI4btqcVeJLbBwe7Wchl1sh+VdQV19C9Xt3chgBlq9CbLMBFRThcP0PHMZZDgi52VWKBb1hanPAcPUWEgRO3nNyyHV4bTxdhBH+OTyHbJx+COCsk4ojRfz00FYbPWHgXM8lkKgCREWBPPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786446290; c=relaxed/simple;
	bh=atCxkuYL4hRzLwzbyOunU2UxpM3YWWuI9Tod9XDOHxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ARAW56LBHQe2MF5WCWnE9Naj8kWYh0auTWr60F+w2/qNC2wjEJnH5HsqTyfqisZ7YNG7AfobQ8eDe+avEwPypk/59ou+t9xb+U+9yfc+cwrM/QSL0dJwAT/Q8VyAJ71hLHr51f/F7K+MiqtS3a4VbOw0qAMC54GvC0hgnjbBrvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nneAstkH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nneAstkH"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-481412f1828so677225f8f.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786446286; x=1787051086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LEHATZupNKkhi1i84uPxQjWjLcsCZYtEP5bp/4g/DpQ=;
        b=nneAstkHsY22j6wQMmPAVcGZBGnv3EKFyomdG3I/1hYHJExFM3n0HsRWTwFqjINyij
         V2x3mEAfhkyBzTqDb23rLHmfFWpEFGAWkOzJEwbEPG47ZgN7B/GlazbbVJfDM0eO4zws
         2uen8h67cR8SHkRhTjpiebYX/I29mC1aNnZ5Pxj31JLynS6IPKLqwAapFM+7pkqXDWme
         2VDWCjC653f0pijo9xi2GQKib1UOZsbVzmUd8ATxKrvU6ces2dlcKnj8xuxXSDb6AL5H
         mpBZT4ADC6dTaWGh8w/L/bNkQNoQj6d+tMu9TqLgWOZlPdMaPJ9D1V9LFtHfH+8ddIx9
         nouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786446286; x=1787051086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LEHATZupNKkhi1i84uPxQjWjLcsCZYtEP5bp/4g/DpQ=;
        b=MwDb+zSBmbaWO05qxbyVLre+nkUsnrObqIKTWw2Nnp+bKpJmCrZyvNdlXltPS1GVWt
         crd1QdmfFAbK5IFaxCMvjl3YInRmNCPKXxuPROFjcywEy+tHOH3lT+l9uQkAScTMfyye
         UvTNdAjXdR2G34PG63XU6OPANB/gLisv7F2cmzYiqooRu6omwjhDWnjt2wnkb4kL/VgG
         0qlGdkizjwNf4HZ5ODXUX0QF6EQxqN6c0E0Iiboc0A2gKfbnq8yiVzzTg7URM8I+sPcW
         WbcKoAt2fDhiOeoUNf8ivRrXe0Y8t84c/DbSGMGGZFjn69ZMB2Z0msD3ftU8bE+kbF+G
         onbw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8w6cCOiH2wIbKQ2hGILCpHI1MYXB9ZwxNs4O0oFyKeja5YUtfq9SXbxB8SaCaoUCqXigm+Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3QfjurXDlUVYahjjIxXRDoFrvJwoicdn9wM75ucXsOCO0zVdi
	LIF8FarRU83Fz0h8ZvOHBorPUNyn3aeEk3ggNRAtIN6HGHwRbs1oSUkO
X-Gm-Gg: AR+sD11zqUVVipqaJqz248ASFe22VsMdyZLN/W5fS2vf8HsNk+svdMGIJnURbmQOmJa
	TgygVtlMHzjKGZD0ED97O81eW6MtXQJ9smsDNmW7snsLPAc1x+K9/YIFx3S6nWQHtJ458tOW5AW
	9s/ah+fn6B8P0R/b0HycCm+5BnVI9VpukbDtGwW/pzcq+YTevkCfJioKl7uETz7UZYd5fs5ak4k
	7gdIxLU3FCyVQW+JV0ONwwrQnPAJUB+M/rzEuY7/cZiIU2x6hELGTDG7RSDCh/hoe/xt39qVlNJ
	oVMlIK885+SDDYduHIrfLK20HQ2U1TNPMeTOCcGmSGLppHzfivz1YgLSyo82iQZiWP9Rl2VonQz
	6tJ32dD2m/Ux9LqPrS2Jx770ZzkHvdtKJAbIe7uJHo/QfEPfLjuo0z95nhz9dX88JciJeE+2Fxw
	sQbyQXDNSEfGEhUUw6NoZnl2XKEf18wQWijd/43lGfKxNPVJM043F4kMu0pCQ586BDc2mWfoF6Y
	48uIfN6iOP3UohD697ymhlJn3Q3sjLdICIf9UWfff9Ga9DEwygd0FlDAtCL88IBQgI3xDIv216Z
	130LUmsImASFZ4hWY0iSqWjKs0BZ1Fw+gDOmZZiSgZ5PGXZHD4W7tNLYBIzuYrtRA3t0
X-Received: by 2002:a05:6000:4008:b0:47f:f3d4:26da with SMTP id ffacd0b85a97d-4814ad8ed6amr4076784f8f.11.1786446281619;
        Tue, 11 Aug 2026 04:04:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a72cdb8sm3593881f8f.35.2026.08.11.04.04.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 04:04:41 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Yi Zhang <yi.zhang@redhat.com>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] blk-cgroup: fix lost wakeup in blkg_destroy_all()
Date: Tue, 11 Aug 2026 13:04:21 +0200
Message-Id: <20260811110421.50747-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wake_up_var() requires a full barrier between making the wait condition
true and its lockless waitqueue check. spin_unlock_irq() has only
release semantics, so it does not order q->root_blkg = NULL against
that check.

During disk rebind, blkcg_init_disk() can therefore miss the wakeup and
sleep indefinitely. Add the required smp_mb(). Also mark the store with
WRITE_ONCE() since the waiter reads root_blkg locklessly with
READ_ONCE(). An LKMM model permits the missed-wakeup outcome without
the barrier and forbids it with the barrier.

Fixes: 3dbaacf6ab68 ("blk-cgroup: wait for blkcg cleanup before initializing new disk")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
LKMM (herdtools7 7.58), with the store modeled by WRITE_ONCE(). flag
is q->root_blkg (1 = set), lk the queue_lock, wq the var waitqueue
occupancy. To model the fixed code, insert smp_mb() in P0 between
smp_store_release(lk, 0) and READ_ONCE(*wq):

  C blkcg-rebind-buggy
  { flag=1; }
  P0(int *flag, int *lk, int *wq)
  {
  	int r0;
  	WRITE_ONCE(*flag, 0);
  	smp_store_release(lk, 0);
  	r0 = READ_ONCE(*wq);
  }
  P1(int *flag, int *lk, int *wq)
  {
  	int r1;
  	WRITE_ONCE(*wq, 1);
  	smp_mb();
  	r1 = READ_ONCE(*flag);
  }
  exists (0:r0=0 /\ 1:r1=1)

  herd7 -conf linux-kernel.cfg blkcg-rebind-buggy.litmus

  without smp_mb(): Sometimes
  with smp_mb():    Never

 block/blk-cgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d9676126c5b5d..2b3cf9caeaa31 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -604,9 +604,11 @@ static void blkg_destroy_all(struct gendisk *disk)
 			__clear_bit(pol->plid, q->blkcg_pols);
 	}

-	q->root_blkg = NULL;
+	WRITE_ONCE(q->root_blkg, NULL);
 	spin_unlock_irq(&q->queue_lock);

+	/* Order q->root_blkg store before wake_up_var()'s waitqueue check */
+	smp_mb();
 	wake_up_var(&q->root_blkg);
 }

--
2.53.0

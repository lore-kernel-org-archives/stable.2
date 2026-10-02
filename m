Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9D40860D
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969433; cv=none; b=gMwu0GuV3dIQatGDa3CtkvV4YQ7JSRdG45wYUCJ0LTw6/pOShC90RLudH4LMRkMonPbZ0OTD6sowkSI1riA0rQwNFhSr48szAFZNu0rbGIlWoeZxpWSH162jSnIpA3/qLqeW/X6/UK4RzYTrkyzl8JsQpxQQ2HhQnkpLKTWQYmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969433; c=relaxed/simple;
	bh=8ud2PPO+Px1fJTR7fKOj7Cpd+e5w0q+EGfpkJKvI81I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDea+uLWVt7f+Rs7l5UYNmsku+JtLSPr/p6i2f8EWoRaHPGXyTt65egiL8BefZ06z03xUfwwO9S98cDLzD1hQmWjJ3xNegV61TjgkHn+e1h2OKHp6MhrwoycPKLkPtEsR/QGmG79VlrFnLkxskvauLlyJeH2TxzMSUQGs25g1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=XZIZrX2n; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="XZIZrX2n"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3510f00d974so426533eec.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790969430; x=1791574230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BVzBvK/NgasRJl/U/yBTGdi7yekXwAP7/69MG2UrthM=;
        b=XZIZrX2nwcFIYbQtJYHWp59Q5QgshZ7f2cxnzheGaqLguTsABtHW06Zlhi47Zg2cyE
         3dXbSF8Joqh0nfRQVuKUVyFXfHxeZfw15T/ruc/Ax+pOb7PKEa9V7UxNK9wKXCdVyOWP
         LBcxY3gUS5MkzwYb0sxkzSgh42wVF+Z7Ffq0+OW/fwDFtMhjqGNjZ3lUTd/ubq+ggpFA
         CVHM+H5gMveYC66+zN+r/nWl6eBJeKkVIoQ3cAOLCugaO5rEDLzQSjVbywxC8bQoBxbu
         NHjqRZpXYFmEKevfk4pAKLRs6oj5Mk4FIew3KjzVlTXifPSPldlvGc63Z4apsCRbcd91
         i25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969430; x=1791574230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BVzBvK/NgasRJl/U/yBTGdi7yekXwAP7/69MG2UrthM=;
        b=FjM66dBGn2X6plNFVPItS3C68SB5w9GaFW/QFZXJ8tWuCXJcFdq+bekmM+OoMHfOXR
         8w0CmryTw4LvCdRMm4s1qA0XIyQVqS/aArUK+r6iraFFQ7U/+uETik9L6vd9CdiIBcj0
         sYK0bwRWgCQ+NjIYA3ZEM2Dml9OTlmwPpoNgrYIHrlg52SvWMzsvWGbcc7eLdmCYMEoR
         0KTfa+MyYjNneWJWvBdzoW4dhcUCUoXFsFvKqqd4/eEj22KpUuG/xa69toOTA8R8LYLI
         NJorHAPCSA3MdobMmtcrsedJmt0cnNtTEfjMjqHontdA4v+wATme1fGa0RfWM9PRiKfe
         oboQ==
X-Gm-Message-State: AFuF++npoUF+Fu0ohZbNFSP6bIY8sGeYRUwhp1oNR3wedbUaJeO37GDO
	JSOEJbTK0luMbCy6Q5gOwo7X1HSjRcKFWiTzovnoeEATFjDZBMi2GcfqQRMiuSObScfcKOXgkEI
	CZWeydq31uA==
X-Gm-Gg: AYBFou3Lj2cI8Lvqlih5JWR2Yz2r3oDuCBlR3Bl71zBrb/qJFV992v/t3RT92odoLpT
	2pyhVopLc3hVzKS15Knn82NnVmvy4ZuZOGdxgtaX1p/AKuwsdSIJIL/GzaGHGtjmSm8AbsFjrMV
	6qTUmV3i1rmcdLpd2QAKjvPcep27CJmSlTtSCagwF403/uGhcdhqVXGJ4Kk2/R/z9586gE1QB+F
	bj9KVwVYtFZ31KEf6OQ4V3r/G032ZEDm1NTfiMilISBfmFgf1/72OM+Fnh1p7IG4bBz1UEWLd7E
	trJdMBdVmzN668H0FBsQS4AWq3EFQzSHYvAReOp6Yp6kPVizuVKrI0ZF2iycx4zeMourPrfqvKb
	5pf4laqUWOAy6oou3M1SwNjv5kaJjLZv+q+vHFXHb5Rk1C6RjSA5Tagrs+WpRnrya1b+SUIf54M
	eqt9CndE/4Jh5W1fcJ9P5VLSdxmWVPZyB89p96mYQKkvM+1RsT6u1/r5YjcnNIdoQWcPYzYNI9X
	MV2n4e29Aaq0lGj/OzD42ZcngASX4DvEccHWsv9SEoeFLv48f6VXJHfZkUWRB+ZgxzXxt0=
X-Received: by 2002:a05:7300:c00b:10b0:34c:fedf:ec64 with SMTP id 5a478bee46e88-351114f8a93mr644136eec.30.1790969429931;
        Fri, 02 Oct 2026 12:30:29 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f660f1sm8427448eec.13.2026.10.02.12.30.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 12:30:29 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	toke@redhat.com
Subject: [PATCH 6.1.y 2/2] bpf: Defer work in bpf_timer_cancel_and_free
Date: Fri,  2 Oct 2026 15:30:17 -0400
Message-ID: <20261002193020.19392-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002193020.19392-1-artem@trailofbits.com>
References: <20261002193020.19392-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit a6fcd19d7eac1335eb76bc16b6a66b7f574d1d69 ]

Currently, the same case as previous patch (two timer callbacks trying
to cancel each other) can be invoked through bpf_map_update_elem as
well, or more precisely, freeing map elements containing timers. Since
this relies on hrtimer_cancel as well, it is prone to the same deadlock
situation as the previous patch.

It would be sufficient to use hrtimer_try_to_cancel to fix this problem,
as the timer cannot be enqueued after async_cancel_and_free. Once
async_cancel_and_free has been done, the timer must be reinitialized
before it can be armed again. The callback running in parallel trying to
arm the timer will fail, and freeing bpf_hrtimer without waiting is
sufficient (given kfree_rcu), and bpf_timer_cb will return
HRTIMER_NORESTART, preventing the timer from being rearmed again.

However, there exists a UAF scenario where the callback arms the timer
before entering this function, such that if cancellation fails (due to
timer callback invoking this routine, or the target timer callback
running concurrently). In such a case, if the timer expiration is
significantly far in the future, the RCU grace period expiration
happening before it will free the bpf_hrtimer state and along with it
the struct hrtimer, that is enqueued.

Hence, it is clear cancellation needs to occur after
async_cancel_and_free, and yet it cannot be done inline due to deadlock
issues. We thus modify bpf_timer_cancel_and_free to defer work to the
global workqueue, adding a work_struct alongside rcu_head (both used at
_different_ points of time, so can share space).

Update existing code comments to reflect the new state of affairs.

[ Backport to 6.1.y: mapped deferred cancellation onto the older pre-BPF-
  workqueue timer object layout. ]

Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20240709185440.1104957-3-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and bpf maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-41045. It defers timer destruction so callbacks
cannot deadlock or leave an enqueued timer freed.

The corresponding 6.6.y backport is queued (6.6.158-rc1). The fix is
already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-41045
Upstream: a6fcd19d7eac1335eb76bc16b6a66b7f574d1d69

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 kernel/bpf/helpers.c | 58 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index af16711a731ffe..e462962a1a12be 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1113,7 +1113,10 @@ struct bpf_hrtimer {
 	struct bpf_prog *prog;
 	void __rcu *callback_fn;
 	void *value;
-	struct rcu_head rcu;
+	union {
+		struct rcu_head rcu;
+		struct work_struct delete_work;
+	};
 };
 
 /* the actual struct hidden inside uapi struct bpf_timer */
@@ -1167,6 +1170,22 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
 
+static void bpf_timer_delete_work(struct work_struct *work)
+{
+	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer,
+					     delete_work);
+
+	/* Cancel the timer and wait for callback to complete if it was running.
+	 * If hrtimer_cancel() can be safely called it's safe to call
+	 * kfree_rcu(t) right after for both preallocated and non-preallocated
+	 * maps. The timer->timer = NULL was already done and no code path can see
+	 * address 't' anymore. A timer armed before bpf_timer_cancel_and_free()
+	 * will have been cancelled.
+	 */
+	hrtimer_cancel(&t->timer);
+	kfree_rcu(t, rcu);
+}
+
 BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map,
 	   u64, flags)
 {
@@ -1204,6 +1223,7 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 	t->prog = NULL;
 	rcu_assign_pointer(t->callback_fn, NULL);
 	atomic_set(&t->cancelling, 0);
+	INIT_WORK(&t->delete_work, bpf_timer_delete_work);
 	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
 	t->timer.function = bpf_timer_cb;
 	WRITE_ONCE(timer->timer, t);
@@ -1424,14 +1444,8 @@ void bpf_timer_cancel_and_free(void *val)
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	if (!t)
 		return;
-	/* Cancel the timer and wait for callback to complete if it was running.
-	 * If hrtimer_cancel() can be safely called it's safe to call kfree(t)
-	 * right after for both preallocated and non-preallocated maps.
-	 * The timer->timer = NULL was already done and no code path can
-	 * see address 't' anymore.
-	 *
-	 * Check that bpf_map_delete/update_elem() wasn't called from timer
-	 * callback_fn. In such case don't call hrtimer_cancel() (since it will
+	/* We check that bpf_map_delete/update_elem() was called from timer
+	 * callback_fn. In such case we don't call hrtimer_cancel() (since it will
 	 * deadlock) and don't call hrtimer_try_to_cancel() (since it will just
 	 * return -1). Though callback_fn is still running on this cpu it's
 	 * safe to do kfree(t) because bpf_timer_cb() read everything it needed
@@ -1439,10 +1453,30 @@ void bpf_timer_cancel_and_free(void *val)
 	 * since timer->timer = NULL was already done. The timer will be
 	 * effectively cancelled because bpf_timer_cb() will return
 	 * HRTIMER_NORESTART.
+	 *
+	 * However, it is possible the timer callback_fn calling us armed the
+	 * timer _before_ calling us, such that failing to cancel it here will
+	 * cause it to possibly use struct hrtimer after freeing bpf_hrtimer.
+	 * Therefore, we _need_ to cancel any outstanding timers before we do
+	 * kfree_rcu, even though no more timers can be armed.
+	 *
+	 * Moreover, we need to schedule work even if timer does not belong to
+	 * the calling callback_fn, as on two different CPUs, we can end up in a
+	 * situation where both sides run in parallel, try to cancel one
+	 * another, and we end up waiting on both sides in hrtimer_cancel
+	 * without making forward progress, since timer1 depends on timer2
+	 * callback to finish, and vice versa.
+	 *
+	 *  CPU 1 (timer1_cb)			CPU 2 (timer2_cb)
+	 *  bpf_timer_cancel_and_free(timer2)	bpf_timer_cancel_and_free(timer1)
+	 *
+	 * To avoid these issues, punt to workqueue context when we are in a
+	 * timer callback.
 	 */
-	if (this_cpu_read(hrtimer_running) != t)
-		hrtimer_cancel(&t->timer);
-	kfree_rcu(t, rcu);
+	if (this_cpu_read(hrtimer_running))
+		queue_work(system_unbound_wq, &t->delete_work);
+	else
+		bpf_timer_delete_work(&t->delete_work);
 }
 
 BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
-- 
2.39.5


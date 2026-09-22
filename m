Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EFD4779A9
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077645; cv=none; b=ZWqlw8d3xJzLAFNChk0TKKmJ8irsAOwk9Mzn5kJk+gQ7aE1meT7yvbHq9fo6xz25Wq0uOlD9BCn4T3o29hdLQZAtGPYp8pDnXsyIgsoqHeNCmGhiOG3kW7gKmgInRm38Ka66/KbwvTLBFvqlvUOlPJ0UMKDoXAOa2IJ9nKMTk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077645; c=relaxed/simple;
	bh=jovRVJbpZTb+ZglNPIIKR2oPE8WyMI7kApZvO1dQFRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/m0uoc8qT+wB0gMh2LhuEG1D/J99OdWDCx6lzBpQNVm5tTsgchYAoIIorDysr9o57Vp1l0UNt9/eIq1a+uVJDpigoQrz6jYeB/ny+JMvJ8Uw0uKHW3hhWafz3h8TUtXs9ByFOIjqI7KXtbqVXCF/5vIErTiAS2TWmWLckAXLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=purNwTsU; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="purNwTsU"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso3189090a12.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790077643; x=1790682443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=enO2+0ca7WL8sisdHrU6dZsOolPhdpJeqxCjIyX5Vl0=;
        b=purNwTsUXAJFa6yGP6yk350VuJRUxnjiNlp+yyZhXJNqlKYUf8S8NeLc+e7+89B/xp
         D1T+U3i9/LRWwIUmwA1QLVGD8Q4E+FRdxCC0mSXk3SgKsv4jVJYXc3XSSGLh1dnBkpui
         svqNVnfOBYsRiydLxPBro/RV76n0SA8O5cLqumC5JO1YjUe116STcy9BebyUdXyhCPvZ
         +43Uht1TCRO6+Sg8jNPvIjrlDEUhGzaFUHWSrZwsbmX2Pw0o70NzGaIa1huoDN29BS/r
         aAE4EbCbhQcxmkmIgZu3BiezzKTJV8S9RnzgasnHncgLBlxH1j2D5qSYYjfXweLYYU2e
         rULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790077643; x=1790682443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=enO2+0ca7WL8sisdHrU6dZsOolPhdpJeqxCjIyX5Vl0=;
        b=cf/x+USJEz6FPG3Lzk/meTs2ByHzP7Naq9tmoSD5tjhi70OrxGbNbI8KaEtyeG9BeE
         hcwBd1kmimUadLvePqh7bYQzHFKHqVu8Uk6jUS4pkUi6uGcFo60mnqYnqO0rihwR5i/U
         QDVxq7yf51FHV+N/u7C0GqOL3cz80SzLwLOU+tYKcYHj0VEsxEmNaL+/sQziFS+fr8M6
         T3Rab/HI+JBquArIxpmP72n3xbzxhGWm33i4DaTLZWwol7u9A7V5QitVDQOiV0uv/V7q
         ijYwOICWCTVR13bUR8nyK5vzz9EohcrHPRUmlwUZTPIWjhQcRaWf9U5iosN/KMLjWHHC
         9t/Q==
X-Forwarded-Encrypted: i=1; AKwUvByen7/e07C0vyoIuQ+nmB8lvADDnnMONEUk8qwzoBXoM2WNdYmD1g2mUVvayzn130/6xoZwpL4=@vger.kernel.org
X-Gm-Message-State: AFuF++k9AWyqExEJLAjTjcHsEmtNTQLxbgh6GMBlA/zE4o+mXha6HLyT
	LM4doZeftZFuIt0iST08LfRebAwQPVN+m0VIr4yMo8vo1OJKgEvXUcb4a5h6lpfZhwNQIA==
X-Gm-Gg: AYBFou0kDYY9JXpZemX+pO25BxneL6PvDCIriev7cV82cchTb+j2nWiJd8w0vGQe47k
	d3HnvHL5Ut+b4VlKnlRf0Mx+w552GVzxtQnUYHwf3wsKRvVmy96rT9SzMgaap6Y5XXPOeDWXZAX
	jtf7pDxD94vMyckZnvbvSQgL8tNjTuogdvBDJ09UEEDPFeFzoQEeJHFcbLrRGH0fk4i2UkOc5pG
	Kucpg5Cxjv2PsPiKh1/+CdsswN0utWwjLkq8A5UTHe5iKGmdNhiagY/PeZ6ijO9ZRmd6zMDVymJ
	yFfC9Qw0hygwou+dEvjXRzbDp+S0s0mTkQ1KG44u85B/lUNCYAEwZ9+qKwIQBJnMMYOA1VjLaOs
	T8vji8iSQ1rDjotG/ifYRB1q+TGkinV9PKiZPIiBzSzp3VtyYVC3e8W3UMNG+IAztcjb6MhfYfb
	sNiWqM7xsrzxpwf6OEosLmmF//o5C+3TuQhKCj6YbjOc3Izkd7MC/hmIGcNChfSEDqD/vGhQ==
X-Received: by 2002:a05:6a20:a123:b0:3dd:a006:7b30 with SMTP id adf61e73a8af0-3ddec802400mr1107154637.47.1790077642926;
        Tue, 22 Sep 2026 04:47:22 -0700 (PDT)
Received: from localhost ([101.126.44.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756987fafsm806205a12.4.2026.09.22.04.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:47:22 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: security@kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	w@1wt.eu,
	Dairui Zhang <zhangdairui@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] IB/mad: fix UAF and double-free in RMPP receive reassembly
Date: Tue, 22 Sep 2026 19:47:19 +0800
Message-ID: <20260922114719.1465335-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921193238.1420558-1-zhangdairui@gmail.com>
References: <20260921193238.1420558-1-zhangdairui@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mad_rmpp_recv.state is protected by two locks that do not exclude
each other: recv_timeout_handler() (port workqueue) checks and sets
RMPP_STATE_TIMEOUT under agent->lock, while continue_rmpp() (CQ
softirq) checks and sets RMPP_STATE_COMPLETE under rmpp_recv->lock.
Nothing serializes the check-then-set sequence.

If continue_rmpp() passes its state check while the timeout handler
sets TIMEOUT and waits for the in-flight reference in
destroy_rmpp_recv(), continue_rmpp() then sets COMPLETE and queues
cleanup_work, after which the timeout handler frees rmpp_recv and
the rmpp_wc. Ten seconds later recv_cleanup_handler() runs
spin_lock/list_del/destroy on the freed rmpp_recv (UAF write,
double free), and the already-freed done_wc is returned to
ib_mad_complete_recv() and freed again (UAF read, double free).

This is remotely triggerable: kernel RMPP reassembly serves the
per-port sa_query agent (malicious or spoofed subnet manager;
hi_tid routing is predictable and SLID/GID is spoofable on RoCE)
and user_mad agents registered via the legacy REG_AGENT ABI, where
a remote RMPP DATA MAD on the request path starts reassembly with
an attacker-chosen TID and no in-flight send required. On RoCE this
is plain UDP/4791 with no authentication.

Unify state transitions under rmpp_recv->lock in
recv_timeout_handler(), keeping list manipulation under agent->lock
(which preserves the agent->lock -> rmpp_recv->lock ordering used
by continue_rmpp()). State check/set in both paths is then
serialized, so the loser of the race always observes the final
state and bails out. recv_cleanup_handler() needs no change: with
transitions serialized, a cleanup_work can only be pending after
COMPLETE, in which case the timeout handler exits early.

The race is as old as the RMPP implementation itself.

Fixes: fa619a77046b ("[PATCH] IB: Add RMPP implementation")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
---
 drivers/infiniband/core/mad_rmpp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index 17c4c52..f05e9ce 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -245,12 +245,15 @@ static void recv_timeout_handler(struct work_struct *work)
 	struct ib_mad_recv_wc *rmpp_wc;
 	unsigned long flags;
 
-	spin_lock_irqsave(&rmpp_recv->agent->lock, flags);
+	spin_lock_irqsave(&rmpp_recv->lock, flags);
 	if (rmpp_recv->state != RMPP_STATE_ACTIVE) {
-		spin_unlock_irqrestore(&rmpp_recv->agent->lock, flags);
+		spin_unlock_irqrestore(&rmpp_recv->lock, flags);
 		return;
 	}
 	rmpp_recv->state = RMPP_STATE_TIMEOUT;
+	spin_unlock_irqrestore(&rmpp_recv->lock, flags);
+
+	spin_lock_irqsave(&rmpp_recv->agent->lock, flags);
 	list_del(&rmpp_recv->list);
 	spin_unlock_irqrestore(&rmpp_recv->agent->lock, flags);
 
-- 
2.53.0


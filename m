Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D8E4E80DB
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610852; cv=none; b=qRZXMa87jioVB94k8EtmkWYJ/sIOGRPjM+/9sCBscJ77gFk/3ODCf7tjtWLqBKPP3iMP97AJpbnPj+lwTCuKHiqBMGwIAdYXF1w1PdXQbK+CncA7t0sQYDOrorXh4oy7iGhlOpNdW2Z+QsteVhu8LHA5YtpSzFuyilVIns3ffrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610852; c=relaxed/simple;
	bh=F1XGthFugO8o/4y3HQ+qHzagDD1wrQEZrzg16ucagfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTLbWxlo+dQlyB6nfHYBQiKGG0JRJ58M5/W7hVcV2yUzFC0VbMH+QnNPlZfiZq/XCe4sDnyRbrSSdhAyvUnNjpgwJs6rEcPPr4ChwPvh9fgzQJ8tFI2LuJoK0mjAInGYCrt5SJVtVPZhalL5vh0lqkqEbcD6p2UiFA4tdxG19WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYhPh4O5; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYhPh4O5"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a48e359e0fso296593a91.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610847; x=1791215647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p2lAgUWgR0XAmgfvHp1lJCa7LTGDn2tS/TFbC3QV544=;
        b=OYhPh4O5NPIs+v8RjhkwKeKU0Jp+wDvLS4mjLAOzeRjTlAJZPj90ued5L9eK4N2VH2
         +Ag3690vP6uaC7E4HaRgWjpyHK3qk5+uJ4Pfd3PQG/3QxzS7HV65hifI+qmgkMaOlkRF
         p+EzNXaJykJ4noJwrcXEuMRkc1bOALaeS3RRW9HDVeibR8iGD10tQG/ergVb03wkCNZi
         uqlcYWo6LncARWvCKz8iE7GcnEKImA/SSVFkoMoUKj2cPfuzkdlyofP1wdC8ynvbw1Uf
         8wDC39rIJkG6eLdKhfWaLAX9pmPziM4pVud082ran+q9Nl0KzMoJxm5ndlSSy+oNYHqh
         uFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610847; x=1791215647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p2lAgUWgR0XAmgfvHp1lJCa7LTGDn2tS/TFbC3QV544=;
        b=FeJkDn4pkv7SkxNFtgXnUiEHe6g/QZotw5KKoyjxFjOCv48M/R3R/9r09637HTFN8a
         +LoaR3eog6N/QguIGhz0VkMbTAs8upzIE68gbdPKdbXCW/IbqyKTRD+bTHTZ5zunMhJR
         NzFBjNiP0/UlDSPRh4UQsj3J4lYIomDONcOwJj23sKiF7Z8rx6yYG8SwhZp9ett2AiCt
         fjlb+QA5MKuU+hbH62fsMxA/dWBf7ae93XEl+Y3M3wA5KEFW19BoUgIloMtZIuEdJ6B9
         L/x9+sFqEbprUf7Oj4cY9CUwd/qvHY21sc5bt0GLiRPV5fniglnRpP6/QSdxGI8Omc0m
         igKA==
X-Forwarded-Encrypted: i=1; AKwUvByXnv5h+eqoBBGikPzVLvJuYiD8n7+UNzwuFreKCszlRIWoS//ukRhPbTh4LKYDotJwWXd6tHo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiy6tvvGyiT0PDqv1uih7ltiz4gZBJU79p7zovFDRdTOm19Dx5
	3pdyJatljCKTHjXPu5CvDjgXPKLkEGB8EIihT/bvxHNe/QdpZw8OBb9X
X-Gm-Gg: AYBFou2e/ZxtVujtSSwAkoD7wg5OUeAV+d+va0PL90w9Hk9hNwSe3UvcEZ6MH9nMwsM
	sBe2+pgaOlLUq5OltAQbtSQ5ykrAu0YS9adNtSSQ/yhCUz7+T/WIhhbOHoHaGeIlZsKf9NoD+g0
	1Y4KO5HIBE5hUWjpbjpGhQ73sRxCTtZumHF5JfkZeMxP+bC2jN0UYnv8PLY2/uWXHAWjbVkjmqM
	JbGvyPQyby4nPw+0PewT5aAB19HW8/h9WK9O7L3WkETbc+IIRIyL+I3hrGKpq2gyPctlBUmCfdB
	JsFxmql7QRMY6ALMazoqTrOrjoyBWXL3dJQgYSX4kh283JI/pBn4U/CAolExLB1oXU9uLy8Ycau
	HALT1GrvEx2jZTGolb/4QZmpK7tPnEw/laQN9qU/n8vkXJBDA1zHYIqNMojjmKHhZcE0H4Zz/kb
	x2DvAACDdkas8Ldf5OelwGA//rx1cEC7yMVw4e/e0w+Rj6AYrxZBCekIenTsyJMLyi8X25bL78p
	c1CiVepACJRbZGZPmCgiqNm
X-Received: by 2002:a17:90b:48ce:b0:3a2:b20f:21b2 with SMTP id 98e67ed59e1d1-3a2b20f2a71mr3224522a91.8.1790610846703;
        Mon, 28 Sep 2026 08:54:06 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986a1905sm44269a91.13.2026.09.28.08.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:54:06 -0700 (PDT)
From: Dongliang Qin <cccccccccccc777777@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Dongliang Qin <cccccccccccc777777@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bob Pearson <rpearsonhpe@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] RDMA/rxe: Invalidate MWs on QP destroy
Date: Mon, 28 Sep 2026 23:53:50 +0800
Message-ID: <20260928155351.3222978-4-cccccccccccc777777@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928155351.3222978-1-cccccccccccc777777@gmail.com>
References: <20260928155351.3222978-1-cccccccccccc777777@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A type-2 MW holds a reference to the QP that bound it. If the QP is
destroyed while an MW is still bound, the MW keeps the QP alive and the
responder can retain a stale QP association.

Invalidate MWs bound to the QP before removing the QP from its pool.

Fixes: 32a577b4c3a9 ("RDMA/rxe: Add support for bind MW work requests")

Cc: stable@vger.kernel.org
Signed-off-by: Dongliang Qin <cccccccccccc777777@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mw.c    | 21 +++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 5e95e5c5e32d6..5c648a5ef34b1 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -90,6 +90,7 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
+void rxe_invalidate_mws(struct rxe_qp *qp);
 struct rxe_mr *rxe_mw_get_mr(struct rxe_qp *qp, int access, u32 rkey,
 			     u64 *offset);
 void rxe_mw_cleanup(struct rxe_pool_elem *elem);
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 82e9fef89b6c3..02d20ede1a789 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -298,6 +298,27 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
 	return ret;
 }
 
+void rxe_invalidate_mws(struct rxe_qp *qp)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mw *mw;
+	unsigned long index;
+
+	rcu_read_lock();
+	xa_for_each(&rxe->mw_pool.xa, index, mw) {
+		if (!rxe_get(mw))
+			continue;
+
+		spin_lock_bh(&mw->lock);
+		if (mw->qp == qp)
+			rxe_do_invalidate_mw(mw);
+		spin_unlock_bh(&mw->lock);
+
+		rxe_put(mw);
+	}
+	rcu_read_unlock();
+}
+
 struct rxe_mr *rxe_mw_get_mr(struct rxe_qp *qp, int access, u32 rkey,
 			     u64 *offset)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 8553c8402c619..c0d77cad4906b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -658,6 +658,8 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		goto err_out;
 	}
 
+	rxe_invalidate_mws(qp);
+
 	err = rxe_cleanup(qp);
 	if (err)
 		rxe_err_qp(qp, "cleanup failed, err = %d\n", err);
-- 
2.43.0

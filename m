Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD931552948
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957827; cv=none; b=GpnRaNYVq4Bx0HL+3DPMutuZi4+zIsFRtR44cx0u6ZnJgkpWbqjn2Lt1bFzJEPxEJWQNM1zmMEWX/Ck746GvrzIk07elLsRSUxdCXWTh9XQNaruUqHJ3nmbKTKB+a1FNOZiIAzL4ctpXFK7SYailQcjg+5y2mA+3hFfABKrUoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957827; c=relaxed/simple;
	bh=IEh6hyyZ9Lhnuzlwyc2+i+G5ZNpRDQ/gz0JsKjP0QOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRarVnIbnc5j911ppmIvwEh9qfIqH2b93GVDLSo1v/1ky8TH3Q8Z//nX1Ql3VGcz1KgfWejUUh/eaV97kLPpjcCZdhcORFBR9iHmu/PG0Sb1JZeyCmy2Z2TZ4ScaKO3tgitjyHsViV5aFyomfvNYrUuvu/yzGGeD3tABDfe72Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0hu6+pm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0hu6+pm"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4902427c1so1571800a12.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788957825; x=1789562625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ewC8JDt7L6gGOtRRFCa2/mRui2ECUd32aBWU8eSS7Gg=;
        b=W0hu6+pmoEmbNuISYLrPJswkelDTqXxpatjqp5r04Z/LM3JJ5P5BLaIh1RyyzppLOD
         8dxLy7x0qXZ9PfilqGThCSrrF0MKGppEP/HPmAzm7G18tsW2TUZkCwMNqjE5ggjKbOTk
         dfuWopJotQWfq42cXOhMhT0fTw1IYdLdJc9pG0Mh9mx6icQ3HJwUGIei0AyVpJTTjoKg
         R2+CTJzuD5r5qz5H17+gmHtGLkfHMU9pJLYeSrCaDhJQyHYHau8xqEs6VqsKNnD1juc5
         6RAP+Oyft9qHUghelhDf0/BB3SJxOKK2ZukD68c2K8USJNy23seiccAKDNpGq9a3rYMW
         iO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788957825; x=1789562625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ewC8JDt7L6gGOtRRFCa2/mRui2ECUd32aBWU8eSS7Gg=;
        b=hzOBYV9qk9EAmNZ5laWVC13oPxCUSh0i7jvlGrAhYaFEHZCAO9vlhTyznqvH6xMusS
         VWVmCyRge3mmHna8Kzqlb39Wh66w6qwG40vJwjirJ50qrQi3+YAY/uhd9SADPKn6gx6X
         rX38Ud8gcaGrumqLTmjP3XCYez+Zom54LcAd0ug5NaOo6op3p15Mdut55/2uPDfPuWPm
         stSFzS5BlY1wZVYHUfVkoq4ss5Tfc8r0L0/ACqqB52xT4oz9p4d3M5FvE/DcR35tx+fz
         Y6y/nD+ez0ZGWFVUE9fryUJdrcCfzTLLgAC7yfwHBoIskfY/ufWmOA4KOc8jcBhHrVUG
         gbyA==
X-Gm-Message-State: AFuF++nXhEgfOSgyL05EKFI7Z6nxfq31afyxzgox07pQ0lEbYufQFYEF
	Rt3LDOvjWtBGKaZgl2LqYjAEsWz8ua7Femtzf1Lq5tKfKUthV1/rhTAqja+9NQ==
X-Gm-Gg: AYBFou1wIby8E1mcMOJNnJoZqa7iaKNn4TX0QtrzGqZw0+5lKsCSpw9M50vDXpzJRzg
	3WafhpSC5uRzmgvvBYqhhcLGg0+uZAIBztL9/nJG/mTPyEt15z/uA6GMN/WQ2MgezwlRTxsp9pk
	vCKdNgEPBCe4V8WS2RENMdBjsMJTXzURtcU3H/KH7VfTrVrEZiEcII6Gw6SdR7avRXeKb9xjnaP
	aNqiYpJMYUXP7gpJp1mMd5NFHS4xQMctO+uG+Nx5YzN2ihBzO9Xe3+hOFCbl0XYko+ml+s7Xw37
	n1FTuovUq+7ydF9KALKXHeZpapWyUrvuhbpukRR13M985Ng6elL3p8YoHyyHLWx0lzoHB7etReH
	kW0kTVAQy7cj1K+kZ/V+iKb4wEkWuTQyWnBdtJbIO3fmOjYnXhzxeyACyqfwMy9VHVVcPZ9u445
	IvpSvXCHrH7hJc6w9vNXClip9CrPW0h7Z8pDJ+UleumCogEf3fvSrMA7TmXeorJDNHYcpwRig1z
	5+EbIvt
X-Received: by 2002:a05:6a00:812:b0:857:73c3:4467 with SMTP id d2e1a72fcca58-85ffeadda8emr35822133b3a.22.1788957824906;
        Wed, 09 Sep 2026 05:43:44 -0700 (PDT)
Received: from hnkz-ubuntu-server ([2404:7a80:860:3300:f22f:74ff:feda:3295])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8693b502974sm346650b3a.32.2026.09.09.05.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:43:44 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: stable@vger.kernel.org
Cc: Kazuki Hanai <hnkz.64@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.1.y] nvmet-auth: Synchronize timeout work during SQ teardown
Date: Wed,  9 Sep 2026 21:43:35 +0900
Message-ID: <20260909124335.1794480-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090905-brunch-expulsion-4905@gregkh>
References: <2026090905-brunch-expulsion-4905@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvmet_auth_sq_free() cancels auth_expired_work with
cancel_delayed_work(). If the work has already started, cancellation does
not wait for the callback. Transport teardown can consequently free or
reuse the queue containing struct nvmet_sq while
nvmet_auth_expired_work() still accesses that SQ.

Add a teardown-specific helper that synchronously drains the delayed work
before freeing authentication state, and use it from nvmet_sq_destroy().
Keep the non-synchronous helper for in-band authentication state cleanup,
where the SQ owner remains alive.

Fixes: 1a70200f404a ("nvmet-auth: expire authentication sessions")
Cc: stable@vger.kernel.org
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
(cherry picked from commit eaa948c0e19b1bb2d93262207bca0c3d19cc3406)
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
---
 drivers/nvme/target/auth.c  | 6 ++++++
 drivers/nvme/target/core.c  | 2 +-
 drivers/nvme/target/nvmet.h | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 74791078fdeb..636a37130b22 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -231,6 +231,12 @@ void nvmet_auth_sq_free(struct nvmet_sq *sq)
 	sq->dhchap_skey = NULL;
 }
 
+void nvmet_auth_sq_destroy(struct nvmet_sq *sq)
+{
+	cancel_delayed_work_sync(&sq->auth_expired_work);
+	nvmet_auth_sq_free(sq);
+}
+
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 {
 	ctrl->shash_id = 0;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 813ceec0a1f9..72703cdbff2a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -803,7 +803,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	wait_for_completion(&sq->confirm_done);
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
-	nvmet_auth_sq_free(sq);
+	nvmet_auth_sq_destroy(sq);
 
 	/*
 	 * we must reference the ctrl again after waiting for inflight IO
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 39348983acb2..90c63971402a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -709,6 +709,7 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
+void nvmet_auth_sq_destroy(struct nvmet_sq *sq);
 int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id);
 bool nvmet_check_auth_status(struct nvmet_req *req);
 int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
@@ -733,6 +734,7 @@ static inline void nvmet_auth_sq_init(struct nvmet_sq *sq)
 }
 static inline void nvmet_destroy_auth(struct nvmet_ctrl *ctrl) {};
 static inline void nvmet_auth_sq_free(struct nvmet_sq *sq) {};
+static inline void nvmet_auth_sq_destroy(struct nvmet_sq *sq) {};
 static inline bool nvmet_check_auth_status(struct nvmet_req *req)
 {
 	return true;
-- 
2.53.0


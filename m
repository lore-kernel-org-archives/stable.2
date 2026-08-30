Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D703B47F7
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788095482; cv=none; b=AyovX6oGVYfufxtCrMlhR5bdHBxSudG53KHNK5R9kEcXn1z1pD28mE1udRblNd2ld9RE7GuDySJjuiug9fruj9AeCbGGrXCyyiwZQg2vqJWsxHjx8g4tf7TOjc81gkM2iN+ZGjoUb0aiPdr+9DjQWfFLAUrlZBS6L+Ylyx+/AQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788095482; c=relaxed/simple;
	bh=AFWMkDBvxtaZELWTnL0W8GQmXNMX2mJlaWvCner6BFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEbMbE8PAhH7hbD8DXeW/13hIAHrWpQMLg4u/KrSURLk/lfGxPX95ERQ3c4vNE4/hKsrD84rqUTugrenxcxeODbISpdzXhLnYhWFsPBJLpfSBiciLWjrLR80ZfPV0nhDC0y9pSFJQ0uXndtFMAn9oPlgYADcgTLZzjpJX8xg0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxFyYfx7; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxFyYfx7"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so2295822a12.3
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788095479; x=1788700279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hBwz1JGKS6AosuLs2+eWbdC5bsNU5Uv1Qp9D4GtVYpc=;
        b=CxFyYfx7pX0GKsc7ymaeQYPmRma1VOIv9jS1/GHFowQ5onYzvl0bjEDuRR5BpXvhQ6
         tJDdvFtY33QTMVjp1uH0+IxZPQTB3VnPN/lzztEFhA9HeFw26WJVIqOJmprnuykmlOzT
         FycGtRD+Y95Ck29mUpSrLnmtfG6HUxdB5Nio9TuhOwJPfTBNPNAa/+zxt1BIaVn7Td02
         TREAWEz9wKRXqqmopu0ubrZ46dnezCaj0XRKY5HQnZ5R5pQcK+wL2N0+Lrf6MXRcO9Be
         o7sw+mAvY+nBXYpgFdDtCa23uTeYzL7Fi8XB1YoK1oU1FtzmwThVp6Uk5HzuBa476gVv
         HgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788095479; x=1788700279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hBwz1JGKS6AosuLs2+eWbdC5bsNU5Uv1Qp9D4GtVYpc=;
        b=n8UAVNu0sIR6HYtFGAYlDEOvKs3v/IDhqT0dsXmke3IyJsrgzQMd8bVlCZbTXpLTu0
         oEu7AjsnAWm8To228uuqNoSVOS1Fq1E6sWN9i8S3wqlX9Mit2UK/yFKFcy0v+sH0ARnf
         TBbWltqYLCZ0Yq0TOWGQXLdtgkQvW7PwPGD/QgYAVnq/HcxVZJNVBtangJt1WTrzKlWE
         hAc+gOam3/NinwMSmz3rfi6aixcqmozWxYDnFtdIXvmTZiYxUfdMU762TpMIILxxom+K
         ttQxwbkwz4bL/KYCzEwzCAajtRj6ty8vuR+GmjhbSMgidhX9g2EYQhV0MYkkVUHj7LRX
         Hg8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzh0tVFanv8vGiXG8Hm8ZQ/CibLEnOdCdJHSJIDXZbEX4ABHQKz7B+MuPOAAx5TwCPT5QLEhIU=@vger.kernel.org
X-Gm-Message-State: AFuF++nVsQqrnPmtgL5+9ZF4kqjCk4eYSP4GSd6CxPNmMJIhmnj+ejiv
	p20PGd3tHYaquydNk1Andpw9fCaN6wm9NXEAetCSi+RRos7PXbLHeI0KTh9snLSs
X-Gm-Gg: AYBFou31RK2m3GPaWSFK3kdB/7yP70MbMZ5XLCZ5I6HZucPQGjjgCgrx2TTQHL4c56v
	kdhLMCw8n9elO8cbg3XLmTpGr17S5zse5ZwYJwmkMJp4In7DWOPqed7KUgVAh6kupEitKB+ivwG
	uirHsyP9BpvaOJ+8Eq9a8+MCVD78/sSWfJYUFd6wSvGw0HeY96KAD4qaNdslkwy2+TRGDEYceFZ
	+JM+YL3XOsl23mvgxbFFfPckH07sRfi5CbSjOSOB64wNyDYcRk6OFQIrC+2WufgYg72/QHFQvpj
	ISwB4/Z2a/Q/ZUszUrowMeey8GogB0wKvIRl2BcKPZGWFUaFPXYKufDc2ZHgPAFnUUY9To1m1Cm
	5F4apxUYvXsxxHM8Q72ZsHsUVd6zm7Ujy64zLoighk5nHSp6R6GVluzhgDoFI/lerV+n2ibUj+Y
	PCRmwNXBInxZMtY3LlxmFPOTTmc01IfNiPp64wQ8CXMQjcKOV3Nvg2kTj6OO50XkzN0+osHMJXy
	Wqaqj+jYW/do3XPyGYTaan7vp1SG91E6kpxapD2efA=
X-Received: by 2002:a17:90a:da87:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-396d0d4c42fmr34049069a91.2.1788095479333;
        Sun, 30 Aug 2026 06:11:19 -0700 (PDT)
Received: from hnkz-ubuntu-vm1.mshome.net (flh4-125-195-69-140.tky.mesh.ad.jp. [125.195.69.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fcfa3asm16265468a91.6.2026.08.30.06.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 06:11:18 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	Kazuki Hanai <hnkz.64@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-auth: Synchronize timeout work during SQ teardown
Date: Sun, 30 Aug 2026 22:11:05 +0900
Message-ID: <20260830131105.680566-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
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
---
 drivers/nvme/target/auth.c  | 6 ++++++
 drivers/nvme/target/core.c  | 2 +-
 drivers/nvme/target/nvmet.h | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index edb9627d97b09..a55319bcdbd13 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -238,6 +238,12 @@ void nvmet_auth_sq_free(struct nvmet_sq *sq)
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
index d74c01c98f194..4b48ca78ce5a8 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -980,7 +980,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	wait_for_completion(&sq->confirm_done);
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
-	nvmet_auth_sq_free(sq);
+	nvmet_auth_sq_destroy(sq);
 	nvmet_cq_put(sq->cq);
 
 	/*
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e362d7913a380..dbda55895f4fb 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -924,6 +924,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
+void nvmet_auth_sq_destroy(struct nvmet_sq *sq);
 int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id);
 bool nvmet_check_auth_status(struct nvmet_req *req);
 int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
@@ -950,6 +951,7 @@ static inline void nvmet_auth_sq_init(struct nvmet_sq *sq)
 }
 static inline void nvmet_destroy_auth(struct nvmet_ctrl *ctrl) {};
 static inline void nvmet_auth_sq_free(struct nvmet_sq *sq) {};
+static inline void nvmet_auth_sq_destroy(struct nvmet_sq *sq) {};
 static inline bool nvmet_check_auth_status(struct nvmet_req *req)
 {
 	return true;

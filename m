Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCFD563FC2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957670; cv=none; b=BC7kEx7EAA4pcwcXDcAFO24rSUFXNx/44O5d5IMihgwLF/MsSa0XzOTXAhX9RmvI1jZG58/4R+pH7CjrzPjPrr18Hj2ZVts2mPHJnK8/bCyvgNRSYFdCB3kJVCr4oWpY/U53ZhSe/o3Nop/jGhrxZCghC/i2dJdPnDvsx1V07ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957670; c=relaxed/simple;
	bh=SXO0mtw+sSIG4txKmjZQW1r65Sxb4IYdffOYwQxrAZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jznUVMvAuWx3kJhdf/ltgb4PxAMLObLI56/oZxO3DukdvUSzujCOnrsGY+cBzJG6y+QpgBSf2fw/ocFbzcM+rcdbU+tF8poaU+aUwdgZLxULlcMWakiUFRi8SqQA2VRydbkjEu2jFWNyDW54+IQyr/78YntW9E8uMJ1yF1VFqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP1BwQib; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP1BwQib"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc02279so149038a91.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 05:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788957668; x=1789562468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=thzxVM4avjGKd/X9MVnCvCDKDK1Ou2yg9mkj+HkrUD0=;
        b=eP1BwQibEGNAzL1FOoW02WzDB1XJL7J41D7SgfWDAwW9C8Q4Dd0+AxnHG3YdzWLtpU
         91FSFxWL2oObq3ssSx6zfKD/meNU6kg2W/0+3QUqvqMAeEPFzC75uu77oseottihu9MP
         ORk74VP3GDEfUXhCiP80OxSlQ/k3vkWSqeAYG/PMdodm2Wy7kbo00OM8WteJSvH/3jA6
         zTCDK1FvL2gjV+O6d2eFFJL9WUwo8WAliL1gc+Vpel414HFpBMftE29rEnMXO4pdoPq9
         rm/fEmfZllzEgzJWRUk3vAhHD8zRdq4FeAps/P38PpocBGdL7uaNLu4yS+h5kKrZXuBN
         2O/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788957668; x=1789562468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=thzxVM4avjGKd/X9MVnCvCDKDK1Ou2yg9mkj+HkrUD0=;
        b=FFW9J1HsVDfbNLQNtamdIl+pr2WQVft0BjErxdNA/oacWuVRnzCjYf7vG/f78perjj
         qVyMRpBlmwluomQrXzdo5XQgyVdaz6ye+Q0vnLRWC9caCd/R6+SrbH4lczEe5gXAis8T
         JdqcPSOMdgkDo25eMF1srKhtjWy869R+sgaYX7XaGhrIzm+axvJ5v0dPBTUwgxPDA8x7
         wAKYYHpWuZI21TwrZGFY50DG9O28goxP/nxxmqo8ZeIFV92JfvaPtSLkOBCn29iyS0uJ
         lfudutZJWhRl+I1diHtaWQNSMHYDkJD0LcdrL1HzLT0QPVFrcv0DR6T6tsvCZUSS7z6U
         oPIA==
X-Gm-Message-State: AFuF++nf0ciB2O0LDKBmKVcLOLuYO1piY8e5tdmgQlmz6vh+fW0/8P1h
	wyRnkMEuTQMb3ydHf0G/LtzB5er4Q3spPq8vg8BwJPn5KHYx6PbSAL/Gv9UuhA==
X-Gm-Gg: AYBFou2kSRcPbtrcEYo70Bxv1+XwX0zYRGyOoQAvvRn2FjJ7DGpZiumHs1Njoa/OCbk
	pVgLR4jsfOmizjr9xUjVmt5163sWSj878v+jkRh3xw3SN7MuewSHcO8a+jkc6QvKlv1b74+KAjo
	1OpcoPHGnBFdc9FatGLSRE/BBXM+tHsehM1q56f/v3jNzNcb+9u365TH/qiaOrZurQzdFpor4Le
	uEoaLH1BsXyl5bPt8oiDm1hm24dMqiSBGBZTZ558s+MejMOl7v61w62iSekHUlCgqG4GalEGPgn
	/BdaCKR2k0mWFXhgzUEp4g7CSedvePfXu1OjkqCl2sVyRPQvkgyHx7urnXnwpDUl5oD/3JZtwRk
	FrN+jWQAlhMqK8t4Duhx9OeLNW9bgDd4SA+wlL6pJmQEy3x1e9znRSaZ+tBTRtsmC7lBKJaM/E8
	bw96YRoC9vq7KIaLhCbMYBC/wAnHEpCWNGzBRjbFX/xp6Q3v41PqtpZ/1lk0NQbXzCwEE0QNWA1
	82RkZdK
X-Received: by 2002:a17:90b:3fc3:b0:39a:e002:f192 with SMTP id 98e67ed59e1d1-39d70b57638mr803410a91.22.1788957667899;
        Wed, 09 Sep 2026 05:41:07 -0700 (PDT)
Received: from hnkz-ubuntu-server ([2404:7a80:860:3300:f22f:74ff:feda:3295])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ba0a7b2c3sm8293136a91.0.2026.09.09.05.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:41:07 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: stable@vger.kernel.org
Cc: Kazuki Hanai <hnkz.64@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.12.y] nvmet-auth: Synchronize timeout work during SQ teardown
Date: Wed,  9 Sep 2026 21:40:48 +0900
Message-ID: <20260909124048.1793677-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090904-flagstick-wrongdoer-b9ae@gregkh>
References: <2026090904-flagstick-wrongdoer-b9ae@gregkh>
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
index b47d675232d2..38d1ced21f53 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -241,6 +241,12 @@ void nvmet_auth_sq_free(struct nvmet_sq *sq)
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
index ce85b5783260..6267c6d576db 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -812,7 +812,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	wait_for_completion(&sq->confirm_done);
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
-	nvmet_auth_sq_free(sq);
+	nvmet_auth_sq_destroy(sq);
 
 	/*
 	 * we must reference the ctrl again after waiting for inflight IO
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 17a63bc7d80c..25bba2d09762 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -737,6 +737,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
+void nvmet_auth_sq_destroy(struct nvmet_sq *sq);
 int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id);
 bool nvmet_check_auth_status(struct nvmet_req *req);
 int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
@@ -761,6 +762,7 @@ static inline void nvmet_auth_sq_init(struct nvmet_sq *sq)
 }
 static inline void nvmet_destroy_auth(struct nvmet_ctrl *ctrl) {};
 static inline void nvmet_auth_sq_free(struct nvmet_sq *sq) {};
+static inline void nvmet_auth_sq_destroy(struct nvmet_sq *sq) {};
 static inline bool nvmet_check_auth_status(struct nvmet_req *req)
 {
 	return true;
-- 
2.53.0


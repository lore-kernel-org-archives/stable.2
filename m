Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9198437F31D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958345; cv=none; b=UOEwbagFg64IiODFuKVf97aV0kIQjujLZ6WaAMiChLmqSSlV82CJG41xy221qWGI4+div6hsOTAy15oFP648Ts1ElGDPWhsCBSBTNUhrjw+EpFJOa/VbREiJFANfc2DQLlJ7hyCk58GfBPQMzDb1zy8e9aJug9pDHi/Qer3ZuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958345; c=relaxed/simple;
	bh=VJX5d9VOEJkpqrZkc7WBtPOG/1CToeK5Y8sJFVR6QhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2yX3rpbfEQk8XR1xpOL++xDNYHppP24++D0xvOo60wfwqlKsgJrIyuWIiwplUMtUwMzQEa9dUEm15bpWGLSMcVOdaeuVx14jpxT77CM7MwnLNICwKu6rrccan1yTx+SexH7+T4Sh6w5SgKVQO1dCAPtNJGJEZYREWNVwQbzMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qulba2go; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qulba2go"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ceb47d53so514800a12.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788958344; x=1789563144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=McDZE6BMTiPzOebjG4AUmwI9Osg+271QF+wG2H9Onp0=;
        b=qulba2goUwNPaLPwaglqtOVNp+O5mFS3I95eWB19wm2n48oC3oM6QmjUe0NkkyhAXQ
         fBOSCJMgD0oUU/Lhc5XMkKYixM/1UEZugcyIomosaY4B25R2DLGXTpwRAXVPR0qgu+DV
         MKIkrj913nDNTmpWevWiyvmhDGP4xQPmSWJsVy2kyEaJ2R+C+iP6Zhc8srTTT90ZZRUa
         HPJAPrYIJPeRHshu9c4CHnUuRvm7oztAHNFTp6Krz73ymr1LXsWvBMAhE/yXTrCwCtnD
         b+RJUYB7YAewPt0sAECaquSNnKm9JdYuRrskfXIZEhtzy7pEJWgbd/iRutDl0nmi0Qiu
         jLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958344; x=1789563144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=McDZE6BMTiPzOebjG4AUmwI9Osg+271QF+wG2H9Onp0=;
        b=maHnCiN+7Efx0pfVF9ywoigcqZrKjFKO7Gkhz1q3qSVBkg9FPBemr4SeFSfIDwToNV
         xrpKiwvCbhT+wanDGxMvkV5tOrec0emZNQL7RfxUcqJPh8PwD8sbRyAoJaaN5VeFwQ+y
         fDDHzShmt0QLg35YXM6dEuQkQrnbuKJ1bFv0HH/lNj+q8ZDU6S2PEkO7tkYwZNdmd2UN
         XjyKWsPGLltc56iuI27IRdUAiJ50OD8aQ3yuTl6ANlm+tmORilIT+jFnvga3+ehU90bw
         5kZhMSJQBihn+HudvtLw5VzNdJhc7XNY7+ypfK0OBO3AcvRClqg8nbVd7T5zwn+STpt5
         2V8A==
X-Gm-Message-State: AFuF++mm3VANdcPtL8yIErisFBW1e56ONav3+M5VTzL30cPajQl+PLPL
	G+4Szw2Aj3CFgOEEUtqIPlKrzRSeEiT1ZZ0jZuVfs+NPzE6hk5yQpA1ChM+r+g==
X-Gm-Gg: AYBFou1p6pA8vDitKjoWEC8ev9YIStfE1wsIPGgtkeMGadJ4NN8utoVuNpbHCILJv+N
	pfPuB4bZrQUvyXszUgsbMeJMA6OLi1K1Qdfgty3pg+Q8D3wMeyk8rIxq8OfLdj17ErDWl3tKB2X
	qyEUUoWTjY4OLEQ3f8HVZlvRFMhtN4/xpZQksDBZeuFgBKug9NHKhXuA5Gadh2g9/wToD6wlfk4
	F9jvxXN9M+w3dHdpQF2/AnY9mKU/2tcj2iSoign095mcFK6zk0BXDLaLTVZq2UxOZy+uzjIGolc
	yuOLeSAF6ESQHo3LivFN19AxaJsRlsxuosDdsrOdeOdVhRNNVu0porqFHzB9FP2fRAVsatzPwsx
	ZWrFm5x7l1ndPHM7iS+pz9/4kh5adqgXZD2HPFKqHSNFgrGzdaVQwi0CeXBPC9RaJilLB3Tgk8c
	IyvKABTcnEf7qKZC7GBpH9yh3RycZohfvXpjdGehD3t7jwWTChS5yJnEfOPkn9amxCZWKWieRCE
	o5BLzVV
X-Received: by 2002:a17:90b:2e0c:b0:38e:7297:a92e with SMTP id 98e67ed59e1d1-39b8be7ba4amr9281199a91.9.1788958343664;
        Wed, 09 Sep 2026 05:52:23 -0700 (PDT)
Received: from hnkz-ubuntu-server ([2404:7a80:860:3300:f22f:74ff:feda:3295])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d086adsm39326455a91.15.2026.09.09.05.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:52:23 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: stable@vger.kernel.org
Cc: Kazuki Hanai <hnkz.64@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.6.y] nvmet-auth: Synchronize timeout work during SQ teardown
Date: Wed,  9 Sep 2026 21:52:09 +0900
Message-ID: <20260909125209.1798946-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090904-demeaning-untidy-b054@gregkh>
References: <2026090904-demeaning-untidy-b054@gregkh>
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
index 9fe6ad89bf83..b3a0e1946453 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -227,6 +227,12 @@ void nvmet_auth_sq_free(struct nvmet_sq *sq)
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
index e435996c5537..3b1b72022a97 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -804,7 +804,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	wait_for_completion(&sq->confirm_done);
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
-	nvmet_auth_sq_free(sq);
+	nvmet_auth_sq_destroy(sq);
 
 	/*
 	 * we must reference the ctrl again after waiting for inflight IO
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c0648216b9e4..c037d1daf94d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -704,6 +704,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
+void nvmet_auth_sq_destroy(struct nvmet_sq *sq);
 int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id);
 bool nvmet_check_auth_status(struct nvmet_req *req);
 int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
@@ -728,6 +729,7 @@ static inline void nvmet_auth_sq_init(struct nvmet_sq *sq)
 }
 static inline void nvmet_destroy_auth(struct nvmet_ctrl *ctrl) {};
 static inline void nvmet_auth_sq_free(struct nvmet_sq *sq) {};
+static inline void nvmet_auth_sq_destroy(struct nvmet_sq *sq) {};
 static inline bool nvmet_check_auth_status(struct nvmet_req *req)
 {
 	return true;
-- 
2.53.0


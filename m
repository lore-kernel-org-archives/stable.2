Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844099;
	b=XqPitzrkR2U7qMCgLhWoQmDCu72DYJe5h+PbDBCGNoasAVtpUP0M2DWSDW5nF4I3ynor
	 l4l3xYqid5PHzdUFGsuBbsUZp/8RIO7eT35gejn1TUdCDmFOGooT2o+0fher1gsVOiVK8
	 qtIM/+K0zOe8SXcQwdpuPB3kme3eL4Cv6R/OjdvqDKETXILzz7RO7UmB7ecYmvvAM+K0W
	 OJWtRfIQq8IKrEQCnU0OAsAk9e+W/c5lQnKXMAxrUEf7hQaH9eGje4giOrSNyzEWONuGL
	 rPo+GFirQrnrZ8f/xwDOoCpyGNhioCZ6nRcSYp7Vc9luaFrCQrCMqQVRKJixFwKRV7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844099;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=J8vvnvUw5Y15snAKS676ImL8ivNTqAjo7VVv26iSDts=;
	b=ysxlf+2Y/d97UDr3fpm7qkbOhdVel4XIkmxl4rIBMxZ7t8rRj1+Jf5GqAu7qeq/0QDyy
	 Oks7/zrpYmjOmX6uXttMy2qjmB6D2FgpSB2yZjdcOFow3wz1PITsNi5az4fQHYBttE06H
	 0dFeyidjy+lo8T+PDdr1josvSwGFB1bc91Os0zIcN8vH8iElxF9tX9JQ0UtWreQ/5hO9M
	 dfv5nJifjgqmhq595AlDDEq25TlsJ5WzfTgqgynkA6Epcq7IWFkeFAT5P6gR1aKOnqb0q
	 y54zfo5W7Vt8Z5wUQFDnD1X+ZD4x1O3JTD1dvQ8/n/Ecn6TmZe0R38/RDAvxnA/adbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxn76uaf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28750606A916
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxn76uaf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB761F00A16;
	Thu,  5 Nov 2026 02:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793844099;
	bh=J8vvnvUw5Y15snAKS676ImL8ivNTqAjo7VVv26iSDts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gxn76uafHkettAgmhHeGRvoEP4/B6HEVPGX8OIaDvjTJhmO2syZRFtIudhwyxysdK
	 0QdGJkNlfEL8mPBUwLmhLDV4i5UmUvBMCR8Oj9vqDaGmgMUp3pVRjI+J0AFQBQIotw
	 xPTaue42d+CynGNj5Z6Kta6aQ33P6LR9SCTf0bSmnZo+9YSmX/WdQpogOG3Vy99P3h
	 3ibNbPENZslT5dBu3dAJDCOVf0z4q3ifAhxkZiU1dGrwHDqGk7Z9hfEkrO7lOPXIaH
	 tPGW2sd3vpUqDE3eriIcHPnTYkskQYXSlblNMTIZjlZ98zkDsR0Q/XGkPXEWmFlx1K
	 nWh0zjmrRiGDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nvmet-auth: serialize access to DH-HMAC-CHAP state to fix UAF
Date: Wed,  4 Nov 2026 21:01:37 -0500
Message-ID: <20261105020040.1133449-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110458-unstylish-quit-5401@gregkh>
References: <2026110458-unstylish-quit-5401@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

[ Upstream commit 53f6efe00cea0c0cf7bd99debe3cdac8567170b5 ]

A REPLY AUTH_SEND command can derive a dhchap_skey key while a
concurrent AUTH_RECEIVE command observing this REPLY state executes
the failure path and frees that key. The REPLY command then continues
and writes into freed memory, causing a use-after-free. KASAN reports
it as:

  BUG: KASAN: slab-use-after-free in __sha256_final
  Write of size 4 at addr ffff88800359c540
  ...
  nvmet_auth_sq_free (drivers/nvme/target/auth.c:237)
  nvmet_execute_auth_receive (drivers/nvme/target/fabrics-cmd-auth.c:621)

Add a mutex to each submission queue to serialize authentication
commands and timeout handling. Unlock the mutex before completing
requests and ignore outdated timeout callbacks. Limit timeout delays
to prevent immediate expiry on 32-bit kernels.

Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ sashal: adjusted context for the existing system_wq name and nvmet_sq field layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/auth.c             |  1 +
 drivers/nvme/target/fabrics-cmd-auth.c | 32 ++++++++++++++++++++++----
 drivers/nvme/target/nvmet.h            |  2 ++
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index b3a0e19464539..59762bbb98da3 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -218,6 +218,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 
 void nvmet_auth_sq_free(struct nvmet_sq *sq)
 {
+	sq->auth_expiry_active = false;
 	cancel_delayed_work(&sq->auth_expired_work);
 	kfree(sq->dhchap_c1);
 	sq->dhchap_c1 = NULL;
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 990bb7af4dc8b..454a01fe00f2c 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -6,6 +6,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/blkdev.h>
+#include <linux/jiffies.h>
 #include <linux/random.h>
 #include <linux/nvme-auth.h>
 #include <crypto/hash.h>
@@ -17,16 +18,27 @@ static void nvmet_auth_expired_work(struct work_struct *work)
 	struct nvmet_sq *sq = container_of(to_delayed_work(work),
 			struct nvmet_sq, auth_expired_work);
 
+	mutex_lock(&sq->auth_lock);
+	/* A command may have cancelled or rearmed this timeout. */
+	if (!sq->auth_expiry_active ||
+	    delayed_work_pending(&sq->auth_expired_work))
+		goto out_unlock;
+	sq->auth_expiry_active = false;
+
 	pr_debug("%s: ctrl %d qid %d transaction %u expired, resetting\n",
 		 __func__, sq->ctrl->cntlid, sq->qid, sq->dhchap_tid);
 	sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
 	sq->dhchap_tid = -1;
+out_unlock:
+	mutex_unlock(&sq->auth_lock);
 }
 
 void nvmet_auth_sq_init(struct nvmet_sq *sq)
 {
 	/* Initialize in-band authentication */
+	mutex_init(&sq->auth_lock);
 	INIT_DELAYED_WORK(&sq->auth_expired_work, nvmet_auth_expired_work);
+	sq->auth_expiry_active = false;
 	sq->authenticated = false;
 	sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
 }
@@ -202,6 +214,8 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	u16 status = 0;
 	u8 dhchap_status;
 
+	mutex_lock(&req->sq->auth_lock);
+
 	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		req->error_loc =
@@ -227,8 +241,10 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			offsetof(struct nvmf_auth_send_command, tl);
 		goto done;
 	}
-	if (!nvmet_check_transfer_len(req, tl)) {
+	if (unlikely(tl != req->transfer_len)) {
 		pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
+		mutex_unlock(&req->sq->auth_lock);
+		nvmet_check_transfer_len(req, tl);
 		return;
 	}
 
@@ -353,10 +369,12 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			 status, req->error_loc);
 	if (req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2 &&
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
-		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
+		unsigned long auth_expire = min_t(u64, MAX_JIFFY_OFFSET,
+			(u64)(ctrl->kato ? ctrl->kato : 120) * HZ);
 
+		req->sq->auth_expiry_active = true;
 		mod_delayed_work(system_wq, &req->sq->auth_expired_work,
-				 auth_expire_secs * HZ);
+				 auth_expire);
 		goto complete;
 	}
 	/* Final states, clear up variables */
@@ -365,6 +383,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		nvmet_ctrl_fatal_error(ctrl);
 
 complete:
+	mutex_unlock(&req->sq->auth_lock);
 	nvmet_req_complete(req, status);
 }
 
@@ -483,6 +502,8 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	u32 al;
 	u16 status = 0;
 
+	mutex_lock(&req->sq->auth_lock);
+
 	if (req->cmd->auth_receive.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		req->error_loc =
@@ -508,8 +529,10 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 			offsetof(struct nvmf_auth_receive_command, al);
 		goto done;
 	}
-	if (!nvmet_check_transfer_len(req, al)) {
+	if (unlikely(al != req->transfer_len)) {
 		pr_debug("%s: transfer length mismatch (%u)\n", __func__, al);
+		mutex_unlock(&req->sq->auth_lock);
+		nvmet_check_transfer_len(req, al);
 		return;
 	}
 
@@ -577,5 +600,6 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
 	}
+	mutex_unlock(&req->sq->auth_lock);
 	nvmet_req_complete(req, status);
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 09778c5d26791..cc74886cb3b0a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -108,7 +108,9 @@ struct nvmet_sq {
 	u32			sqhd;
 	bool			sqhd_disabled;
 #ifdef CONFIG_NVME_TARGET_AUTH
+	struct mutex		auth_lock;
 	struct delayed_work	auth_expired_work;
+	bool			auth_expiry_active;
 	bool			authenticated;
 	u16			dhchap_tid;
 	u8			dhchap_status;
-- 
2.53.0


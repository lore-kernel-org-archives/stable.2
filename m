Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802601;
	b=eqdB1slXJ6eTs0KlsCmhMDMdi/wZKwH9cRzzTbuPF+URDPJUEmGb3EH4qN+HxmAJz7Fs
	 59y7V0AcZ0aQATlRu9zGHPQdLeuTjursw2Qz/AmK0mmdzRYV3eUSOArsu3MxLwIUuyGN8
	 DJ7osmMrQ0/o+DlQ8yFzRAbPpHa92L0g5UYI+1OlzpFtwKfx+aRCVsYuLGWAkRKvJFKEx
	 4dOR0dSMnGK03I3JLH27OKFnjXLjnBBKc5irJvlA+9/UyqFgOkoH6t5epPHDT3nGG62lG
	 zY9JA+l5yBiq0dDdnnj0cMw1qXFdJTqaFykU9aL+pXLDPygdbvlR/qmSJ/xq0ulqELQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802601;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aisc/z7fwZc5IsSoEe4hbxfQEFnhFlkifQDVnoVzTNU=;
	b=pWdoOvRe+9S1cGTXbtIPVb16YB+ck598XNuMSaZX16VND51QWZY7Xjzp01Ty+Jwk23rz
	 NBSV3lWT7ZJxTHSGzqRTmZqMQSb/dh6XgQA98iSYfMpSWjnL4rGtTQFkt8fNy/nHDvuCo
	 tElyBQciS2SD0uwZCcjg9iOPbHurZ2h6+xVgopGy2G2QEDdFfhBF/0G5ePKz6eFlJHrVe
	 M9EA9fU+nadouQILv/E6LD9K8l4FvCOExwfaQh7lz5B1D/OwQAdB3OC6bcF3bDsjWmBAD
	 NTCmAqaAfi0hS1ZNYz7/JPTU6HJLhp5Lm5VD/o1JlHolej/Q6vjjT/KZSqxhg6W3M+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=j1roFFif;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3B8606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=j1roFFif
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803EF1F000C1;
	Wed,  4 Nov 2026 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802600;
	bh=aisc/z7fwZc5IsSoEe4hbxfQEFnhFlkifQDVnoVzTNU=;
	h=Subject:To:Cc:From:Date;
	b=j1roFFifRsAi/po51/roFpdSr+A0F/8D8akc3QH2coy+xTcWQkTEzqLXvzR1jjbSD
	 LCR9NH0wJOzIidakYgx0fq6Gi5bh5XySmgnHX7NoE+E9s9nj63bNy9eidLyyBPcDQZ
	 RxBmAaKMrp9Nkg/cH0xKBTsJWVTVaZq452/C0+2A=
Subject: FAILED: patch "[PATCH] nvmet-auth: serialize access to DH-HMAC-CHAP state to fix UAF" failed to apply to 6.6-stable tree
To: Jeremy.Jean@oss.cyber.gouv.fr,hch@lst.de,kbusch@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:29:58 +0100
Message-ID: <2026110458-chariot-kinfolk-545d@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 53f6efe00cea0c0cf7bd99debe3cdac8567170b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110458-chariot-kinfolk-545d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 53f6efe00cea0c0cf7bd99debe3cdac8567170b5 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Date: Sat, 3 Oct 2026 21:01:55 +0000
Subject: [PATCH] nvmet-auth: serialize access to DH-HMAC-CHAP state to fix UAF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index a55319bcdbd1..1680e5e6839c 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -229,6 +229,7 @@ out_unlock:
 
 void nvmet_auth_sq_free(struct nvmet_sq *sq)
 {
+	sq->auth_expiry_active = false;
 	cancel_delayed_work(&sq->auth_expired_work);
 	kfree(sq->dhchap_c1);
 	sq->dhchap_c1 = NULL;
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 92f8a76f10ff..e94d8bb8a934 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -6,6 +6,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/blkdev.h>
+#include <linux/jiffies.h>
 #include <linux/random.h>
 #include <linux/nvme-auth.h>
 #include <crypto/kpp.h>
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
@@ -256,6 +268,8 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	u16 status = 0;
 	u8 dhchap_status;
 
+	mutex_lock(&req->sq->auth_lock);
+
 	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		req->error_loc =
@@ -281,8 +295,10 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
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
 
@@ -406,10 +422,12 @@ done:
 			 status, req->error_loc);
 	if (req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2 &&
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
-		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
+		unsigned long auth_expire = min_t(u64, MAX_JIFFY_OFFSET,
+			(u64)(ctrl->kato ? ctrl->kato : 120) * HZ);
 
+		req->sq->auth_expiry_active = true;
 		mod_delayed_work(system_percpu_wq, &req->sq->auth_expired_work,
-				 auth_expire_secs * HZ);
+				 auth_expire);
 		goto complete;
 	}
 	/* Final states, clear up variables */
@@ -418,6 +436,7 @@ done:
 		nvmet_ctrl_fatal_error(ctrl);
 
 complete:
+	mutex_unlock(&req->sq->auth_lock);
 	nvmet_req_complete(req, status);
 }
 
@@ -536,6 +555,8 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	u32 al;
 	u16 status = 0;
 
+	mutex_lock(&req->sq->auth_lock);
+
 	if (req->cmd->auth_receive.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		req->error_loc =
@@ -561,8 +582,10 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
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
 
@@ -621,5 +644,6 @@ done:
 		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
 	}
+	mutex_unlock(&req->sq->auth_lock);
 	nvmet_req_complete(req, status);
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a0bd05603271..e315f1c24e73 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -159,8 +159,10 @@ struct nvmet_sq {
 	u32			sqhd;
 	bool			sqhd_disabled;
 #ifdef CONFIG_NVME_TARGET_AUTH
+	struct mutex		auth_lock;
 	bool			authenticated;
 	struct delayed_work	auth_expired_work;
+	bool			auth_expiry_active;
 	u16			dhchap_tid;
 	u8			sc_c;
 	u8			dhchap_status;


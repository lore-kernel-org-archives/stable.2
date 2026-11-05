Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887092;
	b=Y/TBXCKDKkf0wHxp1xMfJ5REUs0dKp7wogT5+qpyAvV7s2QXzDoAoX/oa0DI5KXTyOLE
	 U+6jN3c+0Rw7DVvzMwW6hdo3WleyRSvfwbvXGTR+vvZW9xj4R4W3aGk/y5KY1BfSske8v
	 ZNe2eGWDbrxYTP3/xYpv8unrMclOp0bkUKm6zNI6iIWCBYRy/f1zbM2ONSrtbMv7V/ab9
	 2vsoDf1Wz7wh15jAbfpbzrIZ06Rpf3FI+l0YVjiRk6A1MKuQQ+FiILfZxQjWyKdcZjjR9
	 yQLmGHAyEQpoAFS9kS95sqYEE6/Qy0El98HnIAV9LfVI4eXtxRTPegc0G1c7/i594bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887092;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=Y3NyyVjQB+A++lsAg4cv+f/TphKmY+7HKHATxrw4K5w=;
	b=GVw935qzcwynIZJlh+/XFK7f++/MBJDEIScMFpEKH1rWkqeEbT0gCJKC6GO5OuSh9nOg
	 zzjrNpfMfc+rNzHhPYiv3EOZfkXyXruFCgZhTKzhtvLKkQKS3h2mJGItkBVFg4veABMA4
	 sYNtms8CL1tvkRdugwlo3Ll/teejDaljGoIRchn+LdNKAcEHXrYEbCm/FSgDsyDsq00CK
	 gfHRPNOre4E2SVXMojjnznfFerq9FZvYqyZVCQslKjwMkEysTdjTCrPhESkCd68m9b5vY
	 z/S6ZJd+3dlEeDFGYmqtgPBcy4rIt/vOVxLmasixPrydzofqAVziw70IIaCIbVQYp8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AB606A326;
	Thu,  5 Nov 2026 13:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A71AB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jL3mf2cjSz8Xrr9;
	Thu, 05 Nov 2026 21:58:10 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6A5Dvwkk060232;
	Thu, 5 Nov 2026 21:57:58 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 5 Nov 2026 21:57:59 +0800 (CST)
X-Zmail-TransId: 2afc6aec8b67eb2-cf609
X-Mailer: Zmail v1.0
Message-ID: <20261105215759419k4-bV6cgNlque5OLcc4E9@zte.com.cn>
In-Reply-To: <20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn>
References: 20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn
Date: Thu, 5 Nov 2026 21:57:59 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvMl0gbnZtZXQ6IHplcm8gb3V0IHVudXNlZCBkYXRhIG9mIGZpeGVkLXNpemUgbG9nIHBhZ2Vz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A5Dvwkk060232
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 05 Nov 2026 21:58:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEC8B72.000/4jL3mf2cjSz8Xrr9

From: Shao Mingyin <shao.mingyin@zte.com.cn>

Several Get Log Page handlers copy a fixed-size structure to the host
buffer and return success, without initializing the rest of the buffer
the host asked for.  The requested data length (NUMD) is supplied by the
host, so it can be larger than the structure being returned.

The transports allocate those buffers with sgl_alloc() or kmalloc(),
none of them with __GFP_ZERO, and on success they send the whole
transfer length back to the host.  A host requesting more than the size
of the log page therefore receives stale kernel memory from the target.
This is the same class of bug as the one fixed for Zone Management
Receive in commit 31b8a6af19b7 ("nvmet: zns: don't leak stale memory in
zone management receive").

Zero the unused tail after filling the Supported Log Pages, Commands
Supported and Effects, Supported Features, Endurance Group, Reservation
and Rotational Media Information log pages.

The Rotational Media Information log used to reject a host buffer that
was larger than the fixed structure.  Accept that and zero the tail
instead, like the other handlers.

The Error log page needs more than a zeroed tail.  Clamp the ring walk
to the requested length, zero the remaining bytes, and propagate
nvmet_copy_to_sgl() failures instead of completing with success.  The
ring is walked backwards from the slot of the last error because the
NVMe base specification requires the most recent error to be the first
log entry.

The Reservation log tail is zeroed after the log_mgr lock is dropped:
the host controls the length, so the buffer can be large.

Fixes: 11ad507784ed ("nvmet: add error log page cmd handler")
Fixes: 83acb24e6de7 ("nvmet: implement supported log pages")
Fixes: 0866bf0c3778 ("nvmet: add commands supported and effects log page")
Fixes: e973c91727d4 ("nvmet: implement supported features log")
Fixes: 266b652c65b4 ("nvmet: implement endurance groups")
Fixes: 5fd075cdaf36 ("nvmet: implement rotational media information log")
Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with an nvmet-tcp target
and a file-backed namespace; the target's data pages are primed with
0xaa by a preceding 1 MiB write.

A Get Log Page for Supported Log Pages with a 4096-byte transfer
(NUMD 1023) asks for four times sizeof(struct nvme_supported_log), so
bytes 1024..4095 are never written by the handler:

  unpatched                            patched
  tail[1024..4095] = 0xaa (10/10)      tail zeroed (0/10)

The Rotational Media Information and Reservation log changes, and the
error log ring clamp, are not runtime-tested: the test guest has no
rotational namespace, no persistent-reservation setup, and no injected
command error.
---
 drivers/nvme/target/admin-cmd.c | 53 +++++++++++++++++++++++++++++----
 drivers/nvme/target/pr.c        |  7 +++++
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 26028be8fe4d..434fa543019a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -176,16 +176,29 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	unsigned long flags;
-	off_t offset = 0;
+	u32 offset = 0;
+	u32 len;
 	u64 slot;
 	u64 i;
+	u16 status = 0;
+
+	len = min_t(u32, req->transfer_len,
+		    NVMET_ERROR_LOG_SLOTS * sizeof(struct nvme_error_slot));
 
 	spin_lock_irqsave(&ctrl->error_lock, flags);
+
+	/*
+	 * The NVMe base specification requires the most recent error to be
+	 * the first log entry, so walk the ring backwards from the slot of
+	 * the last error and stop at the end of the requested buffer.
+	 */
 	slot = ctrl->err_counter % NVMET_ERROR_LOG_SLOTS;
 
-	for (i = 0; i < NVMET_ERROR_LOG_SLOTS; i++) {
-		if (nvmet_copy_to_sgl(req, offset, &ctrl->slots[slot],
-				sizeof(struct nvme_error_slot)))
+	for (i = 0; i < NVMET_ERROR_LOG_SLOTS &&
+	     offset + sizeof(struct nvme_error_slot) <= len; i++) {
+		status = nvmet_copy_to_sgl(req, offset, &ctrl->slots[slot],
+					   sizeof(struct nvme_error_slot));
+		if (status)
 			break;
 
 		if (slot == 0)
@@ -195,7 +208,20 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 		offset += sizeof(struct nvme_error_slot);
 	}
 	spin_unlock_irqrestore(&ctrl->error_lock, flags);
-	nvmet_req_complete(req, 0);
+
+	/*
+	 * Zero what the ring walk did not fill: either the tail beyond the
+	 * fixed log, or the partial entry at the end of a short request.
+	 */
+	if (req->transfer_len > offset) {
+		u16 zero_status;
+
+		zero_status = nvmet_zero_sgl(req, offset,
+					     req->transfer_len - offset);
+		if (!status)
+			status = zero_status;
+	}
+	nvmet_req_complete(req, status);
 }
 
 static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
@@ -222,6 +248,9 @@ static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
 	logs->lids[NVME_LOG_RESERVATION] = cpu_to_le32(NVME_LIDS_LSUPP);
 
 	status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
+	if (!status && req->transfer_len > sizeof(*logs))
+		status = nvmet_zero_sgl(req, sizeof(*logs),
+					req->transfer_len - sizeof(*logs));
 	kfree(logs);
 out:
 	nvmet_req_complete(req, status);
@@ -303,7 +332,7 @@ static void nvmet_execute_get_log_page_rmi(struct nvmet_req *req)
 		goto out;
 	}
 
-	if (req->transfer_len != sizeof(*log)) {
+	if (req->transfer_len < sizeof(*log)) {
 		status = NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
 		goto out;
 	}
@@ -322,6 +351,9 @@ static void nvmet_execute_get_log_page_rmi(struct nvmet_req *req)
 		log->numa = cpu_to_le16(1);
 
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	if (!status && req->transfer_len > sizeof(*log))
+		status = nvmet_zero_sgl(req, sizeof(*log),
+					req->transfer_len - sizeof(*log));
 	kfree(log);
 out:
 	nvmet_req_complete(req, status);
@@ -437,6 +469,9 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	}
 
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	if (!status && req->transfer_len > sizeof(*log))
+		status = nvmet_zero_sgl(req, sizeof(*log),
+					req->transfer_len - sizeof(*log));
 free:
 	kfree(log);
 out:
@@ -528,6 +563,9 @@ static void nvmet_execute_get_log_page_endgrp(struct nvmet_req *req)
 	put_unaligned_le64(data_units_written, &log->duw[0]);
 copy:
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	if (!status && req->transfer_len > sizeof(*log))
+		status = nvmet_zero_sgl(req, sizeof(*log),
+					req->transfer_len - sizeof(*log));
 	kfree(log);
 out:
 	nvmet_req_complete(req, status);
@@ -602,6 +640,9 @@ static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
 		cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_NSCPE);
 
 	status = nvmet_copy_to_sgl(req, 0, features, sizeof(*features));
+	if (!status && req->transfer_len > sizeof(*features))
+		status = nvmet_zero_sgl(req, sizeof(*features),
+					req->transfer_len - sizeof(*features));
 	kfree(features);
 out:
 	nvmet_req_complete(req, status);
diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 14eaa99f98fa..99fdcbf572a9 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -130,6 +130,13 @@ void nvmet_execute_get_log_page_resv(struct nvmet_req *req)
 out:
 	status = nvmet_copy_to_sgl(req, 0, &log, sizeof(log));
 	mutex_unlock(&log_mgr->lock);
+	/*
+	 * Zero the unused tail outside the log_mgr lock: the host controls
+	 * the length, so this can touch a large buffer.
+	 */
+	if (!status && req->transfer_len > sizeof(log))
+		status = nvmet_zero_sgl(req, sizeof(log),
+					req->transfer_len - sizeof(log));
 	nvmet_req_complete(req, status);
 }
 
-- 
2.27.0

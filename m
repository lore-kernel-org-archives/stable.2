Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977228;
	b=jbnsEBIanavxiu+QRWhUHIe8oP9Tm8oZTJgva9wXoGkkW/Qg5dN26BRkBdoyjzjBt9zE
	 GjiSpLPOe8dPcweTdQVQZm+mXcQD+onLtt21gDJInG/dTZmMkZCkAaA2eXtRgT0stOTBf
	 KsIEBnFoRQQaDIDMzaAhd26Kaf0/sbhP2aUlQpI6yt2Sg1wHimiHvs9BohS3taTRrym76
	 kdwguFwbb99KM+G8cA1rbyXLmj+Qqw5R4r8aq/2AO+oIbVQVTYkMSYkbT/x1I1Kjs0Nld
	 iVAk0GI1xFqzdvI/IpAzHB6O9bQ8XgPNO6oGyA286/Wvrkbqft41xDIQozyoL3ujCPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977228;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=9t5fly3hO1PboXA0fMYf5Gqlfv6z0xmf1AD5NzOQdGI=;
	b=Wxo3qYvUhR3gjdCy29A+HAaYAjB9ciwzzcUmEMLf/ocln0HHSywQvfmKW13sX9eDqFo2
	 RcVW+DIGtW2mApA7BvhRB2QrYfpiTG+TNAnvq/JmHQLBYbnu8ZUaYIzTZZxQ5NO2gT+Er
	 1dADvn2/SGRrA6T4AJqO74NHp7kfZ9XtEnrXNWMOyB7R5xHlGI7zHjJDUSYH6RhDST0Rc
	 pC9K9pk7EGUXL7wcmGuJ8ND/Y85vEhRImdmHV17IwbSwBQoycvuhfBUUw4m9ZX/Il3Blx
	 QK1Xp+XiqHTypO9P6LIAwOZYSEA85z32dLCEzjNvBWAYiQUyrBzwfKx9x4wcA8hyAQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD8606A32D;
	Fri,  6 Nov 2026 15:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41AD8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLj6113Q9z4yjjK;
	Fri, 06 Nov 2026 23:00:25 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A6F0FMC036335;
	Fri, 6 Nov 2026 23:00:16 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 6 Nov 2026 23:00:19 +0800 (CST)
X-Zmail-TransId: 2afb6aedeb8359e-69562
X-Mailer: Zmail v1.0
Message-ID: <20261106230019343v9OWwbe7yzjYZeoO4htcW@zte.com.cn>
In-Reply-To: <20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn>
References: 20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn
Date: Fri, 6 Nov 2026 23:00:19 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvMl0gbnZtZXQ6IHplcm8gdGhlIGVudGlyZSBHZXQgTG9nIFBhZ2UgdHJhbnNmZXIgYnVmZmVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A6F0FMC036335
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 06 Nov 2026 23:00:25 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDEB89.000/4jLj6113Q9z4yjjK

From: Shao Mingyin <shao.mingyin@zte.com.cn>

Several fixed-size Get Log Page handlers copy only the log structure
and leave the rest of the host buffer untouched.  The transport buffers
are not zeroed, so a host requesting more bytes than the structure
receives stale kernel memory.

Zero the entire transfer length before filling the buffer in the
Supported Log Pages, Commands Supported and Effects, Supported
Features, Endurance Group, Rotational Media Information and Reservation
handlers.  For the Error log, also clamp the ring walk to the requested
length and propagate copy failures instead of completing with success.

The Rotational Media Information handler now accepts a buffer larger
than its fixed structure.

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
The uninitialized tail is made visible with page_poison=1
(CONFIG_PAGE_POISONING): freed pages are filled with 0xaa, so a
Supported Log Pages request that asks for 4096 bytes (NUMD 1023) shows
bytes 1024..4095 as 0xaa on the unpatched kernel.  The request is four
times sizeof(struct nvme_supported_log), so the handler writes only the
first 1024 bytes.

  unpatched                            patched
  tail[1024..4095] = 0xaa (10/10)      tail zeroed (0/10)

Without page poisoning the same bytes would carry whatever stale data
the target's page allocation returns; the patch zeroes them first.

The Rotational Media Information and Reservation log changes, and the
error log ring clamp, are not runtime-tested: the test guest has no
rotational namespace, no persistent-reservation setup, and no injected
command error.
---
 drivers/nvme/target/admin-cmd.c | 51 ++++++++++++++++++++++++++++++++---------
 drivers/nvme/target/pr.c        |  6 +++++
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 26028be8fe4d..6cb05d33f024 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -176,16 +176,35 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
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
+	status = nvmet_zero_sgl(req, 0, req->transfer_len);
+	if (status) {
+		nvmet_req_complete(req, status);
+		return;
+	}
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
@@ -195,7 +214,7 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 		offset += sizeof(struct nvme_error_slot);
 	}
 	spin_unlock_irqrestore(&ctrl->error_lock, flags);
-	nvmet_req_complete(req, 0);
+	nvmet_req_complete(req, status);
 }
 
 static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
@@ -221,7 +240,9 @@ static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
 	logs->lids[NVME_LOG_RMI] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RESERVATION] = cpu_to_le32(NVME_LIDS_LSUPP);
 
-	status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
+	status = nvmet_zero_sgl(req, 0, req->transfer_len);
+	if (!status)
+		status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
 	kfree(logs);
 out:
 	nvmet_req_complete(req, status);
@@ -303,7 +324,7 @@ static void nvmet_execute_get_log_page_rmi(struct nvmet_req *req)
 		goto out;
 	}
 
-	if (req->transfer_len != sizeof(*log)) {
+	if (req->transfer_len < sizeof(*log)) {
 		status = NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
 		goto out;
 	}
@@ -321,7 +342,9 @@ static void nvmet_execute_get_log_page_rmi(struct nvmet_req *req)
 	else
 		log->numa = cpu_to_le16(1);
 
-	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	status = nvmet_zero_sgl(req, 0, req->transfer_len);
+	if (!status)
+		status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 	kfree(log);
 out:
 	nvmet_req_complete(req, status);
@@ -436,7 +459,9 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 		goto free;
 	}
 
-	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	status = nvmet_zero_sgl(req, 0, req->transfer_len);
+	if (!status)
+		status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 free:
 	kfree(log);
 out:
@@ -527,7 +552,9 @@ static void nvmet_execute_get_log_page_endgrp(struct nvmet_req *req)
 	put_unaligned_le64(host_writes, &log->hwc[0]);
 	put_unaligned_le64(data_units_written, &log->duw[0]);
 copy:
-	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	status = nvmet_zero_sgl(req, 0, req->transfer_len);
+	if (!status)
+		status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 	kfree(log);
 out:
 	nvmet_req_complete(req, status);
@@ -601,7 +628,9 @@ static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
 	features->fis[NVME_FEAT_RESV_MASK] =
 		cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_NSCPE);
 
-	status = nvmet_copy_to_sgl(req, 0, features, sizeof(*features));
+	status = nvmet_zero_sgl(req, 0, req->transfer_len);
+	if (!status)
+		status = nvmet_copy_to_sgl(req, 0, features, sizeof(*features));
 	kfree(features);
 out:
 	nvmet_req_complete(req, status);
diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 14eaa99f98fa..b860cbe192cd 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -99,6 +99,12 @@ void nvmet_execute_get_log_page_resv(struct nvmet_req *req)
 	u64 cur_count;
 	u64 next_count;
 
+	status = nvmet_zero_sgl(req, 0, req->transfer_len);
+	if (status) {
+		nvmet_req_complete(req, status);
+		return;
+	}
+
 	mutex_lock(&log_mgr->lock);
 	if (!kfifo_get(&log_mgr->log_queue, &log))
 		goto out;

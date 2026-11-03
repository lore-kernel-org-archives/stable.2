Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732845;
	b=MFdNptsbwT3cpYm2wMp25zIiiBO64zP87KjZK9OKrDUCudr3HRqqvcU8dQgd8VATAumI
	 JEwrst0CJMJ1dE+POTftxRzTUSyLnWps6YogNfYRwh+WvHh2g1AcXiDMqXDrGIVoxvIGd
	 ucT+pqWvzGghHuV9f5z5eqWRQODLIDnFLDZ3701oQkDrDwAKKoCKBgMVgRK0nKr9beiUR
	 RTvBX5QwS/7FMipdNFf2RKkMHY63AnfPv5JfE/vi0GOC684VkpobFj7MDWq/k7SzuvMFr
	 uY1e/52HnqI6L70wQaNSDK/bL0dYHC7eSDUYhPqZwMIG2aZSj+sZZeY/jOR3rS2G9wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732845;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=5GFzxx3iTCNJhbuSD/q+9umx6gML7ap63zvkg3Gu3uU=;
	b=0x8Qjx5IYzh+lAccWBBYzOriG7XD2ODoj7VtVF+aDJLft1QNQVQzbV+zpiueGzd+0dsJ
	 Od2vWZN0xJgAAcnvnyGGx8w9XD3+iW0+hEb4JuKqYQqS42kz2siEqiTSNjiHIRYzbeErp
	 Mn3w0Ozxp20tC7Dd35r6OKwKlNrbyhTCgofR/IxAnA6TI3OxsAMklZS38pBsJxn5QQK8J
	 RNKxlC9Z5ENd0671dTmocfhMQrBBD5o5iIbiLEjT6Gxwckn8g0nqdVmQiEctKE5RGNXYT
	 1FgQMJA4obJkekiXT0y8LtPHrRPCkh89XeI9Ywk0V/CnudZFY/pPNiWAuRf06voEIIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF75606A336;
	Tue,  3 Nov 2026 19:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDF75606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jJykL0jZmz5B13Y;
	Wed, 04 Nov 2026 03:07:22 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A3J79Nf084249;
	Wed, 4 Nov 2026 03:07:09 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 03:07:14 +0800 (CST)
X-Zmail-TransId: 2afb6aea30e2942-d9e81
X-Mailer: Zmail v1.0
Message-ID: <20261104030714286L0-QmZfiJgl_w6jvQVKSm@zte.com.cn>
In-Reply-To: <20261104030707567QiZNPqBVEESVbvpNukFkY@zte.com.cn>
References: 20261104030707567QiZNPqBVEESVbvpNukFkY@zte.com.cn
Date: Wed, 4 Nov 2026 03:07:14 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDIvMl0gbnZtZXQ6IHBjaS1lcGY6IGNvbXBsZXRlIGZhaWxlZCByZWFkIGNvbW1hbmRzIGluc3RlYWQgb2Ygd2FpdGluZyBmb3JldmVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A3J79Nf084249
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Nov 2026 03:07:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEA30EA.000/4jJykL0jZmz5B13Y

nvmet_pci_epf_queue_response() completes a command directly when its
status is non-zero, without calling complete(&iod->done).  For commands
that transfer data from the device to the host (DMA_TO_DEVICE),
nvmet_pci_epf_exec_iod_work() clears no_wait and waits for iod->done
after req->execute() has returned.  If such a command fails
synchronously, for example because the request length or SGL is invalid
or because the backend rejects the command, the work item waits forever
on iod->done while the completion path has already queued the iod for
the completion queue work, which eventually frees it: the waiter is left
on a freed completion and the SQ worker is stuck.

Only decide whether the work item has to wait from the data direction
and length, and let it complete the command after the wait even when the
command failed.  This preserves exactly one
nvmet_pci_epf_complete_iod() per command and also wakes the waiter for
failed read commands.

Fixes: 746d0ac5a07d ("nvmet: pci-epf: Do not complete commands twice if nvmet_req_init() fails")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index a8df176c1a57..b12855b57b59 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1248,10 +1248,11 @@ static void nvmet_pci_epf_queue_response(struct nvmet_req *req)
 	iod->status = le16_to_cpu(req->cqe->status) >> 1;
 
 	/*
-	 * If the command failed or we have no data to transfer, complete the
-	 * command immediately.
+	 * If we have no data to transfer back to the host, complete the
+	 * command immediately.  Otherwise wake up the work item, which
+	 * transfers the data and completes the command even if it failed.
 	 */
-	if (iod->status || !iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
+	if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
 		nvmet_pci_epf_complete_iod(iod);
 		return;
 	}
@@ -1659,7 +1660,7 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 	wait_for_completion(&iod->done);
 
 	if (iod->status != NVME_SC_SUCCESS)
-		return;
+		goto complete;
 
 	WARN_ON_ONCE(!iod->data_len || iod->dma_dir != DMA_TO_DEVICE);
 	nvmet_pci_epf_transfer_iod_data(iod);

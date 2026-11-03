Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687442;
	b=krlGvWsQDzJQoiqe9KO4zagEdtsYuz2lkmOPz7ZINeDgdf9PZG8GbIb8pKLhf+3oVCBz
	 C1hs8i6ryQPDZgcwkK8pmRiNCkJzG84TFTGr652orwoyBWBymgxmiQYC+6AI6f8Fwjymd
	 247yfbpNEpuh8KLwaTBUweoFL02HCIv9BWw0ZbvHbW8xHQo8+qSTwotiR9oAwmVbuaTbP
	 6Y9CJm32NYdre9JjkW0E6wR2vU1EkRmHs6OMqqN+qImqMTBnTAn4Mt+6x4JnVmyXiN50T
	 1ZUejcgJnX8ZrmmZ3p2hexJue3G1p0KNs+mzqXJSiqaNh/h/vwS0bmLF9ifNKXdxyEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer;
	bh=1e5yiaXntYJQtqK8uc9nIplampCx3pEWFOJaZHKAJjI=;
	b=aXkQUU5EIRFIy0PQjJsn66YAhMS48W2IUzHNkOPbK3rYfIsuRZrVSNtkqEivhvCGDqdm
	 bArNkM3h6soFBGx8srnps5EW6oIqwSfhecmoYaONcj027iPIwZlVrCDaxjeI5/jx00dz1
	 ENeCdJeUz/WNkdaq465/6wrvY4zLggbH1etYqvYUn5HwlRJ2A9oMXG5ihV5epU8sWS/48
	 69jamZTFeqkIz7Bqsuqf5iSGMqMipPuANhszokxrz1mtDOT4Kj9djnyw++dWsX69a8ROZ
	 0HMzsam2pvA/BITGycrb/hI7UUuSYHrpYwzKrKZfrYNewp6T6zfLyD9p+6EpphGa2Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jsid9HIZ;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E3606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 06:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D7E3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jsid9HIZ
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36c9a93a1abso41882eec.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 22:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793687440; x=1794292240; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1e5yiaXntYJQtqK8uc9nIplampCx3pEWFOJaZHKAJjI=;
        b=jsid9HIZFoRNwR6GMTza518FAORcQfu/edmN3FC+6bNwNONpdPpvjjRiQkCnQhuBBi
         IUs1yj+F3JN/ggclVkohtM4tk9HHZTI9g3ZQZchB6eiZnydJFech6fL570HOw0pSNQYQ
         EmmZcy4zTzI29HP4wO8ZeEzi81oNtD1LDcmgj2wyWB2XuagDGbcrUMZJX3rrAG4t2AS7
         2WluI7BdZQn/XZ3aoLCaAXo08ogAcMPnbd24vJXNyVcqNzH1AO9sVRfeQrmvYpwalBM2
         e7DrnkocDpxifvDy3yfpFIW7FkLXZgTezo17k5Wn/8cLxgv1G8VB1vNI3g147pkXg4N5
         h7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793687440; x=1794292240;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1e5yiaXntYJQtqK8uc9nIplampCx3pEWFOJaZHKAJjI=;
        b=q8fnIg2CDG/vV2lpxo3JvGQg/qFnnuGnStQwNM0YDrlw8kyuv1xPRA5Oo3cUbyGNow
         YrtS3fn9vJ8yck7i7U7uunLhi/G6n9uI5oaBRrxtyqtltBdMoopbswg6akYpHM6eXHVJ
         AnM7/eeWyJ/5HTlhC6OnqhWDaOciEx6m0EsSz39hYkNKNnSHcsK3urhGBVKTEjk1jCuQ
         2sraEkhFWSgQjL3xjNbmSh04VBS20gcF1J3itn//rBwMoGBVERY3P5cWriM2+zwAQzpj
         zNEYXfxGCJ4X29E3UVBYPNnwHKWa1pZrwFtfL/GE9XsjKYeD2+UrOamZ9mYGzUycHNU/
         erNw==
X-Forwarded-Encrypted: i=1; AKwUvBzd0I5ONgtBzrxWprQL/RjuAy1zwGiufg0CVpMpEZZLoc5XH2swhcNEFfLd0OnMUOBLzGhpjZA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PEv7UCAV8msmeIyeWGdqLwPLaf7AC+8ApGdKUAb0/K8jQNJKG
	UKkZFReqxLpMtqI3ZFFNrfJtbOEe1Im6VUHZWVd/tpMivUlOifuCLCN2Fc9EZ+fDzDk=
X-Gm-Gg: AYBFou3yzpYQwfrZstJHsAo7m4FyV4/VJs4u+6vZ3c+DpAiss1X3akJahLUNjDqEhdD
	FXQUTDHgfqaFxEyLLUGMIW9BwtXD+AG1uSs7MV4OFWzKTzMDDMyNzQWqSoQAPQYgticACYCWa/Z
	RiVT5b5ZFgKsP6i6M4E0b+LzUvjpeb279D0K0DspEb/ozmzqRzKjc0Bo5/OLITQsWxKpzpiVEUh
	RUhXsVdGdiwCBKoacCsK6hDqQ/3RX5X4Bs0e0TBLEU8uQAN0DCBZUzNqKiNmlVK9bG9DC20Snc/
	zzFhtD3+taCT5dDSywBz45fET110rdlKhJvpDmfYlqkgi94oVH7rPurmH61tknKQC2+WLoKnQKB
	bF9AKCsrS8hmAF9j6q9XYNBacClvbI2aAvWx+/pGUafQWPIwMeDHu83vbyijBrfj8mKJKf79jeg
	vLstK3FxC0gKuLK8BZPVf8SvuXFS5Mk+8/HvwGLmvNDEbOb5F3rpu9dc3+aceXGOAgXJt7rUgdM
	lX42IXxEXnMZB2pcKNIpGQlS+mSCPtEeSEtUJ28IlUxwa3O9EllLp4/TqCbivYYtvLYuvsf09G4
	OTcAhANo0vpmRc4Ye4uswBgJIDhmCqLNEfEYByC+BkwUtZQ=
X-Received: by 2002:a05:7300:3b05:b0:369:fe82:8d3f with SMTP id 5a478bee46e88-36a3002ef31mr30681503eec.14.1793687440182;
        Mon, 02 Nov 2026 22:30:40 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429000f8sm44608720eec.13.2026.11.02.22.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:30:39 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Tue, 03 Nov 2026 01:30:35 -0500
Subject: [PATCH] nvme: wait for SRCU readers before splicing the namespace
 list
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIp/6WoC/x3MPQqAMAxA4atIZgO24u9VxKHVqBmskmARxLtbH
 L/hvQeUhEmhzx4Qiqx8hASTZzBtLqyEPCeDLWxtTGHRXyuGuBMK7UckDIoq04VdObeuqVznjYd
 Un0IL3/95GN/3A5ZD3BNpAAAA
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

Readers walk ctrl->namespaces under ctrl->srcu, and some of them sleep
there, e.g. nvme_wait_freeze() waiting for I/O to drain.

nvme_remove_namespaces() moves the list onto its on-stack ns_list with
list_splice_init_rcu(), which only waits for RCU readers before
relinking the entries. A reader still on the last namespace then follows
its next pointer to ns_list instead of ctrl->namespaces and treats the
stack as a namespace. Deleting a controller while a Format NVM
passthrough waits for a delayed read on the last namespace gives:

  BUG: KASAN: stack-out-of-bounds in nvme_wait_freeze+0x102/0x120
  Read of size 8 at addr ff110001d2f3fc38 by task nvme/4413
  Call Trace:
   nvme_wait_freeze
   nvme_passthru_start
   nvme_submit_user_cmd
   nvme_user_cmd
   nvme_dev_ioctl
  BUG: unable to handle page fault for address: ffffffff8af04850

Open-code the splice and wait for SRCU readers instead. This also takes
the RCU grace period out of every controller deletion:

  64 tcp controllers, 1 namespace each   before        after
  nvme disconnect-all (ms)               3543 / 3474   3221 / 3146
  nvme_remove_namespaces() avg (ms)      39.6 / 38.9   34.4 / 33.7

Fixes: be647e2c76b2 ("nvme: use srcu for iterating namespace list")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 drivers/nvme/host/core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09644c13..8f032b3edde9a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4754,10 +4754,25 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
 
+	/*
+	 * Readers walk the list under ctrl->srcu, so hide the namespaces from
+	 * new readers and wait for the current ones before moving them over.
+	 * list_splice_init_rcu() can't be used as it only waits for RCU
+	 * readers.
+	 */
 	mutex_lock(&ctrl->namespaces_lock);
-	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
+	if (!list_empty(&ctrl->namespaces)) {
+		struct list_head *first = ctrl->namespaces.next;
+		struct list_head *last = ctrl->namespaces.prev;
+
+		INIT_LIST_HEAD_RCU(&ctrl->namespaces);
+		synchronize_srcu(&ctrl->srcu);
+		ns_list.next = first;
+		ns_list.prev = last;
+		first->prev = &ns_list;
+		last->next = &ns_list;
+	}
 	mutex_unlock(&ctrl->namespaces_lock);
-	synchronize_srcu(&ctrl->srcu);
 
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-bug-nvme-remove-ns-srcu-93d8a75a9b1b

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773905;
	b=JTFQdPU8VQlakbC3YWHfmmvwkqyjwMe8d2kjhpheuo3R7uoR7Z/32tIqlXvXOrH8n/k/
	 nhh+sPYgX6TllUG+oFM5cS231rYf7m5gUDJAkKAXpxUqrGWmPQR9gt73kbSr75dLQDkAY
	 fONTEOD3zosnZobuiR698eIvzx5r7NJBIn14vAnwK/vpG2KZGzSVIqdqxYojM4zj5aUtc
	 vh02wezQNTIAOofU0rQTIglw0E6ehjuAHV+i3to3EqPCM7TdRR1R0c3QLJlBJyc9AP+NA
	 HmJ+QQPDz4EBKG8R4GeGhI1xSXhtPsUslK2Z1WfE6nl0Sq/lfhsl71A2wm8jez+k+VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=5SBRMVpxoMRkm0sntL7ZW3fIy24tGYRHmBWm6wUW0LM=;
	b=SEjeiSrWCJYnhQMz/rjqoxqaM2aOvpO3IEjVL9dAtciZIqRnJK9RWqYLZfzhY69Iw/dq
	 /EN7LppxBWqknfrAj5ifqsERn5oljHC126ka4s9KZd31SniIFrdDvSS30wsiSyIM7DEnJ
	 +/JdWSIWUEe2808qyzet8Pva9gq2Tqz3w9Jv3TsLOZuGfG6jJDEhYUtNkudqGmGDl81l0
	 DGv7p96vEfp6yvYTY0lNGHdKg8mzTqcpWUAuXV/ZKYZxSK0aBWuztJK1Mbehv6T/7BoZK
	 beogoc/E0ypbUyJinvbHJIxgc/xGfH6qvdg1Z3XmheI/iEv9vKTLZkiroCRjl7lrFxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KlMohCMN;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DCD606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 06:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4DCD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KlMohCMN
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1adbf62dd31so579483c88.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 22:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773904; x=1794378704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SBRMVpxoMRkm0sntL7ZW3fIy24tGYRHmBWm6wUW0LM=;
        b=KlMohCMNQP7aBc5dV1ONhQAxlzwBbvcHzvktszAMwHgePmd6cpqQQs1cCdvdz8zCM/
         orn99X5r5zcG7mWOzyoQOwycfney61nVn1pwV0aBiIJrbIFVdFGUgjfMJlqYOobmX8S1
         +px9i7yd0z1sxxXddC75kLl4GrPDjeUBF413dLRnxFL/WOCAKzOG0TADlIrSnn6t3pZJ
         MONALX8uX8ZVcGqmvnQtXQOCQ2PPv32ptawboY2t+bzBAPvxcivSUwAmhwLMBZIGUO3c
         K/PX6EYqY/zz5cGcD7VJR+b31i8GJt4gwMd7i39mK2e11Gc0ty7SssZkfYszfe+xz1+i
         1Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773904; x=1794378704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SBRMVpxoMRkm0sntL7ZW3fIy24tGYRHmBWm6wUW0LM=;
        b=SKT2UA0HOUbKF5wHlI+vwR8dv6MGsjrun/3YpAFa54QadirJBglxw0bfbFsml6lQgm
         vUOSGjR4OaURCIt1271GB/1EOZuL2CDldFutjgv2+p722YHy5shvOFYQ8WMTOw76I0Sz
         H51oxp4+PrxQkoQ8aPjCH3r5Mq1YlywVRoUuDwpwFqLVnkeFiJK/fAp0sN3UA7VbwSTa
         OpTUKQZuMuylRXPCQs6djL6a3TW61KjY2E6eV5phwO4jXOfrgZ8CmS/HaunTaJyxzx+O
         BPk93ZxPi7qCymK7qvJ5BWOz/JLwnoZwbuJ4jvsYM+ZEGhogZNtQjL5ZHlJkt22AZqC4
         jBBw==
X-Forwarded-Encrypted: i=1; AKwUvBzwKILkEiJAsQBRlcw3R8yShed1/uG+izOlaZ0WJ1yYZrSRo/HfideS89ehBwuGNEsau5gKQ5U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/f7mw9K7ei1hvx3Z4b8KMCac3OIfLuJ4RDbqklrtTo9XPaiV1A
	zUtFLKbxentdSuuGyzfHCf+66wlijbeVmHfBVEr9IS6ka5e7es0sz/l0
X-Gm-Gg: AYBFou240I7ymhX++M/DVRYCk72ffrgtpbV3Zf3duLKGUMy52tfsxm1Gd6R0c5s1jJR
	tuzYIasgCwvLLIH2F830xoJvWvhSXP9J+iHE/R83gGnuyMnR2iPyb+vU12gjQPf8NXdDcj6y7t3
	fR/n1FDCn/sQL5knaLrgNrWePh8n+ojSjTdUoc3Yx6V32MefN5XH+5Sta7U6W7IS7hT2l1hZany
	mW/eqr6r5AD/XXkeUTGOPOO9jyEfpcN458K9gZVjWapo7WB67xgnMEHnuBCO5lt1A0ONpqOLrpW
	KIQ2u/q/RmCxW1Fm1gNPCzS5CzFN8lc7AreftNODe3I56ct3aqG+if9R6TKu662FZLnKTsWRjh0
	Cxb7KKFoZc1Q+Ivct89jY/yq7Jw4/LR8sMyV+EYdr2/BCRYqvmgGEylCgPSd7AayUB0k9w5QWNa
	sG72+nQBs7nWXJTjgKlCvubjv28vuo9bUm7BsxFI96ZEHFZ0geCg3FxzvdR9JTuV3eFVdUI/ZNW
	dMQLmPx+WKoNz8YCak/IEyKtw1zkCdfaCYl0l4pg2O4AecxgFzu55HEW6S75cjvhF8yU9TitO2Q
	VGbgAA9dVor6snl450E7KRHe
X-Received: by 2002:a05:7022:ea46:20b0:1a6:53cc:7454 with SMTP id a92af1059eb24-1ac5d4b2ad9mr25380347c88.27.1793773903877;
        Tue, 03 Nov 2026 22:31:43 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c65194sm4454290c88.19.2026.11.03.22.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:31:43 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Wed, 04 Nov 2026 01:30:40 -0500
Subject: [PATCH v2 2/2] nvme: wait for SRCU readers before splicing the
 namespace list
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
Message-Id: <20261104-bug-nvme-remove-ns-srcu-v2-2-feb64ecb96ca@gmail.com>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
In-Reply-To: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>, 
 stable@vger.kernel.org
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

Use list_splice_init_srcu() instead, which waits for the SRCU readers.
This also takes the RCU grace period out of every controller deletion.
Deleting 64 tcp controllers with one namespace each, median of 3 runs on
each of two boots per kernel:

                                      before        after
  nvme disconnect-all (ms)            3491 / 3509   2996 / 3165
  nvme_remove_namespaces() avg (ms)   39.0 / 40.5   31.9 / 34.7

Fixes: be647e2c76b2 ("nvme: use srcu for iterating namespace list")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 drivers/nvme/host/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09644c13..cdb576db23809 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4755,9 +4755,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
 
 	mutex_lock(&ctrl->namespaces_lock);
-	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
+	list_splice_init_srcu(&ctrl->namespaces, &ns_list, &ctrl->srcu);
 	mutex_unlock(&ctrl->namespaces_lock);
-	synchronize_srcu(&ctrl->srcu);
 
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);

-- 
2.43.0


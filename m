Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645263;
	b=GY/H9HMCguYKe/SDQpwL8ifKNgZpzzz6F4Xb3ABH/kdU70spNhd1K5SaNqRCw58lQ5iw
	 xyXyvPF0nWnxgkZL7b4qX6tksuKxussLMazJ2I1p2DidVD9UMNnpvRcV12tvplJiNosTL
	 UnJZxxkmLkXc+FTCqcc31EQLBb1e4PIN3DjEjbGgUidyxojB8iNraiXT3hp6bgAfMULp/
	 NGzMlB2AyvGr590TqmymssAgKiNQAd+VLO/KEF+92Od/jFlsE0Om2UD3+Su4KGounRx1H
	 9OuTfKJxnLCWiGhhMflM1CbEVIDFlAqbZuOZq99Pdo4koju5bhnTrPubI1VVfWsZT/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=eRKibpmzTNA+GjiY0JkXP7GhIa2AHFH27weV8F24hYk=;
	b=qh+bGEAMGn0MA334VJsviKw9D7xMffHJdKLHrryEgeghnxC2WdC8/VCRzip0+8ixIAGj
	 WoVdWcGFAVRvIOjhAXUZ8JQrNUbdiuoiLlMF4+hSR0m/yCSmsCKFWh4wTLGdLOcSm4PsA
	 jkEMjSUQFUG/urhny6lmz7M6g3FLRcYkqLTL8kxbYVKqup9QhTJmisJfP2AB4JDWb5Jwl
	 f/vcGoKafiFLdZdUZgyawo38CGAj5EW0L4mWatVCd/SjbL4FyKFzzPREKYnrPNQVdJpQ7
	 HSDMj25MN9KwBvY74WOpqVTnxvarY5cJpYU8n4U+nGhHDbYNAR53VhHQUWppxzvyL8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ghe0on2B;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39120606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39120606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ghe0on2B
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3846d5f54c1so7333341eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645262; x=1796250062; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eRKibpmzTNA+GjiY0JkXP7GhIa2AHFH27weV8F24hYk=;
        b=Ghe0on2BRvJbiDF/9OiMHC3VUNHkn5xEJfV8RWM6JWmDus1UKIVdZD9tzjI5lm5c8O
         urRwdp0ytO+TgebIyc6E6ViuU5eCyyUfpoufRE8STFv6DcVufRxT5DKkRjOsKt7i55+O
         X+zx6SvCW7Y273D772zfCw0BAbrHv/QCFzLsiw7Wvm2FFwmuJ/aqqj4jCQd8uJsTsGLW
         PYho9Av3dt7MyxB6QSijsYZAEFthDo3u4dPUXDDT1tz+GSrAlV9iBavEK2Ec2RD0yQNg
         6w+Bpt/8RGcnrsEweNbw0RczPGb/zXF4DVHEpDrHqv5TP7c3ZoKqGphHm+PohPAUD5O4
         LQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645262; x=1796250062;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRKibpmzTNA+GjiY0JkXP7GhIa2AHFH27weV8F24hYk=;
        b=z7k80OxxvtuXJPJ8R++aNqeVtLkQYrisRJ6PnkmLY0bT/DQLDBjuWO651H4R4IoKeM
         chH5+xjauMe/Bct4aYZn5sx/aYe89GyHhB5iEZshimNEIc0sZlKAW4/1eari2fKe+B42
         x6y1k2m/S+UctMBupa/W8xqCYrIX0zMH5jqu5d8zzB47bheRbR9sGAsG1YmQUSKUzpyD
         p2Rl4NHBzFltmXl/UoAchMkNOYojEJviKD0wjKtigk1V0LC6QTGWqXNjTpP7dPfS8pVB
         sRIFrnAQJCzBzkXp+enGjfnu3wGNXtqb9+ZW01QpYvyKBbF4d3azJPNN64ZPPB61haT6
         g8/w==
X-Forwarded-Encrypted: i=1; AL+hErFzZ5ANToZxZB1rkLgQt2K5ChXIyHOzRitacoxxlaKnL2wq0FeC+EEBPWt0OAO5q43svD9ikoQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cEEHO9wK0pXoDKZg6l3fSqFgjHfORzFhi7Sv4DXCJdWUyTIoK
	rc9/ESCWXzW1SuhgwH5O5j0AlTsLaLQdmewEwR1VWUAan4phT9htjQU5942ACAolXwf4Tuuvqq4
	HQA==
X-Received: from dya19.prod.google.com ([2002:a05:693c:6213:b0:381:1c8c:a899])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8084:b0:36f:4981:da16
 with SMTP id 5a478bee46e88-3857073f5ebmr18366493eec.25.1795645261942; Wed, 25
 Nov 2026 14:21:01 -0800 (PST)
Date: Wed, 25 Nov 2026 22:20:29 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222029.1429071-1-elkin@google.com>
Subject: [PATCH] scsi: hisi_sas: Avoid synchronize_irq() under task_state_lock
From: Elkin Cruz <elkin@google.com>
To: Xingui Yang <yangxingui@huawei.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In hisi_sas_abort_task(), when SAS_TASK_STATE_DONE is set, the driver
invoked hisi_sas_sync_cq() while holding task->task_state_lock with
interrupts disabled. For interrupt-driven queues, hisi_sas_sync_cq()
calls synchronize_irq(), which may sleep (while for poll queues it
spins on cq->poll_lock in hisi_sas_sync_poll_cq()).

In addition, once SAS_TASK_STATE_DONE is set and task_state_lock is
released by the completion handler, hisi_sas_slot_task_free() clears
task->lldd_task, zeroes slot->dlvry_queue, and frees the slot back to
the pool outside task_state_lock.

Release task->task_state_lock before calling hisi_sas_sync_cqs() on the
SAS_TASK_STATE_DONE path, and read task->lldd_task under
task->task_state_lock when setting SAS_TASK_STATE_ABORTED.

Fixes: 584f53fe5f52 ("scsi: hisi_sas: Fix the race between IO completion and timeout for SMP/internal IO")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 drivers/scsi/hisi_sas/hisi_sas_main.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 06455c7a9e2a..2a5a34eb1b28 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1730,7 +1730,7 @@ static int hisi_sas_abort_task(struct sas_task *task)
 	struct hisi_sas_internal_abort_data internal_abort_data = { false };
 	struct domain_device *device = task->dev;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
-	struct hisi_sas_slot *slot = task->lldd_task;
+	struct hisi_sas_slot *slot;
 	struct hisi_hba *hisi_hba;
 	struct device *dev;
 	int rc = TMF_RESP_FUNC_FAILED;
@@ -1744,21 +1744,18 @@ static int hisi_sas_abort_task(struct sas_task *task)
 
 	spin_lock_irqsave(&task->task_state_lock, flags);
 	if (task->task_state_flags & SAS_TASK_STATE_DONE) {
-		struct hisi_sas_cq *cq;
-
-		if (slot) {
-			/*
-			 * sync irq or poll queue to avoid free'ing task
-			 * before using task in IO completion
-			 */
-			cq = &hisi_hba->cq[slot->dlvry_queue];
-			hisi_sas_sync_cq(cq);
-		}
 		spin_unlock_irqrestore(&task->task_state_lock, flags);
+		/*
+		 * Sync all CQs to avoid freeing task before IO completion
+		 * finishes using it; slot and slot->dlvry_queue may already
+		 * be cleared or reallocated once SAS_TASK_STATE_DONE is set.
+		 */
+		hisi_sas_sync_cqs(hisi_hba);
 		rc = TMF_RESP_FUNC_COMPLETE;
 		goto out;
 	}
 	task->task_state_flags |= SAS_TASK_STATE_ABORTED;
+	slot = task->lldd_task;
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
 
 	if (!slot)
-- 
2.56.1.839.g22a8290db9-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323002;
	b=Urscm+ZEsMXLrDjZEMfh5z9JiRBaseHUBGXQ6ScUOTKdE/Sco52MEvydPwQGZu7V/Bku
	 Ur4zyC4kyGhNB/j7JfELYv6CKxx4j8CedNZw5eVRey1hpUxr2lhS9lEdn7z9wL3zsDQQu
	 TWeVOtyHeDgw9mMzwhc6fHLIKRNhzq0BwDmsBvctJQDljqObMK/UFg8lERKz7fRRdtNED
	 zy1ON4Xiy7u5y8Q86gMBUDS9rmNixM41zH/GHaT3dlsOyRZynUY5/nFc9R3i+9+fkrVEo
	 CrFKrdRJe8FjTOD/z+bYjsiECR0FPZUNMIZBCt2SG3/KhWg2x4Rd+RLkp3il4hxg2yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323002;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=aQ+79e839SpSVcGAQZBfUwer/H2CE5FduVC0M7Zwuf0=;
	b=Vk1/wJShyvA9bQFm8sddIg74hLUU0cf2pRfvanHFsdATu73RAsVK0g0g8EMId7EG5xKi
	 N4+vzT3DZqvacjzW4Q4rRhPJw7N2LzQvqyzQVtwPj4HiHJGI4tVYSKYk4mNfPDky+AK3I
	 ox6AJ5tX6mFpXmM6VSS1QW73RuDIN79Kjsji4ggwm15Vvf8q9CBgLYpWTyeX3ncyuPuj/
	 LkDrOYfs07BPfd4LO92yq2x/hXjCW38RkgR9miE9vL7Ajiz+R8iDyOgy+NJ3LiBXTWwnf
	 f2iS2uDjSxuZ5VL5CPP5zGs6V4rAm7R+5CtETJpwWKudXAXYQyiFYC/T7E1mJWCJT7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=hRtg7l9t;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9158460A262E;
	Tue, 10 Nov 2026 15:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9158460A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=hRtg7l9t
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jP8zQ5M91z4xPS8;
	Tue, 10 Nov 2026 23:03:14 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794322994;
	bh=EVZeKEIEIa3KCIHtY0Mwx/UqHhx8qiT/szHFc92i6Vw=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=hRtg7l9tE89rfzguh6lzOjwysYVO4MmlJQX9FJpInZzBSekGgRDYnLgflMPwOoUdP
	 HKQJKd4uGkW4W4pGBOSqyeTYUZxx2JSdXwv5Zqpf6vjVoV4cQZH0YX9fjuI8+G6c0l
	 hAQA62XeuuyKE7bCMcBJr9sQNU5fkHQ3WpYoDfuQ/nY3WPL9bTCp6At7lg6Q3zHuYq
	 q7WOs8Jhnr5Ij6QBx5B8nmfDK82eLkJeAPPF0XLCwlS/q/DO77YJVU7a3+JavGoMi0
	 yxcmojVjwaZECiPgTPCawakVNCThxQ1mvb6KkEFQIjMMuUy4JMoj6FS8sfb029Ggwl
	 kA0VBVovf2i3A==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AAF3BiH030696;
	Tue, 10 Nov 2026 23:03:11 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:15 +0800 (CST)
X-Zmail-TransId: 2afc6af33233366-019aa
X-Mailer: Zmail v1.0
Message-ID: <20261110230315189Lj-_xOlluiUEy8Ui7ZA4D@zte.com.cn>
In-Reply-To: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn>
References: 20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn
Date: Tue, 10 Nov 2026 23:03:15 +0800 (CST)
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
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDUvNl0gbnZtZXQtZmM6IHJlamVjdCBkdXBsaWNhdGUgcXVldWUgSURzIG9uIENyZWF0ZSBDb25uZWN0aW9u?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AAF3BiH030696
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 23:03:14 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF33232.000/4jP8zQ5M91z4xPS8

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet_fc_alloc_target_queue() stores the new queue with

	WARN_ON(assoc->queues[qid]);
	assoc->queues[qid] = queue;

The queue ID comes straight from the Create Connection LS and is only
checked against NVMET_NR_QUEUES.  A remote initiator can send a second
Create Connection for a queue ID that already exists, or send queue ID 0
which was already created as the admin queue by Create Association.  The
WARN fires and the old pointer is overwritten: the old queue's base
reference is never put, so its workqueue, nvmet_sq and nvmet_cq are
never released.  For the admin queue this also leaves the controller
reference unreachable from nvmet_fc_delete_target_assoc(), so the
controller and its subsystem reference leak permanently.

Publish the queue with cmpxchg() and destroy the newly created queue if
the slot is already taken, returning the normal queue allocation error
to the initiator.  This keeps the existing error path and makes both
duplicate and admin queue IDs fail cleanly.

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with nvmet-fc over the
fcloop loopback transport; no FC HBA or fabric is needed.

A misbehaving FC initiator sends a duplicate Create Connection for a
queue ID that already exists, or for queue ID 0 which was already
created as the admin queue by Create Association.  A normal host never
does this, so the initiator is emulated by driving raw LS requests
through fcloop.  The LS response and the target debugfs controller
count after controller teardown are checked:

  unpatched                            patched
  duplicate conn -> ACC + WARN         duplicate conn -> RJT (0x03)
  ctrl1 dir leaked after delete        ctrl1 dir gone after delete

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 2b7dc3f03912..181f8028a841 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -818,8 +818,17 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 	if (ret)
 		goto out_fail_iodlist;
 
-	WARN_ON(assoc->queues[qid]);
-	assoc->queues[qid] = queue;
+	/*
+	 * Publish the queue only if the slot is still free.  A Create
+	 * Connection may arrive twice for the same queue ID, or with the
+	 * admin queue ID that was created by Create Association; replacing
+	 * the old pointer would leak that queue and its controller
+	 * reference forever.
+	 */
+	if (cmpxchg(&assoc->queues[qid], NULL, queue)) {
+		nvmet_sq_destroy(&queue->nvme_sq);
+		goto out_fail_iodlist;
+	}
 
 	return queue;
 
-- 
2.27.0

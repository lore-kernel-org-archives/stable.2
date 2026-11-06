Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793984003;
	b=cp+ttFekpPYazD1GKTZbHqfxFwi/D08U7z4o3qKaV2XuOKQiG8v8n4Q1IC7cUvvhyPW8
	 FbbLqrftnhUBtQnjHDC/fEiITmx7nMVPWY0iHVYLNRBxGHNZ0ZzjmQVkVGQ6Vqw7J6Qqg
	 5AQTRRlMN6CWOZrCmmwQXLvz2nfmVEhuFloIcbFMX2N+0zqGsGyvHWLJ6XPM/GVvnu1rL
	 gsD9I5D0gVE71VhhpYxXj8UklD/A6Odj5R0eqQ5VJKfT55strCvIZ9xACFZ8G/j9UgXez
	 1H6PMjVGP/RkZtfPxf4lJewwwtMS65Fbeqt3wDJP7+RE9jdDDqfnV+b6iDClXxvVvAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984003;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=X4ZlRWfZ8M7TwLSDKXdV/Z09UPC7KZO0bf5yXI3zwSU=;
	b=qF9+Ju3GFbSemzryXJtKoWSqnOPXjidgwHImeCTU4ISY3T/TzUVpi/bCIlb17bGQMQD6
	 K+w7+L07efWP4HHs6YqVIgfBHyZPQ86y8L+mnjjgKS9N9mRXW4DiYN/aSu0wNCZcNpEjV
	 49QKpUi13aHMpGrOLdwTTrY2yTEq39A2ffSIVmTU7OeOTcR+WVIfz0r/o7B2OACC+NOg3
	 RICIRULahEdW2IXFdWdC9SRdeOVVqKVY5pwdmnIvU4rrv3n+W+BmO6kNVWQcVCvNqb43N
	 qB3zo1RBd89IUu2hRoKdHg92/Z1KsHEcmzYcyjCrMzT3swXERnRkH423hfa87MCQYTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fN5pUZhX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5E606A326;
	Fri,  6 Nov 2026 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fN5pUZhX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793984003;
	b=3WpFa1SDxHSr2OtMA57AS7T1b9bac4duA6pW3earm5aHDoPJn1IG30qtliEV9E+QEhfs
	 j8/tHEyRwGnOf69sbH6KV/nEC0TztB/SNOMnRBJP68aslwRYCoNQoPGrYvvMY8quR+oNw
	 ImlKKsXFBILXck3uFIOpf7phrtEeDM61cWeA5L7mGwlIg22GngV6/iVAvO84auMlcxzgC
	 iWluCvO5aAF8nN0kIetIAyt3Q5fX+X+hMlddkWB9N0E+ekjyA7lmRrLrdGuwJ/8ucQy54
	 hYCAnIQQt3oPWOE8MOnTnRiG+YhmyI8ebea1UTxs2AikEhQl4+c6Ce+Q0mVhpnPEjCA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793984003;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=X4ZlRWfZ8M7TwLSDKXdV/Z09UPC7KZO0bf5yXI3zwSU=;
	b=W4UdvxivR8ilmav4JaHSoCVNG0NM0NS9YYiVNEFYcA7i6SIUkbmLl/AlC3lFoY2TUlZt
	 skzExA01HE0YDwea3qwlPARRw4UvTVR+3FweddnKaIJRmW/LKGxLDLJmjAP6beEcAsypX
	 TEjhboCX6hlMepDce0jZLV11szbVKiNKC45bNqlFyXMd1D7o1TY27urL6zbIdzDG1B/Cx
	 dPwJJ2zBPDJrRZMkZdGZsIkNVtPmNOJu6/ohggfbWibrhHbD59gzlgnjHikGxaSk+VPYt
	 Pd/eAKcR7eFqA5jwtYueqDj9OW4Y2k3Ui5NFg7kxBVoS65gu+sPLan1dCo7SDHELBBg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6FF981F008A2;
	Fri,  6 Nov 2026 16:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984003;
	bh=X4ZlRWfZ8M7TwLSDKXdV/Z09UPC7KZO0bf5yXI3zwSU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=fN5pUZhXJiem0FEZL4r6sdeNHsGAkm0YYdoyxeeXN/zUeKli0C+RIwITAyNiv0Ijt
	 YIuft1CE9jPTojU+miSaXdsTJW6nFz05lsre486xK9KWkMZ2uaLfN4XczuIZpXq6Eu
	 3T+WPTehYKSQXxKO9EpofzSAyWUY0BAwWC9teIcSIBitFRmNw59H+XsdIm8mvKLZip
	 9m7uBLaSiFsfcs1YmOkEQllXUJK6caY+ivq9wvNkqsL9QN0ZiKpQ63jz5F0USJw01K
	 w2gCaph/BepOFvOvjZLXlE+r3GOSRi4pDPE8yoS4fB0XhzIyQwbugKJf+uOkZlj9/a
	 NEAgBZ7fYdSdQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BE2AD45DFA;
	Fri,  6 Nov 2026 16:53:21 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Fri, 06 Nov 2026 11:53:21 -0500
Subject: [PATCH v2] blk-mq: take quiesce_lock when removing a queue from
 the tag set
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
Message-Id: <20261106-blk-mq-del-quiesce-lock-v2-1-cd4f72a6eb03@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0K6dkxbCYIr72FYtGWQkUqlpURDu
 LsFD+DyJf/9t7CAnjCwS7YwjzMFckMCeciY6dRwR6AmMZNcFkLwE2jbw3OEBi2MMZkGwTrTg66
 Qt6Wo8rMuWbJfHlt678+3+sch6geaabvbFh2FyfnPnp7FtvtfmQUI4LlSslJ5KdriapyNT03qi
 E1k9bquX4Wg/tDTAAAA
X-Change-ID: 20261103-blk-mq-del-quiesce-lock-b9e0f81947b8
To: Jens Axboe <axboe@kernel.dk>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, 
 Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>, 
 Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>, 
 Nilay Shroff <nilay@linux.ibm.com>, Josef Bacik <josef@toxicpanda.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793984001; l=5226;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=cv5/KeOSZ4Z4BXwwrEX0tsh7Mnk0wVg6c4mcT61tdeI=;
 b=qvjLRqoflof3sB16O9bxZWwBNGt0IL+TS6gS3msI13ym+D4/PcZb+GtCM+2rGjJYB95LH8/37
 M/pyn7sDNZmBKrfGTskvpKLu0zMhyLbHdD/cwKjBC13eou6PT1YCgdV
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

Unquiescing a tag set can run the hw queues of a queue whose hctxs were
already freed.  blk_mq_unquiesce_tagset() walks the tag set's queues
under quiesce_lock and rcu_read_lock().  Commit 71ec3c7d6db8 ("blk-mq:
quiesce a queue that joins a quiesced tag set") added quiesce_lock to
the walks and to adding a queue, but blk_mq_del_queue_tag_set() still
removes a queue without it.  The hctxs are then freed right away since
RCU only keeps the request_queue itself alive:

  Task A (controller reset)            Task B (namespace removal)
  blk_mq_unquiesce_tagset()
    /* finds q */
                                       blk_mq_del_queue_tag_set(q)
                                       blk_mq_release(q)
                                         /* frees the hctxs */
    blk_mq_run_hw_queues(q)
      /* reads freed hctxs */

The window is short.  On PREEMPT_RT quiesce_lock is a sleeping lock and
the walk can be preempted inside it, which is how it's hit here:

  [  399.851277] BUG: KASAN: slab-use-after-free in blk_mq_run_hw_queues+0x4bd/0x550
  [  399.851328] Read of size 8 at addr ff11000003014148 by task kworker/u9:2/116
  [  399.851352] CPU: 1 UID: 0 PID: 116 Comm: kworker/u9:2 Not tainted 7.3.0-16299-g81cb9aa43246 #1 PREEMPT_RT
  [  399.851425] Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work
  [  399.851441] Call Trace:
  [  399.851457]  <TASK>
  [  399.851551]  blk_mq_run_hw_queues+0x4bd/0x550
  [  399.851564]  blk_mq_unquiesce_tagset+0x128/0x210
  [  399.851576]  nvme_loop_reset_ctrl_work+0x78/0x4c0
  [  399.851600]  process_one_work+0x92b/0x16d0
  [  399.851660]  worker_thread+0x4e6/0xd60
  [  399.851707]  kthread+0x300/0x3e0
  [  399.851727]  ret_from_fork+0x4f0/0x6f0
  [  399.851776]  ret_from_fork_asm+0x1a/0x30
  [  399.851793]  </TASK>
  ...
  [  399.851988] Freed by task 111:
  [  399.852040]  kfree+0x1b3/0x4b0
  [  399.852050]  blk_mq_release+0x400/0x550
  [  399.852060]  blk_put_queue+0x94/0x120
  [  399.852068]  disk_release+0x1bd/0x3f0
  [  399.852102]  nvme_free_ns+0x39/0x270
  [  399.852113]  nvme_remove_nsid_range+0x2d1/0x4a0
  [  399.852123]  nvme_scan_ns_list+0x2cc/0x390
  [  399.852134]  nvme_scan_work+0x421/0x9f0
  ...

With BLK_CGROUP the disk's root blkg holds the queue until a grace
period later, which hides this for NVMe namespaces.  It's still open
without BLK_CGROUP, and from reading the code also for queues freed
without a disk (e.g., SCSI device queues on a UFS host).

Take quiesce_lock around the list_del_rcu() as well so that the walk
either finishes with a queue before it leaves the list or never sees
it, and say so in the comment of quiesce_lock.  With the fix, KASAN
doesn't report the use-after-free anymore.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it about once every 20 minutes on a PREEMPT_RT kernel.

Fixes: 59e25ef2b413 ("block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock")
Cc: stable@vger.kernel.org
Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Changes in v2:
- Say in the quiesce_lock comment that it's also taken when a queue is
  removed from the tag set (Mohamed)
- Add Mohamed's Reviewed-by
- Link to v1: https://lore.kernel.org/all/20261103-blk-mq-del-quiesce-lock-v1-1-04aa29a481f6@columbia.edu/

Stable trees need 71ec3c7d6db8 first since it adds quiesce_lock.

Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/blkquiesce.c
---
 block/blk-mq.c         | 3 +++
 include/linux/blk-mq.h | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ae22d556540..54ccfc43c27c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4354,7 +4354,10 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 
 	lockdep_assert_held(&set->tag_list_lock);
 
+	/* blk_mq_unquiesce_tagset() runs the hctxs, which are not RCU freed */
+	spin_lock(&set->quiesce_lock);
 	list_del_rcu(&q->tag_set_list);
+	spin_unlock(&set->quiesce_lock);
 	if (list_is_singular(&set->tag_list)) {
 		/* just transitioned to unshared */
 		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1a2f8d48adc4..3c9667854c46 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -524,7 +524,8 @@ enum hctx_type {
  * @tag_list:	   List of the request queues that use this tag set. See also
  *		   request_queue.tag_set_list.
  * @quiesce_lock:  Serializes blk_mq_[un]quiesce_tagset() against each other
- *		   and against a request queue being added to @tag_list.
+ *		   and against a request queue being added to or removed from
+ *		   @tag_list.
  * @quiesce_depth: How often blk_mq_quiesce_tagset() has been called without
  *		   blk_mq_unquiesce_tagset().
  * @srcu:	   Use as lock when type of the request queue is blocking

---
base-commit: 28f7d31c2aeb350df9a0116093fade0a840fb4ce
change-id: 20261103-blk-mq-del-quiesce-lock-b9e0f81947b8

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>



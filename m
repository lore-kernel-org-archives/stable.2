Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048794;
	b=mBpKRyBaxGvGUaEpoSiEEEguvY1t4mws1Y4KiMqnXvYeejxsMlMmUuh/YM6LMwjd9LLK
	 chOZxGHhgivzjQqZtnPMPFC4g0l82la5hZbv9mDokEeLvjGDs9aMEp0UBRXBT3IJZI2/4
	 nBxZjJvsy3YjFls+UTe0YSTgM01nkx0m6jn3T788QRohUyFlzlB+jFJYPiY26ozrH3w01
	 ocjk1u59XJvT/rLgW88XY3LnM6XruELwnqjdG/B4e9yvRrdND0S0onLFy+fJON9v04lp3
	 9gqeLa2gqp/H5Qnkg6g27gDokxc6nBOep4hr04Q3ifvIdusuxSfdjsqigkTNhVn992A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048794;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LULyC/LfA8M3f9+UHF6Ygf3YEN2CriEN48AlVstn8EE=;
	b=P5kXkvQOegGLEWqHs+C8WGtE3YA0x0pZHptW4+iUeSvRCvRTh9wNxkJnr1RBqZX9Htdv
	 TaVeYFRlbo1a9SjpelGZ17q5MzTrwWTLte+pMN6U7DrWhqSq6LZ4EARuWcspuQIarZu0n
	 spk3m55Do01SuK+oxTykwOQ+F6qxhqmiKbQx/RqK/3Uh8C+QtMncFmhjy7tw0FWPvmY+m
	 iBEDR/PGNj67DDZmI4sa903ZAQv5T38yAc2WyisZ9oL2KC7n7Xf5gAAAbSiiu8UNjh6CG
	 NM2xWIioJyY/yIURjGacvuA2p+sT6CQDKwxa8obadcoRr+zgsJDAyHgrlPxri5aRtsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7tmeXSB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A6606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7tmeXSB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8901F0089F;
	Sat,  7 Nov 2026 10:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048794;
	bh=LULyC/LfA8M3f9+UHF6Ygf3YEN2CriEN48AlVstn8EE=;
	h=From:To:Cc:Subject:Date;
	b=P7tmeXSBBWR0AuFDCkaOl+03cbPfhSVtw1JPt8sU0mse7r2MFSNNYE92MyqsmtOh3
	 vVP+dnfIcByMQvdqmpxdyRD0SOLAfX+gAsybV+/8F0h+nStmRLV9dM4jllmYlUhyd2
	 yMqP+n06Bx/5KL44MqquzSoZlw9m65vZSoLtQ7L5T7ihPzzpES0KsXoGWkxGMLU/l/
	 hePcOun0P5Vga684pWlQnMEx1QiQ0sft32rjNW8MWSb+1kAgoa2QLqlGeLUc2+GDyg
	 b5jHvkEEOOHPptNZgVILhfCKfVmFozvPzHuCYl6u68m8aY11v/h+UCqNx/faVcwxKC
	 8BxfWH5jCv+7g==
From: Sasha Levin <sashal@kernel.org>
To: yuz08559@gmail.com,
	mlombard@redhat.com,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvmet: take subsys->lock while force-reconnecting in nvmet_subsys_attr_qid_max_store()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:12 -0500
Message-ID: <20261107055312-failed-6.1-9f426f140511@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9f426f14051181e251590783e68ce589a63e2b1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055312-failed-6.1-9f426f140511@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9f426f14051181e251590783e68ce589a63e2b1c Mon Sep 17 00:00:00 2001
From: Yu Zhang <yuz08559@gmail.com>
Date: Tue, 20 Oct 2026 12:50:47 +1000
Subject: [PATCH] nvmet: take subsys->lock while force-reconnecting in
 nvmet_subsys_attr_qid_max_store()

nvmet_subsys_attr_qid_max_store() sets subsys->max_qid and then walks
subsys->ctrls to force every controller to reconnect, but it holds only
nvmet_config_sem (for write).  subsys->ctrls is protected by subsys->lock:
nvmet_alloc_ctrl() adds an entry under subsys->lock, and nvmet_ctrl_free()
removes it under subsys->lock with list_del() + kfree() (not kfree_rcu).
The free path takes no nvmet_config_sem, so the two locks are independent.

A controller teardown (host disconnect, keep-alive timeout or fatal error
-> nvmet_sq_destroy() -> nvmet_ctrl_put() -> nvmet_ctrl_free()) can
therefore list_del() an entry while qid_max_store() is iterating the list,
corrupting the walk.

KASAN, concurrent "echo 128 > .../subsystems/<nqn>/attr_qid_max" racing
nvme-loop controllers connecting and disconnecting, panics in seconds:

  BUG: KASAN: null-ptr-deref in nvmet_subsys_attr_qid_max_store+0x10d/0x1b0
  Read of size 8 at addr 0000000000000090
  Call Trace:
   nvmet_subsys_attr_qid_max_store+0x10d/0x1b0
   configfs_write_iter+0x1a7/0x250
   vfs_write+0x5df/0x940
   ksys_write+0xfd/0x1e0

(also seen as a general-protection fault dereferencing a LIST_POISON
pointer at the same instruction.)

Take subsys->lock around the list_for_each_entry() loop, matching every
other subsys->ctrls accessor.  ->delete_ctrl() only queues asynchronous
controller teardown, so it does not re-enter subsys->lock under the loop.

Fixes: 3e980f5995e0 ("nvmet: expose max queues to configfs")
Cc: stable@vger.kernel.org
Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
Tested-by: Yu Zhang <yuz08559@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/configfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 0b12b75c6e07e..2b085327320e2 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1780,8 +1780,10 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 	subsys->max_qid = qid_max;
 
 	/* Force reconnect */
+	mutex_lock(&subsys->lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		ctrl->ops->delete_ctrl(ctrl);
+	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
 
 	return cnt;
-- 
2.53.0





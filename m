Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273290;
	b=hUEU23I9fNT5n31QM/5BXQVSeen8PeDHjt2v0YC6L+SMpZr+b2jSigkGF3gxeHYluX64
	 +532ZFLZZTWJ3bCMpvJZwfvjgYr2QlTBNJ/LuI9AejP2TGzm+HdprLw2UV5EOekXC3ZQr
	 dFU5LGlbkl/bDFCFVBYtIqEb9tVQIPxajLneSK4ZuahkZVnTntjFflhTFj8OnxZ5tSU7s
	 m9qtF2qN2aItW8Sf35kwULa8OFfieFX8h/ksccb0dF5k63C1+XsmYeXgMHqJIKtAxZggs
	 1u0OXkqPvWUeyUItuTApLglAM6HkC8mhwxzykf4rsTKTsW5wpY7BfWvg5rZZjqB5jEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273290;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VYZ3/PWrK9BAY3EJ1SghteKvOavZbNsH5skLd7GhU+0=;
	b=PzPjMTLsHoIU5mZL4XDvRnPiUXFMCC149UZM2iIc+vtVvYB9C9tBqvYdAvegB1gYc9Z4
	 GujbOwxEaHVbA1KTItw/kvQSBH98NIZfqh/I1cfyz6/bOXhEm7uAC8hky5gP/4Izieikp
	 Eie9B9e9uQeoAyPzyOqbpOHnsYoaJhI4q/voVVcbeA8UM+Qpb7U0DMgIdLGT5IoT3OSdc
	 BhArKQZ+UIfE6nFryq4N+5AOSNFmVjbMJvvrNBBnuCrakHGbGIGz8z3yrGmJ0EKaTdFR+
	 Fwv3UahMWj0OJc8EklwhVk2NBHFHYkySRNDLr86QMGYMfb+Kc9OzG8LOkDjg7Cu8SAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JDeCp/q+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3907C606A339
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JDeCp/q+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5551F0089F;
	Tue, 10 Nov 2026 01:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273290;
	bh=VYZ3/PWrK9BAY3EJ1SghteKvOavZbNsH5skLd7GhU+0=;
	h=From:To:Cc:Subject:Date;
	b=JDeCp/q+lqtv0NUmaSguy/7QfCVr7wmMh6c3tWsHSoYQq8w4qoSMwh51wy9T9+7uf
	 Hf0vmpeIOAHa8ZOwcvVBxkrd933CmdTCWVwCHikvX4rACRYH12Wpp5Rxaw7kLUDUoE
	 8fW/AapEN/EA+oj70xdTIZ3rPiYBqjoIDm0lZvusRaZivYvl1aH/KPj8lW1agl0BJv
	 35Pq2VM/3D5BrlIQTJAOoXfiwcYjd9HyDGZWFSZ8/ydwZRF4a76GfTDAdhyehQy+6U
	 pj1teVnzIbMh9TVt7GEtcOSoR9OkyBtS9HKx4ufkdNeAUZfF7tDBL2CZ79NvyWWp6p
	 LBmCtGSjhgxOg==
From: Sasha Levin <sashal@kernel.org>
To: odys.yuan@gmail.com,
	hch@lst.de,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvme: wait for SRCU readers before splicing the namespace list" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:14:48 -0500
Message-ID: <20261109201448-failed-6.6-8a0449832b50@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8a0449832b50cd4f99f2d2952cfc1476e5f26d0f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201448-failed-6.6-8a0449832b50@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8a0449832b50cd4f99f2d2952cfc1476e5f26d0f Mon Sep 17 00:00:00 2001
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Wed, 4 Nov 2026 01:30:40 -0500
Subject: [PATCH] nvme: wait for SRCU readers before splicing the namespace
 list

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index da2322da42525..03671bba17549 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4757,9 +4757,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
 
 	mutex_lock(&ctrl->namespaces_lock);
-	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
+	list_splice_init_srcu(&ctrl->namespaces, &ns_list, &ctrl->srcu);
 	mutex_unlock(&ctrl->namespaces_lock);
-	synchronize_srcu(&ctrl->srcu);
 
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);
-- 
2.53.0





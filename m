Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C392472F83
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301122; cv=none; b=pM5yhCKLhE9G4SQUqTlem66pJqPnzmcnk2YXatrLvwNpg7kWu4PAPkzCv41Afv6WuUHe5kikAif+sHAjBp4fM6xN6xXqNNM9UnWbIjOA85YOMJgijolR1uwIKn2g245jKVeJdT0CgOhyPn9YKlv+nkoDnSbDY9pwD79JWVZHjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301122; c=relaxed/simple;
	bh=nQ6iwiIaVZAjx/obYfz2wwv9CXlBaaK5bX7ELBxS4/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPzGTyo+sQu7pEkMZFEV1a3EFpJbJOGOeloN3wXags22sjgJCLbRSrIBtvLldzMjHuOkDV3jEI5rUQ8p5StElYTEaSbrk+5s7Km6ehGvRAQ8s+p8kGtdIA9RhcLwLJYFbfyKs4thEXYCmGSbql4IY3QcRCUv+FZggq6TmgNANiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TATOl41w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TATOl41w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F7B1F0089E;
	Tue,  6 Oct 2026 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791301121;
	bh=lE7ClQvIZ9u2ojYAVt7M0kxf5MFVEFncKosaUxm+Kcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TATOl41wIBUAm01r3QKeu/MDZGy5nJ5VmyuDxstx3kCqwpxve4OIrp2wRGVyHbG/1
	 7Par7vDYv3b4uAQNuSOefgTxSf+rBCYc1DHB3tbBjk+Np2DiSfhQGWsRO6pyC1XRiu
	 gt7lJtPX0L0wD52o1UfttHLchr1TDo5m9+jCUA+9j+6cZ8/pwB5Je6xxnbAkuN0TwQ
	 ZMU7IBkjjkV0v1CVYt9s0PyPCYl8Y7Yb9G59uCFgvXi5qaLFTPw531uvFP8kxJ2Rzw
	 BxhuaLy+F+8KRl+J1nkPQq4exYniFaZaCfTINxVsEi8MtcLZJfCHlSWP6C506NmbA5
	 sNsm7v9hvh8Jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] nvmet: copy the hostid into the ctrl before creating PR pc_refs
Date: Tue,  6 Oct 2026 11:38:35 -0400
Message-ID: <20261006153821.760255-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006153821.760255-1-sashal@kernel.org>
References: <2026100502-portal-companion-f7cd@gregkh>
 <20261006153821.760255-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guixin Liu <kanie@linux.alibaba.com>

[ Upstream commit 5211fed41d7ec90e9ab7239dc4bffffe4d0b2b62 ]

Commit 6202783184bf ("nvmet: Improve nvmet_alloc_ctrl() interface and
implementation") added a second uuid_copy() of args->hostid near the end
of nvmet_alloc_ctrl(), and commit 7b658153f1b8 ("nvmet: Remove duplicate
uuid_copy") removed the original copy that sat before
nvmet_ctrl_init_pr() instead of the new one.

Since then nvmet_ctrl_init_pr() snapshots ctrl->hostid into the
per-controller per-namespace reservation refs while the uuid_copy()
from the connect data runs later, after the controller is published.
The ctrl is allocated with kzalloc(), so every pc_ref created on this
path stores the nil UUID.

pc_ref->hostid has a single consumer: nvmet_pr_set_ctrl_to_abort()
matches it against the preempted registrant's hostid to kill and drain
the victim's in-flight I/O for Preempt and Abort.  The match can never
hit with the nil UUID, so whenever a namespace with reservations
enabled exists before a host connects, which includes every reconnect,
Preempt and Abort silently degrades into a plain Preempt: the
preempting host sees success while the victim's in-flight I/O is still
in the air.

Copy the hostid where the rest of the connect data is consumed, before
the controller is published and before nvmet_ctrl_init_pr() takes its
snapshot.

Fixes: 7b658153f1b8 ("nvmet: Remove duplicate uuid_copy")
Cc: stable@vger.kernel.org
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1b18523cddb6a..3310d0b44ccff 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1633,6 +1633,8 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 
 	memcpy(ctrl->subsysnqn, args->subsysnqn, NVMF_NQN_SIZE);
 	memcpy(ctrl->hostnqn, args->hostnqn, NVMF_NQN_SIZE);
+	if (args->hostid)
+		uuid_copy(&ctrl->hostid, args->hostid);
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
@@ -1689,9 +1691,6 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	nvmet_debugfs_ctrl_setup(ctrl);
 	mutex_unlock(&subsys->lock);
 
-	if (args->hostid)
-		uuid_copy(&ctrl->hostid, args->hostid);
-
 	dhchap_status = nvmet_setup_auth(ctrl, args->sq, false);
 	if (dhchap_status) {
 		pr_err("Failed to setup authentication, dhchap status %u\n",
-- 
2.53.0


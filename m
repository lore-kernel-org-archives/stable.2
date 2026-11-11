Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417971;
	b=WbbWIQlFfdjb41ZRa1FfqpBCscmf8fARLuA3UuLN58qLDEv3zW2o3wo/HIpWsq0+0J7D
	 /xFf9TyfvTqDIQnrZeVRNsV33MWcTF3AyBeOycUVAqr251w/rWy8Nu2FdApl3xOSpsxUs
	 D5fT+qUc1Zk8TB7rymsryWhrvAJsNVh1vj5DhLkGbGJn9Znu+GXrWC+2K+TGGZs+0XPxb
	 X0HDYwhAmL9Qxmg6d5egwlAzUBv0Y66tEj8K8YGaoB+WjSA3Hn4wt0PipPxS1gLDLjdPM
	 B3Mv++S9kEDHTTq1NLTFGmFTHONKbmkPbYMzWNtTCxrz1Btx/DzrXl8zVXFH6Sk/ucQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417971;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U6jExM4yiR7Q4YcCGohuEYXpcdsCixDMxo8aJTgNHWU=;
	b=o9eeU/yfwK4slZrM2XKVxNoUasd6gVczRPjSmK1uTVF1LBRvjtIanD3Co4yL7uCSYkUq
	 lU4/Ovv2hQbt5gz50VburSDd8tS7FnzO/Acl+5GBlHwUfAmDn9ktyohoY4D7NbP5Tf39l
	 hJwVuJ4NKBgoY9BnzKovKw5in7iwbwh58rGIV0BHVpLzxv00H4U+JzpII2V1wy+9ejtBO
	 W9JZ+QgUmpWtf9CVnmP40xb1bQ6S1rjPB9MiAfMtC0U+ll7YF0M0E+x6KUs93EhbTxgL8
	 gNxd5S+wriecGLxNi5fqeMPVLM1oOTJPTRp0mkvVFNvkZ+sIsunMIQ4Jeo/1DaXkCZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFQKhkoq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6590D606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFQKhkoq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B791F00A06;
	Wed, 11 Nov 2026 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417971;
	bh=U6jExM4yiR7Q4YcCGohuEYXpcdsCixDMxo8aJTgNHWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PFQKhkoqP8wM5c8i+Bh/C1BNgmItFECe7k17DREijbhayj66zYiPora4TZ8Z84AW2
	 66/W6N9Db7lmJiJy2UMPdTnyMnG/QZ15wyb2Gu8q3jg59SCdbNsECStmThkmoc9EQU
	 OpXIwUN15wYLYo6oka2Pk68kTBUjaK2pDbEnM9S1FWmCPwoRgN9jDV/ds+gBKC4/qI
	 0xbMq3gOfA4NY8aDRfBeGF1ZFT/9FXNT8O5cte4U+tdYRX20M8yC55QIffQKXI9sD7
	 sMG/mMd5s8poLJzxG7a6jHDz3LtdCV1cKZrUa+fSFo+q2/+5HsYGhbM+MFZWPQZmQh
	 TknrwLvNtujHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Zhang <yuz08559@gmail.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] nvmet: take subsys->lock while force-reconnecting in nvmet_subsys_attr_qid_max_store()
Date: Wed, 11 Nov 2026 12:26:08 -0500
Message-ID: <20261111172541.3562889-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111172541.3562889-1-sashal@kernel.org>
References: <20261107055312-failed-6.1-9f426f140511@kernel.org>
 <20261111172541.3562889-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Zhang <yuz08559@gmail.com>

[ Upstream commit 9f426f14051181e251590783e68ce589a63e2b1c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/configfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 8c12de188e992..cbc3693d5fc0a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1332,8 +1332,10 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
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


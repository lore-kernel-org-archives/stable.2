Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933103;
	b=JgmXa+aqTFNnOCJMkoKeC21QFKaDvBh54G5beiJYhRPUGXL4qt/vPOO4yJJfD5zTjoOH
	 PE383cq4qAPJ7sFQdYPLA3nS3Kz21JdrkElfE68BlGHMO0H1LwKqWaiDp04C0XaUKfVGy
	 nfblDZlfvOZ3fpfUbHn2alDzNSl2XhO7aCO4L58M6IwH3h2okP7BZDrDJGZU/f259QibF
	 BY6at8495hRDpsfNegMf72NoXsSAGKLzsAawwWMqXPWvrwmeidZn7zlSZpl+JFJnGf7n3
	 38XW/PcxqvFq3LBQOXDBUBHHcU9zopaBCiDBG7txcvetXsspqzTnJ6yg3AQHvQV7JdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933103;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tHgv8W4A47HRFDkNoqTHL92JY62X+jVZsBZ6YMs1NBM=;
	b=PCfpgD+E2PpnCHQTlXGG9yIC5gD6pgNw6vTDRiIWJSSBj0JEZ7L2MhkF7NaqE2kmdnBh
	 1x0kXtDkT9o3Kb6G32wAZ29RAz3oxmRqGyYh8fwzn375p7HVBBu4r/7SMC9mJGVspVaxz
	 x6wOPkbNdvECdhH27yCIF80g18Uis3Uf6Wv/7IMXzUOKt4WER1VJn7goDnYXKY1248Cob
	 /QUPz8yCChVLmKbK0yAuF1jROCEj0Us4t2iVUIzGq85AlCSYi3On2wB63fBTH6qoVdNBp
	 OQf7/oMYN9jQPP+Iu2cdQ2XOp2SgrSq/OVkeGe5KkoEywtqlapN2CbrUa7BAnwcCkjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VgwKKUVP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B87606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VgwKKUVP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9691F008A1;
	Fri,  6 Nov 2026 02:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793933103;
	bh=tHgv8W4A47HRFDkNoqTHL92JY62X+jVZsBZ6YMs1NBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VgwKKUVP62XhWBIA8Oka3x/PTj7xgAmaaj5lOgAu1IcHHCBC9qJI1SGvrRjLpSl+t
	 Ulv7f7qbeWyAj8HIxe/xZDP4hNqoOcFil3LvfARthtW76RpXowTUsfieg3F/8skn+7
	 0T6Sd6MZpUo5xcviFbPz5jZ7UPyclY+ZtHCVpSOFYZ/3+GgaCtH/Z93p+2Z4RY9OaD
	 48VoXJYBhW+TviXazxiEbZTwn02lkTfrsd5oX1CRI3ddwyMPWvRpJEIFbmr9+psOIL
	 iUmI/ep4H93304hQWegv3WE+WM09BfLhiQlnzDIpCA3kt8x8FbQu/T9CoCWnHWhvuH
	 4h31RuBrOouZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] NFSD: Complete a cld upcall when copying its reply fails
Date: Thu,  5 Nov 2026 21:45:01 -0500
Message-ID: <20261106024455.3943128-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110443-cobweb-sloppy-a362@gregkh>
References: <2026110443-cobweb-sloppy-a362@gregkh>
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

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 8cef2b0a01d28647facc57501a3df7ccd8d13ccd ]

cld_pipe_downcall() removes the matching upcall from cn_list before
copying the daemon's reply. When that copy_from_user() faults, the
downcall returns -EFAULT without completing the upcall, and a
retried write cannot reach it because its xid is no longer on the
list. __cld_pipe_upcall() waits on cu_done uninterruptibly, so the
nfsd thread that sent the upcall is stuck, and nfsd shutdown hangs
behind it. The pipe is mode 0600, so only a broken or hostile
nfsdcld can trigger the fault.

Record the fault in the upcall's pipe message and complete it, so
the waiter returns the error to its client tracking operation.

Fixes: f3f8014862d8 ("nfsd: add the infrastructure to handle the cld upcall")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901-alemi-v2-3-e163f94a3a6e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261106022847.3726614-1-sashal@kernel.org>

 fs/nfsd/nfs4recover.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 0b033688aa0b5..907a914b04cd1 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -839,8 +839,11 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	if (status == -EINPROGRESS)
 		return __cld_pipe_inprogress_downcall(cmsg, nn);
 
-	if (copy_from_user(&cup->cu_u.cu_msg_v2, src, mlen) != 0)
+	if (copy_from_user(&cup->cu_u.cu_msg_v2, src, mlen) != 0) {
+		cup->cu_pipe_msg.errno = -EFAULT;
+		complete(&cup->cu_done);
 		return -EFAULT;
+	}
 
 	complete(&cup->cu_done);
 	return mlen;
-- 
2.53.0


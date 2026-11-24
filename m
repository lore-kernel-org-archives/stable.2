Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542492;
	b=ZyP7N4Q4Z6aGC3k8Nqp3CnUJk/DsPlxSpHMq3r4rmpIUSgFIlYAdJocGMz+k5Qofcx0M
	 JtDPz7SHLvEpJ68qCbcHCFnzsN843WMPkIC8ozPbv+SDTGCmzIXmB+bVBSI5DMfinE95p
	 U4EAtocV4bPl9po2UTzZW40P5Vd8d+clgTiqOylZioFHvq6OxtOZXQnGrrGc4WUCYfMc6
	 DHNh1sPM+17rvd2U8DHJBugSBCiz8b2TGrirICxuFpjbJTc+qJYA8fctrXui/LMsqAxaz
	 mBHJhM/Rf1iSBdIOtIxl0SMXDa15W6O+Rrh68b5i6L4Ew2YpbI4FTUJCL/+WRKLEAbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542492;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TKDnSBd+/M5z7YcRTp3Viv+zcb4ycwAnOBykya/IUZw=;
	b=lg/1F19DS2I2b6nsIR8SNzbiMPAL2ni6auzJFxtsAt4W3y6/3pt3NNSa1FX3LqQDQ5Rm
	 UoFA7HyWk3WbKeXO5FIgI4yJCHQ2Qc5RcGXMf5zuPwA/+4ynOLqAs2PAoel6ERK3o8JqG
	 PUKsj6yhjwW9TXN24CEOmX7Btc7ZTj7ATwvdsjbNIwaUdc3pPMga1VWQ/tECaYukCfxFs
	 4Gy0fdCg7pglLnUuuyR1nKq0sEZwhvOexDZs4yMQRjYwYNxBy+66Pw0u27lDvDUsKFoTt
	 Q9+KtXZWav3yILwTXR/u6Gg8wo+QIfN2EKHwR3IieQHx3auUB2ul0n9QvW33kTKN1GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DXE/RqHr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA21606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXE/RqHr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711D31F000C4;
	Tue, 24 Nov 2026 17:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542492;
	bh=TKDnSBd+/M5z7YcRTp3Viv+zcb4ycwAnOBykya/IUZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DXE/RqHrvIFCN5sKetmqj7gpC9BZcPjDbBDJbN2N11oulKTBXDG/SJp5xDBoPUS1z
	 B2h4qw921UFFed61wLKaTQu5FJi3FBgbLkxiBonhMNMhyljSXfN0NWr3RcSMNsaZhC
	 RNKGsTtxSy2Mr0IPekT57F24R7iXYz/5xlDQXGPtfrm3u9YVCKWsWOSR43mLfUutKB
	 CKa//3Pf/VPSnX/37LdfK6wZZshM0pJfTx2nR9HmeFHmdfz08fPj/hJER6j3wxGUGp
	 JSt/tepgf5pCLcaWKJPC/3wSkL/7qbZYzL+ma6A65J9PGBCnWdrofGQ4dpWg92sdII
	 fRoLUjZsjsYbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] epoll: use try_cmpxchg in list_add_tail_lockless
Date: Tue, 24 Nov 2026 12:48:07 -0500
Message-ID: <20261124174758.2019784-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112424-culpable-woof-b14f@gregkh>
References: <2026112424-culpable-woof-b14f@gregkh>
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

From: Uros Bizjak <ubizjak@gmail.com>

[ Upstream commit 693fc06e98514c2d5951ead4aca40cf8b21100b1 ]

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
list_add_tail_lockless.  x86 CMPXCHG instruction returns success in ZF
flag, so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

No functional change intended.

Link: https://lkml.kernel.org/r/20220714173255.12987-1-ubizjak@gmail.com
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 9f4413e522fa ("eventpoll: wake the next waiter when a woken waiter is killed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2053d80fb84eb..9e47e1dd66c50 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1155,7 +1155,7 @@ static inline bool list_add_tail_lockless(struct list_head *new,
 	 * added to the list from another CPU: the winner observes
 	 * new->next == new.
 	 */
-	if (cmpxchg(&new->next, new, head) != new)
+	if (!try_cmpxchg(&new->next, &new, head))
 		return false;
 
 	/*
-- 
2.53.0


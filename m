Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46A357CF1
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690589; cv=none; b=Py7cHV1jjLh5W9fBAEcWsMAaaIqHc3nbkppQkrwYwjfWVhJuUpVOdURGsIqtoECyY3XNvvWQHST0KkjKinVqOkd04JU3DAv0TiXPBcEJcRmVcaiACQCw4x+/TagJYkzdh/bKfIYoEZt1/dUbQknvxrFY+eroMep39cwU7pEPuHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690589; c=relaxed/simple;
	bh=kTS9YfMkvy2qH2RDC9Uarwav330tpGzS44yAXH+ag7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gx5S6WqHNPxGKgzG09F2VIRJoao0WguMi7e4PSdsyCzVCnXKEMHLi6eg98/cni7EmPUOJ9olkS8KZNzfVsgsA5apCWSTGEvywPbSF2935SAyWeMITHxLrPBu8tmCvCv7wuLlWpbGR2YHcwwxmadTGzfFTaapQ45UDAgSplk4nv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuO773N1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuO773N1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031741F000FF;
	Tue, 29 Sep 2026 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790690588;
	bh=OYiNYNGNyEBtO4T/qnQbJO70RQm82CBaVtsa4gIhLGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YuO773N16iB2kxEm+fcSZq1XUIlsWRf0lczZHi8/vsLaqxnQyPV7bqZ16Me2N0Blh
	 oPvRshfVlKmRIGR3eL3kEZ4ywOA8DEhAGqxxDW+s/BTEqCvdNxrRc2VZniGXhGjf4T
	 KhQmjgeSpFvcUM0jWb+TaFZ1w0BK3rQxN9EwCTwUp8YLd1s8U7/LJDk/SFUwUGTgd1
	 xXDgeM1e5sNBYZ2yWuBN4RIXzIsRhQ8tJOn4vH1UwT1I1+OOo2f9wqtHOUWc5k6LX4
	 jvoEPSKhllBT8tT+2vnYuEvkz0Y5yg/m920Z6sTC32nWdvpEP+b52OY7aIE9HoyvLH
	 ILdwq8rc0gL4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Peng <benquike@gmail.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] mctp: route: iterate socket tag list in mctp_lookup_prealloc_tag()
Date: Tue, 29 Sep 2026 10:03:04 -0400
Message-ID: <20260929140304.3526894-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140304.3526894-1-sashal@kernel.org>
References: <2026092919-dawdler-dodge-debe@gregkh>
 <20260929140304.3526894-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Peng <benquike@gmail.com>

[ Upstream commit 26cc0e69cce062cd3aa6fae33074684669c35a71 ]

When a socket transmits a packet with MCTP_TAG_PREALLOC set,
mctp_lookup_prealloc_tag() iterates over the per-netns &mns->keys list
and matches netid, req_tag, peer_addr, and manual_alloc, without
checking whether tmp->sk == &msk->sk. This allows any MCTP socket in the
same network namespace to use and consume another socket's preallocated
tag.

Iterate the socket's own tag list (&msk->keys via sklist) instead of the
namespace-wide &mns->keys list in mctp_lookup_prealloc_tag(), ensuring
that only tags allocated by msk are matched.

Tested in QEMU against Linux 7.3.0-rc3 by allocating a manual tag
(0x18) on socket A via SIOCMCTPALLOCTAG for peer EID 9 and sending a
4-byte message with MCTP_TAG_PREALLOC from socket B in the same network
namespace. On the unfixed kernel, sendto(sock_b) using socket A's
preallocated tag succeeds (ret = 4); with this patch applied,
sendto(sock_b) fails with -ENOENT (errno = 2) while sendto(sock_a)
succeeds (ret = 4).

Fixes: 63ed1aab3d40 ("mctp: Add SIOCMCTP{ALLOC,DROP}TAG ioctls for tag control")
Suggested-by: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: stable@vger.kernel.org
Signed-off-by: Hui Peng <benquike@gmail.com>
Link: https://patch.msgid.link/20260921051002.1656692-1-benquike@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mctp/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index d947344113e97..4eb7effb6f2cc 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -758,7 +758,7 @@ static struct mctp_sk_key *mctp_lookup_prealloc_tag(struct mctp_sock *msk,
 
 	spin_lock_irqsave(&mns->keys_lock, flags);
 
-	hlist_for_each_entry(tmp, &mns->keys, hlist) {
+	hlist_for_each_entry(tmp, &msk->keys, sklist) {
 		if (tmp->net != netid)
 			continue;
 
-- 
2.53.0


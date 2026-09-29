Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F77A52CCF4
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691173; cv=none; b=st0oknnZuJgKTFURmgvbJTT1LDRyJqkswsg8aAX7MgzNTkUZVNsZWZiF2Rmp10S7ccMa4rhwjJKc/54yiqgo1yawE9eOVtZquCBUd56DUT8Q0XaVNVGzuK9g6VJ1QLfRjfE13xbjJBGzLKpycU3BSFMaGQ3xhh5gOVypzLFmnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691173; c=relaxed/simple;
	bh=y5CKzn/ede0YjkqijGd0ecd4375ljsQEVQyPDOkSHdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2gRGquT2WoJr3o9CEPzHw1faosg84HRuvR5iu0zvB8hPTXKywdB3kVb5rRGYEH2cWXdCIUAXscR3Th58IdIOWe6S/AOY5DsCfAUGqF4TTBc8TFWkbN+Ueios2dyL41MkK9qQa/QocHrABPsJOBQVD7gBlKCAFaUwyXF9lLl+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce88RX6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce88RX6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969C71F000FF;
	Tue, 29 Sep 2026 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691172;
	bh=5d3j4oZJbOGHf4Fh1WOMNGVzyhZ1G2+m/HNMTy3caGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ce88RX6rKynbAyabo82UW6YeDLa1ob2kh0gI/4+KFRF1XkpuYSlQt5QdNAw8+qv3j
	 l/em/aAgR9iNnd9qW89SnK1oAh1ZC4L8DF6vdvEKMF5pCkqWpluQueWYWK9lARggVW
	 0qYr/zwJpDEeGmC35hQd27BqVpuDvQ9hKkHn0VnJq9jpR//pZPmczOGsPKFn9YzJ2y
	 KR8lp5Y6ca4pkfgPGe+aCK40Mt0MaOPXPDKre8A+UGvVg+d7H6gx57GYilXfvBVEjP
	 ZUUQ75VVnmMNv7Qit4l+wrHX6Mu+2NrNi8QEZP4qK9Takhi82GfVQX6+Su7ccv+663
	 mlBzgzcWE8X8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Peng <benquike@gmail.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] mctp: route: iterate socket tag list in mctp_lookup_prealloc_tag()
Date: Tue, 29 Sep 2026 10:12:48 -0400
Message-ID: <20260929141248.3537868-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929141248.3537868-1-sashal@kernel.org>
References: <2026092919-helpful-hydrogen-8802@gregkh>
 <20260929141248.3537868-1-sashal@kernel.org>
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
index 95ba7fce1582d..7e2d43184eae4 100644
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


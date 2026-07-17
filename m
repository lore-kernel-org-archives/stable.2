Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8839021B
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309382; cv=none; b=YZbVC6Na+80M3jFj4GQSd+8MTb57LyAJ/EH8efXkLl3RnxPk84GbPYKhpKsb+90UHTJ1/St92NkZarH3UTJzP7yBhnNfSd9jcBKdycnLh3lVbThq9W60ptfVcnqbvtu3XVh6MCdpxuoJ4v6HWN6YUxa5EtHeKnJqt4ZiB5PKeRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309382; c=relaxed/simple;
	bh=LfeoNN09Sfw1ntwPillZzrxDIuMpnh/bspoBT12+dNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaIko14gQqEb4ohTxtKYUZcUwWwojqNLj2+aPTHeRfS3t8a3MTlIezXDTV6Fq0jajSM3Oq9GtbLdgKNdARi+7xrB9OkWl/YnN1Rn2mb+ECMDdTRSgjd8R1RkuRqGrFW4TX3rzifmk6f89NaKe6hBwR5g9JlZ2L3lK7GUfhzs5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=qVqWJ+D9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="qVqWJ+D9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=O63H4XoSfuxdxcHb3Peq8OfKiv184UTAP6gM0n0+US4=; b=qVqWJ+D953NkOy3URe7gLX5Xvv
	BdIfFI756sGw2Y7lY+RmAuMIdNMVPTzKBBSUaY+C2OlZK102K+9bBdE0qTB+ulGxV+cmmwQilCf5w
	mT8EcAccDCuFoMWj4x1ZVwgBkeOJzFKHvB9JR1frneyU3Z/HhXVj2/Dlc/+FUT1gb5lyNSUNY7dlo
	ELoGHqssQe4QBm9t1pmQrskt8PWZVd417eybsbB/IoAheAqhWRRFf2AYIuxTk3E93mKgSxyfP3Sl9
	2GyP4kB2I84VbDqDgOurzGKRvUuBp2BGNPYhv+gC5AL19ESNff1Fe1pKTvXZB1TvxOE2P24ziM4MH
	7nayW87Q==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	kuniyu@amazon.com,
	kuniyu@google.com,
	Jakub Kicinski <kuba@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 4/9] af_unix: Set drop reason in unix_stream_read_skb().
Date: Fri, 17 Jul 2026 19:29:17 +0200
Message-ID: <20260717172922.3398851-5-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717172922.3398851-1-heiko@sntech.de>
References: <20260717172922.3398851-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit bace4b468049a558295a0f59460fcb51e28f8fde ]

unix_stream_read_skb() is called when BPF SOCKMAP reads some data
from a socket in the map.

SOCKMAP does not support MSG_OOB, and reading OOB results in a drop.

Let's set drop reasons respectively.

  * SOCKET_CLOSE  : the socket in SOCKMAP was close()d
  * UNIX_SKIP_OOB : OOB was read from the socket in SOCKMAP

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250116053441.5758-7-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 net/unix/af_unix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e0f5a9382149..1d426f5b2580 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2743,7 +2743,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 
 		if (sock_flag(sk, SOCK_DEAD)) {
 			unix_state_unlock(sk);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
 			return -ECONNRESET;
 		}
 
@@ -2757,7 +2757,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		unix_state_unlock(sk);
 
 		if (drop) {
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
 			return -EAGAIN;
 		}
 	}
-- 
2.53.0


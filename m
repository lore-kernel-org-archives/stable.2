Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BDB2E229F
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 04:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786249234; cv=none; b=smR8I1BO2D3V0m9C6ivc1EUq/VgO6yN1jdX7tGspzC0kuATWIidRLwuETwZB2+PQ4QRpE5PUNldQr7u7d9qCaJsONm6nPAulVkGqoAHIogg678/w5SjWz5vQijljowALxMn7ohXxyoJ2vLE3w7luNDmu9OLYXOMs1KGMG9oU6b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786249234; c=relaxed/simple;
	bh=fg9MPMllOSpEtaINts5KNpRuPfGe7f1Rp+iBNqlvF5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEuYILv0g/JyH1FIz5PQ0fJ4kPN5ucM/nbEigEWowLb9+nq7wwTrelkzzq3rdKYN83xgeaNJSlcxFiZpIMUS1ApUCjxVzpwWjgK9cCO9XMmBUFX3oUGLG2WR6PXHJYAQaeYMjylovYIeGyXOs+2wUeKATcVga3W7eRYEmG+ThtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6k25+CZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6k25+CZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D6E1F00A3E;
	Sun,  9 Aug 2026 04:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786249232;
	bh=Xi06aMy++YXaebEvdxSaBnZTBFEuQzt4IbWRmMXZX34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d6k25+CZIVUxekt4ATlXOO6EuXYe8AYGHSttCDDC9KZFBxGzB4Obpr57y9CNfpfDE
	 NJ5tCV27iiqlA52FzOx6dyueweFXvzDwVn9cexYm0ET466gUJepGw5um1wE2Yx/ivr
	 d/Dakww4Txm4cSsLaxQIZR1cURfVIJqPnlnC/EmA4Keyh9xQQq9PC/Bc9H0iRTmZq9
	 X1c+FfOOzuqI0wqg0mUgmscyzSaVuilhRpUuWDQsZrrmHvtXTyCxZJXD4KP3awY28r
	 MhRA1vhq9W0+3TQVftQ5LSxHSRc8wuNY8hnAmMjDCJ5TSPU7fCzNTnjkqPIBPZiOG/
	 rHC24s/7MZZXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Sun,  9 Aug 2026 00:20:27 -0400
Message-ID: <20260809042028.1093837-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809042028.1093837-1-sashal@kernel.org>
References: <2026072944-maritime-sulfide-d951@gregkh>
 <20260809042028.1093837-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

[ Upstream commit c3426ba2ed6942fe33c75bf17fc7513ba2c6ac64 ]

Use the first 3-byte hole at the beginning of the tcp_sock_write_txrx
group for 'noneagle'/'rate_app_limited' to fill in the existing hole
in later patches. Therefore, the group size of tcp_sock_write_txrx is
reduced from 92 + 4 to 91 + 4. In addition, the group size of
tcp_sock_write_rx is changed to 96 to fit in the pahole outcome.
Below are the trimmed pahole outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2521     0 */
    /* XXX 3 bytes hole, try to pack */

    [...]
    struct tcp_options_received rx_opt;              /*  2588    24 */
    u8                         nonagle:4;            /*  2612: 0  1 */
    u8                         rate_app_limited:1;   /*  2612: 4  1 */
    /* XXX 3 bits hole, try to pack */

    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2613     0 */
    /* XXX 3 bytes hole, try to pack */

    __cacheline_group_begin__tcp_sock_write_rx[0] __attribute__((__aligned__(8))); /*  2616     0 */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];     /*  2712     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 161 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2521     0 */
    u8                         nonagle:4;            /*  2521: 0  1 */
    u8                         rate_app_limited:1;   /*  2521: 4  1 */
    /* XXX 3 bits hole, try to pack */
    /* XXX 2 bytes hole, try to pack */

    [...]
    struct tcp_options_received rx_opt;              /*  2588    24 */

    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2612     0 */
    /* XXX 4 bytes hole, try to pack */

    __cacheline_group_begin__tcp_sock_write_rx[0] __attribute__((__aligned__(8))); /*  2616     0 */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];     /*  2712     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 161 */
}

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250911110642.87529-4-chia-yu.chang@nokia-bell-labs.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: a28c4fcbf774 ("tcp: challenge ACK for non-exact RST in SYN-RECEIVED")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/tcp.h | 4 ++--
 net/ipv4/tcp.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 5f56fa8780131..eb7e36a130cad 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -282,6 +282,8 @@ struct tcp_sock {
  *	Header prediction flags
  *	0x5?10 << 16 + snd_wnd in net byte order
  */
+	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
+		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
@@ -300,8 +302,6 @@ struct tcp_sock {
  *      Options received (usually on last packet, some only on SYN packets).
  */
 	struct tcp_options_received rx_opt;
-	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
-		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	__cacheline_group_end(tcp_sock_write_txrx);
 
 	/* RX read-write hotpath cache lines */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 747ca263e1444..e44e2c97274b4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5061,7 +5061,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 91 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
@@ -5078,7 +5078,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 99);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 96);
 }
 
 void __init tcp_init(void)
-- 
2.53.0


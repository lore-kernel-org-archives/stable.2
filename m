Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A603AA9E2
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024207; cv=none; b=KW3NRrvh0QqniVt6bAVGAc79pV1/oKFghfPLNzVKQas6pq9K0fuujt7y475KFvreZAWt6Mgi2I8ft1uiGySc98e/rhCWKi5q480pZdgT4+5AoLLEqpDbXlhf4eLpyzASfr4DFrk+e1bwlCLTWgS9C2JOu1e7e4fD5M7Z/RyYWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024207; c=relaxed/simple;
	bh=cmHJHXmAyk/2LVaokxnfsFHkNzmAV4F3kATclXMvYlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnjvL+nWwCLfUyoCNZREdylJtIisOdCzCj1xR9FGOgFLJ5+0heqGxYHkgxvfoCtuORnSP4DfNE1gyztfL66Nryc0IcnvCLjq8Dis6DBAVEvLOt5X6RsYDtBOwYvsOD63Ig5sd+mFj5Z749G9oe70zcy+mk6WVBAI3LM8keSw+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2IabT3O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2IabT3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA891F000E9;
	Thu,  6 Aug 2026 13:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024206;
	bh=GUgAbmt+WuhE9w6KYHA3ga/9dBc0na+2udS++qzbEzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P2IabT3OFkA+q29D19MljgNELntlXs25KeC7NcpK5S/Kxnlxr3+3uYQp+9SzPEnOv
	 UhYvVnwkZUQMVe2kz/Rl0uMrfeXtlITIMysbQkpy+5jraBOb58iQNWznNMcWW7buwZ
	 EW5yVHGU/7iDhnfPRF+Lu4ylqZocxd9TIbNv1XrGXvKLTldgbqY7/YSDznskGwMBFY
	 qKZoEYWyufBFTK8vulHOYmsGDjnzhSUwk8XT8EZNU0ypiwc64qY2m0Ez22qLMg42Q3
	 ObBrbquNouhCNqqfa9gACdHJ2CrdugkB/41E+x+RbaMnZc+r22C4+Qo1HkaLGyH65+
	 0DSeZVtpYawCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] rxrpc: Generate rtt_min
Date: Thu,  6 Aug 2026 09:49:59 -0400
Message-ID: <20260806135003.602726-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026073013-sanding-unlined-9b91@gregkh>
References: <2026073013-sanding-unlined-9b91@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit c637bd066841de6d0a204898a62f1d9bb8fa1b7f ]

Generate rtt_min as this is required by RACK-TLP.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://patch.msgid.link/20241204074710.990092-27-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e4d2878369d5 ("rxrpc: Fix irq-disabled in local_bh_enable()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/win_minmax.c        |  1 +
 net/rxrpc/ar-internal.h |  2 ++
 net/rxrpc/rtt.c         | 20 ++++++++++++++++----
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/lib/win_minmax.c b/lib/win_minmax.c
index ec10506834b62..1682e614309c7 100644
--- a/lib/win_minmax.c
+++ b/lib/win_minmax.c
@@ -97,3 +97,4 @@ u32 minmax_running_min(struct minmax *m, u32 win, u32 t, u32 meas)
 
 	return minmax_subwin_update(m, win, &val);
 }
+EXPORT_SYMBOL(minmax_running_min);
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 79a377f1b5517..f7ef2790f07af 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -349,6 +349,8 @@ struct rxrpc_peer {
 	spinlock_t		rtt_input_lock;	/* RTT lock for input routine */
 	ktime_t			rtt_last_req;	/* Time of last RTT request */
 	unsigned int		rtt_count;	/* Number of samples we've got */
+	unsigned int		rtt_taken;	/* Number of samples taken (wrapping) */
+	struct minmax		min_rtt;	/* Estimated minimum RTT */
 
 	u32			srtt_us;	/* smoothed round trip time << 3 in usecs */
 	u32			mdev_us;	/* medium deviation			*/
diff --git a/net/rxrpc/rtt.c b/net/rxrpc/rtt.c
index cdab7b7d08a00..bce6e8f32d334 100644
--- a/net/rxrpc/rtt.c
+++ b/net/rxrpc/rtt.c
@@ -127,16 +127,27 @@ static void rxrpc_set_rto(struct rxrpc_peer *peer)
 	peer->rto_us = rxrpc_bound_rto(rto);
 }
 
-static void rxrpc_ack_update_rtt(struct rxrpc_peer *peer, long rtt_us)
+static void rxrpc_update_rtt_min(struct rxrpc_peer *peer, ktime_t resp_time, long rtt_us)
+{
+	/* Window size 5mins in approx usec (ipv4.sysctl_tcp_min_rtt_wlen) */
+	u32 wlen_us = 5ULL * NSEC_PER_SEC / 1024;
+
+	minmax_running_min(&peer->min_rtt, wlen_us, resp_time / 1024,
+			   (u32)rtt_us ? : jiffies_to_usecs(1));
+}
+
+static void rxrpc_ack_update_rtt(struct rxrpc_peer *peer, ktime_t resp_time, long rtt_us)
 {
 	if (rtt_us < 0)
 		return;
 
-	//rxrpc_update_rtt_min(peer, rtt_us);
+	/* Update RACK min RTT [RFC8985 6.1 Step 1]. */
+	rxrpc_update_rtt_min(peer, resp_time, rtt_us);
+
 	rxrpc_rtt_estimator(peer, rtt_us);
 	rxrpc_set_rto(peer);
 
-	/* RFC6298: only reset backoff on valid RTT measurement. */
+	/* Only reset backoff on valid RTT measurement [RFC6298]. */
 	peer->backoff = 0;
 }
 
@@ -157,9 +168,10 @@ void rxrpc_peer_add_rtt(struct rxrpc_call *call, enum rxrpc_rtt_rx_trace why,
 		return;
 
 	spin_lock(&peer->rtt_input_lock);
-	rxrpc_ack_update_rtt(peer, rtt_us);
+	rxrpc_ack_update_rtt(peer, resp_time, rtt_us);
 	if (peer->rtt_count < 3)
 		peer->rtt_count++;
+	peer->rtt_taken++;
 	spin_unlock(&peer->rtt_input_lock);
 
 	trace_rxrpc_rtt_rx(call, why, rtt_slot, send_serial, resp_serial,
-- 
2.53.0


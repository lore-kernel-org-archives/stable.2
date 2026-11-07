Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049672;
	b=CDlj2UTfWGQlJv4Ffn1oI3pD51dIsgQ7QcBuctkQV4VgHiNeiCamf2ZAKPxGzvyQnXa6
	 k96yUsq7lAHsZKFRrfHGvEporNmPYyIVsAzqUsvM86N04kTE5GIFbN/DNFcFQuSUGjPYm
	 EUulJ4HacGgV3jtiI99b7ptKl3tNwKIETe0uD5ZHnT4wzzTGIGtl+UvDuhlzLYYO3Kr02
	 MRMPeS+sEPCtHPO6FBYOv8T8TVlRVd4PhmL4rE8Cl94xFab+AmnWeQziLkRnb7Ro34mga
	 Ck/7mc58a+C0nPKOXs0PhUYkpBjAlJeajcnyEOpSbLwbDYJ5M4s8E7mn89NlWC2GNiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049672;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o/PdgCaefsS8NbcQ8UKVlxeeIW70g6dsQVJk26xjdBA=;
	b=Ko8HZogC6jGU0I5AeEPVIDR2DO8jQVffIw6uSxt45KieNyhPij5aIx7bSxCqCFPEB1Ey
	 wWReoVXPPL/Ba/US0e3CjoFO8rnb/ZG6LWias7Stj/MLFCeCtNsRnXQnKm2aS9F75G8J2
	 CdDbyLA7TgjXGeym9yGavELk20bmDX/+k/rtekwkcyaYSpElK02hdt0Am5AgR1jFa1zfq
	 Lbwz4+N1EApLbewdMMgblhLpteyaXxWWrblYI6YAEvvIq2/SnWs9IvidP5kyOl9rcFhkT
	 MQRiXDq6O2jYyvKJb+KiMZIGsbSwc/8MqlLaCDhvU7oM9EQfIha4bGVYn9j9MSmOD/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDzzRH2q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36404606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDzzRH2q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DAF1F0089F;
	Sat,  7 Nov 2026 11:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049672;
	bh=o/PdgCaefsS8NbcQ8UKVlxeeIW70g6dsQVJk26xjdBA=;
	h=From:To:Cc:Subject:Date;
	b=RDzzRH2q09kGL1qNAjK6yaUL3H213dsq/CEvzDxCzeKLBag8Ayjh8X0RwtpOt+qQQ
	 MHFMJy1mag9ZnG8pClhtYC38smHzyHgvYx8IdP+U7Aapy1jCwW2Imv1+GQWESkdb7U
	 BA1xZnshtftRDHcqNQCrHp4G9blwbsYPGNEJzGGqEzJI2hMjtOoy7966gW0CQX1FNI
	 5jwWfGKNg10fIebWIYqLE16AONhu1X637UevRX9NiJO0FuY5ewm8bZgktY+MDIK7j2
	 vOwj6WRYXTxavW+aDF4saY7L/iUPXmA6Q5h2Luwo5ziYH8BoykTJnnFi5NMYojUKXB
	 qBK5SNAecwg/Q==
From: Sasha Levin <sashal@kernel.org>
To: quanyeyang@proton.me,
	matttbe@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mptcp: reset msk state on early connect failure" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:50 -0500
Message-ID: <20261107060750-failed-5.15-29afe67082b2@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 29afe67082b2d33ab2e90c56c337235d725f023f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060750-failed-5.15-29afe67082b2@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 29afe67082b2d33ab2e90c56c337235d725f023f Mon Sep 17 00:00:00 2001
From: Quanye Yang <quanyeyang@proton.me>
Date: Tue, 13 Oct 2026 16:29:19 +0200
Subject: [PATCH] mptcp: reset msk state on early connect failure

mptcp_connect() can fall back before the subflow SYN is sent, for
example when the netns is in an MPTCP blackhole, token allocation fails,
or MD5SIG is in use. If the subsequent subflow connect() fails
immediately (EAFNOSUPPORT, ENETUNREACH, ...), __inet_stream_connect()
returns while the socket is still SS_UNCONNECTED and never calls
->disconnect(). This was reported by Clashiko [1].

The error path only dropped the token and moved the msk back to
TCP_CLOSE. MPTCP_FALLBACK_DONE, allow_subflows and
request_mptcp were left as after early fallback, so a later
connect() on the same fd stayed TCP-only.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/633 [1]
Fixes: 0235d075a592 ("mptcp: mark as fallback even early ones")
Cc: stable@vger.kernel.org
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20261013-net-mptcp-misc-fixes-7-3-rc8-v1-1-932c9b182fc7@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/mptcp/protocol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e89a69ab927c9..e6f73a5ee630a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4212,9 +4212,16 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	 * subflow_finish_connect()
 	 */
 	if (unlikely(err)) {
-		/* avoid leaving a dangling token in an unconnected socket */
 		mptcp_token_destroy(msk);
 		mptcp_set_state(sk, TCP_CLOSE);
+
+		spin_lock_bh(&msk->fallback_lock);
+		msk->allow_subflows = true;
+		msk->allow_infinite_fallback = true;
+		clear_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+		spin_unlock_bh(&msk->fallback_lock);
+
+		mptcp_subflow_ctx_reset(mptcp_subflow_ctx(ssk));
 		return err;
 	}
 
-- 
2.53.0





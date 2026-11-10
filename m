Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344627;
	b=kfzC+HLt0dShdsAnNuE8JlJgKrY9aNPkMS8365vnaTGnRPE5Nt/kAk2aPi3BPR7jdWLO
	 +OdQfNiG0Pa8HSF8RJFSEi6eTQLiZCvUUGnwDOY6Mqexc/rsoxBg+B9heAqIoMmQ4vzkb
	 0lc7x3aOCTTl1saGHdz8ZnYq/6Ala7yw1DiBMDroAMRl5vpv9f686Yk1mQD0og8xS8yNX
	 Ef5ZU2glk6JuZAF2vVrT5ePx0uoN+qysJXfU0WdxPjqj0cvveTrJH+yvkJbiu+i37b5ZO
	 mHf8C8lFNSl6uFqaOEuD4Hz3PG4GORz4N1y7jYa13iOOrT1iUiKH894sGOPI+Vz68KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344627;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pd/6Py9KUu/SzLURzf+nN6INSzAdThRE+wkkJPlTMok=;
	b=BgMwaMOPQsED6eUqD0QmgulI1+x6/10GNtUv9UbcHyKc7DrtOQBphYJXjAEDmLBfa+D+
	 lrZon5W5JVkXT6Lv3U9dUYvj5YTBLUgPvx0VXT8lvSh8K0tfGsbqMILjo5Gky5AlDEMnd
	 bdXJ8heSnEAErMI/MbdYkYeYBaLKBbhzDJMuosyV5twWFBxQLwvpWQFMA6yjTphrjFqxd
	 sPvcTBqxXgd8IEHqq6QoKfRP3F1DMWKDzXD0FVAqU77lncaOgJsv5TZYY0+FW9KM/WUD0
	 6mW7Bnyy65jVQXU9C6mMPGmx4qwvTRHQoNsCosJEIBExasdlTo2GijcCj96RZ6YJXiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCSqrGA5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCDB606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCSqrGA5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AD21F0089F;
	Tue, 10 Nov 2026 21:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344626;
	bh=pd/6Py9KUu/SzLURzf+nN6INSzAdThRE+wkkJPlTMok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dCSqrGA51wEFcz20d5sHAL0Acnay3IL3MkrshlPiiIbTRnVNbtlyCr4dBcmKGL2fC
	 dwXur8kHC7Wd0vDXxkmTmLMJLOopanzgfnJfK4OQD8QE9hVL/z+efDLtc2PTHvqcLl
	 KfAPxxMC6mcLQ+lBUiz1Jx21nCHTTwrC28AmjvQgvbV78FOt/RCMQk0qc3Jtgfi4oA
	 WgONgyBCaSCxt1xE3Fh4I/gkcPHn8bvvAuUq60ODSXqf/blJkrI3cAz4bmNuznyQXW
	 7jhVgTyngyO9ijsPmaabcJnowBIi+fZyemetN4tcU+lfBSXzWyB7FJxrS+yW7+yS8/
	 Y1o1dfCd7Rutg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: fix subflow bitfield misuse
Date: Tue, 10 Nov 2026 16:03:44 -0500
Message-ID: <20261110210253.3853770-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060756-failed-5.15-7538fa33bb2f@kernel.org>
References: <20261107060756-failed-5.15-7538fa33bb2f@kernel.org>
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

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 7538fa33bb2f66b8b809ff39d58308be48e197a0 ]

The subflow status bitfield is protected by the subflow socket lock,
with one notable exception: the `close_event_done` bit is actually under
the msk socket lock protection.

As reported by Clashiko [1], flipping the latter bit may corrupt other
entries in the same bitfield.

Move the `close_event_done` outside the bitfield, in a 32bit hole.

Link: https://lore.kernel.org/178959153492.22033.1944011998010756543@kernel.org
Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20261013-net-mptcp-misc-fixes-7-3-rc8-v1-2-932c9b182fc7@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: adjusted __unused from 10 to 11 instead of 8 to 9 to match the existing mptcp_subflow_context layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 913d9b1474b05..4292836203d19 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -446,11 +446,13 @@ struct mptcp_subflow_context {
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
-		close_event_done : 1,       /* has done the post-closed part */
 		resetting : 1,	    /* subflow is resetting */
-		__unused : 10;
+		__unused : 11;
 	enum mptcp_data_avail data_avail;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
+	bool	close_event_done;   /* has done the post-closed part,
+				     * protected by msk socket lock
+				     */
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
-- 
2.53.0


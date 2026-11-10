Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342401;
	b=gcv6YvnZqmHrvuwz0PIyBEywmazSQAgO1KZB9/cvYYD5GVMB+4JKG0ior5j6KNJtb+N1
	 THGqzr9qCIEigz3NXv1b9ttI5KrNqWYa1QkuK+iim50CpvST3g1HfuE72HgzA8Xq5l55V
	 WSamVCVLxXQtCkInhoT2q/mzjq8UNSnmLC755amowmwJwCKZwiVzEENjETk0JVNAauW60
	 NOrUXc5bAyPuA83qiCkIvtpoKX0VwdKmf9L7RfBvYQkwYo2RMXODntBvkCMnaOSlic7Ie
	 fkw2pUuXCEHOUAKjSb5iSpus5FwA1Q2Faog3YkuXN81gcM1eMy/oPKZ3G5fNHJEORpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342401;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PgNNyS/T8zdf9SukFUT27rMGZTDebsQEgBTbaLD/Ad4=;
	b=R5sQWcDtOt0CRwp9S+4U4oFkcVXjc9IVolNsy0BjoZZxYLyaxnH1omH+j7ezcUqUusbm
	 +OMDtBzDw4rfNI+ZKwKrkfjM79Hzt3Pb4dzSVPuEaMOZ2G9eBuyvHkx3H3MiER3qgn6iF
	 pYEH5SaMXqjVSzorubsHdqu3Sy96p8uj9gOzN90Cj2LKuc8giPHoWXT4+b/HgmqW05Xo5
	 I8ykmQa6l6x/vBPgqE4/e/dHr54JMTQd4poAV3gxESCbok8E9lTgzQiwI51eI4Tpt+spr
	 3gZLS41aHbRf4Fo9xRTbSOoMpWy2Al/ad+S/65UVg9VxHuFf1bHPAGQWwWJGjiYzPNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Uq/c1IBn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689BB60A6F7F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uq/c1IBn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F481F008A4;
	Tue, 10 Nov 2026 20:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342401;
	bh=PgNNyS/T8zdf9SukFUT27rMGZTDebsQEgBTbaLD/Ad4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uq/c1IBnBKLq+leOT6iU8eXwAxyYz96tcObYO2sdvqX8O00oWReA9GhMI6tOn15J9
	 wmL33YoI+YbvE1l35pmnpau1x+u1KsH80KUgj3eaF1BMeb2CsZQ3lvXnkBs0ZE5ko4
	 4JAOLOH7PwIDnXFsrXaz4FOfBuTgeW4GDwFC9m4Epm8/CJ992xyH9QikzKiIUNXdhb
	 6pB+LWtnhuHvX07L8MkM8PbbWL9uGrKrUAGmNtrkTVXiEBkdDSFVIDSfU02ji1RQbp
	 ax2J1Bn5YVpxmxNxxxsmZtgUg2r//N7oOrtiVFEA4zjhVz/yATaxUJ1WXFEzgJjgqO
	 GKGcpm3NaiSag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: fix subflow bitfield misuse
Date: Tue, 10 Nov 2026 15:26:39 -0500
Message-ID: <20261110202624.3776163-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053620-failed-6.6-7538fa33bb2f@kernel.org>
References: <20261107053620-failed-6.6-7538fa33bb2f@kernel.org>
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
[ sashal: adjusted __unused to 8 bits instead of 9 to match the existing mptcp_subflow_context bitfield layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1cf67a557ff0d..edc81ae550ca6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -510,12 +510,14 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		close_event_done : 1,       /* has done the post-closed part */
 		resetting : 1,	    /* subflow is resetting */
-		__unused : 7;
+		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
+	bool	close_event_done;   /* has done the post-closed part,
+				     * protected by msk socket lock
+				     */
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
-- 
2.53.0


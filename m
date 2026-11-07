Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049651;
	b=VLH4O8FxvAqqcWWF0Qtr2ZeKCtCMLwvniDzd1EPsX1qAZH98r3mpGpL6xHgwMNmEmk0K
	 UzSaKINfgNsnJ9SW40VqVUOJBparScEKXH7nS7OWPy+wCXz4KtxxS0/5KS9+B3wUBKfN9
	 dUnnLQ4WBiSg6/dE2WJsKKO6Ka3bK+VUh5pdYdJ3/mxmcGcKVeQTR/ZaccP2U7uU/Ekh+
	 wTcsOn10IhmWyV1/pAt3ozvPl0zUuvc/eCpJravzPzCsSuPMhmUFwyokB5vBfHtoN6miq
	 20VIXq/c2B/DsMUvXgCs9C8cEVtWBVspNE8T60ol9gLwNNl+RS6sRxyQeEvd9lvO39A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049651;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XY0WqusLKYeYS37nRcAZ0I0ggkYvnNuunMH75dU3hFM=;
	b=A+XLRNH2j+gDCHE9UkrHRiEVeHwsOcbPlEhRteCAunMyhthtCiiWKxf1Q6B5RUwPyKow
	 dIFT0kndI/boFonXUX9BZMndNaPluMX44W01yOQ/zJ0GV9iRhO80+9xpFEY3HmsqrN2Ey
	 4deB2sJxHYQH2izD9aI2BN9rIM+iBh5Ossm8EblBU5uCFWwBBQdxUWrihByspewJyImd2
	 Y5GqK90H7YJO4R7jdaNuw7Ybtvwf0PzdsrVI5sbcJTmdBYT6w8By0VA+lj7tTTplqaZ66
	 lDSM959Xt3pCykdBRPX9iRoUTXRNrjrMvBbKQwSe1oGcrX/EP7louUwEAZXLfspbPmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBfgGGwS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FCF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBfgGGwS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5051F0089F;
	Sat,  7 Nov 2026 11:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049650;
	bh=XY0WqusLKYeYS37nRcAZ0I0ggkYvnNuunMH75dU3hFM=;
	h=From:To:Cc:Subject:Date;
	b=MBfgGGwSloiqMr6XQBJxi3Q2WStHoL7OACPnudPVuhzS57TSHPkMchZYv0iHD/hsP
	 KTw2Or4OvIsCVaoUnqOdFjeapZgYH95r/rkZ95pEXJC3DV3gDHFyowAPu1tpZ+hlQy
	 +2AfgFJtHkXyOjQBd/Oxlqb1RHflSxKjmUGvmjHNiQrO1+0oyrBrhs/G0ED4QVsd7d
	 wLsgpin4BLQ65wWgzCGKe9T0eeuUJwXyzWnrD2fUJituTgmNthQaRVExIGurKYAq73
	 XJ9LcTJsFVabPyFoMkxbS60e64WHdqOy3qmuqKxOYnA1QJeRBtAguELvGTobN2uoXz
	 4RKmAxxQa9P2A==
From: Sasha Levin <sashal@kernel.org>
To: bsdhenrymartin@gmail.com,
	achender@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] rds: fix out-of-bounds conn_path walks via handshake exthdrs" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:28 -0500
Message-ID: <20261107060728-failed-5.15-50f2103fce43@kernel.org>
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
git cherry-pick -x 50f2103fce43922b6e562937b2d2fc62089ff7ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060728-failed-5.15-50f2103fce43@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 50f2103fce43922b6e562937b2d2fc62089ff7ec Mon Sep 17 00:00:00 2001
From: Henry Martin <bsdhenrymartin@gmail.com>
Date: Mon, 12 Oct 2026 10:53:36 +0800
Subject: [PATCH] rds: fix out-of-bounds conn_path walks via handshake exthdrs

Both the lane and the connection-generation negotiation are driven by
extension headers in handshake packets, and both are processed
unconditionally, even on transports that are not multipath capable.
A non-MP connection (t_mp_capable unset) owns exactly one
rds_conn_path slot, so a peer claiming up to RDS_MPATH_WORKERS lanes
makes every subsequent fan-out walk conn->c_path[0..7] at 504-byte
strides past the single allocated slot (KASAN: "Read of size 8 in
rds_conn_path_connect_if_down"); the generation negotiation opens a
similar out-of-bounds walk on the same array.

Only process handshake extension headers when the connection's
transport is multipath capable, so a peer can never make us walk
lanes that do not exist.  Both call sites in rds_recv_incoming() are
gated.

This is a port of the Oracle UEK fix for the same issue, picked up
where Paula's series of the same change left off.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20260825120132.51636-1-pamoutafpro@gmail.com/
Link: https://github.com/oracle/linux-uek/commit/2fdeb0513f18
Fixes: 840df162b3eb ("rds: reduce memory footprint for RDS when transport is RDMA")
Fixes: 905dd4184e07 ("RDS: TCP: Track peer's connection generation number")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Reviewed-by: Allison Henderson <achender@kernel.org>
Link: https://patch.msgid.link/20261012025336.54756-1-bsdhenrymartin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/rds/recv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rds/recv.c b/net/rds/recv.c
index 6204e577a90ae..93ee4546ae362 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -379,7 +379,8 @@ void rds_recv_incoming(struct rds_connection *conn, struct in6_addr *saddr,
 		rds_stats_inc(s_recv_ping);
 		rds_send_pong(cp, inc->i_hdr.h_sport);
 		/* if this is a handshake ping, start multipath if necessary */
-		if (RDS_HS_PROBE(be16_to_cpu(inc->i_hdr.h_sport),
+		if (conn->c_trans->t_mp_capable &&
+		    RDS_HS_PROBE(be16_to_cpu(inc->i_hdr.h_sport),
 				 be16_to_cpu(inc->i_hdr.h_dport))) {
 			rds_recv_hs_exthdrs(&inc->i_hdr, cp->cp_conn);
 			rds_start_mprds(cp->cp_conn);
@@ -387,7 +388,8 @@ void rds_recv_incoming(struct rds_connection *conn, struct in6_addr *saddr,
 		goto out;
 	}
 
-	if (be16_to_cpu(inc->i_hdr.h_dport) ==  RDS_FLAG_PROBE_PORT &&
+	if (conn->c_trans->t_mp_capable &&
+	    be16_to_cpu(inc->i_hdr.h_dport) ==  RDS_FLAG_PROBE_PORT &&
 	    inc->i_hdr.h_sport == 0) {
 		rds_recv_hs_exthdrs(&inc->i_hdr, cp->cp_conn);
 		/* if this is a handshake pong, start multipath if necessary */
-- 
2.53.0





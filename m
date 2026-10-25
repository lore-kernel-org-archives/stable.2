Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792940318;
	b=mH1/3A/WHh2OKNmoUXxeuqkkoGW41OQSML99hZnXj12iFasEimAUJHkr68iaV1h1v/iZ
	 L5iKmpEETXlplcFVjaSjjhCC+UhpOfigxMSi+MzzTWokrTrSvPB2/Ge21ohNdYxJ6H/jL
	 +2o+IUm81P2LFSepe7yOp+7FUhXYG1zZEZOi6hUgxvxFVNOLPddxUjKAsxehNM8crSwYF
	 7no2FyvI31ND1/7XbS01c1QgCX1whARkEbcIL0H7678HiFfecyJLthBKRNejZ3PAb90t6
	 r7aeOZWs4snJ/Hu93TQsFAF2YMPMavrJL9HHfqSyi0iBxOrVoAvclDg3dRKaJplU8pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792940318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KEKjTIlRL0cR7p1QTUIoE0FuE+zxfuCMnzVdUbm/BU8=;
	b=WU50NtsGME4VTyVlZgmaj1Gke/Ha4Z3AgIeLpZpXuCAW29rKbYBOqwXHTJbMya+LuTa/
	 V4pAzkILkRiafO69Cb9maj5uaZBD2i3kJ1SlaEdziETLD8RccwcdNwgwXFH9dYMchJGXx
	 BqIKOodmdPZLtYyy7r+Az1rZCr6ZAinsNGCJb3IVEIUYWREkbkcGz0F4mTaRFRhRVfn0C
	 DCGHpYwPkR4GacJmC6H0v521lXWZfM7dZGq+ZoJdjAYJGYdaC97je3o0HAeP1qaW69/B4
	 xrD1PsUp4strav6J+Q6tbF/jUPSiz03URNNA7R96FkGHjy4ghc8gaTJYGsGYkPQNHpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=cYTMy7E2;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9CF606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 14:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B9CF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=cYTMy7E2
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-917aca1aee5so23800906d6.2
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792940316; x=1793545116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KEKjTIlRL0cR7p1QTUIoE0FuE+zxfuCMnzVdUbm/BU8=;
        b=cYTMy7E2cH2XTudTTt8j0GWmUx7ICafrO+JmWRka4il1tSncOTKdVztnMkwlw2aZcY
         rYuBymLwu8gLstJffuyuTm+auuS3Aulw5sAGu2ONQ3d+lcUPhN7jtjZLhP8xR2GQ2eXR
         y7+rEVf1s3AJY22GbYXSp69f/eTeOx2qrRnERtQevI0y8vVwKzsAL10LC+qdXgra9TH9
         Vpk9S3OlOgNGmem0OvNrkh/AHuJjNd875Mm6LHnuUVAAfg8DpGFkBCrzacr9HVp+dNUZ
         6IfbAD/h9a5QYF+K+bbRYvnckpHqlrbJcUCG0rmZ6VNiSJAR1KthkhIg1Tflzps3RVWn
         9j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792940316; x=1793545116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KEKjTIlRL0cR7p1QTUIoE0FuE+zxfuCMnzVdUbm/BU8=;
        b=vyrywMMjKqYl5GchvrUC5sB4M4eibdJlh/IdQIQAf4J4BPxkza7tECaY+EyofuabRV
         KdhdxOOqLUplYz+UGjnNd8rALC4F7QUKdUfdF//tBx5424/lbWXunX2OxYt8L/mtzbfH
         5X9Os4Vp9IZp5PHVRUKOSsHc8ySTo9oVKY7Fj8lAuhWTpwiiqw8YAxaRDyxzgNLci8dY
         bYMMc/mFX9lHsQda/XqjsUtHfJPCfQhh4hz6z6ve8l+kWSmy5obX+18uugUj64wZ/+k+
         XplGmx/n5wu8hF84zGdKWq1TGU+f4CXy7xvQSnq0geNRGY97IbzCbrocmxNN7y8xJ0wl
         unLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcN4L8jn59BoX61Uhevt8APCUgoms2ibfOt2woiURKZEGkt9wnN6loBxLlvMfIAec4HpYR3bY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKV0zsa7lMw0BdQfDfojaAngmQnB4+pZ9jF/+JrBE7rikNX6kzv
	dXGXuxAlOFpZUZB8/5F0TDazqfDCJzjcu8NKe697nG4IKJteeaVCgZ0u2RRoJmG2D+e2lSKlaZC
	SL2OGscIF
X-Gm-Gg: AYBFou3K4d1XkBpVTN8dpvMQQA7OPke5pVh3LIiu1EnaYzMcu8x/sKhEUiiG5nnz/xp
	HKO4D1u4oA+qaHaXQsPSdTb6ha/5ooVEWTTYM26TJO0SYa8yPZrFyr2gO/Zl43mnqyk9/qfZsLM
	CfV4UC/sM9xtdBSkZQN4BiOHTOMY+21cXKlohsVyghH7fP5wGxVhHF6VR+DQQveJnc8s2sT769l
	4YUcohPkyzlLxk2BLpc1DotA5U8W9mGW1Sq5Zw1tYfqVascLUQ9o6MMCPpLwLo5Si8oVsqAqkuj
	4wcbP2HlAzvsDuflixEZL/jLSOE4WNBCk+zG24crz/RU//qZ0M90b/xU6/1DZ+VBYDBNEgMygh4
	zyIQRYheNCXCvHTl/a9YCQmbfozmk00lsATg5QVjMDDHqmx2Zy0EkWwn7fykWo7u8vByHIDjiYX
	W/MTJBttuZr1WCKoo2SdqPhsjsoTd3ZmVZjTmptEBUIjCQyirqoQ65+DfUBMTG2EuPq6y+bXqOD
	fFvY6PlJuRrw0CASxECyPXNm9CEQ11VAHYqhr4KGwOyuH+v84B05fK4CpPwb3qFeFI7QMsw0q+h
	tw==
X-Received: by 2002:ad4:5748:0:b0:91b:88b9:e121 with SMTP id 6a1803df08f44-91c48ddeb51mr73244536d6.12.1792940316326;
        Sun, 25 Oct 2026 07:58:36 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd1d42sm47859926d6.12.2026.10.25.07.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 07:58:36 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	jchapman@katalix.com,
	tparkin@katalix.com,
	gnault@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] l2tp: only return sessions of the given tunnel in l2tp_session_get()
Date: Sun, 25 Oct 2026 10:58:31 -0400
Message-ID: <20261025145831.2133617-1-hengyul@cs.unc.edu>
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
Content-Transfer-Encoding: 8bit

Commit 5f77c18ea556 ("l2tp: use IDR for all session lookups") made
pppol2tp_connect() and the netlink session commands find sessions with
l2tp_session_get(), which takes a tunnel ID and a session ID.

However, for L2TPv3, l2tp_session_get() does not use the tunnel ID. If
no other session has the same session ID, it returns that session,
whichever tunnel it belongs to. As of now, a session command that names
the wrong tunnel acts on a session of another tunnel, and a PPPoL2TP
socket for a second L2TPv3 tunnel fails with EEXIST, because it finds
session 0 of the first tunnel.

The issue can be reproduced with:

    ip l2tp add tunnel tunnel_id 3 peer_tunnel_id 3 encap udp \
        local 127.0.0.1 remote 127.0.0.1 udp_sport 5003 udp_dport 6003
    ip l2tp add tunnel tunnel_id 4 peer_tunnel_id 4 encap udp \
        local 127.0.0.1 remote 127.0.0.1 udp_sport 5004 udp_dport 6004
    ip l2tp add session tunnel_id 3 session_id 7 peer_session_id 7
    ip l2tp del session tunnel_id 4 session_id 7
    ip l2tp show session

Before that commit, the delete fails with "No such device", and session
7 of tunnel 3 is still listed. After that commit, the delete succeeds,
and session 7 of tunnel 3 is gone.

This patch will make l2tp_session_get() return NULL when the L2TPv3
session it finds belongs to another tunnel.

Fixes: 5f77c18ea556 ("l2tp: use IDR for all session lookups")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
The first commit that shows the problem is d18d3f0a24fc ("l2tp: replace
hlist with simple list for per-tunnel session list"), two patches later
in the same series. Before it, these L2TPv3 lookups found no session at
all.

The receive path still looks up L2TPv3 sessions by session ID only. Only
the lookups that name a tunnel change.

Tested with the commands above, the same session ID in two UDP tunnels
(still allowed) and in two IP tunnels (still refused), and two PPPoL2TP
tunnel sockets.

 net/l2tp/l2tp_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 7e042a3e648c..f509750f80d5 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -315,10 +315,19 @@ EXPORT_SYMBOL_GPL(l2tp_v2_session_get);
 struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, int pver,
 				      u32 tunnel_id, u32 session_id)
 {
+	struct l2tp_session *session;
+
 	if (pver == L2TP_HDR_VER_2)
 		return l2tp_v2_session_get(net, tunnel_id, session_id);
-	else
-		return l2tp_v3_session_get(net, sk, session_id);
+
+	/* An L2TPv3 session ID that has not collided may be in any tunnel */
+	session = l2tp_v3_session_get(net, sk, session_id);
+	if (session && session->tunnel->tunnel_id != tunnel_id) {
+		l2tp_session_put(session);
+		return NULL;
+	}
+
+	return session;
 }
 EXPORT_SYMBOL_GPL(l2tp_session_get);
 

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.53.0


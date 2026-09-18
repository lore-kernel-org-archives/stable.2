Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AB03B42CC
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723300; cv=none; b=MH/a2006Cqh6tBkI8jYN0hDW9ygLejDjeIFXlpvXFh2Ruorut37KCmBudHKC+4ynRUcLbfuPdU3J4PSiqlHrrRcIaNJMyVTstGJQlZD8pt1WWHk6vuQm92T/2ORCFhWDAAW9B7DXQWl9h/RyQ6pvJzoQY7w/EZ3Pr0RfQ+y/clY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723300; c=relaxed/simple;
	bh=6IcpDBPVeKpK7pxb2P51FzmHJu0Pw6iOdwz/Gqh99hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj0oocyXxgYzhQv0knTzTVEahio8GhbVj4gB/Gz3Y2hq4gz6r/PMdMgy6Ms0LiNi/lBncRZkM2EFDqbv5uBz/ikbWlKFRViJuaTvP1aIuljPZLpd8ONVkm1sWCsbKpdu0Z1+UOz68TcJsvVz3ThIibXoKXgiEn2X+sqFixHKepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDZW+XaI; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDZW+XaI"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so283931a12.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789723298; x=1790328098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T1Vs33RF9861v3+J3mo7dJ02ANXeWdtG1TRyC/RC/J0=;
        b=hDZW+XaIoTF38bmKJBT0YNIC96x9b10tb4cKedr/mLTOqyRsS10q1SdEaOjf4XlrEf
         JOZALnrcwwPmJ/GZT3BBX6mTAykiIoAKdbusVv4HGQW+sLsZXG9sTCze+lVU3IlfbxYF
         JB99oUpcJPkoUkokpjJgimE1q+ybX0OUPsES476pVE+loBqIbzR70Uy4a1D7RyyXTj/t
         S4mUZAxgR9XQCvYNBgbfw4o27Jj9oH5p1/t3P01IUY09z0hTQMvIJxTOk7jaPf7x/shg
         UEpnv3MF3tr+A2EwjT+eLcnzbQpdv9qjOJgwRHlwr8OfWXBLb7brTFbMVyppQhh0TBMi
         po/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789723298; x=1790328098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T1Vs33RF9861v3+J3mo7dJ02ANXeWdtG1TRyC/RC/J0=;
        b=Wn7LYDL0JQWJJXfhMLTvT3+Ayk8n33/07I6gnKcr1yHl5vCICPmHQD5GEtAS3L/2aB
         XDw6weRS8uVQ5V7ALDLYVhx1xKDJ8Gej+ayjNJHu5Sf2EGYJaLV8Hr6LcThu8vpskoDT
         9FGm7l0QNkj/aoZ5mj4EG9ycyaAr7TPX76Tca/XUI6vmcejYfuxr8lj5qeiFcrJ4OgdA
         6TZbkthnrrSoDQqB31e/w097A5+HfdG1/4wbwIiT9LPSgNWaQybMfLPC+aCYBxiWD2nM
         Iw5eXTx9lqoaGAeRhXmpIaBJHWIBUGeRKYm9v8bXzJuezqQ/G5gxPkbDd+TWKqGyQHmq
         /4DQ==
X-Forwarded-Encrypted: i=1; AKwUvByHeraY8F+0sF8w+ko2JWPJDfsWpkQKEo6xJlKJ0xxjdORUoW3o7kiVLFK266hDmSPSil2cVLA=@vger.kernel.org
X-Gm-Message-State: AFuF++k3NRymj8LnJ+ErbqOnHusYMyKReZNKZC0x1pbnl7pEFf8LsOYP
	sar9Ffmh2e9VX5QLowe6tjEh5xnedeQN8Avq3H13NcM4LyxHvTLdp5Xc
X-Gm-Gg: AYBFou058kcF+PG2L9uQAm/jVrd9jX6ppl7mDPKVuCnCi78Ys0vLrWKzwMl1f5aRj5H
	QgvHDhjAsHBDw21F2dI4Jqj/2xZ+S+xupsG3uiNz/OM1FMEypuRgaStN7MviBHhUqPQMLNwvub2
	DaT3wn3NgDbUg05KqN9qgB1FZblYA+gmaeD6bjb7+Laeny9ZDb5g05s90gCzKt9yfGQVh5RzY4R
	JciZ5yB33p/KuMHAFqb1z9RF8YCw0Vy4aq5on5xrj/M6A8l35VLUfNe1FzqKhYRD3o4TZfxcGau
	RUIrX9wbCBjsThPwVrZLhru0mOju4LBWKRi/ehjYrUG39bMtOGVcnrNVAI06GIYE/xujnOsT5Xs
	GQGcbYdPp/Pnhy2nabCoMjFM70JQDhg1uQS2clqQHkQyn+2DuNT04B4C6gu/V1nf33HTbq+58Uz
	trg8nz0ft4zUXyi3qyW48aonfDaDUvym9MGDBJJRA4QDWXp4W03fuRPtUPDHeO+OGBi3/2EC/c3
	AnwwT3gUpmPIvdk+6cDCZGmc/wL3u5eGJ4uMrW/HxeXKSeJiw4wSUq7QuV2znEJvED8JJZxMnmX
X-Received: by 2002:a17:90b:5305:b0:39e:4c81:6c63 with SMTP id 98e67ed59e1d1-39e54dbe3c1mr4210633a91.30.1789723298457;
        Fri, 18 Sep 2026 02:21:38 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (n11212025079.netvigator.com. [112.120.25.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6137e111sm677341a91.1.2026.09.18.02.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:21:38 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <enjou1224z@gmail.com>
Subject: [PATCH net 2/2] tipc: make conn_idr teardown safe
Date: Fri, 18 Sep 2026 17:21:13 +0800
Message-ID: <909d83251b5e7d4b0cbe00e5e7246604ee03bb47.1789722780.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789722780.git.xuyuqiabc@gmail.com>
References: <cover.1789722780.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The teardown walk iterated conn_idr by incrementing a numeric ID while
holding idr_lock, so it could scan a large range of unused IDs without
letting a connection's final reference release make progress. An entry
whose last reference had already been dropped could also be resurrected
by the unconditional conn_get() while its release callback was blocked
on the same lock.

Walk conn_idr with idr_get_next(), release the lock and reschedule when
no entry can be taken, and use kref_get_unless_zero() so a connection
that is already being released cannot be revived.

Fixes: 35e22e49a5d6 ("tipc: fix cleanup at module unload")
Fixes: 667eeab4999e ("tipc: Fix use-after-free in tipc_conn_close().")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 net/tipc/topsrv.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 908622a3d0fc..9333e36a74de 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -710,15 +710,20 @@ static void tipc_topsrv_stop(struct net *net)
 	cancel_work_sync(&srv->awork);
 
 	spin_lock_bh(&srv->idr_lock);
-	for (id = 0; srv->idr_in_use; id++) {
-		con = idr_find(&srv->conn_idr, id);
-		if (con) {
-			conn_get(con);
+	for (id = 0; srv->idr_in_use;) {
+		con = idr_get_next(&srv->conn_idr, &id);
+		if (!con || !kref_get_unless_zero(&con->kref)) {
 			spin_unlock_bh(&srv->idr_lock);
-			tipc_conn_close(con);
-			conn_put(con);
+			cond_resched();
 			spin_lock_bh(&srv->idr_lock);
+			id = 0;
+			continue;
 		}
+		id++;
+		spin_unlock_bh(&srv->idr_lock);
+		tipc_conn_close(con);
+		conn_put(con);
+		spin_lock_bh(&srv->idr_lock);
 	}
 	__module_get(lsock->ops->owner);
 	__module_get(lsock->sk->sk_prot_creator->owner);
-- 
2.55.0


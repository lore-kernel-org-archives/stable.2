Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697AF367F25
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976022; cv=none; b=FstPW7rPgX55kXz+ZMYCeUtwj++N/4UQBu6CmGgmfPzwTG6ds/MRNUkrPz7Dbgwk9yJwEb13avm9DXOEFUS9YQgK/QcDMlc8VO0XeCgbg1sFc3f3yk0hizFIDjBbVdW4tLGsPbIp3I2hh3ikApAIp4NJLllFi9nyLeHnQRIux2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976022; c=relaxed/simple;
	bh=3KoknGohNS4LzXvSjC+6L5y5Fd1ZCLMV2KoCOQA0Vc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Izv8Hs2olLggN+FkyaeYYyckKpN2lmE85POEnuM1vvaCJlnSDMj4Icn7jld4Sgty41/dDkKEei8D7o5+LT1v4Jvv32h97K40MGODoYc9OuEwtQpjYr6eeGFJoQ59VHel6c7QLHU77BPWcVjMurY3XjQm0JeegmZsaijo6AJApZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhqXEf+k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhqXEf+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C0E1F000FF;
	Wed,  9 Sep 2026 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976019;
	bh=CF77tnyFnmijGebRSWvAdhe9f9S9Dzj0UnT4y7NM8D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RhqXEf+kzZ2XsqkrncqrON+5EkCcWy78PRwpwR8YS5Bp21aA11FXQjHEQn8VLf3aq
	 EN0NzcoAw3AKlAq/37KzjIB2LBRVc6DbD5QChadb6qmWxCwRN57h23pEXRcdG8Ppjr
	 vuiiJJfh0CDmiCPQzVcsBJDyIUz1Ky7vx7FNewGxiSXNTbzQVcVH1A76xEuMxBY87F
	 tYYdWHJfC5YhP1kfJB/rtLNCA8iRrkXEM8eg3/GDtSKUwRt8i400skn06jWFxsx8zi
	 SOKsTpVqP0iiglI5hrqmF5Wfj/UJ8KhWuQbvhhzCWQBJtFa/I4V0XSqM/qaFabwd7u
	 OTp7Ap9gz8MtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/6] l2tp: cleanup eth/ppp pseudowire setup code
Date: Wed,  9 Sep 2026 13:46:53 -0400
Message-ID: <20260909174655.3345526-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909174655.3345526-1-sashal@kernel.org>
References: <2026090341-survival-shrill-fee9@gregkh>
 <20260909174655.3345526-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Chapman <jchapman@katalix.com>

[ Upstream commit d93b8a63f011f252dcfb101d5b90367bd8f42db3 ]

l2tp eth/ppp pseudowire setup/cleanup uses kfree() in some error
paths. Drop the refcount instead such that the session object is
always freed when the refcount reaches 0.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: af20e269f745 ("net: l2tp: do not propagate multicast notification errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_eth.c | 2 +-
 net/l2tp/l2tp_ppp.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 5d45b2cc2aab0..7d350ed218772 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -332,7 +332,7 @@ static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
 	l2tp_session_put(session);
 	free_netdev(dev);
 err_sess:
-	kfree(session);
+	l2tp_session_dec_refcount(session);
 err:
 	return rc;
 }
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 1d17e523b254b..f219bc992fb9f 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -759,6 +759,8 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
 			goto end;
 		}
 
+		drop_refcnt = true;
+
 		pppol2tp_session_init(session);
 		ps = l2tp_session_priv(session);
 		l2tp_session_inc_refcount(session);
@@ -767,10 +769,10 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
 		error = l2tp_session_register(session, tunnel);
 		if (error < 0) {
 			mutex_unlock(&ps->sk_lock);
-			kfree(session);
+			l2tp_session_dec_refcount(session);
 			goto end;
 		}
-		drop_refcnt = true;
+
 		new_session = true;
 	}
 
@@ -865,7 +867,7 @@ static int pppol2tp_session_create(struct net *net, struct l2tp_tunnel *tunnel,
 	return 0;
 
 err_sess:
-	kfree(session);
+	l2tp_session_dec_refcount(session);
 err:
 	return error;
 }
-- 
2.53.0


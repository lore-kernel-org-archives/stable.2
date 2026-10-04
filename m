Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2793161BE;
	Sun,  4 Oct 2026 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147626; cv=none; b=tWzBXDfMDFmnr/w2BK7sRfcCbJiO7vUqyf1FtsT7T2a1sHcGJNhkxBeGPQCmmFHjFtZIY7/IyUjWxOpt8A40Jw4VaPTywB88Spn93PbB0A01EsKvilnxC/3QzrHCcgi3tR/cngtorIuUkBB4odmfokvvAf0X5HRzYhTb1yRsncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147626; c=relaxed/simple;
	bh=r0rHDsLZOA2ic17J4JKnnqLHj1ZrU+69qCj1TVSofUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPFZI5OMzH7XwyInDM1o5mkZTWsWQuCjDJpOEADc1G6dLT5BKIMBm3nzPz17/uPZocN22vaf9uRbeRjkp6WfuXxONOI/jd69Q5HoBDFPcO+aQGSwyUhRONlhFHO0RVbQDFEzCwOkg8KkEAIyy6pHifIhg5ANmPnQhdaB32PqlwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=dSafmNae; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="dSafmNae"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uD72eE0Kdngwa+FAEryAIrrH8bo+4S26T3z3EGBC8gs=; b=dSafmNaeimK8ATnqGNPuGwOWP3
	9VJWmcsshSyUV+lXhxptXp+plTMd0EJpz9ZQfnh8CDFnyYxuYMfR3mxLwmZytxY/a6feqsYj2JJEK
	hMCixJIwWm7uV9tVlLcVBjICTEQoi1IpF865GpxySUFhqLGF3JaxpzRLja6glkDhClXRQbxa4JG2q
	AZ2SoUz7IsrwBXsB0ExcBs9OCwYJyNwf8cvDViRkskQpHoNd/ACBQW8HBq4RCVXn1A8CORb5zZGWy
	fu0XnYZq98RXmHo+0/70ynoSVu3i6Obh1RbxRKvvafFXLQYYADU7l7eVaKmjqG3PLGAgFyhDGInWf
	k+O75C5A==;
Received: from [151.115.150.205] (port=43990 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xDTJn-00000007JF1-0HYM;
	Sun, 04 Oct 2026 23:00:23 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Jon Maloy <jmaloy@redhat.com>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] tipc: fix use-after-free in netns teardown
Date: Sun,  4 Oct 2026 21:00:16 +0000
Message-ID: <20261004210016.3051310-3-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261004210016.3051310-1-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261004210016.3051310-1-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

conn_put() decreases the reference count of a connection, and when it
reaches zero, tipc_conn_kref_release() removes the connection from
conn_idr and frees it. Removing the entry is protected by idr_lock,
but decreasing the count is not.

During netns dismantle, it may happen that a connection gets its count
dropped to zero by conn_put() while tipc_topsrv_stop() still holds the
lock idr_lock. tipc_topsrv_stop() calls conn_get() on that connection
whose count is already zero, and then releases idr_lock.
tipc_conn_kref_release() can then free the connection before
tipc_conn_close() uses it. KASAN reports a UAF as:

  BUG: KASAN: slab-use-after-free in tipc_conn_close (net/tipc/topsrv.c:158)
  Read of size 8 at addr ff1100000cf4f408 by task kworker/u16:3/70

Stop accepting connections before walking conn_idr. Use
kref_get_unless_zero() to avoid taking references when the count is zero.
Walk forward through conn_idr to disconnect all connections before
draining the workqueues.

Fixes: 667eeab4999e ("tipc: Fix use-after-free in tipc_conn_close().")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/tipc/topsrv.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 01dd34b..f3f32fd 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -698,19 +698,25 @@ static void tipc_topsrv_stop(struct net *net)
 	struct tipc_topsrv *srv = tipc_topsrv(net);
 	struct socket *lsock = srv->listener;
 	struct tipc_conn *con;
-	int id;
+	unsigned long id;
+
+	write_lock_bh(&lsock->sk->sk_callback_lock);
+	lsock->sk->sk_user_data = NULL;
+	write_unlock_bh(&lsock->sk->sk_callback_lock);
+	cancel_work_sync(&srv->awork);
 
 	spin_lock_bh(&srv->idr_lock);
-	for (id = 0; srv->idr_in_use; id++) {
-		con = idr_find(&srv->conn_idr, id);
+	for (id = 0; (con = idr_get_next_ul(&srv->conn_idr, &id)); id++) {
+		if (!kref_get_unless_zero(&con->kref))
+			con = NULL;
+		spin_unlock_bh(&srv->idr_lock);
 		if (con) {
-			conn_get(con);
-			spin_unlock_bh(&srv->idr_lock);
 			if (con->sock)
 				tipc_conn_close(con);
 			conn_put(con);
-			spin_lock_bh(&srv->idr_lock);
 		}
+		cond_resched();
+		spin_lock_bh(&srv->idr_lock);
 	}
 	__module_get(lsock->ops->owner);
 	__module_get(lsock->sk->sk_prot_creator->owner);
-- 
2.47.3

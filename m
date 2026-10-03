Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C917733B6C4;
	Sat,  3 Oct 2026 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791055597; cv=none; b=E/fbhK5boorsggPsgclzQSm6lMx+HaUxTMCk0XCOv/PsS6KVuYnrnRf1iRdE+/QVGKT3i7PWCHulF1dQLwK77kVfoTqXe6G34lMs7hNNzy/rldKA8Xd8K5t/C4DsojgrL67hV9eFTjkdzEIAfjnJH1n1RcKGmfNRxcUW1OvMfYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791055597; c=relaxed/simple;
	bh=ne4DE2Kbps8U9ue9LceVqg74lnohRogFSoEolKYwoRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q6rdu8PHckYjtu+aXOPUW1V/oCgz8ZBPfD42xMKNwxJ1Gc7f2HODYQYW2NuT0VIqLgzB/lwSSRPQ4eWtHnTn1M3WrVvRfDZwuD1Uy6CSbmzY+JE9+xkoYbf3sXxv2wYcCk+NumsZMqFbrCHaI/sfihLmTfCmfBrE+QLyn6N2ng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=CyscC9hv; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="CyscC9hv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=DUnsrRI8Dm7GcYsyfjeM01fsNT7D1vSKGaEorMuk4N8=; b=CyscC9hvPlLWkMjMLoa/3Fqn1F
	vOS3RTmIhxCKUrz9YFFAf1gCC9ktt3RB57J9UYUq79sis5iDkynwRynPsjutUg+WYi7LruqdAAlDT
	FszsEriA2qdwm+F0+QCCsszGCJFRfhh/Xf3ECHinHDl0J1+SfrTVWI/elAEuqlSsQFRYTwDO1kCDs
	0SVosPwbsG+7HijrOAT9wKWL0n5lJqukVORPpyWKTioAMRv8saoRGhNenCdt2RT5ymGU/A0Vm6ltq
	vooAlq6sPj3O5yvgN8KUgpYtKk1wxK70Ngc5jKTI63WmPXgHXA2aCUy0H4WpEIAnr3Hf2QmFGuCH7
	chTFSRIQ==;
Received: from [151.115.150.205] (port=58646 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xD5NQ-0000000FAnS-3ZFO;
	Sat, 03 Oct 2026 21:26:28 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Jon Maloy <jmaloy@redhat.com>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH] tipc: fix use-after-free in netns teardown
Date: Sat,  3 Oct 2026 19:25:31 +0000
Message-ID: <20261003192530.2414682-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
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
tipc_conn_close() uses it. KASAN reports the UAF as:

  BUG: KASAN: slab-use-after-free in tipc_conn_close (net/tipc/topsrv.c:158)
  Read of size 8 at addr ff1100000cf4f408 by task kworker/u16:3/70

Stop accepting connections before walking conn_idr. Use
kref_get_unless_zero() to avoid taking references when the count is zero.
Retry from the first entry, releasing idr_lock and calling cond_resched()
between iterations so pending work can finish.

Fixes: 667eeab4999e ("tipc: Fix use-after-free in tipc_conn_close().")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/tipc/topsrv.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index af530c9ed8402..9ab2349f71190 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -700,16 +700,23 @@ static void tipc_topsrv_stop(struct net *net)
 	struct tipc_conn *con;
 	int id;
 
+	write_lock_bh(&lsock->sk->sk_callback_lock);
+	lsock->sk->sk_user_data = NULL;
+	write_unlock_bh(&lsock->sk->sk_callback_lock);
+	cancel_work_sync(&srv->awork);
+
 	spin_lock_bh(&srv->idr_lock);
-	for (id = 0; srv->idr_in_use; id++) {
-		con = idr_find(&srv->conn_idr, id);
+	for (id = 0; srv->idr_in_use; id = 0) {
+		con = idr_get_next(&srv->conn_idr, &id);
+		if (con && !kref_get_unless_zero(&con->kref))
+			con = NULL;
+		spin_unlock_bh(&srv->idr_lock);
 		if (con) {
-			conn_get(con);
-			spin_unlock_bh(&srv->idr_lock);
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


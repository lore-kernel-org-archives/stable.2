Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045208;
	b=RqDSK3MQtPYzAs/Zzm8QaVOInECGsn5vuS/sXY+k9q3zFwdRYMcCJ6aQBVyyTbvt+Ju5
	 25hLwMV5hfPcMKftRmSm5DWzW2wnksYwt3dTFi8A3Vds/EgBIoDHuJLmAuJ5w7xElQztE
	 UjDe8Mz53+ocozyGAW3ZEQ7+v4mkl9BVNVJEiPMNQ3tt9wqzDoZIL8kA2RJYiefStQx76
	 kwS0pkjxTclBHV4ni8ldcUs7wbop9wDON5EV0IehpcCvVjy8obBFriTQIn7NuFcH+PFTZ
	 ffB4QBgX8/0q3dGNALZet33EAQpIX++L6SuhLk86jz1y4CnnvkCHEDKQaTlRjlv/DjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045208;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=4VrW0u/vwrlVPbELXfi7l9lOvTXrXBvrEj36bIwr0sk=;
	b=zo2U8+uyMozrW8CzxYkNaKKw7bj5QuvDtgJt7yN+uXEsb1iJpEISGj5Ju68b9SWRMofo
	 ONX86SOx6fhi88PZcR1uc+vOJ3MbMoh3T67kTQ6Bg1DJgx5fqCV0GHjkhZtt/ygQvy4QE
	 gxX7guOCZV01uEm7Lu6zlNDYBMHjmHcamQOBXbW+2MaArHI7Xk+x39HqlFJ2H3k3tknGF
	 m2NO/Pl5WKEygZfQxH+B8+sE+stDZS+BUIwfbIkL0KPmYRElh3meZ5CyNex+RQuqsJPdH
	 V/IiBP9lqW/36gjJ2l396UpSzLJp1pvwN8JXkxLC2mb4xdKku5auWY795V2HmAuwYeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=j5EzPif7;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95050606D801;
	Sat,  7 Nov 2026 09:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95050606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=j5EzPif7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=4VrW0u/vwrlVPbELXfi7l9lOvTXrXBvrEj36bIwr0sk=; b=j5EzPif7qWaH8FLfjLA5VfHekA
	tKAjF67H+oBT8Ai/UfQHDuJQktFK0ahRq8aFU8KA3cn3eNSXrl5BbwP6JTKe0PuCfi3BfgZnLpwVM
	okhet151oXhNWSNXUGlDSfj0NQQ81maFrJQ5SwYmTT536BEhg1XulowBW+fNsjcgg9jnaWs1AtOzu
	MYmn72M1VyoOgjb+hXbTMsDWDJZZVB4TJ51ldnvIcACQyCNgUF1XljE/NskztG1VCiB1/wTa7cYiI
	SB1h0oKuP4SAYmQ7BHjm4TSaOJ6dK1aor2pakzXt5k9YA7iWBBcVNWr26q/+bW/Cq8R4lDheqi/iV
	WaQ4csqQ==;
Received: from [151.115.150.205] (port=54728 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xPd73-00000008Fns-1DGs;
	Sat, 07 Nov 2026 10:53:25 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v2] afs: Fix server UAF during peer appdata lookup
Date: Sat,  7 Nov 2026 09:52:29 +0000
Message-ID: <20261107095228.917198-3-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
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

AF_RXRPC does not take a reference on objects stored in peer appdata, so
afs_find_server() can race with afs_server_destroyer(): it may read an old
server pointer and pass it to afs_use_server() after the object has been
freed through RCU. KASAN reports the UAF as:

  BUG: KASAN: slab-use-after-free in afs_use_server+0x2e/0x250
  Write of size 4 at addr ffff888002b910f0 by task afs-peer-uaf/87

A lookup that overlaps destruction can also queue destroyer work while
dropping the last reference, or leave an inactive server without a GC
timer.

Keep the peer appdata lookup under RCU and take the callback reference
with __refcount_inc_not_zero(). Make the unuse paths rearm the server
timer instead of queueing destroyer work directly. This lets timer shutdown
serialize teardown and retries destruction after an active callback wins
the race.

Fixes: 40e8b52fe8c8 ("afs: Use the per-peer app data provided by rxrpc")
Fixes: 4882ba78574e ("afs: Fix afs_server ref accounting")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
Changes since v1 (after review from Sashiko):
- Use the timer when an unuse path needs to retry destruction.
- Rearm the GC timer after a callback drops the last active use.

v1: https://lore.kernel.org/all/20261103231930.3213821-2-Jeremy.Jean@oss.cyber.gouv.fr/
Sashiko: https://sashiko.dev/#/patchset/20261103231930.3213821-2-Jeremy.Jean%40oss.cyber.gouv.fr

 fs/afs/server.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index 189138bd6d712..499ea4f2fbab9 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -23,11 +23,21 @@ static void afs_server_destroyer(struct work_struct *work);
  */
 struct afs_server *afs_find_server(const struct rxrpc_peer *peer)
 {
-	struct afs_server *server = (struct afs_server *)rxrpc_kernel_get_peer_data(peer);
+	struct afs_server *server;
+	unsigned int a;
+	int r;
 
-	if (!server)
-		return NULL;
-	return afs_use_server(server, false, afs_server_trace_use_cm_call);
+	rcu_read_lock();
+	server = (struct afs_server *)rxrpc_kernel_get_peer_data(peer);
+	if (server && __refcount_inc_not_zero(&server->ref, &r)) {
+		a = atomic_inc_return(&server->active);
+		trace_afs_server(server->debug_id, r + 1, a,
+				 afs_server_trace_use_cm_call);
+	} else {
+		server = NULL;
+	}
+	rcu_read_unlock();
+	return server;
 }
 
 /*
@@ -356,9 +366,11 @@ void afs_unuse_server_notime(struct afs_net *net, struct afs_server *server,
 		return;
 
 	if (atomic_dec_and_test(&server->active)) {
-		if (test_bit(AFS_SERVER_FL_EXPIRED, &server->flags) ||
-		    READ_ONCE(server->cell->state) >= AFS_CELL_REMOVING)
-			schedule_work(&server->destroyer);
+		unsigned long expires = jiffies;
+
+		if (READ_ONCE(server->cell->state) < AFS_CELL_REMOVING)
+			expires += afs_server_gc_delay * HZ;
+		timer_reduce(&server->timer, expires);
 	}
 
 	afs_put_server(net, server, reason);
@@ -381,7 +393,7 @@ void afs_unuse_server(struct afs_net *net, struct afs_server *server,
 			server->unuse_time = unuse_time;
 			afs_set_server_timer(server, afs_server_gc_delay);
 		} else {
-			schedule_work(&server->destroyer);
+			timer_reduce(&server->timer, jiffies);
 		}
 	}
 
-- 
2.47.3


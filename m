Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748486;
	b=NYcRWFuwNvQLWXzgXvqS/XuH16Bt0HaHzL5MtrIdnqOJlAdWSbjGZ5+YPxY8va1t85W1
	 WMEm8ZNp/iK5QaiNcEGRMS6g3OaXTiiycp12WVVcvNBuHo4dOv8iDibHJVukcLSJdlfQI
	 MU0XdY+MgLrFSByCKMdhz/nOw6xMy0wQDmjNMwH9AOpUA44Z3GHdz9mSYrqqinzSthqu3
	 HKmwjObTxtlHOg3xnlt7E1RR558rpE5Mygh5nV8TofAEIQleaW07ppkPjYein2/NlwTjz
	 cxXv+I7J/mMXYRmNWLczqVMkuyfCPyogiThwMCnmeG/vUpuV1qJZxyR3/QRCOYoKxFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748486;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=HTEjSItWKIsdJkuG+lzcjXBextZFeFZ19Xztacgy4NY=;
	b=qxwXPfaNvoHImZITNMukKb+HIRCjSH6R/mjQPFJAbidKjUI32AX/RIIpLqGn+/xEiOy4
	 UHJqOZ1QpU3Pu/DoYCdstlbs2R8Kc3mTvxsASvVHiCCCX0HyiTOtp4HjgKAo8yqURZTw8
	 EAMMbTMeo35+Q1lIGpKpseNConCkSUVvrEnuDZcKiP3zzrZ52mBFfnzCnjf3VDcPf4Bna
	 kBkkZbEkYByDgZd2+MsZU0ocAkuLwwj9wPMDJU0mu9tc6MPt4zTPM4GFxH8YIn+vY4HLl
	 8iN18anHnv9RJo2CPvxUZJ4CELqBQM3n/56017Va+M5EIVeRuUUQCnFJ6VxhxctwBSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=nNCcFfpI;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EA8606A324;
	Tue,  3 Nov 2026 23:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4EA8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=nNCcFfpI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=HTEjSItWKIsdJkuG+lzcjXBextZFeFZ19Xztacgy4NY=; b=nNCcFfpIZVrYjsdr6/bFyuDAa0
	de83MePl5BcC5g2v4OIYYHkZHtRU6cIoCHVDv0RavLPPq1R+ffyLWg8qt6DFL5aHXHVsobuFZHwMX
	j6NdvR5YI+UY748SjIfvHtehCzwxq1EhtGY32QV5tuZfQZBzGiDfcjKerMhxQht2c1ijJ0YjaN9Bs
	mY2bCY2pgQBeIJjp/1Jm0m7BDD31c8RN/mZgBypbLR9WW6VNUDVzTGXbiQTaqRn4X8DDjn03UHqbx
	cMULbLPrIENQ45aEJmtDEio52AE+h4PNzzNxYWZbi1kbc4Dt2F0m75ZXyU8EnHHGnloKgxjDEIleS
	mqUEdV3g==;
Received: from [151.115.150.205] (port=52178 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xONvB-0000000GktW-08ml;
	Wed, 04 Nov 2026 00:28:03 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH] afs: Fix server UAF during peer appdata lookup
Date: Tue,  3 Nov 2026 23:19:30 +0000
Message-ID: <20261103231930.3213821-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Keep the peer appdata lookup under RCU and use
__refcount_inc_not_zero() to get a server reference before leaving RCU.

Fixes: 40e8b52fe8c8 ("afs: Use the per-peer app data provided by rxrpc")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 fs/afs/server.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index 189138bd6d712..506119f9b1d32 100644
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
-- 
2.47.3


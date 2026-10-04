Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5242730D41F;
	Sun,  4 Oct 2026 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147625; cv=none; b=dQEwCsD5waxQPWZCGuGgmBTKdPlu+BfHvzeczR61HKUoFwOUNLgxhwiLcNSH6fyMgWETY/jl8wzNAF2GOLyYOEqTB0k1ARBaKC65RQTX2GYjnSDdaHx6CuMiXsmzCCYppm3gEfdeA2tn7TAdsW5u/x3XjlOsuECC5qtyqj+DIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147625; c=relaxed/simple;
	bh=Y+ejeEjlI5n5SG+SA3sJmeWhJzAWBHlfIRgG7Ea0faI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qj5jYijSfPft7G1FhCFeUNkBAFkSpG0AR/DWxVuHZtUOqD3iIGpZ3WHIRsVtWjKlqndVz0b74GWMNi9Faw5fjTE77Zrr6MllNNiHZzs9fJL+PSf09Fco33aa0T6o6K8VdpggXFzmLCUWuSrS/WlkQ2nSMHFAVgsMNqGX3ZjPQPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=h1+i2vAd; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="h1+i2vAd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pCS2YIxhblGf/nbD6eEwyBWjK/vtbIcjnyrUYdS6rWg=; b=h1+i2vAdqzcCM+gByh+xeFmOAY
	9njs3we5iT1ZdWRRHZ7zST9hvhgyONbVnETKNP9b6oG+/je1m9WEpf9tqTeL852+jvEddK3Y9+mW2
	VcWNLru1umkmHwcTuXMlrVJJ6mXpnyPMDegGu+wZplpL8z2gcePvx+eXFaN0wbsoI/ZiB4w+asttS
	lGfCm2UGaXzpEH04Dc56b/fo3hVQMuAC2ojUICh37j/Zf+UIaFNDlzjbIKxzSSTolnIygJcEmDjGU
	HLs3i3MGVN/0wonm7Mh99+PNJdwszIkha7zfrAnWxTCPeA+5D+OFcX8qw44ZBHaX/NiCAdWiD8ZN0
	QJkP581w==;
Received: from [151.115.150.205] (port=43990 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xDTJm-00000007JF1-1pln;
	Sun, 04 Oct 2026 23:00:22 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Jon Maloy <jmaloy@redhat.com>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] tipc: skip socketless connections in topsrv teardown
Date: Sun,  4 Oct 2026 21:00:15 +0000
Message-ID: <20261004210016.3051310-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Kernel subscription connections have no socket but can remain in conn_idr
after unsubscribe while send work is pending. 

Skip tipc_conn_close() for these entries to avoid a NULL dereference
during netns teardown.

Fixes: e88f2be83282 ("tipc: fix race condition at topology server receive")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/tipc/topsrv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index af530c9..01dd34b 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -706,7 +706,8 @@ static void tipc_topsrv_stop(struct net *net)
 		if (con) {
 			conn_get(con);
 			spin_unlock_bh(&srv->idr_lock);
-			tipc_conn_close(con);
+			if (con->sock)
+				tipc_conn_close(con);
 			conn_put(con);
 			spin_lock_bh(&srv->idr_lock);
 		}
-- 
2.47.3


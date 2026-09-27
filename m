Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A33D2367B5
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790497136; cv=none; b=bK50x/alnBS9+arJUq3336y+S3PjMEVKxDMAnDfNFGdVbj795W/3MAv0lxb/kuC8CidGLvL1qBUltLMkDVlcdMf38/hZ5W6tBKOjXB6rkmdVmG1iBf3V8+ryV4lGjJRkYWJdpy7q72/ZtFq3E6xMqLEC05KVQO1Zuog8JW5rjSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790497136; c=relaxed/simple;
	bh=tnuxZHiMDP7NlbhxQnE94F7KWiJbmmUqD0qtt4RN/nY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9hHYZgHUotkx/OUbfZj/l4gTX+bewxLSBX1mn17HJ8eeUGkyS9Wdqju9sZ7zIhwQIPmVwd63a/+fxqj/KulMLX1MxsCQaL1+hS2j7SGWAagfSCnpIcjm9cSikGqXbXAmxkuOJwnOExsDsCoGdimCK7ZF+38XaAuRokmLUCDi2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/sIZyTX; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/sIZyTX"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-344213c95bdso21125eec.2
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 01:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790497133; x=1791101933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d22dLlUUYyImrNJb1bwxtlpRx+qcfWK6QMtWMrfJRas=;
        b=C/sIZyTXbWFlry9svumX8/IQXAreIq4EgfkG0uoZCfgcN5cpjjdjhuE3LcV3LFiV4/
         dpvMkqD7iB2R8H6k2pBXteI1DhIMeAReDqJqEF8iq68dnIT1EwE865etPvGVKbhyiUtG
         GnlkKCiJQ0DWzZiIvmaOCV2Q6DgaQIiaqKgRjGtQv5HfipBC9fDD06YTgmFF1LmRTw/c
         mNYuui0eEkfRu0g80P1/b69KMTlaNhKKxF6Pny3CkCi/I0wlGhqCWeVZpPEocfUHXhKY
         yWUQ79ecVesBMynHk8Jq2e8grTwTu1VSvaI46V36kL17K/SucNE1qfrByvJ/NY1D/dKt
         Nglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790497133; x=1791101933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d22dLlUUYyImrNJb1bwxtlpRx+qcfWK6QMtWMrfJRas=;
        b=OwYm2jg0TD09aHo78zrXzQMAoVmJQIa0cy8bRDmyBx0db4KzDmg+/GOqf8K6/CiBTm
         8EhclYmEqjOVV99ZOr3Fi1rBbeF0jwDJ9Be8+pl+XBs4oGa8WTH7FpHWXvoaPjvwJCxU
         zLyKI+sz+oFoE9yaYMD+HSiwSB+XPFABJZfg+xdFbhIuz+MHaWTJV8GNa9pJIv31ca4G
         +O1+/ctC6q85aA1oCDdAuSjcP7yoiO4eWvZZowQovXLiRGPHwGBLNmKfuF1VnpbUHciQ
         E+Rwmj+nmlfzH/ZdWLL3XCfJYHgJx2CqNzvPzbboL73ZoyArOvDjb7UTa5o3eIvaG6g3
         kr+g==
X-Forwarded-Encrypted: i=1; AKwUvBx8P+0wp1LGjijv3c6rYN+hwSV5N7nS8l2T4ZpWUdRGoevMyqV/DviwB5tzz8z8Pf/xOhml7zs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKT2J+b4dUJyUSiwwnk8Eu9w8euIv1R/oGgPUFC4+khHy7GC3yM
	vr7MyAnGaFvH0liHEUiJlDlV7bxm1We/gCtmo28WzBpTaM0/AJ8fUSVq
X-Gm-Gg: AYBFou3KuDrNYaGiN/pgL+aLMGbqpiBzfPESz2x8lX+90KwcxzSiUVdNhW8F1zfnyUi
	ROHbjNGHCdlJxKtS35GeJ3Iff0WnTBeRjNoQPNSoinuoX89RgRIdeatMmCHSAR26ZWXg0CauSrn
	RJceQAukr2mqy2/3/RTgxyhU3k06FF31bnLa6DXhgBVHc5CpCBUeI/wBqLEaiH4KLX4RDjg+G1D
	We5c1zR4GVyAXyqT2DZQ9pZMpCsdfH2vLhjAbdM2ABKWbN5mJS59cLgiFrGhN0fIIcX2KSwGK7Z
	saPUUY+Fn7SlvkBb4LNV8mHkQ4f17Iz5cLAY2la9wR03Xj3kF1mZtFEZehMyaHMvF6i6OeBZrNj
	sNhWR9yQ1Pl6eh2mEMIMEBIhr28jef1EDn6Tccr9ydoVnSY0+i0n9W86E9UWi3Vfa/URLzwOuFb
	IxhhzV9D/PnzqghPV/Wps/WdNqkCWpgcs+jNRLUOMAxrkjjaLHIw9Z4dZzIGv30HhvhMLnQzalb
	0w8pRTtEMnvAlweLiuPml/Tk+jTsrFCLUaqIlDlxeoguyR1cFUR7bY1gtdI8LzF1ewhsMs3Ty19
	6REq
X-Received: by 2002:a05:7301:dd97:b0:33e:6a79:5a81 with SMTP id 5a478bee46e88-3427179721dmr7985570eec.1.1790497132522;
        Sun, 27 Sep 2026 01:18:52 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144172de6sm31192132eec.9.2026.09.27.01.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 01:18:51 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] rxrpc: Serialize client connection IDR updates
Date: Sun, 27 Sep 2026 16:18:45 +0800
Message-ID: <20260927081845.3696101-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Client connection allocation runs in the local endpoint's I/O thread,
but the final connection reference can be dropped by another thread.
Connection cleanup then calls rxrpc_put_client_connection_id() directly
or from a workqueue, without synchronizing with the I/O thread.

The I/O thread can be traversing or updating local->conn_ids in
idr_alloc_cyclic() while a cleanup worker calls idr_remove() on the same
IDR. The removal can change or retire a radix-tree node still being used
by the allocator. Concurrent removals are also possible. These
unsynchronized updates can corrupt the IDR and crash the kernel.

KCSAN reported:

  BUG: KCSAN: data-race in node_tag_clear / radix_tree_delete_item

  read (marked) to 0xffff9d03804b9fd0 of 8 bytes by task 109 on cpu 1:
   radix_tree_delete_item+0x132/0x160
   idr_remove+0x32/0x50
   rxrpc_put_client_connection_id+0x53/0xe0
   rxrpc_kill_client_conn+0x7d/0x190
   rxrpc_clean_up_connection+0x193/0x370
   rxrpc_put_connection+0x3d9/0x3e0
   rxrpc_destroy_call+0x192/0x2e0
   process_one_work+0x325/0x710
   worker_thread+0x31d/0x5c0

  write to 0xffff9d03804b9fd0 of 8 bytes by task 97 on cpu 0:
   node_tag_clear+0x7a/0x110
   radix_tree_iter_tag_clear+0x47/0x60
   idr_alloc_u32+0x13e/0x1a0
   idr_alloc_cyclic+0x7a/0xf0
   rxrpc_connect_client_calls+0x375/0xa40
   rxrpc_io_thread+0x79c/0xe20

Serialize allocation and removal with the IDR's existing lock. Both
paths run in process context and allocation already uses GFP_ATOMIC,
so no additional lock or allocation changes are needed. RCU-protected
lookups remain unchanged.

Fixes: 9d35d880e0e4 ("rxrpc: Move client call connection to the I/O thread")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/rxrpc/conn_client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 48519f0de185..93e08a13a236 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -45,7 +45,9 @@ static void rxrpc_activate_bundle(struct rxrpc_bundle *bundle)
 static void rxrpc_put_client_connection_id(struct rxrpc_local *local,
 					   struct rxrpc_connection *conn)
 {
+	idr_lock(&local->conn_ids);
 	idr_remove(&local->conn_ids, conn->proto.cid >> RXRPC_CIDSHIFT);
+	idr_unlock(&local->conn_ids);
 }
 
 /*
@@ -162,8 +164,10 @@ rxrpc_alloc_client_connection(struct rxrpc_bundle *bundle)
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
+	idr_lock(&local->conn_ids);
 	id = idr_alloc_cyclic(&local->conn_ids, conn, 1, 0x40000000,
 			      GFP_ATOMIC | __GFP_NOWARN);
+	idr_unlock(&local->conn_ids);
 	if (id < 0) {
 		kfree(conn);
 		return ERR_PTR(id);
-- 
2.43.0


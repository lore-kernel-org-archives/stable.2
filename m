Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385DA40587A
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574584; cv=none; b=d52c6x5jGjqpBcYmrdV2+iJv7piGgmotDTreKbdSsEVeqCak32FbUfFvFbY/iVAZFkvC1FddvQYuuEfI5P890BcFhrnFxbpYQqFoTKBvBUOdTPqHvhT4eBpqSn1nVAGscdEZNOVJ8BImIA8ZQfc9KRSoCxfZvSloVjxyPdB2SSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574584; c=relaxed/simple;
	bh=/p4Yl9cRrA/08EFs7XUHDyj23xIlq6ZPP0gzi9wHapg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxGqaIDdxYzPHlpbjIWcXXaMHjyNVzm/bW6hu07AHYbP2bmKUIjnkFksdS4cwFTYW20CERZ0CVaBPAAuLgBwc9mq4bGSCVinfGo9z/3Qw3B/qlDnisutDDBstry3iz5A8vBsgrwbvQKaUIbemllzgsMuVDmpAZzKt0zlZr4+Ub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USrDBV0b; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USrDBV0b"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-451fe9bf738so481973fac.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787574581; x=1788179381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=udVPUe6IPHcf7p6BJaM0xcgin13VVHNN5Zpwgn/hQ6I=;
        b=USrDBV0bKQZq9JYtrMP2fBafqLKGBeX/fy3asHPsvY+XBbwv3V0sRSF7QKlk0w2al7
         cFw5Vwd2IYBOPkmoYH7USfKgKZCXUrYkZh5cDr8FPdRI8jLgtYhCJjMVv0Ab7yBxQhF+
         TTZCTwi/oZlqCukP8q94ImTs0zoQrorFjrM9hBQSJIJqdUasGIg6ihcck4D3SYuV14p7
         /1L/PgWtRgOQpDdjccYU/3O8a7HMI0LDTM/nu1DxeUY29gmUzV7DhVZF/X3E+jv0Ytwr
         XiIX5vSx/WphTevs3Zrw307wYpgD0scVEuOagsdam7X3Ap4PTmyuWMP3C7kYmhhInOcf
         QcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574581; x=1788179381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=udVPUe6IPHcf7p6BJaM0xcgin13VVHNN5Zpwgn/hQ6I=;
        b=AFHYUEzfLUL918XnYXGJB9dAyZde2H7VvG44WDTEqbDRp9NQrysmGHEQ6lBDyhHX9a
         kILPA2Cp02ismKeqnoDwTu8KZWdw5OwIVlMJAdbz7VE+P7ZBTLob66isqrc4pCgw3tCU
         2E3T3Y7mKYLULdTiWRdsqZ5QYj6bsAPga+hZ/gY3yug8xbeepYpu6FXE0oCD2JsV3Zdd
         eSVywCBJ1rHLnmFr5wviTG+Ya+AabIfXxRu/jYNtraidnpAK9nV/baQIoHlfMjvQguhZ
         HA/ZtNTxNxEmyU1MDcTatzLilmTfE7ULesRMb3BaWM+BlXbh+HDPpE+YqEZ0WIOjWmjy
         Qh4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrX0QNcIWTdONtA4rmutNwFWMNsdw2Hf3nJ/WqoY68/XW/4cpz8S+/CifBk2O/QvMKt/LRF4+k=@vger.kernel.org
X-Gm-Message-State: AFuF++nu7l3ohK+nyH6e0mO1eZOTmFHsYi3CfYg0zjiwhQCkxZ3Wjjz2
	BUGNDtEDPAZoY6asR3wvHNFptbZNLCAZTfOebJ+YzA5N1KV1iPfqUHfX
X-Gm-Gg: AR+sD12ZH/ZMLjWT3cW5R+yALIYwkHUY+wQ8k5CuCcHrywoLQeOrXocpPvpHyrcgTRG
	zxhB2w6ujOAdHRinplCP9bjRLzjuIKnI/3GVNj6tp/eRHNmiZPTYlJX+C1en6AlPcvi8MfBEESZ
	ZOfJoNR44lMWAx/2UjWgo0uDVTaugoIGU5JzYYIQuAulLGYKvVOYDmx20/8IdvUYv36HpGGKW9f
	uzEsiltlUd2a31Ab2wNNUsxDbxENWwOQdfqoTSLjgGqulAjcoCEZj26AxyqTZ3ZfwxTsH0dODWO
	jpdUsTdltEVk9a/O7aY/rLflTUkeuSh7LeudgnE+zpHRMkDi+p3cUvbyO3JQN878IDvY9rnoGSS
	MS1RTuCjp2PwgeYC9XKchQHIO6zliVZ4g9RgXznMUDfiHbzqQ4JL8PLdU5ECsAwf4pUR/oDtlOi
	wPgMsNgB+HbC7QifugydTe2jr4C1u6NULGrvjhOis8jtK1/EfVAJBzXcGJMaAeiXUvVvQoXuNUK
	F/nhel3Fa4tWhHaJvlrorHy6ber/vxy/iLlq7DW/VHGHfWA6QNLv2Q2
X-Received: by 2002:a05:6820:341a:20b0:6a3:6bb0:e584 with SMTP id 006d021491bc7-6b1592c253cmr9992591eaf.1.1787574580793;
        Mon, 24 Aug 2026 05:29:40 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b17c832d31sm3598839eaf.5.2026.08.24.05.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:29:40 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Tuong Lien <tuong.t.lien@dektech.com.au>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH net v2] tipc: protect node reset trace dump with node lock
Date: Mon, 24 Aug 2026 20:29:29 +0800
Message-ID: <20260824122929.210431-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tipc_node_reset_links trace event asks tipc_node_dump() to walk the
node's link entries. Unlike the other node events that request link data,
this event runs without the node lock.

This permits bearer teardown to free a link while the trace callback is
dumping it:

  CPU 0                                CPU 1
  trace_tipc_node_reset_links()
    tipc_node_dump()
      l = n->links[0].link
                                       tipc_node_write_lock()
                                       kfree(l)
                                       n->links[0].link = NULL
                                       tipc_node_write_unlock()
      tipc_link_dump(l)

tipc_link_dump() then dereferences the stale pointer. KASAN reported:

  BUG: KASAN: slab-use-after-free in tipc_link_dump (net/tipc/link.c:2910)
  Read of size 4 by task poc/115
  Call Trace:
   tipc_link_dump+0x10cb/0x16b0
   tipc_node_dump+0x4bb/0x740
   trace_event_raw_event_tipc_node_class+0x258/0x360
   tipc_node_reset_links+0x14d/0x1a0
   tipc_rcv+0x13f5/0x3030
   tipc_udp_recv+0x4e3/0x670
  Allocated by task 0:
   tipc_link_create+0x1e1/0x1020
   tipc_node_check_dest+0x7d2/0x11a0
   tipc_disc_rcv+0xdbf/0x1430
  Freed by task 89:
   kfree+0x131/0x3c0
   tipc_node_link_down+0x267/0x4b0
   tipc_node_delete_links+0xec/0x160
   bearer_disable+0x107/0x260

Take the node write lock around the trace event. This serializes the
dump against tipc_node_link_down(delete=true), which frees the link
under the same write lock.

Do not take the lock inside tipc_node_dump() itself: several dump
callers, including tipc_node_link_down(), already hold the write lock.

Fixes: eb18a510b5cd ("tipc: add trace_events for tipc node")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
v1 -> v2:
- Use tipc_node_write_lock() instead of tipc_node_read_lock() so the
  dump is exclusive with link deletion.

 net/tipc/node.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 683a136e53ef..127848e8a644 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1333,7 +1333,9 @@ static void tipc_node_reset_links(struct tipc_node *n)
 
 	pr_warn("Resetting all links to %x\n", n->addr);
 
+	tipc_node_write_lock(n);
 	trace_tipc_node_reset_links(n, true, " ");
+	tipc_node_write_unlock(n);
 	for (i = 0; i < MAX_BEARERS; i++) {
 		tipc_node_link_down(n, i, false);
 	}
-- 
2.43.0

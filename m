Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.101.131.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605099;
	b=1g/GlX/Sm0ZPWiPMSG0JqwplfZ5+YgFoXEYLnG5PKAbwqdVWT2EBh3wt9kpZCaldWPV8
	 QnyfnTUxkks3d0uRcieBHYTo0ieguRzPmASafEWlY4DLb7/wkLU4nH3Hr6u/aQqw7dPbu
	 haBWVAGim+a+x+zna86GF37pnwdk/I7MYkNOt44zUFn1JR8YGS1E+scvazPRuE1z6JVXL
	 W9qh0Vyt7yzW77YkvGkO+J6gDMlA2MwEBbHx/kWflsxK2kBlx36xkgM9+9VQdIKsYFQd9
	 4EvmZdAIS205EqGld+qBIoRrWk+AFAtgrKCObR1B67djDkPxf6kGXnPymIDHuidAHVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605099;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cRR8J1W13AfUCmhazkn/JvGpLRIlKdVrG3B9ATPkqYw=;
	b=JkYmfCVtPVr0jexCAUH9pRmF+wxr8vkFl2VpNdvNeFcIMEgo7u6X/iTOj2dOKtmza5e1
	 +U7oFiAy3cViQ5vBbhUdJPoTqaeHnxUcCI+u6ESBo6aYNW8zvgXyIdIVBSHKFMBw60JTd
	 o2qGbwtQ+UhNXDiPz1uWmcqRtFjfDBFbXk2TZ0zxu+r4xkz08vk0Znxbq73vwTmjGydqZ
	 2HcRyYv48x8Oh/pQHXDPdQRnYCe0FJhnkw4ql1r0eEX/cMmAqLrUoCjLKBWEiFWwJuQcx
	 9LRIWNYLXtcE30MRUBxjnlK9D+LDsOPraGse3471zvhoyObP/lZyY7qFKn/Ga3MQxJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=citrix.com;
	spf=pass smtp.mailfrom=citrix.com;
	arc=none smtp.remote-ip=160.101.131.9
Received: from na1pdmzitismtp02.tibco.com (unknown [160.101.131.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241B9606A31E;
	Wed, 25 Nov 2026 11:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 241B9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Received: from mewpvdipd1070.citrite.net (unknown [10.113.40.46])
	by na1pdmzitismtp02.tibco.com (Postfix) with ESMTP id AC75D8513E86;
	Wed, 25 Nov 2026 06:09:52 -0500 (EST)
From: Mark Syms <mark.syms@citrix.com>
To: jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: hawk@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	bpf@vger.kernel.org,
	mark.syms@citrix.com,
	stable@vger.kernel.org
Subject: [PATCH net] xen-netfront: unwind created queues when page_pool creation fails
Date: Wed, 25 Nov 2026 11:11:29 +0000
Message-ID: <20261125111129.3109095-1-mark.syms@citrix.com>
X-Mailer: git-send-email 2.56.0
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

If xennet_create_page_pool() fails for any queue after the first,
xennet_create_queues() returns without undoing the queues it has
already set up, and talk_to_netback() then frees info->queues. The
NAPI instances of those queues stay on the netdev's napi_list,
pointing into the freed array, and their page pools, XDP rxq
registrations and grant references leak, as do the grant references
of the queue that failed. Reaching this needs an allocation failure
in page_pool_create() or the XDP rxq registration during connect or
resume.

Release the failing queue's grant references and unwind every queue
created before it inside xennet_create_queues(). talk_to_netback()
still frees the array; on this path neither
xennet_disconnect_backend() nor xennet_destroy_queues() sees the
queues, so nothing is released twice.

sashiko-bot found the bug while reviewing an unrelated netfront fix.

The patch builds without warnings at W=1 on net (gcc 12.4) and passes
checkpatch --strict. The failure path was not exercised: no fault
injection or boot test was run.

An AI coding assistant (Claude Code) was used to confirm the report,
write the fix and draft this changelog.

Link: https://lore.kernel.org/r/sashiko-outbox-232996@kernel.org
Fixes: 6c5aa6fc4def ("xen networking: add basic XDP support for xen-netfront")
Cc: stable@vger.kernel.org
Signed-off-by: Mark Syms <mark.syms@citrix.com>
---
 drivers/net/xen-netfront.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index fdcb91042f29..9abae76871f3 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -2244,8 +2244,9 @@ static int xennet_create_queues(struct netfront_info *info,
 		ret = xennet_create_page_pool(queue);
 		if (ret < 0) {
 			dev_err(&info->xbdev->dev, "can't allocate page pool\n");
-			*num_queues = i;
-			return ret;
+			gnttab_free_grant_references(queue->gref_tx_head);
+			gnttab_free_grant_references(queue->gref_rx_head);
+			goto err_unwind;
 		}
 
 		netif_napi_add(queue->info->netdev, &queue->napi, xennet_poll);
@@ -2260,6 +2261,21 @@ static int xennet_create_queues(struct netfront_info *info,
 		return -EINVAL;
 	}
 	return 0;
+
+err_unwind:
+	while (i--) {
+		struct netfront_queue *queue = &info->queues[i];
+
+		if (netif_running(info->netdev))
+			napi_disable(&queue->napi);
+		netif_napi_del(&queue->napi);
+		xdp_rxq_info_unreg(&queue->xdp_rxq);
+		page_pool_destroy(queue->page_pool);
+		gnttab_free_grant_references(queue->gref_tx_head);
+		gnttab_free_grant_references(queue->gref_rx_head);
+	}
+	*num_queues = 0;
+	return ret;
 }
 
 /* Common code used when first setting up, and when resuming. */
-- 
2.56.0


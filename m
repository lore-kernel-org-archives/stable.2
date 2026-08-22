Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95A22248AF
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787370625; cv=none; b=lWoYjRmVe9ieS/KAqbF7yfc1w61lee9hGJeyOihy3U1X4iBrv8LFqDrrkbeuQkGl/Pakujjf2TJbzdrEbQnpGWpMerrdokXG04MKwKzckgB1pPuN1igTm4Jwpc1LGBgcJa2/IMT7nJAAgLkiHXp+UnAc3kORnc8RbANOWCk+3CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787370625; c=relaxed/simple;
	bh=T2i9mOof3HpXds4ZHpc/Wv0uMvpPRYlp0zN/XQNR0Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCrlZ33SEY1vmTytUa68vNMdIfc1jP5Xjo+bfwogNHLKgeSiHujDUHqZx3zvAXsBITL6T05CJznN2wBMIzTPkjwmc4QWPb9xQR+oFj4CVmppXTYrddx6fzRrQJuH1fnDi8m62ZtL/SPDIQkwzdBpl813K6m91E858tR08lIlLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D36DUYJ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D36DUYJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF491F000E9;
	Sat, 22 Aug 2026 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787370624;
	bh=Q7eHsotbxSSVZIAYm5fbO2JkwQLOaDcvyA26PediPJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D36DUYJ3V29yGefcsyTLIm7DtZFTqhvRkSoxCtKrs6A9HGclAOE7OlFhoH1o4Ow7d
	 RMUwDaP3YtKFefnxkMDaDo5AQpqkKi46UnsZdmjER9lS8GnADtX0tRe2pVTyk1t/2M
	 eJpGcnKrNxUrD1Lqhjb8rQahyH3VgHSFiUS9GQ+oRoIwh28U6V6hqKwk7TLmt8/1Y6
	 E6og5tbs7HCnoP1bpvwrfu5G2T2wwYHI0MsPMiQuUM7TN1+w1Zvflz3YWs+m7Jceph
	 f26Gq2sLQkijdbJOenYqYbL/aUm2QWpYQ9+obULrjsyYiImeGEN9a1Cs1qjB6BgP7W
	 mYNw6skqqfaeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ren Wei <enjou1224z@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] inet: frags: publish queues before arming timer
Date: Fri, 21 Aug 2026 23:50:21 -0400
Message-ID: <20260822035021.1113240-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081751-obstruct-mystified-44d6@gregkh>
References: <2026081751-obstruct-mystified-44d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

[ Upstream commit 653d7ddf6cba867777a3d14c4f83ace008c5ad13 ]

inet_frag_create() arms the fragment queue timer before inserting the
queue into the fqdir rhashtable. If the namespace fragment timeout is
zero or negative, the timer can run before the queue is published.

The timer callback then marks the queue complete, tries to remove a node
that is not in the hash table yet, and drops the anticipated hash
reference. Creation can subsequently publish the completed queue without
restoring that reference, leaving a stale hash node after the caller drops
the remaining reference.

Publish the queue first and arm the timer while holding the queue lock.
This makes timer expiry wait until the queue is visible in the hash table,
so inet_frag_kill() can remove the node and balance the hash reference.

Fixes: 648700f76b03 ("inet: frags: use rhashtables for reassembly units")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
Link: https://patch.msgid.link/bf66785e7c0c139d7a1900e2f01faeeab344b960.1784948849.git.zhilinz@nebusec.ai
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_fragment.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 7e38170111999..7922b10f360ee 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -339,16 +339,18 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 		*prev = ERR_PTR(-ENOMEM);
 		return NULL;
 	}
-	mod_timer(&q->timer, jiffies + fqdir->timeout);
 
+	spin_lock_bh(&q->lock);
 	*prev = rhashtable_lookup_get_insert_key(&fqdir->rhashtable, &q->key,
 						 &q->node, f->rhash_params);
 	if (*prev) {
 		q->flags |= INET_FRAG_COMPLETE;
-		inet_frag_kill(q);
+		spin_unlock_bh(&q->lock);
 		inet_frag_destroy(q);
 		return NULL;
 	}
+	mod_timer(&q->timer, jiffies + fqdir->timeout);
+	spin_unlock_bh(&q->lock);
 	return q;
 }
 
-- 
2.53.0


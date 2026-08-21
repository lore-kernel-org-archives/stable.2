Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81797433054
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353880; cv=none; b=P6ocBx8uqND1FbmdbdH88PdmWIXd0W5iDAYV4nZGrYqAh/1s92YSFY+YTP/V5hDj/Rs3jfo1+GISiD1+VZqUUWf53u/n/5gNTjERHqW0qruwxEdHwxWdw8yXbSb6x66NpBkvESVddwjPR0dI0oHUj8cC6U1oqtutgPgT0rxMO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353880; c=relaxed/simple;
	bh=0YoGUHJt53txSCfLNZxO/qBLfy6n5wbG/uqyrmis09s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNdUuOJS5Mpa7bda5pPrTK5Dpi5Y/gpH9AmJ4fxzIdgkAru39IvhOEwOTpBS1uDSxfg9Nv0K2ayeG73XKWc0dm25LM+j5d29kQJNNlIeXZxLdoXD0DYjnYTuGjGwdGHhFX8rwdAMijrXL7jK2uPfpphTjsS5o8pjjWOqZzxom+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BImcIW7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BImcIW7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077001F00A3A;
	Fri, 21 Aug 2026 23:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787353876;
	bh=i2HizyISJIJCFeKWMiMI34O8r6MQGgiqMKeqv9NKdsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BImcIW7qq20ZK8wEfqcNmJlawLSFZr8vRD5TOC1NfOB30dA+ejigyYm/N9iC3EEG7
	 ONlsrffJINvRMcCZ1db9kYb2iOjcSeSiS9a6yOh0CShB3zrDrF/r1KwEAF/hEphmlY
	 98ycWjaipMWh9RUD9HnjDd695NKAOouQnanX512qGSq2yZzECcEAyfD/uE+tw4fi4t
	 I9j4/X0qDhJkgB5oyYCzU7nSejg5vcjfouDT35ZJ44qIk6Gp8A1TlgLApoVjckteLI
	 RdpgHD3MvpFTiD3JTPcGmxOUhAlsxWQfA67vFoLr5r9cb8mufhMVCZrT43QlLWGjYs
	 YRmRyi2mPxvvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ren Wei <enjou1224z@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] inet: frags: publish queues before arming timer
Date: Fri, 21 Aug 2026 19:11:14 -0400
Message-ID: <20260821231114.122739-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081750-caterer-unwound-67c4@gregkh>
References: <2026081750-caterer-unwound-67c4@gregkh>
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
index 834cdc57755f7..0cfad7ab9f96d 100644
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5332F764
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517825; cv=none; b=VGdCjcuHP3hBVXsfIDEgaEee9QaG0gvD6iuI7mTOKupsv59ufKczEyZnb9ggCxuxrxdWHQPJNUMFDj09/MAYqhqfs2d6/eZCnXocIFnhcq3qpQ1dzfCmKNyLLqP/14PO+97+5sHu1cJXjWlFMhUFfljcJ4eBe1LvIwkOsb7ntmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517825; c=relaxed/simple;
	bh=IFxHTewrvv2wXUK/3C9I4ScR1eevwOf1MyylrfydQhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soMjpr4YxQfn5fMtSULcAmkGirTizUqR9vTaksUmJPRqO1QCk61dr6VOEI1oEZ0vJntCt2Oktbo7BO99ehBEzuGkdGSClBvT37Iz0IFOaVz2PlFcLHdD2RhZuDgZlzsdC/iTfe3yNB41ZRRzLamQHyEvSchiwRhIpsGUMQc94AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIDRiM8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIDRiM8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7461F00A3E;
	Fri,  4 Sep 2026 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517824;
	bh=fAZ2Iar16N4BSFLEzDgSJdcktLMWAMjEDs69k2CzJ8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QIDRiM8/ya3QUPrN6LeuIcgTFCYSImtMb8TBd0z08oxa8HpDFRb6tDbK9Fmp1BigE
	 pJYF8Kp8vDFcjIfsd1kmChGMT25Ai36AqVEk9n3nNPHUo+ygE1f0ftJX+hjVUxnfyb
	 kr6dUG+pL6FkCSZrAWoR2NfOVRqgfyiDM0Zs100/TQB4N0EqgbdcBw19Z+dOrmsSg7
	 fEBvG/S4wrmuBSJ0GpSjAJSREY3TA35AOlrl0hLaEKwVsSJfv6LxlRDEHBTPWAsFof
	 Rxw8IXd2drn2j03PgdNXQhgs/CB4ejAlU/aOMO1yefRN4HV8E4P0eeI1rUkW4jrmjZ
	 MXgu7BmzRrXmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] slab: simplify init_kmem_cache_nodes() error handling
Date: Fri,  4 Sep 2026 06:30:19 -0400
Message-ID: <20260904103020.2502384-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904103020.2502384-1-sashal@kernel.org>
References: <2026090310-subtract-womanlike-c117@gregkh>
 <20260904103020.2502384-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlastimil Babka <vbabka@suse.cz>

[ Upstream commit 9d4e6ab865c48c70e684b176d3ee1574d092626f ]

We don't need to call free_kmem_cache_nodes() immediately when failing
to allocate a kmem_cache_node, because when we return 0,
do_kmem_cache_create() calls __kmem_cache_release() which also performs
free_kmem_cache_nodes().

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Stable-dep-of: 7e98f8563956 ("mm/slub: fix missing debugfs entries for caches created before sysfs init")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 42d75afaa7020..b5944af1ead34 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4339,10 +4339,8 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 		n = kmem_cache_alloc_node(kmem_cache_node,
 						GFP_KERNEL, node);
 
-		if (!n) {
-			free_kmem_cache_nodes(s);
+		if (!n)
 			return 0;
-		}
 
 		init_kmem_cache_node(n);
 		s->node[node] = n;
-- 
2.53.0


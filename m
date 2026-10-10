Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B0B381EB6
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791598183; cv=none; b=Z8AVVXoEAeqtuN9mOpQAeVJWAs0Jqd5lYdrjnmiQK3zg4vrOP0Hbi0CBDC7yTjzNNk+7vuRhd3SHqK6oPAz47q6LXbrzI/k68jMRr/vJlekRb3RLr7yCCmHL3mvjBQqmxA95/qCcDzzfCKUdsJG6Sxnm/btF6ejeEL32L42yqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791598183; c=relaxed/simple;
	bh=qAoyVKmozYbnipeQ7gMMeMMuDIzRloalTulxU8vQOLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pveBEGbUxIIy16dziKMHCIGz6vBC7Q+ougLgkc7K4qHF5qYEHavlPsD3Tfhh4SmYPHEwhs+gs7SAUi0zFZMscOvFeOwYQgRfwHsdWrILQ2pqFZhqaii2KRsREn8IMGyPSuKdCrR1hXLRi705P9bER9Fb3A9MarpT6IX404g/VJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=P/VXBOdn; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="P/VXBOdn"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-8258ac98bc2so311142a34.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 19:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791598179; x=1792202979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uD8coseHJ8cbO2psrmuf1ZffJ2GQja8vTBxGB69y3bI=;
        b=P/VXBOdnt5vLk0UIp111asvAatZ2kJ7Y5E9xow4P4YnN4EvnzldxzhJoGWYK+IIO+L
         7MoaOoV4rjBVxhCsARuLVtP6YLTJ0CG+dskwKmHU5vkb2t/Jsx/KVXxYHLVlmKlw16+F
         XotDdezamgdRB9Y1tXQ/Gb32PH2TywPT7w4D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791598179; x=1792202979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uD8coseHJ8cbO2psrmuf1ZffJ2GQja8vTBxGB69y3bI=;
        b=AksElzTfndXdut45DeWE/n+exMJ56aB/pSxA14vSkEkj7vzIIJ8im9/x1qhabWHFiA
         C0aLu/I7cSKAMlqbjeVGhU9Ur8hvla+P50oNTm8O331Ext313EqnZSZuxBJCwkM3Xq6j
         QxliT1JHS79ZAaSyDQ/pK1lbTYSbwwj6S0JUpXFC5RFkeFOs2FfCwCkJgWZYARfhJY/m
         u7bYJprmMj2nzIbSO7JBxK9uuP1IzphRnLvVHlSZe8YsH9J7yGDlrjs1odr00McsOxn4
         rkMN23udqeJWHeHBG0JaYPmhvi1hubCJ2ekGkq/ilwNdFyP/7SirbbHJ24P8zHi0XKtW
         MHKA==
X-Forwarded-Encrypted: i=1; AKwUvBz3aMKfWi5WZwuuQPMAtjJRSBuTCsoCTK2Idgz2gY7GtcvIUNVsp8BDmgTGygbiyM9IRBZqVa4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6bAdOeO5CTkP3qBSDh9QLMicDKioUWddOOrIHT58vzVo48PUw
	xsxDWNFdVlEHhu0qs89NIJvg+G35YBXwHJIfskJ0Iai4jo5GaxpUFC+HEvAUAjidCHA=
X-Gm-Gg: AYBFou3+RszBg5gfyGrQzyXgRuAi1OvJXoVEQU3mOXErasx3lYntkfQ8bf5EntyZrdJ
	1oTjddLpQpvztPH1pFBMHu7aenOlY9+sh07yD4tnImtBFbSNDijcJjhk8YCZyFi/E8UfiOV3Zxz
	qNu4fuYHZ+rorUW3EB51zireUFu9qi4UZnQISsmLu8hsXCAN3TAh3QArd8O5jEhzQ+IVhG2ZYS2
	CZcrGoKACfidubJh5MQ5GYNDyz8hihX5WQkqb2N8yAe23oJw/LrAq4PFou5CgnrYFoLPm0k8NJU
	Vfr99StylaTHJ8a/pf5D/MhQwcSjBQPfRMGgdKQMnB2DhIp+AtN1xt2uUJxwgcFE3XYgoX+RHky
	9S6x1JYWS/QOBZ5uRF7Rl9akE0St1TYjEoR0Qo8xv0mLTC9ECXI7BAixNCBR4WvO3Id3YBmFG3Z
	RGUYJA+MCqaafcduaB9CLMbS2oy+0zGzC+Ssyws6nTJHa9Gc7kMYvOR3B/J+mN/SBxrKCTGlFWy
	cmvW0enLgLrWzHBGMuJ/OnpVM8JQhPn6FgfI/uX07Ee0E/Gd4PSzB4BXXE/PglBXyZdMq89QkE=
X-Received: by 2002:a05:6830:6816:b0:806:1e7:4167 with SMTP id 46e09a7af769-83095843911mr3366701a34.13.1791598179659;
        Fri, 09 Oct 2026 19:09:39 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm3580257a34.25.2026.10.09.19.09.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 19:09:39 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] xarray: initialize the offset of new root nodes
Date: Fri,  9 Oct 2026 19:09:34 -0700
Message-ID: <20261010020933.83051-2-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xas_alloc() only initializes node->offset when the node has a parent.
The shared radix-tree node cache clears slots and marks on reuse, but
leaves the old offset intact.  A new root can therefore retain the
nonzero offset of a former child.

Lockless iterators read a node's offset before loading its parent.
If xas_expand() grows the tree between those reads, the iterator can
combine the stale offset with the newly published parent and descend
into the wrong subtree while retaining the original xa_index.  Even
xas_reload() can accept the resulting entry when the offsets within
the two subtrees coincide.  Page-cache callers rely on that check to
validate the folio they found.

Initialize every new root's offset to zero before publishing it.  The
offset sampled by a reader will then still be correct if the root is
made a child by expansion.  Non-root nodes retain their existing
initialization, and shrinking only promotes a child from slot zero.
This fixes the forward, reverse and marked walkers at their common
source, without changing the iterator or page-cache APIs.

Fixes: 58d6ea3085f2 ("xarray: Add XArray unconditional store operations")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 lib/xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index bfe7bef80f34..509d7e4157bd 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -382,8 +382,8 @@ static void *xas_alloc(struct xa_state *xas, unsigned int shift)
 		}
 	}
 
+	node->offset = parent ? xas->xa_offset : 0;
 	if (parent) {
-		node->offset = xas->xa_offset;
 		parent->count++;
 		XA_NODE_BUG_ON(node, parent->count > XA_CHUNK_SIZE);
 		xas_update(xas, parent);

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA8339708
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411425; cv=none; b=aZBaiTsK4fdgBYhUh4iqJIJJV/Wd3nXiDg2oKRRKYXOAVTic7dNIKvDh/tTBm1pGe1QEiQQt2JJimTfloUWvKzIyvFvjhLObQeH8Z17eSfOF+2o8FMfX4/1aqEdTfTbFkIAaKVyiIJfHWoVhBrboocSKeDi4/9qR0BieN+nN6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411425; c=relaxed/simple;
	bh=jbVBFqzA+iF155IuKg9SVZ+u2WF0Eh8YwLiboVBeKWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoMpNvIvL9VHaVysP90cZkg0UJHny9NHodZvHmBwldTFImbOFrWVCUdred4+d1uhVWFUfCIe9V+EriLE5ravOuJHT0yU+3Ms2DC/EAcQLrB3sWYuih99UZgKv97D2XUEX099+wWPWNgWe8dvtM6V3oKLqLR/dzrtXezrbf6XUrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT5PA2JB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT5PA2JB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4DC1F000E9;
	Sat, 18 Jul 2026 21:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784411423;
	bh=bhC/M6rk+GWHNUx/sohRc5oXqAaG+2qWARRpt4QRK6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JT5PA2JBf19Rs7atC9tXJqXUi44Y9VX3SEINQG2bcSUk5+deaFXwEpbXS7mlQDGkX
	 NltqcaTxT1p4iLU7cZTIa0BqQ46bm5feJRkqrnufW9bqT8fBms5bwyFDPBzEB5Gosc
	 SW3Etf4ZIHDKppqP3izMLwLHv0rTRyrM/jRSwJZRnp5x0I+EAkZpyZ1rs7Jejr2+66
	 tILShJPe/3JK4PpGZ2wy/qLceKln9YYgiNz45dX6wgAFZXDxExB1J0VtjxM8JqJ8yd
	 sRl48O03CKkoa+hwZiFk6mGQZDRJJTBN+Vd7YmQwFV62lVDmfm0MRa6+4mXlo8T2J6
	 irSL6VjivM5aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] bpf: Convert lpm_trie.c to rqspinlock
Date: Sat, 18 Jul 2026 17:50:19 -0400
Message-ID: <20260718215021.3447372-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071451-collision-embolism-f766@gregkh>
References: <2026071451-collision-embolism-f766@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit 47979314c0fe245ed54306e2f91b3f819c7c0f9f ]

Convert all LPM trie usage of raw_spinlock to rqspinlock.

Note that rcu_dereference_protected in trie_delete_elem is switched over
to plain rcu_dereference, the RCU read lock should be held from BPF
program side or eBPF syscall path, and the trie->lock is just acquired
before the dereference. It is not clear the reason the protected variant
was used from the commit history, but the above reasoning makes sense so
switch over.

Closes: https://lore.kernel.org/lkml/000000000000adb08b061413919e@google.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20250316040541.108729-22-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 2f884d371faf ("bpf: Allow LPM map access from sleepable BPF programs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/lpm_trie.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 37669d69886640..cdfa10b0c56b78 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -349,8 +349,7 @@ static int trie_update_elem(struct bpf_map *map,
 	 */
 	slot = &trie->root;
 
-	while ((node = rcu_dereference_protected(*slot,
-					lockdep_is_held(&trie->lock)))) {
+	while ((node = rcu_dereference(*slot))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
@@ -475,8 +474,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 	trim = &trie->root;
 	trim2 = trim;
 	parent = NULL;
-	while ((node = rcu_dereference_protected(
-		       *trim, lockdep_is_held(&trie->lock)))) {
+	while ((node = rcu_dereference(*trim))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
-- 
2.53.0


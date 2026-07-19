Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEEA5FDA7
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784465014; cv=none; b=X78esYbKh7arMDWtQRJjqRQRs7kMBC7ajRy+4FRixJFKP1QI9i0Kk0bjyVTf3gHhuRNUZjY9Pl4cifh47PoPSVsB7BVwt6wL4OpTlfiVIgNsc+c6j5FCPNJWCVrAVuzhXMSzDvIig230tQdtoT8BSN2v3/KXifzeBClNlY5//YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784465014; c=relaxed/simple;
	bh=jbVBFqzA+iF155IuKg9SVZ+u2WF0Eh8YwLiboVBeKWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qazV553at1N1P43fuiBvv7iPNygFD84KBxWWrcVqRWf6gVBLspW8sywcJEzePXFB8rOeTMuD9qOmvBBKXfFVh1Bs5veVT3wFI/CGjyx3QXiMvuHvu11RGu1H4LyRBy19u18FEA+bwpphy9n9ftcemtzv9FTuj8YF4AYJXYEMkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epqDnjp2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epqDnjp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288921F000E9;
	Sun, 19 Jul 2026 12:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784465012;
	bh=bhC/M6rk+GWHNUx/sohRc5oXqAaG+2qWARRpt4QRK6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=epqDnjp2ZU8rOBY09TUoLcAiWIN2Lzb+xzOkodoc1KLohldznNJpdSffZgQx7OZhg
	 JWU8wSExYj639BxIj8xG0QTCodlxE73oLbnV7Z7HTlhewz/YCuc9jea/RHQIEWWXE2
	 4dw9Y8g9CSVRBOhlmxpfCV57UQNgyetJnjuPYA4Gn2uDOYpoUalTYWg/NUZb2fr/m1
	 pXO35XK/7acy357nmzRyorZMfnSfw0hYFdusRUyMHv4Wbrra9NH/Jz0ZZbnewUNscC
	 6kI1ZW1nJ8EWXdIQwJS0csNnbZgqdtFmLG8oVTvJzvgyMD9M8LL/4ESn4xigr3A8mT
	 vApT17zG0aQeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] bpf: Convert lpm_trie.c to rqspinlock
Date: Sun, 19 Jul 2026 08:43:28 -0400
Message-ID: <20260719124330.3645834-1-sashal@kernel.org>
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


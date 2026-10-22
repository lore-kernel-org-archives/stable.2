Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680560;
	b=SXK9Mjp3x3hS9+wn1OqS9iTusnv20mxslYZ32JOi/GGRFChHfT7GOikjoZqlxSTzUr4v
	 UaWjJfeXdGIxdxAS0XMVEithcUhkwgn8jT3UG9vZkZtyxYhsvlmOGr1IbqRgke3TsLokr
	 VoIYu+13MsbtvAv/FBlwVkjwOjhAAx3Yr2pHKH/khISlU+aKw3LY3r96NkEA/L0Fscrkb
	 3wQ5JbcoXHhHzKYo+rq8gE1TXqzbu6oNGnGNRwNsLcBhf6eEbFNgfF5mk+0D5GHpwBJzP
	 LBHpLdCLByymOyV70yJIt75+w7Ow8QS6RlP7trCVV/KfWnZqmPqLKZIcGnIL/dlnNcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=a2e1+s/dkUyzgp4aM3yqleUClBWwjYKBUO/fowk/ZYg=;
	b=NmF1/qQxNdJmCpzXg4zRQ5DLkeo/Oc8BUz8PYFZbERRUfqcizpnZA2lbIyKkFFwgj5h9
	 0BPHmHYMKas78nWqxyf0YI34mySSneXFkmv2fJYUU0IWBxZs6BMNwVaPSmNXQQjtK4Wj0
	 MGVANNK3gb4nPozkZoYtjYnTxzREs2RCaY3Px/+osPfO+h3BFwyhNgaPodpYmjn946Bws
	 1KJZBPmx5wzjxIUCmMn2WSjQDA8J8AklG2pcmnXJ22WCIsOSTXfW28S+ESuvtHURAj1rl
	 4uf9dwD6T7j5FaKERyYq+FWhqry8D6vgVFFm7wud0r24xVm6q11Sqcu7DTYzEr+iaNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JK+hF4M4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1E60A261D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JK+hF4M4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20881F000C1;
	Thu, 22 Oct 2026 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792680559;
	bh=a2e1+s/dkUyzgp4aM3yqleUClBWwjYKBUO/fowk/ZYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JK+hF4M4wH3UhteYKhWhdJWzE8u7ycD46W7iIXhml/VUxn7ESkbdrlCRf2vZqyJsW
	 U8f34JYqwA45hA1EUn6qschMTEH/lmrPbLmSatss79pjThTKjAPayEk6eOq4vyfOZc
	 VxmCs18e5dr67F67b88Jyr9D/WBNWvhGMqOjKugjIvxEtgCN1yZ4/NKli+tt9u8gLA
	 Ata/scQBfWY9GZ5gtcMRu3H8lfrkJsPBDHqFrPNUa8a4r9l2+mgyKywI0+0Fra2fpW
	 1SFJwk3sbVEx0j9XPHW0holn9LM2jbpm0kGediFObaVULbmWwVSh47Cj778NeTHNe9
	 KbVY73NUbNxGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ben Cressey <ben@cressey.dev>,
	"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] dm-integrity: fix infinite loop on discard with large tag size
Date: Thu, 22 Oct 2026 10:49:17 -0400
Message-ID: <20261022144856.1605379-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102106-constable-postage-e400@gregkh>
References: <2026102106-constable-postage-e400@gregkh>
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

From: Ben Cressey <ben@cressey.dev>

[ Upstream commit 18d80c77b4c7dd20699e81cedfbbff4e9d198f28 ]

When integrity_metadata handles a discard, it fills a buffer with
DISCARD_FILLER and writes it over the tags, max_blocks blocks at a
time. If the kmalloc fails, the buffer is the on-stack array
checksums_onstack and max_size is set to HASH_MAX_DIGESTSIZE. So if the
tag size is larger than HASH_MAX_DIGESTSIZE, max_blocks is zero, bi_size
is never decremented and the loop never terminates.

Fix this by using sizeof(checksums_onstack) as max_size. The array has
MAX_TAG_SIZE bytes since commit b93b6643e9b5 ("dm integrity: fix a
crash with unusually large tag size"), so max_blocks is at least 1.

Fixes: 84597a44a9d8 ("dm integrity: add optional discard support")
Cc: stable@vger.kernel.org
Reviewed-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Signed-off-by: Ben Cressey <ben@cressey.dev>
Assisted-by: Claude:unspecified
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ sashal: Adjusted context for the max_blocks calculation without extra_space. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index f552c402b3c17..7988a2da6f048 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1830,7 +1830,7 @@ static void integrity_metadata(struct work_struct *w)
 
 		if (unlikely(dio->op == REQ_OP_DISCARD)) {
 			unsigned int bi_size = dio->bio_details.bi_iter.bi_size;
-			unsigned int max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : HASH_MAX_DIGESTSIZE;
+			unsigned int max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : sizeof(checksums_onstack);
 			unsigned int max_blocks = max_size / ic->tag_size;
 
 			memset(checksums, DISCARD_FILLER, max_size);
-- 
2.53.0


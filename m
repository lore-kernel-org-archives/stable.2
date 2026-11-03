Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730727;
	b=hyXX8U13zsU42Q4yKj6JGV/v9L3/ZFZsvN2KgVdnew9AV5q33ycUy5Z1IXIMLFZUw/HT
	 PI8bgV8M4BFkTajLrepu/dzjSinAO1sLoJpVAJqkvMBSQT4LDCOEwzDJwD8HAx1Nj5CTt
	 +su0JXvOetlgU5GH6h6jineNuRGJMWwIAHJ0LsP702c1kLuiN/1fhpBYoF4PCpgidVfE6
	 apy7yhNyfXZo+hSSj9OC8iP9+M0k2yOSBdnhq35BnZ9TpLY9ZzVg9DQvi4yeGe31gHwLL
	 xAtotgbxtZVuxe7xYmaye2u44MsdS3ZIy3rYsckNlo1o1UVpveedvrA9byxt2UnSgfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730727;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4lPgWCWw5afVEOKQYPDlfBM+bkXafIhu1shhrvFW/Os=;
	b=Uqq1Nv4KQG85ZxiKSK/FMSko+IOPFQyGg3NOTbuc+KkEdgQmz7YIHDxjjF1wmDZiCr4Z
	 fiHBzxP0V8yGHeeEm5nJpRLEesmKjLetVjobuK42rKG6RMa3AuiPRPpHHWQGQkN68HdZr
	 YHiJM9ASWgB4WKxAciOpsdmmYATfwGtH5/j9kJO3QdVnDWBNQJ2GjNUZY1oCi0ZDSycAS
	 kHkUhBMeugzjFfuef/HkOLi+S9uI8h4edlP4tfAIEWfYKoZGp+LaMZrxPeQ/KP0VVGdY6
	 mH+muUJhUl23q/I6w2ZMNE4x4SWUaPI60pOn4vZ3J/j3JE/Plk9XEbg56e69yu/5znQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgpkTNhB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3EF606A33B;
	Tue,  3 Nov 2026 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgpkTNhB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF9E1F00919;
	Tue,  3 Nov 2026 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730727;
	bh=4lPgWCWw5afVEOKQYPDlfBM+bkXafIhu1shhrvFW/Os=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kgpkTNhB7yGXCkKUs4H6jKAD5UBj78pCC/2XF6BjFOZtt8aJaQWLro4WgITERqSea
	 TyXcWQBG9mkCON+8iBxqKY9eT2aC+PNu7PnRil3Ljfx3NwEGZrFqcf56Bzc9n0pyI8
	 v4Y0SjZehNNiK3xlxdxo0YHVxys5EjJBXrmdfcQAr23ZIQ8pQ531kP3SVCl9KoBbMO
	 P8kvxNuIkzUvuWxfWt6Ta6CNaCdwIvms1azZVe5UPBop0UMUDr6nrkSCxZw7yZIxSL
	 lPymmtDYnrpakY2TcJiXxR0DMSdHKaJaUGCkqSm8d8Rny/vcmB9mGVPp+GD3fYD7n4
	 fJBY0Ak91Usug==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 03 Nov 2026 19:31:44 +0100
Subject: [PATCH 1/2] mm/memfd: handle GUP pins more reliably when
 write-sealing
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-fixes_core_2-v1-1-f332954f1df4@kernel.org>
References: <20261103-fixes_core_2-v1-0-f332954f1df4@kernel.org>
In-Reply-To: <20261103-fixes_core_2-v1-0-f332954f1df4@kernel.org>
To: Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Rheinsberg <david@readahead.eu>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=david@kernel.org;
 h=from:subject:message-id; bh=Wy87zWgjvDFa6nQn3gznSv/cs+suxS5XMGobWeCkKH4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJeacxay2Tq/jbvx5a4SpXu5FvTM5f3zpp0mGf3tISf8
 8orotOZO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZiIjC4jw35n6f1q96ULl63I
 5P10sEks7a+G2Pf/s6X9mafcXTDzji0jw6Ps/xadM04YR4VOShN4+fWJYTFnrmRs52SRBKPbM+4
 /5wIA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

memfd_wait_for_pins() detects GUP references by comparing a folio's
actual refcount with its expected refcount. As spelled out by
folio_expected_ref_count(), obtaining the expected refcount when there
can be concurrent folio (un)mapping is racy.

So it is possible that a changing folio mapcount can race with our
check for GUP references, and F_SEAL_WRITE might succeed even if there
are some, allowing file contents to be modified after sealing.

For folios with a reliable pincount, detect FOLL_PIN references using
folio_maybe_dma_pinned() before falling back to the refcount comparison.
For small folios without that, the 1024 pinning BIAS makes it very hard
(although not impossible) to misguide the refcount comparison.

This improves FOLL_PIN detection for folios with a pincount. Handling
FOLL_GET and small folios requires a more fundamental change.

Fortunately, most interfaces that allow for GUP'ing such pages use
FOLL_PIN, in particular interfaces using FOLL_LONGTERM. However, we
still have some FOLL_GET leftovers ...

Fixes: 05f65b5c7090 ("shm: wait for pins to be released when sealing")
Cc: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memfd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index 0f6fff004f5e4..9eda4c3eeaca5 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -32,6 +32,13 @@
 
 static bool memfd_folio_has_extra_refs(struct folio *folio)
 {
+	/*
+	 * Use the precise pincount where available to avoid racy refcount
+	 * comparisons.
+	 */
+	if (folio_has_pincount(folio) && folio_maybe_dma_pinned(folio))
+		return true;
+
 	return folio_ref_count(folio) != folio_expected_ref_count(folio);
 }
 

-- 
2.43.0


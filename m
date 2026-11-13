Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604325;
	b=ODOlc/p6rQIqTAipEvoIxrxiioX/iTjYuWuSECQlCcX9TcLAJ96MwPBW72RDXTQIOFea
	 5O9aheyQAh5f+P3caqbKkw0O4oWV+ogWIUbhorrVkL6YMxNSrWuIq7g5J9j593QHBTrzG
	 Z2L/6bnmuzxh9sUGMhf+xl22G6EqaCLnDvZqORuEkblKsJU1uO7e6Hd2uz9rtyrdF4M9Y
	 Kk+b+j+eVM7HqMpczCboa67bDz8ZwzbYZpxeJxHOQyfJ1Uv0bG2XBxuAyKawvURZQR7RX
	 P3gilVsZMeJpSH4aVVjONbte0/Nbgjk0wZfcBChEq+nbh2qag88GAvfyAJ9PfeqV+ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604325;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cXDOIn242QIl6wzrsbYJQJAoMBhg39PiN1wDozSEvjk=;
	b=vTNdYYvykv5w/8ooE/vjAhnu26kaQo1SB+E1HakoLyW39DvorCT3HOs8q5PRuFWmQsI+
	 kHW81ERdZuw0G0fheQGRRZIGp2OiAEON69dNFtDe/hLkh+xdz06yfaESbZp8BXq7izTBU
	 uR0YFOB1qjYR8ttt06Jkozka5weVZWgX282dUgJmDZkXvKtBwIcf54wFdNru02rKYwHbS
	 eb3gu0HwwCqt3ajvrMsSdGKuppEoNV+BrIGqiWu9liP830rI4awrfDMSmowo7rl0yE3+G
	 L8xkC19FVQY90Gx5KgCUPZsfF8jeFcI1HvFjOZMYEgcACLE8CztkCCUE2BGRdqJ7Q/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bml3Gchr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA0606A33F
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bml3Gchr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BED1F000C4;
	Fri, 13 Nov 2026 21:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604325;
	bh=cXDOIn242QIl6wzrsbYJQJAoMBhg39PiN1wDozSEvjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bml3GchrWwrrBplnySzWTgaKeynqWIBlcAZ0/6jjJC6oI9fuA0IuQRF9G0I6MFj5/
	 D+ErQ8wRY3zBgpV0ylacxUuoMP+UDWG0NeXs0ENWQCZ8dEl1FF/RrbjXLIUMOpF5Jy
	 1jn89ntm79cvJdIaE7OKBF8mK5PC9MPAmrw1vfgfL+jRGzFIPsPdyZDqTH3Vj7b9Lp
	 /zsYar/siFaVMWWdlgBFYeHI99tCP9JbiTWEsrYj5s3HzhRTYAEJYKpESVf7ZBZwo9
	 tBSWM9pxGIXQci0Wdah7IHutKOLMZQOKcQl9cAebIhjJ+whcSxJn3coA9fKTZ5/9lY
	 tbMg77uMOnoug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Dev Jain <dev.jain@arm.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs
Date: Fri, 13 Nov 2026 16:12:02 -0500
Message-ID: <20261113211143.2634958-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202333-failed-5.15-b4417d08034a@kernel.org>
References: <20261109202333-failed-5.15-b4417d08034a@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit b4417d08034a7b4a3083e0e2d95429d4542524f2 ]

move_huge_pud() reads the old PUD and clears it in separate operations.
Hardware accessed or dirty updates between those operations can be lost
when the saved entry is installed at the new address.

The raw pud_clear() also bypasses page_table_check_pud_clear(), while
set_pud_at() accounts for the destination mapping. This leaves the
checker counts unbalanced for mappings tracked by page table checking.

To fix it, simply use pudp_huge_get_and_clear().

Fixes: 7d846db7d0e2 ("mm/mremap: convert huge PUD move to separate helper")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-30-d6437171ecc3@kernel.org
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Replaced pmc->old_addr with the existing old_addr argument in pudp_huge_get_and_clear(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 5d8b8309ae2ac..e29007fce5bf8 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -361,8 +361,7 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 
 	/* Clear the pud */
-	pud = *old_pud;
-	pud_clear(old_pud);
+	pud = pudp_huge_get_and_clear(mm, old_addr, old_pud);
 
 	VM_BUG_ON(!pud_none(*new_pud));
 
-- 
2.53.0


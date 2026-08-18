Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1B3890E3;
	Tue, 18 Aug 2026 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043927; cv=none; b=EzygWkMyaKAA7JFRuunNFJfbPCWuouf3dUwh4kUaf+0LsA2Cn9gskXONgwXdV6npnW42Prs9LdCyxOOEII82AHebvFgO1HkRHcWSCRtvgOqSHqXEYevrmvR/mB/acVJnLltAql0xArkWft5tEorljdYtTJte0iUsnTMFZ8PIdXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043927; c=relaxed/simple;
	bh=ArDP+xPYo7L5LAYvlcf9r4ybgRs7cFmSGQ6qSx53NAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IhzblMKyb2Jjf160D7EPxweyEJV5TP0DFjhygWxkAbf7ZZwDyg0nTI1TlUipZnuCuCxqKItOIuHQoaelLDyzfW0DSx8Kejo8Nmu9DVQ+kxTxredCAODM5apjXCRLl2kaDklno4UMNEvgj2PsVskU5ZNdZy5QK81LMSgaFErYEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=tF8nDEJA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="tF8nDEJA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=WrGJ0Uzan2ImOgGQ7YbCggxDQmGPpBly/qZdeZQEPEA=; b=tF8nDEJAH/tN1K5TjYvoLFMr1T
	P2nnwgywH71lmQPJ6nXvavL1Xg87U+19sM8AGEAyVRNlXM/L1Pwv94w2+d9U9wgOOnTElJw+uz8mx
	GQ8SaNKxTW3oo4OF8QaYq82rbl6QTUrpqk9Wxk5JDUxkYkuUTgySdfpHOMer6llD2wnnCbOTUfSqu
	M8o8XIcqb+Y7bG5h4bAObhaKFL0MKG++oF2tds+sS3EQeZxc6kGT0JDrxj0pBuKTEmNXy7RW6pB17
	MHajD6M1+8s8gAYkgySj/1rUTGUBAZ617kqC4KZOCf9yQ7QKmzr+JqXu9y10uuBl1U0oCuHu7B/DH
	OZYNXayg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wwFkh-008tsS-2x;
	Tue, 18 Aug 2026 09:05:00 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 18 Aug 2026 02:03:40 -0700
Subject: [PATCH] mm, swap: ratelimit bad swap entry reports
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-swap_part_one-v1-1-a4fc58119fc0@debian.org>
X-B4-Tracking: v=1; b=H4sIAOwfhGoC/x3MUQqAIBAFwKss7ztBg8K8SkRIrbU/JhoVSHcPm
 gNMReEsXOCoIvMlRY4IR6YhLLuPGytZ4QitbnttjVXl9mlOPp/zEVkZv+rAfWf1wGgIKXOQ5//
 G6X0/C6NS318AAAA=
X-Change-ID: 20260818-swap_part_one-1ad0fe65809e
To: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
 David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
 Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=leitao@debian.org;
 h=from:subject:message-id; bh=ArDP+xPYo7L5LAYvlcf9r4ybgRs7cFmSGQ6qSx53NAc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqhCA3s9yhmIJelTJ+LbL97xgDf/DG4nsncIyY/
 q8Ez43ZtbSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaoQgNwAKCRA1o5Of/Hh3
 bVHkD/wPyu0OuSilyXkZ9gP8CY90hf2yoZqTHyBIbB7U6XHUZVkK7NA6XXsqX78Ut6ANTYReAs4
 fSq3DBrrwBaJ44JxHfcoy2XMZ4bQw5sq8l53DuHuTgT5vMytpX2nbWHBwNqGk8V7w1wmMKyQPUR
 +Rm2XfzESaU2F621Ckqu/GiElwfb0uuDsjAVRwdXHLTyUCWjrQKC5bVgs2nL6MgMBJZIJJJepMV
 GhXbiWOOkDn8wDs1SF4NadPhP5xmkxbCp1rsXso8nMKfbQYMBNJHlMg9VY2hYFnSRcBwGcJRTCj
 LNNBZ2TyhJm6YXidk+UibhjIpw3e+fQWeViL8+Z+bAUMiFzhgNxP6jlEtZzfvpfvyh76uUTniS3
 jshFN3XhO9KN8gcjZd9pGu99u6T29aOdJTdwgMN8zMlGlX/+cmCo4AjGAtADaovGh4inuCf6E6W
 uds+y5D9iy3fftgSZ8TJjCYZC2c9hEfASKNVQzu5hD7sU1qWxbJ0qwPXmE0S51PbnMMj/AsoWiS
 DPWetHpXchHyGGBGLHxlUo7fJJTEzuuK0/dquhAuYB2UFRqJvRsVME14tC1qH8q/EnUCupq0fBa
 lleFSjsddMfJDesAKCwUDzkzO/N9RrD02ldBjLCWxaLHcCsrRF36SlQmkA95s8HfguvRERzeBcB
 6kwyk46pb8bl7Rw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

A corrupt page table hands the same bogus entry to get_swap_device() on
every access to the mapping, and every rejection is logged. One machine
logged 6185620 copies of the same line in a few hours.

swap_dup_entry_direct() prints the same message from the fork path, once
per call: the WARN_ON_ONCE() guarding it warns once, the pr_err() inside
does not.

Rate limit all three prints.

Cc: stable@vger.kernel.org
Fixes: 23b230ba8ac3 ("mm/swap: print bad swap offset entry in get_swap_device")
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/swapfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index dacef34a3ed7a..53bf01d5f7f11 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1899,11 +1899,11 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 
 	return si;
 bad_nofile:
-	pr_err("%s: %s%08lx\n", __func__, Bad_file, entry.val);
+	pr_err_ratelimited("%s: %s%08lx\n", __func__, Bad_file, entry.val);
 out:
 	return NULL;
 put_out:
-	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
+	pr_err_ratelimited("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
 	percpu_ref_put(&si->users);
 	return NULL;
 }
@@ -3883,7 +3883,7 @@ int swap_dup_entry_direct(swp_entry_t entry)
 
 	si = swap_entry_to_info(entry);
 	if (WARN_ON_ONCE(!si)) {
-		pr_err("%s%08lx\n", Bad_file, entry.val);
+		pr_err_ratelimited("%s%08lx\n", Bad_file, entry.val);
 		return -EINVAL;
 	}
 

---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260818-swap_part_one-1ad0fe65809e

Best regards,
--  
Breno Leitao <leitao@debian.org>


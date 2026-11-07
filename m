Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047531;
	b=WjszA18h/+XAjPeslgi0ETtMAg7xqFiLYb9/h3SPe4AP8bDkIj/xZXf3JV0ssMnhPV7i
	 bIfNbXbNoieG3SdtE8Bvz1WnW5oNCBPOzJH/oxVoTK2RS+p/pQjld7S+Lkf73xkcRLHP3
	 SifFhqAoXGrvPoYH4iQw0uYGkCMYftLusBJGW8CoAViq3ClXrgiuxzr3QqdW7uyUV+W9d
	 k55rlSWvgyabp+KUD4xjvKhsVXhF7q22puwG8HqMl8t/U1ZKMqhWbxJuMrc9fmBDD+GkL
	 cZRqw+v3Ai1eIJcBYErZ/k17ZCIJD90LhV9O5SSaaX0M+bHGSVKrjVw1lvE5+KVfNsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047531;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AbJHuUfvE6LOdRYwv0fJWP8FVwYv8lSsW26JnX6AIWM=;
	b=Aq6LIzUV09IZiidFrepzkIypRPUaaU658Zo0yJBCzCxG7ktYe/QPFIrq2Riy+iWGvpzh
	 kUeTCe+7H5EJ77LoRyVnMHCY/RId3jRt+ps3kVIwS/WqkQEMTiwpWMwzszDxIU3CBYSfd
	 K2PmoOGoq85LzjppXpLettk0c8STdUN8DJf0pgrvTHNvGlxt5qcSEZE0OdNCU3EccSYyT
	 Ds2KHJTE1NWZRQqAKvn3a0LmWzbunhuuCtglszp9AZVgdvnZsJgsBwjXEIGEDzHutQFwB
	 rQCGwYijxuO08RCSrO3NnLZu6gFRQi4koO1oZZ1jHlIPSmim9fBDqxdZcOihajtQhag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ciEUO3Yn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0934606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ciEUO3Yn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45711F0089F;
	Sat,  7 Nov 2026 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047530;
	bh=AbJHuUfvE6LOdRYwv0fJWP8FVwYv8lSsW26JnX6AIWM=;
	h=From:To:Cc:Subject:Date;
	b=ciEUO3YnV+VIMdmd+yDqQ2xg8vcOXk+GeLeTvTa1TzRzcD3iyRqxAswCfyWyPmYxX
	 IL2qt9IZc+/lW0g3On870cI7wxHZk7PgAZMFXcutYFQ44x+OiTj4TbmDWRhnqiSm4w
	 S4VHgNDwdQtfoLyois9RvPjTASl1l/x82zPvN8l1k2T7dV2R61uEpx18eevVBbMteZ
	 dgCY4dvZR6AT/GunomfwL0OX/+GBPRMbsBHQnj1k4WCYaYqdbXiKlrRZPA74r3lwHQ
	 Wc7tvJDXogkQODSMacneDPdmwt0In6MRvtKZxawJ4FpK5t1Gf8GSBDvwKvaCrIxsGF
	 xUgRFWf6phNtw==
From: Sasha Levin <sashal@kernel.org>
To: roxy520tt@gmail.com,
	enjou1224z@gmail.com,
	akpm@linux-foundation.org,
	vega@nebusec.ai,
	liuye@kylinos.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/page_table_check: skip zero pages" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:08 -0500
Message-ID: <20261107053208-failed-6.6-33afd07412a1@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 33afd07412a1efe5b750a3fd5eb0272ebdd12761
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053208-failed-6.6-33afd07412a1@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 33afd07412a1efe5b750a3fd5eb0272ebdd12761 Mon Sep 17 00:00:00 2001
From: Zhiling Zou <roxy520tt@gmail.com>
Date: Tue, 21 Jul 2026 23:56:38 +0800
Subject: [PATCH] mm/page_table_check: skip zero pages

page_table_check_set() accounts pages by whether they are PageAnon().  The
shared zero page is a special page, not an ordinary file-backed page.
Read faults on private anonymous mappings can install many read-only PTEs
that point at the zero page, but page_table_check currently accounts them
in file_map_count.

That lets an unprivileged process populate enough zero-page mappings to
overflow file_map_count and trip the BUG_ON() in page_table_check_set().

Skip zero pages in page_table_check accounting.  They do not need the
anonymous/file mapping conflict checks that page_table_check performs for
ordinary pages, and this keeps the existing counter size and page_ext
layout unchanged.

Link: https://lore.kernel.org/1f8848512d2e3ded944f8d595c29faee8fdaeab0.1784645969.git.roxy520tt@gmail.com
Fixes: df4e817b7108 ("mm: page table check")
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Cc: Ye Liu <liuye@kylinos.cn>
Cc: <stable@vger.kernel.org>
---
 mm/page_table_check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index ed3e1a76f2664..143a918c0bde2 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -67,7 +67,7 @@ static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
 	struct page *page;
 	bool anon;
 
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(pfn) || is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))
 		return;
 
 	page = pfn_to_page(pfn);
@@ -102,7 +102,7 @@ static void page_table_check_set(unsigned long pfn, unsigned long pgcnt,
 	struct page *page;
 	bool anon;
 
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(pfn) || is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))
 		return;
 
 	page = pfn_to_page(pfn);
-- 
2.53.0





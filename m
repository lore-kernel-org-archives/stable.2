Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AF456DFF
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922775; cv=none; b=dFcHp9j0NGRD8o1vgRvwFrEtXsJhB8JtxkT82zX1h/gLXgmTV6U+m/fg8nlYEpiAPCKJP/vI9tPUc3QSOl7w8kBcoaoY810L53jBComsLAM700G22SitMepqkrwWh1rhNlbyng2/Hs5VNgB4ek+pwc9WohTN22ClBvQXX8hgOgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922775; c=relaxed/simple;
	bh=YUytcI+m4jOaLSW6byh3vqrNZyJkPkPMPzL2oPZDyG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=agZr5VOyZAUsUI/OcHvxM6gU29Y7K7jUphUKdITYFd3X0/VWEqygpHhYvEkKfzmLmkocgj8TA0JqOX/LiJzMBc53fv5Sif9Pm31B8eIOxDCYgYJjuk8UKjZ8G1nUc07dLfZwLbeDGmtes6J7vlWkGo8YZYPrAfgh5gDaa+yVseA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=i/s5DoQk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="i/s5DoQk"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47362928f65so768724f8f.2
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 12:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1784922771; x=1785527571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NC+t0PVzM1V3bCRy8dl7R5jb/yivKWdDFY9rHZ/PNfY=;
        b=i/s5DoQkz2nvj42iNsKDSouT6CHxJU75FI4V7MTG+qguTV4iZ5YiAEcJmeo4zjsGbZ
         yMytC0TsJDoT4K/hci0unVU305ryMDAgqaEYvAZlveeF2a5ALF+IFbeV1+E9FUSX9IQw
         u+N/YdisuT/+E+wwG0aIOfslMk/Q8coDC70er405R2oAz++IFece+7iw2SjCp4nguwe9
         eeSjbKHsHQNr9o8EW0SJ9qPjw9WUemP34owhlS3tcsRF9pz1urBJRQ1alh28G7S1GFin
         b4DnTVHMRZFGvj+IXUOvk9EBHsO69p0iXOd3F22P8hWcizbdKHJcL6wDuhT7Rh7H4CPg
         EpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784922771; x=1785527571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NC+t0PVzM1V3bCRy8dl7R5jb/yivKWdDFY9rHZ/PNfY=;
        b=MbtF92l+ziBZMF/TwC5fKRvHKG8ZJBGQGBKSvl+W3SxaOzkagDfByVx3S3PiT0/vVZ
         yaj3cYiy9/iQDmdpG5LhPsYFpG/N730zvWGRLl9Kqu1HKW2trgDjK8+nGawfZS0ginTl
         9TyjNP+FTi3h45gNKN0sEtBDjN+dNtQByf7aHdazVq+sjE2SjJVgagEfDGsJWmyzgg53
         6zmiHriqiXl8V5mJGV0gOLxw2xoOaOkCE51/VrizqMtnUakyaClUgGbOlmHDQ46EGOT3
         Le7Xv0f0vVLwCH7JKbjg/yxaGCqSp8RnltW0wogzHQfEKuJO2fR3fK1KV+AC0cL7GLqa
         JnQA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/KHYosP/s9He1nEwYUq5IRaqcayoe4f2AiiLiurpm0I1lNesnj2EYSozFZYyF8DHtNZS1eGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKJEf4IKcz0TNdx9WtZKizht7p8eqWzn2tSaddlSpH6IQXzUN
	JX29zye58Cy1n9+eGUWuMu2TOOolmuO6Grtn/umwU5R0npmzutP06T1ejsd1I16Z18Q=
X-Gm-Gg: AR+sD13sQ1vhh6f6Tqjg1ocgufmlpU++JtSo4hDd2NyvfH0D0NKKwXkQO1NNJ/y20k/
	Bcbpf1jIZmCQQq0/SM3tK3w0fBXQ6x/q4kDKRDTRTvh6H8GBeX8fXe9P2aUfZnJ1QUQXyvaCjjk
	m7GOCLDgxDXlXXaMlR1dooZolyqMQYvPo8YZ/o9ApX35Y5nHy8Ite9skP2V3+V8XopaOxlEBuqB
	Hz9oWq0z0ku+byi/EUtO8XithZJPtvsLfrG2LMkhunl3pYN+JkoiOk8oU7gP2UilJ/0UyUY/9Ck
	Vo4NEaBol8bsEcDCmT1LGe5jByVXjsSOPo6YTb1XbFC182jIW+ZAn+XXeziHE6YE8IwjSnzrCrw
	62zs8AzlkgL5INXwrTdD3r0JwJdOHDksiahqOggF5j+XBtSh77oGIbQVbEKBN2XMg5xRkbbGwrh
	SRj5iM
X-Received: by 2002:a05:6000:25c3:b0:47f:6fd1:d399 with SMTP id ffacd0b85a97d-47f8d76ebd3mr11047801f8f.51.1784922771364;
        Fri, 24 Jul 2026 12:52:51 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:294b::41d:2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6287csm26605268f8f.25.2026.07.24.12.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:52:50 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH] mm/huge_memory: Initialise workingset state before folio split
Date: Fri, 24 Jul 2026 20:52:44 +0100
Message-ID: <20260724195244.3715130-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

xas_try_split() adds __GFP_ACCOUNT for page-cache xa_nodes, but
__folio_split() leaves the xa_state's xa_lru unset. That lets a live,
memcg-charged xa_node exist without being linked into the mapping's
shadow_nodes list_lru; when reclaim later walks the list_lru it trips
VM_WARN_ON(!css_is_dying()).

Use mapping_set_update() to install both the workingset update callback
and the shadow_nodes list_lru on the xa_state.

Reported-by: syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c5b060ce82921a2fd500
Fixes: 58729c04cf10 ("mm/huge_memory: add buddy allocator like (non-uniform) folio_split()")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b5d1e9d4463d..12d0e0b14e83 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4033,7 +4033,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		gfp_t gfp;
 
 		mapping = folio->mapping;
-		min_order = mapping_min_folio_order(folio->mapping);
+		mapping_set_update(&xas, mapping);
+		min_order = mapping_min_folio_order(mapping);
 		if (new_order < min_order) {
 			ret = -EINVAL;
 			goto out;
-- 
2.43.0


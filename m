Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E38175A95
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784974467; cv=none; b=UhcyiRmIbJfn25btuyVQ47bvS/4n1sRIO+7co1Mnmkwt3Ci+1U7+mVqy5byRllRryK+2C/6iqocTX+DVZuOXeKlbqIFBDptmegb+Fhgx1RkORI4v+Z+HuuES3e3QUqvQmT9Ws3D6TPQyITF6JH9uLqyut8CkhYdXmY1T22BeJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784974467; c=relaxed/simple;
	bh=ZoevCOB3AVJOLQNo3puwsZK3nyVscupnbFcL/mWh9HA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOFtO4RbPLcu08L01pN27tZdMcPG+/mnb2j0PeoNYrnYl54K8iPcD57btjJSbYcZKk1d4iall64jL87nHPGEDQN3E/VnG5TGsLQhjt8YJLv9wZ4mL/jdfGmX5yK7q6EzAxMsdYE9EgAOUeZOYld5YRGuHng0lH7bLzffLrDvVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=MU3KKvFC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="MU3KKvFC"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f703a9d05so750265f8f.0
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 03:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1784974463; x=1785579263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mKnbPcWgHhMyrO4V7xcbU637Ba8Qy4Y9EblUr4Mkk8k=;
        b=MU3KKvFCf3tUK7vMQS1gB9d2oVTNHotkBEClBkOg3l/CQiuQ4DpRpovQla3YrT5OP7
         VipdqqIeWb4hamcaXrCu7bSugbv60qhfmlJjeXeLve76OEUj9hgt1ChtxO8HCRtkIME+
         tp9L0d0zs7kpEcryjyYj1bVaemxyg0mnMINZ0NgJNUtz8yRLuz3Yg7/0ivMvwyAMHyxU
         d9fh/xP9tgmMU+heDOIyn3IynjQHeMtmZwlm+CJrpTLFZtYz5LeCMq1cYBe3U86GpqoF
         0p3wriiN7o3nwnjVSaVjVgRbEr0i2URMLyVXpKRhCH9B1vifQjV5lwwcRywIlkT6srfv
         F2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784974463; x=1785579263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mKnbPcWgHhMyrO4V7xcbU637Ba8Qy4Y9EblUr4Mkk8k=;
        b=ACp6la1BcLltmvbY5NDNAOkhelLZyigrRyESn75PIoRKYpeThnYfAMb/myAfPzZ9hP
         79UaY4+4gTI98t9SIGJ9wekjsfkWEKsXH2CdUH4R5Vxe5S4o9a8f2MOyEPMgmqHHAeFr
         7i+zpCx427ZHbXUeUaFqwmjI44Sqj+G9YjK1I9pNJpUEoB16/UAf85k+W8zfcOJOTxyV
         rA5KqorYNqVGz4UhrCG7uRhYrx6owHJt4Dn6LrG8jIWVQbuRU5PBQSnc/D4CodoKDhGT
         ZjrnTaPEk5AVvoa6DkmRxojzsNdQ5PtwSOZ9TVOVIIchz70K4ifgbtZ8YZrHTfCbPdZp
         a6Kw==
X-Forwarded-Encrypted: i=1; AHgh+Rr84io38cotWDAmBUJhro0WtfDdTAymMhFtoD5NN+JA7yB/F/o827WOk+pZodwmihatY4nVxXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR83rg0tpu9w+475Qw1fyi8hzddMjKuZEDK0Eq/aXWJqBxIQ+k
	CFrZWCOt7efMVvmlCYtnNOeUCRG517RCjk31WSlbcc2BVqRtzXSVdyVg3kwSlsaxpo0=
X-Gm-Gg: AR+sD11HNH8DOY35eMBt8DkWfMKalG1ItHiCs3xSGesGdJ4fc5SekbsEyu/XBh0ByBz
	oRI07ZrTTkLJHG6picjF9ciEJ3ovcaclpRZ9BkynaJc1n2rFlFTkzjWSET4S/uASTTuAR3UIYKB
	daCakyDXVn2edOMrwyLC71il+K4w2exhvmUwQqukzO5jCXHm6YWYmmqy71fIaG2wCgoMX3zKPgC
	l03/OkTcsXcYz1AV/wi8m0iAx2PXqy9/fOQM2WLLzJGv4JhsRzRhBbwQL6Al/5K6YFk6/GSntQA
	hPauzc59t2tlAqDr2E+byX+F+OoxzDzMGc09Wg6k++YmTOxQrFtNaOeF6XBYmvMz2LIz35hyOyy
	026OB7qRbh/RNW61/ZlpCks4rcqFYOocLSVfIsDZaXAdyO5AU6UDAp9j8IXFVMWWTexFLK989Jc
	e879y8oA==
X-Received: by 2002:adf:e190:0:b0:47f:52e9:3716 with SMTP id ffacd0b85a97d-47f9fea1ed7mr1967871f8f.44.1784974463387;
        Sat, 25 Jul 2026 03:14:23 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:1f19::319:116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f864305f5sm30334154f8f.17.2026.07.25.03.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 03:14:22 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
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
Subject: [PATCH v2] mm/huge_memory: Initialise workingset state before folio split
Date: Sat, 25 Jul 2026 11:14:19 +0100
Message-ID: <20260725101419.3938406-1-matt@readmodwrite.com>
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
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
Changes in v2:
- Move mapping_set_update() after filemap_release_folio() succeeds.
- Add Zi Yan's Reviewed-by.

Link: https://lore.kernel.org/linux-mm/20260724195244.3715130-1-matt@readmodwrite.com/
---
 mm/huge_memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b5d1e9d4463d..4ddbc72e92fd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4033,7 +4033,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		gfp_t gfp;
 
 		mapping = folio->mapping;
-		min_order = mapping_min_folio_order(folio->mapping);
+		min_order = mapping_min_folio_order(mapping);
 		if (new_order < min_order) {
 			ret = -EINVAL;
 			goto out;
@@ -4047,6 +4047,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			goto out;
 		}
 
+		mapping_set_update(&xas, mapping);
+
 		if (split_type == SPLIT_TYPE_UNIFORM) {
 			xas_set_order(&xas, folio->index, new_order);
 			xas_split_alloc(&xas, folio, old_order, gfp);
-- 
2.43.0


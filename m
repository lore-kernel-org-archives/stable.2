Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B342D753
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929968; cv=none; b=GJQMwc+96X3sFP3F/fA+vC+KvILGcHlVf60hZDKC0tMq2BIemsaNJ09ncDZhiX9ot6ilccJkOc451wq19h2LFlJSY2Ego88CfDSwNszVAWTnPcAIRDSiULhSDQ9YussvG8lko67JabpLvErUtNBleWWtx2JXZbcmerEafnZr9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929968; c=relaxed/simple;
	bh=iAmUHHQzaz4f9Rg6y4wTz9QKPgpQfSPXphBN6MdnwQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvOAeSR7rxkL1AuPj3Qo47hKXSK2Uc9c64vT7qXF4JLJhNvb8vipUAwQybX2bkaFERlWD0Kp+euIYOEJZKHm9/RmN5iq000SM15RjkXvd7YIq2EYBZO1Ig95lMDpp07mn0AWXZQb1ckT88KT6oDoOJyoZWUj1yB+pHxnlSleIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBUOcS7Q; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBUOcS7Q"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84f10e55beaso222978b3a.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785929966; x=1786534766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cWKwxfj+Ulmx669+xXO9b93Zs1csGNYfgoV9iYgU+M8=;
        b=fBUOcS7QGurlf9Vnc4x6sAfVbAuZfaSJG4VHCVNOVFqqiD27/9FIYC/aif0wt5CjMn
         x23CXRbXmOYGBYciMN8jGY28rPkNoDOqX1Pf+eR3AcEfO1TRyzu8+SKLjMITPGzP+YW7
         WE/rP+VwgWcrPRD8BrLbxtsCas/U0IT81lWiqPOM8gpM85PT45ljoZXu4aYerofKIWyd
         UgioUGDzsm3M7xEZd4cHv62SLRIOw1Bxvb8RmEMQmI2zLxf6mvXwIaOz/BE/dVxgPaRi
         2ffaJHCUl3jnxdSfI+OrqYBhw804lRJx+zZXP0hpO7DEZTJvwxYDzmapBE30xUw7jqdi
         n1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785929966; x=1786534766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cWKwxfj+Ulmx669+xXO9b93Zs1csGNYfgoV9iYgU+M8=;
        b=eag/uOQwFK0kjxY2nF4n5pQLTAI9Bm04/02ycfjBBdoK33SgK5iTLy+IaIhiK2u1e8
         0dpXMbtSa8o6BEbbNWmlSOIfnXsNFnAD7b0MUedpV05aQ0Y9G7nzD1ASwEzauCwYS++b
         CN+3sq3zuiTiXK4KtiSmcdoUWholp2cYbWJTvK75j12AIBGv4/TFqaNVhq32Uoeb3d3u
         f7XTQpfPZ88dn6eGY9J4XLhlVYSzIABFLKO10+ydoSNddg1jSlryAgW0hP6XAeEOr3q5
         hAuLdcrVBukHUFUcPfTgvpkggLrQ/ANpFP1+3onbXmaxjwzhAf4DE5NJIcf4cXchZdQm
         TPNg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/xIMSPPeu8FFxmZ3G3OdRwdZMtWaoN97f8XwH08f1KbjVDPW8TT6MLAEa4HXqvhoFVs0N1fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqq50uyE8eMcR9MT8rnrIfiV6IvzDzy5fkNjAKVYKDL6m96+Tv
	ej/ssYE6mF/ofkaff2DFAFenJ3fyWnvIksxmspTR4KWZztuNITI4ICto
X-Gm-Gg: AR+sD12Hh6H5e/ue87cv/vtKghDBSsD7apEu5tmRTky9ZC00GA1KvSjz/eAPG6sk8rs
	ftxFIzn32AHG7LJqLQq/WVY7+cuLBFTj15ZYd8zkkBrqZCyDebU5azf9hHJq9ddE757BwDDWZDG
	SyycfoVGysKA3SeO75Df68NzAybJ/XC4Psd40kH9/T6ZnYcmlkeRUjOOHZJgnMCgn5KaLAw96XP
	6WpQqxtCqgqyp4ceCfGnCgk2mk5hK4RNeh9RI8hmogj3we8yOXckfeIB1+ZuabSmzm2j4mq/Lca
	BGM7eTRiCwbkGbRkDBC+VT5aIbm0wS6PNCF3WTPNBQb4SEFbB1JdeCNo9vSJgCvMg6TnIt3BH/K
	RhaoP98UujmoPmIqXIMCmTIq0LKZ/jTZcZQ0Oet7o3pJKXP8+UxL6KiDz47fOysRiZXy+EXXI7D
	Ua+ZLpgMBHUone5xHFnADuEwndWFq8dx8QtdEOTjjcJupqL/KUy6x/rN3MUVLzAXMfcTzItKSAH
	mIhU932NVhAjyOAspDoK4XJxioHuhOZHh93OoxecrimGWa6NmhG/0Ep6HJFySLKqd3/rUMCytbX
	85+ysHfAgjmDMzXwWp1oPAsFKCqwOVsrueH4V5/RUvgveyvStdZ2
X-Received: by 2002:a05:6a00:22cc:b0:848:2c6c:dfc0 with SMTP id d2e1a72fcca58-84f2e04ea1amr6194826b3a.24.1785929966087;
        Wed, 05 Aug 2026 04:39:26 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe708c0ebesm1368088a12.19.2026.08.05.04.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 04:39:25 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: ocfs2-devel@lists.linux.dev
Cc: heming.zhao@suse.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	glass.su@suse.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Matthias Goergens <matthias.goergens@gmail.com>
Subject: [PATCH v2] ocfs2: fix cached cluster count after suballocator reclaim
Date: Wed,  5 Aug 2026 19:39:20 +0800
Message-ID: <20260805113920.385959-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <anL1pYKZK8UqYwsI@p15>
References: <20260805070837.3390148-1-matthias.goergens@gmail.com> <anL1pYKZK8UqYwsI@p15>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reclaiming a suballocator block group, first reduce the on-disk
cluster count by cl_cpg.  The current code then subtracts that new
count (fe->i_clusters) from the old cached count
(OCFS2_I(alloc_inode)->ip_clusters).

For an allocator with N block groups, that leaves the cache at

    N * cl_cpg - (N * cl_cpg - cl_cpg) = cl_cpg

i.e. ip_clusters -= (fe->i_clusters - cl_cpg) leaves ip_clusters equal
to cl_cpg regardless of N.  This happens to be correct when reclaiming
from two block groups, but undercounts the clusters from three block
groups onwards.  The incorrect cache value is also used immediately to
update i_blocks.

Assign the updated on-disk count to the cache, matching the allocation
and inode refresh paths.

In a QEMU test using a clean 256 MiB OCFS2 image and a 10,000-file
create/delete workload, the first buggy reclaim left the on-disk
(fe->i_clusters) and cached (ip_clusters) counts at 2048 and 512
clusters respectively; later reclaims underflowed the cache.  With this
change, the cache matched the on-disk count across all four reclaims:
2048, 1536, 1024, and 512 clusters.

Fixes: 4a54331616b3 ("ocfs2: give ocfs2 the ability to reclaim suballocator free bg")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---

v2: commit-log wording revisions suggested by Heming Zhao; code unchanged.
 fs/ocfs2/suballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index a4a2b87a45fe3..20c3aec6b9873 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -2759,7 +2759,7 @@ static int _ocfs2_reclaim_suballoc_to_main(handle_t *handle,
 	fe->i_clusters = cpu_to_le32(tmp_used - le16_to_cpu(cl->cl_cpg));
 
 	spin_lock(&OCFS2_I(alloc_inode)->ip_lock);
-	OCFS2_I(alloc_inode)->ip_clusters -= le32_to_cpu(fe->i_clusters);
+	OCFS2_I(alloc_inode)->ip_clusters = le32_to_cpu(fe->i_clusters);
 	fe->i_size = cpu_to_le64(ocfs2_clusters_to_bytes(alloc_inode->i_sb,
 					     le32_to_cpu(fe->i_clusters)));
 	spin_unlock(&OCFS2_I(alloc_inode)->ip_lock);
-- 
2.55.0


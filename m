Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CFF3A0E8D
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065563; cv=none; b=bK3rGdRWtvrV3JgzvJ9U5dCBNTsgJbcCiS6aGz/7yCeXIrQEt6wJ87xTBy/eZkbu+Ibfg4oInzCa+hnsU8aUwdGfHswPrnv6HHuMkZ+woxRWbR6h7XVYLakRZDEliC4IrvxXuU3+yqfkuiQXIJXGR8CxQOArmZiVqtmnudeXd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065563; c=relaxed/simple;
	bh=UmHDQ8Avh88213YFsBTKp7WY9yAPzXpx6PsDprJSvWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efjxY8FJ93XJAHDWPStX3NpON6bqGocsg3m7wOZXiX8y7XP7O448PMKeTYgPDcDb6UFqR34h7rxZBdyq37JUh/7vMnEwWknV9y6IzGxw873SY2K8Y0WKecfr3laQbGkto+LgaZKj56TGnu9S4Xae82DyjUsok9wXEfg5t0r04OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=NvQ8//bf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="NvQ8//bf"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so3370355e9.2
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 04:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065559; x=1785670359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=NvQ8//bfQJuzp7j3yL6gGGLYRLnOCIWXp9Tvdo/+924SfpBfJNqUZbLQ/g52q/t3IP
         EIMETlmWs5z4+GPI7G9faNf0w/VzoWTgtPV003H4FOTYAkbA8/VncXQq+0VjYU0fx3EW
         W6k7VMG/U1W00FFP64RodffPkWcQX6C4WrqnPoTE7X48uA5BvZtLcjeyriHB4OvsZTug
         VDWon6KhNPTPrdv5OgErtQAFkMuTKEUU9G6gIIjPCbUKjLUqk0bzCqnnJCz4ScP85sbn
         nr+DIJD/zcANqYHkcoigNe/Jtl+6UY1MQ8B74D3cVc51Y96cXwxVP5uVswIDnDmV4/it
         FF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065559; x=1785670359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=je+TGSlZgMYFXbxmg3S+LAPb/N+qELUK9+ZuBdNkmu3sPiGKPordHkRL4VxWLoUaoC
         D/5rF+8RotLtdS3OQqaFeUKVUIfole39gJc/dTs7asEJBDBZ/Bc5VccVYO/LWOiEGhWQ
         +YzmOU1LC6kTWbaTi6U6aBKPxDt40xl3xBQWd6yW4gnsAroVPpuP+qO6omeZit/MzdJv
         jiJKWbYgiTskwaTDx2tL0NBoR5KB+4QW/h3LdIVQsdtF0K1XmWZcVcfIoKavZQkynhJS
         yfBeSlhQhSoLgb2eZZbfAFTAlOiQHDjr3xLC+zTehNW/BEh+fuqIhGZpG4wQYm2IlGqO
         ajcA==
X-Forwarded-Encrypted: i=1; AHgh+RrGBbO1pglLZzESmZcNhu/DZ7QyNW79EIoe0Vh5huADTZYsJ1gwTzrH7TZUqk4o4ceDeKvpUQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXwDleliwvpnBxNW09JGwR0mE+TaPgNIcQAZ7NpQq5ioSz5++
	Qmr1BfLegQB1Tl4vghZJIwt8Xj9uGO5HTRjJqrFrJu7+3H/Sc/1EGGLQSvICq9N4Eg==
X-Gm-Gg: AR+sD12m87/GjmjQZ8BHAPKj72bblH7aYAAa7/FoVqSOE9doapeMPx8SQd7zlBKAH5R
	FCBIwMzS5NiEpWSE8bKfvvKZWzszjbB6cpl3WI6LlsTp9eplpeEiPu4HQkI40Uw99Wms34b7QGN
	vTkIFWbuRTTkUpaU3pFs+P2Cq5O82yR5QjxhzRVbFK149Kz1KTsRsqrh9Rq/KXPaOzhxotn3uaM
	t+iL22qJ4SvI0tu7pAE/uH9SgFjLpIrwm7Q4A0uUmy2Gl9bk1MEkbU/PW84KWfraWBQSS+3QYQd
	ykFSyJApku0sr0x4gblnafgOtvM2dyCvj1Zb8kcMOYmfz+0lBA3oB1Jox0FFmF0a+w30icIrGpg
	r3NpbE4/X587QI10ceIQi8E1x1MfiA+FbcjrBXkTmz8rKJ6eSIxyvsDY8DFrPD6tDLtHyDKTQk1
	P/9BmMoo2Y5kUYH3vUP8NtTk3FQaQkz2v8rfj5xYchLi23JnxwrtA60bdKK3eM8VuwlQqs4Q+2I
	JMfmuVgFK2uKZawTCPMCYsW+SWPSm6swrB3zSwCjA==
X-Received: by 2002:a05:600c:1d0d:b0:493:c8c6:4989 with SMTP id 5b1f17b1804b1-496b56bbc65mr64847835e9.6.1785065559344;
        Sun, 26 Jul 2026 04:32:39 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:38 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 02/12] md: ensure REQ_NOMERGE is set on P2PDMA bios
Date: Sun, 26 Jul 2026 13:32:19 +0200
Message-ID: <20260726113229.2154269-3-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

md_submit_bio() strips REQ_NOMERGE from every bio.  For P2PDMA bios
the flag is what keeps requests single-provider (see
__bio_add_page()): merging a P2PDMA bio with one over a different
pgmap, or over host memory, maps the merged request with the wrong
bus address.  Set the flag on P2PDMA bios -- bios built via
bio_iov_bvec_set() arrive without it -- and keep stripping it
otherwise.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/md.c | 10 ++++++++--
 drivers/md/md.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d1465bcd86c8..3770bdb4d4b2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -451,8 +451,14 @@ static void md_submit_bio(struct bio *bio)
 		return;
 	}
 
-	/* bio could be mergeable after passing to underlayer */
-	bio->bi_opf &= ~REQ_NOMERGE;
+	/*
+	 * A bio md split may merge again below md -- except P2PDMA bios,
+	 * which must stay single-provider (see __bio_add_page()).
+	 */
+	if (md_bio_is_p2pdma(bio))
+		bio->bi_opf |= REQ_NOMERGE;
+	else
+		bio->bi_opf &= ~REQ_NOMERGE;
 
 	md_handle_request(mddev, bio);
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index d8daf0f75cbb..73df1a6eccd8 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -11,8 +11,10 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/badblocks.h>
+#include <linux/bio.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/timer.h>
@@ -22,6 +24,19 @@
 #include <trace/events/block.h>
 
 #define MaxSector (~(sector_t)0)
+
+/*
+ * P2P and host pages never mix within a bio, so the first bvec is
+ * representative.  Read bi_io_vec directly: bio_first_bvec_all()
+ * WARNs on the split clones md handles, and data-less bios have no
+ * bi_io_vec.  Not valid after the bio's iterator is consumed.
+ */
+static inline bool md_bio_is_p2pdma(struct bio *bio)
+{
+	return bio_has_data(bio) && bio->bi_io_vec &&
+	       is_pci_p2pdma_page(bio->bi_io_vec->bv_page);
+}
+
 /*
  * Number of guaranteed raid bios in case of extreme VM load:
  */
-- 
2.52.0


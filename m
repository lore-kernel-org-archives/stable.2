Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDF3B9D96
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439044; cv=none; b=FcH7TQyP1vnt4/PPVcP2rTrUtvgkl9rKvIT9UoG6lerI5Smgijzw3rMSFxW5NlY8Xy/mHecZk+Is0oKf3X9mpeD78Gt9YBVYq/GE2cjwm5O/iIoCak5ksa6gg852xvRsHhxTIs8MNIvLM3QR+4yOobLSNKZCXDupsYKPsgHehCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439044; c=relaxed/simple;
	bh=KFBVO6QyzdW4ZTmOdrPRQeIRnCIg49mEfVFjUotbCP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwYfSitYKC1RJBf6iSLgimOWQkNrNpoml/7WQKthayZnTsQwPjjGDVHKtr20xhyLpelEyXeU1F0GHn8P8o/D/lFVKk+oWpXLqmLOpvDpmTMZW4brk5AIYCBNVXwg3IiWwH4dV78viDsLBna2qVpvPQPib8a/DOBFIPEBtJN09Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFRmSn4M; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFRmSn4M"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490ac357c55so26292075e9.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 15:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780439042; x=1781043842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=muTnxhGqlYOE/TlItGjvUxPhQ3HFtb72AnUGbvWcFwM=;
        b=nFRmSn4MzrLEITRsHzfZf0E+2I4gVE/Ps95QxQPrS0HY9dJVvi7XUE9uu0Fg2Elp1B
         MLYr3UqrWR+s+rKdFVA8MjcLae9esAZT7W2oTEGtvFdAZSECyNQbL4CTMwSmxaPru5Rd
         CEYAFot246PtxunfpwYx0Zdtes6GxjuBRilN4I4PcSpKRyVIbciaLZg7yjTFNPFwMgnp
         Z3xcEiAaWnmRSiGCL/ZmIIxY0TeWFISbHmagg6WNOlotztg+Fps/g4zoTR2kSG97Ru8T
         jrp8iWsnTfNtPoVY78Fv3ysp2ldx0lJSrq9X2DO0llRhIj9txo54S5xvxsEa1xk5k8gM
         Kbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780439042; x=1781043842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muTnxhGqlYOE/TlItGjvUxPhQ3HFtb72AnUGbvWcFwM=;
        b=Pn/3icBRVIvFkamsS0NPR4flt5U0w/f94gV1rVPc6oAtcu5/WLa1zLaEwcbrTDZXat
         QzaKORzHA1a4iySDbLHw1nWyqhhFPt4pCPxbRQ9UCI5rl6941FaqDEbpEapC60qFjVGf
         UuD3d6R7b1qq5LKoUIzvDBkyYHnRKfsDuVeUXZnLHCDn//BqbbdMPYeMIYGlqq56u6h2
         7eIZnfIHeZDvgY/m/WMMn+Y2woVRP/3dfkohtu22d+strh036PdOq98cFkjc5DmRCXUy
         bChwqvuYNyzrM3AR7MGUd3V7UJFZU+cRiasdzbk4aPygy+/5XkM/13JxqvyzqWJbBKlq
         Ke1g==
X-Forwarded-Encrypted: i=1; AFNElJ81c+n0JYzwrzDfxw7yjEJga9yn4RpXwKg4pV8o/F9kY5hxF9VTqMkgtrrXr1BJ+DOP+LzSUhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZtM3ZROlz9c9A0vuCCoeNvzpiP8NUeFQ2Hcv6F9Zph2bQWlsj
	y4IuFl9NSIatpghSNnAlxcpzcTXXFzLphf/eSzC05s+CTmbLcMbFiemY
X-Gm-Gg: Acq92OFp3UgJ4bKjLpb/Theqc7u5Vm5sMUYH0JJO9Wk5+5/JQOswYOdW43ld+L9n6iA
	GiLvAVDlZ9klCsDQopaO/daPIOvR0azxo7gmT8eoXENvdsV3/eXCAhvzj8CCzWITw/Zz8euAIHe
	tpiGS26y4Cw8re6IlS0DkeIe7wHzDNV6r4WqClmKWv0pWGMMUYICzQ4ymZCtlbRnxS4d5k0fl/O
	P+olxskPuhsuwdFySmRLGIzk6eJMyaspcY1TmqZ+Vll31DzwcF7Y/sG/FF4CGK82Xd0qoSrcpnv
	8EIePaViw5ey6KHgELJMmJ6nvr7uxEzc2369WDVh335TzynkFmVRhPr4K75Qd0jos0nluDmA1wl
	aWv+lYASzJgn6FaFQ8ywWdLrEvDwmNV2Ku6tLjS6vdTuYxfP5R1upmyY50d1KF1nu74ZEoP54cn
	3+nuiYfh1FCtaRDucWNO2PqwOydPTyao1lO5UALR5Y3cqM7NCvuwJW0ID5lNzGlPKj1PdAOk/69
	aCayK4rGttHAssdy+df3w==
X-Received: by 2002:a05:600c:3e0c:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-490b5ea86d9mr9922945e9.10.1780439041650;
        Tue, 02 Jun 2026 15:24:01 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b60f6d5asm10362265e9.0.2026.06.02.15.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:24:01 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	syzbot+deedf22929084640666f@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>
Subject: [PATCH] mm, swap: free the cluster extend table on teardown
Date: Tue,  2 Jun 2026 23:23:57 +0100
Message-ID: <20260602222358.49061-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

swap_cluster_free_table() frees every per-cluster side table but
ci->extend_table. That table is only released by
swap_extend_table_try_free(), which the teardown path never calls, so a
cluster can be freed with an extend table still attached.

It can also linger while the cluster is live. swap_dup_entries_cluster()
drops the lock to allocate an extend table when a slot reaches
SWP_TB_COUNT_MAX - 1, then retries. If the count dropped in the meantime,
the retry takes the normal path and leaves the table behind, all entries
zero; only the failure path frees it.

Since a swap_cluster_info is reused in place and swap_extend_table_alloc()
skips allocation when ci->extend_table is set, the next user of the
cluster inherits the stale table and its leftover counts, corrupting the
swap count of any slot that overflows. CONFIG_DEBUG_VM catches the
dangling table in swap_cluster_assert_empty(); otherwise it is silent.

Free it in swap_cluster_free_table(), and also on the
swap_dup_entries_cluster() success path to match the failure path.

Reported-by: syzbot+deedf22929084640666f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=deedf22929084640666f
Fixes: 0d6af9bcf383 ("mm, swap: use the swap table to track the swap count")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 mm/swapfile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 615d90867111..a69a26aec4c0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -432,6 +432,9 @@ static void swap_cluster_free_table(struct swap_cluster_info *ci)
 	ci->zero_bitmap = NULL;
 #endif
 
+	kfree(ci->extend_table);
+	ci->extend_table = NULL;
+
 	table = (struct swap_table *)rcu_access_pointer(ci->table);
 	if (!table)
 		return;
@@ -1711,6 +1714,7 @@ static int swap_dup_entries_cluster(struct swap_info_struct *si,
 			goto failed;
 		}
 	} while (++ci_off < ci_end);
+	swap_extend_table_try_free(ci);
 	swap_cluster_unlock(ci);
 	return 0;
 failed:
-- 
2.53.0


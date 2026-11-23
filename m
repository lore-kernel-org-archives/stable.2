Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402824;
	b=U2pQ04qkFfruw4sTMagNI/IfLUIdu35U7acKmryUaqOlaxY2LhyHQkJFzwygr6CFnTXo
	 5z89igSe0vayOWi+y6ZmIgXMGoX6HrFvrzYxMGxt8KFZwtBbqLOFG9QaYMVWQPzwR3f1W
	 2nMRo/iMiVly3uCwuWaC6P7CEPsyITPoQswoR/8jSR2gyQBlGghxdtj4KCdLkk1gXqnD1
	 wtVXinM7vildxsFa+A5pQP+BfeXjEYtD2IOH5PO5PIilNiTOMtA5ttAbVsEM6gO3rzhNy
	 NI4tiWi2JdNwnNpR0dEdds8iJ8SSiVZRQO+KSdyjCy8nonDe4jtTGNvvYSoelWATrtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+FgxJSlCMhr6jcW4y/MvZaUC1tSRD2CiwZ7Xb0DzK+s=;
	b=fdQEd8YzXD3dy0ijSoi94pNP5r/Lr2C4rPjNUhQEOmRJiVDa8BgAjjF+R0w0+FW9/q0v
	 PRuXI0Bqz4aTahL/A5uWkNC6EY6/xKvdibHq3SxlPyPL90bvchfbKd7M1giD/Ex5BltWq
	 4F4vR6QBGP84Z+7lc1gsnWtBSJb0mHsPPxFidhuqSSzgG5ohDl0r1GgUOtW2rquat2cK9
	 nPf2UBGpbiciR7hkQnsqkVpfs8M6LzQKrz2o3cJaUzMGQdy9p5ewRN+OG8J8yN7AUrK2W
	 BlPRagr2N+24BmRwhVL8Wgc6Mkj03ilRuvqlZlhlVVDxBehnpOMbkPSZVWv/daKG55w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Cn/8pBu3";
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DCB606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 03:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4DCB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cn/8pBu3
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2effa00323fso12263195ad.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 19:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795402823; x=1796007623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+FgxJSlCMhr6jcW4y/MvZaUC1tSRD2CiwZ7Xb0DzK+s=;
        b=Cn/8pBu3pDIeFt8N15hUWOPvoG7TbKXfgpsTAn47Y2l/zwIyq+2z+kbkma8yPW/4ah
         4u9MuAo6vM+i5vmLy+43Wo4sPw89W6R+BeaEtdGpf0pyUSE+XP9lIHStApSeuQqbpBG3
         7hrMsr81GrTEtA/pU8w8vc+0ExsdDtUUaOzQtZPXkXCeu5E2Fl/1M23N6WySO56Tdh4W
         1NE/CXKFV4BKY52PcUxRFVCGgb8KsXrGz1bJTrwpg8J9nkvapYzl7iuZ6qkVkW1ZhHT5
         pFWwx7ykDfsj+A7mhgiVNOikPoKnheVCQiFkTagf5IZmueeDcBN0moQkBOfYDBNLGHDQ
         9sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795402823; x=1796007623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+FgxJSlCMhr6jcW4y/MvZaUC1tSRD2CiwZ7Xb0DzK+s=;
        b=el4KRWkv8DG3q07fA29GIOzzYwfMBQyCby+8pNuIFN5qWzZVlSMA85lk3THcZJLQA3
         mVgQ1vlWcUyGF6wTE5HvqJik9QBO95zc3BBokO+lZFKkffI9l/xLFEs0V19gYv8tMUDJ
         i2eCnqUkUyV4zQ7ekj1JgDcddXxrxe2vGNEDFEb7YPinxWxZCbRUb71qwaHV3Zvj2/A8
         Xyu3XtTzxEL7Jvz3r+x/hKhlwk1ptaAg7DbSTZjEjDm2DNwuzIASeBc9tkiCujdtUbYQ
         sF2imYpdMqv4UWz/iGE57OjV41AVN/t2+cO2r2oWxjNcab5igyEnLxnUcQ0fqHKNwnwy
         u6dA==
X-Forwarded-Encrypted: i=1; AL+hErEI5xAAMKnowVgkF7mp6j3sYz19t5NOj/MWdhUeM2lkkZcX7iXlgrKZv6Z12CeG19WEilcffyQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hanzNL7yeprllWh6mvi9fY9Ai03GRxqLBk+RbJpB+cUhRXYLw
	pzDu5rTxLqhooESMNDtlXKzCH5JCQ2MbM772RiGLiD+h1BpR1q2ILB2Z
X-Gm-Gg: AZFdTZfsc5xYdDgKU2Q7fmwNMlpuKoYnFeUjuVmX4BzpMF4h3dcF/pof0vGMLEbYEtG
	6lVN0r8tro30sAHWbHMlYBSA2pxJPNO4Hph4AbQsZKoPZSvrGk9KkoQlLOkUE7xtop6eesEBuTo
	cRnXxUiJC3NqsDWDm2WLFzPugQuO3misioYmsU9Z2gVar3wYDty3j4ypBBrXNGMHkmTXvnTQ7yg
	n2TaE6c2fXsfu4So5BloE/isPtA5goNZIPC+KNNzMMCgK5k6Js2F0+dJ3ww5imRExstV+W+t8/c
	tqlD86wArFm2kSRS4p0Vp9nxysW9jFKM2dU7FWu/t8FlE5OXRvNWc9F3sV0fMgZD3SzrTu4IoX9
	440/fWr7G6a2MMjEKBMH2vDO7Kl+P7Vf6RJqS57f9vFhfUIJeYLoQcGM/sG8jkDB5ejDFuwC9gc
	I37lTUC1/SxtYF2V8byRUIsqol5hk9xLuH5ECYP+XcjnKyfU+6nu3o5Cn0RVMx+wsR5Qakkobhr
	khgli/sg/lqtlR8UeakAbyzOtIT8+PhKSG91RMAfGU3ZOi/QRnhuRGVCrmhl5Fvc2KXKqP3f+4B
	QB2o9Cq8KeyEd5dDNi6IEef4gM4nYTX3hw8CrtISK04ANXHjdaqhRVc+Nn/CdPNG9IQ6feuWBPo
	=
X-Received: by 2002:a17:902:f603:b0:2e9:6788:9381 with SMTP id d9443c01a7336-2f03f0c1f04mr95101065ad.7.1795402823169;
        Sun, 22 Nov 2026 19:00:23 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f070a12491sm21615055ad.8.2026.11.22.19.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 19:00:22 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: fix cachestat NULL pgdat dereference on DAX mappings
Date: Mon, 23 Nov 2026 11:00:14 +0800
Message-ID: <20261123030014.3116755-1-bsdhenrymartin@gmail.com>
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
Content-Transfer-Encoding: 8bit

filemap_cachestat() treats every xarray value entry as a workingset
shadow.  On DAX mappings, value entries are DAX exceptional entries:
same value bit, different bit layout (flags in the low bits, pfn
above).  Decoded as a shadow, a DAX entry yields a bogus node id;
NODE_DATA() for it can be NULL, and lru_gen_test_recent() then
dereferences it:

  Oops: general protection fault
  RIP: 0010:lru_gen_test_recent+0xde/0x300
  Call Trace:
   workingset_test_recent
   filemap_cachestat
   __x64_sys_cachestat

Any writable file on a DAX mount triggers this once an mmap write
fault has populated entries.

DAX entries track present pages, not evicted folios.  Count them as
cached and skip the workingset decode, mirroring the dax_mapping()
split in the invalidation paths in mm/truncate.c.  PMD-order entries
are counted as one page, as value entries carry no order information.

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 mm/filemap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index a1b2ca5b933c..caad0adde792 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4694,6 +4694,16 @@ static void filemap_cachestat(struct address_space *mapping,
 			void *shadow = (void *)folio;
 			bool workingset; /* not used */
 
+			/*
+			 * DAX exceptional entries track present pages, not
+			 * evicted folios.  They must not be decoded as
+			 * workingset shadows.
+			 */
+			if (dax_mapping(mapping)) {
+				cs->nr_cache += nr_pages;
+				goto resched;
+			}
+
 			cs->nr_evicted += nr_pages;
 
 #ifdef CONFIG_SWAP /* implies CONFIG_MMU */
-- 
2.53.0


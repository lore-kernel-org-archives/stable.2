Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA0A4499BC
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523992; cv=none; b=snwWqS4KRcmyZoFmRp15R/vNnM3Sq/miq1GHibHLIoeBSaCtpHSTGUO9xh5NU9MKO8GA6hoRMgUPy7LWnTtMNY7Z5V9Pm+HkXPpiJVCJ7TrJL1MVJfyoytyB0agGP+7e687DChhqzqPJ8hHduu+iyB31Ae3VLnd9hLEd4XSUyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523992; c=relaxed/simple;
	bh=zSqa9dihvimtXn9njMYRrxH2dkDZMEDepYBv7lPDxBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Idtf3lCd2Sj9LWk+SWdZN95DkQDhcXD9h+MAjrwnbxFmrf4udS1vSwf+R1vClcp5iTnjrQphbPe4D0V1aeUMGkCQY06GIwvZ1ea6T9C/fjI3m0P0P60wRGVk2LAxneAfictg/OxeIHGt5iILSfMLEVB3niAhb0ut4Pm8hxnbSXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj/3X5lB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj/3X5lB"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4843f205a5bso619008f8f.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788523989; x=1789128789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VePVaPZTkw+6DtNuaRA17uIRjgsuoVwzCjlWsl2fbEQ=;
        b=Kj/3X5lBHwXKzr2Nqg6QLCG7hb8pugCA5fXFJB4DYjn+kXlJE04L3D673pHnoYPy3p
         I3+jVZm1L+A/gFPKBE864+hafiIvmlpMbGY52FETYBERj6Jhw4tyTjqpMR2Kg9Svoy7s
         CxsMcGgKiCxzxx5RiTMD9EWGOFw69y9PdR7dFMQKioM+LNXM1N53lpwMeizfBmn0Dy1x
         1XvcK5pIQcdB7P8704awdxzMiLFwacWHFlj9YwsXV+XQnYPg0IvGxrej/3FI+G1TYeHc
         7Eh2y+gcHI0ZpujLtnm4CQQykahXWAHzWckpjzyoDBnums0dymgnNngIufCCQuTVX5IE
         yaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788523989; x=1789128789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VePVaPZTkw+6DtNuaRA17uIRjgsuoVwzCjlWsl2fbEQ=;
        b=J53YMFchfGPu8hgnyA0O6wjZqJdXvpwMAh20lfYQO9irTIflWDHEQx1myMbFTPo598
         X6wRdB/MuGrhPD0j8O/kw2fdaP9+oTQEgcIainvnWSPjTJJH6KeYJOf8Xz3wuVuuDVoY
         dk1h+FlZ3pCS5egL8oZxx+Z7aNkIS82XsseVwDl0VeZVfF07fVY4aG5wGU9OsrtMdLFt
         ZQ+mb4diqnvOz5nMbgt8D4EA0Z3J/XIjo0OOCX73ucADF7ZgVgqAMYZpUzxDihrl05ba
         yUSZZS8/uJF9Y+gF9fDhbOiz2PNj1y5clRHq9Pzt5IgEi7I0bZsBUCtqLSpDlVh9KYv+
         FBFA==
X-Forwarded-Encrypted: i=1; AKwUvBzA4x3KJfdbL4517xhkLNgXJnLK/WkQ1FdREbq23hRKJICN6IQzJ+NWVfts3UnV8mD53IYRVmc=@vger.kernel.org
X-Gm-Message-State: AFuF++mOYrzx6EXvHfEKCy+WHjn3wvaGdyP0vHcQpROEUZLkwXjLQbJJ
	jYp/sku28djWDfJw0TWtZgTcHqFVLPoY4GD20+r180qrpozq2sPT5AQ5
X-Gm-Gg: AYBFou3lgTyVDuD/KO7VdLGYZ691aKE7jAQK99QHG0F6xOKdC3GZ/8Ue5cTmcnsht9h
	1qq3ENwwMwVv/9fDi5sFXpwNTZxoqBAfqpYk/gGefsU2bpk1CWThKPT1NeKAF4ug4LzZ8tshzTo
	QLWlmnTzQ6E2zc6QUrIH2WdPimtFJOax5nkA58AAnea7dGk2PI6OWApxwRWRYPAh/Y5KDhuSDP1
	/mqAX5agHFVGMDcFXfXbM5e7E1Nrpa966uvvEWqSryHVthZT0qqTWYHFESW02PfbmrPZAt7x8Ys
	SPfkSdGRlOaYhjDii9XXfb0thTr5IlAlO1+/qLgfLYKtMhalrUXdo+Bm/WB4QytcHFnHnZywJB7
	vQrwLf2mLqIMrHQge6jY1hYVzM4uKsuNpAMy2N4r2jDX+fd5BjKOIrTrF2D/pNJ6CmR5O/0aW/E
	SQQCkgLUWTnLpX/+Mlgmjfve8ZzPhZzGTA6++MjYJSeQfphuLBFuKfceEZK+U0vm4rkMjCroU29
	anOte+f2LQ0iGUKWmHobeD26t8FIcsFoH2nHCUOjHcrVZkkFX1GNxudWlJH8HEkLeywdo64IZIg
	RA6CeSFeSW0l60P7VEGG0/7NIU5pAHhBAhGPsMoNJL03dDE0qm3yoHy634ry+nKp/E2lDdykUXc
	LFKLMR22sf7Bq9JrM5Fn+k3LgDp4h
X-Received: by 2002:a05:6000:1863:b0:482:e6b5:61c with SMTP id ffacd0b85a97d-48587098310mr8284636f8f.8.1788523988455;
        Fri, 04 Sep 2026 05:13:08 -0700 (PDT)
Received: from Ubuntu.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm6681622f8f.25.2026.09.04.05.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:13:08 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b72767277f29b6407083@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] xarray: fix index jumping backwards in xas_find()
Date: Fri,  4 Sep 2026 14:12:59 +0200
Message-ID: <20260904121301.200049-1-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <app_o87YogZExbwm@kernel.org>
References: <2992424b-2120-489e-9010-f45f46ed52c8@mail.kernel.org> <20260903112251.6114f91af953412d2355e5b3@linux-foundation.org> <app_o87YogZExbwm@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bug in the XArray iterator xas_find() causes the iterator's index
(xas->xa_index) to jump backwards when iterating over a multi-index entry
(like a THP) that resides in a non-leaf node and is concurrently split.

When iterating over a multi-index entry in a non-leaf node, xas_load() sets
xas->xa_offset to the base offset of the entry, but leaves xas->xa_index at
the requested index. When the caller subsequently wants to advance to the
next entry, xas_find() is called. xas_find() attempts to synchronize
xas->xa_offset with xas->xa_index before advancing. However, the fixup
logic was incorrectly restricted to leaf nodes (!xas->xa_node->shift).
Because the THP resides in a non-leaf node, the fixup is skipped.

As a result, xas_find() simply increments xas->xa_offset and recalculates
xas->xa_index based on this new offset. This causes xas->xa_index to jump
backwards. If the THP was concurrently split, the entry at the new offset
is a node pointer, so xas_find() descends into it and returns the folio at
the backwards index. The caller (filemap_map_pages()) then calculates the
PTE pointer based on this backwards index, resulting in an invalid memory
access such as an out-of-bounds read or use-after-free on a page-table page
freed via tlb_remove_table_rcu().

A userspace access that faults in a file-backed mapping can trigger this
path. When the index moves backwards, filemap_map_pages() can calculate a
PTE outside the page locked for fault-around and dereference a freed
page-table page, resulting in a KASAN-detected use-after-free read.

To fix this, check if xas->xa_offset matches get_offset(xas->xa_index,
xas->xa_node). If it does not and the node is a non-leaf node, set
xas->xa_offset to get_offset(xas->xa_index, xas->xa_node) before advancing.
Also add test cases in test_xarray to verify xas_find() behavior when
iterating over and splitting multi-index entries.

Fixes: b803b42823d0 ("xarray: Add XArray iterators")
Cc: <stable@vger.kernel.org>
Assisted-by: Gemini:gemini-3.7-flash syzbot
Reported-by: syzbot+b72767277f29b6407083@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b72767277f29b6407083
Link: https://syzkaller.appspot.com/ai_job?id=a01c56bd-74d0-411c-afb4-ee6f0cb6cb61
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
Changes in v2:
- Derive the regression-test geometry from XA_CHUNK_SHIFT so it works with
  both the userspace harness (SHIFT=3) and the kernel (SHIFT=6).
- Check the xas_split_alloc() result before calling xas_split().
- Describe the userspace-triggered use-after-free and add the stable Cc.

v1: https://lore.kernel.org/all/2992424b-2120-489e-9010-f45f46ed52c8@mail.kernel.org/

Tests:
- Applied with git am to linux-mm commit b0266eddcb10 (the base of the
  reported CI run).
- Ubuntu 24.04 x86_64 mm-ci host tests: memblock, VMA, Maple tree, XArray,
  Radix tree and IDA, Multiorder XArray, and IDR all passed.
- Userspace XArray tests with ASan/UBSan passed for SHIFT=3 and SHIFT=6.
- The built-in XArray test suite passed under generic KASAN.

 lib/test_xarray.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c      |  8 ++++--
 2 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 5ca0aefee9aa..615f7730a5bd 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1247,6 +1247,75 @@ static noinline void check_multi_find_3(struct xarray *xa)
 	}
 }
 
+static noinline void check_multi_find_4(struct xarray *xa)
+{
+#ifdef CONFIG_XARRAY_MULTI
+	unsigned int order = XA_CHUNK_SHIFT + 1;
+	unsigned long next = 1UL << order;
+	unsigned long start = next - 1;
+	XA_STATE(xas, xa, start);
+	XA_STATE_ORDER(split, xa, 0, 0);
+	void *entry;
+	unsigned long i;
+
+	/* Multi-index entry in two slots of a non-leaf node. */
+	xa_store_order(xa, 0, order, xa_mk_index(0), GFP_KERNEL);
+	XA_BUG_ON(xa, xa_store_index(xa, next, GFP_KERNEL) != NULL);
+
+	rcu_read_lock();
+	entry = xas_find(&xas, ULONG_MAX);
+	XA_BUG_ON(xa, entry != xa_mk_index(0));
+	XA_BUG_ON(xa, xas.xa_index != start);
+
+	entry = xas_find(&xas, ULONG_MAX);
+	XA_BUG_ON(xa, entry != xa_mk_index(next));
+	XA_BUG_ON(xa, xas.xa_index != next);
+
+	entry = xas_find(&xas, ULONG_MAX);
+	XA_BUG_ON(xa, entry != NULL);
+	rcu_read_unlock();
+
+	xa_erase_index(xa, next);
+	xa_erase_index(xa, 0);
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	/* Split the multi-index entry after a lookup begins inside it. */
+	xa_store_order(xa, 0, order, xa_mk_index(0), GFP_KERNEL);
+	XA_BUG_ON(xa, xa_store_index(xa, next, GFP_KERNEL) != NULL);
+
+	xas_set(&xas, start);
+	rcu_read_lock();
+	entry = xas_find(&xas, ULONG_MAX);
+	XA_BUG_ON(xa, entry != xa_mk_index(0));
+	XA_BUG_ON(xa, xas.xa_index != start);
+	rcu_read_unlock();
+
+	xas_split_alloc(&split, xa_mk_index(0), order, GFP_KERNEL);
+	if (xas_error(&split)) {
+		XA_BUG_ON(xa, true);
+		goto out;
+	}
+	xas_lock(&split);
+	xas_split(&split, xa_mk_index(0), order);
+	for (i = 0; i < next; i++)
+		__xa_store(xa, i, xa_mk_index(i), 0);
+	xas_unlock(&split);
+
+	rcu_read_lock();
+	entry = xas_find(&xas, ULONG_MAX);
+	XA_BUG_ON(xa, entry != xa_mk_index(next));
+	XA_BUG_ON(xa, xas.xa_index != next);
+
+	entry = xas_find(&xas, ULONG_MAX);
+	XA_BUG_ON(xa, entry != NULL);
+	rcu_read_unlock();
+
+out:
+	xa_destroy(xa);
+	XA_BUG_ON(xa, !xa_empty(xa));
+#endif
+}
+
 static noinline void check_find_1(struct xarray *xa)
 {
 	unsigned long i, j, k;
@@ -1370,6 +1439,7 @@ static noinline void check_find(struct xarray *xa)
 		check_multi_find_1(xa, i);
 	check_multi_find_2(xa);
 	check_multi_find_3(xa);
+	check_multi_find_4(xa);
 }
 
 /* See find_swap_entry() in mm/shmem.c */
diff --git a/lib/xarray.c b/lib/xarray.c
index 9a8b4916540c..980324d686bd 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1406,9 +1406,11 @@ void *xas_find(struct xa_state *xas, unsigned long max)
 		entry = xas_load(xas);
 		if (entry || xas_not_node(xas->xa_node))
 			return entry;
-	} else if (!xas->xa_node->shift &&
-		    xas->xa_offset != (xas->xa_index & XA_CHUNK_MASK)) {
-		xas->xa_offset = ((xas->xa_index - 1) & XA_CHUNK_MASK) + 1;
+	} else if (xas->xa_offset != get_offset(xas->xa_index, xas->xa_node)) {
+		if (!xas->xa_node->shift)
+			xas->xa_offset = ((xas->xa_index - 1) & XA_CHUNK_MASK) + 1;
+		else
+			xas->xa_offset = get_offset(xas->xa_index, xas->xa_node);
 	}
 
 	xas_next_offset(xas);

base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.53.0

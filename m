Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C9442AF8C
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380206; cv=none; b=N1D3cihYewEwPf0ZuCMkE8Frk9B1v7H1UvfJe6xH+lZWw33BfxsL95VTa5tQ6VmoEo0rWKNHunbRsIERRpXfjOqnjW64vz0I+m4nKeu+7Cg1F7YnF4IB79L0qVWAF+nCaQqNRKx+xaXRM2iEoHr9evA/a9hWPYgaCX1NV0Sr31k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380206; c=relaxed/simple;
	bh=c4fSmyNB4m5oQ8lZfExUsQGukvI1B3sAmLc9u8/mj5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nieu5YCODTSk9iXKh4bcKaQqJtIei/zBLCYxZQojZIZZ6dC7o+La2Btu2ML2q6Rg4SAiLzObgQRC/t5Du72nCt/TjCjvPzcQCbbPGTLhjrUjd3/6hQ6PHuW19Dl2BaktEKuj5J3jcPC21IKuF91Zmzjx0POUCmlA6+tKjAWYCok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peridio.com; spf=pass smtp.mailfrom=peridio.com; dkim=pass (2048-bit key) header.d=peridio.com header.i=@peridio.com header.b=w+WbApYe; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peridio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peridio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peridio.com header.i=@peridio.com header.b="w+WbApYe"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-73d809c9b63so57266137.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=peridio.com; s=google; t=1786380204; x=1786985004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGxAii+GkeS62oW/NXkupU8ykf66W6U2MtKUhTFewv4=;
        b=w+WbApYee2JVL3BDvw+cAmS5dYbL5IY5mKFDHHJNvNtr7340ugFW4ElG9fD5Bk54Hg
         uE6r37hzhUX/Ob8r5FJ3HbdLoY2LW1NecBF7kt3dOm0MkBYJieqF7DMYst2tVn4cnpIK
         NbhEKRURpQZn5XfY9XypZvt2k7X+wIcd+B5ZhpvM0EgF7f6C3A5fBX5OVD83E3NX4Z0E
         p32slj20OL0D+YrlfDjIiK2h4UH0SIJ4l1neCLyj+9c1nVj+TY6G/OPB+bhw/9zgOcfu
         JO4wMkrd1oRa4Bsf3A+S18azyg12uPnkj5ytIy7ORLrRHahanRGfSobBbt90ZSnvJ4LE
         kAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380204; x=1786985004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xGxAii+GkeS62oW/NXkupU8ykf66W6U2MtKUhTFewv4=;
        b=do9yrrqO5DQCFyjzb/3N/kMbdXWJOqh1yu+KzFIIUQsX84u/zG18yBU1ifHubL/eW7
         ldR+atSom0zSEvtd1tXAlUyHthcz/MT8codXFRqvEJnTRHfH55ACiTwKt2fdj1YYovAX
         y1/cIw15oo1ououZWBEjbOOOgs/mFtyRNogyFtW1yadmFUaMVU3lLatvkjnvWwIPrB2p
         JT0tERJ8BvYVkyOQxyDMSbFgQ68WYj3DvwbE57fKjdnmGnseGCr2aS/LMTPPsU2/18UU
         uT7FGb/FAx1StBMgJhCD48nShswuXPxxMZf4u/wH0gsQ58nPqfuT3o8T/z8xEGb7dJO+
         BDqA==
X-Forwarded-Encrypted: i=1; AHgh+RrfcdKrhhP0PKZ+r5hMpeMers0oJbL+F2rtH1Fwk7TuIGJaC8jQugFTIXInSmRRo88TSsoLp2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqBn37loih140mmQ7FvqDDBEu/vJYIent95XJTDAIcrzu3a3MY
	fe+0hc2AEfFm0I+44W6EaElLrE4SbTCune7c/GGfkOUSFZbRl8b2I8K6/blynst3Dnk=
X-Gm-Gg: AR+sD13un7DIwD2n/7inSKWDeQ/hW9HFvf1GtmOPHCfI0N041sukvM/HWIIv5tLLvu7
	FxXpbqrv0HlykNsYnyiR8GyNWTv//YCAyZ+ZbMgHhJBu/VmuiMGGfV7cLFfNw1mqHRuCGXgw+/f
	1OmR7oEexlKeLuSztgjHGR6e9X1eQdfTby1Kta9urymtsyQZf5wLK+mrJ0vyyLHcHIos7PqNzuH
	oHRazOw/+GU8FXksTnlFZ3fUCRtQhZH+sJEJq+FAgovcjJLjrDQ188nMjZWGS6OJenF6qHKD6XC
	QWwWID7NrbyUR5fGhHqTxrscYvz632zV7VCPGUn2P0pJCcW4Rm6u/LG8VxWjMDarcG3UmQRyg5B
	Vv/eLCB0iA41Qum02G46c1vQlBv6KJVyFMjHF4VqNPGlpRPxvmobBAoMI8n6dS1cOoOr2P8N2fY
	Vce4Cioxqb9gxGYoKABVwvgQCCEvS6wEHCsP/64ZmPEHIgskfNBHyOS+ifmKEU7Bzl
X-Received: by 2002:a05:6102:3ed6:b0:738:9abd:9ebc with SMTP id ada2fe7eead31-760e79e969amr6371775137.0.1786380203875;
        Mon, 10 Aug 2026 09:43:23 -0700 (PDT)
Received: from localhost ([190.113.101.40])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-979ffbdd8besm2934121241.2.2026.08.10.09.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:43:23 -0700 (PDT)
Sender: Javier Tia <j.tia@peridio.com>
From: Javier Tia <javier@peridio.com>
X-Google-Original-From: Javier Tia <floss@jetm.me>
To: Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 5/6] xfs: initialise args->total for parent pointer updates
Date: Mon, 10 Aug 2026 10:43:18 -0600
Message-ID: <20260810164312.960721-13-floss@jetm.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810164312.960721-8-floss@jetm.me>
References: <20260808234016.246054-7-floss@jetm.me>
 <20260810164312.960721-8-floss@jetm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2476; i=floss@jetm.me; h=from:subject; bh=c4fSmyNB4m5oQ8lZfExUsQGukvI1B3sAmLc9u8/mj5U=; b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBqef+hRIGiF74Jb6/aVidlMF/bNycp0hpb4sogI TuDxy05+peJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCann/oQAKCRC17sMLqGd3 HzF+DACSYpq5TFDCIpcKCPZrDIPpswdfRaDz72dOdUR0qFUfFSm6ke93hu1jeluazL5nTIe9PNF ZPyJfNxNBSw2ECWhd7qdY4TRBooGXvKPvJtLH4M3V24m17NE6CRRPgwfFWxw62xCRVHOAIO61CO YnwTGe0AFpoJtPIJVGM5Gn19FVWEdf1d1HGXCN0StGVStKlGoHC6GLjnTZjx67Z6d2APLI3JjCM 3bXfgTOR8ou/qleyn15ey/0hNkABgIBvuQAZbO4nD0JBKsUNjAAW90f4xBtCKi3jfhNdZh9j4m1 fupLiN5V6qwb9gRZ5U8D4qoVmhz/TITUu0kRCKeqWhyHrbN2v8IQo0JP7imyGHNngiuIn6pmNB3 Y1LdECJSvj0CvOmvrOO8Lx6HAEFIOIvfWGaomaZGRNTmOVeEC1EOY9NLtF3TyKW/XYoiRUJ1DCF PAkyQx5WDlLEWoAHt9PvtpsVBsha58N2bRCWxRLNCWx831oEHZDIQxzs2jZZc5v+U1Z7s=
X-Developer-Key: i=floss@jetm.me; a=openpgp; fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
Content-Transfer-Encoding: 8bit

xfs_parent_da_args_init() builds an xfs_da_args from a zeroed
xfs_parent_args (kmem_cache_zalloc), leaving args->total == 0.
xfs_da_grow_inode_int() treats that field as a running block reservation
and subtracts from it; because it is an xfs_extlen_t (uint32_t), the
first attr-fork growth wraps it to ~0U.  That defeats the free-space
check in xfs_alloc_space_available(), and when it coincides with an AG
that has exactly zero available blocks the allocation is clamped to
maxlen 0 and returns -ENOSPC, which xfs_defer_finish_noroll() escalates
to a filesystem shutdown.

Set args->total the way the log recovery path does
(xfs_attri_recover_work(), xfs_attr_item.c:706), in the add and replace
paths that can grow the fork.  Removals and lookups never grow it, so
they leave the field alone, matching that switch.

Fixes: b7c62d90c12c ("xfs: parent pointer attribute creation")
Cc: <stable@vger.kernel.org> # v6.10
Signed-off-by: Javier Tia <floss@jetm.me>
---
 fs/xfs/libxfs/xfs_parent.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_parent.c b/fs/xfs/libxfs/xfs_parent.c
index 3509cc4b2175..312f33086d53 100644
--- a/fs/xfs/libxfs/xfs_parent.c
+++ b/fs/xfs/libxfs/xfs_parent.c
@@ -194,7 +194,7 @@ xfs_parent_addname(
 	const struct xfs_name	*parent_name,
 	struct xfs_inode	*child)
 {
-	int			error;
+	int			error, local;
 
 	error = xfs_parent_iread_extents(tp, child);
 	if (error)
@@ -204,6 +204,10 @@ xfs_parent_addname(
 	xfs_parent_da_args_init(&ppargs->args, tp, &ppargs->rec, child,
 			child->i_ino, parent_name);
 
+	/* Growing the attr fork needs a real reservation in args->total. */
+	ppargs->args.total = xfs_attr_calc_size(&ppargs->args, &local);
+	ASSERT(local);
+
 	return xfs_attr_setname(&ppargs->args, 0);
 }
 
@@ -240,7 +244,7 @@ xfs_parent_replacename(
 	const struct xfs_name	*new_name,
 	struct xfs_inode	*child)
 {
-	int			error;
+	int			error, local;
 
 	error = xfs_parent_iread_extents(tp, child);
 	if (error)
@@ -250,6 +254,10 @@ xfs_parent_replacename(
 	xfs_parent_da_args_init(&ppargs->args, tp, &ppargs->rec, child,
 			child->i_ino, old_name);
 
+	/* Growing the attr fork needs a real reservation in args->total. */
+	ppargs->args.total = xfs_attr_calc_size(&ppargs->args, &local);
+	ASSERT(local);
+
 	xfs_inode_to_parent_rec(&ppargs->new_rec, new_dp);
 
 	ppargs->args.new_name = new_name->name;
-- 
Javier Tia


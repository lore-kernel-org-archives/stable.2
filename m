Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD53EF67D
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786403199; cv=none; b=ot/NCSZ85bjvBV2GvvAWw+bTIOUiy1SZZuB0WNaU8g/sY8cXXte1ukdYGixL1/9hM2J5LDFtqyGtKJMFsVDdXdISe3Mh5Gqv/JubPTIVY/ed/Pwx5npjMXBZeuQKqYT5BN78ACQY/KcTbe6gKWPlYml316zpTJVl+7M5Fb27LeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786403199; c=relaxed/simple;
	bh=IzuppipK1dEFr99+pMsDknXhyhKbvUSEG1CYeDnWIwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G99F51/8208DsILkI26PdZvdmLCkFBnDhS8L8TXT7HL0I3JMdcZvGU4V4SVyIwr7bfJs7I2cgO9EeUFDCI/19SwVBs7tlnPFx/SqvwTB8oCpS3CWH3fEJYCryT2wqPsfODaX0UH7bHmG9LOOemB8uu6AD13MgkE9RrHNAGbLmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peridio.com; spf=pass smtp.mailfrom=peridio.com; dkim=pass (2048-bit key) header.d=peridio.com header.i=@peridio.com header.b=vP5BD8uS; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peridio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peridio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peridio.com header.i=@peridio.com header.b="vP5BD8uS"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-972f2ea069eso83291241.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 16:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=peridio.com; s=google; t=1786403186; x=1787007986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uSGSDxy2zUMBEFhOX3vJ37AYVV3JHVveLhDFnDI+8Zg=;
        b=vP5BD8uS6qVjAvKCrioVvJjghzs6fYvP57ZscTusOP/oT3fFxhhXmKQ+Zuy/jYIdxg
         ytosKp5VLWuMCZe6p9Xh/ZVE9MIZmuoCZceJXwVPLl3ixy+VkwJVZd7y3Bs/oMiGjA4T
         IUGHhCQYrtri+5yiyzwgXvGY+HIvAX0nS1WVMiKrEwu556jtkLUwuv66GJDH0E8POwb1
         YE4q2uX8PJF61smdTiLOmuiYf8pIz3pYhY4jsgyEJGLZgLHmuv8jlnEFAosyUcdsTFEU
         FexCBporiqGTga5/5n6skp5k14P8k3CO8+u0VwL13WtSYVLcFnR5eiLFcw5Qss2qHPeF
         uFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786403186; x=1787007986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uSGSDxy2zUMBEFhOX3vJ37AYVV3JHVveLhDFnDI+8Zg=;
        b=DHbLMILaAbuoV+OYVNKA6itIEElVq3H3KrdRwK7IL8kuMxHnYeIL1Gs8agItdGJn+O
         69iUHscLNygqcLn2TsJnqGsiVVh6WfQP92DjrRdhxXfbQ1VbdEw6V7zpuAEAVDSJgbww
         4RJWUZ3Xl+kG1lZxR2VETs/MWhY8BDmT1QWk73MlBvNtiYFrV73LUSUZV9hI3GHztJLO
         GwSRXYWzlTZvq3n1q4q3QtTO+maj0HRDg/aIuHF2qM/sHEXM/jdVpowvEIXhC1dXceaF
         pmkm76jthvNCF0iWPj5DwldszAZ+cI8ckupTmIiLz0YjdYzgci2DkGlxsZLGpxXxURzU
         f4SQ==
X-Forwarded-Encrypted: i=1; AHgh+RozCQ740E2nnBgjBC3dvVkjyP+0n9fVOA4PgnJzjCHqxSuQRrXEqYGuGD7lkGA2DTgg329WAPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQLfqrmbHG689jlcOTiPvWk+V+0ge+A8nr568BUKaGeAmbgGm
	hHxKnTyPvxHnUMOFcHRPFRQrexLY96oa5ehIeXcRNgROjtNjD70KVhHUSieSKH8dqeo=
X-Gm-Gg: AR+sD102Wfx2YsrF5X+TMLUUjrjaB5Qs2Nero4mhfzlNhVVyHxPxtAAHjtA3U3KRvdL
	GCHs09If7UtAbQNWmiF20++UwGfHoR1xit6jzoV4nrudCZO9/iZlV9veOtfPo5Ueb2kSelLWGET
	X3Eg66iG6XwtjDX1oISfoMg9d72T60ZEMMQKzsyF21UgdQD7/L6iN+WZI8Dwd/PA2UntsiDIySP
	LgIpN2V4u7ZZvg6w6LI7RDczGTHyybr0z50GGj8wdAuJNBIZD3VBQjzpJHO/5qBquZhuDwW98i7
	OKtFQwQrvuhE1XiKmOv0x4xofbonNyVGJVFq4NWLMXWfO3iAMzzRLlAbqR1OgCywe0d7F6tV2nx
	DlL49N6JuafL3xF8gdYkAxWQcI8JUQoEeHJVFbqIJnTD8iPNtj4e4d67etqBXquDAq+A8JYkUmO
	39jrN0dPPvC3vaV2DiZupA6uOpxZW4K6YlX9rPP2jsdxNLN4lXil/qmVE=
X-Received: by 2002:a05:6102:3e84:b0:74c:551:54d2 with SMTP id ada2fe7eead31-760eb45605dmr6973438137.4.1786403185824;
        Mon, 10 Aug 2026 16:06:25 -0700 (PDT)
Received: from localhost ([190.113.101.40])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-76400dfe036sm5284342137.8.2026.08.10.16.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 16:06:25 -0700 (PDT)
Sender: Javier Tia <j.tia@peridio.com>
From: Javier Tia <javier@peridio.com>
X-Google-Original-From: Javier Tia <floss@jetm.me>
To: Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Allison Henderson <achender@kernel.org>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 5/6] xfs: initialise args->total for parent pointer updates
Date: Mon, 10 Aug 2026 17:06:17 -0600
Message-ID: <20260810230611.2859909-13-floss@jetm.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810230611.2859909-8-floss@jetm.me>
References: <20260810230611.2859909-8-floss@jetm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2528; i=floss@jetm.me; h=from:subject; bh=IzuppipK1dEFr99+pMsDknXhyhKbvUSEG1CYeDnWIwY=; b=kA0DAAoBte7DC6hndx8ByyZiAGp6WWOjlAjLdfWNwJr5dSRkdWEVI7PiFkDsDAdhGLXRGXpTc IkBswQAAQoAHRYhBJsTsgvPDt4jRUqTybXuwwuoZ3cfBQJqelljAAoJELXuwwuoZ3cfko8L/R3Z o++3z2kqlMstgJp+Ec++0Y7iqhb1w2c9ZmdbKVWnZ9D9kWzHFj2m2F8hEbKPq8eT5NfqHC5NYhf EFA4aTZKN+Tq6I/yr9cba3d6AMxCAIv8fVUuPsRxYBx4AIN2hPOccIX02rGCkGHz/GrdZ3RVJkD D7FGjoGSNqiPApdMJ7wXoaZAS4fFi97zLcECIPIklvwzODqEN9fSlz7j7FvjH7eeYkxw0hw47FI sjX86gS7nAeC0Y7MyGgU6CRu9g3E3a90TMq2sdO4r7nzKdVlAxE4rTW9RJUz7D8x2XFo2WmuCB3 qli9e0sGKDkCnCzRHaS9Q7OoQLdSFbOLSdGMUw2zsOlfXyoPYZbRvFU2vLdFbJO17+p9T2yCIa3 gq3Ufr67312unu33K+qau5EvClnyxTGgNtmLUoJKzqf30b4bbZJpAla/OBVhxm4XrsYPLO0dPUk eOjqgLMXbkI1SCadeEbL22MtYRJ2bbN96iesG8iOvgRwBuBM0YbJ4yYY91iw==
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
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


Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9FB37E5FF
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786232426; cv=none; b=X2IOYqKPPV8JjHs/K3RtOghYSheWJQQPoap+KlYsryvIVMXSqN+B+epuExajjVmszXKy4iFMzYXvWc/ti3u4tAGzw22kn2twOBhardyYnF4z4egmpZunRiN1+gXzAa0Z7/e2XH7aWMzoooNZSydcKgsLeM2yImBtcSQL9glQzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786232426; c=relaxed/simple;
	bh=eywyJoxeJiPzUZHoEDNCnRq967Hjwuh00+xW9hxuF8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RglzeqWMvqa7iN7GtDXdMC89C8jcgUQMnKy4h7ouErjby17nmnU68idy1VmJdf69Tab8rNrDhPp2lijhw+WJq+ylXsss1CPNgXW01m9kLGd/56DIoxo4tFH7PTySGGClq6uYhRny3foVyPvNBEaASJk4aMVcy5zLhMWclwXQ9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peridio.com; spf=pass smtp.mailfrom=peridio.com; dkim=pass (2048-bit key) header.d=peridio.com header.i=@peridio.com header.b=yfogSeAT; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peridio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peridio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peridio.com header.i=@peridio.com header.b="yfogSeAT"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bfdb047c1eso16337e0c.2
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 16:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=peridio.com; s=google; t=1786232423; x=1786837223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0zdhFckn2ilRT1BqFxb8uQ/4LTj7nukbKKF9CpzD5YQ=;
        b=yfogSeATdAJnlHy0rT1dFX9cdX6ubyfo3TJIgqAyQhmpZbN7RhxSYZSX/oHKVdgZuM
         aN7ggig2SWFWBH3cVamEt8lLcqwVRYNCrl89w4gKGS5eo1VMDx3rWj8AnBimqlXBJFyf
         pajjWD5w3byhgnqFzhMm/4nMpT4IsHzNZ3m+w3Ihvc1R9bX0XNEsSJyqxO96QmgBh63y
         7creSr/B0pcaSH/qlhN1lywsEh5gcwTiOn8sUul5lH1ySXNufARJa/Xz0Xgbdw0B4Pjz
         0nlAi0H2mvGP5tvi1Utl5KK39P1EUPXw02jnv8MVA/RZf0iH56C0Cg01zRJyMGB3CDhP
         BNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786232423; x=1786837223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0zdhFckn2ilRT1BqFxb8uQ/4LTj7nukbKKF9CpzD5YQ=;
        b=nqJb/CNdQfOuGgzb1dGo7JvJE0V7/dfhOo3AfhsNGDIlkdCloAakRsoLEnTAoON2d0
         mElX/2zIvYAVfRz+3R/8LIuMuQK+CyMp5C0B9EhRhfMgu1fQCSNmm+Kcxg+ecb/xXGrQ
         V5RZ9UJXIXVYfrOep41EFu3bS77nC0c38QRfZ+2BJWLH6gYI/viOeXyMoR0ef6NRWa/r
         G3huZmobIntLK0UNZb82yJkF/jPnGEIB/6kW2hGO8llRiWJ3aeEc9L353nK0ab8HaDBu
         GwJNDdwUU16RzL9O6/LfSbjYWGVZWESc2aEw247j9YRZix0CGUWnEItGGWbWMMsPYesA
         q6Sw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4wJNfveJCN+iWIQhk5LBvmVTlxEAZGpdk4QSrQ/UsWQKZ8Mm+Jc2oSzdA2fPoZUO/9XyNQjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNYrKO5QqG2JSZ6zEJ+04YEdXiwkKMdNTLVBYgwt8eEydQlsdO
	qtyyP+XwPbg7XKz8ZBvC5NUWPRfPNIIQcFzcymjbytRbOCE7gDO1mneTtt+BetojBZY=
X-Gm-Gg: AR+sD12cYVaWo+npL7a+2cu0eOyyTXRGOqDjL/z6dNU2eJFAQoFOlMjDvEVTDxroNuX
	B4cBOy5D8/5eDJVklgl6brHbY6rXs+39kGdCmIcUI+lgRmytFGck5i+baLgYVxm4H+Hs5GkLGDI
	axi+Wt4tkfwG9qZ2ZrB5vL2DdRJ6u7snoizjnN3wsFe+oa2XcDcd/16yCTMKwQFnTBIDOar6FaH
	/Aj5w11QMd/PSNO2g1/QsLwcUfZZvtIVp5N766tJwAxJe+U1QjMK3wYwjkSyjFZ1FpV2XqdClQB
	jnX8tzzdDH2SO7lmeZMq8eISusD+i8CefQZqaK+bxcGqlAb7lD2mu8B5Ct0b4oXdVLNjBECcMPR
	sQSBNwAfBrY9pS34uQ/Erlg6npSb0tD+6go3d1PauW06Q+aOTwMMcSShqL+B7q5MZNQbP+yFvHq
	yfD1qG76Y1lcEThcYm/PQNyN1O1qfyP9W+82HMAeXbpUiMTbUmWCXaqi0=
X-Received: by 2002:a05:6102:b0b:b0:633:3bf6:977c with SMTP id ada2fe7eead31-760e5cbd79dmr4739370137.1.1786232423622;
        Sat, 08 Aug 2026 16:40:23 -0700 (PDT)
Received: from localhost ([190.113.101.40])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-979f2e53fb5sm2083603241.1.2026.08.08.16.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 16:40:22 -0700 (PDT)
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
Subject: [PATCH 1/5] xfs: initialise error in xfs_defer_finish_one()
Date: Sat,  8 Aug 2026 17:40:18 -0600
Message-ID: <20260808234016.246054-8-floss@jetm.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260808234016.246054-7-floss@jetm.me>
References: <20260808234016.246054-7-floss@jetm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2877; i=floss@jetm.me; h=from:subject; bh=eywyJoxeJiPzUZHoEDNCnRq967Hjwuh00+xW9hxuF8A=; b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBqd75gWnthqa0dZDU1DdMYG7SucNZ1t7qzbjI67 QP0Mb4aZVyJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCane+YAAKCRC17sMLqGd3 H9vrC/9jM099GVI/qnPe0VN8QrvIS7TxociIcdYmg/ixa9M3Z9arGeKrhQzc/8399hLqAHoy9+x ZAAZH238MBkwf2gJod3cWLc6xjfnKPkLmrdxyGpPcCio4TQmTQA2D5X3JaA/FsaulrNFjTQMjCh h6ZNctMc4bTwFUWf1TrbIhFW9UQhfSg/uk0C7Oz4gDNYx7FBa2zYKd8Ig+5JU1pAycxW0md1ZZf 2+5YAjXQqJXwwOBzawM6HJrfCWjMSzlZJ1rEU9HR+Hao/eo0/KUUmiYdcAEZirGz9EcUC2Dv69g VVwDmKslMmUrc6O3aKo2oZczzkUNyQOTlUEtvEANkpHeRjaio/mziIsJiQfcmTsdKoleBwnvRzp 8km0eGqR6tTG84EU7VWK4xiKmpRSfPx2eE84IarWtVDeUMhsyKXjNtxESZcddZFK9yCFpsG7IGx Yk9vT3DDVoZzRCZaLf+t3O9RPpBMbEqaI3Axhid5gS3br6mkg3cR5pOcXmdAzuRmQDt84=
X-Developer-Key: i=floss@jetm.me; a=openpgp; fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
Content-Transfer-Encoding: 8bit

xfs_defer_finish_one() declares error without an initialiser and only
assigns it inside the loop over dfp->dfp_work.  When that list is empty
the loop body never runs, control falls through to the "Done with the
dfp, free it" path, and the function returns an indeterminate value.

An item-less pending item is not hypothetical.  Of the three
xfs_defer_alloc() callers, xfs_defer_add() always follows with
xfs_defer_add_item(), but the other two do not.
xfs_defer_start_recovery() is harmless because it adds to a
caller-supplied r_dfops list rather than to tp->t_dfops, so its items
never enter this path at all, and they are driven by
xfs_defer_finish_recovery() and ops->recover_work() rather than by
xfs_defer_finish_one().  xfs_defer_add_barrier() is neither:
xfs_defer_create_intents() walks tp->t_dfops without filtering
item-less entries, so a barrier is spliced onto the pending list and is
eligible to be picked by xfs_defer_finish_noroll().
xfs_reap_ag_blocks() adds one every other extent, so online repair
reaches this on any filesystem built with CONFIG_XFS_ONLINE_REPAIR.

The consequence is a filesystem shutdown that depends on stack
contents.  xfs_defer_finish_noroll() treats any non--EAGAIN return as
fatal and calls xfs_force_shutdown(SHUTDOWN_CORRUPT_INCORE), so
whenever the uninitialised value happens to be non-zero a successful
barrier is reported as in-core corruption and the filesystem is taken
down in the middle of a repair.  ops->finish_cleanup() also receives
the same value where an op type provides one, though no op type that
can reach the empty-list path defines one.

Returning zero is the correct result rather than a papered-over error,
and not only because the barrier type deliberately has no work items:
reaching the free path at all means the item loop drained without a
non-zero error, so zero is the truthful value for any op type.

The uninitialised declaration is older than the Fixes: commit below,
but that commit is where the bug became reachable - it added
xfs_defer_add_barrier(), the barrier op type and the only caller of it
in one go, and before it no item-less pending item could exist.

Fixes: 3f3cec031099 ("xfs: force small EFIs for reaping btree extents")
Cc: <stable@vger.kernel.org>
Signed-off-by: Javier Tia <floss@jetm.me>
---
 fs/xfs/libxfs/xfs_defer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index 89501e8bd2f8..843c33304441 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -583,7 +583,7 @@ xfs_defer_finish_one(
 	const struct xfs_defer_op_type	*ops = dfp->dfp_ops;
 	struct xfs_btree_cur		*state = NULL;
 	struct list_head		*li, *n;
-	int				error;
+	int				error = 0;
 
 	trace_xfs_defer_pending_finish(tp->t_mountp, dfp);
 
-- 
Javier Tia


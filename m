Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA594FC8C3
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075086; cv=none; b=bEUa17m2EhD7yvWzMLTZ1DbCgyCUjoOR39UqltFg3yBdkpsJMwwVbiqc1zY7wNABFJuTL5kDi034H9b0CNfdiEQW+Rd8hc5mnotxCho7Q4x1hjNTDj4z5vtDK2WAiO5AqThWSOsxavtKVz2zLKz7ljnKCpDVcc+nIv4Kyz0Fsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075086; c=relaxed/simple;
	bh=il6FDGKCGQ3ltGODPhMBRswkBHRyGXjwl/hLnyywj6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDJUEzLXsUHk3stPGk+kOcvS/AnyY3AwE0rDmzP8wDsdp3L/aqyGRtYttswKim8cDEWEA2H7Vu2iWqVFnK6WEc9STPVzNZOE5eFflPJQw7UVVLfCq6CHK4cE2FF2uWlBe0U7UHuugHR1JPTw53CBufh/mDn4ExVtP1UTefuE08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSHzXkKZ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSHzXkKZ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so29923535e9.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075083; x=1790679883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJrfhcf5/3HcyaGlirHsZFpoVVhbQLF/RDLKqw4E1Qs=;
        b=aSHzXkKZCauvrszWiKN/lKj9eglOaqPF0HMH1SxfOPzXmQqMiT0JbJrFnrVPY0z+wp
         voa1QYoImM7WpCwjyHQULB7LGRvBvrzqpY1fP68y+489F7QBmFY+LeHresU5HyuNoM5C
         uScgHUKZn/y0QjL9GPbnAslUMo/dKrxT5W+A80E82osoRhM+8aYv40/vI2tqtBvTUCke
         DnXD5OhtzXRBNsYPE6GfZ1og/puBAzD5+V1FlDaJAQ1+5f3wtSq1uUJgehzmN8xI8m04
         v27FxAQ1C0CwCtL6AuGmUBUKw6r21mA8iAgXVxz/NlQkjjfYwM9wZd4NEtEs9UYZ8Cs8
         b7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075083; x=1790679883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HJrfhcf5/3HcyaGlirHsZFpoVVhbQLF/RDLKqw4E1Qs=;
        b=k6bKGMhGK9ObqBE+xGWkXSGEEv6JyC22Tw+FDjVAJzYkJMxclLCKbr4A3yYR8oQKMU
         Yhg4sAkRAb+yZ4wpdnuen5izLXXVdXZoR3Wff9l2X0BpGlIoVpWlmIjDdSww4Y9EU67W
         M3sWrCuSH5kua7zebOWiJnR2J9fi21R2tEad+VbS3eIY6P7kSTBI+dLI9vjs3Q7gHdMb
         jsIFos2a1PuMgZ0apcN0DETpoDsVfoNIzd2Yrr3LuzKAItX5nzB8qBPWXaV8yhg6cA4E
         PR81DDDSesMZ648domWtc644N0fP+e7jr2aMax1YkrV8rSRMdTl/4qcE/7x1lMERVfez
         DZog==
X-Forwarded-Encrypted: i=1; AKwUvBwfbv82VAq1uUYML3WgnBgI3CTKINtNP8rxecIaFvRvDusHqEGrbb1PUc0lThj/doSw7AY8EFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++npUxLLvxquzGW8fKrqh9I3BAUODO+przTuKFhm86aWfcP6Hkyt
	PgA3T5qIqgfWK5/WBZq/g0yW09I2k4Vho33xb4yLNDvi2y3fbr9hzOMo
X-Gm-Gg: AYBFou2iRMEVRPEe3v70f1fNn8hShaL8y21HPHACkiQumdSztABrNHzHav+erQHzOR/
	jXRrGrw/Me2E7PEFEQVlKECNesFmMen7f3eGrJtnJEV0Cdnj/uIK7RsP8B11jit/55YdhhqkwG4
	1M1UyQ/LriR2SURUkDKo/L6oWeOwU4lMxFzJ1dFe3uAntHqA5LxwejZzSXzTN4pgjF5aOlRxym1
	z27N/ZpIXwuI+IlBkKU/FQkB30x4q3+9Ip3Jl/LmyoBqQgKYgxgb7cC4Jgudk6Xt+x5xKL9eIXO
	VCovInSgZ/QKKxqZzElJ4QdrjwkZdm2T/+HAwfL6/9Zba9afclTlyBuJ9f1lpEh57S6R023r9Sp
	qvDc88V/6Vc6UljcWjCr3Qr2HbAH7hzybmZtPQEcOvtlpQwhrNSJWC7FsTzcE58ixZ/8ixBDMLx
	AMpvaG8s3CnuAHGEJ6daLGNjYJ9TDf5pUEtAdqX44oxFCOl/nZW7QVE/divE19DNlvdXA/u8cGx
	Ha2Ep5mr4jOBnoEBBwGZw==
X-Received: by 2002:a05:600c:8b21:b0:49d:1df8:156d with SMTP id 5b1f17b1804b1-49fc574f001mr189984325e9.18.1790075083148;
        Tue, 22 Sep 2026 04:04:43 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:42 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 18/26] xfs: fix rtgroup repair estimations
Date: Tue, 22 Sep 2026 13:02:13 +0200
Message-ID: <20260922110221.1431-18-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922110221.1431-1-hackerowskiy@gmail.com>
References: <20260922110221.1431-1-hackerowskiy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

When I added online fsck for realtime reflink, I forgot to update
xrep_calc_rtgroup_resblks to factor in the size of the refcount btree
when it guesses how much space we need to start a repair.  This hasn't
been a huge problem in practice because there are few filesystems with
(a) realtime, (b) rtgroups, (c) reflink, and (d) no rmap.  But let's fix
this before someone stumbles upon it, especially since LOLLM flagged
this for me.

Cc: stable@vger.kernel.org # v6.14
Fixes: 83ccffc489975d ("xfs: online repair of the realtime refcount btree")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/scrub/repair.c | 19 +++++++++++++++++--
 fs/xfs/scrub/trace.h  | 12 ++++++++----
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/scrub/repair.c b/fs/xfs/scrub/repair.c
index 11697a8b2a1d..c2a437416227 100644
--- a/fs/xfs/scrub/repair.c
+++ b/fs/xfs/scrub/repair.c
@@ -399,6 +399,7 @@ xrep_calc_rtgroup_resblks(
 	struct xfs_mount		*mp = sc->mp;
 	struct xfs_scrub_metadata	*sm = sc->sm;
 	uint64_t			usedlen;
+	xfs_extlen_t			refcbt_sz = 0;
 	xfs_extlen_t			rmapbt_sz = 0;
 
 	if (!(sm->sm_flags & XFS_SCRUB_IFLAG_REPAIR))
@@ -411,13 +412,27 @@ xrep_calc_rtgroup_resblks(
 	usedlen = xfs_rtbxlen_to_blen(mp, xfs_rtgroup_extents(mp, sm->sm_agno));
 	ASSERT(usedlen <= XFS_MAX_RGBLOCKS);
 
+	if (xfs_has_reflink(mp))
+		refcbt_sz = xfs_rtrefcountbt_calc_size(mp, usedlen);
+
 	if (xfs_has_rmapbt(mp))
 		rmapbt_sz = xfs_rtrmapbt_calc_size(mp, usedlen);
 
+	/*
+	 * Guess how many blocks we need to rebuild the rmapbt.  For
+	 * non-reflink filesystems we can't have more records than used blocks.
+	 * However, with reflink it's possible to have more than one rmap
+	 * record per rtgroup block.  We don't know how many rmaps there could
+	 * be in the rtgroup, so we start off with what we hope is an generous
+	 * over-estimation.
+	 */
+	if (refcbt_sz > 0 && rmapbt_sz > 0)
+		rmapbt_sz *= 2;
+
 	trace_xrep_calc_rtgroup_resblks_btsize(mp, sm->sm_agno, usedlen,
-			rmapbt_sz);
+			rmapbt_sz, refcbt_sz);
 
-	return rmapbt_sz;
+	return max(rmapbt_sz, refcbt_sz);
 }
 #endif /* CONFIG_XFS_RT */
 
diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 0f5adc293962..cb85f75ce101 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -2376,25 +2376,29 @@ TRACE_EVENT(xrep_calc_ag_resblks_btsize,
 #ifdef CONFIG_XFS_RT
 TRACE_EVENT(xrep_calc_rtgroup_resblks_btsize,
 	TP_PROTO(struct xfs_mount *mp, xfs_rgnumber_t rgno,
-		 xfs_rgblock_t usedlen, xfs_rgblock_t rmapbt_sz),
-	TP_ARGS(mp, rgno, usedlen, rmapbt_sz),
+		 xfs_rgblock_t usedlen, xfs_rgblock_t rmapbt_sz,
+		 xfs_rgblock_t refcbt_sz),
+	TP_ARGS(mp, rgno, usedlen, rmapbt_sz, refcbt_sz),
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(xfs_rgnumber_t, rgno)
 		__field(xfs_rgblock_t, usedlen)
 		__field(xfs_rgblock_t, rmapbt_sz)
+		__field(xfs_rgblock_t, refcbt_sz)
 	),
 	TP_fast_assign(
 		__entry->dev = mp->m_super->s_dev;
 		__entry->rgno = rgno;
 		__entry->usedlen = usedlen;
 		__entry->rmapbt_sz = rmapbt_sz;
+		__entry->refcbt_sz = refcbt_sz;
 	),
-	TP_printk("dev %d:%d rgno 0x%x usedlen %u rmapbt %u",
+	TP_printk("dev %d:%d rgno 0x%x usedlen %u rmapbt %u refcountbt %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rgno,
 		  __entry->usedlen,
-		  __entry->rmapbt_sz)
+		  __entry->rmapbt_sz,
+		  __entry->refcbt_sz)
 );
 #endif /* CONFIG_XFS_RT */
 
-- 
2.55.0


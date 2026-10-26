Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048163;
	b=mPI1EDiv/rgT4gCo0X9Q8KVaG4YnEFFKArvsXrh+eDBYD+zHis5uRAjQ4f8zqzBQ4iVW
	 bXJKn9b+0Q+q4g+jTxe77tmOtOQ5gbT+ED8hkC6oSXkj1W/E6wqpcu3aonA2DqhWR19uw
	 qnwzDyKlNVFpHwLrbBNg7YX9js0d0CG0FrkHkyLw2HQuxwfX+Aav8dGMWdQfQS/UUQNoE
	 189tIRhk4YpZL5jpOO0tfFEBl7AxIdE5XYn9dWZKpW227hYhcPQBIp9cLrsirAAyf9bx3
	 HKeDaJJO63LZyJLQk/E1aKRPIfevNmJRRgfQOUp3GeJV+JEfWschTxCmTWl+/7NoDbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=3B44qYC1y1oMWzUzev4ii49MY2PIUQMP+MPnvqlHD0k=;
	b=J9DQXpZf0uYAt0iuNXUVcBbm5hv/2KnUTsJ+dsXoYpFLaV9m3JAxL58To9HMP5xpvO8q
	 KssIUJLuyTmbw3xOICwxfBg41J0O7TF2noop+5BDa4OUVdYh2R8hwCF3YvU6n83zizp6q
	 W2/JExqGRQZXVtKm41Z38gvP6WhyAijpGxIZTpW1PHNgPgpnwkC+T/j/hnLuiZfE05qAu
	 RdKNXqoRVLZFGWBvU+54a6GF73L5cZ0Nssz8CwyL69s8VglGZpOJuPYckM1PvV/yy3MkU
	 nBQpiW/FckmTFo2ymZaVSZtudfVsJIv6JLb0AkS2/r98HIt7gHau55ty3G3SLB4WQrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=A+AZHrl6;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED40606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AED40606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=A+AZHrl6
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e94f72fb9fso33105375ad.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793048162; x=1793652962; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3B44qYC1y1oMWzUzev4ii49MY2PIUQMP+MPnvqlHD0k=;
        b=A+AZHrl65W8yvx+twdQ2Zl0C041QiC4aIxbw4UqrAJgWKUy+u+RrStSW3L1pSKiWVm
         quNPq3st7bcrd3lJyRLLcD1A8lh1kK9EOmzyi8SdigV6xrQ5qNrobNRhjwAo8qYPyU50
         zcM2HA19Uj+e39zoGBi2DnF0jO6kD5qqVmVG+pAfuRJAI8O0PMyA9AEogFfulGKL+uA4
         Um3UQce0OLoVrUoI9qfqHdCNGAmEtdK9dGvooFMieTMVJWwmFI9dn/G5jNLnm1LgPuTU
         1/aAs/SiuNkKI7S+q/cPiUxeiTMp99WNhbVeYUaEOb5lfNXtfTIag6+E07E8H4lPkMQi
         y0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048162; x=1793652962;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3B44qYC1y1oMWzUzev4ii49MY2PIUQMP+MPnvqlHD0k=;
        b=uO+seFysH+d7PhE9b7s3oKTAkHEipyYzsWVhqSifNUWomW1vaeKGCdxE0A8/EMvAos
         SpxycXcvaeKMKgpy5ZSeBk9qQL4Ae0b2JSz0O4ek7QQECDdsNtDsl/5Bb8h+Qeg6ZY2w
         GaUnxD+qKLb6w3wDhBq9AiwGb5RXSkygCNcvxZ6+oEuMAwe9mQ0qyxdm5aKE4fph45zy
         pY7J5rqdo78FZOkuYdLX/4FQhEbQozTMfNjav13w+vCurwLAxsfc0DN2Rk1upfp3rHtL
         sKM5qokYhZjx6ndbRe1SXh2vc2K6SXrn1vboMgulYWEv/lPXx+MdbfAdh0C4DbXrDYZE
         wmUw==
X-Forwarded-Encrypted: i=1; AKwUvBzv+IaIi1w1i8F1U8dEdGTKmcYNbBoBUqZvu2Ui25IIjFc8lJwEgPTV79N6/6sb3K+FPfEiTYI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKonWCP3zz8V7EiRzhFTo+TvnRK6WT0e2YtQ8mWi0L6wjgeZ7Lg
	GZ3A2ARU++OE2jdbJiYPuWH5u8VBZoLfGgdtBtVrC1VKji1pZExrqD/LXQtJZxBG9dCG0jWXXKq
	KvbRoynWo+7SX5A==
X-Received: from plot20.prod.google.com ([2002:a17:902:8c94:b0:2e9:6468:1ffe])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3806:b0:2e9:5175:2eb with SMTP id d9443c01a7336-2ea9c0f388fmr65823665ad.1.1793048161845;
 Mon, 26 Oct 2026 13:56:01 -0700 (PDT)
Date: Mon, 26 Oct 2026 20:55:55 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026205555.2918396-1-skhawaja@google.com>
Subject: [PATCH] hugetlbfs: enforce F_SEAL_EXEC on chmod
From: Samiullah Khawaja <skhawaja@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Daniel Verkamp <dverkamp@chromium.org>, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

F_SEAL_EXEC prevents the exec bits of a memfd from being changed once
the seal has been set. F_SEAL_EXEC is included in F_ALL_SEALS, so
userspace can set it with F_ADD_SEALS on hugetlbfs memfds just like on
shmem memfds, and F_GET_SEALS then reports it as set. However, the check
that rejects the mode change was only added to shmem_setattr().
hugetlbfs_setattr() never looks at the seal, so the owner of a sealed
hugetlbfs memfd can still make it executable with chmod(). For the same
reason, MFD_NOEXEC_SEAL provides no guarantee when it is combined with
MFD_HUGETLB.

The memfd selftest already covers this, but only the shmem run passes.
When run as "memfd_test hugetlbfs", the test aborts in SEAL-EXEC because
fchmod() succeeds on a sealed file, and none of the remaining tests are
executed.

Add the same check to hugetlbfs_setattr() that shmem_setattr() has, so
that a mode change touching the exec bits fails with -EPERM while
F_SEAL_EXEC is set.

Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
Cc: stable@vger.kernel.org
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 fs/hugetlbfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 01c4d6f44ebe..56e0588d295d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -842,6 +842,10 @@ static int hugetlbfs_setattr(const struct mnt_idmap *idmap,
 
 	trace_hugetlbfs_setattr(inode, dentry, attr);
 
+	if ((info->seals & F_SEAL_EXEC) && (ia_valid & ATTR_MODE) &&
+	    ((inode->i_mode ^ attr->ia_mode) & 0111))
+		return -EPERM;
+
 	if (ia_valid & ATTR_SIZE) {
 		loff_t oldsize = inode->i_size;
 		loff_t newsize = attr->ia_size;

base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
-- 
2.56.0.307.g5fe7bd680c-goog


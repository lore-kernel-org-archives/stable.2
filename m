Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD351D525
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713267; cv=none; b=NS9eeD1afpH3ZkcCXm0SrtHnXIO5v44rk9vJVg/3sjGwUUwpHcDvblWsMiMXnWceZCNeRM7RYbBixRV8fJaaDByr+Mq19o0GE23mkIK1ARK1AUEaQzg9cm7wDc2KO/rbQgsuX9k2njPP0TNkw8Dvh2rONiyJFvCb1uPHfXfq+oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713267; c=relaxed/simple;
	bh=iRjbTkx4Of1Zb8zkJkx1sStZme1vCcPBa5+tPQr/yso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNG4DdsCYFmQmLU0pUzWHr/rtC3fDizEAPZDH0qNm6ypsGUHizbSkKTC7wKPrDsWCBTqnXDIzrfJV6TKmEclDTUR31vnEv/jkvFKRhO23zm4pT2Il+7k+qZjFl8Dw+0UN4zezsFSvEWPoaifEmWtZNIxHK78payKaFmwNCd7fj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9mXL/t6; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9mXL/t6"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so27494695e9.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790713263; x=1791318063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zKv2477Z43K69h4lwRjf4ZEKr1l8Bu4ddjI08syiTdw=;
        b=i9mXL/t6WsFf5SYQqq7la7dFae/STcArk8ZWZM9t5DbPjTvFwWtuGdQIFfyesY1QUX
         PeGSS6eTmRoth3rT63hHOWeSbkOlWqDU2SFj2LaYideja3E82OTRPnwsXIhLWZv/VGL8
         psywNfNg8+TswrY2HBzAIkNz/wWCk/BnVNZ+hy/HmNz5jbhgSgA5d614O/FNY13p20pq
         bgcNOiopmB2GSfp+uSFugHFVV72TV4xWkshXty5E7J4bOI6agiUuD8H6LcQh6putAaMQ
         wS2eaLg2HqYRj6NAbnS5+d7gcmYkXpXS7rJtvazO+QwvNd+LXq/6n8GWtzENuzAFTAof
         i+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790713263; x=1791318063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zKv2477Z43K69h4lwRjf4ZEKr1l8Bu4ddjI08syiTdw=;
        b=jzxk7FMmlGlgJlNzIIZ46Nc2a3UCUQU5ZOQgd7rasUQ6UL8ghpGdJdERFVMtQ1Q1jV
         Fa22XV7b8x4kPiXGNWmo12S4uS67TKj48jBV27zU95ttbnxYg4UOcwVWjdtNDEY/wvxY
         IOJH5NFauIosKRk16ty9iHj0zwCd+rkwS+5Gk4K6Vgt35RokP9zEoMDNLrYaC4tAS6e1
         hUg/7dZJx3ZHjYruEmSoEloxp7i/5KdDDOKD7RyPRl/151J7p8GlVnqwVz+pwgSazJMD
         0k7GZQdnPkvwO3SXrfdVortthZjsA8yZnvta2ONtMrFQVlBvddf8dFFszmv7Ta/LpdQX
         vEfQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6lVuidXzAL6biL+MPIINMZew6kBHmbj6b0qCoTufas3LjceNcmpAedKB44IMib2XeX68ByNY=@vger.kernel.org
X-Gm-Message-State: AFuF++mx/y4iv2QiqNd0O9VzL52YaCkpD9c5zNSvJi1keQtHotV3xDZh
	g2Ba5k4JfXrsia9Y50454vEYD44nh1QzTIj4qJOb11B+wmQQxVHz1WQ=
X-Gm-Gg: AYBFou30TGWza/OJXDyzAUgjP03JqeH0f7RyjEl9F4bStCz3WD+jAQ8z+bRr2kNlVQO
	vP4BfvRk7C51g9+ZqeieRW1vpyq61i8vENSJ0tewjvhxegptJU1Tmd+1MDE/GKrB81MGSEwLey0
	5atcSE3s/q83CrJk3luWDTvbbDK+c0cJpjTXWmZZS1618jDFxhNkygH9fGNIwFt2vkwHN3LEM81
	0gUTUk1nlFacrxANK/D35/FPDhxwJsuC3bw8wzfk6kdxhwXD47i/03Ferr86zx3lKaoMivJKfgb
	6if3xH3t49MC38T6eM9SRNil+Z5t2D1z8Q/d51/GPEonMwvQM77AhGQLAZ8Q3+GbUotRs44RlZW
	h0cKapvvlTJnmddWNcHtuNYuCACV90CGuZhozR1oE2DKNP48ZXL6f/nEAZKr/SX4melVuy2f8jp
	AWXc5E3H9w6yIG4f3YjZkGlidGfdRVbFoBw4JA4CXUiZYo+SaoB/L6BxFPcGwJyu3NnAEikLsIq
	x6E6HZ8EFaJSezDtAMTDSc+WF2vNGVH3ch7belKUTIp0qHVFinjSubtvVMG8RRcjy5Jijcx4NBW
	/5QSER4=
X-Received: by 2002:a05:600c:c494:b0:4a0:1d2:1a8a with SMTP id 5b1f17b1804b1-4a015027518mr3741815e9.16.1790713263399;
        Tue, 29 Sep 2026 13:21:03 -0700 (PDT)
Received: from Ubuntu-2604-resolute-amd64-base ([2a01:4f8:13b:86d::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfe13a1sm102947985e9.5.2026.09.29.13.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 13:21:02 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	akpm@linux-foundation.org
Cc: gabriel@krisman.be,
	krisman@suse.de,
	brauner@kernel.org,
	andrealmeid@igalia.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] shmem: fix unicode_map leak with repeated casefold= option
Date: Tue, 29 Sep 2026 22:20:35 +0200
Message-ID: <3a57ec70731165b4b1244fa89bba95c82a666df8.1790712330.git.med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each casefold= option makes shmem_parse_opt_casefold() allocate a
unicode_map with utf8_load() and store it in ctx->encoding.  When the
option is given more than once in the same mount, the later call
overwrites ctx->encoding and the earlier map is never freed.

Reproducer:

  mount -t tmpfs -o casefold,casefold tmpfs /t; umount /t

Repeating this 50000 times grows kmalloc-32 by about 50000 objects,
and kmemleak reports them as allocated from:

  utf8_load+0x21/0x110
  shmem_parse_opt_casefold.isra.0+0x65/0x100
  shmem_parse_one+0x368/0x510

Free the old map before storing the new one, so only the last
casefold= is kept.  On a normal mount with a single casefold=,
ctx->encoding is still NULL at that point and utf8_unload(NULL)
does nothing, so nothing changes there.

With this patch the same loop leaves kmalloc-32 flat and kmemleak
reports nothing.

Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
This is a separate leak from the remount one fixed in
https://lore.kernel.org/all/ba38f80f629fd093c77f3a49fdab7b71ee7bbc5f.1790687276.git.med08elkadiri@gmail.com/
which Gabriel has reviewed; I found it while testing that patch.
The two apply in either order.  Tested on mm-unstable, alone and
together: kmalloc-32 stays flat for duplicate casefold=, single
casefold= and remount, and kmemleak is clean.

 mm/shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 07b2855dfb7b..262f1bcb6144 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4731,6 +4731,7 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
 	pr_info("tmpfs: Using encoding : utf8-%u.%u.%u\n",
 		unicode_major(version), unicode_minor(version), unicode_rev(version));
 
+	utf8_unload(ctx->encoding);
 	ctx->encoding = encoding;
 
 	return 0;

base-commit: 90ddfbd1963659ca4a5d3d7f20717a4222682a8e
-- 
2.53.0


Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F9386C3F
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242965; cv=none; b=dk2lSZAFgVUXJ0OlQouB8zB9J5vq8hcyWc/0WitvWrVySXVSL+RUGscpyGutRnFf0T1cX7uxhCg5AStgbRynRZKZ/OMth2sc7E5ILVlRFkbN2uNWyHXuC+tikbKFohlJp+ChGXd4yeREpvAn9ZkPKm8sS0AYExm5yM7g8HBrrQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242965; c=relaxed/simple;
	bh=lambDYX2lwAsI5keUktYfmRvkhvX1OmYUKy53CnCprs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fuxwx10DPZWoAhpQbD/yjUZCidnLhGVqd3NZvZY2SYqM8troWJtYRU6NYr9+jkb6ahEXWz7zq9NFDpCPO7CMTtuOv+j0G9MeaC7KF8uF4YfB0sZKvm4+SxcY2Jlv16fLD7BqPma3SDGJSpJsp0YI2b+iidJuORRX86VPATEJ1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUivE7Es; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUivE7Es"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso10924385e9.2
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789242960; x=1789847760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NwiXawn/cOlpKopFTshA1Oy47KkInxpQCTdPgG/ctyc=;
        b=HUivE7Es62sxR+XLVXov6xp7S3xA7zc5sHg2aPtEm1D76vGg1cOSKxrjCSovHeU7zj
         Z4XWperoqM/Nf13+t4OeR96Ig/PZiaG2eMVn+b0aS7RQPAwJkd3oF2hhQCIal448eu+Q
         LbRCIw7BZceNKu2BD2oaddvMuIswR0fMS3mUzgdptZG/8oCVm1fUvgSLnzjGlMgs4Aws
         IN5tIEcKDkmdm2wkY02rHkEkzo7Fkxw4i+mTh/TKaEIKoEUQFgEpw+6G5930rkhshcrp
         jjDGbby1UGLM/3SL5Loma2LMNtsSftBmNfAbsju/FlhLg7AT08XO9A5ce0zRqZD3F5FB
         X6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789242960; x=1789847760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NwiXawn/cOlpKopFTshA1Oy47KkInxpQCTdPgG/ctyc=;
        b=r/zMqTFVtHqz7l3p1b90OYaVTkpK85O/DNg7pC983/eqvg0nVfFTdoFAFotf+fJhsq
         q2A9m9c4wGIR5CFW5TVUM/oG65k23cGthJLdP8USONAFB37QkXnG0N5iIb+OUiDSWe8v
         o3kaehweTCH5NebB3lC9B+oLyVxLFkxdRBLn6SEIJXo4QH+GYiE0aGLChxKe2uepaOTA
         BnZvSI6cWDdaK7VvFZ5GtOpgG+2y2oo7bM/hqZE5GgmZb5Lv6pHXe5JSDNvtBVx6bn4w
         qOUmkWDBPOpI6PrYrGzk/Q0M0z+e5eQ9NVy87IY2IVSwoAgHzoc4NmrYD0+Pz5h8BGGv
         85Lg==
X-Forwarded-Encrypted: i=1; AKwUvBzfA0aox3b02+FlKSi/z3+QF30/CXqZ6QK68IzvnXokiaMkS0JO6XhTXzBtwg7wlvBXapf2O2o=@vger.kernel.org
X-Gm-Message-State: AFuF++mxOseqYoVDTlab4ptTneQrUcqAarTL4tAVk32qZw4wqTW6qEeq
	ZieQvv1A31+6zViJisPNwo4APt+HdodlGe64i4rK5VGOLuwyiznqhOjn
X-Gm-Gg: AYBFou2RKnKHIPAuTDqwPlEpP74urfiXrSQAFfnLNpyXVvtnfRncfkMNaGaPJ32i5Mm
	Me6a03e94SE4yjTAaDzRfDpK4inXq6j17DZn7EXfA9PMpl2hZjirsw/d2OCYPvKtMrNlNkRCgXi
	0EdFrNwrY485irvMxNOhMJDnEr1h0ffVC4B61jl0nOKUMP/IKbrp+30D4O0AcnzmkLmRp6F3rw4
	TwOWS7G2TVk56nuEy5lXKu2WnbTar0qIRGRLe5D10J3Y/swG7Jc+TFXASZnmw5frJ9Syh8rfHwv
	lppEW7Cy+u4OC+NbmdjgfQ0yaxDt6l+ENy4Ptt/X27f/IUBn++BSxwTOrcNjI94kkcckZ/snVJI
	p+XowtwmverDdhirw9xRKbbGS2s6u+Z/DEsEA/s1IcuV4iH6s+98TYUewth1/vw0CnjywMcLQ6A
	CyUucxlrI5ggzZC1XOUejrPSVOVpwz1YsGuqCTWjNBPVY4RlOl4tnIdVtPvZLIwXrtdZ/EeEJDU
	Uzpx9oKZHwyBvwBGkgkcZ5JxU6xDa7/KtFlvh4DnAkCYISarBar4aZGFv2wj09SeKZKaRg4x31Y
	OUDSx9humTJ3zmmQlzvhOz7K+0w5ltAwjUQYJdVvvixmiJmjBhYHlIU8GBJkH01zBBtc64vFevL
	JCBsDk8s=
X-Received: by 2002:a05:600c:8b38:b0:49d:272d:74b4 with SMTP id 5b1f17b1804b1-49e619a1e56mr222951175e9.2.1789242959747;
        Sat, 12 Sep 2026 12:55:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm267089045e9.14.2026.09.12.12.55.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 12:55:59 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Radu Rendec <rrendec@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/4] ARM: cacheinfo: avoid out-of-bounds write in populate_cache_leaves()
Date: Sat, 12 Sep 2026 21:55:49 +0200
Message-Id: <20260912195552.76673-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912195552.76673-1-kmehltretter@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

populate_cache_leaves() advances its bounds-checking index once per
cache level, but split instruction/data caches consume two entries.
CLIDR-based allocation supplies enough entries. Early allocation from
the device tree can supply fewer and expose an out-of-bounds write.

Count each written leaf and stop before a split level that does not
fit. This prepares ARM for DT-based early allocation and matches
commit 875d742cf532 ("arm64: cacheinfo: Avoid out-of-bounds write to
cacheinfo array").

Fixes: a9ff94477836 ("ARM: 9433/2: implement cacheinfo support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
The overrun was reproduced with KASAN on QEMU virt, cortex-a15, using
a device tree whose cpu nodes carry only d-cache-size, so one leaf.
With patch 4 alone the boot reports a slab-out-of-bounds write in
populate_cache_leaves(). With this patch the boot is clean.

 arch/arm/kernel/cacheinfo.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/cacheinfo.c b/arch/arm/kernel/cacheinfo.c
index e1469b641780..860eeb03cfe5 100644
--- a/arch/arm/kernel/cacheinfo.c
+++ b/arch/arm/kernel/cacheinfo.c
@@ -151,7 +151,7 @@ int populate_cache_leaves(unsigned int cpu)
 	unsigned int level, idx;
 	enum cache_type type;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+	struct cacheinfo *infos = this_cpu_ci->info_list;
 	unsigned int arch = cpu_architecture();
 
 	/* CLIDR is not present before ARMv7/v7m */
@@ -159,13 +159,15 @@ int populate_cache_leaves(unsigned int cpu)
 		return -EOPNOTSUPP;
 
 	for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
-	     idx < this_cpu_ci->num_leaves; idx++, level++) {
+	     idx < this_cpu_ci->num_leaves; level++) {
 		type = get_cache_type(level);
 		if (type == CACHE_TYPE_SEPARATE) {
-			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
-			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
+			if (idx + 1 >= this_cpu_ci->num_leaves)
+				break;
+			ci_leaf_init(&infos[idx++], CACHE_TYPE_DATA, level);
+			ci_leaf_init(&infos[idx++], CACHE_TYPE_INST, level);
 		} else {
-			ci_leaf_init(this_leaf++, type, level);
+			ci_leaf_init(&infos[idx++], type, level);
 		}
 	}
 
-- 
2.53.0


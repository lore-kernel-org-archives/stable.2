Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A78F3EEAD2
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444664; cv=none; b=aZ5UiU8ZVBFU0FYEpgwRFMDbpCdV7eq+3X3wExMSzW1uAM/87bHu0DdVi5Po91TIywjJhfZHnyH4bZSty+tp5X8l30ihb+F8qsU1dijcusZmViI3PlYdkqUvYQC/H+3KaEm20vZsPZwUuis69ahxwxD+nLpSn/mxe9c1rqyntKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444664; c=relaxed/simple;
	bh=QoqC5FWDPTguiDUacor1rhogobE1ykW+PVHQtFAmfKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuV+0Paopu5XZcs4U3n5PrufUCeSNwnEzQAcfkMbiAixP3Ls2jkV3mQ/TVL6G9xRBif8pI+uN5MagdQqZN55901JWLw6uDrersR9/1j8hJjyMzpiUBXwWyeR5o/75xVpx9sI1JINiKl+jeF8Ty5i4Ieq251utK4GMFR5B/Efj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RoLrBi5k; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RoLrBi5k"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a02551822eso362828a91.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791444654; x=1792049454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n0iL076pHUaLr+l14HbxfZqldd4j3905YwLicSMDih8=;
        b=RoLrBi5kBuiZ/K5MfYcTf89CF87DRixsB2FN3nC5+9gEFiIN9huoTPPcDeWNhldgFH
         lTgcOQMaKasNhr5kRzJh+1oXFAG4WwxYQO1LO6ph/1Wdt2X97+iriDG1uky+p2IzIrEj
         nFAwE8OGePwH3UUf0HEgaHte5kFCNv7vMrZu2NOdd3FHYoUICMRW6ZGpK9iC9mOCGsTS
         cW1AtmCGDrkmKCage4N5DswIs000wZhcXhRJyXeO6Fmk/vvEu8uIdZsV5RbV2nuRNK8I
         eeY5KiRgdLZ/rjZJC6Y/rQpjzdQvFEdcxFx8KLr0T4ssAo8+crZhGL2uIedNLQMMVHcf
         f0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791444654; x=1792049454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n0iL076pHUaLr+l14HbxfZqldd4j3905YwLicSMDih8=;
        b=t/8Zi8oh/9M0iKjsF0xmZhuDvFLYN1PmzOZIquxCPE17d8M4dABzQ38eyDXG1aiAbd
         9TY4BZ4PZD7dManB4g+be3xmUhpiiCFM/EC0P4mL55d7vAHplct83hLgp7/VAFyOX1St
         LXLe6BdvDMAqehbwjxumjK+EjTFREmXBQ+XUDiphiH3/uk2VQUFtSrXBSLB213kjzw4s
         Z/dDq7y3ASj0Y96TRuLrv+YxGmIQU6MYURXm2OBRbqSeY9SswhhuDqR2zzem2UcvKUwK
         mGHlr2YYyKuuMeSzxJk3wBtwDhsLWf7u6qU3rNUKwwPACTqhiwOQO5rnFUqp6ur23r0n
         Pf5w==
X-Forwarded-Encrypted: i=1; AKwUvBxBUjAyUhqxUc/Igo1c4h2evsM3Zm/nWLygKmSow2qooKZkgzq81+XXX3loe9g1tMKnCSqp6g4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsrhoqcJJKPVGjFMJpnV5F3HsQek7xw89Coi75arettNuCD379
	RTsyBndwlDK0SXDUBjG4zHOOKahsSli3stSvplu4tte1bwGDvzzvtoa4Awf7Uu3FGYA=
X-Gm-Gg: AYBFou3TkIQ7NvCTyBr/MCuBcYU0Huiixlf+QHqkTcb+8TWDCoRfdqATOSU6ienlrSW
	YOn/RKdPb6/sLaI5L8Ahv/KsU4FqvliCVbK4ngBZ0H84gp4GxZNc5Osc+5T3RakOztSyYyDMm3s
	cnwdMECC6VTbL+TqjWfzJNa4+eMMfdfCET0FcVY36WMc82BiBzETEZFr0d9PHOsPRx9m4diCm6N
	obYSJDbNzysDbUHEMCjhWANvj5c7RmkTRUDlaxws0OVLvzXPEoQNYaU+F6Lsmo3ZUskyLxsTq5z
	70pW1VdxXH5umDZk86Mr3+wg4uMKrxoQntacrKBwG82o6IHZXOo6MpfU02MxRlTv7/WlrIx8k4z
	D2vLGLMkiRN8Oap4EEmlI4qBMLXRo9VgqCX2WpLBLBr/HkJ9mAB9oexLu+F3p6V1xi2FlYsA72z
	dpsLPH4hkVOTooYAX1jAEjwk2z/qf5oOHB/NEaTaBEne4y+L1dGVNa6YC8J2RVvmAMf3VuHfx3J
	v7U0Efk2sZ4hHQyUdx+
X-Received: by 2002:a17:90b:4a50:b0:39e:6c68:fd92 with SMTP id 98e67ed59e1d1-3aaed9a2992mr859363a91.39.1791444653999;
        Thu, 08 Oct 2026 00:30:53 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8a438f25dsm3114715a91.2.2026.10.08.00.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:30:53 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	stable@vger.kernel.org,
	david@kernel.org,
	osalvador@suse.de,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	bjorn@rivosinc.com,
	apopple@nvidia.com,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: [PATCH 3/4] riscv/mm: fix missing destructor for hotplug PUD tables
Date: Thu,  8 Oct 2026 15:30:20 +0800
Message-ID: <20261008073021.2512665-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008073021.2512665-1-songmuchun@bytedance.com>
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8472cc4503eb ("riscv: mm: call PUD/P4D ctor in special kernel
pgtable alloc") made alloc_pud_late() run the PUD page-table constructor.
However, free_pud_table() still frees non-reserved PUD tables directly
without decrementing NR_PAGETABLE.

Free PUD tables through the common free_pagetable() helper so that
constructor-backed tables run the matching destructor before being
freed.

Fixes: 8472cc4503eb ("riscv: mm: call PUD/P4D ctor in special kernel pgtable alloc")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/riscv/mm/init.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 429a0b015ec1..62077539ee78 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1540,10 +1540,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
 			return;
 	}
 
-	if (PageReserved(page))
-		free_reserved_page(page);
-	else
-		__free_pages(page, 0);
+	free_pagetable(page);
 	p4d_clear(p4d);
 }
 
-- 
2.54.0


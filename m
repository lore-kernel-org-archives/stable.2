Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177363;
	b=vUsYryxtNhnUXh6ejmj2SjnaLizJLowkuWMKcQh5S9ZCA9L+gmt4vwYyjljlCXxpIXSq
	 1JOX0Wo6NhUgxak2AJNUeGpoFUbn9JUJcr4fb+nS6nkp698PNOlTejD+wUIV1FI/F6VpX
	 aLCkKr1CdHIY2VVu/DMioqXIfPkXVsgl9wQScNfWM3xWQCzx/awY/z37tXClfJnWc1vta
	 h5cM2GRNQdI08Y5iue3H0j0K1SNuB1nQQXMw2YCRMIBORY2IW/ET8IdlLxsk1a9WRv6n8
	 uPT6c3HexyWdBcYEd2tBDwCypaii4CR0cCmQtEeA4mhviTa12utd62xlZ7o1u0jCz/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1kNf7/T6Z3Z9x33XOj8xN/pKgMapC3Cz/qc8M6FMmZs=;
	b=lTlm7xlb6a+KGKji1deh6Lm6xIX9tgx6Mudi8zgtE4T/Zu6AcaIJdPeqRh9agVb9xluq
	 1p14AyR7CnnX4nNL2jNxfIEA1NWyY3et2+vydSIsadbrgWjF2t4J08cFu8/2xu0OyENSQ
	 FFEb8BOkfIyIYPkKV1zB6mqldx+N2QvdsQqQFyUyqlgJncAMOK3s7q/tIvYifEfEe/Vjd
	 Tp02Wlzjr4ByIzDVE/AGGBq0W3tPWWmTjWwgOtyPJXUkjHK/1WD+KXUDgIdUvj5OiISO7
	 eCpV23kcbNiI6cXpp1fZrN8HGNSKlBbij97b8NhXi7NVwvoeVop8W8LV/tAUi2bSEvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShDTzBtj;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CDA606A326
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6CDA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShDTzBtj
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso40176666b.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177361; x=1794782161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1kNf7/T6Z3Z9x33XOj8xN/pKgMapC3Cz/qc8M6FMmZs=;
        b=ShDTzBtjwSJXqCMUEGb41FMhfMCTTwW4HowLQCzZKTOq5TPR8B+oJmlWU0VXWp52un
         pH2EFzrQjftXsAXbJiSx0VG8GWoMjew7u9AEjPk3kVUN2nhQZgNacTUoOpLtYMku4sbu
         8G600W8DRgFXm9rfHZ5yoWELYtmGh2R3zZCQ7WXgX/UuAMVXplzjC9nUsk1wMbIHlX+l
         s43+GotMUmZwMqn6b+83G1vAXAgfwgXtkJ1UHeIF/nUXIcmsUBaeRy8on4nHjT/OnSQ6
         ZnjPwBCB/cjzS2NWFqBJIo3htOBmYBxvOLTOFImIQFDbcvouSsStUfcxGJo8sg2QxALz
         zifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177361; x=1794782161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1kNf7/T6Z3Z9x33XOj8xN/pKgMapC3Cz/qc8M6FMmZs=;
        b=u0C8az7YIBXOL+kSEPZ6lFIIa9Z/zra4vqCtXSvE1cC6dJqZBdbOla2T2UICodM3Eg
         qeMbghl4Wp/7O1TpCDSJcEX4O7XJU/zdnj2kolJXIZsxv/940xUOClffm6DJHehPVz33
         NhyZt4/cSSOHoxtg00C7tFrYCux1YSfjNEMieUAtXfQ7W6NTlIcuuOuasYJ9yJtctb6N
         T6lRxp3Uo7YwYaR28ggCcGCkUblczSEPa5PbBp0wSGApJ8QGdYpnRr8Vs0nttc+Bqgc9
         0Mkx5/cfRCXOzWewP2kSYINpMZzjlcBR7m3Mtkml/MCcNmY/At+V4PhTUl1ZnrjzHbxk
         A6iQ==
X-Forwarded-Encrypted: i=1; AL+hErGPQiOoITrwsA6g4s6hAX8iuuWF92ROeNqx1YADO8/8il8VO9ieSwlkxVj7ZUgkpuA2/LMBBko=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kb/vHAs8QuD6bLJiZ3sEMdY710YN3V1AhGqQdOnoBka4G1azo
	BpZYb5w+jF3eFSH480gbC4Ugs/lB7+9vuZ8YpA2+Z79NoPpCSpm3rPbX
X-Gm-Gg: AYBFou3jtEL7NY1T5rXcvro2blqW+vo1tqkO1EiiOD4N7s5lBKyAfPWOnqIQL/rfx3D
	rume8SmRPUcWNIaSlKjMThq+t0lp5xTVXP4qcdy1ryxhOzpmE26EoHPasAcPKlMaVZlL/oE6qpp
	URnv6lnP/5TfzzL2W71mkrecjwJqi1wiuj+6Vnht1vuby8gDF4ogy/+5515Frd+VWNJjOxazNp1
	VT3dueAzwpn3FZM6wL+/dj2uPxwzeW18/LWauQuu6jhPDdSheVf5s2ZMRm5HY41m2GqpbmQ6bNr
	bY5s3GOajK7nDr5qKU77TzInpia3ULbCZwzac/eNMsGU8B5dR273MruyM2J0XlhOnN8egz4n7hB
	48UIxwmzj99CCjmeoGM7SQ0ZPYqyrjih0BX4FRbv6UT0kMd6Kg4x/PX8x5gj2uAnbSwlnsn4M52
	OSgooHYucPOlRPQR8PKu3v73Yc6VdRAIZ8qYlskSKB9UDzrK4dYJLgUYvN9Rr8JL441C13hrIp1
	wsY2FcaMzw1vagmVdRxm3bP1ifBZX751to5HaA++I6XQid7Lri0MEITPA4QySgmLa0TouE3Gx6V
	ekI83HSViprEZA+NzAV7PXiqZuozmKX8a2nCOmlt207GNO38KLQu2FSRpoNrWD0CgHRJ1qs=
X-Received: by 2002:a17:907:9347:b0:c36:a4b4:b1ed with SMTP id a640c23a62f3a-c4d6daf7d4emr185489266b.11.1794177361100;
        Sun, 08 Nov 2026 14:36:01 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:36:00 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 4/9] sparc32: flush the cache when a kmap_local mapping is installed
Date: Sun,  8 Nov 2026 23:34:14 +0100
Message-ID: <20261108223516.1125534-5-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108223516.1125534-1-linmag7@gmail.com>
References: <20261108223516.1125534-1-linmag7@gmail.com>
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

sparc32 defines arch_kmap_local_pre_map() as flush_cache_all(), but
generic highmem has never called that hook. The post-conversion flush
correction moved cache maintenance into this uncalled hook, so a new kmap
can be installed while another mapping of the same page still holds dirty
lines at a different colour.

A writer dirties a MAP_SHARED page through its user mapping on one cpu
while a reader pread()s the same offset on another: on an SS-20 with two
RT626 modules all 100 iterations came back stale, 96288 words wrong. With
the flush restored, 0 of 100.

Flush from arch_kmap_local_post_map(), which generic code does call, on
both the map and the scheduler restore paths. Running after the pte is
installed is safe: the address is not handed to the caller until the hook
returns. Route it and the tlb flush through sparc32_kmap_local_post_map()
and sparc32_kmap_local_tlb_flush() so later patches have somewhere for a
cpu-specific policy.

MBus supplies only optional VA[19:12] "super-set" bits to a virtually
indexed cache, so differing colours remain a synonym problem the bus does
not resolve.

Reference: MBus Interface Specification, SPARC International, 1997, "Basic
Assumptions for Level 2", signal VA[19:12] (MAD[53:46]).

Retain global TLB invalidation. Although the slots are CPU-local, remote
translating cache backends can populate entries for them. Local TLB
maintenance requires those remote translating users to be removed first
and belongs in the later HyperSPARC optimization.

Fixes: f99e02372af2 ("sparc/mm/highmem: flush cache and TLB")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/highmem.h | 14 ++++++++++----
 arch/sparc/mm/srmmu.c            | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/highmem.h
index b1b915ac604d..14b03f348823 100644
--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -26,6 +26,10 @@
 #include <asm/vaddrs.h>
 #include <asm/pgtsrmmu.h>
 
+void sparc32_kmap_local_cache_flush(unsigned long vaddr);
+void sparc32_kmap_local_tlb_flush(unsigned long vaddr);
+void sparc32_kmap_local_post_map(unsigned long vaddr, pte_t pteval);
+
 #define kmap_prot __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE)
 extern pte_t *pkmap_page_table;
 
@@ -48,10 +52,12 @@ extern pte_t *pkmap_page_table;
 #define flush_cache_kmaps()	flush_cache_all()
 
 /* FIXME: Use __flush_*_one(vaddr) instead of flush_*_all() -- Anton */
-#define arch_kmap_local_pre_map(vaddr, pteval)	flush_cache_all()
-#define arch_kmap_local_pre_unmap(vaddr)	flush_cache_all()
-#define arch_kmap_local_post_map(vaddr, pteval)	flush_tlb_all()
-#define arch_kmap_local_post_unmap(vaddr)	flush_tlb_all()
+#define arch_kmap_local_pre_unmap(vaddr) \
+	sparc32_kmap_local_cache_flush(vaddr)
+#define arch_kmap_local_post_map(vaddr, pteval) \
+	sparc32_kmap_local_post_map(vaddr, pteval)
+#define arch_kmap_local_post_unmap(vaddr) \
+	sparc32_kmap_local_tlb_flush(vaddr)
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 49d41b33aabf..aa53ec10cd8a 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -88,6 +88,27 @@ static int is_hypersparc;
 
 static int srmmu_cache_pagetables;
 
+void sparc32_kmap_local_cache_flush(unsigned long vaddr)
+{
+	flush_cache_all();
+}
+
+/*
+ * Nothing has touched the new mapping yet, so flushing other aliases of this
+ * page here is as good as doing it before the pte was set.
+ */
+void sparc32_kmap_local_post_map(unsigned long vaddr, pte_t pteval)
+{
+	sparc32_kmap_local_cache_flush(vaddr);
+	sparc32_kmap_local_tlb_flush(vaddr);
+}
+
+void sparc32_kmap_local_tlb_flush(unsigned long vaddr)
+{
+	/* Remote translating cache operations can populate these entries. */
+	flush_tlb_all();
+}
+
 /* these will be initialized in srmmu_nocache_calcsize() */
 static unsigned long srmmu_nocache_size;
 static unsigned long srmmu_nocache_end;
-- 
2.43.0


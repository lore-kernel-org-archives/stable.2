Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D6273D6D;
	Sat,  1 Aug 2026 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785573297; cv=none; b=OZ+a3xmBFgRExLWBVG6hFwHpNE0EIjzbCxcdXzal+Fj95RAekJRni+uWZajbKA7HvJcpWTwIzBjJIGvm/HsYzuxIrdnJMn9pt5zrdI5T6rPrN8xJUP3kHY/yp1ZkJUqHJB2zug1Zam2+gVA8oONw/JXx7hqf93S7Cs/xTBlanXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785573297; c=relaxed/simple;
	bh=D2XhRQ9aDr3wx0Fde00d1IVLMP0QSC+BSHaDEOmBv/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PK5xCU94q+S4yFl8gfbUwhY6e7hy+O5nS6Cg9rCzOM+FwxkGrAnnytJGz3jEodASnJT0MeWv8nh9dEsRkMZcoQ+xl22CEQ/B3wysPNzxQSOAhphBF2WkJBM99kYxGKc0rpv+vAw3vxxBdQDJYHRsRDbMrl043uHh4WYBL8ysoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=r1Jx8jvk; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="r1Jx8jvk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ho/q32AcbYFvSnd9s+n2PIJxfB/MItoG1fAzyJ5oEHY=; b=r1Jx8jvki8JkOpQeblmg2V3ogn
	7jMteEyL4NEQS0LxO88nzK3y6PpyHEiPKPzeM5khp1wTsdRj8K+B6rAF3kgOiHOrebN6CCIWBzPl3
	KplZxMqZcs+u6n6MHkh6uKmdJjfsTC9IRTDWBYYFT0OH4ohv/bKGSMW6pk54ZxRTBlkFYCv8bLS31
	9sUP2wNe/6AWFVVBl7S6JZCa8xSg2l6f1koOY5sgdkr4toc+tH2UdGEyC4xN854iJS0aJrr3WXlhM
	Wh59WNv/KocYzQccNsrzi0HAEh1WNlA7gE+2A02QqS+LMS16d5d3JWx6kxUiKH5Pqmn7o4wsMI6SH
	mv3Xhdaw==;
Received: from [151.115.150.205] (port=47632 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wq5BH-0000000AYsZ-04fq;
	Sat, 01 Aug 2026 10:34:53 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: bpf@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v2 bpf] bpf: harden bloom filter sizing and indexing on 32-bit kernels
Date: Sat,  1 Aug 2026 08:34:04 +0000
Message-ID: <20260801083436.4014218-1-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-scw-domain: oss.cyber.gouv.fr
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

bloom_map_alloc() has two 32-bit-specific problems when the computed
bitmap reaches the U32_MAX fallback case.

First, BITS_TO_BYTES(U32_MAX) is evaluated with 32-bit arithmetic. The
addition performed by DIV_ROUND_UP wraps, so the map allocates only the
fixed-size bloom filter object while keeping bitset_mask == U32_MAX.
Subsequent updates can then write past the allocated object.

Second, fixing only the allocation size is not sufficient. The bloom hash
is a u32, but set_bit() takes a signed long bit number and x86 test_bit()
eventually feeds the index to variable_test_bit(long, ...). On 32-bit
kernels, hashes in [0x80000000, U32_MAX] therefore become negative bit
offsets. x86 bt/bts with a memory operand interpret those offsets relative
to the supplied base, so a map with bitset_mask == U32_MAX can read or
write before bloom->bitset even after allocating the full 512 MiB bitmap.

Keep the U32_MAX fallback, but split each hash into a word pointer and an
in-word bit number before calling test_bit() or set_bit(). The bitops
argument is then always in [0, BITS_PER_LONG - 1], while BIT_WORD(h) still
selects the intended word in the full bitmap.

Compute the bitset size from (u64)bitset_mask + 1 before passing the final
size to bpf_map_area_alloc(). This fixes the original under-allocation and
keeps the allocated storage consistent with the addressable bitset.

Exploitation note: local privilege escalation is possible on a 32-bit x86
kernel using the under-allocation bug from a binary with CAP_BPF.

Fixes: 9330986c0300 ("bpf: Add bloom filter map implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
Changes in v2:
- Address AI reviews.
- Split full-width hashes into a word pointer and an in-word bit number
  before calling bitops, so upper-half u32 hashes cannot become negative
  offsets on 32-bit kernels.
- Drop the redundant final u64 add-overflow check; bitset_bytes is bounded
  at 512 MiB once it is computed from bitset_mask.

 kernel/bpf/bloom_filter.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index b73336c..f111d26 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -33,6 +33,22 @@ static u32 hash(struct bpf_bloom_filter *bloom, void *value,
 	return h & bloom->bitset_mask;
 }
 
+/*
+ * Some 32-bit architectures take a signed long bit number in bitops. Split
+ * the full u32 hash into a word pointer and an in-word bit number so upper
+ * half hashes cannot become negative offsets.
+ */
+static bool bloom_test_bit(struct bpf_bloom_filter *bloom, u32 bit)
+{
+	return test_bit(bit % BITS_PER_LONG,
+			bloom->bitset + BIT_WORD(bit));
+}
+
+static void bloom_set_bit(struct bpf_bloom_filter *bloom, u32 bit)
+{
+	set_bit(bit % BITS_PER_LONG, bloom->bitset + BIT_WORD(bit));
+}
+
 static long bloom_map_peek_elem(struct bpf_map *map, void *value)
 {
 	struct bpf_bloom_filter *bloom =
@@ -41,7 +57,7 @@ static long bloom_map_peek_elem(struct bpf_map *map, void *value)
 
 	for (i = 0; i < bloom->nr_hash_funcs; i++) {
 		h = hash(bloom, value, map->value_size, i);
-		if (!test_bit(h, bloom->bitset))
+		if (!bloom_test_bit(bloom, h))
 			return -ENOENT;
 	}
 
@@ -59,7 +75,7 @@ static long bloom_map_push_elem(struct bpf_map *map, void *value, u64 flags)
 
 	for (i = 0; i < bloom->nr_hash_funcs; i++) {
 		h = hash(bloom, value, map->value_size, i);
-		set_bit(h, bloom->bitset);
+		bloom_set_bit(bloom, h);
 	}
 
 	return 0;
@@ -94,9 +110,10 @@ static int bloom_map_alloc_check(union bpf_attr *attr)
 
 static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
 {
-	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
+	u32 bitset_mask, nr_hash_funcs, nr_bits;
 	int numa_node = bpf_map_attr_numa_node(attr);
 	struct bpf_bloom_filter *bloom;
+	u64 bitset_bytes;
 
 	if (attr->key_size != 0 || attr->value_size == 0 ||
 	    attr->max_entries == 0 ||
@@ -127,21 +144,16 @@ static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
 	if (check_mul_overflow(attr->max_entries, nr_hash_funcs, &nr_bits) ||
 	    check_mul_overflow(nr_bits / 5, (u32)7, &nr_bits) ||
 	    nr_bits > (1UL << 31)) {
-		/* The bit array size is 2^32 bits but to avoid overflowing the
-		 * u32, we use U32_MAX, which will round up to the equivalent
-		 * number of bytes
-		 */
-		bitset_bytes = BITS_TO_BYTES(U32_MAX);
 		bitset_mask = U32_MAX;
 	} else {
 		if (nr_bits <= BITS_PER_LONG)
 			nr_bits = BITS_PER_LONG;
 		else
 			nr_bits = roundup_pow_of_two(nr_bits);
-		bitset_bytes = BITS_TO_BYTES(nr_bits);
 		bitset_mask = nr_bits - 1;
 	}
 
+	bitset_bytes = BITS_TO_BYTES((u64)bitset_mask + 1);
 	bitset_bytes = roundup(bitset_bytes, sizeof(unsigned long));
 	bloom = bpf_map_area_alloc(sizeof(*bloom) + bitset_bytes, numa_node);
 
-- 
2.47.3

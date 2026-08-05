Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E17326D4C3;
	Wed,  5 Aug 2026 06:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909781; cv=none; b=OS5JRzpH7agugy25s8Kfif2Ostrex0wtL6VJmrzIpW9YiiHlrZDy5S3N+pqLK5Tmf23ad9f2oQH5MOzIp5hil4XTecWw6cl3mdFP4ZQBpo4G4+tB0yFeRjBtyUcBvq5bMcILIXIJiLqfGO+6pQ/kv2EqVAE07R1DVKrS10aR25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909781; c=relaxed/simple;
	bh=bqDx6vb2FXNsrrRRxni+b2maFJZgt6iCLkQbug5HZdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fDiFNBBVWhHAkgz2hcs6AYdnysyXefflZEAAo86JhQ1tD7Z4nezpUgx84gQwvkqmqJebn1KoDh2Dd3/qS7t0vsv6PK4dkW5lfgwNRqoAVYzpic+c/fAiSJtAy7ukqkmwYSZ9ukrLt1UT461i7NAVlfcF5dCrN2QWPevqQ4VvGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=ePaADWnz; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="ePaADWnz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s5W4gQo3cQPXmeaei8VzoJ+1QXcSNANQYpgANPza/WM=; b=ePaADWnzBKMvo8O9pm45qFsJh7
	0xIBbonvzCDHguIdg2fpd6jg/g1dlXcnT+89b+PRJ9MyDJhw+P3u7fT5oIruQ2YRusjZac6wipg3/
	0PMm18pK3KFgbdXWZJYtUc9OnLcfwoQsZbcfIjQUaAJhdP/UgjRY9Br1Km30AExiyWJxHKac7/N7c
	uLlXXHm9LEqPdgQlt+nlSLvu/FCZxtyKk4ez63WWxymIQsNp2Y7gLccn3u/gClNv1LYCCP/oLcGae
	zvFfC2BSdAv3+AIoQC1lv68yvZh0/k6VUyQjMEz8faPC4IH/ope7iWLlUxDpbReXL0+sLV1qCEf0g
	TLCx98pg==;
Received: from [151.115.150.205] (port=52256 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wrUiR-0000000FZIP-0OFa;
	Wed, 05 Aug 2026 08:02:57 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: bpf@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v3 bpf] bpf: harden bloom filter sizing and indexing on 32-bit kernels
Date: Wed,  5 Aug 2026 06:02:28 +0000
Message-ID: <20260805060228.2703051-1-Jeremy.Jean@oss.cyber.gouv.fr>
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
Assisted-by: Codex:gpt-5
---
v1: https://lore.kernel.org/bpf/20260731204917.3845309-1-Jeremy.Jean@oss.cyber.gouv.fr/
v2: https://lore.kernel.org/bpf/20260801083436.4014218-1-Jeremy.Jean@oss.cyber.gouv.fr/

Changes in v3:
- Address change request simplification from Andrii

Changes in v2:
- Address AI reviews.
- Split full-width hashes into a word pointer and an in-word bit number
  before calling bitops, so upper-half u32 hashes cannot become negative
  offsets on 32-bit kernels.
- Drop the redundant final u64 add-overflow check; bitset_bytes is bounded
  at 512 MiB once it is computed from bitset_mask.

 kernel/bpf/bloom_filter.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index b73336c..b63839d 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -41,7 +41,8 @@ static long bloom_map_peek_elem(struct bpf_map *map, void *value)
 
 	for (i = 0; i < bloom->nr_hash_funcs; i++) {
 		h = hash(bloom, value, map->value_size, i);
-		if (!test_bit(h, bloom->bitset))
+		if (!test_bit(h % BITS_PER_LONG,
+			      bloom->bitset + BIT_WORD(h)))
 			return -ENOENT;
 	}
 
@@ -57,9 +58,13 @@ static long bloom_map_push_elem(struct bpf_map *map, void *value, u64 flags)
 	if (flags != BPF_ANY)
 		return -EINVAL;
 
+	/*
+	 * On 32-bit architectures, hashes larger than INT_MAX would be
+	 * treated as negative by set_bit().
+	 */
 	for (i = 0; i < bloom->nr_hash_funcs; i++) {
 		h = hash(bloom, value, map->value_size, i);
-		set_bit(h, bloom->bitset);
+		set_bit(h % BITS_PER_LONG, bloom->bitset + BIT_WORD(h));
 	}
 
 	return 0;
@@ -94,9 +99,10 @@ static int bloom_map_alloc_check(union bpf_attr *attr)
 
 static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
 {
-	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
+	u32 bitset_mask, nr_hash_funcs, nr_bits;
 	int numa_node = bpf_map_attr_numa_node(attr);
 	struct bpf_bloom_filter *bloom;
+	u64 bitset_bytes;
 
 	if (attr->key_size != 0 || attr->value_size == 0 ||
 	    attr->max_entries == 0 ||
@@ -127,22 +133,16 @@ static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
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
 
-	bitset_bytes = roundup(bitset_bytes, sizeof(unsigned long));
+	bitset_bytes = BITS_TO_LONGS((u64)bitset_mask + 1) * sizeof(unsigned long);
 	bloom = bpf_map_area_alloc(sizeof(*bloom) + bitset_bytes, numa_node);
 
 	if (!bloom)
-- 
2.47.3

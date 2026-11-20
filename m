Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177013;
	b=UOnDXVPlTDnurSEw+CJ3ddoim5GW8RFeMWwq7B8qprjarSd9r6gDynTSaZd/jImGrPa6
	 48wUsRVnpfdcG2jkakfV6QOWGoaquyqAH9MMVTVN1njL8+LTlld95yp1jkQbv4cwPlUhD
	 n+Yt+MWzcZRVw1Uatci4y4bc8ExJwqstr5c8akKPIoZwj1tjkr42LNlbw2yHyXuRUJ4iW
	 cDAGF0BKKXcyUMsiOXqixYwNYje4p/4t48sDxgLxdcjAkmFegOwxBSuPSTLMxGexpjz5e
	 ZWmh67vSrOHLeeadsZ4oWmECsuenIxbKRG66zho/fTbqAyMfM4mQy2tfBJbnhfHZ3Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177013;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WFGUsPib7UYtVJ1BiXTL9SeVte53OesLIVWmVAJzm2E=;
	b=eLE9KLBJbvt81R1Oy9JqsAaUO+P09EONroTv42fYAFleN3Wx0uqakijEVLmyI6pjJQec
	 q2IhvIw4MA4RvfFnXOYwu9vEJq3oEjPNZH/mdnWAxSHyOoZUwfpbfaEJXEtccQL3rls+/
	 mbVkoVy4lxNzGhs0TdeVmGMQy1j3lZhC+HzWyers0krpDcseUj/R4gJsBSnyBBMtS+8le
	 pQmTa5do4WU4LyLn2aoN648mbPlFffvTaAITkkoty9SqitEQEmS2XvieMb2EnLwVE8vAN
	 alP3SpifA3HUXFH++XpVuOoWB/ljwuCCieJiM/fUpV3GUPNXz/yYdVP6yuof0y1XYyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="U/QsRWSw";
	arc=none smtp.remote-ip=95.215.58.68
Received: from mta1.migadu.com (out-68.mta1.migadu.com [95.215.58.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37E606A32C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE37E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U/QsRWSw
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rMvHJji9BqzVdUvxXHqbG2A1RgJoNeZr1+rKa6jfFow=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795177011; v=1; x=1795781811;
 b=U/QsRWSw6sPavX2LMNl6AOJB6QRTZj2R3aBovDpVN1qqp12E6GKYJW0v9Z+tvXJt9x1PfXql
 ydpRhX7JUUXv+dUfZfdY/dh5zszYlEk6tjpCgtq+COdg64wpP1qtzB1HKepYrWDLjjgdRTdIUgX
 mKaSmZkYd+GcbneWr508BWZY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d94a9313021c98ac;
	Fri, 20 Nov 2026 12:16:50 +0000
X-Mizu-Trace-ID: d94a9313021c98ac
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fuad Tabba <tabba@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] arm64: mm: Add an ISB after remapping the KPTI page-table slot
Date: Fri, 20 Nov 2026 12:16:37 +0000
Message-ID: <20261120121638.194154-3-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120121638.194154-1-fuad.tabba@linux.dev>
References: <20261120121638.194154-1-fuad.tabba@linux.dev>
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

kpti_map_pgtbl remaps a temporary slot with break-before-make, and
kpti_mk_tbl_ng then reads the page tables through it. The make ends in
a DSB alone, so the reads can fault on a translation of the slot made
speculatively before the new entry was written. With the temporary page
tables in TTBR1 the kernel's vectors are unmapped, and the boot hangs.

Add an ISB after the DSB.

Fixes: 47546a1912fc4 ("arm64: mm: install KPTI nG mappings with MMU enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/mm/proc.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 12aacc74f7647..7ca36d59bf77f 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -262,6 +262,7 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
 	orr	pte, pte, pte_flags
 	str	pte, [temp_pte, #8 * (\level + 2)]
 	dsb	nshst
+	isb
 	.endm
 
 /*
-- 
2.47.3


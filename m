Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793294620;
	b=N/e+7NOFjihKWgvbVzBFvIH3sKY1pM/R1Jc0IrTkC7Gejf7mP4SNAh2mpo9GgXoBS2kZ
	 RaXluHyzOFsJDHNptkCEVnPGZbRYkpGjeJo1Ec+nzoZWCL1lWWMfJB9TaxY2tvxN/HLi8
	 pO/Oq2vsuaqM0KpfreBxXjPIg3vxNEGVIPjd+/yhRvGtQXAQtt5uC/QvZXxWxjCrQlSsO
	 LtqHRSK4jR1F0Xb+AgB9CqcMTMzomzs4ZS0pKdQiXe5Wl9iNZVzaBrFeC5n39rnX2tg8k
	 fcT2/ss7owqdsiAO0mlYNdZ3EDUoU9S57H9lZDP+qy6Cxu+I1Ommy6qZbPKx0TgSWgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294620;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=2eiZj4z0YqxczDZhTP4xk2y8uh1O35jeXRePIqjNdtA=;
	b=G2s4oQFyFcOcYG2ZSbi1+6DF88Q0V+AjHC7k4vih7O+loNOUfAebNJ+dk1bw5b4UGVg/
	 pbxC7veX8EQynFHN3x5kFqvA105KJiwhiijfXgS++OHjtVZ79v5R0IsYfcPRECqto8LHp
	 hnHx2lk6WtdHYg8OKoJ0fqUzZA/kmOFEzqIPE7mU32aMe3BrMf188VhneoibfdnXlgJww
	 a2bNxXWBfMO/L+lpTYIGImaClrLyR0iaApJTsVmUv+nrJd+CywsGDI7btWBUv/bep5yie
	 VM2DqeLKy5sIBptDhj5t8sl6kd29QDMKq+pxqvbkr2rp9n6sIkgs7tSsw4gpSDHyozQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tKqbDw0k;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D8606A31A;
	Thu, 29 Oct 2026 17:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 566D8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tKqbDw0k
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB56B1682;
	Thu, 29 Oct 2026 10:23:28 -0700 (PDT)
Received: from gaia.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00DB53F59E;
	Thu, 29 Oct 2026 10:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793294611; bh=89SvGZ6WMPqFWYQKrcmNz6K4h0a9xvHSBOWe1Dr2QQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKqbDw0kJstskDmn46lt05CuTnjC3aInPTR+oCreDFmV1TDXRixNV7gQs9bvaolno
	 9vloIPpeqvvl/gryOc82+JKTrXA3ps7tBc9lEcHzJokLGtsLKIA/dqPhL2aktd6nV6
	 FD7SXq5tC9XzlvCsLzMdG06RdEwDTzqfLK4CFf50=
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: ryan.roberts@arm.com,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	lance.yang@linux.dev,
	mark.rutland@arm.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/mm: restrict transparent contpte mappings to valid PTEs
Date: Thu, 29 Oct 2026 17:23:23 +0000
Message-ID: <179329460319.2444743.17610856580354729996.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c4c33aaddf5741e125e4130f2220b1892b50aa61.1792756709.git.zhaogongyi@bytedance.com>
References: <c4c33aaddf5741e125e4130f2220b1892b50aa61.1792756709.git.zhaogongyi@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 23 Oct 2026 20:12:33 +0800, Zhao Gongyi wrote:
> The transparent contpte layer treats PTE_CONT as software grouping state.
> When a valid PTE has PTE_CONT set, the contpte helpers may align an
> operation to a CONT_PTE_SIZE block and operate on the whole block. The
> current single-PTE helpers use pte_valid_cont() to identify such groups;
> this is a helper contract, not an architectural restriction on using
> PTE_CONT with present-invalid descriptors. Explicit users such as hugetlb
> manage their contiguous encodings separately.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64/mm: restrict transparent contpte mappings to valid PTEs
      https://git.kernel.org/arm64/c/486d396b19e9

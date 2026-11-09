Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234468;
	b=CI3UhidgyKhbiH1dlG4I4IALAdzIgYZT6/S3+0eONAMcsyCRGpZA4PYyOK6LelsX7dwd
	 qMquchOJgj6wkXwRmD70yB6fucJCFTduqeZYK9DHBJ3ORBeGWyFcGJOI3RZp9pj1/p0aV
	 6vVs0QjtlIbArVh+dBhWRm/Pcap9oEQu/LEtkd8Q2oTJPRDYEkRhx9+CTffm5JAtE/tMt
	 tFLOcNsQIOilWXCcQ+Tu8wdW6X+Zr6x75zoegEPI0Cx/CVH1k9P6RjM9L6P7k/yswejUL
	 rk3JJPDv54LSZPir4gXRGNSwnfKVQ7DADq63oome5LCwD1yQ2ua0OzVvqjKu/HkIDZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234468;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=JV2g1MGII6AONd0SSqvxC6iZBiQWfA6j1ds9TAhkTTk=;
	b=HJMDkALqLJJBj+wal+O8O0K1P/VF2tYqOQopeVPE5RCHFb/zQSgluWUnTAkscOdKBKy5
	 smw9GRiNXRoGZtfSVwyjIwOV11BF1DAW4gNRpbzoy+hSR3egn3m2gRZFMA+HN8Bo7VuC7
	 a2psVY7ormUgCNMyR+ZOXT1gAzFglj1H9wSuznXHoMHNtQqCEyfRIrA8VpIltbVYSanDc
	 dqGQnEASh6UQYPQi1U3d6Mf7OKbvzDrjQ/5PXH56Sic242j/6BaB7ffPZbbgwH6ikDlyQ
	 foGCNbRdHFdqVSLl+SskUUAPYwR5lJ7Ymkwsxi+Rk+kX6yQ5CN+3e9tEpn5n8wWCraQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AN+9b0iy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF4606A31C;
	Mon,  9 Nov 2026 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AN+9b0iy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0751F0089F;
	Mon,  9 Nov 2026 14:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794234468;
	bh=JV2g1MGII6AONd0SSqvxC6iZBiQWfA6j1ds9TAhkTTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AN+9b0iymNq3EFk/OjlrnobBewX4SeN8Cnv0ZcRTv20c+YxXZACx1+E2hEhEPIIhc
	 4WMrsQYpnJQEM688BOC9by03rPF2l4Pdlx8tgyPC0gzLhynRlDXLLs9JKvfY2Uyqmw
	 6JIV8V7Chmefg3Lnu8h4rs5048dpwR8xHPMrJmoK4SBrLBefLW/wbMsa0PoXU5+ym4
	 l/Nf6NQVS4ogUssygSp6MbLssLWM06crHDyrK1eeheTrX11JC9AjxvE5rwPb3qFAMU
	 hMxETBoWsuEe9xUkJz7963k1hNkAXjmEEFgT6UL7be9pnO77OHYw4/QM9PYHoLmUFT
	 1dazOiMaxGeig==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Hugh Dickins <hughd@google.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261106-khugepaged_set_pmd-v2-0-d2457b5e377a@kernel.org>
References: <20261106-khugepaged_set_pmd-v2-0-d2457b5e377a@kernel.org>
Subject: Re: [PATCH v2 0/2] mm: free unused page table allocated by
 do_set_pmd()
Message-Id: <179423446371.18983.12929879882545410707.b4-ty@b4>
Date: Mon, 09 Nov 2026 15:27:43 +0100
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Fri, 06 Nov 2026 13:36:11 +0100, David Hildenbrand (Arm) wrote:
> This isn't super urgent, so it can wait for 7.5.

Applied, thanks!

tree: mm/core.git
branch: core-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/2] mm: free unused page table allocated by do_set_pmd()
      https://git.kernel.org/mm/core/c/e5111d38
[2/2] mm: don't allocate a page table under RCU in do_set_pmd()
      https://git.kernel.org/mm/core/c/bd4d4f8d

-- 
Cheers,

David


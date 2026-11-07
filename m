Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080003;
	b=h0PoNZTXQxxvPr41OJawhEeMiHddnPZbOVDbChn2JYw0kzf98yL6QAK3t0TlFSbMFssC
	 C/emmuqMyAzFBVOgHham4laN8bZBWKOCg/cNua9iSR1K8FfZkkdStk+X/nwBScKHHdcaC
	 Ka9YPkeTpw7c79ys76ooSzBdMQcA8wRmRwqXUNNBWOolyf/kIcRBK+MKEJCCLkgROtTAn
	 BrOL7p7RLqnrZ1JNlNnLMc0DkQqTMOh3XeozE/V4b/fHzThWAZ0gf+/MbTHvs5huInWL6
	 6mZLTyIyGpfj90hnPl4pl3RdZU/r96TtRRfeChMKpWCpk1/UmvOGPkgQVhtvwH2vtdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080003;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=aUxj1eB/EyE2xuv+24/5uGP9CxShlT7sfivuJJSfDgY=;
	b=IqbVqj9WngVJ/fKJG++J4zdM5++WqeggL/AKqdKFFQ9B0XbPTcAoEvgaQPkgupNf4jfG
	 TOH4VcC5tY0fmdXZq5emelojSZgHAImAwzFrec4/F7ewR6f2jrFkyUbH1O7S9C48qM0si
	 SPicWgcFuaK2RQ+qA+wMhm8FbfKrG2Pqa5RAO3RVgBnApgNOfiejdAzOnbwwlCRDvKied
	 bDDzUisN8NGadTahKcWzZFloT/mWDs4YotRezdlKvpt0pj/km7Zm+LxOFGnGY1j7pR0zw
	 SFxdrNMLIDb2AC7crLpOSviLDx9ERvGKirbaptwLyeu8orzvG54DzLWk1X3GhWVFXyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KG/smLcC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08804606A32C;
	Sat,  7 Nov 2026 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KG/smLcC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A691F0089F;
	Sat,  7 Nov 2026 19:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080002;
	bh=aUxj1eB/EyE2xuv+24/5uGP9CxShlT7sfivuJJSfDgY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KG/smLcCXGWOMAnnLNh8eHoPYGqC+IC2/UbAcIvjDWbG04Rqzmu46mOn1zJJJITkk
	 fkaF1+q3DDz7vxdCQIH2nTmEj6QuRwsurtADWxrhtp9ubrZJreAa3wE2rs0cuieDW8
	 KDQnhF2pPPrsmkmFEZqGJ1wubxJ9q9gySUKVoSpbLnbMrhLDIySYqA3SQP/PUkI99P
	 z19RI2+L8N5+HXj+Ot49b6ln6loj6qHJC6YpmzVLXGZ5HaMlK3QfR6yoiVGpIJUjed
	 i8/GQ4diTppsbv0VVh4QRG2q78RGw8vJZHWNdiFcTd3nGGt829JjzbvASidUdOH3jZ
	 4MyoTSwlRuYTw==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Hugh Dickins <hughd@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Zach O'Keefe <zokeefe@google.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
In-Reply-To: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
References: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
Subject: Re: [PATCH] mm/khugepaged: don't map folios that are not uptodate
 in MADV_COLLAPSE
Message-Id: <179407999817.4465.376927481020440241.b4-ty@b4>
Date: Sat, 07 Nov 2026 20:33:18 +0100
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

On Thu, 05 Nov 2026 19:16:44 +0100, David Hildenbrand (Arm) wrote:
> madvise(MADV_COLLAPSE) can map PMD-sized pagecache folios that are not
> uptodate. For example, shmem fallocate() can put such folios into the
> page cache.
> 
> collapse_file() already refuses to proceed with folios that are not
> uptodate. Let's just do the same in try_collapse_pte_mapped_thp() and skip
> such folios, leaving handling to the page faults.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: for-next-fixes

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/khugepaged: don't map folios that are not uptodate in MADV_COLLAPSE
      https://git.kernel.org/mm/core/c/043a2260

-- 
Cheers,

David


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015055;
	b=GTdkZ8WMUjMBKfLST3q7LtZkTnCjBhirzweqV+gTMnoe0qitnIZs/xdaHjCeyC7IEMJn
	 J54VkM/8oa6rHfw7Nc/Ssfie8uP3zKDhR3aRMjERVnnm72bDNCMqNpXAJk2peADrRR0qB
	 XPKi8bycrGwQ8AQdk0VhFi0Pmj1xqy4pGjUGral82q+ZfunWvrr6jud084vyItm3Q7hU4
	 Sxx83cdvaVu1E4uhaVVRb0SLtJhLj/KE7EYWWacJonRCjPRadGwQ631mgg21M2AZb8Dlq
	 P7mFrniNKas7odD4zlMiIIHT9869jbgr4u7olvXUwZWdJTb8qAipA0uOBsuYa5/ghLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015055;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=9eNFjz8eGoaFkh5ByexY9gtwepGgk8JN1OSK8KUSAaY=;
	b=fDcor9TshrLxSjRmenZaHeySMLipAeRw/EUTu2P9TU3A0vt8v++4C9M7c38tQpV+EiB+
	 S9pB/g9rmpiO8eSSr1CYoG5rI+mQNOjk9DqKlwlN1KFp3tX0eDFIUYcZlXv0izrtzRt7u
	 Cbtwrs265T63IK9A7LehEicyzHg7MVjc/XCXITrxUPMkk9NDfbz0Pik6JepCw9uspUyNZ
	 0cdyTnTU75K/JfaHmhcf5tz6XOrkb18feUIIStdoVidMqUxlOVpvg77b63UJKaCbJ393h
	 WHMoJKKHWA67v4ftJClRLYG67XpQOLjvb8gs0v1yq8qQOd7hV+iu0gXxMk3QLX+8Xmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+E3VNgm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5DA606A31C;
	Wed, 18 Nov 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+E3VNgm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE121F000C5;
	Wed, 18 Nov 2026 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795015055;
	bh=9eNFjz8eGoaFkh5ByexY9gtwepGgk8JN1OSK8KUSAaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=K+E3VNgmUZ1CtEoIBgh+MLhkxySu15WxG6psA0t/6HrkUXxiH5y8ElLlMW7mU15+1
	 unb0Cpy1bOEi+FwKaWVQUHRKherIi6ozV1MQHOdHT1e+XKFi96seRY+ixDpN6yzUhp
	 LEGJ2Ym/5H4pl+484Qy4zhkH1GmXbrH+l3Wg2wt+wLIZmi2jG/8DlnCNPM/Tb3sWti
	 IlL4dTvvc/IbG43lukUWr6CBeo/sto0yanSZSBgslZiQZu+NT0lbqY1pFZJIMcdlXn
	 KCGe4Tr0Zd8L1xyjR/7poPi0WPQ1unsz0iJ1gRYcH72G4wc7v+bOBHVmjRM1B4L/2u
	 5OmhGoPCraD8Q==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
 Roman Kisel <romank@linux.microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Naman Jain <namjain@linux.microsoft.com>, 
 Michael Kelley <mhklinux@outlook.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Eliav Farber <farbere@amazon.com>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 "Gregory Price (Meta)" <gourry@gourry.net>
In-Reply-To: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
Subject: Re: [PATCH v2 0/4] mm: fix races between huge and non-huge faults
 in PFN mappings
Message-Id: <179501504807.12832.2222363605872715262.b4-ty@b4>
Date: Wed, 18 Nov 2026 16:17:28 +0100
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

On Tue, 17 Nov 2026 18:31:31 +0000, Lorenzo Stoakes (ARM) wrote:
> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
> 
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
> 
> [...]

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

[1/4] mm: update walk_to_pmd() to explicitly return an error
      https://git.kernel.org/mm/core/c/977781a1
[2/4] mm/memory: remove racy huge PMD assertion from walk_to_pmd()
      https://git.kernel.org/mm/core/c/dffaff24
[3/4] mm/memory: do not report OOM if insert_pfn() races a huge fault
      https://git.kernel.org/mm/core/c/6aaf0015
[4/4] mm/huge_memory: only compare PFNs of huge entries on huge fault insert
      https://git.kernel.org/mm/core/c/bc5cff91

-- 
Cheers,

David


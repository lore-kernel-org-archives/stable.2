Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950538;
	b=Py64zDlw6PjEOJ6wccro56ENmZph+1Phmhm7aZZNaw38wQcEiAI1U3rVqQYutYAU8UDk
	 ly5gppJ6dvKmYtUiBnj+EdlHpFn1z1IuCicNCZ2SABA/X/QZ/5SzIYsi0juiWwLfIsO4W
	 H4QOw8oHSFUPYPm3iPi7ydso0Ik0nN8W4iyYNp+RjBysJhwpr09j4k4GUeDKcB4VZJP4r
	 l4LhsBgRkqj3MOoZBERYv9t4He9OzE4ljuKnL/QlFnre2YhX8ZENVO/4DO/62fubqKTFH
	 bn2q128t+0Cxl2AqwAcXH2FHByuS4Q7X5cWdv3T5Yi1y+NnltTt49XxP1mXnu9d3xMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950538;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=FeCT63aSkz/VhoJT6891eWVwy4XaOtOt1ms2iF5hk/M=;
	b=wFhDMhpuiHe9xxcY0W69qWj0oQQ6teCvOIGCa8RBHBc4zygD+ZlNIAPaO9W/ONaRTn+0
	 /+bTIZwBFy2QR6Zk86OdZpWPwCHtfd51ZC2cto/89VGCHU3PXfe3mFicwFx/EITW8pcv9
	 cUNQrg1db99JZ6EHk/QrfcIEY8lXoD1Q6KvDIRStZ73j21sdF692GfR2xr9KCuL396b2l
	 6Q9E+u4yFz5T/rk5VKOnwQnoU+tE7SnDdgoxrarFkX6XYLHBtlL3MJFL+gfyHHKMjBADe
	 G4lTebsJHb46tYTRd2BOpVsr4qkaNpwm/UiujGE9OI0WliVXAVAGHl7stX+QfcZKVAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C26y9o1+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B436E606A31C;
	Tue, 17 Nov 2026 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C26y9o1+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BCA1F000C4;
	Tue, 17 Nov 2026 21:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794950538;
	bh=FeCT63aSkz/VhoJT6891eWVwy4XaOtOt1ms2iF5hk/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=C26y9o1+nWX5rbIxEPoTXu6eAf4pOY/zxhGIIxnY9lboROWO9mDJvV1O4TONfP/pZ
	 QqXdWdHGUxi1GCKV5ysDzii9d0HhWEINL2pff3pA3lj7kIwRGo0yji4nVz2ewPSDVY
	 TEz/gfWJfuY7IqmG80r1CmprsRmkoDkbUVWVRzILMQqjm9YXd+vNUV9hRQiSit3pIG
	 pbY/VvZLcp7UOs5XpARuNFnsO05dcz0v4nMEw3YfRSdc+d73XC8zvUwjgqOm+s7TfC
	 Oh63dpOURFQ3sRV9KMKcXACtnQzqUNdbIxidyBqn9780GD++3ohF25r2kIM/Q8gsVl
	 OskHUcArEm3Wg==
From: David Hildenbrand <david@kernel.org>
To: Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
 Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, 
 Ross Zwisler <zwisler@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
In-Reply-To: <20261116-dirty_file_pmd-v2-0-571883053174@kernel.org>
References: <20261116-dirty_file_pmd-v2-0-571883053174@kernel.org>
Subject: Re: [PATCH v2 0/2] mm/huge_memory: flush dirty file PMDs before
 removing rmap
Message-Id: <179495053051.3499.18428844631976887655.b4-ty@b4>
Date: Tue, 17 Nov 2026 22:22:10 +0100
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

On Mon, 16 Nov 2026 16:06:57 +0100, David Hildenbrand (Arm) wrote:
> Details in #2. Now includes a fix for a preexisting issue on UP in #1.

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

[1/2] mm/mmu_gather: delay rmap removal on UP as well
      https://git.kernel.org/mm/core/c/7faf889c
[2/2] mm/huge_memory: flush dirty file PMDs before removing rmap
      https://git.kernel.org/mm/core/c/5a1f5d89

-- 
Cheers,

David


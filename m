Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434125;
	b=x8Gw9dEbybDboxGHI3pt2sZGnMPxh6oDLZoKcBi64F8JAEG+e+E1PRYftnDNBTLGS6ER
	 1+mZlyZuVs4dOJ0VQ9vnUsac5T8ImPWtSskst8g8LjxTIwGk0B+7kZv5Cv8RGY3ykan+X
	 0wMhh7ipkj3vQK8kdxMg4I7PP0NxdxB8X30hYixxDmy0Zz17x1HdaAicnT3FEOLzRSHQr
	 voJaQCoDJ83Jy0MdK6K/eKICfaL/u+UopKnfzMRY47bXLCd3in6joN5NWaF9TWNO8YalD
	 6i3PvQWDcpPcvHgfJc4AqKm1+f0Xqwxnx9OhteedaHTJj6YAS325ny4tGHTDywk3OyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434125;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qLp26Bg4Pd0p7gbf5/aWtM4oGih2Jh60tTYYWo9cLoQ=;
	b=2WsmTkUCz95fmIcQxOhijIstzugyYs8Z4pLhQnXWTAZhvhwy/cLowRlSbKbE1qSnrwxV
	 1PHpPPta8pbS+Sqp5aMXADynhMtG1+K+Su2QiD8w8fVgOIcMTrM6fkfagwxo0rHBoalIb
	 oRqxqD1JDPA6MpL98uMmk41EQ6enFW6/svedeQi/Agbrzd7qcADGillwLpFaB08DYGVWC
	 UfBqPgZE0p3wQJxuEiDOy4uP61Si0Iw5Y8qgEaCP+mJVgGHyfr9uT33cVD0koBbCEfDqL
	 hnMdmY81tKPV704parC6AvSfQUCbeGZbZb2/4c1Z2rb+kiOjY4gqlTFJ69bWRZD4Kog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+v4sFDk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53475606A895
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+v4sFDk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AAD1F00A0A;
	Wed, 11 Nov 2026 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434125;
	bh=qLp26Bg4Pd0p7gbf5/aWtM4oGih2Jh60tTYYWo9cLoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z+v4sFDkti2qhtA3nJtE4pWrOGNAFj1gXAFO68RtFVcOarJkB3fLX28fGH32hZCxP
	 5BZQON2m0pwr0jWxCZQQOFdHf083mhf6h5RQ1XBHjM4YlcEbXxx5uSWZwMB5GR7T9G
	 uWXGef7dyrFxpVwUrj1xo+sZnftgY4vM65v5XMOBE3IDLQh9LtsxhS22CesC9d9Cwp
	 ZxCOxE4GpszIbDJxKhYA/DVspn1ssF81YpQCEoSGKVTvypJInZ/Tv+PDZoiSKrwL1r
	 NOizZM8aoUpMHvLLRyBy8PXwMYcAS9FTZEeOlmSYaLy3BsaRelBECE+rb2LpV97wMX
	 eux0851/zlPxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Samarth Narang <samarth.colleges@gmail.com>,
	Lance Yang <lance.yang@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	=?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Brian Geffon <bgeffon@google.com>,
	Denis Plotnikov <dplotnikov@virtuozzo.com>,
	Doug Gilbert <dgilbert@interlog.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Martin Cracauer <cracauer@cons.org>,
	Marty McFadden <mcfadden8@llnl.gov>,
	Maya Gokhale <gokhale2@llnl.gov>,
	Pavel Emelyanov <xemul@openvz.org>,
	Rik van Riel <riel@surriel.com>,
	Shaohua Li <shli@fb.com>,
	James Houghton <jthoughton@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	SJ Park <sj@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: Re: [PATCH 6.18.y] mm/ksm: fix userfaultfd protection during merge and unmerge
Date: Wed, 11 Nov 2026 16:54:59 -0500
Message-ID: <2026-11-11-1-daily-reply-0026-04883abeb32ad63ca89c@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111082809.32654-1-lance.yang@linux.dev>
References: <20261111082809.32654-1-lance.yang@linux.dev>
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

> [PATCH 6.18.y] mm/ksm: fix userfaultfd protection during merge and unmerge
The 6.18, 6.12 and 6.6 patches are based on released stable and do not apply to
the stable queue, which already carries 2efc6332f18b ("mm/ksm: keep soft-dirty
when merging a page") in replace_page(). The fix itself looks sound. Could you
rebase and send a v2 with the two uffd-wp lines placed after the soft-dirty
block?

The 6.1.y series for 990d6c2194a9 ("mm/ksm: fix userfaultfd protection during
merge and unmerge") applies fine, but it has to wait until 6.18, 6.12 and 6.6
carry the fix, so please resend it together with the v2 of those.

-- 
Thanks,
Sasha

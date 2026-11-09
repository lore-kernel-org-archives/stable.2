Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227545;
	b=DNlSGuYyfCCZEhGku3M0A9VtGyCWpmKwaGrdSo1aUtqSyTn7S5YzIFrwuxPS4JncnyTA
	 7uftMq+8z8THFDKULEYcTfsxqaDCv6zAMXdiZw628yUlpuKWQEY2Rj1+LaD308lPsvJeo
	 4qnJGBxGdIphe9NbuWZC5NwcZPtD3YHd29NBpjz+vd7UV87weLq2LixuUTHAIL3QtV4xX
	 z6BnkB0HpHjPqE+eBuop7VM8B91PJinPWhp4DsU31Fsu4/F0ikwv6b6zdOsneFZZKk7ud
	 PuU3Qx4ce4seRlmBrI2lTPArmP2ZPt7ck4xszlh7k8kzb7A7Kx5+GEftX4mc1cNzAoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227545;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=VlFyDRL68yzv0Vgmoy9MTx56r7nZBApHYwIR8O8rV2s=;
	b=08pMnp4kXYnlIaamKKXWH03wrHE8tSYXJ6GEOjPaIj0syLfH4HCi36O6tYV3TxXaZYCH
	 l0jX7wTf2G3xX8dnjkR18b9lc5TOEhAE15Tc3ufrXcROKYQsq+jx05fpbleYbN2/vDgH2
	 P3PhgMEGYmm0llVERIQf3yIqB9Ed96Uv3K7WNkpEJTHja9T3hNhUoJYoR8741rTyT/dBe
	 bp4xtKsuEGza7KJtZoCY8akT0OxaUKcmnkC7+MkLoMuBb4a6j8kNYKjlsFwHvbFJkINz4
	 POu5m+IrdvSUqgRwpmOoYaoz6idgJxiD6HVgmspQ7iSfRtB1dVLGdXkgK6d6AMsJ1tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlgVS065;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A4606D838;
	Mon,  9 Nov 2026 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlgVS065
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C9E1F008A4;
	Mon,  9 Nov 2026 12:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794227545;
	bh=VlFyDRL68yzv0Vgmoy9MTx56r7nZBApHYwIR8O8rV2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DlgVS065/RaB7JFKsxLb9aYRFBXW7o5Mem6V+HH2grHzdJ6C5lnB8eUrr3CXAXqme
	 DIzI4EtymtHbwc/qRn7tVb7xeGsRexOug7H8m/0trqdMVwGvYBhXvwkEC0CL9Q3mex
	 H28978Cpee/AkyYlRtxWk7BxlDpPXBhpO614sBIL+1KQfFLJBrdObJcviV2J5pITtJ
	 leZDeZr0SoWajOuwiRbc7wAs44/HtwyxwY3qrTQLIr1MOLR5WPfkXhAin865dA7FCD
	 JBX1pxx6OOwsGV7QxFDPhRh1Z64lyASChkg4QoVpWuddtaIJ0RKdDS7wFrPvXftIGM
	 m5F8JB+dm4Udw==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
 Chengming Zhou <chengming.zhou@linux.dev>, Stefan Roesch <shr@devkernel.io>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Qiliang Yuan <odys.yuan@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261108-bug-mm-ksm-smart-scan-align-skips-v4-0-86be8fe77e7a@gmail.com>
References: <20261108-bug-mm-ksm-smart-scan-align-skips-v4-0-86be8fe77e7a@gmail.com>
Subject: Re: [PATCH v4 0/5] mm/ksm: keep smart scan from losing duplicate
 pages
Message-Id: <179422753967.4976.7051945485845554420.b4-ty@b4>
Date: Mon, 09 Nov 2026 13:32:19 +0100
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

On Sun, 08 Nov 2026 20:22:49 -0500, Qiliang Yuan wrote:
> With smart scan, which is on by default, two identical pages that become
> mergeable some scans apart can stay unmerged for as long as they live:
> each page times its skipped scans on its own, and once both are old they
> may never be looked at in the same scan, which merging through the
> unstable tree requires. This was first noticed as intermittent failures
> of ksm_tests "KSM NUMA merging" in run_vmtests.sh.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: ksm-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/5] mm/ksm: align smart scan skips with the scan number
      https://git.kernel.org/mm/core/c/2b86234b
[2/5] docs/mm: ksm: describe how smart scan picks the scans to skip
      https://git.kernel.org/mm/core/c/53ee57e0
[3/5] selftests/mm: fail KSM helpers on short reads and writes
      https://git.kernel.org/mm/core/c/78509845
[4/5] selftests/mm: move waiting for KSM full scans into a helper
      https://git.kernel.org/mm/core/c/579d9b5a
[5/5] selftests/mm: cover merging KSM pages aged by smart scan
      https://git.kernel.org/mm/core/c/1c3db177

-- 
Cheers,

David


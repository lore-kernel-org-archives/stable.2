Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080137;
	b=u4+b7pBKkMpfvu9jpCqDfq5+gnx9wlptjZTzROlJIr5i0KiRPf1vZ/vNeznU2e2yKJz3
	 cKmss0HQSITDIy4eRKHzk1sybIvzWV+ciIjhStSPCQC5LJi/p/QuLq+ZSU/3eFp3L6Le3
	 vIWKrPpIdjSFnV+WMsuvk1uSCrDrlepQeR6wsnewkWugIybFGrFg4h8B7xt8eW6vwGEte
	 UlmV4KKZYpsM7hHKT3nSd2p+e9QgSIMkqdxhWQyQ426bwpdY7Y9zRvUF+vLJfnlNslwNA
	 6VukyxTHiHlZ3u6jJgaIMYlm9GPeHs58y2eKq4s537n+zvMfzRjmxWNBrd582S1W6bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080137;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=y91yUk3QMpxcP22L5RRZVkCw7buIe7KPREWLseYyt3w=;
	b=i756A2u9KNn5jdm+RFgpOQ45EQhMDAoEeFswqYYVDCL2EuVERAY0AX50eIkxP1hk33HV
	 1wKu6UB+A0fW5o6Wk4pFcOTfNseNtda2lFh5gFtHzAEX+1mDY9bxpiv0UARUQXRhWA+Vd
	 8oYO4dmV36mUQaWinTNVKz9q80y5QyXlsuMtrqNmjkqmRrJ+MciXvvc8uPle+J6thZvmN
	 dO16+oVJ5NS4pZdxpME2VIHW+N0mAqs8xqVFdLMW25eUCGxKRmTyAKwpBfOlK9HSGGWr/
	 q0hP8E9uo/DNbZmlXiUo5zd1lTmMPnd8OYgFlnPWvBGqdj8M8pVCscTUjNNZhdSKouA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1DElYiB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED5606A326;
	Sat,  7 Nov 2026 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1DElYiB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3303E1F0089F;
	Sat,  7 Nov 2026 19:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080136;
	bh=y91yUk3QMpxcP22L5RRZVkCw7buIe7KPREWLseYyt3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U1DElYiBCAwYNb5lvnlydTAg+Zx/qbjkhjIeGQqYkRaeyYdOGOECsJgFK+4t8mPgz
	 kSt884AE/XerPp+N8+qYwVKaiR7Y+UBvrDNbEktuXsk/Xw1sG+J6lpGyEsAfVnGSl0
	 YEfZXo/fqEJ38p5kWs935lTGr8wM3oN13+H8uwh1njL/1jfNF5zSefgdLLvi4WYT2x
	 HwD0lTfeJm+z49lcXZYMhkBUBK/8Ev5WTvODQmBd19QxRtrUS8v2iYYQLwqSjXt4bV
	 3sppTarAIZbmHOlEiwLj4IpYtSP50gzqmLVtOG8R8ZVHl2xY+4Gg7taTVaFJfeyt6K
	 FxAStSYhTeUjw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Rheinsberg <david@readahead.eu>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	stable@vger.kernel.org,
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 1/2] mm/memfd: handle GUP pins more reliably when write-sealing
Date: Sat,  7 Nov 2026 20:35:23 +0100
Message-ID: <179408004350.4783.10820829282179060083.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-fixes_core_2-v1-1-f332954f1df4@kernel.org>
References: <20261103-fixes_core_2-v1-1-f332954f1df4@kernel.org>
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

On Tue, 03 Nov 2026 19:31:44 +0100, David Hildenbrand (Arm) wrote:
> memfd_wait_for_pins() detects GUP references by comparing a folio's
> actual refcount with its expected refcount. As spelled out by
> folio_expected_ref_count(), obtaining the expected refcount when there
> can be concurrent folio (un)mapping is racy.
> 
> So it is possible that a changing folio mapcount can race with our
> check for GUP references, and F_SEAL_WRITE might succeed even if there
> are some, allowing file contents to be modified after sealing.
> 
> [...]

I'm applying the first patch for now, as that is an obvious improvement
for many GUP users (esp. iouring fixed buffers etc).

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

[1/2] mm/memfd: handle GUP pins more reliably when write-sealing
      https://git.kernel.org/mm/core/c/42990cfe

-- 
Cheers,

David

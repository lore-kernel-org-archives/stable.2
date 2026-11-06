Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969374;
	b=H7IkMGYrL8aS5+vHarNFtSmyzUYOUWpdhhfPmTpbhQ/6ucmGgvqiZMRtRuepqOtqIKRR
	 BYrQjTTN4LehfF621lA0rMFVdwgKD2Js7PMCRsQmQX9iHkvEupHK0JNDk9dSTzfnRBYuQ
	 lRghWS6iFJHAxDkYz4WcQEmxS3Hm5a6aqgXS8SEI30car3DlvAhRMvYeLTl3q45oUIM+t
	 PLoVWZbAHQWfUSmHoUIYJvBrQqUOSekwNp92RqRqAS13CbeErzQ2WvVYdy56vK7gpSrC2
	 Hp8cQ/VxKkfvtZ1k9wAaPY+bOttXKE6RcBSG3g7voInySGHEjKMSwZkQTLWYXS+D5iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969374;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=MfInTUzq1I5bmAHdpslIMIN8700/Qi0ASVtkQGQk8UQ=;
	b=llcImx39G4RokfgCJD9WdTQcKkeWDUMHAvmgS3+tGl3kzS0eRr7iDhMT+w6PAecuZI9j
	 3XfKfiJlxIAB66c4XXKXK1DDBgmODG11qJ4waXuyQrhyp/0vxcpCgcVrgtFit8xb6AX2F
	 EXJmiWdZCJndrY+S1nP4nCmmqgQuqCLj681kJS7yG0Mbd3UY7z0nygYwOGUx5YttRa3er
	 HonF2zIsWKM+VFIcN77JhRBXZaJXJ7IrNW9OsEhQB364a6HrIV+ycdESqg4+2GtZAhiBm
	 RombijUFzpynZlggjsyHvyYumxYJ2efaI0K8m+hvZQcpdZAETF+ThWbdAMnN+zuKEAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQKuXGZh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B3606A330;
	Fri,  6 Nov 2026 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQKuXGZh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFFE1F0089F;
	Fri,  6 Nov 2026 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969374;
	bh=MfInTUzq1I5bmAHdpslIMIN8700/Qi0ASVtkQGQk8UQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IQKuXGZhlNxc0vzYiGGG+WWptr0Cybd1J5cdy5LQiHbvReQTrkbSs0p4OiW+tZQpT
	 DdesXCviqPJIoOTqGY/F3iBQfExbDFCnbkQurepOuHezZGxYNMtBbqrqE7pbIrPvvJ
	 DJFaVWsGWQjtXfqcl5q+zddqS+az0RX7yMkmWHDDVPC8rViggdYUeU26RL8n/5iFrk
	 +N3Ch4zil+t2FNEKgT5VinUrYkkoX2g6skrbpg9smn71JvMf/6m5IM9yX350EDKIZy
	 GLIdJoluvgypaQIljk//9iv1WUuNZsphhnjfCZSYY8T0hnqyyh/GA57cclFQHOYzEa
	 PgbjxcN1NSMhg==
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
Message-Id: <179396936975.4326.8320211724584654723.b4-ty@b4>
Date: Fri, 06 Nov 2026 13:49:29 +0100
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
      https://git.kernel.org/mm/core/c/d6d183ac

-- 
Cheers,

David


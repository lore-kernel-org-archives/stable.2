Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108352;
	b=CcxM0sFJTUYa3zYpLaUDVnwnYkVqLZ0C6PPCdzxVLd4+jr2Kbm/dlu0mcMSR/+mJOFax
	 4v+CYeBvW87mxhjIjXWEUpHHACju4Q5YlNgPPvp9QcUeK0ImFWXv3m3O1bQxfXxDlE6vg
	 PzjDfnBHw7xdG+UuwFns9G6dSIzWchW+dV7RYh89X3V3p8avQQDzzbxHEfnfoxECH1ft+
	 tHaUZe2PeqPMRNKBbKvjXfBQunVp+fSImu33H7EQfA/h6aSfUl96+YBe/0kz1itlxwICF
	 Q0LWNWL07wa/LziauIyQnY2aIMhG2iDJ0nxRWaf+fiDqeENylJ9dvK8eWCVIg+4Hksg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108352;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=O5byhV97n6P3OBfGuLDvdezO+quTywLYBChMiMmstwM=;
	b=Skn6bCaoIHzZcBJQ/GS3ZeZ8qLediJ1NgCx1hri/mc4z976sfUcM9LuzciRrm6avSgGj
	 amSushEkyeL8ySl+K0fsRElhCTHyVv1wuY6HMaN+Uq1axeKFHUE/e7wph+EA/5LoXFz6R
	 nBk6st7sREEDcUDeJGYpVovCU5tQY2Cs33KT99p55e6UUjm2feJh94vsRnvaTSVLc1XQU
	 NTkDzJDq5uvR2VpSkAJ/8OjaYAkn9lx1Fd7P5s+FQcdkr8JE60NLMRA5k5Lh4JxPc4wZY
	 R3Af+G4mmQXMZ25BtTpy2Dh2ROagZuKKceNCXuf5LnmbJJvbjRAAHCwe8iFaNse0bBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hui6CRpH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCCB606A32C;
	Thu, 19 Nov 2026 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hui6CRpH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96E71F000C5;
	Thu, 19 Nov 2026 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795108352;
	bh=O5byhV97n6P3OBfGuLDvdezO+quTywLYBChMiMmstwM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Hui6CRpHqGNGxr5oPed/8hLSI5FAFf8smhFqWGEzeO65nkP2/gqPWEh/wOT7IOl5T
	 jPKDvKHd8hbz/KKTZQ6x+4vz4bONaOonPX75U+uUSI9x31wwAYTCONHOWZ2WaCNRp0
	 cmu4uF335ewBG/Iq7JkMw8KEeiWx3K7XIAgHE7WG0wK3/HixUY/P27J2ODwSw+g+Dl
	 YplXojF3grj1QdqgffjCClxv4tnFyjY4KEBV8bmKLqhUWyvQ7KFi8r917qanOmlVgf
	 2939LiAPdDLBcX2MPjy0JEag2cEXxZMuC2U8mA2f0wmN5ToORsAYyuZGjfcf243IQ4
	 PbhdqtmOZmf4A==
From: David Hildenbrand <david@kernel.org>
To: Hugh Dickins <hughd@google.com>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jingyi Sun <1045704958@qq.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <tencent_69A761EE2ABA6F15B942EBF0EE686B2DE608@qq.com>
References: <tencent_69A761EE2ABA6F15B942EBF0EE686B2DE608@qq.com>
Subject: Re: [PATCH v3] mm: shmem: limit forced anonymous shmem huge orders
 to MAX_PAGECACHE_ORDER
Message-Id: <179510834962.6900.17066358141269764658.b4-ty@b4>
Date: Thu, 19 Nov 2026 18:12:29 +0100
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

On Wed, 18 Nov 2026 18:22:07 +0800, Jingyi Sun wrote:
> When the top-level shmem_enabled knob is set to "force",
> shmem_allowable_huge_orders() returns huge_shmem_orders_inherit for
> anonymous shmem without masking it with THP_ORDERS_ALL_FILE_DEFAULT,
> unlike the other return path at the end of the same function.
> 
> huge_shmem_orders_inherit defaults to BIT(HPAGE_PMD_ORDER). On arm64
> with 64K base pages HPAGE_PMD_ORDER is 13, while MAX_PAGECACHE_ORDER
> is 11 because of the xarray split limit. With shmem_enabled=force, an
> anonymous MAP_SHARED mapping can therefore get a 512M (order-13) folio
> in the page cache. Splitting it later, e.g. on swap-out from
> shmem_writeout(), triggers
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: shmem-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm: shmem: limit forced anonymous shmem huge orders to MAX_PAGECACHE_ORDER
      https://git.kernel.org/mm/core/c/a0dc4b77

-- 
Cheers,

David


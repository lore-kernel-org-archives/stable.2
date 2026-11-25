Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603452;
	b=xh93MOwGuMcIUb704parMgYMdf1n/cA+Gi3TGrcCUkO0bXZQL+vP8myaEEZfWCAhfbcG
	 R482zGdGc6p9zA+tU5S2x1R7D5FIbcN6WymTPI3S/TGJ3lHjmH+Oe0t6t+SVuagr10Zgv
	 P7iZ1eYhuPjeONG3iUMushTsNFC7LV2e0aohEMeZGARHPBA6WSo6He86qm1G6j+5M1B3N
	 HJC7K7MjcyxnicIoQaIIySXAY3n1ZQW9jgrwtjsUnSaA6+eWGJbgaKU1OoZ4Z+5YaXRnB
	 6nDQurbgAE8XpkFAOsTKitDXRZPNerSqD7Ii9GkBSxsUjRfrhrEHIy8Ogjrb4LR//Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603452;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=GlKXvFWX4gEJBHibIvdqd1FwvtITIqKSf4ngjmttRnE=;
	b=NtTIR2I4qlmd2r1wqFnoUFdU6Di+GP9AbhsrNT1VduR+ykBQ2pUQyuFFuV5JJJrjMkB5
	 T8o/wpAfGx3rrr2l9zASlD3yF3yOaDACFENViqJHiYSOSX78xarcpQYtHSvhBGacC/oqv
	 qpQNHf4Z43RQK8vYGDdYjEViV0qBU/11KSwUXoMUNkfrI1M0zWpb1vYHoF5lG1CUSJYKI
	 1MiAqYEquCkCalQSdkvKV3Vl3XQHrdbpPB9chFQxOqQ6Ox8cbSdiqfJq/xqnWsqFXoCcN
	 PMweBktceBP1KDsWkGhLWTTiXRTZiOoUCGxMimXsNXbZc89+OmsPYTGfn0LQwqAZ0fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnoLrQun;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF966606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnoLrQun
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46061F000C6;
	Wed, 25 Nov 2026 10:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795603452;
	bh=GlKXvFWX4gEJBHibIvdqd1FwvtITIqKSf4ngjmttRnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JnoLrQun8sxhUp4swp0IvwihTOOxGD/EM/rE7gBzt53x11QuFNBQVSfs9nYk8qMou
	 hs3JDqoomNLTrASrtit0BBoM/FFUHa6h3jMP4g7gDW6V9WQj3L9lPb0BPjQvYfKwtF
	 TpAW5lD6ZGALJUyd61dniIdtqqGa5lNhGQV//esHpnsLE5JeM60DXcRM+Iwmn9h4vq
	 G+3ivSs4s6my3YxZouboSEISornuxoSpfzhQMdPgg+FNEGyR8u1r817VgJDOAZdOrF
	 ZZ/jhzIxUXV3fY0rwHdpGa1QHbTRma0W24eCsLkNK+c9SceJI+GWJlIpN2m0CVTnzU
	 5LaEPzxHYtCwQ==
Message-ID: <83701963-9c6c-4784-a53c-c9f0fb7738ea@kernel.org>
Date: Wed, 25 Nov 2026 11:44:09 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y v2 0/2] mm/page_alloc: fix iomap buffered write
 regression from 5d8edfb900d5
Content-Language: en-US
To: Salvatore Dipietro <dipiets@amazon.it>, stable@vger.kernel.org
Cc: dipietro.salvatore@gmail.com, Sasha Levin <sashal@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
References: <20261113110724.2920455-1-dipiets@amazon.it>
 <20261116112229.3815501-1-dipiets@amazon.it>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSNWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBrZXJuZWwub3JnPsLBsAQTAQoAWhYhBKlA1DSZLC6OmRA9UCJPp+fM
 gqZkBQJqFFy6GxSAAAAAAAQADm1hbnUyLDIuNSsxLjEyLDIsMgIbAwUJGtCBUAULCQgHAwUV
 CgkICwUWAgMBAAIeBQIXgAAKCRAiT6fnzIKmZJIUEADFx/tREzUImHrEwVHeSvDFmA7tJysI
 UVrlvrM09E7GIuzphzv7jYmo8n3ANpCczLEVr4G0syYQdTigaZgv3+FQDIIzhKih1IHhu1Ei
 XHlywNWKnQxxQEUNi5Mwx43wQz5XVw9F1A7gtKBKNtfogO511hAbrzagrYajyQacEJ/+sfhZ
 9Da8ltHIXD8pcYaHUfQgEusCgmEd9+KrUwrTbckFKmYq5chuE6yJ4J0EmWknL096jIE6CnzF
 FRslQ3B1UKDjxVsm1ZHfir5NeWszLkTvGFsddFaWTgh8UycESG6VQzKXjjewXu2pG7YQYRpj
 QKm1W5X2TkwWkXRBZTmfmbhxIUMh3+zf5wQ463rSmDN/8v81tdqBtAW6rH/kzg1GvkaTHXn0
 507yEHFzBksk2viAuIxxr7km8+/KARYLIdGtx30EG8cKzAUZOK6WqxtNCsXUJNrVE8CWrCaD
 icoNu7Fs1c5hmPHdSTnU48ce67449DdnO4neLSNhRiGlMHJgfJUmgrxu/hcYeOZ3haWmEQ2w
 uW1Mh01OHi8QZHCEyAbABrPs9GUgccc/4eYXX9hIgxfSkYzn8f+8NuIFPWl/0uTvjgqU29FQ
 SbzOLxHq9439Ox40G5mS5eZXRGxITYR+6TXvRGI6P/264jvflnr/pDGUttaikU+0W+1uxgKH
 cmYbEc7ATQRbGTU1AQgAn0H6UrFiWcovkh6EXVcl+SeqyO6JHOPm+e9Wu0Vw+VIUvXZVUVVQ
 La1PQDUi6j00ChlcR66g9/V0sPIcSutacPKfdKYOBvzd4rlhL8rfrdEsQw5ApZxrA8kYZVMh
 FmBRKAa6wos25moTlMKpCWzTH84+WO5+ziCTsTUZASAToz3RdunTD+vQcHj0GqNTPAHK63sf
 bAB2I0BslZkXkY1RLb/YhuA6E7JyEd2pilZOrIuBGl/5q2qSakgnAVFWFBR/DO27JuAksYnq
 +aH8vI0xGvwn75KqSk4UzAkDzWSmO4ZHuahKtQgZNsMYV+PGayRBX9b9zbldzopoLBdqHc4n
 jQARAQABwsF8BBgBCgAmAhsMFiEEqUDUNJksLo6ZED1QIk+n58yCpmQFAmfIHFQFCRYU6J8A
 CgkQIk+n58yCpmS2PA//bqN1LfcotmArgElsa+0EGZSQlYgK48pm8WAeTXTngudP9IJ4SuKY
 HR5RNjHcBeqN+Me0zxRqYzRb8nGanHEkDyf4Im8DQM8d6vbyU+FcPmG4skud4kgS1zMHnlVd
 SXfSIwKC/hKgdHG8aBV7545Lz9X6Iohea+94wneD0aw/hqF+QWewGZhWJriWAZtvEkzNjQOi
 4U9F/trLten/x7bpphDSnDMKJtITbtzATT1Dq7o7VpIUK1nCTQALMuMjKCdi8OdU/+V+R3O4
 0PXWvX8qrvqYapVbZ+9KqT74FsuB0Ya9uXwgBF2Q6cRuETZk5vqaqKxzqoQZCO8AOz/58j6O
 2RHNy/mZEN+7tJ5Tsq42zVJ4jxsT8b9YplavCMsnBgDeRWhcbYhCyttoL7nYISyWg4kQYZ/P
 wIV3OuNv2f8iKYsxNsRuClOAF82+gvqOy1/1pprFjy8uo2pkoOrb63aOP3vO5VHnRKgra6dq
 NcaZ+c6J4H+nEJGi2SkHAUJz5oBzuThvPudLvPA/SK8sKoM01IRxSihev/S/5WLazXB1PGem
 OCbvzC1IjWJJraxiDJ5IygokapUa2RP7+WBR22skQ3SSl6G107QgWKSyTOGWEaRmV53vxQLV
 jXuCmzSSasTL60zq5yGrT4/DYQVSNEUiUbG4pYekxJujNeEDkUlky0Y=
In-Reply-To: <20261116112229.3815501-1-dipiets@amazon.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 12:22, Salvatore Dipietro wrote:
> Backport of 0e05a469c294 ("mm/page_alloc: avoid direct reclaim and
> compaction for costly __GFP_NORETRY allocations") to 6.6.y. It fixes a
> regression from 5d8edfb900d5 ("iomap: Copy larger chunks from userspace",
> v6.6), which slows buffered writes under memory fragmentation.
> Andrew and Vlastimil agreed it should go to stable [1].
> 
> The series applies on top of Sasha's backport of 6ee3d87b9408 ("mm:
> page_alloc: do not give all non-blocking requests reserve access") [2].
> Patch 1 is the other prerequisite, fe21f930d1e6, only moved from
> mm/page_alloc.h to mm/internal.h. Patch 2 is adjusted for this tree, see
> its changelog. Acks from Vlastimil and Johannes on these adjustments
> would be appreciated.
> 
> Patch 2 keeps the mainline behaviour, including the THP defrag=always
> case raised in the Sashiko review of v1 [3].
> 
> Built, booted and tested with pgbench simple-update (PostgreSQL 18.6,
> 1024 clients, 96 threads, 1200s) on m8g.24xlarge (96 vCPU arm64),
> 12x io2 RAID0 XFS, mean of 3 runs:
> 
>   v6.6.162               93,808 TPS
>   v6.6.162 + series     159,670 TPS  (+70.2%)
> 
> Changes in v2:
> - Dropped 6ee3d87b9408, now queued from Sasha's backport [2].
> - Added my Signed-off-by to both patches.
> 
> v1: https://lore.kernel.org/all/20261113110724.2920455-1-dipiets@amazon.it/
> 
> [1] https://lore.kernel.org/all/1fc0caa5-43b1-487f-94cf-0d1aff4c03fd@kernel.org/
> [2] https://lore.kernel.org/all/20261113005511.435938-1-sashal@kernel.org/
> [3] https://lore.kernel.org/all/sashiko-outbox-214392@kernel.org/
> 
> Johannes Weiner (1):
>   mm: page_alloc: remove ALLOC_NON_BLOCK from ALLOC_RESERVES
> 
> Salvatore Dipietro (1):
>   mm/page_alloc: avoid direct reclaim and compaction for costly
>     __GFP_NORETRY allocations
> 
>  mm/internal.h   | 11 +++++------
>  mm/page_alloc.c | 12 +++++++++++-
>  2 files changed, 16 insertions(+), 7 deletions(-)

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>




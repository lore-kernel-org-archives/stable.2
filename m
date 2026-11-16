Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847740;
	b=HuM0f4GlMS9+pNWpDq6QujqDGu4FWA8A4D7g45sckcow+nEqdcCHY/y+DUA7dxtm4U4f
	 lrGvND4IH+yKA7VudOW4wMJ7425rKPlAoyRanls3lQY00Ex4AqruIB3TpwNyzRBllh54/
	 CtW+gkGFjDmMXcFR08nvoL1q4oKATd+SmGg2Ubec3cgCe1BfMcqEsk+X/Wb8EiKLt3uKR
	 pejSj+0lGN+ULdnMtF5N4j2i+wfb/pckLu8jXyzQqz9tZ1/JBf9CFaXE1VJSh1VDs0s3I
	 ZpOHTjL3PSU3DE7NNkoJ7Q/kqiEKjXzQUrhiitm1X27kJ4nMVStE1jiqtxADBDdudfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847740;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6omg0ligBH57n8EnOMUV3ZmfFZF7HYyuZoHQ3IpUkmg=;
	b=pKEd9xytnwkWlB7xAinGfELYZW9P1+vIxYXX1tpFRMcZFQSS7zX8P+qdM2zVHfB2Fesu
	 X7COM6Obqsd0qUgcyQoorajLU2LNnTvGQP7HxQiTbcEtlcis/CJ25LgdT05mk7NIvSusC
	 roO1G+IQYvoQFDbyL4EPBdI1BQR9aNmBf6mFAMLVO/5lgdqgRsAMA8W7cqKiDaJHtDvqa
	 8RsgoauZ81bp2ZoGvGoDsthwFuznBSmXZSzl3CG5Cac5tFrftI52cAD//8WbiHE67ChHp
	 PphAeEJOjhK5ftOR3xH85gXU+5fqmGakI4RMYijMKlSL0FbHz7z04uHlAPjLpQZTnpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgmLiAiw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A6606A893
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgmLiAiw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA4C1F000C4;
	Mon, 16 Nov 2026 16:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794847739;
	bh=6omg0ligBH57n8EnOMUV3ZmfFZF7HYyuZoHQ3IpUkmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FgmLiAiwqY9TlwwGqjLX/hI57bfvrnBflZJ8S53YzeooIz4z8NSxcLXKtodK2j+HZ
	 f2Yph/AsUHK/7NO11nCv5ppCiZ/l5ArHIyP5Nl9fcksutLURYpXgu0ABBAi3XHGNWf
	 +oq/s7CRpd9pbgMWz6hVBzwgbSaiVWYoy5fcsYLU5Z5yo4GzAm1MMGy8O5+6q3ksJB
	 o4JtJRhI2hq8LfyKL9FxCNR1Y3cZQ9SH5Yc4D5n4gb82Ok94tXI5M5N19Mmr0Mr22X
	 24sWfbPvVn0sUCM0b3KKuXTKoqqR6HeSJ2z/zixzPp2vzq3cEZqp5aB+CXz/QPninM
	 gVu0/odW7Fapg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id CADC91980052;
	Mon, 16 Nov 2026 11:48:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 16 Nov 2026 11:48:56 -0500
X-ME-Sender: <xms:9jP7agKpXSc5bAZ-AhMrhB57-aBd4UfIXAtbPXxHwgkZhVlp9thpRg>
    <xme:9jP7ahdzYhACbFdUvO7VslOo0jH1i_WrsVHZGMp-xnjKWEu6uR39vfqvNOGoPtNQJ
    J9wIYDO6vSTYXsdVdyubsP3fEs5m-bn3HafSRfQde1VJ9cVsrxyTw>
X-ME-Received: <xmr:9jP7alWvtBNL3xk-RJQKkzMTczgPALyD5HRnAVLGOpA4qUQW8JxAWQEX2co>
X-ME-Proxy-Cause: dmFkZTFYEHTeQONFqSduiHoZS2ZTEPeeVopmMeomfz1WJVsyyKyGDBfvRrKrTvkq2DKLl6
    hbXbi/AtSM0frbppQym9o93S8gk8YeFAfIPfsfMHr97SIjQZZpMHuRYiBpiSGmGqf7mgmS
    Bxc3bBJPImVMURYvN3sFQJfTtg/H/RSMu6q97va2siGm4Ok08N3pXoLvtPleBBWZHOOT04
    /Sdv6Qw6VVEZSmUoM7a/11MGLq03jPI+F+EGk8X1WDvYZglx7J3RFNM4qfRy6tUHvc2wcE
    k5jcypoHfR8OZjPfT/4Fn+V7vVMxB3rVL+m+/jQJYnT8ONNs541NFnehigpC1Twm3NYUNy
    qv6e6u/bjX+2KqQqii+1fIgiiHevWyUykqtrpFTz63pW+wkYe45neW1JE3E0aFJU8WkyvL
    +37BLjAdro70LyXGROaWQRzpgqzdB4UJJ6bu4C1oXtnMV4p9GDoezMhjQTLofT5dSnPXrP
    2FcgYtZ2OKbVYshmNamrTTzpuvNu0CFOTC/0d1cPS9cXtFtaMNdITkVAX4aeZp1cJ7DtUJ
    YLWYU0nprGLdO6dSIAM3/NOejQSojmIaN0TkBbVOgRE9H29d7dADtL16iumxhqhBjZ1ZjP
    pqFkdUWfhrZ13Hk5WvIKtB3H/gOvHGQn0HmB2yRkOMK+BdGX1/bP2WIMZlEg
X-ME-Proxy: <xmx:9jP7agGtjLyPIIdjR3ZEXoa-gl8KOLLFWtGZPrENq8w2AFGETbw13Q>
    <xmx:9jP7auUsZkw9Gz0WfanVsxpBsO4qyApOLMc8S-pzKbNa_1J7JibQmA>
    <xmx:9jP7arCiX2gZaMY5mOMEibJmoBkcWIKTjFQDgBIZigvyiVU__f4noA>
    <xmx:9jP7an2o4Mt3srcw2ycbO3qrD_c9Q5kmWGA8fLmoWz0EooIPS-3VEg>
    <xmx:9jP7ajRifHXGnS32pRnmJMAsyNQSZGgzZw7D9tWkAPiTic5g5jqAwt3x>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 11:48:53 -0500 (EST)
Date: Mon, 16 Nov 2026 16:48:52 +0000
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Pankaj Gupta <pankaj.gupta@amd.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH 6.6.y] mm/cma: accept memory of CMA areas reserved at a
 fixed address
Message-ID: <avszpOC2q4p8dVVK@shutemov.name>
References: <20261109201234-failed-6.6-f8f9cbc34a30@kernel.org>
 <20261114161849.4002504-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114161849.4002504-1-sashal@kernel.org>

On Sat, Nov 14, 2026 at 11:22:26AM -0500, Sasha Levin wrote:
> diff --git a/mm/cma.c b/mm/cma.c
> index ac363f16d3923..27e27e5d70cd3 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -318,6 +318,8 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
>  			ret = -EBUSY;
>  			goto err;
>  		}
> +
> +		accept_memory(base, size);
>  	} else {
>  		phys_addr_t addr = 0;
>  

NAK.

accept_memory() takes (start, end) in 6.6. It was converted to
(start, size) in 6.12. See 5adfeaecc487 ("mm: rework accept memory
helpers"). Here size is taken as the end address. For the usual
cma=<size>@<base>, base is above size and nothing gets accepted, so the
bug stays.

The 6.12.y backport is fine as is.

Correct backport for 6.6.y:

-- >8 --
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 6.6.y] mm/cma: accept memory of CMA areas reserved at a fixed
 address

CMA areas allocated from memblock have their memory accepted by
memblock_alloc_range_nid(), but areas reserved at a fixed address with
memblock_reserve() are not.

If a fixed CMA area is requested by the cma=<size>@<base> command line
parameter, it may be in regular RAM and on TDX and SEV-SNP guests it
must be accepted.

Accept the memory of fixed CMA areas as well, so that all CMA areas are
accepted regardless of how they were reserved.

Link: https://lore.kernel.org/20261029-cma-multi-v1-2-2cbced8b5cb7@kernel.org
Fixes: 75d090fd167a ("x86/tdx: Add unaccepted memory support")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>

(cherry picked from commit f8f9cbc34a309a388c052706f3329d1b52985aa3)
[ kas: 6.6 has no cma_fixed_reserve(); accept the area in the fixed-address
  branch of cma_declare_contiguous_nid(). accept_memory() takes (start, end)
  in this tree, it was converted to (start, size) in 6.12 ]
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index ac363f16d392..906bad0393dd 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -318,6 +318,8 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 			ret = -EBUSY;
 			goto err;
 		}
+
+		accept_memory(base, base + size);
 	} else {
 		phys_addr_t addr = 0;
 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

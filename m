Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180947;
	b=mcTbgafcnpG4ZqKsB4IbFN64xSwg+0Zz5MzMlR+IVgpILkvw9bNYZmHV4qnMrsfZrT2Q
	 vgx/qkEv3aaxl+794mPLdCIulj6guZZu+hBq7F2x2wJPFoXpD9AEzN4854tBevg36zwEq
	 8yuC2ty2Me6P+WNzRgPjGXwHmCrMCy6XegGY3aylHI2+twjA0t8dgGOfdEPCt44lcf4eH
	 bU9IO+NNMNtvezsD9EUghL6w4QwyI1U2CDamwkjraKz0uB+lRtd+WKRZBFMCamdP3XCgu
	 nBKiTjRpwBOr5XYUDHgO7NRVPwSwzCc4hMnDxluwigx/2/FgDnPXbpabCyiHEo9NCMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180947;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CYKzK+afm1UAXOdWN88x2NYVRVihApLSg0ZCPnBXpAE=;
	b=CkqWD0IfpUdGdT5iCnAdhuWTcZF+kZtKr9SCYO0/B2hQE1htm384V/LrXc1tLFkofwuu
	 hM2BYYnp7rngjJ+HzNRoJskZGcXDcoPMmxoEtmPYqhY/SNOPvLOu6FvnXXpv7yOGiN3PZ
	 J2R6fN7wpWjx9xxDvCET9WDU6hMSGvmafHwKToA9xE/5XDPM1NDUrjH5juOA7R9je8xUH
	 3Pgnv3ro8SBnjJwF4gKAlJY/KGXukT8wzxwr1F48Re3ev9HAyYOXe9maP1uPJt2T7voxZ
	 2SboWAGpwkdMW6xTPKxJ4xkALiwKW3nBqquuEyGbngfG2Bld3w2LfXCP0ntBitSEQ7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daY6EDy4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8A606A326;
	Fri, 20 Nov 2026 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daY6EDy4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417B01F000CA;
	Fri, 20 Nov 2026 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180946;
	bh=CYKzK+afm1UAXOdWN88x2NYVRVihApLSg0ZCPnBXpAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=daY6EDy4/MYgaj691rc13nwsS7BVt58ckPRvsKOl2i2Hnu4t/DTGBXgBKLWv75LqQ
	 LyocvI3dr8BHsyaTYk6KWZ+lo8NPMzYhMO4mK05rpvqFVb4ZMKY+Yv+imvPzytoM0p
	 mJ3OD0foxm16lLw/nD3rzKJr58Gc27/GczEOn2lEEdMQAFagiy38PrrIRl0M0tg7MN
	 w/UcBT8RLduLhw9YlLeSyxtcYKLXnxIwGf2Yff9jH+iQ6mbq1d5YJxhKbbXDdOJQCB
	 LqLGvy+B/ya4W91XSznxOTE8c3OZX6TDJD1v01gXWyjzrsGITdeX8h9VoN7bY1RDqk
	 D51Qrr7L8WkIA==
Date: Fri, 20 Nov 2026 13:22:21 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nico Pache <nico.pache@linux.dev>, Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] vmw_balloon: account 2 MiB pages in NR_BALLOON_PAGES
Message-ID: <awBJbbFwE7hlEs03@gremlin>
References: <20261120-b4-balloon_nr_pages-v1-0-d8944b587819@kernel.org>
 <20261120-b4-balloon_nr_pages-v1-2-d8944b587819@kernel.org>
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
In-Reply-To: <20261120-b4-balloon_nr_pages-v1-2-d8944b587819@kernel.org>

On Fri, Nov 20, 2026 at 11:34:43AM +0100, David Hildenbrand (Arm) wrote:
> vmw_balloon keeps 2 MiB balloon-inflated pages on its own list, not
> using balloon core that takes otherwise care of updating NR_BALLOON_PAGES
> for base pages.
>
> So far we didn't account 2 MiB pages under the "Balloon" counters, so
> /proc/meminfo etc. would not reflect them.
>
> Fix it by updating NR_BALLOON_PAGES when enqueuing and dequeuing for
> these pages manually.
>
> This has low urgency.
>
> Fixes: 4d689474e1b2 ("balloon_compaction: update the NR_BALLOON_PAGES state")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  drivers/misc/vmw_balloon.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 3edb934dd7fd5..47dbcb3be6ed6 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -1005,6 +1005,8 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
>
>  		list_for_each_entry(page, pages, lru) {
>  			vmballoon_mark_page_offline(page, VMW_BALLOON_2M_PAGE);
> +			mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +					    1 << VMW_BALLOON_2M_ORDER);
>  		}
>
>  		list_splice_init(pages, &b->huge_pages);
> @@ -1049,6 +1051,8 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
>  	spin_lock(&b->huge_pages_lock);
>  	list_for_each_entry_safe(page, tmp, &b->huge_pages, lru) {
>  		vmballoon_mark_page_online(page, VMW_BALLOON_2M_PAGE);
> +		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +				    -(1 << VMW_BALLOON_2M_ORDER));
>
>  		list_move(&page->lru, pages);
>  		if (++i == n_req_pages)
>
> --
> 2.56.1
>

--
Cheers, Lorenzo

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02AC499F17;
	Mon, 21 Sep 2026 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003634; cv=none; b=NKH7goQHKO4zQaXE/cWn+R9X5OYyzrDsSzzLL7fJ/xo/nQiccct5ZzlWa5RRKa8Xd0UoJZSb5fHA0Xf3zMWUxMe3S7lttOGWqKopQewDmWS5Upl16QG5sto2AmLfCcTa1qTFbLMezTXfFKsI5NWSaXO+Lamr5PiC+uIjyMzGFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003634; c=relaxed/simple;
	bh=bqE1xEot6tiyL8ZmNNempke5NHtbffWU04ZTox5AuAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+QGZ7tstSZmc5h2afTn2HBN5tm3HurxEB+ydbm3sKGO0cjiJTgqTdDcvANTdzndzLs5wUaoDDXxXdI3Jr9qYyK/6wGyLceAQ7V1nHx4TZeBzi6Es4iEK7hbHkwGnVrQYCEL0xRMOQikqD+U8780x6qiDsV2B9mQMrZsAb1+x3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cc1hCmak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc1hCmak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BD31F000FF;
	Mon, 21 Sep 2026 15:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003633;
	bh=ZDRQ8N++1ApttUwT3N9xaoQfi3XlqZ/LvnDqiBydZrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cc1hCmak9MnLVSyItvdYF19QPrqsY4ZANqMEsli5mCF1D/wouBXlfbJBRLXgsMN8d
	 mXKE+hWDqXvxgduDPBHAvrEr1CCJFbKMIawi4wSxLtzF++qSLy33WQRglavpqQbv//
	 czTJZ/5PuwE3ky01ofsn2ZaO90ZGtm3d+pMYhbQ/vpX21wzQZ2H0mvVmP1fmdTSMCI
	 jOVRMTblUcTAD0KW6cRYiIVCratM1yr/zkPA27klgQySE0WtipE/kexJTaOb5s+LGP
	 /sboowP4V7r+J5d9lp0hx9NqWN7GtDKjLEXH4RU3B/ph+nwOvrTf1OhpW2OWz5h3Gy
	 AR9WQxLY2Ta3Q==
Date: Mon, 21 Sep 2026 17:13:50 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, stable@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: intel: fix OF node reference leak
Message-ID: <arFJrf7S7IvAR27Y@quoll>
References: <20260915163407.2487869-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915163407.2487869-1-lgs201920130244@gmail.com>


On Wed, 16 Sep 2026 00:34:07 +0800, Guangshuo Li wrote:
> ebu_nand_probe() gets a reference to the NAND chip node with
> of_get_next_child(). The probe failure paths release the reference with
> of_node_put(), but the successful probe path keeps it for the lifetime
> of the device and ebu_nand_remove() never drops it.
> 
> As a result, each bind/unbind cycle leaks a reference to the NAND chip
> device node.
> 
> Drop the reference in ebu_nand_remove() after the NAND teardown using
> the flash node stored in the NAND chip.
> 
> This issue was found by manual code inspection.
> 
> Fixes: bfc618fcc3f1 ("mtd: rawnand: intel: Read the chip-select line from the correct OF node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/mtd/nand/raw/intel-nand-controller.c | 2 ++
>  1 file changed, 2 insertions(+)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof




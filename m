Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067C8499F17;
	Mon, 21 Sep 2026 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003484; cv=none; b=jYn+5NNbVzryG2qi7+2zZQC/kXY8am2tmryxVev7Dx9zzwYcm3WME3JUZrHQeFlNFTvEGvU+ofBxyZCC+60kTH4MOvVMbAyUAX+ySnO8V7sWuEl7PMo9288iFV7mYs3ybQeePYTQMDgoPn5tsJ7QdocsF9X0xx0Ds+oAHDYNcIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003484; c=relaxed/simple;
	bh=bqE1xEot6tiyL8ZmNNempke5NHtbffWU04ZTox5AuAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmTZwBfzb1jYydeXdyXrMXUcbviSva1vbCU4MhgybrD8Ge6QrpXVQF8cyK1GQydHpzouZl+ukgLOW5WiNJh7evENbD7jm9VUBPM9dSi0FygNDCjR10QkhKBzh5OIMeLx62z+0BiFlqMy4OS0pnjgVdnxtbLDYqrpqTR0SgtZUhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5gmCXeg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5gmCXeg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048B71F000FF;
	Mon, 21 Sep 2026 15:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003474;
	bh=ZDRQ8N++1ApttUwT3N9xaoQfi3XlqZ/LvnDqiBydZrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L5gmCXegQUbpWwF/iOX7v/aMDnaqKZK/MMBosvdkNVGreWB98Pw5TVQjXjCJt76TQ
	 BxGbp4OV5E0MOYWajMj/Lc4LAyv6CKFGPQK470CRf+2PTEY16nCux2ZBXxf13oyaMB
	 ppvHyB+ugBCaM3PGxX3yQ5bVcQ7OkbCHZkat+YBrE8296bZL4aj6sql/0/aUNB1V5k
	 TOIiLp8Udn5BwbyPscjSEYmqdaGNC9mgsVc7efJhVeCSebcCur37ICYcO5rNpCmRPX
	 elxckYSupWrqDy96pCRpL5eRAqE/wN3ADr5v98Wz7867oWk/kjv4rI2zmLzhzUWbyo
	 hx6hVKU5Nbcjw==
Date: Mon, 21 Sep 2026 17:11:11 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] mtd: rawnand: intel: fix OF node reference leak
Message-ID: <arFJDKtpHSmxkhVG@quoll>
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




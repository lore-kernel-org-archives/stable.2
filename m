Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D993E1728;
	Mon,  1 Jun 2026 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336842; cv=none; b=Bh6kRKj9PJLWzjMWIJyIR3zbQtfhkEudKS0dCSidzcGUaEJ026OZ8/XGAjK6+NZY1siybnCoQg/dyIigZOYS7R9tage2xgfBH5+pYv06hSW7YXzAc5cd9qNYivNeacW402smKHUizO3JaOf3CATo/SnAcOYWH3r3oqe2cgRW0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336842; c=relaxed/simple;
	bh=2GiO+rw//gwST3S8z0fflupggAAITCQ2zd32W71wKvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In4T3RX6ScrPJxJwJ+7ChellwplPr+uQt+O42bdUj5JNj053BxmayM8V2VrFUGxUG5e8UroNoKaVJmx694ebLtsjwhstS1Qlv9c7Jpl/V9IWgGNo1IhuEsHBC66yqysOvYCKTBSLeB5BxNOlQlSguYCXAGFtxb2djJr/bnm8/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BP8rvdKJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BP8rvdKJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9801F00893;
	Mon,  1 Jun 2026 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780336841;
	bh=2GiO+rw//gwST3S8z0fflupggAAITCQ2zd32W71wKvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BP8rvdKJPXH9RmlnVdk/08Rel1FtZo5IPta6dYgGI2tomLnnSixvZVV5GiU0i5n7u
	 n9a1aGPosYM99iJvUtWj4DBJiy/4YddMqefRgmFyd5KLyo9MVza0RESWf9UsFbN7Sv
	 5PEPHAjSixgahFqu54jD+su4/43f35UJILGyHxHdpo9jigt3C/Yd3abPqLGO9b31g+
	 VVsKiL1KnmpFLjfh0vlsG1v/n/OTYAH/6RARYUHT1QcOkWAAfNZtrVjWzEURtTZ0xK
	 kZVrRMogXElyiVY/0VrUsA0BNS7B34pnLLA4TTDSiwJommtxlGHI/XOvYGw1rkP3U/
	 5e/CWsAOiaeYA==
Date: Mon, 1 Jun 2026 19:00:35 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org, 
	Sashiko AI review <sashiko-bot@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs/proc/task_mmu: fix make_uffd_wp_huge_pte()
 prot-update race
Message-ID: <ah3IrXG3aFVgXRpd@lucifer>
References: <20260529172331.356655-1-kas@kernel.org>
 <20260529172331.356655-2-kas@kernel.org>
 <ah3EQvQ_Ja6AJqzF@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah3EQvQ_Ja6AJqzF@lucifer>

On Mon, Jun 01, 2026 at 06:55:43PM +0100, Lorenzo Stoakes wrote:
> On Fri, May 29, 2026 at 06:23:25PM +0100, Kiryl Shutsemau (Meta) wrote:
> > Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
>
> I wonder if better as a separate patch? Not sure what Andrew thinks about
> it, I do recall him complaining about separate-hotfixes-as-part-of-a-series :>)

Ahhh it's a series of Fixes: :) ok ignore this then!

Cheers, Lorenzo

Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364EB3AFB0C;
	Sun,  4 Oct 2026 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791112878; cv=none; b=Xe2YW3+SFEIUT5w/Nw4xms1HlZZkOdpWlbMyPoaCpKLhOsPbVaBoisEJKL3zlnIsyCDkVWgEJxb5BLbXRGXeBRxLdRa76gFq+XrYooBWeLO3PzrCQJzQUvW+Oso9T2/s9F62+buCwTDU+sL+vAesQ3+/wtVMkFS3445zjUqwoeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791112878; c=relaxed/simple;
	bh=I2xyeTQDI3UC745fEw0MG93IuKAZikzAYyxNC7b4Ha8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nuij6zB6MVaXxAoxDyjJNuY6YK2LiS43/cQZXt2qwZTD8xMWgbrnnCKnhZtNb1AD87zvqvGHOq8KnJmQsaGEodG1UCxiJfZ6SbF7Y8xJJYdMvFFFHb4wKr2Sg1qJhvaFySnPDGfIEMSu5MH0zEn8uwOX80n9v9KXDIx660JeVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=JmBhULh9; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="JmBhULh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1791112873; bh=I2xyeTQDI3UC745fEw0MG93IuKAZikzAYyxNC7b4Ha8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmBhULh9mBNmb54mULS/zWSbeGIcnXnYQqK/m7asMHXjcU8FsdHy1rlqtLqutwl75
	 ooZAzkIeJMPoJgiaiYIcXUF1flX24zmDN/eg9U7c+dfSTvaYWHNrkz2NF5lPMZG6Rc
	 tLsbQdAWn3olEKwT3hw0UeUxn7tqyzIU9oEA1w3yMr6RbynwsKcxXdnzJ+xHwESucn
	 ZXCU/K5/VZMZlZm7WJdQsQhCbqcY7swpI5EaY7/Yxr7OXk1u9HaJzrOc9twJkcLbse
	 WSjenXMIkeDkcV0aFzR7yHP0W1OEa8TMJRw3l/WwvrMYFCY1dO/W+XrcdZ7zC+SpXj
	 nfRD0Os2slEAA==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id 1977C409E9; Sun, 04 Oct 2026 12:21:13 +0100 (BST)
Date: Sun, 4 Oct 2026 12:21:13 +0100
From: Sean Young <sean@mess.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] media: rc: Fix simulated TX timer lifecycle
Message-ID: <asI2qe_wzS-VYFYX@extorris.mess.org>
References: <20260929143105.2170272-1-runyu.xiao@seu.edu.cn>
 <arvlSbG0Z0FGxq3l@extorris.mess.org>
 <20261004094507.1191384-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004094507.1191384-1-runyu.xiao@seu.edu.cn>

On Sun, Oct 04, 2026 at 05:45:07PM +0800, Runyu Xiao wrote:
> On Tue, Sep 29, 2026 at 05:20:25PM +0100, Sean Young wrote:
> > I think this patch is correct, but I am not sure txsim is really needed
> > in the source code. Maybe it's better to just remove txsim module parameter
> > and all related code.
> 
> The txsim parameter enables the driver to expose TX on hardware without
> native TX support by simulating TX completion. I found no in-tree references
> outside ene_ir.c and no separate documentation for txsim. Removing it would
> drop that fallback. Do you consider this fallback obsolete and prefer
> removing it in this change? If so, I can revise the patch to remove txsim and
> its related code; otherwise, I will keep the timer-lifecycle fix separate
> from that cleanup.

If the hardware has no TX capability then what is the point of those code
paths other than exercises the code paths. Might as well go (unless I missed
something)


Sean

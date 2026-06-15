Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3243CAE61;
	Mon, 15 Jun 2026 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512396; cv=none; b=pMhdpEvSNxnG0tw/+Jxq9ORD2i2ok0HvVEM0fE2jAc0ls+9YaLN5KhuB0UuLYo5a8x4Jv42jXbrXK42X94H3uTkJzjvlMIiCCiAdAlvS5DT8pMRJL8cG3Yf2CscRMvrrBez3XLOBCoFV3wtrFbWrVObN0qhZ+oFraY/5yvH+Ci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512396; c=relaxed/simple;
	bh=bhNdERKO+2zOaNEe5hebDG3dSwA8uHn1jQ9in5tSBko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4At3nGywtm9lnDQVaulHa1p2Kcf0L/w/ud/vFjY2wDLNBj5JGAyNp1P76gxSST5Ve/9HA0RmlPIL+m/1FCytJcoE1Jrjo6jHodBCuo2s9JhpxXlJasstOjdxV5RKtBo3iC5hMVAXm5/Rv+6JSn5c0p/eN9MhJil+AmHXbHNPr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiKhHkod; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiKhHkod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74C61F00A3A;
	Mon, 15 Jun 2026 08:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781512390;
	bh=LJgk49lZh6XkT3vT7lnSu1LzZgJc7yNDIBCNptBuK3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hiKhHkodjr8F1lTnZSfkNelArHKuwZFvaMO9NZ3kHGojJoYvnYvo+9oEgK9tYy8yO
	 K6LWUwWYBJ7H7s/SpN1JR0m89FPDHrCe78Vqhwxjq/4iFZntiZJF2+FKd3xg0dJEZX
	 SXukZovrHXKWLJZtO/vBTQzMHS0dUxc57AayqQ3pMpF8k1YIbwb86M31eWLkdK04jm
	 aSEuOO9wf0JPitNpyjpWvvva+IwajkFG0BL8rJCB0vslLnszOjQ81CJmQmKavVwZCk
	 K+ZzUnwe6h6e8GLmZVgKKQQu0h80O+fyFYLbgXpXtpCjCzOFarcBc3DaZIePSZXW27
	 gs04kaRsSn6CA==
Date: Mon, 15 Jun 2026 10:33:06 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Hongliang Wang <wanghongliang@loongson.cn>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	loongarch@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v6 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
Message-ID: <ai-3ZiF7RL8J4lNP@zenone.zhora.eu>
References: <20260608024533.32419-1-wanghongliang@loongson.cn>
 <20260608024533.32419-3-wanghongliang@loongson.cn>
 <ai8o9vxUX6rbZNV4@zenone.zhora.eu>
 <338facef-6893-c8d9-0efc-b4fc3aea756b@loongson.cn>
 <CAAhV-H5R9fPvUs7dvNrZAbXrGiWvE4YPkaca2nxnhgS3A+TVYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5R9fPvUs7dvNrZAbXrGiWvE4YPkaca2nxnhgS3A+TVYw@mail.gmail.com>

...

> > >> Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
> > >> and div, calculate the prcescale of i2c divider register. The
> > >> calculation formula is
> > >>
> > >> prcescale = (clock_a*10)/(div*clock_s)-1
> > >>
> > >> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > > I think Huacai has not reviewed this patch, his review was only
> > > for patch 1. Am I right?
> > >
> > > Andi
> > Sorry, it was my mistake,  I will send a new version later.
> Why? I really gave some suggestions in previous versions and you accepted.
> If an explicitly R-b is needed for each one, then
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

Yes, no need to resend it. The R-b should be added only when it
is explicitly given; otherwise, I can't tell whether the reviewer
agrees with the changes.

Thanmks,
Andi

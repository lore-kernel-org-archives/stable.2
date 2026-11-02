Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612959;
	b=zKxwnqn7zauLpVVSq/1viT78yZQnkgM3xwQ1AWY1wr9Jz0noFuWiZ8BUbXwXuGb7CUwD
	 e/xBG/2BwBRddWNtRaBjDkoDQSVu5qTfwFQXYT46U90jqYHSa8hkl1GLrF8JbEeelZQeV
	 SvC+40PqbxZAvrkVqfMlgUIa0kBs4NT+EIq3z9eJZJQ8kcbw0IaXg9b0ozbp+CUS2P3v1
	 uPLmPdYwm0gipLA0S5/a1JSyeiLXFq1UFP8+DLrEIe72+ZIJGdFoQJYcbfOggN3dKyQHk
	 TAz5zqeROQb5zPTPgqF0DLPqF1kU4hu1a4EoCj/XDX3JoMNwJdmzlzgAm2e5gxQTigw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612959;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0cqa4XXN/9RPuC6p6z0Fo9GJirn1/Ro9BcftbdoqQho=;
	b=KpQh3vK//QXStK+gjFqIX0eVbamZh4IuWbD3/nvTTZABc5I+s33/j9swb1wdfoMa/HiC
	 8CplSyYSL0yFO/czVYCiTr1C1wZaY0xZG1UFPf17Rd7X5zfDFW8neIMeNmoBGDTd7yVl2
	 112NzWOu2MktJ5TIq8p1PvGybkSbjvnNLa7caoHgnEXOchovJnhpxHeH83I2ypjkAcGLU
	 rtrdvCZJT+D0MGw0wiMMxewXdVmp4gxqQYRS9I2CO/ik9TifhHv7oSRkmwvqZ6Co1s8ml
	 UHtdZrl7EKhRZb5/S7DpRR/yK8p0gzYlzkTbJgneEUfgJiJWDB1/MkKTGeQYlIUV0ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M6avkHZ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C72606A324;
	Mon,  2 Nov 2026 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M6avkHZ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF08D1F000C1;
	Mon,  2 Nov 2026 09:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793612959;
	bh=0cqa4XXN/9RPuC6p6z0Fo9GJirn1/Ro9BcftbdoqQho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M6avkHZ0bgkaJjFiJdQuS8A7HqMtb2hSZZWgbVc03U33tlg+y8Fru6jjVdtVhZ4tI
	 8gf98yrfJtep01eU4l2PGDOTvpkupzoCqDAXkkjRoUOqYxSqGBgH0cJcN07+yXc7MR
	 +De3HpKCVnuVgYc7zeObENGB7sLh7Gr9xPC+SemZqf+xdkcruCoj3ulmBmlDDN81Ad
	 cyV83n78hr9Ow9nEH1IKbaYLM2R+z0qLlUaL7++tZ5f5Z0ldsPt/+jkQ8hM8StvbCR
	 33QZ1rbc+vzlov0n1OKEgSKFNGEVbpViXWUmbi2ju2xllko+95rxp2IIb/FGj56B7b
	 Wa0KHl+Bx34zg==
Date: Mon, 2 Nov 2026 10:49:13 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Yu Zhang <yuz08559@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Koichiro Den <koichiro.den@canonical.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3] gpio: sim: fix the configfs lockup racing with
 mkdir/rmdir
Message-ID: <ndfegsdaikebmo5kyqbdnzuiusjx27q5lbu7pkdk3ywl5yfm6d@pzbn57jjuaxd>
References: <20261027085653.90471-1-yuz08559@gmail.com>
 <20261031085821.23385-1-yuz08559@gmail.com>
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
In-Reply-To: <20261031085821.23385-1-yuz08559@gmail.com>

On Sat, Oct 31, 2026 at 06:58:21PM +1000, Yu Zhang wrote:
> gpio_sim_device_lockup_configfs() depends (on activation) and undepends
> (on deactivation) the leaf configfs entries of a device. It walks
> dev->bank_list and bank->line_list without dev->lock, while the lists
> are modified and their nodes freed under dev->lock by the configfs
> make/release callbacks. It also walks the lists twice, once to depend
> and once to undepend, and the two walks can see different entries:
> 

Don't send new iterations as replies to previous ones. Each new
iteration should be its own new thread. Please consider using b4 for
patch management.

Please resend this as a new thread on the list.

Thanks,
Bartosz

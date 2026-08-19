Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2342231A3B;
	Wed, 19 Aug 2026 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143225; cv=none; b=dG/DR0S8eSOSfjD0WSv+z57m+P73yYDorxx8CKmM6ltmq66DlL66tIXZi/RNvqOtelVcx9D3HSoaJrb0PKdLZXaFZJnryOt4CM6OvF3Ao8DGDj6EJqVKBC5hGjfQrTSjblBQRnh4au+RvDhvIbdF7vbGd6PcT378BX9Kcsld7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143225; c=relaxed/simple;
	bh=Ie4gPpJ1mNQXYKT+o5BSJkv0rr+BEpQ5I3MNAz6yTdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUvcDFrTnWY0KREf837a+X+P1MlpAs+Is9Kdk35PgYBy0qEX/1vfX42X/i733RiPelN+dsuH6hiI7oBdrES2lpAMjEej5tww21XdkQxyB1I6JJ9IV65HXYuMgazQ/kbP+RN0Y8Kgp+iuPclVDPHn68DsAtdFKjIY/fnDB48y+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZJ07j9zL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZJ07j9zL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2B41F000E9;
	Wed, 19 Aug 2026 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787143224;
	bh=NADCpbWVIHfcFkLPK+IP9dO7i9W5cBInAyJM1rqVYaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZJ07j9zL4trL7oa0tRpl+WAGjqtU8YchXCxKPtB1eN4tAKqTLhOJZAH5mIppKS8Li
	 RI8ERIXMpsCrjWA9zTa5wYHUkTaykJHlQMWxFBBQb2yKcvJJp+iraec71ETIMZxAfA
	 r+y9F+CxxcVy7IDhHiK4j6FJqJWkJNZuuIQtjUQU=
Date: Wed, 19 Aug 2026 14:40:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Rui Miguel Silva <rmfrfs@gmail.com>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Kris Huang <huang_kris@projectara.com>,
	greybus-dev <greybus-dev@lists.linaro.org>,
	linux-staging <linux-staging@lists.linux.dev>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	stable <stable@vger.kernel.org>, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] staging: greybus: light: initialize channel lock before
 registration
Message-ID: <2026081946-hamstring-sly-8c39@gregkh>
References: <20260818142020.1989539-1-runyu.xiao@seu.edu.cn>
 <2026081801-arguable-gosling-c590@gregkh>
 <ANAASQBEK9Ye2X-O4oze*arv.3.1787142765226.Hmail.220255722@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ANAASQBEK9Ye2X-O4oze*arv.3.1787142765226.Hmail.220255722@seu.edu.cn>

On Wed, Aug 19, 2026 at 08:32:45PM +0800, Runyu Xiao wrote:
> On Tue, Aug 18, 2026 at 20:23:10 +0200, Greg Kroah-Hartman wrote:
> > How was this found and tested?
> 
> 
> Found by code inspection: gb_lights_channel_register() publishes the
> LED class device and its brightness callback before
> mutex_init(&light->channels[i].lock) runs, so a concurrent brightness
> update can take an uninitialized mutex.

<snip>

Don't send html email with tracking images in it to a public mailing
list, they are rejected and generally considered bad-form.

greg k-h

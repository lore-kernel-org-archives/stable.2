Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC503CD8A8
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586413; cv=none; b=Y7gllX5U/6APl48znJjm7WQ4/vDz0W6BFka6JrinIz4eivyqfmSIhsMn6A8gbThEDPpzOrhfk+fNQXlTiD0BfQlGzrp+kSTOR86+xXPd3R0haz06tWhcVDjtGgcANuV03IVcJ3mbnCmRsjLNMbQ63ef5NDx0uca0B/VJIkDBxuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586413; c=relaxed/simple;
	bh=GqYOMS0tQ/zUf2ktF51zEA9/nsonMHVzRp3KK8Tnxvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6nlY46M+gSS1GtkVTL6toVL2CBrM2wdAG6wrnsglacSqrIDrLRdGkyvjG3SKxUdWS+0RsbzJq2aAZ7QphehJv5zWOpwHIBEJynf2D6DYmQFvojkboasn3dlX03QPQDEp7sxBOBQUATRQZLT7DNS9gsf2xT324r2jaCmBIa9ghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=PQ1dbdnm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G+xbG0bZ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="PQ1dbdnm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+xbG0bZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 661DF1D00172;
	Tue, 16 Jun 2026 01:06:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 16 Jun 2026 01:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781586411; x=1781672811; bh=h4gPK3FZ6b
	63Jyfr6Z/suOoSJEvo2X3t8RLqUz9KcA8=; b=PQ1dbdnm+pQgs5f5kTl6KSz+ft
	eaUZDsNJGJK3YztBcenK/Zu9hy4wRSncXPTCXHpye4jzHa4/OnXAYMNaoIqKh1nr
	NzErS/2ZHIfH/x90iPSoSblWF5ZuVhg+8XwlA7tr8HBR7ggn1GZiUc57zKSHnD6L
	oxbKWqFcPMZnXd6z7qKxeNvwIBhPHhkgGUYe5nGvwM59WbC7JInDQSub0Fyqi3F1
	w0flBypf/78vbWlSDAfE8+ovyaB+kFlbFu7088DOwUJG9ugoNb7be+FFxu4UYbq1
	TJhUifDBTbWVSOdV0ABhck/qXiN2p5qazch1Qv8lmVoXmTJAxs8jxPiMQZOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781586411; x=1781672811; bh=h4gPK3FZ6b63Jyfr6Z/suOoSJEvo2X3t8RL
	qUz9KcA8=; b=G+xbG0bZPw2oyg2t1TYuRvnlTvk/gRiA1F12DM6vnsllfAaOda3
	4Yb+Zsr20kLVC+mPLllqwgeq/ikuthfNZvQQH7rJGVMHmpovI6bobDybmjKOUUY8
	rSrvwxfYSNaCv+mjJt+GDdfNbPzMcpunlg6Xx+ueMWyKQtIV9F24eCHl0G/j7LYk
	n8oH1966mcLrAPaee92NUPgc/bxuCwzPqcINKJS3sbboxhUBtUVOvjJ+avuLxm8K
	eySQQuftneJHue3Rw0gifQEQdFMwuWtZNMnfyu+TvefKuvDRu+8DniSXGjhTtdG/
	+SARuW1DAYfcst8GWiZS/YMCMNvlHSi4LWw==
X-ME-Sender: <xms:6tkwaoaK62zh_YQVFIoyStCIAqu3COMbjJbeDze6E2syWpCrMC-CYg>
    <xme:6tkwatZ8L1samA_u5CePOG1KOXayBBlziYUwpFWnZDAoifIsRzAG-hl6s3R7_agYJ
    idWxLvMx7VIq-amDQGldP9UM4dLTj7U76KShlZcRhlxa4HE>
X-ME-Received: <xmr:6tkwapn55k5lWWpVpPd6kkI5rPJhNYwqFGXjWnNLuG_PB3xpIlvNRYho>
X-ME-Proxy-Cause: dmFkZTF8J3kCHEzZJQ90lPsnhmT3IWK7e209v8VpFQC//OCwqkYdSlhrXdu3YuT+NPplhg
    iBMz0zEz3dMylz1GVVDvIxnTLHpZoGg1DmRjwnZZIhzIR7oP/ZhX4AiHYm+PjYPbdfS/6f
    puTzfiHkOHPW5j3wfLnMqvtpAS9Z/G4fPAzly2W0FnWj/UxsACH+fXG7S1mV3670P+KYel
    h7dbv+3OpfOYiO7vxk95ulnh4CKibaiLpzaZbA56agLeKsr7BuSjZvql9pTRzzusEw9QNt
    vqoSOp4D8z5gUeKMGobL6FMzSKaPcInq6XYY6JpxvWmiQ93Cbh61j+KhokxTnPOY5u97nB
    Ne8sONMvHOFaCOKKL3i8dGx1QFwxtDGgUfQgEiVYVQwF1ktZS6xdQ3mbmNoPMeDGOZ67ui
    kxXMaOCTA2kEZJFRcdH01GYCVLDrCNOjpsRtmx516hx8R7+MslK6Aa2IcpzVYXH2mXk4gO
    5GRhjk8nPIGDd9oZeCZUhU2m3jx90QYe8mojVF5sA1NDbr/Gt2wMFDSD8YhJou6gyop1B1
    6+ia+ogXZyymbrGmNcqoK8HOTQZCeVJMRTuz6DgQbSlEaqLeeJ5Kk7Ks9osGkT6xYKzdmC
    ywQxjTToVGJrBYEi/daZngN6QxtZjaLcndM418OlxxFZpCRfHAfvwTOhClhw
X-ME-Proxy: <xmx:6tkwag26W8S2XwGYHkuW5-wDVKuyfAH6C0apP9EwY6uPhEU_U76CvA>
    <xmx:6tkwah029VB5nX60Wx2_hbmEUoHPRBvi4C4mj9Hzg-nC5owyH4n5uQ>
    <xmx:6tkwaqr4dQKHe9omp2MqLG5Y5WBBs9wbrT-Oy6pe5l7KPfhxqq6cTg>
    <xmx:6tkwalhxeTmyZsBgkcAAqHe-jXcOXePNRla1IS9gactI_AMqv4NfKw>
    <xmx:69kwapSaM8_wUZ0n3efCKYjlohW0YYq0QahJw4P3bjhURLY3LcCalT5M>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 01:06:49 -0400 (EDT)
Date: Tue, 16 Jun 2026 10:35:45 +0530
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 6.6.y] iio: dac: ad5686: fix powerdown control on
 dual-channel devices
Message-ID: <2026061638-struggle-enforced-f8d7@gregkh>
References: <2026060441-corrosive-musky-8357@gregkh>
 <20260604161903.3777464-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604161903.3777464-1-sashal@kernel.org>

On Thu, Jun 04, 2026 at 12:19:03PM -0400, Sasha Levin wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> [ Upstream commit 8aeaf25a85263a7a43357e16ad78ab969f6f8aeb ]
> 
> Fix powerdown control by using a proper bit shift for the powerdown mask
> values. During initialization, powerdown bits are initialized so that
> unused bits are set to 1 and the correct bit shift is used. Dual-channel
> devices use one-hot encoding in the address and that reflects on the
> position of the powerdown bits, which are not channel-index based
> for that case. Quad-channel devices also use one-hot encoding for the
> channel address but the result of log2(address) coincides with the channel
> index value. Mask as 0x3U is used rather than 0x3, because shift can reach
> value of 30 (last channel of a 16-channel device), which would mess with
> the sign bit. The issue was introduced when first adding support for
> dual-channel devices, which overlooked powerdown control differences.
> 
> Fixes: 7dc8faeab3e3 ("iio: dac: ad5686: add support for AD5338R")
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/iio/dac/ad5686.c | 46 +++++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 

Does not apply :(

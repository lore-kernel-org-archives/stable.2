Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302108;
	b=KpVt9CJhjVetLII1yh14Tr/RZ4CY6nOrkiORgL/hxDdmGOcmjPhYllaptw/5eFZ5lLcV
	 BGyIBc61C8ThMwy96WpIH5mkq4Thb7JikXK+TaIeMRue2+ToFzfuCnJ5lQ08ay5TZgCHi
	 Q3l/9kHKBsbe/sCDEayzLFU+C1hfN7GNhNk5aKey0o5Xjv12xYfPcVgiIiioTVzqn3Wwi
	 D2Bq4zvq5AF6BXqyYaxm0JfXayAk2/PNp8xU5E8Bujp2HxyazhsB4BkU+cliKua+pG+x+
	 PH8eC1bwg8Fam00rRBgUrSOE2Z1DLWFBgBB/7hmcvwdWFmTaPhtOgQVK1e0lt5zRFxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302108;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=f2nY2psBL9Dn36CGhhiafRyd89S7py63c4DQ0xt83qo=;
	b=zVCx/WxKe2LNwVVkbwzDdtqahU4BmbxZ2sPWMFgT9kRymRIhHnTGQyLBwthXRPxaHEJN
	 nHx2jcAdiqB5ye2b91O3Kl9VZ03z7x/Ychjn5zAp8INlFXef8CUZ565ORVOvT8hDfmNFT
	 3h5x77PiJGXNPFEUrKA6nSPKI2IRY8c/QyDios/4uCfxNOwbt/eBpiu18gkR+2zgtfCP5
	 AmocvN2PYnyKOj79Dh2nW3GlWMqWwVo64+B/8BiDtZS6piIbFUsTIfCXA3crW6wB4jYWG
	 ebO4hoSKVzPx2nRmcEUB+fhHSwQcbhaKIwO5oS4mVaXFUthVZiVopE7B8adPHi9mrow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adAFt7a6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EB74F606A32A;
	Tue, 10 Nov 2026 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adAFt7a6
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id ED8381F0089F;
	Tue, 10 Nov 2026 09:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302106;
	bh=f2nY2psBL9Dn36CGhhiafRyd89S7py63c4DQ0xt83qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=adAFt7a6BXxxbbviaxn8vaXQDnCFhRCDgHvgs6yQ9qvueBadNDKcHW8+CMux9c57j
	 OP+Np/7/jNRlOJBCu3H2az/Efk45qMsYdkmz7pfFPbIiKdVIsA/LG8MnUVzlTsJiWg
	 IbwcYKDSQPQKw7p4r80M4kIGFLtg62IGxWicuX/7iyRtv+basr6EuhYvBrnVotPx2+
	 A36tXHfm/9vjrqivF8jMVWqrGYKINPNSBCiVjKjagbgW1YK03VTwMrhjYYysMWgryD
	 8MmjngK5XWS8IjYc0tZoQsrF95Z/MMODLCU+aulb0+kKVFVWYR7Z/JH57LSHdZG//e
	 zfGWCLE+xNsmQ==
Date: Tue, 10 Nov 2026 10:15:03 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] gpio: sodaville: fix use-after-free bug when registering
 the irqchip
Message-ID: <kyqnjm57yrercvg5raacrxwt46p2fig6leeeywipv66c3iqzlg@tdh5swet65jb>
References: <20261105-gpio-sodaville-use-after-free-v1-1-f572f40feedd@oss.qualcomm.com>
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
In-Reply-To: <20261105-gpio-sodaville-use-after-free-v1-1-f572f40feedd@oss.qualcomm.com>

On Thu, Nov 05, 2026 at 02:14:27PM +0100, Bartosz Golaszewski wrote:
> In sdv_register_irqsupport(), if irq_domain_create_legacy() fails during
> device probing, a generic IRQ chip is left registered in the global gc_list
> while its underlying memory is freed, leading to a use-after-free. Use
> the managed variant of irq_setup_generic_chip() to ensure that the chip
> gets unregistered before the memory it uses is freed.
> 
 
Andy, will you queue this or should I take it for this week's PR with
fixes?

Bart

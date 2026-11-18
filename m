Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041111;
	b=hWdMEARAIlV8+bn+cxmqWJ5ZqIXDBNlMo8DbrA2PKU4jyHx6RpxCfzIeMpGgM8PEmMnX
	 NNkQhakKdmg3qnFyb7X8+I5KviSHa3RjdLT52OL8ZlOGITEFdM9wif3EvEfxxcjAEC9ou
	 1un0eFrNw1LMLqcx4ITqe1vrrByd9MXxKzMkamO5HXUScNippYwo6AP9K/U/pj8XllBji
	 U4m4MgQpMZzcJSPZJNy/3G0o3VCu5BFdL+CGoRxuknGobgdZ90ypDTF9j0jbC/s5JmHQz
	 5FcB3Hh6WIjaJgcP6U65skFK1TnJ5Rzg8OOQvXjFAS7yv5nFthMK76wB1tEFQ99xd/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041111;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=aDul+VgzHXJAnaDvASj93S0Y/BexSBs9fmx8vcZBfaM=;
	b=2gpdAPGDo1uhdd/VpDVYUMdn+eLbH+wIuSY/o0iU1IJGIeIIlBZ+f2BzkOhlsNOjEcjb
	 hosXLIzNIZkstXApGfnMOMtqwnI4JWEJvhN2FYdq9hR7/x75NWHPG6pkmbGniPsv3079+
	 MC2n+x84kPP9YgC7bh7HA/3DU9cfBzWxVoXyY9LdZQBiB8w22gt6sHhUI2ooJFHXuP0/v
	 epgvz/stsn0H5Jr3fSm4/+5Sj5MDTfEqTXVaFaETwDpSMKItGYFt72Awv/YvBkc9+WN/0
	 MDLV0ijsthMJVx/UT/Fj4D+Qhx8OHwp1ortnHFijWZpLqrKDQUJPvsOTmut5wGmmhjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dolcini.it;
	spf=pass smtp.mailfrom=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=ZA67krL1;
	arc=none smtp.remote-ip=217.194.8.81
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFFD606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EFFD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=ZA67krL1
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 517D71F8F7;
	Wed, 18 Nov 2026 23:31:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1795041107;
	bh=aDul+VgzHXJAnaDvASj93S0Y/BexSBs9fmx8vcZBfaM=; h=From:To:Subject;
	b=ZA67krL1mdo4kNiwpFYwe5iDzAplPx0Wri5p7q0pPeSOAbetJQLy+8wwvBaoynJLU
	 Wr2Q1wwKoOSHDjaGwK3zCkAOkShpDlo7jZc0J07nJ4VhR5m89KcHhjuTWM1Vf1kme8
	 I2wSZ+UYfgsPUQAOkLYxUUbHrRxmmCBY7fHh57ZL2a61hswJ5u3WVbWNnK015JD5Oa
	 tJBQWSuiOxe6mW0vyyECkKfINRpUWjBfNf0YgoBE7/vBhVvX50pJA91QdkHEXzq0I8
	 wVGns+7TO63ah2RMSp66VF7QBMM95Bq+pYYUv9gSxDqYmELiDDP2RBpBd4rWuCayaX
	 XXOFY/vB3nqEg==
Date: Wed, 18 Nov 2026 23:31:42 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Aristo Chen <aristo.chen@canonical.com>,
	Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 7.3 1238/2651] phy: freescale: fsl-samsung-hdmi:
 initialize default rate
Message-ID: <20261118223142.GA597634@francesco-nb>
References: <20261118150247.972732815@linuxfoundation.org>
 <20261118150332.571312313@linuxfoundation.org>
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
In-Reply-To: <20261118150332.571312313@linuxfoundation.org>

Hello Greg,

On Wed, Nov 18, 2026 at 03:41:18PM +0100, Greg Kroah-Hartman wrote:
> 7.3-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Aristo Chen <aristo.chen@canonical.com>
> 
> [ Upstream commit c01ccf91b257741e9edc374a465126bae9ae4711 ]

This patch introduces regression in any RC release, 6.12, 6.18 and 7.3,
please drop it.

Multiple people is affected, and I did send a revert 2 days ago, see
https://lore.kernel.org/all/20261116162409.218059-1-francesco@dolcini.it/

Francesco




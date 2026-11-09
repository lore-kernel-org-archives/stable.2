Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253667;
	b=wA3vmlqfQcZeEUZxQQWfhI9qnCX8XrHRPhHlG7eZNOunyaO0O3gTIetXqolLqrH2ImiM
	 lWWUizUAAH3pDEDpoGg7vSUNa6QnwsJq1ltQ0Xdn06ywrLflqWD2KOyP5/2Xbt+HDequV
	 bsheujTqWUCWJOKYN8uvi20BJHbUradPKBJ9jTyCjrBcyWMXD+MiLE65Ylmb7ugHFCZEp
	 GJnwgx1zijQJslADrwdgsRatjcKp2m8U6yAt3wO4uLxFemeiaQXhERnM+gk2aa9Njr7+K
	 5JdC+wAX0UokbBXXBz5zeSEAOPwkFXsxwEfvj3ZLXRiBAbfvo4DOlUV0XXU0MbeQfwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253667;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pV9krjWOm7CMLnjJAX1T7pyND4JTthbimwkKyjuLO5s=;
	b=TwscCrIBx1+QKgA0mRyzqo8areCq2kQFYxKSuYvAXXOy9NJvGgIzHnhLzq/yHH0Lbodk
	 s7WBHqGEmNdt3Mpg+FD6CJEX23y5CrpOpTc72ZRAhZ/d4rBUGpr5FPNlSeg22c6cNQ8kT
	 QITCWrFkSxgWtEj9Sj0QdelymOvlkOgedblBJwgFWv3YlY4wRf3XVx56wBjZT8v622NQK
	 +xqhmfHDzC8z5tZxqYYbv1ql0fd6yNNWFbsEopfgJ6eK4/Zh87fcx/c8kcD5aGaVQMgY/
	 EMaUYrE6j3D9KCNB1JB/dUJNd3qeO3DJwFGKHVOSXX1MY1RwcJMY9nWGm26hjT2W1Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfztcQIO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD7606A31C;
	Mon,  9 Nov 2026 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfztcQIO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000601F008A3;
	Mon,  9 Nov 2026 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253667;
	bh=pV9krjWOm7CMLnjJAX1T7pyND4JTthbimwkKyjuLO5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EfztcQIOLjPDiVXG8l/ywbkikMsKx4Go7eAv9fBVNjdTuIopgHireDOxeTNfWLd9o
	 UMw/ReoFmIBRiZ17vfylSsCf5Ifr9vYqxts9A8PCwUdcFMfZ0us9hbk7EtTIHW0B2W
	 w2N3xOJCiST4tEbF0XL5ePSe9pubjYFXeKjJRSbJXEQUoqIdOLx+/qNx591mz6+NKf
	 V2d31s4q4OZWgXZYhFM9NHh+3944Yx4E9KiNYykm4hwEACB1npQOAobZHsGaALl3h2
	 2TCp8z5TNvmXVZj18UighBqCmqv+KOFbvqRypP2lN4w8lvr2KuhI6KH/K7XoEzvyHB
	 R9/+O0yfsryXQ==
Date: Mon, 9 Nov 2026 20:47:43 +0100
From: Niklas Cassel <cassel@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ata: ahci_dwc: reject invalid device tree port numbers
Message-ID: <avIjXxp3hu7xd_s9@ryzen>
References: <avHknBRJnZPpAIke@ryzen>
 <20261110000234827nXRPQjzsInWFXaAaxeF6N@zte.com.cn>
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
In-Reply-To: <20261110000234827nXRPQjzsInWFXaAaxeF6N@zte.com.cn>

On Tue, Nov 10, 2026 at 12:02:34AM +0800, shao.mingyin@zte.com.cn wrote:
> On Mon, Nov 09, 2026 at 04:19:56PM +0100, Niklas Cassel wrote:
> > Again, this warning is reduntant, as it is already printed by
> > ahci_platform_get_resources().
> 
> Agreed, and thanks.  The KASAN run for this patch printed "invalid port
> number 100" twice in a row, which is exactly the duplication you point
> out; dropping the warning leaves only the skip, which is what the test
> exercises.
> 
> > And please send this as a patch 2/2 with the libahci_platform patch as a
> > patch 1/2.
> 
> Will do: 1/2 libahci_platform, 2/2 this one.  Since the code changes I
> won't carry Damien's v1 Reviewed-by over; he is Cc'd.

I think it is okay to keep his tag, since the only change is a dropped
warning.


Kind regards,
Niklas

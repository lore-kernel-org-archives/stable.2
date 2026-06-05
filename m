Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E293BADBD;
	Fri,  5 Jun 2026 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623782; cv=none; b=NU+gHUA/3klkd/NrPb8AQNtMM2O8wRMqHVkDb0wg7D3ZPNZCdMr3c/zFL4vsmQBAmJoav0RFwncL1VEmxHMCNcQpPC4Kn+90+ukn92I75aR92S2DKUhrVojp54lsIko65JqzN+NDtrvLd6gdLpkjmzQQspKsosoeYUmFa5dwAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623782; c=relaxed/simple;
	bh=dskLtZgJlzOyaLXcLQ6iatsl88TAxfTqf6uWcYshc2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5jVgH1fYWhod67GqA8/WnZTlXd8dC5Lri7hIpSWht2kTvzg6nkufpUYcluWER3VXmNOU4sqmiVU6/3zcuExz+uEowSbunH/yxir4FcIYOIaiRFoOXTzneyQXUMf+pABAJj6RKKXkZtdcHjTT1//wgPCGKtGVmjs4so7ff5RY24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWKBQlUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWKBQlUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960281F00893;
	Fri,  5 Jun 2026 01:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623775;
	bh=hpggIRYA6ue9PnR1MTPLybxfDbNvo8P3BOtZSnhepK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eWKBQlUVj1t2Y4gWkWfZyZ4g81wt7AJs3pBYWLQ0h+GcTfEnUsq+rQyDvJ8mgf3Wf
	 SIT9NS7G3Itd2eVi4lhmaPPJ9hilpYqhoCOJLoAIWLJ1Ud3i1AOeOZw6vzyGYSsW/+
	 zb4QQ3abTaE7bL2vaLqTYzQ6yG76u0wJl2OwON+TpgEX5UoQPJSZQifwpN2ufbZCEV
	 7m6Tq+wBucwQjOcIfTGQBIh5nGM8xTrawEEnS/BUSWazL6YoiOETt0cTjq22Fi5hhd
	 SLCUqCd7pH8pqT5KNkjaT1IkGCblwlD5mXx1AoBC5a1cYyNzl5c3GAEeM/v9acbovX
	 Or5VMRY29EyJw==
Date: Thu, 4 Jun 2026 18:42:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH RESEND net] net: mv643xx: fix OF node refcount
Message-ID: <20260604184253.2653d974@kernel.org>
In-Reply-To: <20260604083430.2b61c2c3@kernel.org>
References: <20260602073414.22500-1-bartosz.golaszewski@oss.qualcomm.com>
	<20260604083430.2b61c2c3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 08:34:30 -0700 Jakub Kicinski wrote:
> On Tue,  2 Jun 2026 09:34:14 +0200 Bartosz Golaszewski wrote:
> > Platform devices created with platform_device_alloc() call
> > platform_device_release() when the last reference to the device's
> > kobject is dropped. This function calls of_node_put() unconditionally.
> > This works fine for devices created with platform_device_register_full()
> > but users of the split approach (platform_device_alloc() +
> > platform_device_add()) must bump the reference of the of_node they
> > assign manually. Add the missing call to of_node_get().  
> 
> Where is it released? I think it's important to note, I can amend
> the commit message if needed..

Not enough coffee in the morning I guess.

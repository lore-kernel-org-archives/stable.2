Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F02D94A0
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417258; cv=none; b=h/V2oV4LSnKxunveP4IkgvSl48OhFKCNtYQ7VdvXB5JKaUTwRxLbf2KD4cQhfAjJ+4iy/hR/d1uv5moAaocBM6u0NaqmfnWNsLAZwK9QFYA93p0ameCn0sZXiYf3DLZZLJ57p150uiWrQ91N6Hoq4SnBoz7QpTstTFTfx8UvIeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417258; c=relaxed/simple;
	bh=udJ7tcsLtAzFRvocWl6MWJymtqcEnCUJWehE5qE0sJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkDMLGGjo2u5mTkW0n4t9ys57ydH++B/Gu0gQcJfwYdJWoyCBjf+i7SEHempFS9UDDXMrdOb8PKDOsP5EBlU6mfuVvx4cUbxz7cKnTKZQGUKbth1907a572IrCUw5RT3eOblplGudaYWVJEPdRSoX0HCix9kI8YPzRmeTWo7uT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=agKrwce0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ONz3kTKl; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="agKrwce0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ONz3kTKl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B297C1D000BE;
	Thu, 30 Jul 2026 09:14:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jul 2026 09:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785417255; x=1785503655; bh=bDWvpkhOPT
	3o0D4czkfzAI6pKrZ3JJPB7bp9jUEbf4o=; b=agKrwce0RLxgJDLIUy3E0XzXQe
	4FL2dXimyjEWFeFREvSfwKMK0DI3r9yswNcX1KDYt8fTj3Qy3wRCSwMiwh3cimx5
	jb1z3/GSD1WWoT7zg9Ee+b6Sc2zpFUBLNU5tsr2wkBzHq7c5hHxzv3BLQsC6ITvh
	1cn65cBxPsY/RA6wX0zOkopTF6+qosNEtzGN1Wusth4evCofLrRjhfRqxz9Qclnj
	V8isPwLTQ2UO/UPb0ID3UqICt/dy2l2xwP32dJzztc0gZgkuLeNqupA//QlC9ALQ
	rvqhuNvJzdsSNYiVRlcceZ8ZuQ2stHEiXiaSE0LMVlVJdpz3ZqfsMDc6aNow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785417255; x=1785503655; bh=bDWvpkhOPT3o0D4czkfzAI6pKrZ3JJPB7bp
	9jUEbf4o=; b=ONz3kTKl6NafUflKbjt5/2EVkgHtW3X/8DqOl2xJaG0xVOUUScr
	FXV0N8U1t8r7PkyekF98VaLpfQoJ2Nt4Y1iUGTs2W6CxfVmK0ZNksS13jGBCvxA7
	3v5Ajap4G27xTymWyVqEt6HscwgGMt29rVMt6k+H1KGittlKb1KZ8psZ1fiI/xcS
	kj8uPM54loi6NynXzLfuNI2AtBIHWDuPqen7u5CFYw+KpsjBQ5/a0QaIwZ0iFRw0
	SgRD8YrO+GL1Z2uVRsIWpOG8ErNCAIed9FXwDwzEM3lQ8jSbN9U2bymdByJxMlZC
	LfcWMiOsKXNw0U6Zki5mi3F6ADr6aCSFkgQ==
X-ME-Sender: <xms:J05rahw2KQ2mR9XlZSnidGj6M0hdgwsp12CQqYmyee2Jap6oNYvtQA>
    <xme:J05rakUzbvu1uYQwVTDKAb0kgpFv4pbINTs-7cC_jxnywQ7Ez5-OATDMHyEONBmCE
    aDvLuyqifAKICYb_hnkw9BNbTK2NdSmuQAX5QZxIh-Ty1Rzgfg>
X-ME-Received: <xmr:J05ral-qtYUqnHnssfcaxU2ye54SQmaNtgadzQf_7GfrIUZ_-nK4D5fdApTDx5r6v1tasPpRzE2hiB5rRZluN5G8UToCOGSnvJ6S-rShjd0>
X-ME-Proxy-Cause: dmFkZTEouAgF3kN3gS5P5dMOCDI6zp7vLWb4yB9VxU/hix7otEd4p54Ue2HZmb5OsI3/R+
    x9EONbBHsOXWBXbJ3rjY/c9ZQ5QzSMeb0X51vdoDeas5hXIjzIVFgv4gW+x6va83iBlFqP
    RpB1lBpRZ1xWdqJMw0AKIvMb2O7aZ+lqzDVy/iKh+4P12nsnfCelcaqkoyGLfmSGeKt7vO
    0noZACFxkeDvcoA1knpJEmcYcHNExyodjmsEhHksrJ8NNFm9jozmmejNgAZR8Xd093XBw/
    ehcKEJD7XarlxIowQFS2BMu6LGsuKbO2mEJWthvY8je5XtpckZyqMldETuUazjEP+W7ZGj
    so9EZZXFvm1huU7VguPtFyX7JARR5RXUlZAezYcDq8iaPxqCJfDhnKolifc2E9tC1YvVe2
    jiN4Lq9rUakeddAPZaXufUH5PqEOkJnesQ9/2MZLZIVhZIwO058bpAHHOWqlnrtn6GhtLY
    tPkeRs0Qd5tGJlsKZGV2KG/XxtyhPYinIamc9p3uEINykMj1I8NxI4Z1fyNyJiEGzkhfhb
    t93UIMOsaT+DVe6ksnLcb/EHGWGWdL47VzZZOBoNi/8k+kfVTVRrKf2KI/Afi6e5655kwk
    o3uCIJhh1SgLDOYUqKC8pXuhqz79bIgqHOoGLfP4KSwlG5JJPw46aYVx8moA
X-ME-Proxy: <xmx:J05ravtbAXDw06xQqwNAMzolv9sJShRaiSsZFdyJg_okobGao0AXsA>
    <xmx:J05rat0UXPKONuoestav28fgTFpYF2_ZMJHNxUozPGqCMFua6vJwxg>
    <xmx:J05rasSAIZB2YVNChOqE5_yHrzoBpG-Wg9u1Q18J6549Bjs4Okw3pA>
    <xmx:J05rapetHq4I4ZwTl6QG51K1YWdz5_Vp-hv2_JPdrdP97OJl3hZVNg>
    <xmx:J05rak04HqcbHA3AlKV1smzxZhj2PGhfrN9r4jYiE2I18aeJUGofg3pV>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 09:14:14 -0400 (EDT)
Date: Thu, 30 Jul 2026 15:14:01 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 6.6.y 1/4] i2c: core: fix irq domain leak on adapter
 registration failure
Message-ID: <2026073056-nature-oversold-2714@gregkh>
References: <2026071636-amusing-conduit-3c6b@gregkh>
 <20260721182758.332454-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721182758.332454-1-sashal@kernel.org>

On Tue, Jul 21, 2026 at 02:27:55PM -0400, Sasha Levin wrote:
> From: Johan Hovold <johan@kernel.org>
> 
> [ Upstream commit 8ce19524e4cc2462685f596a6402fbd8fb984ab2 ]
> 
> Make sure to tear down the host notify irq domain on adapter
> registration failure to avoid leaking it.
> 
> This issue was flagged by Sashiko when reviewing another adapter
> registration fix.
> 
> Fixes: 4d5538f5882a ("i2c: use an IRQ to report Host Notify events, not alert")
> Cc: stable@vger.kernel.org	# 4.10
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Stable-dep-of: 07d5fb537928 ("i2c: core: fix adapter debugfs creation")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/i2c/i2c-core-base.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 943f0021d6a2c1..4b3bc72ef53ddf 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1551,7 +1551,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  	res = device_register(&adap->dev);
>  	if (res) {
>  		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
> -		goto out_list;
> +		goto err_remove_irq_domain;
>  	}
>  
>  	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
> @@ -1599,6 +1599,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  	init_completion(&adap->dev_released);
>  	device_unregister(&adap->dev);
>  	wait_for_completion(&adap->dev_released);
> +err_remove_irq_domain:
> +	i2c_host_notify_irq_teardown(adap);
>  out_list:
>  	mutex_lock(&core_lock);
>  	idr_remove(&i2c_adapter_idr, adap->nr);
> -- 
> 2.53.0
> 
> 

Didn't apply :(

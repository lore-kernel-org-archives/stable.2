Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0B1B3B19
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783917329; cv=none; b=p7c77lFYv+EDYUDHBef1cHuVODsMFBBPjNNGD3lAJnaIMPddIZM9neO5w5yhYdads+PYdpKxp1qTE0LROVIEDTszn4TGi2XA6+KbC9gn/zw35Xnyz5RviwsuXarOvJHXmeloBQ9D9ufteq+tgwxCPQOI5B4GhooT1+E8/yCj3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783917329; c=relaxed/simple;
	bh=ddXWj/n6m5sj0uGy+wdrUodNVIUrlUfKGHm6GuIG+KA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=FrMSB81JCNu70aDA5CTZ2ytlI+vF77SrRp3riUgRkdBjxz28LA/u0VYXfULFzvtgs4DZVOZK8Ht589CpRoB4WzW/ITnZJlp4kNmdarhQasp9iepOmfnU5UDzPJmK3TCYDutNVCW1fXO0074z/iUq1cpXrzoBigxAAu9ojNWOUhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbfmJQgc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbfmJQgc"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so2013216a12.3
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 21:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783917327; x=1784522127; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Evmcp0cx/ey5p8NBBfV63KEI8AjczaUnGJLsFi1w810=;
        b=MbfmJQgcjHC9ZvGBdZH4EQ4OgSadnu8LHV19tyJ3R5QQCEX76InSOKr12ljagZaawm
         XEWdl3a0ZAFSv22bs03gZ+wEwId60sl3hEsI2FnKbDMNR8LJV+m2jo/rbA74rzWWsQsg
         k7B0C1TM2irWXHPSIMdi7/OwaBp/orJYiyR1PcV1Fx0xohx19hpoh0NpBiAv1nLwU95n
         2E8w6OuNcY1KILUa89swekt0f4Bm1MnrqsWUDSdxlQb0NE5A46Q+7s5Zd9r0rlBAoFWZ
         Z25DVuI97IIMCWWSOXNLjtSe1/b0xkMnom25DyRleenPxL5/e2jBASSrS8VTBR8BARvp
         bpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783917327; x=1784522127;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Evmcp0cx/ey5p8NBBfV63KEI8AjczaUnGJLsFi1w810=;
        b=X0dSz1Xa8bENs+xr6ObyUEhhGMbZYqqxdU3tSRjT9MxLdSBK45W66lFb1/iR8gt5xS
         sMcT0lqpPgw3f+OOLEr5idee3VWTyWI3IyNS5GUOj1kUJiyz5bSh9rZiUnsY0q9kriRy
         lPdK9YWEQbu1ExDpHMNrCE/AvBZCaJt6tTNtJhdOMj0w5IhSz+KZmcsu9l8a3SZZrHGz
         QoMLmydKQYm6GoZSLOZ/iSiX0abDDMjXdVdvMAS3DgEf7/hWD9eiT82CLRboWyTL019l
         ++Bqyvg1kw2+eqV4YnKdWtP0z73rESoI3k053drXhjV7uvmYfL+95clXTh5LtD/mf59g
         hHRw==
X-Forwarded-Encrypted: i=1; AHgh+RoF48nVtYa0QI05TjC7drEYwXjvABvIkFYpR+i8MGmpB9KzmrsagvWHCDm+xEAIx7WaiSa2m7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZS2Pc71d8pTsFIBYfX4mE/to84mvpcBr7OFjY8KhVCaSsfUCf
	94ZO0HAdQgq1paMT3hnPaDs+xuH88vGT9ZyEg6rtBhJTLzvyoVPNqK1+
X-Gm-Gg: AfdE7ckyjdtLg6ORl26UX5xtjfH+yu4yACzPfE+gB5YCszqUXWTfzIU+JcAg0S6irlI
	+4ytld15AAGcjvZSB5cHPCMyAiMrKhvgNnTFgIvVC5HPJ4y+GPu1gBv9Oaky3L5lfw54UpawFvx
	WasCJo+NsYQPFEt6k1h+KypZvGl5xWISZ7KlArU3MxRsDzf/oB/bIG33HOrKJEnUzum9ECot8xW
	zJPt632yPvZE+BL5ZyH48uOZ+MN9hoWLPUMC99Xn2aFJWEAKQauMy4uggPH75j5ouGDFSt4wf9r
	uyoSS9r0uJHLgxJgR9bW1YOK0Q5XTWk4x4jiOnwWIb3HOgedfUS97mRRoZaLh93JOaFL4NxsRZA
	X7HE8+CGBRD0rnR4yzOBBBiwFyq3qrMWORlnoek8BMWzBxAUTf8SwdBGBL4i1BlJMpIhWq489wk
	48ELXGqm/EBcM=
X-Received: by 2002:a05:6a21:398e:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3c11018d907mr8510137637.21.1783917327122;
        Sun, 12 Jul 2026 21:35:27 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b987fc629sm14989693c88.0.2026.07.12.21.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 21:35:26 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] powerpc/pseries: Handle and log pseries-wdt registration failures
In-Reply-To: <20260713035954.1559605-3-sourabhjain@linux.ibm.com>
Date: Mon, 13 Jul 2026 09:59:58 +0530
Message-ID: <qzl7v7eh.ritesh.list@gmail.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com> <20260713035954.1559605-3-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> The pseries watchdog initialization registers the pseries-wdt platform
> device using platform_device_register_simple(), but currently ignores
> its return value.
>
> Check the returned pointer for errors, log a descriptive error message
> when registration fails, and propagate the failure code to the caller.
> This avoids silently ignoring platform device registration failures.
>

Fair enough.

> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/setup.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 1223dc961242..bbb2813f8ede 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -191,8 +191,18 @@ static void __init fwnmi_init(void)
>   */
>  static __init int pseries_wdt_init(void)
>  {
> -	if (firmware_has_feature(FW_FEATURE_WATCHDOG))
> -		platform_device_register_simple("pseries-wdt", 0, NULL, 0);
> +	struct platform_device *pseries_wdt_dev;

minor nit: we should rename this to pdev, since it is already under
pseries_wdt_init(). That is generally how all platform drivers use it
unless it requires more than one platform device.

But either ways the patch looks good to me:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> +
> +	if (!firmware_has_feature(FW_FEATURE_WATCHDOG))
> +		return 0;
> +
> +	pseries_wdt_dev = platform_device_register_simple("pseries-wdt", 0, NULL, 0);
> +
> +	if (IS_ERR(pseries_wdt_dev)) {
> +		pr_err("Failed to register pseries-wdt platform device\n");
> +		return PTR_ERR(pseries_wdt_dev);
> +	}
> +
>  	return 0;
>  }
>  machine_subsys_initcall(pseries, pseries_wdt_init);
> -- 
> 2.52.0

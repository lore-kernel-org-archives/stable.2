Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04639B489
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875985; cv=none; b=igvlzc4qar78zycODccisNwCUu+lU2XvqSagMtRBco3RjdgrZNyK2YKxe8sqLFzBTcIHiLgttvxcpVh6kmAg70mnYUA5LybF/p3Z/CAtvMuCaFGUyTGMCf6wu2XX4yo9B91KvbBmVyVoKF+ypsNyhZPIKGMqDzXi4x1ULCBVCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875985; c=relaxed/simple;
	bh=C6g4IJ7nkIuLRBYnGLfnGuivsqdEPRmNM7+k8tmIPGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icr68jciWvszJO0GIqhp0/MjtGz+UmUX8MIxBKdA2H1KN+fWjnDWb/Ym83svHRjJovQ5m0lwXQp2ggweQVdDo4qx4i0nJxGoLZ4Fzit/HKN/HUIgi7zOLPXxT5xapFi16xRlJuZLJWEJhPJqO+zUCQ0Z0ybceDQlEllDP8pZpUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EgHRNfcV; arc=none smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EgHRNfcV"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c1971f5efc3so9383966b.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 23:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784875979; x=1785480779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WY7CdMG8toSwubevIKGiHcYEpkYHz2KmtfuPZHWqhkg=;
        b=EgHRNfcVzCUNbMbONBBHLiQGbTrXedCgX8uAfEG+Ygpk4rhFzgk3DmzMZ/x+pZeY1U
         WhQ4SpvnQ+WPvx9ksx10dIP1mpB7Bx+NZSvFcIn5wQOkWe1QKeCgZc96fEDIl54yyOrN
         WfJgjb6NVcfRs1bWrRj8WSdE6KUow79Uzq6DOyWTpFG9b3n53LXUNsa3fC4YmO417FNm
         kRPn3D0WUYpA40gcr/HfSQbOGZTTY2VwOdELDdnBxx93jEfnF/YVuq3SLY6AS5zVCGBL
         dhemDSC4J3UzC28Zr7E2xmgPDQ5F1DmPwv4JP8wc37AcJ9yWyZRsxYssl+C9zvSHXVsM
         zKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784875979; x=1785480779;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WY7CdMG8toSwubevIKGiHcYEpkYHz2KmtfuPZHWqhkg=;
        b=W6iZbd0/8g3IU9lblIp9UDFbeUU2br5T7Ax/W77Nwnhlw33DZ7UHpbUmvBgSB7gkid
         alV4Q7luFZ473eAs+W6eFT1vNL43n2qadxi0M3WKN+4FlV95SDW0u3VA2CTAvsf6evqB
         OxjYXruysSRaYONTJ4x+Aup7dA4I7d9gSRftocTcYAKz8G44DKCKp4g1V8h510kdx0P9
         H6ZM9uErVH8J8774oMy6ilk5/yrAbGdvGcTWUKgxsYMH1FC7BoOea+u6FXaUnYYlE3fP
         hqwrwHTsH6SevRI82NttD570Fiy9lOm6OefcZL0DgMwl1As7ogDVA2BKs1mQUu2bXZdW
         /8xQ==
X-Gm-Message-State: AOJu0Yw8rXgqvLA6Qz+LUeaU9UNoid3c9h7l0iw4VnwOlNj0ZVJv2+pU
	jT5jpLGAdpIgJ9DXXyguLPBWi+Om54pbcPY/9H8z+TxnQyHL/+0yFxLl5dcgTiBE+DE=
X-Gm-Gg: AR+sD11njlnetDkV6npR2k8i41yM5YOsJNuq9u2eNbG9cG5TK9+C9lhexJkCRivvDxR
	+GWbwFr81AvloOpLCwFy41IujV2FbAuRIEnflM3k/k5VCftgk3WUhGu6ibyd4w17zumtUXZgddO
	IRxBT5SOR2s6phuKojS3Ho6w+8Y4z60vVDKkthUoXGAJX547QeamAakfS2dj9FlHeK5DgIBSupd
	PDjJ8hL5bri7kvO2NnxklcQ3MoS1KVWvVnFvoLlRmyuSafdW0Rn4vul4No/ejIAcNdofYrjisx6
	y47idLcy1v/a0dXr3zM/dfSWtMRZmvqiKt15DXN8n08tm7Cltp2k56ikL86I5p5smCjTz3Cg8m6
	GkibaG7lbV/2PXTJjaoAMboWp5w130O4UC3X8XhZLsDDqoRiyHfvnqjybai5SvoSUXipxqI+CtT
	ZFQPnT9s0MPnWOsm5ZRQN6JNhWe+c4
X-Received: by 2002:a17:907:1c02:b0:c15:b332:260f with SMTP id a640c23a62f3a-c1c5089e82fmr290349466b.30.1784875978862;
        Thu, 23 Jul 2026 23:52:58 -0700 (PDT)
Received: from u94a (61-227-70-26.dynamic-ip.hinet.net. [61.227.70.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03b0eaa8sm1009011a91.8.2026.07.23.23.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 23:52:57 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:52:50 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 0000/1226] 6.6.145-rc2 review
Message-ID: <amMLUyAZFJJY73JI@u94a>
References: <20260722143258.264584003@linuxfoundation.org>
 <amHSEwZcutUhO5tL@u94a>
 <2026072304-dentist-repayment-4761@gregkh>
 <2026072416-chunk-curtain-332d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026072416-chunk-curtain-332d@gregkh>

On Fri, Jul 24, 2026 at 08:18:39AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 23, 2026 at 12:17:23PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jul 23, 2026 at 04:37:07PM +0800, Shung-Hsi Yu wrote:
> > > On Wed, Jul 22, 2026 at 04:33:42PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.6.145 release.
> > > > There are 1226 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Fri, 24 Jul 2026 14:31:21 +0000.
> > > > Anything received after that time might be too late.
> > > 
> > > BPF selftests compilation is currently broken. But with [1] applied it
> > > will build, with test_progs, test_progs-no_alu32, test_progs-cpuv4,
> > > test_maps, test_verifier in BPF selftests all passes[2] on x86_64 and
> > > aarch64.
> > > 
> > > Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > > 
> > > 1: https://lore.kernel.org/stable/20260723071334.39630-1-shung-hsi.yu@suse.com/
> > > 2: https://github.com/kernel-patches/linux-stable/actions/runs/29987147891
> > 
> > Ok, I'll go queue those up for 6.12.y and 6.6.y now, thanks!
> 
> As I said on the thread for those patches, they only applied to 6.12.y,
> so 6.6 will remain as-is for now :(

Hmm, I would swear that `git cherry-pick $6-12-commit` in 6.6 worked
when I tried. Maybe I got the wrong tree.

Will resend one specifically for 6.6.y, sorry for the hassle.

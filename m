Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93E947D440
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251245; cv=pass; b=G+X/zAcYhgMAR8CFEpl7KIJCWLYGzaGp6B7Yv8AsDSk5lpXcBzIiJbRxAumCkXoqqkLiVtgMIXIdU+XH57ZdsAOOQnxuNhOf7P+FlceIceKM+5+QHt21yOLTsO4txbKQO8Dp3uXJJxqekyuOdLiFj17Fgt8QxMjBdfT7n/omqkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251245; c=relaxed/simple;
	bh=V4eu6A97YuNjzUNXoyTJh0xukmvbj4affVPwK+58STs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQJAQg8e0+yauqPcry1ZURPO7I6FGg3AlO1wdjFLvMpDYnZpGVWNnneXPa6gtn78Ub/vQjLmXS64V+lJFlJ/2pBcXre0csCLUZaUx9WSbMhd55GFNAnJ9ctAENEcNzM4U8CedfmFVZOARZa2dkKuHEYsGQ+JaE21r2PAgUD6rs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdVWudRr; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdVWudRr"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43db0c17so29273047b3.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 05:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790251240; cv=none;
        d=google.com; s=arc-20260327;
        b=LZ4Xqu2fQzrauocNYVpv7oDUWKvC0YQGpQbAGm3KnL4y31xNWbd1FL1eq/k73G0eG5
         NyybXJ6qvP98A/Z30TAqhd1dngtBGcFFwh4L7IepLhqR+3j2eoXr4+bAqlAhfXm1bDhd
         Nv2dPZ5DHbicE2Fj8NGH0Ev7PZLE2S4VYYoCw+CBZI0LR9WKSGTzRPLoNWkKrv+p+e9Z
         2NNrHDoKhdwDWuXyy02kTAcaz+He3+sc0/7rAPd4NJlqNRzdr9sf917c06UC7XrVVwWM
         KjzakVgjH+o8ylcGr7xwPpPokIsbBKdtuF72WRR4At5g4G28N1w537Kp3l+gjmvBsLZw
         EVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V4eu6A97YuNjzUNXoyTJh0xukmvbj4affVPwK+58STs=;
        fh=i4pxQ5MWsf8JRCI8Uc0Qgoxghy/nDF48/CB/XDItJSM=;
        b=LVVeByj3seou+z40oWOfuiHMSfp7cvv+RacClkGKMGITBRRy+yzKxXbXpy5zc0wqd+
         eW7/Z6gwVABfFz/I9IODEzNCaj9S+o/K3tfkBMQL9k4M6aJtMQbJV1dJ6LJkzi8i6Evc
         UGgcFqqewNDyjwekdHR5g1/M1xpgmZK6U4KiJMiBUXHtwlWA4deoigaDg7fktRdQ9qhU
         XWnccCFatU/o7UhoBd3LH/ZV7PdNliLBbRzBUIfoSB1bf5Alerrvs91Ch6EwYv2az/Hd
         bTe4ckbQV6EvHb0psBBuNyaFA+27X5r2KlBJ3ehCbQ94G4dBr4pVaNZO2Mc5t1JZsbBd
         dXiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790251240; x=1790856040; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V4eu6A97YuNjzUNXoyTJh0xukmvbj4affVPwK+58STs=;
        b=JdVWudRrI3FiJXAk84gED11cP06wPOP4bn8sz3yLOTnjFy+NL+YGTWLdT7k1EuZpwN
         /2B/ZVI+G+P/+P8+Yx/5rtP2r9fyRKdIS1oZSYI1OQfB7WQadgNH3um1vbhViybI48Dl
         rprFZGxI8OUzJ5NocUYfmftLftP+I1rnUJS2kkHascv+eDrf282C8sMkQDLQwHMkcICJ
         F/E2HT4o3LydGNkzlZ1SVUrDuVUMGPz2MctzQft+lmtBihkefOnAkRj5YsY50+QsnT4S
         jH46oDYc1LphzuXOyBQOPLowvfRkSK2WrkIlxuEYTygwTPnyZjV/GFKgoouWdXngmbVT
         3cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790251240; x=1790856040;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V4eu6A97YuNjzUNXoyTJh0xukmvbj4affVPwK+58STs=;
        b=V+7YNSs6iDSNs7uT8fRWGpXiha484/0zgPAWNbxIDAIIsEXfMW0CKx7weyhuQ1MtJ3
         w/UEkM3sWBgMnT/LBpds9B5qJA9AzI6HefKbAuztYT7YCnFdkw0BBpCyMB95FBsDsXZs
         05NI8kUT9pZPSe6XnSdlSrdA72KhY14McCAm3x2sPLsSxqDId07hoklnRqoZTQSpcwTn
         wGWYoGdl7B/JLuritTvcKvY2og+ffpQmw3SUtra/fUm01aElG5EKfcNHNq6K7YT4nI4/
         G4SPGikP0Hd9R+4N4kih0ck0IiESxVgCB0wop4BMT4lOAZY30j8DkqkYT8LQiz1EMjXR
         27Vg==
X-Forwarded-Encrypted: i=1; AKwUvBz7wKRVfUBDxMscvp3EXG215KdCI+mxS+u5oEADTg+MWHR6t5Zb4uBgC6jrk1X9O4voNZa5A5A=@vger.kernel.org
X-Gm-Message-State: AFuF++kNZHl0cawasyam9VKoWpcrlELY1pLGvB25S+z17NKHo0chWfGu
	g2m5MPKuEAshL94GXdbsAKhPIBFWj48xSlhZiq5EqvcgA8vgi4e3ZwD555i9bYnzd7fIC2iK0g/
	aH6r2OMdyMQQQqznJ8GqJcIlaZUt6u3I=
X-Gm-Gg: AYBFou0ilOCbichVPFPKzkkUzUSEtkLgvnV2hEa6HzS7fLYBokxYNbPqA5ErS45J1tI
	G0onghRAcGBAbDUrF5tjCP95a8rflEX6r13weSAzKd2yc4uxoq+AZKlFsku33OJrz3pnDTxGmDL
	1Bie4Tf1k+HXLRIMK0mkPIZiMpxDzKmxTE+Jh/6pJ82ifBkRbNlkcEXLec11+7p/uuDcPimtyqz
	mvzfwQvJ6YQy/+XNnObN0yawRsG17BDtCrVTs8+3Mz8QX6FqNbszhCjwkXMEpHV7Q+bQyaZecbt
	XHlDsJ1Weqlkvi5xMAR9s6sM24SXm5r2x418xm7kn2GRgdpXu8gskpU/ew==
X-Received: by 2002:a05:690e:c46:b0:673:938f:684 with SMTP id
 956f58d0204a3-673938f08d6mr168889d50.56.1790251239884; Thu, 24 Sep 2026
 05:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921104058.353748-1-lgs201920130244@gmail.com>
 <20260921110512.GS106095@black.igk.intel.com> <CANUHTR9gA-mKn8Y496Pty4_Fhu3BSSyhXWrmiod1WvuVdQjkag@mail.gmail.com>
 <arJ0pDlXpdlsF0sT@ashevche-desk.local> <20260922123315.GF106095@black.igk.intel.com>
In-Reply-To: <20260922123315.GF106095@black.igk.intel.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 24 Sep 2026 20:00:29 +0800
X-Gm-Features: AclHuK8ajLz_1mV9OsX5cTlVyofvFYTK8P24xEanxXIUMhPnGnhiLT98a2I6OJ0
Message-ID: <CANUHTR_Su1KxOeB2fJDwzVeyW4WpnWuzTYm=6Yz4z12Pr6GugQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: intel-lpss: fix iDMA device leak on probe failure
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee@kernel.org>, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks Andy and Mika.

On Tue, 22 Sept 2026 at 20:33, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Sep 22, 2026 at 03:29:24PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 22, 2026 at 03:59:32PM +0800, Guangshuo Li wrote:
> > > On Mon, 21 Sept 2026 at 19:05, Mika Westerberg
> > > <mika.westerberg@linux.intel.com> wrote:
> > > > On Mon, Sep 21, 2026 at 06:40:58PM +0800, Guangshuo Li wrote:
> >
> > > > I think this could use devm_mfd_add_devices() instead.
> > > >
> > > > > The issue was identified by a static analysis tool I developed and
> > > > > confirmed by manual review.
> >
> > > Do you mean converting both MFD registrations to devm_mfd_add_devices()
> > > and dropping the explicit mfd_remove_devices() from the remove path, like
> > > this?
> >
> > Won't work properly. The rule of thumb, it should be no 'goto' after devm_*() call.
>
> hmm, isn't the unwind done in driver core and has nothing to do with goto?
> Maybe things have changed since I last time looked? ;-)

devm_mfd_add_devices() would remove the children when the parent
device's devres is released after probe returns an error. However, the
current error path tears down the debugfs, LTR, clock, and IDA state
before returning, while intel_lpss_remove() removes the MFD children
before those resources.

Given that ordering, would keeping mfd_add_devices() and adding
mfd_remove_devices() at err_remove_ltr, as in the original patch, be
preferable here?

Thanks,
Guangshuo

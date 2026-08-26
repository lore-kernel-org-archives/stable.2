Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9A3B71DB
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731936; cv=pass; b=Pau6uofH9Z3mduTU9ZtiQYCy6HTiWdst3MAVUrQaDCVAfHFBUSeHgYuXrFBfaT0YlqPLyZwaHYGZA4qRMt8zZ0nlm3lRbci3j8m2uSdL4wRuvWc0MRAnACGB6R82QwjIfgzqfddm4qRH+I3FyNeRKerfSoylP+hScdliP1X9Cxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731936; c=relaxed/simple;
	bh=yQc/Ey0ssENHrHqEgMHYIV5akmCC8HHrE+7PeThi0ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQy1Lvc1JpmUdfKVFajKD9+cF8OfjzemoSQj2t9uE5L156UqogzN3t0uriBwhobTX2lfofupNKu7MBrIGIIQ3MRFCl14BeRPEKWPBv33ihTBlVXkkBiTkPXmVgxS2Slj1c6NTppJjaJ2HBFkBE/SJJ1xgcVO7bgAti3GBLoRB9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5l1aymp; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5l1aymp"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66c711b7f2aso1058374d50.3
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731930; cv=none;
        d=google.com; s=arc-20260327;
        b=M6X56EgyZz2iXXBOf68GO7zN5K9b2xJT8DsB4nZSPF2lO/MZ2os6sl8Cy6t0vnVMTE
         rveH9onfJmo6v6DDMAP4Mm6cDr3HrvBnNRh7eNaXmN4/vl/kPWZVtnDHmd1PZeEwo7/p
         SO8Scu4Ckqwuco00h/gw2ADnskm1rWTImu0jpWDpFWi0+rpDEbzEdH/0fUxWHt9FRVhZ
         gSDTXI1xwVxVskN2VtY8aWd032Tn+c7pgQ4Sjir0ltGfD4/X1eWG82Jux27qcL/2C4KL
         rQMWc924Afeut2S7/R5//Ml4Px5sCRC7iuROd5fNPXau+y6dltAnl3/Kfla+oPsurplO
         xO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yQc/Ey0ssENHrHqEgMHYIV5akmCC8HHrE+7PeThi0ys=;
        fh=wVMvvOialvU2pJuQpJ/MhOrOyJAbZIXHc3jeiECLY3E=;
        b=EfzY4dUxHnRbC9U9cz7DP3pi4/haJg55URpSjDifGKRx6kwuKkiwhAuf532wIyeSXE
         zPzWlN1ioDkOm2gUyocaTUd96qmyKMkUL3AXdgg4okdx0jTtcQ9dyLqF3oa+wcQjeeF9
         jlJgGjVRY5D7tXd+s5QOtxkwMvasuYZqQdMBwp4JKaapZ85wZSr95SNjqivoX+oeMKZO
         rjRiRMZOIZy7al/Jh9ISgnNvaAJmrcjO7eK5YZ6Pd+5xdWvUd+/rs32thFrfqU2a4VNg
         h/jTCs1jRXwTNNxaO7tfI0AvqtwFsZPK3mZ0BpQvPPUVcoeEWGmx2lPK3jrLAy0B0697
         EIpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731930; x=1788336730; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQc/Ey0ssENHrHqEgMHYIV5akmCC8HHrE+7PeThi0ys=;
        b=U5l1aymp+WuwBOuCCbnmwrAOwZxhd6SSyuq2tePFoaFPQ2YP538mhmlpKMUDE8Xvco
         YunlRT/QfGFQOZvwLQ4/VnBJEYKn5IIvJRVL+VQdllELyA9B+kDWkM6JDDcKwqRiu+yV
         UptSuvdGXiWJyvOQ5Y8MF3lc2zGgdfWYqELMH+Y1t+8Jfh1ReAUH9OE//SKS15583KPX
         ZtioN/PiNMq+hFM5KfDAV+IIz9A90vnkW4DSyZKm3wZ0UiEEQjfbuziRI4v3t842uTl1
         kF5rBOQV2jGQL1QYuni3t11nHUT4KQawzM3/In/cFUmqVKLlOfBlc6XQ3Glonjm/pC1R
         0t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731930; x=1788336730;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yQc/Ey0ssENHrHqEgMHYIV5akmCC8HHrE+7PeThi0ys=;
        b=cPpeNfb5RRyOxuX25pmiFoA7VHxYTxfj3U18k1rtYRxe4wbGc/rwQpUZuUB8Hmlz/d
         cPw0l0U2qDR69v/69P56EPYQxDUaaeobcDNAY5CYsm5XfTCzibZKKMIFQ4dfrJAEoQuW
         8jhFcp2iI/EJqLnbzaJtGmOoMU8wDtCouH59PcIWJe01hPAcUOSjnG0cQwACJfu6rgC0
         N1SefpvcXQDWon2eb46akp5I6TwsYWB1dmBlESGPSyYdIt1uqi1jr83CYYSxZLicAlhj
         obDhztLDQ498fC8+voYqF7GFP3Om6akOCUhKYRqhKmE2ffzuBE7HALgLI132nanPTo2l
         VV6g==
X-Forwarded-Encrypted: i=1; AHgh+Rqdb33MSOiFGqJAQKzgB3TivUonvR5NEi48PWPcpTknee106C7xCJVsNP7RgK4X0eSIx76/50I=@vger.kernel.org
X-Gm-Message-State: AFuF++l7l6GIWKSC2NllOmREgE38G1oogMWSe4v4nFGnhjcI6CsLo479
	lxJ8IfsDSFgFRcXA3j/5/OJ77TS8LWj74Ql/fClYiYKGyiKMQ7MNyjRhuYt6jDGXRkU7qgMxBE/
	A9vwxvGAK5eh5ETjzxFVWEFI6Mz1QiBs=
X-Gm-Gg: AR+sD10sZdKXIyErrWSdW3xuIl4gD41UoGt6yr7dfpIpgKTVCTYpp1l1xpVuMlhlK5R
	Pdht/3TbhEehAgut6277G8bnmdbulOebFBodoDRVJcAQ7BVEsJaD9xmzpBaKdZPoKf+K+FV5yPY
	Y7qXGAsqX38Cg9KxX0/A0ixwXKFWa9NeFZB7RgeUNR5tpVh7iZS7AcUQaOeqhyVR+6stAEM8deb
	aCGuuwmE6xMj08YJ4Z5VuUiGTWYBbj+zuRouP+s5ks6PaywYtjQ8ieeVFrZrt9N/8H2c1dc4ni/
	zLMcWN7zgmU8lmNqIjX1resgj6jf809O8r2dbB96IkAu9wk=
X-Received: by 2002:a53:d009:0:b0:668:713d:893 with SMTP id
 956f58d0204a3-66d256571b2mr1358761d50.4.1787731930255; Wed, 26 Aug 2026
 01:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809073055.2980971-1-lgs201920130244@gmail.com> <5364b64a-f4d1-45af-ae67-f7cc1779cdf4@kernel.org>
In-Reply-To: <5364b64a-f4d1-45af-ae67-f7cc1779cdf4@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:11:58 +0800
X-Gm-Features: AcwNN1VpJeinnGKw4tuGLUqqDDN5XTtkgza0_JQMxp0Jlx59svEIm7ca6TXZWUo
Message-ID: <CANUHTR_RXWiM7enzFg=Q-jNywZXgcfBD8ATsiuegTAFHjC1y_w@mail.gmail.com>
Subject: Re: [PATCH] i2c: designware-pci: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Ben Dooks <ben-linux@fluff.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 09/08/2026 09:30, Guangshuo Li wrote:
> > i2c_dw_pci_probe() calls pm_runtime_use_autosuspend(), but
> > i2c_dw_pci_remove() does not call the matching
> > pm_runtime_dont_use_autosuspend() during teardown.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call to the driver
> > remove path.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 18dbdda89f5c ("i2c-designware: Add runtime power management support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo

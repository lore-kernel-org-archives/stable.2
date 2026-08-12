Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A671A9F87
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786561727; cv=pass; b=QBSUvawDnmqrHauG5imVO98DgjHJTWObg9IxRU5VIX7HzOSdJELe6GOxHUhxMbMrH9cozIQ4cZ8Q9aayAQF81FicxdsJc8jjG/V/S7gBdiIPK+DoyNpJgB1ahV87AnafD9oNkYenmrWVb7MSZbbX4q2p9JY8mOpX5Me9hDyx6Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786561727; c=relaxed/simple;
	bh=BZr5083eACLRkZqQqZ6nDLbTDJ7Gni+cd7Cc4EhHE28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aq1Q/rH5OtZVFV7ers5zlslSTz2neVTfXnnga1PNm9WaYbFmSMfX9Cth2IfMsxqYPF1EaIEj9TljWgNpW7JQujQMWkEbnRdsB3PrQUigWZA5AoMlh03V32rEvZGojlu+OU31thAXXWtjDqV79eJTrqx+WoPg7DqOKBH4v8zwadc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MEBEidZS; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MEBEidZS"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81f64e8dfbcso19546687b3.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786561724; cv=none;
        d=google.com; s=arc-20260327;
        b=UGYJMFY2U7GUxgVvIq4z5wzJvrfRApHO16+SZ/102quY5FfZX/a7/nXLRwgwTeedrq
         IMF9ifA3efvQvGl0UaZdtzFQ5maVmObkZbYo0/xWv9dUxFZE3hVVS+JwWoHJQ9heLSL1
         IRUFBO9Tz4+SkkYIynmWAK9VLr3OlGGeZ6kJQgidN9+/oOa0GNXO+RFc2ewc2+BLShor
         RTLiwQam4YxICaY2k2KkqoZbHCLab6aKJ9n5rgMlBym49j97OgSef2xpvMnF2zmqtlf4
         W0kVinGQwtt+wj6LMeQnquzKd0jFMZ4/LLR0qirN/tQspec2xvCtTK1Ps0EroNTxaGoB
         FZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wd+mCtHn9KjMZIUzGeLhwPtkxmdwj6bs/gC47PZwi6g=;
        fh=tJz2nXyj1EpYaqdEnRCznIxmYurJUNvnZxZKUBGwQXA=;
        b=jl4zG4Ie0X+ukvzqmrL/RzwsU7YCstpTv1/cNP6bRH2l8rKoCZ3yCHoBe7jHcoVkjc
         6/qof071vzvBzkRZhR+nrDc2766kiiXKA0jB+qlMhhkGFOihT5I979AdvnEWJXWd/1eU
         hOTLbpLxeNHJBsnlz1d5bDIuM9PBvoTC2L/s68K6r3c3a/4MyiBL6XT84n/nQFxLbfDP
         +NUlwDG7FuqjCd8+oBMk/YQDM3Ne4H12dYcNJ26uHfsWZooAvH6WwxNSQ/Mp4kPe2KDg
         /diZ0wdV8W5lTFZHsLwD7ltLipOZ3yVf0XWHzWs9YtRTAyx1jTLR5kyClZSJXdm5Lhcu
         4/wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786561724; x=1787166524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wd+mCtHn9KjMZIUzGeLhwPtkxmdwj6bs/gC47PZwi6g=;
        b=MEBEidZSM/OoUIebJp9V1pEOzuRJYcHf5xa3Gd4Z9xCQgF2y0tvy6H+h0hsHFwAAU0
         8a81PL7fszkrePdVCc4iEXxnXaMtPEOqxP8dp4k2saMTutHnSk8QbLwLpBbRlbWiwkih
         qaLbYSqjMGUeT24zFIk5WwoLxyGNkiGnNzD9nKHVjk3pd/8l3nvcr5NQbHN/aqg0zTLE
         ygF8eyyYEnDqq6vgKz9VwLomOhFd4P7fSdpb/Z5RNTYhkRhg97VaY4QZMTYlj1Q/YMw3
         WFPJOlldg0w1xVTBEFGevRvIp0kmGFgxFAMdBsCtjgL3pQudQVB9ATfvRYPvblYF9rnS
         4APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786561724; x=1787166524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wd+mCtHn9KjMZIUzGeLhwPtkxmdwj6bs/gC47PZwi6g=;
        b=LO98cNcLUudhWabuacoG/NWM2ZO2zi6nu5cutKTwCR6tCnGigU5trD5W2y+u2vHIsm
         oL6SrhzQvu814IYuXiIQn/+zikf8PyJvsPSSAzGRojMxzDH+NMDsCBYrG2k7bjlVWn3K
         eqIjo86kQ1L8Q8fvD2Rf8X6vvwCcB9RXS0jn4ZaUUG7rqJzDJZlknIw8PAMTdEkk06Du
         ZIZmHwKE1W38RFGu8DWlzEAQizaWHeio5efRPfX+gVZ5rqBVvY3wNpa7SQ4rVyPR9LOB
         3nQ9LycRTkE+iKYStGlIZUZpJCGcDU9egAFAQUhRyhy8QvYicOsWqIDFGnSqMFbj1Yig
         Kidw==
X-Forwarded-Encrypted: i=1; AHgh+RrgToqJhsPyTxUlvlnh8tFmtu9VMrJKTpZkwgotH0V+KHSzUMJu3G1IJqP6ElY4UoPTMKDgXpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQoNffZcFRAN6WkId0FybX90+s/AYTNThX6AfqmSKzhP9B6kd
	oXCefWbhrQ4gSztWYdCTUBSQzs4Cte/fGQSrXHf3ealVuOMKAgWagCvGnL/G7axhfuQ2K4MCa6O
	1gDFB2dRHHXqvWf31zGqN0q3iVJRTLX91a4nm/j67rQ==
X-Gm-Gg: AR+sD13FWe72u+O2S8yM2hvtQ3BRvesUveDtpL8Ch0DaNG4HjtVMbXaX9cUHfXp53wD
	CtAXX8OASi+ASV58vsaCUtJ7ffHH8HOmzc0IuztUk9TO7wjgzpuRSBJ/GwyNysMHYugdcCr2ZAq
	wdUxMYdok9PMpyNX26LR4kjBlZ7e5Y8RW4RUkdUkGejSwNfD+HMkdBwd/YFoEnuPgsPyUSkAA8t
	opMw/iPbohSGtp6JZuKYNQqskPC5Ad0AvtSa6iN0pntwr4G8qSe10vvE5yCApZAz4aKQQrdqsR0
	RFKHtoYhsFpzkhaiwtdK8JIr9YZY8EzNLPR46dfWrfg6
X-Received: by 2002:a05:690c:c61a:b0:81e:9f17:8050 with SMTP id
 00721157ae682-83474abf784mr584327b3.21.1786561724352; Wed, 12 Aug 2026
 12:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807222721.2795123-1-jrangi@purestorage.com>
 <20260807225241.GAanZhufwGMzonqHUZ@fat_crate.local> <20260810133933.GA57095@yaz-khff2.amd.com>
In-Reply-To: <20260810133933.GA57095@yaz-khff2.amd.com>
From: "Jasjeet Rangi (he/him)" <jrangi@purestorage.com>
Date: Wed, 12 Aug 2026 12:08:32 -0700
X-Gm-Features: AUfX_myEFkjNtKsPaNjZOTnjssABeRyD0Kf3Ou0VwqIcPQ0KUIZ7qcPC8IJacUI
Message-ID: <CAOTx7d7r6OYFuKLfK6XCL0=N=37P76G1e7Rj3g7er3dVhh22XQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mce/amd: Fix inverted interrupt enablement during
 storm handling
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org, tony.luck@intel.com, tglx@kernel.org, 
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-edac@vger.kernel.org, stable@vger.kernel.org, 
	Smita.KoralahalliChannabasappa@amd.com, avadhut.naik@amd.com, 
	msaggi@purestorage.com, rjethwani@purestorage.com, rhan@purestorage.com, 
	"Dhaval Giani (he/they)" <dgiani@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 6:39=E2=80=AFAM Yazen Ghannam <yazen.ghannam@amd.co=
m> wrote:
>
> On Fri, Aug 07, 2026 at 03:52:41PM -0700, Borislav Petkov wrote:
> > On Fri, Aug 07, 2026 at 04:26:59PM -0600, Jasjeet Rangi wrote:
> > > mce_amd_handle_storm() currently does the opposite of what storm
> > > handling needs: it enables threshold interrupts when a storm is detec=
ted
> > > and disables them when the storm subsides.
> >
> > the subside path:
> >
> > printk_deferred(KERN_NOTICE "CPU%d BANK%d CMCI storm subsided\n", smp_p=
rocessor_id(), mce->bank);
> > mce_handle_storm(mce->bank, false);
> > |->mce_amd_handle_storm(bank, on)
> > |-> threshold_restart_bank(bank, on);
> > |-> tr.b->interrupt_enable =3D false;
> >
> > while that commit Fixes: 5c4663ed1eac ("x86/mce: Handle AMD threshold
> > interrupt storms") says:
> >
> >     Rather, disable the interrupt on the corresponding CPU and bank.
> >     Re-enable back the interrupts if enough consecutive polls of the ba=
nk show no
> >     corrected errors (30, as programmed by Intel).
> >
> > Yap, I see it.
> >
> > I'm not sure about your approach to change the bool meaning - "on" is f=
ine at
> > a first glance and this fix should be minimal so that it is more easily
> > backportable to stable - but yap, looks like we're doing it wrong.
> >
>
> I agree the fix should be minimal, but I like having more explicit
> variable names for clarity. Maybe split this patch in two? First is the
> minimal fix to backport, and second is the variable renaming.
>
> In any case, this looks good to me.
>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>
> Thanks,
> Yazen

I agree with Yazen that having the variable names is more clear. I will
split it into 2 patches in the next iteration. If we later decide we don't
want the variable rename then we can drop that patch.

Thanks,
Jasjeet

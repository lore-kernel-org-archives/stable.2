Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE6483835
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936933; cv=none; b=llEchZqD7jnyW6glpHc9XBNBVz5vtMSD0ntcT1M17q9u0dUHD8r5KPQe30+c3CVIPomHfzzEB9UBlBO8c5iRWHM1miacJc9iGs1+WaU62ZPAMNqiFzbAsqPcJAnkwAUlwiNMJeDRoLFd/S9e0XQfWpy3A2jzFHseNythpnC0Ylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936933; c=relaxed/simple;
	bh=5gdN6MbyupG4up2v3CNyc/2HhdKCpR12n0Nqn1/8SxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUDs8VRJKZckxcRVAkkTGzUZkaABUWrAblDud0yO9ExQnCLAPspojugb4e+Ew3pH9tOY1ExHg3CtcR0mvAPkWBTBHkLiRTLlF1hFq07NA0HNNaidqDgboh8/w6OA5QSZkJl+84qc9dVlDa+iJxQeOKhjivuEn/QstCrJYBpaExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iycXByNc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iycXByNc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so11612545ad.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 16:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784936924; x=1785541724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=isHJkq5dJt9QVOk/Tc0QQ/ea7BPXsGmxmAavDSM2GtA=;
        b=iycXByNcCkV+Lca+jVCFyK2Rxx9DID1p4PNmB35s0uSRQswHqN6XbbKeN0hETemWf0
         wSFQ6NFYiande5nAMPgz8W1bf75o+NmWKSWhGxFNVo4lUqI53qzZWpXC49ERee+/IJis
         8LMdg0c0ZgTdLBn6xt/mG4MOZXqXpwSIeDje73Hybvpa+KG63IOWwrpUYHVdiGRTpAes
         ag/KoCW0DGdzsg/CDE5GSmgl0a35wvAlN8JLRCgsasiMHlmQyBPlxS1xPX1dwPtOlvCY
         1BsU2TGhjEY7tJZVvVC/I1SlGRUnkkG68o3vX/aTFoDRxTSh7GQBty9k9Lsy+dBa4V4V
         9s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784936924; x=1785541724;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=isHJkq5dJt9QVOk/Tc0QQ/ea7BPXsGmxmAavDSM2GtA=;
        b=FsU4iKYlj7+C4YkzT//WxRq/fM2ZTqrrcT5jg7ATLaRwD3apy635C0rqYxEAKawNgP
         Iuec0pCv/AMFeS4lDFj1Sehs4DqQdJJvuB2ARvC5M62ILcMsRwJ9yIa4cylJ9nJO6Wo5
         I6EXh7lFU9z6yAfgFuI7F41w1TtMnNtl4EUGCE78FozQR9vWCdcJcn9qMSJLxTvSH4Al
         FnmEj+ly9Q+JEL+Dbk9CfIA2vl5FrYqAuCLe33tqYu/4qcZLd1Fq4yneOY+T9RwtEKLj
         2ENi8BWdG2YzfwafzvucFp2EpKHvogqHJDUXDdZfY0/Lt9rUO9MoxPvRbcl4Ml9oCOHq
         w5Sw==
X-Forwarded-Encrypted: i=1; AHgh+RpPRFlYFyduQYz1mlKeTULf9Cwr3vC1S/UnmmPUIIcadEl9Wy40t0Uf3lJDFOUO16hKLqISX5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xX0Ps+nGCod0lqqvvjcyg/kbe0qDVzw4i3q3xOJacizB5/Vy
	URgw6HT91gyDAnsWuws3qaoKdN9dmjWyqFg/gPsgxQto8Yx3hqHPgcqi
X-Gm-Gg: AR+sD12vKM4u7U1X6eTOn+VhWzoVEITDutThUV1+pmGkoZSDa3RZLO7U9AcBHxEcgET
	IHzGnTo05sS84Elbv8k6TtXQERsSBcSRI/uIkeVMvoPZO5/R9y2f+/z7DHI3QF3aoTKrOMROq4V
	8Mp/aPMfUL0YqKlN61mFEJneroklCe92wOaFJOuLwKK0+58sKju8ABW1VnM6UzJ1zWVxnkIfg9w
	Y2sJ8ZwlNyBw750HQyxMx6d0E84RCpqC0mxvOqSYL4uqDEyGqIKK4lfHYwVmahvEhQUnwpCHjOP
	Rw4aqTiwfM5zi1mMCp/wxBHvEw/ZQbVXj77MSu6RrxDyF9/LXzsBKvjk9NwxiQiHVfqiV5ykhD8
	sc3ir6qkSq1GtPw0okdyT4Ho+1Et+8oCtJAM3BcApX6SgzUQGYb3yrMvha+ipNESoNHr3Pj4RPR
	AZiFoGsQJvd/RKE1XT6xI9zIklLQyiW6r72zXO7teMMnF5RR5+mXJyNA==
X-Received: by 2002:a17:903:46cc:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2cfde67beebmr4779085ad.2.1784936924553;
        Fri, 24 Jul 2026 16:48:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548f5dsm3900707eec.17.2026.07.24.16.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 16:48:43 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:48:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: James Ogletree <jogletre@opensource.cirrus.com>, 
	Fred Treven <fred.treven@cirrus.com>, Ben Bright <ben.bright@cirrus.com>, 
	patches@opensource.cirrus.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: cs40l50-vibra - validate custom data from user
 space
Message-ID: <amP5s-Dzp9_qWxAd@google.com>
References: <20260718074032.1864861-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718074032.1864861-1-sammiee5311@gmail.com>

On Sat, Jul 18, 2026 at 04:40:32PM +0900, HyeongJun An wrote:
> cs40l50_add() copies the custom data of an FF_PERIODIC/FF_CUSTOM effect
> straight from the ff_effect the user passed to EVIOCSFF, without
> requiring it to hold anything:
> 
>     work_data.custom_data = memdup_array_user(periodic->custom_data,
>                                               periodic->custom_len,
>                                               sizeof(s16));
>     work_data.custom_len = periodic->custom_len;
> 
> The driver then reads two words out of that buffer: custom_data[0] as the
> waveform bank in cs40l50_effect_bank_set(), and custom_data[1] as the
> index within the bank in cs40l50_effect_index_set().  Neither read is
> covered by a length check, and custom_len is fully user controlled:
> 
>   - custom_len == 0 makes memdup_array_user() call memdup_user() with a
>     length of zero, which returns ZERO_SIZE_PTR rather than an error, so
>     custom_data[0] dereferences it.
> 
>   - custom_len == 1 allocates two bytes.  A bank of ROM or RAM keeps
>     effect->type out of the OWT case, and custom_data[1] is then read one
>     word past the allocation.
> 
> The bank value itself is also mishandled.  It is masked with
> CS40L50_CUSTOM_DATA_MASK (0xffff) but stored in an s16, so a
> custom_data[0] of 0x8000 or above wraps to a negative value that passes
> the "bank_type >= CS40L50_WVFRM_BANK_NUM" test.
> cs40l50_effect_index_set() indexes vib->dsp.banks[] with it before the
> switch statement's default case gets a chance to reject it:
> 
>     base_index = vib->dsp.banks[effect->type].base_index;
>     max_index = vib->dsp.banks[effect->type].max_index;
> 
> Require the two words the driver reads to be present, and hold the masked
> bank in a u32 so the existing upper-bound test covers the whole range.
> The da7280 haptic driver already range checks custom_len this way.
> 
> Fixes: c38fe1bb5d21 ("Input: cs40l50 - Add support for the CS40L50 haptic driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Applied, thank you.

-- 
Dmitry

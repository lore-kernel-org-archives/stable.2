Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265BE3264E2
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194995; cv=none; b=afJkjk71v92HohETeI9nEBsHEogfSvnZ1KG5MXMR2niwENNXnejOgiLnpuCORn1FQ+Ev299fm658Wo5M2qZ7UuRunTxQBKlv8kcXPZHxYsismdl1ynsElu77xaTmlg2IpgtDOTF6y5fAaGxjT5DuZfxFYGe4XLh8RnWPlDbaWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194995; c=relaxed/simple;
	bh=8QanJYHVUT34kn3QE9sGltuZP8jObTRJVRAYEc7n4so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oy/fqESsGQwbDHH/qwjrr9N9pOKYYk2elm53FRWFxSTV8fPkt6bacQHAY5F+jTLWzK9GWH4MW32Ikt5+eTF6+qz+/EIHPlo0iElDHxiBd2DMSROHDkznlwv4ruSBI8vgpQSuUZRJ6hIUHOll7n5SiGDFwKFsC8xoQs8kIAhVTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFBvTPCr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFBvTPCr"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso976781f8f.2
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783194992; x=1783799792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81Ke9cmmCoYK/kTyeCdB3HD1YEG5nCK1a1GlO9Nm9w0=;
        b=aFBvTPCrWp2EXCo+TLnjJVBfB5HILsEIoK7VKP/pzpEUZAsIqYewpDPGy4Pz0esYSz
         BSrjWwNmqbOV0ClNB2ilqK6Yk3AFFB1YzonNi36StMs4d9IZzkUeLc0Z65i0z5j7LEFR
         tq+OGiKtxlyugVnptRQ7gdrH0MwI5FyTXFgPLHzazIcrr/0MH+VdKnuVQUc5TEX0XcO0
         IYehbnV6WAfnB3k3hi/2H0jV0tWSU19qbVDBxkPy5+4H7VV+DA689bjj23OQfTnW8h9s
         ZwRibA16bSBiKgDgAz9DPL6FsduM2JIw1gZehvDtqpQN6QZ8LFRG8DbKNiBNvcwzAywi
         6TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783194992; x=1783799792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81Ke9cmmCoYK/kTyeCdB3HD1YEG5nCK1a1GlO9Nm9w0=;
        b=sCIi5A0steoMj8Y2QnrhaU7Y2vQvvnBCPNT7tanh8JY7fPoh+gSLgi8yYc8kNc2iCb
         Z4vsjMkQEhmTkFbtE+qogpN2I+xFopzjIBrmS0Lp5JnqK4K3B/JSVdlW6ume26YNHsQ+
         GkrAKbbMJSeU7WmD6xJPuDXWl1gpFV9wqN7zOGgL+uHk6wju1VaXqvUUoEjMkUrz7Mdm
         dmODB7OYEP7CJ6gPJGjKEhjBDtO8PVpzLhbMigHbIjOevOL9Wp0MYCy6GRSSTmQWL2+v
         mXastWFAZjlrcwvxuEHlxGL/Quuz+IPfP6dbAXmqzBIUX0sDYrHSuz6WBkzyC6523Uj4
         lA7A==
X-Forwarded-Encrypted: i=1; AHgh+RpbG8ndaVtWbuOVMA96xQoVm9KFAhWXjKoTV0is1vvGbgiBlbMQ57e7ZkbcLT2TqhgROfBR64Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVW9qX2jt2eN9JWDtzuqWU5sI6mimi3TSgu5ZDvZRIIoBX5Bzu
	A0oDJBF29I2CYk4LRsZ86QX5L6ow7rH8Nl5ZY/8DWiQDnwOAnShEDNtRnVqI2A==
X-Gm-Gg: AfdE7cly8EfB2cgdWyM+RD0erZNM+DI/vIqMzkTkZwadDjvUf2AzL4fzazunDpgnfrJ
	lXZ/ydCRq9crW1LZsd2L3UkwM6PPdn+IW9gONLcuRZWHNiXzmnir/SKkgQc75EpdI1GhLtp7Vp9
	O6+dTP3wl+CR0s6p5Y6yy/M5FbUwb0s51QH0SCpqDZypIWqiL3aLe3qsj1aAIYcWdE9Ah+nsO+6
	ntm/59zG86CSnJkHCqrXs/SnbwOxVm401o41USlHO34+a2W86jcOVmb2H/oJocj4IvJmqtj4BnC
	PUUfEhZrTzbg+JvEmJi+56XIG1mA2PlLLUr86M27ZtsglhlxBLyr/NKvKDkriNFnzGK8ymFv6xK
	oWcGBgZAKoA/Ndur9VZn6fxga3z65Vqi4N8H3xgMUyPOXJ3d2EGsQXsX+LS9qnBP+4Hf729bCoK
	In6NKhsuygEbrQP90rnEIi0ElpXgLwrx/iw82DKV+d3/7BFI4MOYqlGHFzDnTQSodWYFMC38vbw
	FGJweHBEIY=
X-Received: by 2002:a5d:5189:0:b0:472:55a:ef96 with SMTP id ffacd0b85a97d-47aacbacb97mr3807785f8f.39.1783194992448;
        Sat, 04 Jul 2026 12:56:32 -0700 (PDT)
Received: from shift (p200300d5ff229f0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff22:9f00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm10342826f8f.33.2026.07.04.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 12:56:32 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift with esmtp (Exim 4.99.4)
	(envelope-from <chunkeey@gmail.com>)
	id 1wg6TX-00000000K1L-0Vrs;
	Sat, 04 Jul 2026 21:56:31 +0200
Message-ID: <741085b4-3892-487d-a39e-75c62a7b6d0f@gmail.com>
Date: Sat, 4 Jul 2026 21:56:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: carl9170: reject mismatched command response
 lengths
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
References: <20260628092814.40583-1-alhouseenyousef@gmail.com>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20260628092814.40583-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 6/28/26 11:28 AM, Yousef Alhouseen wrote:
> The firmware response length is controlled by the USB device. Although
> carl9170_cmd_callback() detects when it differs from the output buffer
> length, the function falls through and copies the entire response into
> that buffer. Callers commonly provide stack objects, so a malformed
> response can overwrite the kernel stack.
> 
> Return after scheduling device recovery. This also preserves the stated
> behavior of leaving the command incomplete so that its waiter times out
> and clears the pending output buffer.
> 
> Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
> Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>


This was posted earlier too:
https://lore.kernel.org/linux-wireless/20260421134929.325662-1-tristmd@gmail.com/

In fact, there was even a mail before that that was sent to security@vger.kernel.org.
I told Tristan that I would much rather not return and instead fix the memcpy.
carl9170_restart can completely unbind the device, so it's unlikely that one would
see a timeout.

Cheers,
Christian


> ---
>   drivers/net/wireless/ath/carl9170/rx.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> index 6833430130f4..ea3f435fb64c 100644
> --- a/drivers/net/wireless/ath/carl9170/rx.c
> +++ b/drivers/net/wireless/ath/carl9170/rx.c
> @@ -145,6 +145,7 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
>   		 * and we get a stack trace from there.
>   		 */
>   		carl9170_restart(ar, CARL9170_RR_INVALID_RSP);
> +		return;
>   	}
>   
>   	spin_lock(&ar->cmd_lock);


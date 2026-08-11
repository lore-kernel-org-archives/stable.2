Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F971443ABA
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786451195; cv=none; b=MpKXjZfmCJUUPVCz4KVnbWj1uuwTfY8CXk9fd3Ys/URa5a0RdP3eHtnkWdSPgVibw5slqVOjsas9xQ23gLCSCwD1MKx666XwQJumpuL9bTFFE9bPPHLhWuh/VmH+ifgH+r2x1FqMShgv577zmz3t7dgvjjLWBaQubu1U2pKzHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786451195; c=relaxed/simple;
	bh=FhK+PPdEUEsR/M3kiMix3JnW50mQEytqxeqxwx9Vaw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTFt2pbF7x3dVAD9mjQ18pbKEjh7Ybb+P3sRgsIGUQ4zCV3rhHa5eVm74Hiz2WaDb6Sz0t+i+24/x88/Ow9yTlC8dQxUauvOHbUUDLhWYB3B2smdBHoJQo3jwn6jJk+Nr/+o6m/tZdrFV+nYop9TA49BuKuLoKfG+rXgPyI3bQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC4a7bCl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC4a7bCl"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f7027ca11so1958175f8f.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786451190; x=1787055990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcp9Xyy2hoh4eNF+HTy2sWu8AKCbGo8+F9Skb8g8ERE=;
        b=iC4a7bClGMC2GUIkDGUFZ3wpOEIi8GG6xPKUTJMWZ7X85Q5lmm4P7sIJTmQQWMi0Dt
         aEZTr6mTPTCK4BRfoPnQmCTYP54l/UCbWJ+2G6ZM6Y4OekPqMFS5UCItBoFBwlJaKvMc
         bEAlRWBzrvBvx8Z5eQTBDZu3d6yHUjFRrSCG9I8XlcOmZxgbfRLJ/PdhiwSkKwQa6it8
         06XTvqX7EEjIecerctF0k4twWAZP4S8YDQ5wCW/WiSVz9yNO1A/0gmjSbX6xstcrNDI2
         7fFhJhMQUncu9wAh2IuaRZFBuTzJQ4vVp3C4hJUkmxSbtqSWRTDkt/k56ChwaLnX6vJE
         MFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786451190; x=1787055990;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dcp9Xyy2hoh4eNF+HTy2sWu8AKCbGo8+F9Skb8g8ERE=;
        b=WEoPiQOEmcgGx+SBn2zxJmGpwkMp8LA7JPRcqo82t6ZT/NyH6pXdNxFdM/LcSiHcbA
         l6l206crBwltKTkgj/MtWqeSKTnJfS9AIQHPBRuX+lX5I9GA735Mdra3LLiCeBp944gM
         Vjdu8pKLxdhMavRkn1xrM8xPknollKFVec/mIuFhgfweLEAsLfNL/aW44j7rW4piDqrK
         QDt3v30uEdydffnUT5L6il2ESv1goArfr3MxFLne12ghRk8c/n57GV5AzdVvMPd/Cc5Z
         dcJnHzDWelHx3aEHZBtux7RsM3Qm+hSmqnjgYOpfNy3ChKoT/hu4+MCHydstHKo/9Ulr
         Zaww==
X-Forwarded-Encrypted: i=1; AHgh+RqFhMoAUyWenj5R8F2JNkZq5yecokJ1RWqyxlbKPDItdTuZXjqIihT/1SvRbS1u00ghvzahgec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVoP4DHwq3OZUnDUn2RnQF3JoBBz0DbWtUqWgHwglF3myqU4X
	Y/0VIDVBeyVNS3oYgWgFl0bAkJjdkpfMzavu8CaXcxtbcJqOfpi5qemp
X-Gm-Gg: AR+sD11LywBH8f4K4mD1yLruk+Uno7R818rigj0o/Lm7LGm4YSC2K846PPWfA0PZiUY
	U5EMCWHCvhROPdcWz36ioQHON4NqZSKv2FVv7OIjupPq4UNCZoPVHI9t4mEyWdAy06cUsO5nTWL
	aUjVkuh0LnVICs51ha8z91fi3nQtDLuzUxguyjmud241YsGhH5trofU7J74LU4ECLYE/TmyuKoI
	5hupl9AQAYlE3QHEauP0XQfV2AOuVVa94b6Kyes8EUk1nZUOFzo3hzUjA3eWok1I9x6yrJkLDcb
	Y47q39ne1gHqCG++JbVuTR6ZFLn6Fq54kIU1dI+YzZ5cjIzWYuRs8lkK1LY806OP94xLMb/pZ5n
	YW9zUxI6Kxmc93L4JU04Qk8rWaQJxO1ee5DaQJtyW8AbyfVc8RxWSbEtCG4HmP0OEXiv6KyHj51
	3BR+1SrHclABqIMdHXmIWw2ZrDs371hX+BrLuRvEXLKsSCddEvxtx9dHr+ZUU4LNNZ4qqxNkELM
	W2b
X-Received: by 2002:a05:6000:22c9:b0:481:4810:d701 with SMTP id ffacd0b85a97d-4814adbb1d1mr4452767f8f.19.1786451190140;
        Tue, 11 Aug 2026 05:26:30 -0700 (PDT)
Received: from [192.168.10.195] ([188.216.175.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a7096c5sm4247773f8f.24.2026.08.11.05.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 05:26:29 -0700 (PDT)
Message-ID: <8a0fad2d-788a-403f-a880-2f97c6708275@gmail.com>
Date: Tue, 11 Aug 2026 14:26:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 George Zhang <george.zhang@amd.com>
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh>
 <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
 <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com>
 <2026081151-reabsorb-calamari-7442@gregkh>
Content-Language: en-US, it-IT
From: Sergio Callegari <sergio.callegari@gmail.com>
In-Reply-To: <2026081151-reabsorb-calamari-7442@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2026 10:08, Greg KH wrote:
> We aim to be "bug compatible" with Linus's branch, otherwise the
> "pressure" to fix those bugs goes down.  But I defer to the maintainers
> of the code involved if it is being worked on, and they want it
> reverted, great, we can do that.  Otherwise we prefer to leave it as-is.

I understand. Sorry for asking about things that might be obvious to 
most people here. My expectation was that only a selected subset of the 
patches on the Linus' tree were to enter in stable, so do we really need 
to have stable "bug compatible" wrt this bug? The original behavior was 
not free of issues, but they were rather minor (a reporting issue). Now 
we have this very bad behavior where the display remains dark.

To make the matter worse, on systems that have encrypted root the screen 
remains dark also on that password prompt (observed with plymouth).

In any case, I managed testing 7.2.0RC7 and it is fine again.

Looks like the Linus' tree has more changes wrt backlight, and the 
interesting ones are probably those in the cumulative fix 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=973fd9493ec21f12e760fbbedeb7b0b2317c02f4.

Best,

Sergio



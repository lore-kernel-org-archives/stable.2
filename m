Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986456;
	b=Q7yZsJD1/LvtagJleRSVKirrnm8m1elFeZ4r/Oeyb/Gsjl1HDKB1Y6mvxGwmWeWdUT7M
	 lg1qwNbo2TOvxp39L3Zndfb+zuCm00wRhohyL7qbGEzfwY+UMsB0wsQKh1SHyKqVlRqwl
	 wsnIYxxruAyHE1h6/4M0Sd17kx6ZhA7jv58/5nvZVXC8jxubKqJgs98Viq0Xsa8X5IUQ0
	 A3F7/CaP8wbO23IZGoXB4+vtbFq25H/PGD5QuKLfZXNrfN2ScG2jPiyr61qlW1966KwZ8
	 YIUCaFtFGXaVqlqHhfFXIaU6g/hzBZqDE2eVRvxJCaJMeP9Qs0o/Gs1aio8PtHfpMLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6rsNhxKU4Uq6TJj9umYTq5+bXlunuJ5/jQ9luyM1bCE=;
	b=l98Ww57BtVPxXgrCoiAEVlY/Vhbt5CUdxHhmWTYOr0i0pqoCGypVTZZ/CLc466syqyp3
	 DLZrA/WURw82ewEsCxIZH2xSrNAa1D811BM4FQgJkG135TZagJSsRrehlKipiDGW7QzQh
	 lxBLstycwO2yVgMQaXcEy/tuLaPdDs1ZVDu+/4jZb6/7AGfBwbdwAsfxW3erxoQ5hRPNT
	 WzFSRtf0ocG7WUSBAoOfCtH+XpBAJ1SqByEM8hrHikmB4MVxlmvNituwjC6YbKPpdez/A
	 ZvyRQoFU3Q5GwAAA77MDHXzLnh/wfk6nL6g2jXTrAH+vTHyE2ba2ABWXe5il6fLF0pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=H1n8peoM;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CBB606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1CBB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=H1n8peoM
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4f699fe49b3so594537b6e.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793986453; x=1794591253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6rsNhxKU4Uq6TJj9umYTq5+bXlunuJ5/jQ9luyM1bCE=;
        b=H1n8peoMAqKlFFts4q7qsZyavtsxv6Xj/IKYK7QUEhpvVhDCbI3FHLnzVZ6AqNSqnY
         OQJxro7CJci/kmR/w8Ramc8i4NjtoqfL7Rts4ErC9dR97OpiUSHtXW+MqxkSctC1qa8c
         nyr7Gt68/h4GDFItq3Jzz7mW44evez2L0oINWZfvijjhPGS4NtQY6RTNTIaYublj0O/u
         5lfAbwywwIY8up3KQy1H48g3+LnMjpdhHQRemisPVk9aw2SMIHR+69TjjQ7IR8+DwDGG
         992dderweWZWd9pNy/7Sw2Pdfh3Ts/mN1pQjTwSqQ+lkE+/Pei9J0lSxNCV7WdeGCYX9
         vd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986453; x=1794591253;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6rsNhxKU4Uq6TJj9umYTq5+bXlunuJ5/jQ9luyM1bCE=;
        b=Py066DzQLbmEO0/SO8egYlYTVeDLsPe8IEeU8gf/zbY/kZObOSqG+vzSPvol4ccXZ1
         atkBeTCXUCwrdtLZ18pEJuXNAQvYznRNOqnRJmibXz6B/p0bveLbN38+Gi30K21WOD2R
         xHl2PtAPUjRjgm97cKZBd2uUQkLevwbRg4RSGdgDNWqYDDNVZEEsYtSd3tsSDRSZdSWq
         SxBH7QjSS1fs8PNmWKz0TG50OnBltGRVNjzQIvVjtAu9T6J9SUxCtfGImTt7xQIbjYit
         gXhtEpLEV6aeUA1KecX1VMS59h38/gPexySwMybj9FjpJT/i5PB4ULn/Rqxn8W3S4pZb
         wyHg==
X-Forwarded-Encrypted: i=1; AKwUvByvqtFFhVgNNBzdtBWCDRROp2vx0AvdhWaj0rskvlfCCF1VlhvmHuw8UXw26drjUjA7BX49vXo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PKC0juq+5NV3676XuYdionWE3XbwJnqgZfTw7lzKui8ErcIVU
	vRUcDdQhKQ5mFB8By0lfWFKyWQmFrIqpOqnB50YbUSC1Osxi/Uz7jvQowCoTH64Se+U=
X-Gm-Gg: AYBFou1l72QDX21g7qQeICiRPaCX5bgoQhvaVIqJ5UO9kxYFzKffMdKxUFcWcAf3En2
	VhHDi9YLyO6M/sblJRLmvqu1gtpdTaFDS9iGcUPfQ1fvJeWLIFB/HqIk3cGoY5vfp3bFLgCnlKa
	wSTsO+w2EQiDuemS6sdJ0vlC3GJOcjT0T/VzqIDEXEyNpu1kGrgyvZNFy+Xx/5TEfiPJ2DP5mvZ
	5SCt2YcC2NHHJMfZrdrRDK2/LH5oA7JTSIN520VtQ5O/F5k8rJ38IvR2SGjFz7BBw+t7ocQwU+U
	Pw/aGPXGRs/klocfNC10LRTi9kFfEyQLg6nrYOALbsPVQd4z7NaxV1jG9wTwqaljhpkrYIWeENO
	bsFELUH3Qi+UuyFCPgGb5t6LFYFpeAg+r7Z13rkGvzQqJ7ynAFYk/M98B/upsbvN3hX3oBvxW0y
	62wkEoJjk2CMHxA20LW+PjIijFB71ZuGmzwossoYhwwIhLkiw0qP6HSWDP5kfOh6MtIvdWj/Fxc
	BgP4bMNYYyrGWz5CN+qEHWzvAnPS4jgDbe20mJtfB5W8K3M2TMkMCAJkVu37s8QKKYNbPRcbRcW
	Oq4ouYiL2see1Q8itIfqM0k41B6d3UGoqgF/evDZGDwUsOPeiY0N2W5MTXSQcglt2LlP+RJKimf
	Psr9A7/r/
X-Received: by 2002:a05:6808:15a7:b0:53a:e153:e901 with SMTP id 5614622812f47-567e0f42f28mr2650995b6e.2.1793986453280;
        Fri, 06 Nov 2026 09:34:13 -0800 (PST)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7e5f6e2sm1932773b6e.11.2026.11.06.09.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 09:34:12 -0800 (PST)
Message-ID: <a41c9599-f668-4920-93fb-c4dff42b2856@kernel.dk>
Date: Fri, 6 Nov 2026 10:34:11 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/kbuf: fix cross-mm interpretation of provided
 buffers
To: henry martin <bsdhenrymartin@gmail.com>
Cc: io-uring@vger.kernel.org, stable@vger.kernel.org
References: <20261105061433.1947491-1-bsdhenrymartin@gmail.com>
 <3f0cf989-c294-44ac-8bf9-11bf69dfee45@kernel.dk>
 <CAEnQdOqaGiexk6BcvU+L1xoEFDr1e6sWzm1VuH-JBJJKXhc__Q@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAEnQdOqaGiexk6BcvU+L1xoEFDr1e6sWzm1VuH-JBJJKXhc__Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 10:31 AM, henry martin wrote:
> On 11/5/26, Jens Axboe wrote:
>> This isn't a bug. A ring is shared memory, and anyone with access to it
>> can write SQEs that the other side submits, with whatever addresses they
>> want. Provided buffers are no different from the addr field in any SQE,
>> and the same holds for ring provided buffers which this patch doesn't
>> even touch. Sharing a ring with another address space means fully
>> trusting it, that's inherent to the design.
> 
> Agreed ? the SQE address fields already grant that capability, and
> ring provided buffers have the same property, so this adds nothing
> beyond what sharing a ring already means.

Forget SQEs or whatever, what stops you from inputting a virtual address
from another process into a read(2) system call you're doing? This has
nothing to do with io_uring AT ALL, and everything to do with people
using LLMs to try and find things and not even considering what those
"findings" are before sending them out and wasting other peoples time...

-- 
Jens Axboe

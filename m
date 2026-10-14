Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5949C271450
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791940461; cv=none; b=YjVqj8X1+xXbyyjHZ4NucxLPn31R+5DWlmMbT/HQHLrtoISmbAU/cNaeLn/Vh21cOws5+5ZDf9RZvOVtx+s3h2PI/pNewSir2j/84BuTjTyG7N8Jy9VmOiRQkvQ7bXr+ochtf1ZIoh1H+VwN9ez3GBCC1WPvQQgv+eYUj1qEpLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791940461; c=relaxed/simple;
	bh=73ZSkgvDAc/tEb38F0TL0h/qQE1nmehsX+W+85TKIlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VW4DdOO3/UCAXHEReZtSHvMs44+f92debkQT83C7kFoBCh81wYqfv67tz2/HDlOvewRrd2PZRfcWWTkI8hXxrODFN3xFdSYnm9sRWr604pEUyG3E5DqL/nyq+EkGilmZf6JFWp290qoA3ao4CoM4f7eWEyiERbPGrNRCZ0fWSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CO6NDMK4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO6NDMK4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so28288745e9.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791940458; x=1792545258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+IRGY42o0foxKofOSIE21b7k7cypUKnC6DpjmgjMdLE=;
        b=CO6NDMK43wiKPojMSSW1HF3u0mstSOPLyi8tY2H6Nlsljlo52qgIGTdCQYd2TL7+b9
         0nakKlqYTz44tcHOFJpxhjHfMVl+4m3Jl/UYlZoBjPZtDeulxXD+VE5ySnVdsfl56Ofp
         XhJK0xsaB5+DAFWrKMAMs/7OlBTinUNtsf2WZONpIWqvpMUP7q0PzAcidAEIKgbEnqVS
         EfIn2Y64MePjoMFqN41bru7prUO2rfNHlCmoW4STOySXfFl5McK/pJO06QSCUM1T9aC6
         7+wfEPHVoCS77Tvrt62ToQMUweDdvEDpkDcvMZvBpWJUn9JPERbPkiT0IjiFPbDCZ46P
         DEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791940458; x=1792545258;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+IRGY42o0foxKofOSIE21b7k7cypUKnC6DpjmgjMdLE=;
        b=jEFqCwo3J52xYLVFAGWmenrSChjcTC2YncFzLInJz1B21Xrv4Epa7npivr57Qob6eY
         Xy+S2xVnFGbYBUWNW1fmrv56KlwVVo8IPbJe6IS2UeViN97fDlUkJJfYZEuS4t53wHvQ
         bMg97k8dI922XnikVlZciJPDEfcqeO35cEW7VIOSNrMs3Qf4ChNqD/iKAEvcTPOnsdmB
         rTz5axmzvTHx2IlJ6fApiWSrlyIY0ACn+KwasdLjI8J0dr4hRJKX+Ru3s4jiHcqswUO+
         XSr4Z1lFSFt9WAWGk2i4996JHetpx2QnAY5B0f9H5TDaeFRnrrxja+TXc2DLtt0QjB7s
         9whg==
X-Forwarded-Encrypted: i=1; AKwUvByYGkGxPevhVK+DTxuYBZBuV6mUKCw7SozbDTyCM4c0hyOplkIDvhrpE+100vosTx46dQ6bOzk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJ+kW6gJpYF/iEJOvebX3bKTkg8CXbQ+XE3eVPV8DSYClN55HQ
	epj6mY8pJXntAyF4fNvq+J5jaYRBQbly3ETNe0/XG03ZS2/EP2wqYlsw
X-Gm-Gg: AYBFou1QM9zOkPx5p/n1cyYmfsUuf7RrXY7Th8pm2VmteMJmd6rSLOjg18tUuSk6AJZ
	Xkpv4EHRaDNZs01RxPjArabaEzNAEXPC1atNvYEupN8wbCAlT1wdE6vb6BcWcCQZqtiTq1YFbUR
	/COT00K4fEETFPProcQ3b12VtNVyGRPu3Y8rBLdtQvyTtDUvzLf6ZZkcZvcMrw9Ypbyr0sSQTk8
	BrWDzFw5E4zlZNH2VZzHuLhmTUdEoPup7JSzMT5LTzAa2PwS6CBdJDbVnIH7gZ3xtbF1G+4vxLT
	gGUrUlvYAt+FqNUplxmvsHZtZZCWfWm8a+GDsH22qpuWt0Z5P/bAeEx4VmQdceabO9PChYZOF0J
	v87MUZ1fwRKLzFmacCtXsP7RndXULZowSf9Jp9uOBw7JxZfSTm56VoNxUeO6CmdQsbf8L34A7Kx
	VMspSMCKfn2J3A0urlRvsj2DHw51sBZ5sR1BwUh3Cp+xWUw1VGUNr0L8AuGL09Xrxskm+OHLGwf
	ipFdTLxTArdC7LGtc+9VV199gdFDzBC52vnwjPH68I3Ua+TPvYMSoNIxU9wq0tDDiSwSgdSqI8n
	/IV5zXUrIMd53KaBkMWyPEePy+ShHBhq0PacYkC1ftxX83ow
X-Received: by 2002:a05:600c:3111:b0:4a1:811c:8069 with SMTP id 5b1f17b1804b1-4a18e49d640mr279688285e9.8.1791940458506;
        Tue, 13 Oct 2026 18:14:18 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b748cbfdsm4389935e9.0.2026.10.13.18.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 18:14:17 -0700 (PDT)
Message-ID: <86ae9136-3413-45b2-99b0-fbe404ef1b39@gmail.com>
Date: Wed, 14 Oct 2026 02:14:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/cmd_net: prevent infinite retry loop on
 unextractable timestamp skb
To: Bui Viet Dung <dungvn2345@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Willem de Bruijn <willemb@google.com>, lollipopkit <a@lolli.tech>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20b406ac-94ec-4b0f-a307-08082092ae08@gmail.com>
 <6ac7afc4.cf15ae49.1a8a2a.2a55@mx.google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <6ac7afc4.cf15ae49.1a8a2a.2a55@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

n 10/8/26 15:59, Bui Viet Dung wrote:
> On Thu, Oct 8, 2026 at 3:43 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>> Sounds fine since there are only timestamp skbs in this list, do
>> you have a test case?
> 
> Hi Pavel,
> 
> Thanks for the review.
> 
> The issue was spotted during code inspection of the error handling path
> in io_uring_cmd_timestamp(): specifically when skb_get_tx_timestamp() returns
> a negative error (e.g. -ENOENT due to missing PHC bindings with
> SOF_TIMESTAMPING_BIND_PHC or unavailable timestamp data). Since the
> multishot apoll remains armed on EPOLLERR and the unhandled skb is spliced
> back onto the head of sk_error_queue, it immediately re-triggers the command
> in a tight busy-loop.
> 
> Below is a standalone test program demonstrating the TX_TIMESTAMP command
> setup and execution with CQE32:

Did you actually reproduce it? This program doesn't for me, nor does
fault injection. Taking a look at the code, io_uring_cmd_timestamp()
returns -EAGAIN, and the request will wait for the next wake up in the
polling code. There are bits to improve, but that's not an infinite loop.

-- 
Pavel Begunkov


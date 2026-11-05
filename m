Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885342;
	b=LVX9tcaraAIOfF2Nv1NDzShwzs/Lu8I0a/YW+guq+41J1i7laj+Jka7zA8GSal0EMdY8
	 ETyT+3BckeVs8CTDzAqM8Jw85ij68qZFPiEDkDx+fgupv6rLdJfR9ewxTXPIuaNzmLHiT
	 hJMG7U/Th48M/YxWpYzz9tS799Hnl7saY/byaFyQIzqwDPxlHjoumBz2c5yTxsVbws9yk
	 Mx6cjWwosCVOCYYBczgwSpn/h76BRWuaQ6hOuKH4sTrUtulVJvCTyhTrBhGnoHPx/cvsy
	 e/se9WvMW3Z5Vbg2Kc2nTFH2lyCKXYOiDeXeCB3y6EWfVXKXzN9vH8a3GcfSsGJ6BEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6mrHj4CuiNys75XCtOOzNTCjWS+enY6qZZdIQBYIpJg=;
	b=vpwIIGLNycYvrPvip7hOF2OYhojM4WO/CrzfK3qLAgpz8kifJiQfj2B5SYzzdAwec75Y
	 sJ+x5yr5Gs7Qe813CMrgT/rJmNms6s32KI6Hkq4JuLaVP3Nx3fMJXMs5z5G+Renl9d2OJ
	 TcQDnALjcw9HWzqVEWitLTA628Yx93apsGZsYq4oYZKiFrXDDA5/7j7RHO1zvr6ahGRse
	 +i0uNbuOGgSdWGIxBAEHi7LHcQJLJAKpdMJMXEdfBH8YOS2a2iNn9hBNPyWtI+ZLPnUqI
	 WNKaoJp4MgvA57gz2gilukhJ2D+cuKLv9kNWVHl/Y9SLHPGS5Y03b4E/wQjtDWSoYBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53378606A32D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53378606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e987a2ba0cso10207065ad.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 05:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793885339; x=1794490139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6mrHj4CuiNys75XCtOOzNTCjWS+enY6qZZdIQBYIpJg=;
        b=UWHqYAPTT1iJjMjkhmZN8OyXtDqZ94cllRjs9W4ou97ta+APi0O8TLMczJJRZFr7O5
         3KyQ/sDk1UzqcCg/MsDssdx7S1tThQ3RMeGpXk/4e+4Kc0eTh+HnRAid3sG0VNVciuLT
         ELUTKTMNkvmG5V9sSCTPe6qf2s55KZ7+hTNICv+hqju+upr9JQAK8Idfzg8Rlpf9jiWH
         BFn+gPXM83a63DyZmkjqU1pad7QBh/YBlP8+/+ASJqwkpH60EN9koVL/p3+vcKGrGHgT
         OWwKXdq/qesLNNWrR2hqF4d96dqvWUdfhmDvahMe+hyMCmi/xI0nt3AT1SZ3MzN7kV+6
         tLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793885339; x=1794490139;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mrHj4CuiNys75XCtOOzNTCjWS+enY6qZZdIQBYIpJg=;
        b=oTVcnLQ+xLgu9S3zF1TWUHY3bneIfwkSrOJjLLM0+LVHpvs0Rn9SV9m7cxuiiejxIx
         lc7Ka7m0VH+jDbH27mnQDG8ayUKShWMtF41BLTR7PFVnAkyBc+wPrgnHaCTyOMDQlhhb
         4n6eQGMPu+NM/i2tWG9kZlrqwYShPqPDqN+v60CNZFUcGQH7GNEwP61CcGUYyAq8AcEw
         T7i5ieIqnYV25Hf+YaU/ojwXYfZ4OyaGHNdqszZHsRxGGWo/YRyK7qjL1jD12u3I+tE8
         y7RT6Y2WXEKknip877wZH9cWvQWm9wxpftURJtQ/bG4ONwkH3I9z+t2RMEGfuW7segCB
         KJDA==
X-Forwarded-Encrypted: i=1; AKwUvBzSndJF5po2NFj9hzI4hiQVuneJH/yhiocw79PEKvU+21yucMNNkW93yJCXtIQaLwhuHFg0pEI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aUm4uefI1h6XPeSSus6/6d0FsWv/VU/qc7ltn9K2H4f8jmPpE
	wrDuR3lhdKL6+McjLTVWwr9TKLhFCOxt1phlXvjs+WfsNlLtigzXLEP7kNRzIn/Ed1kshsRx0Aa
	JJZckj4Y=
X-Gm-Gg: AYBFou2h6Md1AbdmYsgZve4GHa8HeeBEswe/W5M8NlSowwvpi35MZf9WASMcEd0i/Xe
	Urh1HMfDjbnLiQpS2wELTUXPH4aAAGKdcXkZ1omP8Nxxr4XhzwccX11EObM7c/ytXymIjoKqUzC
	5czcnKDXkcVKRgf3LVFrGJ5GaErOGX7kvFNQwrq7t5pOEC3tawx3UTzkT/jW+NCsEX7jKPbetSI
	b56qvSu++F73UBow8gwO+n8SKNysVyF6BHGQWTkQ1A8aBaXbfAdjnN74/7qqNAkYgssMUWIm2iJ
	XbIgYBOFzW+Gyl4IGdLTUOaOtMXujww14IrzjiFEU8oSOTiXKQIlyy4CtVHDSI18RiDBa61UsI7
	QiYSGau7v8bTYa8mO+zTB59Pn+3XR2dJP2WAvg/6vZdKC3FxIkMHPUl0+RW1wtRiR0OWZj6JULa
	2fDJG5JLrWVzKalWmeYZhPw0g4u/fd3lHJhkYeEZRvyRfUevwlH/XUS0Dy7T/llgdbkn/97Dr2b
	UEeqRHAMSSXI0PTpOAdcNYAcObAd7QMrCtuJMqn6GV0ppBhy1a1bv//rY5flpnwyK0m7iwVjXMa
	slFb/DfbpUpKAABjBOUcuNXN/ejveAm1gT67b6UchWG97Tc2kxP4mmdAs5Am3DIIaeVV4mDdAeO
	/6mynCLo8QWBP6hW3L23LbU0gaAzKBbbT
X-Received: by 2002:a17:903:2407:b0:2dd:ad74:ac28 with SMTP id d9443c01a7336-2eb364a1427mr183211245ad.26.1793885339235;
        Thu, 05 Nov 2026 05:28:59 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46998fe1sm2168508a12.27.2026.11.05.05.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 05:28:58 -0800 (PST)
Message-ID: <3f0cf989-c294-44ac-8bf9-11bf69dfee45@kernel.dk>
Date: Thu, 5 Nov 2026 06:28:57 -0700
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
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: io-uring@vger.kernel.org, stable@vger.kernel.org
References: <20261105061433.1947491-1-bsdhenrymartin@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261105061433.1947491-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 11:14 PM, Henry Martin wrote:
> Legacy provided buffers store a raw user virtual address.  It is
> recorded in io_add_buffers() and later returned verbatim by
> io_provided_buffer_select().  The consumer (recv, send, read)
> imports it as a user pointer, so it is resolved in the address
> space of whichever task issues the request.  Nothing ties a buffer
> to the address space it was provided from.
> 
> When a ring is shared between tasks with different address spaces,
> for example across fork(2) and execve(2), a consuming request reads
> from or writes to an address chosen by the provider, in the
> consumer's address space.
> 
> Record the providing task's mm in each buffer, and refuse selection
> when the consuming task runs under a different mm.  The buffer stays
> queued for its owner and the request fails with -ENOBUFS.  The mm
> reference is held while the buffer is queued.
> 
> This issue was discovered by Tencent CodeBuddy Security.

This is nonsense.

This isn't a bug. A ring is shared memory, and anyone with access to it
can write SQEs that the other side submits, with whatever addresses they
want. Provided buffers are no different from the addr field in any SQE,
and the same holds for ring provided buffers which this patch doesn't
even touch. Sharing a ring with another address space means fully
trusting it, that's inherent to the design.

-- 
Jens Axboe


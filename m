Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795110592;
	b=k4s+QUqmMc+5LDjeYGdWBnoB6SAzwlSUTcEUK0IbUx56iEPy/9x2Bz+cyJCciwk3qplw
	 52YsUIOYZ959NRVdZuiBb+BND8rwio2PLdHJi2+ntQedJlCscPIN3kBtMcfPNvOtTlfoO
	 pbFxNZIGtUjCl3K5P0fU7SU6NGSZgKwHnvJNP615noSPOyDg92m3r4hp51yxSWnXTcS4u
	 tv1W96mjOwAGYf0iN2BgEbTz2xQ1ixt58snaIu/Waf8xO2c+mxd+IIGP3LUAKXvuQjrAn
	 mIVhcCyguq75hAf2DwbGAdFh1uGw6SDqsna0KA4Ou8U8loccjwdJ1dkzCKqdeeRnw6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/O0/GX+7ajqO6zTAHBdQP6c0ZEI97XrYu3SAglUaXjY=;
	b=u7QTb/YsCgb74qUavvo0AOShidYscNl3eNvGYmryZ4yZodM0G8xRBaGt8gkJbYZ3Eq4S
	 XQkx3xektBL+E4brbcLqP93StkWiHmP5nEvsymm6bnh0fu7DiGfpXueNFYMRyRFxFHCc1
	 EBAXAojNgXorqVdBI/7nNRer6BkFaAy+hvUy9e9NJqQETAdf2MzVDYymJGoHZp8O7q16N
	 LpORjIXJqSUDESWa3lnZOmX4k/l5/EC4x1oGqC99Qoc3bGYNge11FLHP4tDc+JG2W2HiW
	 FOBsTCiBPf/5jN+yl0jFqIISoKVQbVkB+CaCtUn6+g8VpLdOIQmKFYRdGiJDXNhB0Ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=BDFzAuNp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BE7606A32C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 17:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BE7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=BDFzAuNp
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c51239b0e3bso5470966b.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:49:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795110590; cv=none;
        d=google.com; s=arc-20260327;
        b=Ez4cljGOhPIoRrTNiEHSWaDS72FA6z+Gnk1zZotnVd49NJpEvRwo3jzTbja0w/UwPg
         olJaNzCgL99bzqOF1jXXU13PWSsuseEu+Szr1LdUs8oBmeif2MZxRwpwcSY9qH+LmkKP
         yfM6kj4O/e7syfK3gX8cP6eacWeMChZiBvYWjj31DS6puqs7HMcjvacvEwjd3KDJatZA
         kOOH4tpQnJ8kjb6eSPc0eq39drCs6ORcYCRfJbR5ixP/mqkBgWA6IveeIOVcteq/oULT
         qyLfAI3wA50US1El1exNji4msoUbNN7f+YigIv4b/pjwcRJvbYb89FyqIZQitvmIq6kc
         RlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/O0/GX+7ajqO6zTAHBdQP6c0ZEI97XrYu3SAglUaXjY=;
        fh=S5L1jsy+2+3qKLKWrzb0fNiCGQHBHIdd0OXLT7Cs9ZU=;
        b=F4/5xOJK9rMM5DiPx9Sgg6dHPO0tmlyK1fB68xBnUmXXQyeXf5QsW1wHI1qd5mBNLs
         m90mdWs64K0YwstJ5UBi2jzKEmGVqVQPj3QYu3stFSQfPLdT2M6H2ecyQ23Tm6nB3G5b
         su0DLvo+NEP2/KD6muk4lYkBYMfxT5VonAzuQQdePCMq7Nn2vBDzmksAE6UsUbicuLVI
         H/2ESOst/fyBzwufc74+laux/xuWKQ/EiA/WSe4j51VQ4P91LGB5Q1kUoLT3JX0xt535
         FmFgXlLpvAbiHdaj+0NLxb4T6L12qoaS8IcBcMuUE2eroV+JHY85jF7rvZkkXon181wq
         o7tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795110590; x=1795715390; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/O0/GX+7ajqO6zTAHBdQP6c0ZEI97XrYu3SAglUaXjY=;
        b=BDFzAuNpRvvcKd/LuWfKHb0Up3yVJK+lUdRHw+QAkLWhRGbKgaDhPyUL+XgX1qkSB0
         KO7wVl3Injn8WCdGcF6KS5G6p4PzoZxufMdeSy+FshWVIeuVb0XURSX4XNfGitKoED9+
         2SHwoor2xnYoAyS+HVcqrAu49HdzMTILfgwi8W9Scl5Bm3P9ijv6S2No9HS4l+9xe5p7
         dTG3SJGgGaxbQDUFXAZjmta1OcEL7s9+bRWSoMeFMzRKF/8w5pa/F9Sq29fDmyWUqSqw
         CrB7DFdjOySfyTim15Ah3kei8YaR/HGLNrwLSWFaH8JEqaVA+juXKaEcD+MtgLP3YpOb
         iStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110590; x=1795715390;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/O0/GX+7ajqO6zTAHBdQP6c0ZEI97XrYu3SAglUaXjY=;
        b=e5kkYwDYUCuC2Va9sQkdFAagN6HskwDF3lkVDaWcZxiQ8BvifJIRtE2JdjY05z7EOI
         SErNUF6+/hYFirwwUWFmfb5JaTSlwjdFv2KSlzbjpqPTKTKjcm0icLpuXbImhR8isaol
         UPACDNL69jTKtWQtGq4xxiyk+ghXKMUu6UdADG8VOqkJf4iyMILCfUEqVkSeqsrmK4ge
         je9h1OlKCtXH2G6cEvDfvMi45P3TbSgQAu/TlC7iMltmoFvg+W5ju+zswCGwFTYTZcVZ
         VRKh89X0QOM/dTZVnSEIjJucl3tcl8JjCQ4VWlkY0fwU+DQz8PyhXwFZWl40C2++UVCB
         Y/qg==
X-Forwarded-Encrypted: i=1; AL+hErHLmq9PeB7lgNi207QC1q7r4N2PHSnL3jxH46jvUlatHrAzczy2+kEe2NJ1WZOdSRA4B1IbNn0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8S+HrIdj4g0RV8OPXG5+XABeARJEQYAEk5XqcV1tzjwPVnpBnS
	emHvgRU/qPYqrpjOG47bozAqOTgTEv9FOCrU1A4I+tNjQvZQFFD6f/3/bvWa3HgKw98YwolzAl0
	guQxsPWr6T8kPwVS4akEBgv5oSH35Lt7pcfQTl4/lug==
X-Gm-Gg: AYBFou2mhf7iQV+F35wmIwBFDxHWEoLDrCdmd9bi5Hp0C7JRhJJX9DQ6BrhrEBdnivJ
	vXjGJPULXJvDAAophqNGKh4aqMcs76BPyctvhM87vEVXWoA6qybKlMOT+uW0f3aFoXEjtKBrthX
	NrvRMos/qIpUfCSdMPjL7YyOQ+8y2K8pBkdN8gTFtlbO65UnkyJDwviWlG+Y9j64FAV1Cajkt3J
	sFKeEAfJ/GJJCF2kmJAP4sOJ0iFOy9GWYFtyLC1Xy7SQUZr5pyAX8ILpFJ3pSrlbvUhjIbDQJBq
	f+P/auNCv13Ns0BVbQ1orqBG5yysEc/2QDuPxXSbNUtaWlVKvYPoQK/eHKeqHEZZ/Ao5Zplf/17
	8C+k/Xx3nY9QqYd9zHR4ucQfoQgV/TdtgGg==
X-Received: by 2002:a17:906:3b94:b0:c26:1649:47ad with SMTP id
 a640c23a62f3a-c513ab209f4mr54087866b.35.1795110589931; Thu, 19 Nov 2026
 09:49:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <alvD5nOP15O5B8Ai@kernel.org> <20261117104838.2650999-1-rmustafin@cloudlinux.com>
 <avwzid1Ovl4ACkaQ@kernel.org> <avxJ9MxZ0PoWbQTc@kernel.org>
 <avxKqn-PlzJyxVdK@kernel.org> <CAG6=z5sxUo1x6mpotkNZXk=nQYvD2AyMLSDhzD3B3kqxJ1=iaw@mail.gmail.com>
 <av23L5HBpy2gbm3m@kernel.org>
In-Reply-To: <av23L5HBpy2gbm3m@kernel.org>
From: Rustam Mustafin <rmustafin@cloudlinux.com>
Date: Fri, 20 Nov 2026 00:49:37 +0700
X-Gm-Features: AclHuK9Q0IcDkucYCJnM_63DevcnoFoQpfJyHRtWSFgpZWzV5JY0H-0a_Kp8-CU
Message-ID: <CAG6=z5u+qK3JQ4OwqS8e9ncfcasYPWLQhU9Y4iBFi1pEf0QFuQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: track the response read position internally, not via
 the file offset
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Jaewon Yang <yong010301@gmail.com>, 
	Tadeusz Struk <tadeusz.struk@intel.com>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 18, 2026 at 9:33 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> I wrote that out of my memory. I did not expect to be exactly out.
>
> Block uring.

Hi Jarkko,

I looked at three ways to do it:

1. ->read_iter and ->write_iter that just return -EINVAL.

   Simple, but readv() and single-iovec writev() stop working.

2. ->read_iter and ->write_iter that keep readv()/writev() working
   and fail with:

       if (!is_sync_kiocb(iocb) ||
           (iocb->ki_flags & IOCB_NOWAIT) ||
           (current->flags & PF_IO_WORKER))
               return -EINVAL;

   The first check catches normal io_uring reads/writes and AIO. The
   other two are for IORING_OP_READ_MULTISHOT, which uses a sync kiocb.

3. A new per-request flag set by io_uring and checked by TPM.

   Needs io_uring/VFS changes and is harder to backport.

With 2 and 3, vfs_iter_read() callers such as Coda (which forwards
reads to a file passed in by its userspace daemon) can reach
tpm_common_read() with their own offset. Today these calls fail,
because the TPM files have no ->read_iter.

I have 2 implemented and tested. It would also need a check of *off
in tpm_common_read(), because of the above.

Which one do you prefer?

Br,
Rustam

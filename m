Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847806;
	b=ZKJj5WXjYttN6a3+ERjMORHC6aHRgYNf5OJikN7K4H8Rg8A2a4Bor4JQqJzdLItNFosS
	 oh4yr0XMOcVS82+3JYfNJsWSLSKM/1ouBQu3ukFKe7q4MNnCk6kO9GCQUHhSO9+O6QPg/
	 8idcE8k0pA6QgYDVsN6XOTaFf294jO3tldg4c351GLOw6ltP4PAgZTyeyotFlgNNaI+lC
	 3REI/nTgSaFcVg0aXTDAV/VM6bxoH476Wu16DvlGTYp3rCuu1zW3RJJz2mI3KbCH/2uyz
	 cnpczJVimlbN5iL6TnUxYTAD4139lWdxwYYJ4mFCVXUjih73QiQLt2gHZZNh9ib/RGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TmyrGImNoeERgzj0671/YFCWmU7Tn1bl23zRlCFzkls=;
	b=S/GJ2Ua0cHyZs0iIcAdA4cECekz+HROf0QRRmasH8s1wD3zvfQCrpI53Cmh/MpWpW7Jn
	 zKUZFHLXRBeUx4KiCipA9RH8voo2azJI9XZlRnPH8+57sT4+yxpK3HB4bpCyJG1B5oQZ3
	 CMjduwyUB7vDIcP5rWbKfrQVZfHfZm/51lpRsQnuVzoenUl902ucxkQpK1Ruf8KRr2PYF
	 RsZRKS0nCeVpsREm2/rSJh76UB+3tNVR2+LbtWh+5Fyk9jrHalBznvHxNxUpFFFtHGGvC
	 v+VJ7/fLkBJ4PodlVy1YowtDi6f6HedErJYj8ie4+l1pwwkq9iSQzOYq7wytiHG026A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.cmu.edu;
	spf=pass smtp.mailfrom=andrew.cmu.edu;
	dkim=pass header.d=cs.cmu.edu header.i=@cs.cmu.edu header.a=rsa-sha256 header.s=google-2021 header.b=HZ0rvCUd;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3D606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 03:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FA3D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.a=rsa-sha256 header.s=google-2021 header.b=HZ0rvCUd
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-917aca1aee5so17566346d6.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 19:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1793847799; x=1794452599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TmyrGImNoeERgzj0671/YFCWmU7Tn1bl23zRlCFzkls=;
        b=HZ0rvCUdtiV8k6tqRF6TNPr6BxCfo26C8HCb+SArpySJ7XV0WATODALH96NFOW6e7o
         ZGApbRrZ/QSzYLJ8X4t1ECE/Eu4lMlNDeD5wgFvEw8IqauOWePNXyp9HbuUJ7TnRzq9w
         U3Fio9VNZSRrd/Z/2C9vHTz+SG5PyKTA8gsSf1cbn0lXq0B5Gfq+ofBHPqPkjgfeaBO5
         /DXZLDSD0LWbJgTztTbwX8R2jJ4XcYm23CuYO5ko5CpQToVLBWnMG6CIHfph0jtfZrkO
         8ugkjNiL0OzxmB6W5QvQOvvIzyubf5vGK0UgGFdBlaiG97CwLOofr5AdJpIJv6MOq/jP
         CpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793847799; x=1794452599;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TmyrGImNoeERgzj0671/YFCWmU7Tn1bl23zRlCFzkls=;
        b=GBcNFMmBbyMXI03+ayaW38+zOxD0090eW3XxRTqZat175aASsQSFtrA+P9TQ1MrE5l
         L1REQtOuVzG07KMGgCmmkflK0UwCFKP5Yp9NrbsF3myS+ovMJj2jz+yKZDz6yTTljXpc
         olxLZimHJ8Z6eP0qINdMgIfNt/5/AJXUmNvFozADF0OVRwGyTLmU+wLE67Nour0yK9Sh
         kkNFQLc0a1KjUg4jfRDLYdQVFdxHUsqZuYYzRAFfY2DSIYv0q6wQOzQMI4KAk17sdT7P
         6uIk3cXrPMBymqBnILFbpDxAFfunajTZqxLbTwl3nQCaxIHLTIyz1qtYi+4xWQfHgukC
         AREA==
X-Forwarded-Encrypted: i=1; AKwUvBxr5fzcwIogvIihecx6Hwun7BXYX97xDxCjCoaDWdp55fGL7JrbywU5z8hocWT2XxwuGGYN6DY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aNDiwNpzjbL9OX1sv1vK4xnprihjOY6b8YLS0wVBiBExP/PMt
	MO+fTy/kAPSjiFLM1Ac77ryplJJCUrJMV3naQTBWs9IW9gTb5r+O6pIax8x9uWXHge60SdrYN2u
	ov+8=
X-Gm-Gg: AYBFou3m3Lcpc+S1xfIu7ZKoVmGqN505za93iU2cWECMjIMj3LdGp1zFmm28ocLyoWs
	Y9Mxc3YROp0tNX7DxiXj4jXWY+4LFf/qSP1Llvx936O9MSA+vtfw4X4efE34cOpsMVp50VNjGxX
	r/vI2a0gktKM3cxZz0E25JFil7/g8Upz7y6Cr/K4V0Gja8lz+Jal1X4HKx6SEPs4a6VvpSxsgxo
	09KpfrQFGd1ukS7LhKqzC7ZQ5D2Yp6EAQceGLKzr4e+jCUzAiIP7EyMyc62xDe3DNitrL1tvVNh
	v0s662DNaLQ4vRjQ1BYQ5PZ0hauYSHpqFfsz28GjNCQD+29oSqN/QZOhcUdgkje8EPmJzX5CJdb
	Iub4jn3bpSoM6jbKvWNoJ+xV1lZGl9qYaVfTtXW7Qt9+l937h/9yUUApnc+Jz6z8RprS0VJTx6z
	6hiMSq2ZQrRMrs0cYGMMD1Svj8nV0yHSVbcamgz0yFUZ5d2+TRHaxSdbHffwsZAe1bzQzjZ024I
	RuC4R7ki00yrh2J2mWcsOuHJ3MEc5Wjk04S/mou8jAPBqsN9QYpo1Ug4rPf33iRBp32y58d8zVn
	ZmR0nokm83XBLduvWfpMlsXtoUMoAKJ99ue5aP4BcRPgiUX2uA==
X-Received: by 2002:a05:620a:46a5:b0:93f:2e08:6420 with SMTP id af79cd13be357-94421741ccemr3073423785a.38.1793847799333;
        Wed, 04 Nov 2026 19:03:19 -0800 (PST)
Received: from cs.cmu.edu (tempest.elijah.cs.cmu.edu. [128.2.210.10])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d468fbe9sm362171485a.3.2026.11.04.19.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 19:03:18 -0800 (PST)
Date: Wed, 4 Nov 2026 22:03:04 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] coda: honor the append state of each write
Message-ID: <20261105030304.ukyfkyh7xf66yf7w@cs.cmu.edu>
Mail-Followup-To: Hungyu Lin <dennylin0707@gmail.com>,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261104191355.89544-1-dennylin0707@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104191355.89544-1-dennylin0707@gmail.com>

On Wed, Nov 04, 2026 at 02:14:23PM -0500, Hungyu Lin wrote:
> coda_open() adds O_APPEND to the container file's f_flags after it has
> been opened, without updating its cached f_iocb_flags. An O_APPEND write

Why do we now have cached copies of f_flags around? That sounds like a
recipe for getting things out of sync.

Anyway, your patch subtly changes the container file we write from
cfi->cfi_container to host_file and I am not convinced that is a safe
change.

Yes, host_file is set to cfi->cfi_container but then we call
venus_access_intent, which is an upcall to userspace which involves a
context switch and may update the state of the container file.

I am going to have to look at this a bit more carefully because we do
use that cached host_file pointer to get i_size right after the write,
so maybe it is safe and as far as I know our userspace cache manager
only updates in place and never actually swaps the container file.

I haven't looked at this in a while, but I think f_pos synchronization
was assumed to run through the Coda inode, so the append used the
coda_inode->i_size to decide where the write would land, but I can also
see that with the locks being where they are and the access_intent upcalls
that may not be a valid assumption anymore.

You are correct that we cannot rely on the containers open time flags
because that container file was opened by the userspace cache manager
and is passed as an open fd to the kernel.  This handle is then shared
by all users of the Coda inode, so some Coda file handles could be
O_RDONLY, others may be O_RDWR, and some O_APPEND.

So I think the core of your patch is probably right, but it may need
some more careful thought, maybe the use of host_file is ok, maybe the
i_size needs to be copied from cfi->cfi_container instead of host_file.

Jan


> can therefore overwrite existing data instead of appending. For example,
> writing "Z" to a file containing "abc" produces "Zbc" rather than "abcZ".
> 
> Pass RWF_APPEND or RWF_NOAPPEND to vfs_iter_write() according to the
> incoming IOCB_APPEND state. This also honors changes made with F_SETFL
> and per-write append overrides instead of relying on the container's
> open-time flags.
> 
> Fixes: 164f4064ca81 ("keep iocb_flags() result cached in struct file")
> Cc: stable@vger.kernel.org # 6.9+
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  fs/coda/file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/coda/file.c b/fs/coda/file.c
> index 6ca8bfcb58f2..ae03f0b30d84 100644
> --- a/fs/coda/file.c
> +++ b/fs/coda/file.c
> @@ -71,6 +71,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
>  	struct file *host_file = cfi->cfi_container;
>  	loff_t ki_pos = iocb->ki_pos;
>  	size_t count = iov_iter_count(to);
> +	rwf_t flags = (iocb->ki_flags & IOCB_APPEND) ? RWF_APPEND : RWF_NOAPPEND;
>  	ssize_t ret;
>  
>  	ret = venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
> @@ -80,7 +81,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
>  		goto finish_write;
>  
>  	inode_lock(coda_inode);
> -	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
> +	ret = vfs_iter_write(host_file, to, &iocb->ki_pos, flags);
>  	coda_inode->i_size = file_inode(host_file)->i_size;
>  	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
>  	inode_set_mtime_to_ts(coda_inode, inode_set_ctime_current(coda_inode));
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.43.0
> 

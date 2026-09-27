Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3640C3B9949
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535820; cv=none; b=qeEjiw8GYw+HYp7vhR4aZ7NuJ8bu7g+HIPyn9D5p/gwlhPuVhbbi0VrWlPG7vc17niDD2Nf53L/n1octhWX2jjiu1w04fOA4Wru8aBpUuI7Lg86Fsfu200tfdBxR0LC7PcIn9+OqpJMgjVbNlWnULQeupTa/KTOvo6Ae2G2HQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535820; c=relaxed/simple;
	bh=iww9Rrw/7xVmPZYqt+U+P9KcHpNhKk1XEZ9j0Zir8vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jm9v/CSfYnFh6HCBwU4EwiZyLzm+Ka5kqJUA/1pe6GuMTpkCMsh4Xl1pJYDWGqTKGN3oM6oGviMyRaDrqh2XPLgrPKzs6lpTf53H6wj8iOW+rmKxl4iADnisDj0bnf1NybQR/xrjV6hVqCuS8Utct7jHkgzy4rnT/MQGOBakrN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snNZyDmN; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snNZyDmN"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f635552aso1846626f8f.2
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790535816; x=1791140616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hyA13uQBPobSZN7QEDfmz9E3dETz4qLP4md8sLtn8EE=;
        b=snNZyDmN31vH2iWiTXD1dogUrWuUcObLz/Egz0tuCZ42V76I5nrwJuAaE2Fw9R/89N
         FBDrSSBtHJcKk2ACMWA9bO3AYJ70k12dGtBIQW2ahbm3PgzLAyWWzGvZ3GJilIdVHgE6
         mQvBjppBfXrpHpAjzZXoWmyFUdfi+aDwYtYvRQEMzOTgIxJ5ygIVLmdi+b7IjpG6yy8p
         aGuObClTT/kPyCXoofYznF5SbSqh+5MfkGUfL++y4YqPCy6R5XjSGtb6Ufm8Fg8bTLu2
         VdFyOMKuCI81gHHxAXqE7Rm/Lzwt8CYssabJUX/bovswdrZ/8QPv2MZLpblR0QXtaVdJ
         tw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790535816; x=1791140616;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hyA13uQBPobSZN7QEDfmz9E3dETz4qLP4md8sLtn8EE=;
        b=fZpljTAyMzE+vQgYmeeZjF69q70xlmxRGFS+B/jXO9e5bncMajs9ypzcFxt4Zurm0S
         3wFuT996X9WN9QCz0PZvDmXKyTR3wxKlzuJ6ntFBAGpA12FdU9Xnxi2I1RRUrVRJmTmo
         dYvWC2Z+SdqLhop7Msa44lIvX1Kd45UMVZvzBoaddb1MYdawAj1gj9UUdhCDvFcTIqKN
         1dq9JP6ahI+kxUEWjkP3JzihQi2kySW3lcjksYKCLtoKiDtYJcliMuYIrgCTDtu0OaSM
         aYUmWSodxpewf3WXUf6IvdnU4eS7g1zKGpQMVZ4V+Qc4pdRu7/1KzMihZ0hgnaHzVgh7
         ZXXg==
X-Forwarded-Encrypted: i=1; AKwUvBwuWUrgneJgpvGyBaOSfWBDm72L6UiXCJFC2KphZhUPtEHbNGeLadEcg1AMiVl1dENvOSaNQ+M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKFDc6wLmw6DzGLnpIktR6POmE9jgU9qM3t+9cSyPH58YfJ8Iy
	Y0aOVW6hFO0UniFQNUKT6RnEQaJPbFTkZzlraBDX3S+/oFDnf1HnBoCO
X-Gm-Gg: AYBFou3O8bBLLaQd/hHUFpNr/luiyRdJiIgt6qzUgvfy+VV3t0w169tTG2QEavJtIDQ
	8DbEj4xYHO7vUflo0S4TZy3E1gRjvo7z/WscnmBKtHEpzK6lgrmwhjIMvPU1ptV0Xi3/TPke7uH
	Eri3hLwe2aTGn9B+HTwUNHEJAKWQc1jBq7h4FywEeje8kRN2U4fzoAaNTYMDz2L2Egh4SqnAyvi
	VQ1/fwZZf4AFDRwuEj2SUfZ6AUqgH2GV5xl5VnsFxYo1PfCz4iTquXOtf97okUwWFMukWnEayIv
	YlO7agbXTEKs9JMjNjL4QagkOeMfjFB2BUe4tVVKdJwdGn01lYPpSkL3kgQf0GGOl+owlJDUtu6
	ZAmtJ92CpCHvikfhjFmBKbw+sAnXVKjGNepbCUA0iQlTqYWB6n6p2UkZJMMIyimtl1bqJTdpu+a
	UipSX8mmvgmNzqBQqokxKhLgeMSbEuLyvXfVnYVeupkVcJHX1dRscNN8kiXeIZr2QGUN7aBt/HE
	MjasKcVxgWogsfVC/9bg2gcENJUdhzJ/YpXxmdJndodC6iCw7yacQcJwu92+ORJqu0eT6v/FsZi
	G0FzQaIAwaV1xbVIpjjFkZP6lITnHKwImfEb5xM2BhiP2kJ8fiFuA1DI5XE=
X-Received: by 2002:a5d:5f08:0:b0:488:89af:e95b with SMTP id ffacd0b85a97d-48889afec11mr7503670f8f.8.1790535816106;
        Sun, 27 Sep 2026 12:03:36 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349a0esm30979151f8f.10.2026.09.27.12.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 12:03:35 -0700 (PDT)
Message-ID: <5b65f83b-d30b-414c-bb71-197f72feb367@gmail.com>
Date: Sun, 27 Sep 2026 20:03:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/zcrx: requeue multishot receives stopped by a
 local resource
To: Junyuan Feng <a@lollipopkit.com>, axboe@kernel.dk
Cc: dw@davidwei.uk, io-uring@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <010001a0cd914529-23df2f94-bbe0-49cd-ae5d-05922356fa12-000000@email.amazonses.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <010001a0cd914529-23df2f94-bbe0-49cd-ae5d-05922356fa12-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/26 10:20, Junyuan Feng wrote:
> A multishot RECV_ZC can go idle with unread TCP data when a receiver-local
> resource runs out. An empty copy-fallback niov freelist returns -ENOMEM;
> a full CQ returns -ENOSPC. After partial progress the stop reason is
> lost: io_zcrx_copy_chunk() and io_zcrx_recv_skb() report the copied
> bytes, and tcp_read_sock() drops an error from a later call once earlier
> data was consumed. The edge-triggered request is then not requeued, so
> it cannot consume the remaining data until another socket event arrives.
> 
> Record in io_zcrx_recv_skb() when a walk stops before consuming the
> length it was offered, and requeue if the pass still returned data. The
> failed chunk is first on the next pass. The resource is usually still
> exhausted by then, so that pass fails at once and ends the request with
> an error CQE, which the application must handle by re-arming. The
> request does not spin, and the stall becomes a visible error. Keep the
> existing skb limit and SOCK_DONE handling.

Looks good

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


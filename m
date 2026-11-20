Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189515;
	b=pdLrxA2+VhgJJq/ZREFGqVIV6o2eZ9di+SoRNN+KMTRj0Bjc1Djcy5ScrzRfXZNgAXVr
	 I+voqfoKl0XM1Zk1jlLt4b6BdtOaRTwNazf87QpTrauwAGr6o/JTf0LIXFcSvkzhk8dSr
	 8+uS+uB9eq0dOLN32xWpyAfdWOtO8ltu2OQvwXov2Gb/KYTPY9eG9JK3e5+UwAOB7Gx2U
	 L4WIXXSG1L+MYd2ImHOTCXXyae86zhWP1H4pDCOjCbMo1B9HLUluX5bMjQs8U+v95kJxh
	 87X2TA0/1iq+mXZGf/0XEiA8tNdK5/M1Gbxu0Y58iqXgGL7lyDcGzZKO9zq75mQ9Gkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189515;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=apWQglMZ3WR6Lq4/1VhlQe/yInFiYTe1Kqw3Bxr/zls=;
	b=kKwdfmoNg6jYRdPwtRJpXdpYZGIZCN44KWMJ6cSXcgT3j+ID7fDLoDeo5SMaqt+tJzQC
	 5uhw9tKE/GSoYHhVgd+RxCNy28hnuVfAxsZGKFnvmVDyHxwAytWbmN/RtNz46rNa6nA+1
	 cwGcuaNqaKcewxb9uzkDVAFyyB1N7Qf+7VrgcrUsbuYTj350QbOIvDjwM7RPZyWTXABcD
	 WhiafhRfpUg5kwLiAbTHZ+pIJoYfVZNIEjjGK0MhfJmtlp3NZNtRXy0Ot3k6dHQEuoZVU
	 jxvBdgIykaEcKXsQt14ObSp51SYh3sSfaNeyETbmdanTCuFd5E36o7WAUiPi30GiEHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UX8pBjDO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C0606A334;
	Fri, 20 Nov 2026 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UX8pBjDO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04EA1F000CA;
	Fri, 20 Nov 2026 15:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795189514;
	bh=apWQglMZ3WR6Lq4/1VhlQe/yInFiYTe1Kqw3Bxr/zls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UX8pBjDOnjLtEHZ5XE8CaPe0jP6PgAbXPkboIZzJ0jT3CprDUZjsJF78WumNAra73
	 rId9XFyQaiyJb21WKGZz+COrDoHg3uYirXYVEiQiHdnJboXwp4TSAH4PbGrc+T4OQ5
	 L4ot4SEhMHZREESAhmwdB9jYiFvi2g8ak6mCnFv5MhwZyfeSPaOkh772UnmkY7xwLl
	 UZb21N2I+fkPP5s46acmKzhtzUPIDsEUFWQsN+15k9GiQL7kH5Jn9fu6GxXu0HnMxZ
	 7/HBJDiqix1cePPZ0r0ReoiQvwW6tkrkTCqaqBKqDmQ9UaBPuyVFCaQFoOsOKZel/y
	 kfDY2Sq/ARs+w==
Message-ID: <f40f3cf8-73ea-4d77-b0d4-8e7afca54cd7@kernel.org>
Date: Fri, 20 Nov 2026 07:45:13 -0800
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
Subject: Re: [PATCH v2 2/2] zonefs: ignore RLIMIT_FSIZE above LLONG_MAX in
 zonefs_write_check_limits()
To: Ding Feng <dingf3ng@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261119031026.7985-1-dingf3ng@gmail.com>
 <20261119031026.7985-3-dingf3ng@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261119031026.7985-3-dingf3ng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/18 19:10, Ding Feng wrote:
> zonefs_write_check_limits() follows generic_write_check_limits() and
> has the same problem: it stores rlimit(RLIMIT_FSIZE), an unsigned long,
> in a loff_t, so a soft limit between 2^63 and RLIM_INFINITY is negative
> and every write fails with -EFBIG and raises SIGXFSZ.
> 
> Keep the limit unsigned and apply it only when it is at most LLONG_MAX,
> as the generic helper now does.
> 
> Fixes: ebfd68cd0c1e ("zonefs: Fix O_APPEND async write handling")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5 Frama-C

Not needed...

> Signed-off-by: Ding Feng <dingf3ng@gmail.com>

I queued up this version in zonefs tree for-7.4-fixes. Thanks!

-- 
Damien Le Moal
Western Digital Research

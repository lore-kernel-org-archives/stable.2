Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278776;
	b=SKQYyBzGw9AMtVPVjpc37T1AnTkg9Pz4VjppT8+o8afOSzhU06V2x/I47KHBKky4vE/3
	 AqYPRiWEpu5M1h8mtKGSkXnpGz9P/1/RaivO30wG0Xl0yaGnLyjvJfoHe4duRo5EDNHs9
	 YsQgYP0oolFUER6KSX/KWnAbvn9V4eM0TnXpjOnjvXq6dUsYH31eAKoSEyX3mKvHS++sM
	 HIexnLgcs7V9UtIB2W55OmFYY2M2mPzzeZ0SZeLCw66Tml2oZl5vc7Ekufr7ZeJORU1Bi
	 W/JrDfuEH6c5LH7l6YSqhv7rTaC3rQn+QYlDBY8pQAmNhPpwwWl10rcl3M1Jt3Jdh+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278776;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fFFb3ERYWhLPPrGzb6PUS+6QBuR3ObPrqTUZrlW/KL8=;
	b=2ln4csm2D+4WJYWAkVow3mOeO6Lg9qwtybmIpSSYT0azt34e67MkWSpgfTNzHQBND8WD
	 f9RJVC9nzCw2QYoXh5w0H42aGb8uS7Xs4z1ldSIBYwIUIXSKGuK8TAk/4QR/N84vVaKNK
	 6/Xb1Ex3V3x2DExpg/PReUvg7RJOzknvAxCV+PxITyllWwy9jyGBBEhXvtOBmaZC/6MGp
	 12Tk/fiN7z7lge8MrTZtwgsBdsi/3To/dgcw8GlQ5HxcyMf1NRUhn5PiSV1s4aBr92jTC
	 qzZmUYgA/1anBhg3OslQSWYhjFhd5HQrGv59o+GRRLb6vLHWJ3hEVQjCGkMVumnPCJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZeAw83X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E28606A31C;
	Tue, 10 Nov 2026 02:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZeAw83X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9151F0089F;
	Tue, 10 Nov 2026 02:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278775;
	bh=fFFb3ERYWhLPPrGzb6PUS+6QBuR3ObPrqTUZrlW/KL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XZeAw83Xs4YUcCgKf2X1UoJYkgecetN5u/kBBH+Wcpr1jyGmNH+nzDAca6vOQpkQS
	 WiULalmKcYo0kMAsngmvkgajgiRmxpHaSshtPBOrIVOCEKyFp1sFE1Hi9qmt2+7SIU
	 yoifEjzDzjAJnTvETVLnrDXISk6H3NfHJE1y9AbbwfRZiOdkPPgsEfBJVZbiadCnTz
	 mclfuNQfXIR+exf4oCNIqmn9DuvjcU0cmDR+a81H+UcFKF9lc6L2pvMO+yJpqEEtN9
	 5VKEkGtMbWLxjYqANr6lkdRgeQHTN7ZjyfysUPM+LlDbiIph74kO5gCmAicJ5ZfZ/F
	 98MSU4jlYqDag==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/core: move static variable last_nr_regions to damon_ctx
Date: Mon,  9 Nov 2026 18:46:07 -0800
Message-ID: <20261110024608.119184-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110022454.112647-1-sj@kernel.org>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  9 Nov 2026 18:24:54 -0800 SJ Park <sj@kernel.org> wrote:

> kdamond_split_regions() uses a static variable last_nr_regions, to infer
> if the region boundaries are too stable.  If it looks too stable, it
> does a more aggressive region split because it might be a fake stability
> coming from non-aggressive split.  Because the variable is static, the
> inference can be racy and wrong when multiple kdamonds are running in
> parallel.
> 
> The user impact is not critical.  No crash, no leak.  DAMON's
> best-effort monitoring accuracy can be degraded when multiple kdamonds
> are used in parallel and the workload has certain access patterns. Still
> it is a bug that is better to fix.
> 
> Move the variable into the damon_ctx struct to fix the problem.
[...]
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -804,6 +804,11 @@ struct damon_ctx {
>  
>  	struct list_head adaptive_targets;
>  	struct list_head schemes;
> +	/*
> +	 * number of regions after last merge.  Read kdamond_split_regions()
> +	 * for more details.
> +	 */
> +	unsigned long last_nr_regions;

Sashiko warns [1] this could cause kernel-doc build warning.  I will post v2
after fixing the issue.

[1] https://lore.kernel.org/sashiko-outbox-206056@kernel.org


Thanks,
SJ

[...]

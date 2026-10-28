Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197474;
	b=Qdwxbs+tQuvNICOyHjIjnj98ROODmuOmt1gmIHTefGPzzj77uVSrGstIaVbKTIhZ4mal
	 yf5oVT8Na6XxbIdtTqlmSUYBa/1f2f4pcdILY87nuZLC0MWuH5kpPLuzTS6KgwlxlW6U7
	 aDIoB7MbF+sjK2nVwTorGEnZrr8/lihNm8zRBRHe+DGUJEVqNuwM2agFY9xHQkAzakIjO
	 ugcgPCg81F6lfr64yxKEYifeyXNktMgu1qUaIpwD5797oEWTrvZ4XvyLQ2XVmc2AKkilN
	 gbDPBPLJAM8Dz5FDzvF5tJS5PjKj4Y6qgjtZSk1JIE94BeBgCaf+hO78wqCBv07Vwzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2lNc3TmeFA42z/vlls1GtDaaIwnrmScSpoxbIc0sB0I=;
	b=0Zw4z+9w7sw7iWC/b+uXYaNehJ52Rw0GKbRIrOH6YmrELGXTyCpq0AZxDtVCm3o+L1ya
	 HNBg7MrL6ou1q/QR/fiQtH+2D0tfk+vUG0CGIpOqT25VHVKM3AJlRKLJ59cu3yEUUiNbb
	 pJ7UjpqGU629Xuf+J8KjdI8ygXf+25JoNdw98qvknGNADJSqAkDKhaMvKPnaQc/2bCd+8
	 AmPqEW1bH77MaaaAG7A1RdRqGWmExE+rdSRLYfg1YAcbIf3SpaU6WpETT/+caNUxYiKpu
	 nxxWsyi5WC+xxGsT5EqT9J4lri4DV/qX/w6y/MiLYlLRlTujEZcrxaIjPboTkZDHeNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iuj+M89E;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA390606A32A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA390606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iuj+M89E
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3535a54bed9so1488867eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197473; x=1793802273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2lNc3TmeFA42z/vlls1GtDaaIwnrmScSpoxbIc0sB0I=;
        b=Iuj+M89E2C4BUXp3d/YGDW8L0zBd/79sxNVHYvvpUsD8kuWPNu6jNoS9QAPi137XQ8
         Max3lgZ+9dS9GfQvT2IO0vN766ns5hz4aqX5Ck3PUkO7Z92AgV5A8d5KvC8beg4uEfyM
         N5FRVYkT9vwajGJYW9KocJ+ufbhfArqdcWUMVtYaZP3s3M3FQUOAFS6beBv/iWrMr1VI
         upDYD7SS3VWgn9Kf0jjK4vCUCMxvQAz7oQoAav/wzyOUbiYc1y5NcPJ1d/0VxDnDM1rH
         jkDzlEBO6MQ2LaPaR3nV5j5T9qDMweomiegT5pVWV2QSrGcvxkT6cnbN/RRN8FvHCVuU
         3uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197473; x=1793802273;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2lNc3TmeFA42z/vlls1GtDaaIwnrmScSpoxbIc0sB0I=;
        b=DewIebhotyLSz/9s7K5FGvzXdBFlnqrV+9+q5/5KfJAU/Vs1ZHTjMYmiGGDL6L+Icv
         6+buw+a55zanQHbVtVh3ZwNJrw5Ig1+e1eoslGR+oL5V5NxP+hvPi6EqEIiVIjlLn+2C
         0ykzObqRCADNWo+jNlPpiOzb1Yl2gUkrc1eSyTUVwiBNl5o/k6+s7yteCxyq0aXN9zOs
         aKu7wahuz8shocqTHGRU7MafjkYd1DvNtx3A8i1I5sVg7eCskZ1lIYhQGsCXBSYP4FNr
         kMIxWL+OoMKNAhh/8/med2xb5LgnpJtQyAeCyYPj9FQWV55hDRNWazbFR3ZJ7m8TNuUe
         rl1w==
X-Forwarded-Encrypted: i=1; AKwUvBzDWp3iQ5+Qd0/WX0pLbm8RyJYqOEgmVze+NuhjZFeEaK8BLdqLCHjLaCWghsWAyn9jHA+hpgE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMqg2z2xFB4uA28qCOO8pesYAWzpQkOxGuob4NOTDSbKvPHxHw
	H9dM2k9SROHFkVstptLrJZmKS41QFP6saN0+8WLTlpfEvSZkXmncHh6Q
X-Gm-Gg: AYBFou3xjltBUuXZifqi7/mxFUwcsev7tLKFqZ1ICeE6Z677n9/RyFfN+tUgLlKmEyS
	egpEf2ggqYLwbTBSJNJ4aLKU9DhIqj6xMnF/dZWsK5Apqdchwukj+Ys+Jto8KLbvelFkE4x0C+f
	LHwfC5vNWIlcllTKHUeEx+zX8AycBB7YxaYKS9aBv0Kk5zFexZWWea6L9I7ZxMC3CiWgiPv2FKT
	bT4xXXIXc99EL5D6E1A/kqV1nhf2V7zpIU1EmPPR43WnZRwf9nGUMCNHpcsJnyfwAeyXmbNFP97
	tPx8EvpYuBH0hxoaS610qz61RamD8PBTZQUBW1Q7ZcvIusNgD7TGaTRsGNvHMUyAsCNklW6QhPF
	c4ihYlTDvYBKHQjfXVgX8M71j6mqLzlpCCxa5Vp+49tfCLlN+oEsQvluBpI9QeDcogcfcmQH2HT
	egj7gbKtBvRKwdZLPHUgks8V1a6lo1ZbRU2kWbInBy3j0gUOPO6mqtK49uLZwikc9KJyKuJp7uD
	+e7UfoTqfUD6DhS/9IUs+JHbrso5N7kG11xnfm6N8Js+z3cV7O8lXZcCHUUEP8joRb3uljZvoKg
	PnQWvw81zM8giA==
X-Received: by 2002:a05:693c:87dc:20b0:368:4acb:f8a with SMTP id 5a478bee46e88-36a203af6d1mr3477586eec.17.1793197465873;
        Wed, 28 Oct 2026 07:24:25 -0700 (PDT)
Received: from l ([2406:da14:1f64:300:5751:346d:db2a:88a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239198c9sm6895930eec.15.2026.10.28.07.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:24:25 -0700 (PDT)
Date: Wed, 28 Oct 2026 22:24:11 +0800
From: Liu Yufei <lyf98405@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Gustavo Silva <gustavograzs@gmail.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: fix zero timestamp in triggered buffer
Message-ID: <auID4_vQSZXuNk0Q@gmail.com>
References: <20261028-bmi270-fix-timestamp-v1-1-99c0e5fe7d0c@gmail.com>
 <auG5MXTh9ZkXMw55@ashevche-desk.local>
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
In-Reply-To: <auG5MXTh9ZkXMw55@ashevche-desk.local>

On Wed, Oct 28, 2026 at 10:58:25AM +0200, Andy Shevchenko wrote:
> On Wed, Oct 28, 2026 at 10:59:26AM +0800, Liu Yufei wrote:

...

> > +	s64 timestamp = iio_get_time_ns(indio_dev);
>
> Do we need this variable? Why not call it directly?

The intent was to capture the timestamp before the bus read, so it is
as close as possible to the data ready event rather than after the
regmap_bulk_read() over I2C/SPI.

If that difference is not considered significant here, I'm happy to
call it directly in v2.

Thanks,
Liu Yufei

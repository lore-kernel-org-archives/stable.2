Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615560;
	b=qPa+KYzSQf51cW2mWdtwccAZxSeUujkvAm+GBcGeebYn7Ib0OtGBO5UFl67uyTscfCLI
	 PI7+j8D1JOZtwmjIXLettFC6yfgvmYFVGGPZUuAvhBJU8R+2uNYL59NtSjH+yLUeoEPcs
	 SpHSlv+eF6oYXQIL/5AQtGWcdME28dnN0DdD2IlF0JY50Nmev9AHQkRnXNMHIq+6qgJ8k
	 FmpzXRH8c8WCuteJa3tzIxP44VTyW9FdpjBrcmtt1QLnzIkk1yOuAcoEYeF8sYvWOYJqw
	 tJPUv224GEJ/A0Jz8CpuJ4epLKpzwMkwTGUDtSk4cXG7wAkYo9MC2WamCDPjxS0YDQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=s5Ihq3EDQtqpbYTB2nxg63sO8PdDPYRVUiCL/mkX980=;
	b=jVoXU2KiqT3u6U81XXPSUAlteC4nqMyAWgS1M/MtneYe+SnTtML/bXFBYTSvA1xR4yUy
	 lzlAoSvjtw0wSx/PhbrKguPvSfhIGlDva6zYRDAxE+/5snmv2SOteWzLK1OFEUDgd+dXG
	 QbRphbBH6OI3qdoIYWoW3cKX3OnQAI25bo6swZzGiUUb+FDvydM+ou5sHWs9HB9GA7L66
	 RFksemT9zL2YQ70HVS5kptbeZEQtAs6hUkctRh+ROXYpqTVE4YQ7DttNHrtHDtTqZ+HUv
	 8XjSuxgoizGdSwRgEZbPdk/iKdDIBVKJA2AfevN+GxdHYxZGvcSNSruW3n9lUQ1rMKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YRyvXk+J;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE04606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE04606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YRyvXk+J
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso19236835e9.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 02:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793615556; x=1794220356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s5Ihq3EDQtqpbYTB2nxg63sO8PdDPYRVUiCL/mkX980=;
        b=YRyvXk+Jya/S850FN1og1TUyPM7JSwGSQbmSEG1aDTc8/MkHGIw4P4FNGh7jDDk0bj
         v6OD3/wouGnRVnwmtCeiqX3fK7Tl8rdp4cSMxdHeQulceZ3SMwjLVlHjKrzwb9zQ8rVo
         vB7Ym8COF4zO4FFS5iil/gV5foFx4zGKQFDlxDzviGaZYWExGNfd/cDimEztakQNBdHE
         cgxrleQp+XO6BwfygnAyrWr0KNeOejQlGt/AC0rWok/eVA3a7GN2eWr9z/noWT/otzVv
         CJvgK3U1CmIcMWvi3+brx/W0YRdsWn3azd0jKxDdckJXt0RGu7s4/3AhCyk+8R/FRSoI
         eAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793615556; x=1794220356;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s5Ihq3EDQtqpbYTB2nxg63sO8PdDPYRVUiCL/mkX980=;
        b=IuRpDNza7FM1ounKTEIsmmwQZLZKmGzmGSnBZvnWkva3LtufHXvsStYpt61EJN9J6n
         RXw0rqkspC1VT51HcFig95g18RWHeUMi9K3ZD7CXEUUiEHeIrxz+KOmQt4kFCg2prDhu
         bVSvIOFZ3vw8n0z44Shs/UVbGfMJNXO6yT46VU9u3jZ1wXhxy/URMINaz9dXUBR4m0YJ
         bxbPOjsvFBKpt4GKs9jjdcOIVwQjckM3faOLrgXycNugjjT5UhfSFNIXVwHUvCA4T8U9
         xmlj5FHOPjRe1+F/h/6NDa7Jej5mLnRwL3FrgElysmoYiYB/cwjlpJI/HEU1KsKICTIP
         9yZg==
X-Forwarded-Encrypted: i=1; AKwUvBzmf+7kbj8Kir2OApljXeu7rwREfwfupaWAbCRYtXDvjh/1fe3gU68JPX/tPJayr6/+ta2b5+Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwLsCz8rs1+J9wVS6Rf9FOgC0cyhv1IPmhZBdDyn1NcWzL0gxv
	Wep5+ekd1kjwHMmkMMLlAu7Po/ItYS0QA8SqnOrh5uRtFjvdIvJsnWuQw1+9LSU8I3g=
X-Gm-Gg: AYBFou2XRCjqSHBr+T9D6VZ/MgHQqR4cf58nvf4UO7xGTvzCcKU8fy96jjBdFcZR2oV
	mpGCiEu6DfqGjb0CYcJAEg7XRq1YNhMTCvb9YgG/1pASePOuWOwlCJvAIF4FJXyIB4wWipChBxm
	8qrNQ7ueppzWZsSQhsMKTjbB6c7bLd7mtgNyEOd0P963eDnZdPLwHZDmUWjao5+jjcgVE3K69c1
	1GRAK3iemW+dVhsfmstaQCLZDtPHOWj93dtHoF3NaAPEj35m2VZv7P9kKbdG6WhwYGpzA6iOx6j
	5BRvvph7jEHxLcm9S14wjQbn2F/D0i5O4XPSYgmK/GTbmifBGEwqCbf9n1g5y/gtxWawVdDfW8C
	coasm8yJUcOYSxgtDWc67kaszQkWVU2aL9F2obzlRjrAnqFZde7EuBwzEMtSXWSlBJitaXWZ8LH
	8Kx4QiWCK6PqDwwwCXgzrdwPOf58bbepP/x7kcLi0R4fRp9BMBst45r5k4K2Tu3kMwAjSTR7y7N
	PK3NEY/LoaZd7wI1ZGeWrgHtGnxRXyZwAPo/YEnOzK8OjT51gkBadqOLMvbApW4sXUVcPOebOaQ
	Zu2u0ssH2F9lKFhcKJNhUycLKXmSW+u+AFUwK162IeclJWBZux1FKC/IghYV6/chWEeOFQ==
X-Received: by 2002:a05:600c:848c:b0:4a1:efd3:9862 with SMTP id 5b1f17b1804b1-4ac1765d977mr205638275e9.21.1793615556161;
        Mon, 02 Nov 2026 02:32:36 -0800 (PST)
Received: from ?IPV6:2001:a61:13f9:c301:88b9:18b4:d518:6aa3? ([2001:a61:13f9:c301:88b9:18b4:d518:6aa3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d425sm19722777f8f.1.2026.11.02.02.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 02:32:35 -0800 (PST)
Message-ID: <ab7f4bed-92a3-4d69-8ddb-818121309837@suse.com>
Date: Mon, 2 Nov 2026 11:32:35 +0100
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
Subject: Re: [PATCH v2] usb: uas: ignore UAS for ASMT135x bridges (174c:55aa)
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 gregkh@linuxfoundation.org, usb-storage@lists.one-eyed-alien.net,
 stable@vger.kernel.org
References: <20261013221944.41598-1-olivier.kaloudoff@gmail.com>
 <20261014105700.19433-1-olivier.kaloudoff@gmail.com>
 <09633215-e52b-42be-90d9-12fee5b8728e@suse.com>
 <CAKLTOU-rb97bv5dNZ0AkzBNORLYeWbK9kJjQUxfveK4aCAUuJQ@mail.gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CAKLTOU-rb97bv5dNZ0AkzBNORLYeWbK9kJjQUxfveK4aCAUuJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 29.10.26 22:32, Olivier Kaloudoff wrote:
> Hi Oliver,
> 
> On 27.10.26 10:54, Oliver Neukum wrote:
>  > have you tried the new quirk reducing the number of streams
>  > being used?
> 
> Not directly, but the failure signature doesn't look queue-depth
> related:
> 
> - The enumeration stall fires with a single inflight command. I
>    reproduced it again this week on kernel 7.3-rc5: with the
>    device bound to uas, sd probing's first READ(16) times out at
>    +30 s with uas-tag 1 inflight, then abort -> host reset ->
>    attach. A stream cap cannot address a wedge that happens
>    before any queueing exists.

True, but just to be clear

1. is this a race that sometimes hits?
2. does the error recover actually work? 
> So the two failure modes are probably distinct: a probe-time
> firmware bug (unfixable by stream limits) and a load-time wedge
> (possibly helped by a depth cap). Even if US_FL_QDEPTH_075 fully
> masked the second, the device would still fail enumeration
> reliably only with UAS disabled entirely.
Yes. The thing is that if we get a rare recoverable error
on enumeration, disabling UAS would be overkill.
If not, it is what we ought to do.

And an experiment would show us whether UAS could be reenabled
if we ever find out what causes the issue on enumeration.
I suspect that there's some difference in how we and other
OSes read the partition table that triggers a firmware
issue.

	Regards
		Oliver


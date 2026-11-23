Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464844;
	b=ic//tPRUfSMyNs9/yBuNUKCiAZC+JHK6bWho1JwlTBMStyezHQQ7fL19xnAh5VN+oBed
	 OlFRKGxHK9Zq/nMuoTOdl1V8PPPInHNrn2EmwNXOO1sFgvQHvFEaGigcHjvffa/FHZNKY
	 SROqO4luvkpxGzNhY9WBgq7eHROZ279PvZICOpR55eemLRjLqlG3i7ml+u11EAYTBEWUW
	 Ysi1lMayhbMjRMYSu5wB2zGBSOhmNQgPmhvFqjpP2Rq+DArFf/FjIS1+Me1G87vneLo5u
	 9roYcB907Wl1EVyzD9GTPmQpt1WTQbjOSNBDp6cpzjRH10u4dCpjXraqbXEn1LwOZkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=dgeT5HSySDkjBdmipJm4ZLy1GjB1CH3yde0pguoA2Lg=;
	b=Rcf+syWYpmJcvFIcpLA3cPaOtKXWMVMQSlrinOMWb8OkrFpXaZsbFcjYazrVpAckFGrG
	 6GurOMpOsWgXeXkN5nU+0MX0IQYqhSSWgn7X2nyqr4lMg2ScqdM2mKz6NgaD/8ePgtuJo
	 Etuqt9xzx6m9dbCIkE9Wy04orS9ew7ELbxPM4klhZEMm4JqlytCRMnvS3XrvRDvi8X6rW
	 zDTWh0solHwwSPfdr7Kd3UMjqWjGT2h3fXmHCmgokNq6GBDlAAu2Y+BoUBIwqmfqfatBc
	 cQBk40Nmoo/6TWI7y2JI4BklRBqcDjYKkpYxxbTRw9Y4I+odG4Zs/3H3qucCL673wGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="O/QYgvZm";
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF5606A327
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FCF5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O/QYgvZm
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-38587f3de36so4491767eec.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795464843; x=1796069643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dgeT5HSySDkjBdmipJm4ZLy1GjB1CH3yde0pguoA2Lg=;
        b=O/QYgvZmhabx3+D1Ox0nAqUklAwki5ts/e5ICD3coNuTFdwkbOEZN1+A7RpaXEaQwL
         Mp4iBvaRVCxjPQ7fVMeTNRD8T8FoxT7n7oxKfV3t3J8vEdjJqUCAKqgmMab+Ay57xxB+
         bcVpILohdXpSCjVMN7aXBpUyixQATBOkrAY8wSTNkf2jhPRN+Q1N5+TQTREXzogel4si
         QW5sgjsw7YTrPRx/77ku31KCZRv/wLnBT0F18Vn/OdNghH4QCpBIP9G2+idR7IOZuGCS
         itNt8FdcM5sVUtZT2ZP7qYHmDSK2KV8KeJFQXljcQIviEb/kursmQKvy6ypAemXGiOae
         +Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464843; x=1796069643;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dgeT5HSySDkjBdmipJm4ZLy1GjB1CH3yde0pguoA2Lg=;
        b=e0I474q6Vy9N8oi0eK7X0ANc5zl9xBo/sIBlvXiCzaMtTupwb+mOhl9Z5PoQMZnURS
         90IatLUF94oqVznJ9ogWucUCKFPzRDC+NmzkQo8ge9YPIF+COHFCUv+lEB0tNvAG3bHi
         WONctNmz9CopGaW6LXOVcZDUexq7UtcEeoUn/kI1IP8gJsO3o5FDcLkqDIeMCL3zvnvU
         5CiRM4kHpBGwmsij8bqXGfw1Gz5ULJJjV/dGLRAb2ZEO0b348LZusrc7YtotXN2jKrag
         tGRfjSVldtLrM+4D7iZ5rxBcFgP1Y99b9dWJavxBlw6VDMfRWAtiZ4q5LLI1kf/RDgm9
         2Heg==
X-Forwarded-Encrypted: i=1; AL+hErG/mFVHUPO6aMUwsYw7qORyQbttcAlY335jVHYFtDlui7fBV2iI7eFUOij9g1/eNCNujtdfeWw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cy3GOh7BA90oEYmOBR9nm9HkTQR+ku+JIUogjo/Z9CoHGLYQt
	Ef+C+WnWSp9wQ9d0XfIdLyNYdS+mTtN85IjqCQos4DWF2lWuuuNwXEwy
X-Gm-Gg: AZFdTZf/zeboJXg6bfXYkLqCJZlNmMskVG6UABRjG2l08pc4rTBpzX/XvV/brmBtB98
	H2ijnfyRfVb9IX+8O/t6Apc1ZA4qyDwEnoLUQSovpSAKwsm3H2Zt8rsjXGXvV2CJpuyK/ihWqzh
	ZSd89UQ9oqrBtSHIgWKJlvSwguNUnXF8/+qPfA7w4N2X36Az1xu70nj2SI3cPjgAKsljWgJI4yW
	aGl6H7Ae/6zWJ+lQQ4kSZBEDfzUZGwsN0hoCJQb2gRBBlOPynqYEKoHA/diXlL8XwZkObS9zWRt
	CYfYffAJAS4nzDFqsFAs/OnB31JXcDAf7w33BE4T+5YFmpbSQqJC5b297jlzvGqJtZfLmIygm3B
	InPq0Iaaa8ME+CI1peMbqgPicwMmqvPdL66OWghG1daLfRs2ixSZwfQxCSahUZu8Pp80yUrDbWq
	TMNFWfSOWQX0oP7/SlkpGRVkh9gGWgTwPocTltVzyfD7XXvZwxZsDBtm1wS3DRBIM7mma9iJM2s
	zl95k0VDxYRheQ26ysa7kkZazBhVSwl8yxIzvgZelOws+O7/5dvUC+8KSEthJsv5nFJtja1COyc
	wqvvZgf53Tj8vNc0f9WZcks6l+m35AMeXHwEWj0PxNDdLOGkRvkBY5v6YIkJ5X0yWRvWoqU=
X-Received: by 2002:a05:7301:259a:b0:36e:800a:71fe with SMTP id 5a478bee46e88-3856c4b844cmr12383687eec.1.1795464843155;
        Mon, 23 Nov 2026 12:14:03 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b9bdafb5sm4836352eec.9.2026.11.23.12.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:14:02 -0800 (PST)
Date: Mon, 23 Nov 2026 12:13:59 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>, 
	Ronald =?utf-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 03/10] Input: applespi - cancel touchpad registration
 work on removal
Message-ID: <awSebEs9zEV7GDF8@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-4-lee@kernel.org>
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
In-Reply-To: <20261123183200.3900004-4-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:09PM +0000, Lee Jones wrote:
> applespi_probe() allocates its driver state with devm_kzalloc_obj() and
> initiates an asynchronous touchpad information query whose completion
> schedules applespi->work to allocate and register the managed touchpad
> input device in applespi_worker().
> 
> applespi_remove() disables the ACPI GPE and drains in-flight SPI writes
> and reads, but never cancels applespi->work.  If a touchpad info
> response scheduled applespi->work just before applespi_drain_reads()
> completed, applespi_worker() can run during or after devres teardown,
> corrupting the device resource list via devm_input_allocate_device() and
> dereferencing freed driver data.
> 
> Cancel applespi->work synchronously after applespi_drain_reads(), once
> no further SPI responses can schedule it.
> 
> Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
> Closes: https://sashiko.dev/#/bug/linux-bb2fd773-6c20-468c-a092-6814f008077f
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/input/keyboard/applespi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
> index 96c504f28495..d964cd3ee5af 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1819,6 +1819,7 @@ static void applespi_remove(struct spi_device *spi)
>  	device_wakeup_disable(&spi->dev);
>  
>  	applespi_drain_reads(applespi);
> +	cancel_work_sync(&applespi->work);

Likely should be disable_work_sync() instead.

Thanks.

-- 
Dmitry

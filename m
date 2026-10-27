Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793063099;
	b=XEzYG3iSXC/iKKwWf0sW5dKBLKk8ttEonJYClmqLY5U70Lz785VKm0SU67TwYB/74nJ7
	 b+p+yP6Vv8uuYvhPjavEapDn9cpo3Z1na4IJmuvqtCYZ2FSI4yj3YgamloizFq6tNHRIe
	 8AiuNUcVWkMqu3NazR407Y1lwUtyY99MtQEsT868AgM+5fdgjlFs5smiIdLJAzkVGdt3t
	 hVMTH/nsXJXnt8J28Y/iSDXwrnSQjVFTo8SBagiJao8JKcBTXldSOJ0RoDdIkVs4+KYkh
	 jjfrz6h8P52GwY2wDTPEBvXsafatZl1LaFWklhyJW9lIgczVYWIyKRdWoM8RCj/rcjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063099;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mGxWHZuwgItXpq40WocP1Fuuw/cuauEvBv+PeNmyS44=;
	b=X6rZgH2V1NZ1lR/cPJ8yul7USAxSfAdGKCR1vmIBfTyMDAR2Nj3FLM1ttSS2SFvAIdNF
	 jan1LNtfZGo9jJli5Pc9bdnGcnSL3pTs9wAEswpyRVV+cjq8yh+GeAAvXQq5+dSqVhCJZ
	 Kg1M7rw1uCfQ5ZwYWzeE4NBlFj8QAcsQ5ZfrMnRErE64tW4YxjAyTW2qXrrzWsJDKYeUV
	 0zILXjFxshETOutuDhE0nt9RiPKKRrC+v7JZNrnPAiRtXqUP0xmaV293Stii3pkPToInV
	 qNy2GcdvDbXMSxwxS1VsX1IyH6WopcOheYUC2C+C6ubNobJN0gFSf8rwPiwGxuzvXww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJM+7HSJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778F7606A31A;
	Tue, 27 Oct 2026 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJM+7HSJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792661F01825;
	Tue, 27 Oct 2026 01:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793063099;
	bh=mGxWHZuwgItXpq40WocP1Fuuw/cuauEvBv+PeNmyS44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QJM+7HSJCDuAJTQqAd+iU+38gWcQHquWOxygitQXX5oOqe93VrlxlbFg49HHp/hpn
	 L9Inrrg+hnMc4aOckCuZxar5iQ71+DtHI7qnvePFwf4ePCZoYTPtQ977VnJ0PJYG2b
	 qmkNWVNEDk4KZSZgzofIaYK9Uu37RaAUv+AHPr3eSL+d5h4042EDsnwwSQJyKgx4tw
	 2ew8mwFKW//BYEbRH06XVzQ2lixfB5MT04ty8S7rWNwC441nPr0ZZGgzLhQTBEgc2n
	 5CrHNBNbBjpbciW21vvck/FOoJRhLo7KR4QxQkviO5reEbgrXfad2BS1oJw+gHzcVR
	 yMf4w6Oxego9Q==
Date: Tue, 27 Oct 2026 01:04:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Kevin Tsai
 <ktsai@capellamicro.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>,
 Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Hans de
 Goede <hansg@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Tristan Madani
 <tristan@talencesecurity.com>
Subject: Re: [PATCH v2 1/2] iio: light: cm32181: validate ACPI object type
 in cm32181_acpi_get_cpm()
Message-ID: <20261027010451.7214ed8d@jic23-hlaptop>
In-Reply-To: <20261026142040.62383-2-tristmd@gmail.com>
References: <20261026142040.62383-1-tristmd@gmail.com>
	<20261026142040.62383-2-tristmd@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 14:20:38 +0000
Tristan Madani <tristmd@gmail.com> wrote:

> From: Tristan Madani <tristan@talencesecurity.com>
> 
> cm32181_acpi_get_cpm() accesses cpm->package.count and
> cpm->package.elements without checking that the returned ACPI object
> is of type ACPI_TYPE_PACKAGE.  If firmware returns a different type,
> the package union members alias onto unrelated data.
> 
> Use acpi_evaluate_object_typed() to request an ACPI_TYPE_PACKAGE
> directly, so the ACPI core validates the type before returning.
> Also replace kfree() with ACPI_FREE() for the ACPI-allocated buffer.
> 
> Fixes: d34ca613b939 ("iio: light: cm32181: Add support for parsing CPM0 and CPM1 ACPI tables")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/iio/light/cm32181.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index b32a94028f091e..8d00486af608c9 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -114,7 +114,8 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
>  	if (!handle)
>  		return -ENODEV;
>  
> -	status = acpi_evaluate_object(handle, obj_name, NULL, &buffer);
> +	status = acpi_evaluate_object_typed(handle, obj_name, NULL, &buffer,
> +						ACPI_TYPE_PACKAGE);
The parameter on the second line should be aligned as:
	status = acpi_evaluate_object_typed(handle, obj_name, NULL, &buffer,
					    ACPI_TYPE_PACKAGE);

Along with being preferred style for kernel code I think it is also the
most common choice in this file.

>  	if (ACPI_FAILURE(status)) {
>  		dev_err(dev, "object %s not found\n", obj_name);
>  		return -ENODEV;
> @@ -131,7 +132,7 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
>  		values[i] = elem->integer.value;
>  	}
>  
> -	kfree(buffer.pointer);
> +	ACPI_FREE(buffer.pointer);
>  
>  	return count;
>  }


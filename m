Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793491014;
	b=ea4+01hYn53cF25HzmrVhv8+d2EiFzDyTS+WCj6WmVxvepnvr9wKCLgRnpkYYxjTShuS
	 89YuA6Q5jVu9rXxNVVZA7MnJzLKDHjZhBhzmI+uXUGGi7NvFJf/TugKYDlUWpz9mUpcoG
	 RmWr2ttxyd1l2n27O1MekKrEORqp/gexygZPsFImpIK93TQ8Q9saizi4TbeOWhOslHIdF
	 bXPXPip5w9e2pHSMOOfdDCgNdHhLF6KEeYnBNyfxvB011lCpW5G04DiZrFweVuJCNhTQm
	 NKiXY10emKvOTAA82GiMxZ403DCb1Z+Akq/VuPMHf13ZZBPsrAuRz5mIQvv7MAVaqIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793491014;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Xp2Q1Tm8g8ofcTkcO3AHq291Sgn2y+s6CdAIBTqEkXc=;
	b=J5I3//6dOWmEjo0kEQ6h6Cujyt0C2FcZkmC3BjfVv0JMx+9kxthhFwu1eWJaIgCAnsPY
	 4yTeQdlHc6IcYCdv9gUrGwv+5te9ev4WRKrimiPMW4m6z7E6qbnZzEu+24oXqy1CT0M3A
	 +u16E+J1C32AklQdoJDIu69zH0pOZV75dpRRb+5BgfVCblOBHphMm0dQz57QAb6s/QlLd
	 Iqhc8ymmWCR0c064S9JwFgA+0jFcnGi8aldjI5gLr0xFX0JB+czWEwEjhH1sKXl7wPZBe
	 115AbBLmDzeHvnR3FezgMlXq2ii3NiYgkOr7wSrn+ttY/tSPZvPiYFYUGyug3ccXerQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2cZtD9r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA3606A31A;
	Sat, 31 Oct 2026 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2cZtD9r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520E61F000C1;
	Sat, 31 Oct 2026 23:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793491013;
	bh=Xp2Q1Tm8g8ofcTkcO3AHq291Sgn2y+s6CdAIBTqEkXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j2cZtD9rhnCcMtqvFQ4MDB+q4EWdGpBtgn3wICyPacsQ20ImCILL6nUsQXT1CPdzu
	 TomMbHR5J+HFo4ExFewTJYIk1OymJw3q4MCPSvk+y2iZjuE9AzuoUzxN0pPI5QC3Hb
	 Nww5IguBza24+VFVnGYIMnUWLpaeVMPq5y3zNEzgb+LDjJ77WkTsSjG6wpXBVA5wpc
	 7sanif2Q4FZkXJ/2aBlwlgewretV+wdO9NImvihhZnEwl5meTut8ivHRp/dHKm5KAR
	 kqnf6vfjAS9ddKtbU9jN7J6wd4YScuS2f5soTeYk7wR52x2n81ibu8Yi5LIrWsP1F/
	 kan2d96hTX4Mw==
Date: Sat, 31 Oct 2026 23:56:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Kevin Tsai <ktsai@capellamicro.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, Nuno Sa
 <nuno.sa@analog.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Hans de
 Goede <hdegoede@redhat.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Tristan Madani
 <tristan@talencesecurity.com>
Subject: Re: [PATCH v3 1/2] iio: light: cm32181: validate ACPI object type
 in cm32181_acpi_get_cpm()
Message-ID: <20261031235644.226c6a9c@jic23-hlaptop>
In-Reply-To: <20261029110829.1086835-2-tristmd@gmail.com>
References: <20261029110829.1086835-1-tristmd@gmail.com>
	<20261029110829.1086835-2-tristmd@gmail.com>
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

On Thu, 29 Oct 2026 11:08:28 +0000
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
The threading is broken here.  They are in reply to previous version
which is always a bad idea and not threaded below the cover letter.

Hopefully I picked up the right code.  Applied, but not rushed
so on the testing branch of iio.git.  These are hardening patches
against broken firmware rather than fixes, so I've also dropped
that marking and the +CC stable.

Hardening this stuff is good to have though when it doesn't
add much complexity like this patch.

Thanks,

Jonathan


> ---
>  drivers/iio/light/cm32181.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 9df85b3999fa8..a16fc83bcbb08 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -115,7 +115,8 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
>  	if (!handle)
>  		return -ENODEV;
>  
> -	status = acpi_evaluate_object(handle, obj_name, NULL, &buffer);
> +	status = acpi_evaluate_object_typed(handle, obj_name, NULL,
> +					    &buffer, ACPI_TYPE_PACKAGE);
>  	if (ACPI_FAILURE(status)) {
>  		dev_err(dev, "object %s not found\n", obj_name);
>  		return -ENODEV;
> @@ -132,7 +133,7 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
>  		values[i] = elem->integer.value;
>  	}
>  
> -	kfree(buffer.pointer);
> +	ACPI_FREE(buffer.pointer);
>  
>  	return count;
>  }


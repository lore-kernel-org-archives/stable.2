Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793063252;
	b=JxzzRGL9uZ51vDBg7m8EJ8yLIJpMLmUjQA641zKqVw3YatYEUoVLAzjqr7i59NWM2OCN
	 3vHsoPIk5wpCoPAvJwF7YYLwsxGln2dy1+x8IVxa7M9KwtQXr8F7Lx0lRv0Prg7tQmAs4
	 gXfV+5tjdhrowqL7q20qAQ2ArKIEF+FPcveYrGIvG0ts4G7XwlNuc37jMd9c2YDs+hcI0
	 F12YqdcK7jlnV+gopDCQIko3dnSMMqIZqPaDMUbGNJXfcI3rOSNlm43Y/Qeqql1sDfl5b
	 VKsLKc+JFPA5V6UsKjYYYAA7Gei35F+JFAiL6nTcuBhJJpbtOD+pA73u4TOXb9HhSwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063252;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=55ArNOBWPhEla2pmzTdRiMih/sZJNSHURRA5JAJ5SX0=;
	b=LOp6Oe9thqhxXRlfop0HTk8FrlwKGgXthXrkKBLyQmsg42k3hk/6XSQXuZwnDMCWZPB8
	 EqMbF8E9G/JA/yI4qZ5/mh5TAGC49nUgN5xW7hOhB+e5Z3CvCX7jpYIxkmd4dnsPw8nop
	 bgASseFpcCV1gTL77CZSbbZdpyqJd9N8YVsG6byL8MSZ8Z5eBrAE3vSNkqxAXkqFSlxjc
	 kAAWvijeF1ac2c5E/77hYn5C90pMa0TVZ20HMhdgTLcDYm3n6X0kvQuQz/uzVA9LVQoBr
	 HTAMNv4GFeMrdQHD9PeHLY7gScDUaLFqh+qZO4UAx4SbN9I688kO7ZqQTmA7/t6EttQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DuXwr2gD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C60606A31A;
	Tue, 27 Oct 2026 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DuXwr2gD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4767C1F01825;
	Tue, 27 Oct 2026 01:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793063251;
	bh=55ArNOBWPhEla2pmzTdRiMih/sZJNSHURRA5JAJ5SX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DuXwr2gDB4QNZILHXgUxV6jz7wgWPyCzNP2EFrOXEjzGOsIWqiQqn3pyUREAYy1YI
	 CqigLyxR5qcL9MbwCrF86tMFi98r6NAZRIAkRtehnYEVGeG/IsojvWY0F8M3rCJlVj
	 UfEi3OTZARSS51y9YK97ijGXDyxM8SASaqDOdUWBEDBoLySeS31lsw8z9RkfRVg0u4
	 q+zkJtA736Kud8KkeCqCEzVpF/m5KvEUBVVEcS40RZSCZRSANU9wZiQz0/bEWczbJA
	 QWcq8wI0gXuksWxb57IGRvJJhBvUyhhMLkDQQ9lpki5co278XIffgc0o3YnqQq6N4k
	 QXMCAa0g21Lhg==
Date: Tue, 27 Oct 2026 01:07:25 +0000
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
Subject: Re: [PATCH v2 2/2] iio: imu: inv_mpu6050: validate ACPI object
 types in asus_acpi_get_sensor_info()
Message-ID: <20261027010725.4fa8ea9b@jic23-hlaptop>
In-Reply-To: <20261026142040.62383-3-tristmd@gmail.com>
References: <20261026142040.62383-1-tristmd@gmail.com>
	<20261026142040.62383-3-tristmd@gmail.com>
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

On Mon, 26 Oct 2026 14:20:39 +0000
Tristan Madani <tristmd@gmail.com> wrote:

> From: Tristan Madani <tristan@talencesecurity.com>
> 
> asus_acpi_get_sensor_info() iterates through a nested ACPI package
> structure without checking types at either level.  The outer object
> returned by acpi_evaluate_object() and each inner element must be
> validated as ACPI_TYPE_PACKAGE before accessing their package.count
> and package.elements members.
> 
> Use acpi_evaluate_object_typed() to validate the outer object type
> at evaluation time.  Add a type check for each inner element before
> accessing its package contents.  Also replace kfree() with
> ACPI_FREE() for the ACPI-allocated buffer.
> 
> Fixes: a35c5d1aa96a ("iio: imu: inv_mpu6050: Create mux clients for ACPI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> index 460792ed27e031..e5ffa0d5f6b1a2 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> @@ -52,7 +52,8 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
>  	union acpi_object *cpm;
>  	int ret;
>  
> -	status = acpi_evaluate_object(adev->handle, "CNF0", NULL, &buffer);
> +	status = acpi_evaluate_object_typed(adev->handle, "CNF0", NULL,
> +						&buffer, ACPI_TYPE_PACKAGE);
Same as previous wrt to indent.  In the kernel style guide
this is only there implicitly in examples, but it is definitely
preferred choice for IIO and I don't recall seeing anywhere in
the kernel where this wasn't an acceptable choice.

Jonathan


>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> @@ -62,6 +63,8 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
>  		int j;
>  
>  		elem = &cpm->package.elements[i];
> +		if (elem->type != ACPI_TYPE_PACKAGE)
> +			continue;
>  		for (j = 0; j < elem->package.count; ++j) {
>  			union acpi_object *sub_elem;
>  
> @@ -78,7 +81,7 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
>  		}
>  	}
>  	ret = cpm->package.count;
> -	kfree(buffer.pointer);
> +	ACPI_FREE(buffer.pointer);
>  
>  	return ret;
>  }


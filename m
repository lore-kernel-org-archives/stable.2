Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966688;
	b=HTq6XtQ18tdVtolnY6Oyxjbj5L2U9RNpUeFbnTEb9BT22Z4XUc52YUmbfi0pzcx0jR/m
	 +t2uQbTmatr5TAHcKPtyls/IMrhUUR3JeshF0L3DL3Qfp2HLQDV2eey7a9L06FTHqI9Rh
	 6dYMU6FKAJ8vIy4KeGS1l++KOX2Wq7tkirS5/SheMhLpjRW+i/lokU446srO9CGGjI4Vg
	 3s4nYqtyFl8Xzl9pDlipaU+4hQXVuQGjnM1linj/N1gHZTn9CglYa5iC9zY11iKrdZiTQ
	 BFwwBY0a0DShTaIi46BWaStGR78mXEbHvtK5UtjTNOtCj7arzi6u9jvj6wbelQHpiXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966688;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MacUxvjp/ZyVsp7L+6WsiqrbR9Yvhn5rX+cxazDxsVc=;
	b=oTHV8zKH2RJnshG8cYvGbOiEgFroj0Tm6XOAt3RlpoD0tRqWVI+SYXxWBq5GPYgGNEpc
	 4HsnSG+iz9XDOJetI0OgjR6XCADVx/4OyA+1WC/tnvIgWpB65Vy7uCbPPIzwdjas07L9O
	 CVxOvT5lD5GUMZVKV3FN7DYxgziBxD9suTxKER8M+j6qFiIlqOer/OoeItCvFoX1lSFgS
	 o/abXf2cuO56qsmaWFYnPnwRvGNWk8ZU5T9dcC+trWoqjD0Ub0snh/gho7PUxddUqIIWE
	 hAkSM5KdZ1qBAEgyA950J00iPH2PmzjiJa6v+f9cXzONnRA4ctSO9GqbqjoBJEMvaDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBm7rv6O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E6F606A31A;
	Sun, 25 Oct 2026 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBm7rv6O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303651F01825;
	Sun, 25 Oct 2026 22:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792966687;
	bh=MacUxvjp/ZyVsp7L+6WsiqrbR9Yvhn5rX+cxazDxsVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dBm7rv6O1X+IGCP1geOO5pKCVTLaWEXmAuw/NVH+7MCusTD6CDCNKNu42Qu3tnYB2
	 6vh79543ojjI+jGbRTtiy8ngfbok3atQBjrMxPiHvsNYh3DMnT8OskEwtLChP4wYla
	 gQwG1Nziuc7oV0GB/eWFw2hjbiebhwE1+yqOni9WnWabIiRon9e5z6L+JSGFzZw5ki
	 OqUD2CHJ6QqOyEVsxsM31m0SA+FrFVivkm2Y1NCo5XRHXYLHvGnROc1yLymwo8+Brl
	 /xJ58aI59IDpcoD9399KVI8ievdqw7iTrvOSXefG4DfRqpYcgay1hl5pDG2Wsr6t+a
	 QqRXXY6ZE15bg==
Date: Sun, 25 Oct 2026 22:18:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: validate ACPI object types
 in asus_acpi_get_sensor_info()
Message-ID: <20261025221801.1dc4a7eb@jic23-hlaptop>
In-Reply-To: <20261025180323.3641477-2-tristan@talencesecurity.com>
References: <20261025180323.3641477-1-tristan@talencesecurity.com>
	<20261025180323.3641477-2-tristan@talencesecurity.com>
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

On Sun, 25 Oct 2026 18:03:23 +0000
Tristan Madani <tristmd@gmail.com> wrote:

> asus_acpi_get_sensor_info() iterates through a nested ACPI package
> structure without checking types at either level.  The outer object
> returned by acpi_evaluate_object() and each inner element must be
> validated as ACPI_TYPE_PACKAGE before accessing their package.count
> and package.elements members.
> 
> Add type checks at both levels of the package iteration.
> 
> Fixes: a35c5d1aa96a ("iio: imu: inv_mpu6050: Create mux clients for ACPI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> index 460792ed27e03..81fe1d96365b4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> @@ -57,11 +57,17 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
>  		return -ENODEV;
>  
>  	cpm = buffer.pointer;
> +	if (cpm->type != ACPI_TYPE_PACKAGE) {
> +		kfree(buffer.pointer);
> +		return -EINVAL;
> +	}

Similar to previous for this one. I think we can just used the
typed call to get it in the first place.

>  	for (i = 0; i < cpm->package.count; ++i) {
>  		union acpi_object *elem;
>  		int j;
>  
>  		elem = &cpm->package.elements[i];
> +		if (elem->type != ACPI_TYPE_PACKAGE)
> +			continue;
>  		for (j = 0; j < elem->package.count; ++j) {
>  			union acpi_object *sub_elem;
Whilst here the ACPI_FREE() thing probably applies as it did
in the previous patch.

Jonathan

>  


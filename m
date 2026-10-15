Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5EB51DAF0;
	Thu, 15 Oct 2026 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065215; cv=pass; b=Y+j7Ktc953lu8x5WHwVSitm3c+hpdAEYRG87ETbt/kUewrTeG4Xw8gXA+U5O7vAHHhz+gcZVtn3iX7Va24CIhW/OEZtfSci4vpgctUH6RD/6l8hXfr5D81uqCoAZSZ9FYVd4lmiU9pPAfp4pWLfshpH+G/efU5aFVDFWwDbdKLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065215; c=relaxed/simple;
	bh=NQvQ/6e+uslrnVXOH+XijZaZFiXfuMx8/pgP42Eq9Tg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KhXKvI6EAzFv+Yd+dPe13FGFVBet/y1tbAC9TyjLmnGqd+K4wyLMQERQrQX3j5wFC72r5ZnRBh1zt71z1rFpaTQ+e/vnZMuPeFzLJCjn/D3RTnG813z2ZwqOHqC0yQVjcJZV8IJ9FMUnlmHqaRVMoDulxAN3pLEfht1Cu6QOuc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=q5serVoS; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="q5serVoS"
ARC-Seal: i=1; a=rsa-sha256; t=1792065190; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a621UlN+ky+70D2tfJEubY3d9ftrtveDYAOOf/CKLwNqV9hnVp+2jT8vIbxhfNFKDuk2uKHUpRJGHxw1s42h8OYEI4HFLGH+c/mJHBiZf4IjP55QFv0labn6jnb8P9YtyGSE1YcBYraKaQfus1Y7x3Pja9U/dB0UQdky18pGkws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792065190; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=d1DBlPPqgYWDBNyBKh78Dl7fk7EpiM062VvlN5DcAho=; 
	b=dK8yCBpZishrA7QP5xCeN1Vaw7b1XBWIWt5ZV8nAMn7htWnEw0xslcqXKcv9JP1FZrQ9S/7YrUJIcehSncfBVzM2MGXAIlU8ardOz88VBkFe+TfS/5m4/7P+0TTO7DoH7dYZyT0z8jI5WPlBJT590bMH26IQCBmpp8R5zKiEwXk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792065190;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=d1DBlPPqgYWDBNyBKh78Dl7fk7EpiM062VvlN5DcAho=;
	b=q5serVoSwNHJsedHFd5bumkyOCUD6/u1bZIYalZXmCPMMgALFEKxmoak5OzKR4GU
	Es3ElIHiXHgYfr8AvE4pO97D7uUqUDaxXhl/oZ8/UT9aR33Bp44jRU2PIltGNEoXTBM
	5Y0Bfc4LsJiUgPdSLIjw/7491GEUsQEwFWlOU8xaAv/+l6INaxc6FvSF9iTqYPOOg54
	jLMWu4yij0ug84EU/puCMJ7M2LezgdqfD/M5hILdIRW+KHhnpYl+JxlOs3meKbTkbrp
	8nPHks9TH4uNk7/Mf6tsNQNyPOL3UwNW0HckbhPLnvSkS2fkHPVoE0cVFaKc3tx4G0D
	HWJSt0pH5Q==
Received: by smtp.zohomail.com with SMTPS id 1792065189744241.5369712250548;
	Thu, 15 Oct 2026 04:53:09 -0700 (PDT)
Message-ID: <6ede627fc8b3745aebfc4ff08079541b7196edb2.camel@rong.moe>
Subject: Re: [PATCH 1/3] ACPI: utils: Add exclusive AML evaluation helpers
From: Rong Zhang <i@rong.moe>
To: Ali Ahmet =?gb2312?Q?Memi=810=946?= <aliamemis@disroot.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>,  Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>,  Hans de Goede
 <johannes.goede@oss.qualcomm.com>, Charis Stratakis
 <c.stratakis@proton.me>, 	linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, 	acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
In-Reply-To: <20261014133013.94097-1-aliamemis@disroot.org>
References: <20261014132703.93355-1-aliamemis@disroot.org>
	 <20261014133013.94097-1-aliamemis@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 19:47:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Ali,

On Wed, 2026-10-14 at 16:30 +0300, Ali Ahmet Memi=C5=9F wrote:
> ACPICA drops the interpreter lock while AML waits, for example around EC
> accesses, so two methods can run interleaved. Some firmware relies on
> methods not interleaving, for instance by switching an EC page selector
> without taking the AML mutex that the other users of that page hold.
>=20
> Add acpi_evaluate_object_exclusive() and acpi_evaluate_integer_exclusive(=
)
> which serialize the evaluation under a global mutex, for callers that are
> known to be affected.
>=20
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>

There should a Link: following the Suggested-by: tag to provide some
context:

Link: https://lore.kernel.org/all/CAJZ5v0gS4agVUkCO6M=3DVW4Wi2y1-s+k23bpzmX=
9aAZ0Rsv4z9Q@mail.gmail.com/

> Cc: stable@vger.kernel.org
> Signed-off-by: Ali Ahmet Memi=C5=9F <aliamemis@disroot.org>
> ---
>  drivers/acpi/utils.c    | 56 +++++++++++++++++++++++++++++++++++++----
>  include/acpi/acpi_bus.h |  8 ++++++
>  2 files changed, 59 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index d499b72574ab..f28680424f14 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -10,6 +10,7 @@
> =20
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
> @@ -243,10 +244,34 @@ acpi_extract_package(union acpi_object *package,
> =20
>  EXPORT_SYMBOL(acpi_extract_package);
> =20
> -acpi_status
> -acpi_evaluate_integer(acpi_handle handle,
> -		      acpi_string pathname,
> -		      struct acpi_object_list *arguments, unsigned long long *data)
> +static DEFINE_MUTEX(acpi_exclusive_eval_lock);
> +
> +/**
> + * acpi_evaluate_object_exclusive - Evaluate an object without interleav=
ing
> + * @handle: ACPI handle of the object or its scope.
> + * @pathname: Path of the object relative to @handle.
> + * @arguments: Arguments to pass, or NULL.
> + * @buffer: Buffer for the return value, or NULL.
> + *
> + * Same as acpi_evaluate_object(), but serialized with other exclusive
> + * evaluations.  Use it only for methods known to break when interleaved=
.
> + */
> +acpi_status acpi_evaluate_object_exclusive(acpi_handle handle,
> +					   acpi_string pathname,
> +					   struct acpi_object_list *arguments,
> +					   struct acpi_buffer *buffer)

A single line can go up to 100 columns when it improves readability.
Reducing line breaks caused by alignment to open parenthesis falls into
the category IMO.

> +{
> +	guard(mutex)(&acpi_exclusive_eval_lock);
> +
> +	return acpi_evaluate_object(handle, pathname, arguments, buffer);
> +}
> +EXPORT_SYMBOL_GPL(acpi_evaluate_object_exclusive);
> +
> +static acpi_status __acpi_evaluate_integer(acpi_handle handle,
> +					   acpi_string pathname,
> +					   struct acpi_object_list *arguments,
> +					   unsigned long long *data,
> +					   bool exclusive)

Ditto.

>  {
>  	acpi_status status =3D AE_OK;
>  	union acpi_object element;
> @@ -257,7 +282,12 @@ acpi_evaluate_integer(acpi_handle handle,
> =20
>  	buffer.length =3D sizeof(union acpi_object);
>  	buffer.pointer =3D &element;
> -	status =3D acpi_evaluate_object(handle, pathname, arguments, &buffer);
> +	if (exclusive)
> +		status =3D acpi_evaluate_object_exclusive(handle, pathname,
> +							arguments, &buffer);

Ditto.

> +	else
> +		status =3D acpi_evaluate_object(handle, pathname, arguments,
> +					      &buffer);

Ditto.

>  	if (ACPI_FAILURE(status)) {
>  		acpi_util_eval_error(handle, pathname, status);
>  		return status;
> @@ -275,8 +305,24 @@ acpi_evaluate_integer(acpi_handle handle,
>  	return AE_OK;
>  }
> =20
> +acpi_status
> +acpi_evaluate_integer(acpi_handle handle,
> +		      acpi_string pathname,
> +		      struct acpi_object_list *arguments, unsigned long long *data)

Ditto.

Since you are anyway moving the existing function, it'd be better to
improve its coding style as well instead of preserving it as is.

> +{
> +	return __acpi_evaluate_integer(handle, pathname, arguments, data, false=
);
> +}
>  EXPORT_SYMBOL(acpi_evaluate_integer);
> =20
> +acpi_status acpi_evaluate_integer_exclusive(acpi_handle handle,
> +					    acpi_string pathname,
> +					    struct acpi_object_list *arguments,
> +					    unsigned long long *data)

Ditto.

> +{
> +	return __acpi_evaluate_integer(handle, pathname, arguments, data, true)=
;
> +}
> +EXPORT_SYMBOL_GPL(acpi_evaluate_integer_exclusive);
> +
>  int acpi_get_local_u64_address(acpi_handle handle, u64 *addr)
>  {
>  	acpi_status status;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index a10a591c18b2..e7a671dba624 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -32,6 +32,14 @@ acpi_status
>  acpi_evaluate_integer(acpi_handle handle,
>  		      acpi_string pathname,
>  		      struct acpi_object_list *arguments, unsigned long long *data);
> +acpi_status acpi_evaluate_object_exclusive(acpi_handle handle,
> +					   acpi_string pathname,
> +					   struct acpi_object_list *arguments,
> +					   struct acpi_buffer *buffer);
> +acpi_status acpi_evaluate_integer_exclusive(acpi_handle handle,
> +					    acpi_string pathname,
> +					    struct acpi_object_list *arguments,
> +					    unsigned long long *data);

Ditto.

With these comments resolved:

   Reviewed-by: Rong Zhang <i@rong.moe>

Thanks,
Rong

>  bool acpi_evaluate_reference(acpi_handle handle, acpi_string pathname,
>  			     struct acpi_object_list *arguments,
>  			     struct acpi_handle_list *list);
>=20
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341263;
	b=aNGJ6O96GdEJjCXNI7Asre4bsZJLFDAJ8QzHpLnlVlnVlsDyVgQ/XidtSDup2rNy3eXv
	 /fxapvNrN8U+4+ER8yx12bNpI8i6bpq6huASVKSwoKtSsdhgp7iTn1ZcLAqkw9HwcXzt6
	 izmQMyprYOz83r65o8JBQKujoU4xWq9AvIj6QYocSxoIcDfZERtLgxtZ28QgXOyy2ukpb
	 3x8t2Y+Ucc35ctKzYqb6rathNEtfAdTWk3MK2EeemEggl7gjAPz7hi8TPsZlQOfGVjDNb
	 qFiYyMAn7rDKjgifRY/jUiJp6diwhf8SqZAjTZC5ytUpMHui2vpCat0DTqVkDr09vXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341263;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=fFSfGgw6bVYeUu0kiLvEaiITNG7sY4O64OeTREfeGfo=;
	b=m8Kc2ytIr1jnNdqnaWHbfZI7StWnhCB3wWXSEaUv0JBKSgszKTNWfMCRpjDScsz7HD4y
	 6f7OW2JvwynPDoL0smnKYjpniULWBKj+NcgGjL/bpAgs9pcfdsErimP63y2jRKcx/VJEo
	 HoY1nbDh/8u05UuzBvBTyOmDdUh+iTtaTJVQQto2MHr3Kt2tXCP3Cz8fRYLobMYAbLnJV
	 c3WFlE0EtPpsbIjC4C+xtAbJ/2aaWgCF5hMGOy+JCfKrpDTDs/+50wcYYVL/eK4HmAtqW
	 /7pmiQVziHKJVjSn3sD5ziMyjPYPEUZtbBvS/hrRudsxY6vaJ+8AFe455XK5gfrkPDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2PAuiZb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683EA606A327;
	Tue, 10 Nov 2026 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2PAuiZb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C381F008A5;
	Tue, 10 Nov 2026 20:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341262;
	bh=fFSfGgw6bVYeUu0kiLvEaiITNG7sY4O64OeTREfeGfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h2PAuiZbL8+C9cFGu0hLkY/GW6LSnwFsQlh72teyZqoevLpXQn9BDXr5lwI6W2S9U
	 oTPN/ufmKJHWcds6dUuuA0Jd+trPON6z/PfR9Y1KfVFLWbP3oX4WFz8J6qpkZe/06+
	 SRmC3dEP0M2Y63yi3A/6GIl5Q1TsPA5akE4xonvE7PWdTQ5QIefsR60dNZ2t8G/E4U
	 +YjEWFgkB3D4cTaLXQAr5DIDR8EGa8+SvKr6hGQtH/iUmLAFkysVFTJ90fPne3SYrO
	 F+gDw62x3g4d4og21o9Ff0IrTVbcKTKLUPM+6lJsW38SZtn/RcSSuxL2AZot1hVl4x
	 jEt3A4OZQ/jHA==
Date: Tue, 10 Nov 2026 22:07:35 +0200
From: Mike Rapoport <rppt@kernel.org>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] ima: fix kexec measurement buffer overflow after failed
 loads
Message-ID: <avN5hyR2V9C_4GPR@kernel.org>
References: <20261108190404.1397829-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261108190404.1397829-2-Jeremy.Jean@oss.cyber.gouv.fr>

On Sun, Nov 08, 2026 at 07:04:04PM +0000, Jérémy Jean wrote:
> When kexec_file_load() fails to install a new image, it can leave the
> global IMA scratch buffer larger than the IMA segment of the current
> image. When that image is executed, ima_update_kexec_buffer() copies
> the larger log past the end of its reserved segment. In a test, KASAN
> reports it as:

...

> Limit the dump to the smaller value between the scratch size and the
> installed image segment size. Update the IMA mapping only after
> machine_kexec_post_load() succeeds.

These are two different bugs and the changelog only explains the first.
The second one is that if machine_kexec_post_load() fails (e.g. -ENOMEM
in trans_pgd on arm64), ima_kexec_buffer is already switched to the
segment of the image that is about to be freed, so the installed image
loses the IMA update and kexec -e writes into freed pages.
Please spell this out, or better split it into a separate patch.

> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -206,11 +206,13 @@ kimage_validate_signature(struct kimage *image)
>  
>  static int kexec_post_load(struct kimage *image, unsigned long flags)
>  {
> +	int ret = machine_kexec_post_load(image);
> +
>  #ifdef CONFIG_IMA_KEXEC
> -	if (!(flags & KEXEC_FILE_ON_CRASH))
> +	if (!ret && !(flags & KEXEC_FILE_ON_CRASH))
>  		ima_kexec_post_load(image);
>  #endif
> -	return machine_kexec_post_load(image);
> +	return ret;

Nit: an early "if (ret) return ret;" reads better than folding the error
into the IMA condition.

> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -98,12 +97,14 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
> +	/* A failed replacement load may have resized the scratch buffer. */
> +	ima_kexec_file.size = min_t(size_t, ima_kexec_file.size, segment_size);

This prevents the overflow, but it treats the symptom at execute time.
The actual problem is that ima_add_kexec_buffer() updates global state
(ima_kexec_file and kexec_segment_size) for an image that may never be
installed.

When the failed load had a smaller measurement list (with staging the
list can shrink), the dump is still truncated to the failed image's
size and the next kernel gets an incomplete log. kexec_segment_size
reported in the "kexec_execute" event is also the failed image's one.

With the first hunk ima_kexec_post_load() runs only for an image that
is going to be installed, so wouldn't it be cleaner to (re)size the
scratch buffer and kexec_segment_size there, from image->ima_buffer_size?
Then the comment you removed would actually become true.

> @@ -239,7 +240,8 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
> -	ret = ima_dump_measurement_list(&buf_size, &buf, kexec_segment_size);
> +	ret = ima_dump_measurement_list(&buf_size, &buf,
> +					kexec_image->ima_buffer_size);

ima_kexec_buffer is not tied to kexec_image. After a successful
kexec_file_load() followed by KEXEC_FILE_UNLOAD or by a successful
kexec_load(), the old image is freed but ima_kexec_buffer still maps its
pages. kexec_image->ima_buffer_size is 0 for a kexec_load() image, so
with this patch the dump fails, but buf_size is still the header size
and memcpy() writes it into freed pages.

That's pre-existing and not a reason to hold this patch, but it's the
same class of bug and I think IMA should check that ima_kexec_buffer
belongs to kexec_image (or drop the mapping when the image is replaced)
rather than rely on sizes matching.

--
Sincerely yours,
Mike.


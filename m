Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587104;
	b=0JLkZVuH7hKtTZ7p7Gj83uqvKtCK9GAtwFhR0zAQd/jS1FFusJzsSODqsxscN2mSRsCx
	 0miRJTBdCPHapyDoYNHUipwwmzlJCeZz/YsndGSZj+idQ+d3z3BXop+C2iKtZgQ8UkoIe
	 4+iPpKvb5g/mZWz1kdMU6o2n7XZ3JfIuoN4z5mNgDOGQY3WERoTjf3J+gIl0uOZUZWEH3
	 wpVyCua95mKlJsM+jlbtF9X9UGxbQ0AfNjEUY9JkbCfjNL3tIR2nENM+qAt3PVIVEY64G
	 1omM7V2LgH4WLPhmol51N2CKck822ItsGVBxs2D5ULCCUulWuekKe8hCga3UdcwXOPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587104;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EdidfY8kkjQXTJZy8RRsiMCtOG0JFSggzZGbgvEUt5E=;
	b=avxlfjAxlIecdudOVvqURXr/1iq6ZWvK1k1H3BYcTbkMPsEGhfwAQzAFXjEVQ+IaGBIL
	 L1S4CvQ1A+LrQVSlOjF/765O2lHLYg40+hVLEaz57y61CFeuFs6ztC/56d6l9veSf7UcN
	 /qKUTcGUXaINwUm2jWCtPHFPufFmmt6jLS1TCmHXFDnphUj0mL4sG0MIeFWGGvGcjd7Vd
	 x6tqIMeSsnaJ4gfFEyz57XHC6xPweI8s17z6FH0n7/p3ceK8DgQwGgQ5wmTd6GyjkMGyx
	 V+jfZompKhOu/iCuox5CCBx3ppcyYa+zzVv6rApmdjib6JZJ4Unns1KNQogxhpDbCoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CT9GYnwQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88201606C577
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CT9GYnwQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668C51F000C6
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587104;
	bh=EdidfY8kkjQXTJZy8RRsiMCtOG0JFSggzZGbgvEUt5E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CT9GYnwQ5xO9mcoj1riTuGCQPREGqLar/U3PU7KFJxrs7Ba1JaVXVcPcVP99bWSrJ
	 NJXdXGNltJx420zg7szplLxYB8CKHlU34K8oZXks7u1ME5eHjb84nz2cEgVUnjZbLN
	 D+bdbZQZowRAiVlP3mzS4YGbKAC3M9bkQJb/XBd0vbYsURe2b22gPCPePo+Wk5rD/z
	 Q7yyHWs0qkusB/L529dssPuv2C7QVwiGuJVqrR177gKxDJF6+EsX/ueVLW0w73lHHm
	 oH1P9JXIoyStLtkoPSfvw9Hs1a+NfgGuY/abq/PLVO9FG0Ixp0T1TL9mQ46fXJ8SIt
	 D+yoCKjurfG1g==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c1479a959aso1297430e87.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:25:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGU4IDieGTKYldZyseu2FlW69tK/51D5DcnvGqu1steD1eHgUAhfLrQ0VwjJP916+Xmq/VFu84=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VVQkZx5VU5xqSTubyl5cUsRVi0gC6DprDYejZJVqLi+U5sVzb
	yajOs7DYWKzouggJteA+JvPODy6gKQ3AZV9qv6C5AFcq6r6lLmLkRZtVQqA/DMa3eYFnZ7in6ze
	7Mvy57n1nmCzDWUBb97AF+iLZVmZznks=
X-Received: by 2002:a05:6512:b08:b0:5bf:b945:2403 with SMTP id
 2adb3069b0e04-5c1709e1278mr1097583e87.44.1794587102823; Fri, 13 Nov 2026
 08:25:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1D6D9530A62ECE64+20261112091935.1394634-1-raoxu@uniontech.com>
In-Reply-To: <1D6D9530A62ECE64+20261112091935.1394634-1-raoxu@uniontech.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 17:24:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ggbq2=1JqA8dc6s=SWcssYxUS_T4EwHEv2gTs21EzhdA@mail.gmail.com>
X-Gm-Features: AclHuK_ZUjaC9RtYeBJy00-Na35nfX1uTFnRYl-LBsandFGPggNV1UpSzgXVJQw
Message-ID: <CAJZ5v0ggbq2=1JqA8dc6s=SWcssYxUS_T4EwHEv2gTs21EzhdA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: property: Do not free embedded subnode packages
To: raoxu <raoxu@uniontech.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shuangpeng Bai <shuangpeng.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 10:19=E2=80=AFAM raoxu <raoxu@uniontech.com> wrote:
>
> From: Xu Rao <raoxu@uniontech.com>
>
> The _DSD data-subnode parser accepts both named-object paths and packages
> embedded in an enclosing evaluation result. For a named-object path,
> acpi_nondev_subnode_ok() evaluates the object into a separate buffer and
> passes its handle to acpi_nondev_subnode_extract(). For an embedded
> package, acpi_add_nondev_subnodes() passes an interior pointer into the
> enclosing result and a NULL handle instead.
>
> acpi_destroy_nondev_subnodes() unconditionally frees dn->data.pointer
> in both cases. Unloading an SSDT with embedded data subnodes therefore
> attempts to free an interior address, as reported by KASAN. Subnodes
> created exclusively from named-object paths do not have this problem.
>
> Only free a subnode's result buffer when dn->handle is non-NULL. Embedded
> packages are owned by the enclosing evaluation result, which is freed
> after its child nodes have been destroyed. Keep the property-container
> and data-node cleanup for both kinds of subnode.
>
> Fixes: 99db5ff7fe0b ("ACPI / property: Hierarchical properties support up=
date")
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> Link: https://lists.openwall.net/linux-kernel/2026/06/05/10
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/acpi/property.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 8ee5a1f0eb48..3a26df35979d 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -664,7 +664,8 @@ static void acpi_destroy_nondev_subnodes(struct list_=
head *list)
>                 acpi_destroy_nondev_subnodes(&dn->data.subnodes);
>                 wait_for_completion(&dn->kobj_done);
>                 list_del(&dn->sibling);
> -               ACPI_FREE((void *)dn->data.pointer);
> +               if (dn->handle)
> +                       ACPI_FREE((void *)dn->data.pointer);
>                 acpi_free_device_properties(&dn->data.properties);
>                 kfree(dn);
>         }
> --

Applied as 7.5 material, thanks!

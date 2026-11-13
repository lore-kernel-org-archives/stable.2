Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586916;
	b=5LxwN7DSLCRw/7smH6mNKA1NKJ8JyxCJhr1SAggaBmzIMpRtOF2LdBdmtgnE5bfz5Am5
	 wt/tD6hRzxtJC8vAh3EqEvY3rhS3sWYK5hf9x416YjGdEtquM33StDTNCZrDf4cKnwUnj
	 nCLQWSsr+0bRV6tymnwqJxP3tUihGPAgntzaIuHueXEdJz4UH9A2/f7ykhNBYiFNVFYwB
	 AkaIf/abVyjc+rgh0GinEco70rYvBEAXf7RD+93iotKzEbs2c/1ZGFyBYznAVBR/12Pxk
	 Hn+RNK1NVVVahqqzrUvc+9qOYKaStpWPZbVmMxNJLVaPniV10mWmWCuIyTfB1X3w4mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586916;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+VKfSuQjy++Fjxy2YGdpBhBllGH+kD5pPYBWRy71ETU=;
	b=01auSKWi6HjbIsdcXlx9AfmDo97wYzL1OBljEmDtGlhws+t0wZzGxckZKEE89uWz8QbC
	 igHAT/oNA8iEDr0n7NAZ21fx8jC+yTVfXGjBxK6+TruKiY7BADULbaKIG8ASJPB9GjbX3
	 XpmZROCJ6zXGiMMHv+wUu+rCFTbpaBSxfR5smS4LzegW3EmTtfwR8KVAnmAP1FGymJ7iV
	 ol6Al/WIuYCHep2/m5HkV1Gelhvs+y2Xelk6TP+OJzYVwnp9khMoDQee6pRulwcl14QBU
	 mv+FDygUY4b9SWCwvouYjhcvMd4Ia2OULD50fs3mzb9Fw1rzzaSnJP8heLIKvxMrFsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQQTNcBv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B334606A334
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQQTNcBv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450EC1F000C5
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586916;
	bh=+VKfSuQjy++Fjxy2YGdpBhBllGH+kD5pPYBWRy71ETU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JQQTNcBvIP11OFjoRGL3VjLTra+mcG38pMOAUB3P85nKQLtjDUSpORrh5C3IqfCw3
	 6UvRZddukcA+Qph0OvWk7DzyQDZoFQTdVcvfcNtAlOLbBIFtLn4xiNCYEumKI89+hq
	 JhM181zObk1qIrHLqYmHJdDQcPYhKVEx5D/nEN+Xzrsz6M6KHMeU3VeeOlzPGScuph
	 4cPV+tMLioCgGVTxiIloluwiP3ugEd2G2aR85pBMzc+bzzyVR9eQ44g3anTXaTfBZX
	 5iD8EPC7N+fdC0E6t8trzgHThqCITOHd0VtdVsxG1wv0V9wwZVfpnhgRftPbXCirlf
	 rq1Z8dVaPnXAw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c1465bbbdaso1415736e87.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:21:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFVgJhSSMI52+SEpO6PX1jpNbmJbP/VXuesk+r3aZU0+ybsK3t3u49Z446iW81uO3TYsE8cVM0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9f34uqS3GGQ9MJuMVMUE/Lx9NCmyHe0tXbG41AGGBeLH6qJ5qG
	3iMGiyA6Kw5oEdqCUHUu7Uj8DC4XGihx7n5F5YRiS6MvNlSZ+agORUqzH7R2tNjM0nGGMLlsH2d
	MAhyQ7XAl5xx0FCACmsUC0t5TDtD85sA=
X-Received: by 2002:ac2:568e:0:b0:5c1:57d3:9f06 with SMTP id
 2adb3069b0e04-5c1709a1294mr1483206e87.31.1794586914722; Fri, 13 Nov 2026
 08:21:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <DC796DD7AB1437C8+20261112090954.1388267-1-raoxu@uniontech.com> <avb-JJur-yeedbFa@kekkonen.localdomain>
In-Reply-To: <avb-JJur-yeedbFa@kekkonen.localdomain>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 17:21:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hZfO01hw14Pf5nKwReJML8yvDuapSng9c=1M57pdxtJg@mail.gmail.com>
X-Gm-Features: AclHuK_bpQyvVno3ZCcHdbx4mFwW-KoXYWd7_RaiAp90jJbXEmy3bYe0rpPvORg
Message-ID: <CAJZ5v0hZfO01hw14Pf5nKwReJML8yvDuapSng9c=1M57pdxtJg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: property: Fix leaked buffers after skipped properties
To: Sakari Ailus <sakari.ailus@linux.intel.com>, raoxu <raoxu@uniontech.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 1:10=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rao,
>
> Thanks for the patch.
>
> On Thu, Nov 12, 2026 at 05:09:54PM +0800, raoxu wrote:
> > From: Xu Rao <raoxu@uniontech.com>
> >
> > acpi_data_add_buffer_props() compacts successfully parsed buffer
> > properties into an output package, but stores their separately allocate=
d
> > evaluation buffers in props->bufs using the original input index.
> > acpi_free_device_properties() only frees entries below the output
> > package's successful-property count.
> >
> > If a property is skipped because of an invalid format, invalid types or
> > a failed object evaluation, later successful entries can be stored past
> > the range visited during cleanup. For example, a failed first entry and
> > a successful second entry leave the allocation in bufs[1] while cleanup
> > only visits bufs[0]. The evaluation buffer is then leaked when the
> > properties are destroyed. Lists with no skipped entries do not exhibit
> > this mismatch.
> >
> > Store each evaluation buffer at the current output count before
> > incrementing it. This keeps the ownership array compact and aligned wit=
h
> > the cleanup bound without changing property order or buffer contents.
> >
> > Fixes: 103e10c69c61 ("ACPI: property: Add support for parsing buffer pr=
operty UUID")
> > Signed-off-by: Xu Rao <raoxu@uniontech.com>
> > Cc: stable@vger.kernel.org
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Applied as 7.5 material, thanks!

> > ---
> >  drivers/acpi/property.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 8ee5a1f0eb48..fb6b214f2335 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -523,7 +523,7 @@ static void acpi_data_add_buffer_props(acpi_handle =
handle,
> >               obj->buffer.length =3D buf_obj->buffer.length;
> >               obj->buffer.pointer =3D buf_obj->buffer.pointer;
> >
> > -             props->bufs[i] =3D buf.pointer;
> > +             props->bufs[*count] =3D buf.pointer;
> >               package++;
> >               (*count)++;
> >       }
>
> --
> Kind regards,
>
> Sakari Ailus

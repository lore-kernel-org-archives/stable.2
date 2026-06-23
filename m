Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16937F8CA;
	Tue, 23 Jun 2026 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246677; cv=none; b=ov5gcm3RaeecqAXLoknDMv5ntO8jlC81UcLNWu/1GXqdumWgvJ4wlicdnhpumP/DpQlwNrgNl+hw5yWMvGeSrLGHH6sdr8PCbo6P5Ud2MC/B897IP91jM/Gd7NUk0Zb37dNqb8vF8N8ktvscnKLRN6z1qCzb78XTUFc4ddta3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246677; c=relaxed/simple;
	bh=6N712Y39fEmI6NUMYBE7Wd9tDVWFwfLyU+lQn2wwGrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H/PPGd7tU7MQqp0L1jlv0n2ofkbgZabEJAZDCxJ3UEiSs17frtd0HyY/qosbBQ1X8fgtt878hpon/QnA/K3IOyr9rzbDnuEnXEpxgMoNXUT9ubLXjpOr09038yZNYiqcu9L4MmGyhfQ5HEbLazV2LJNeNZrpo8ZRCvbRMXFJ81o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FYDxf5WJ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FYDxf5WJ"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 583F640430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1782246675; bh=JHVDemaeJtLGgnzKDvCHVijM1aKm8d9R8FTiQoBvvHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FYDxf5WJZIRgU3yfCLLJ+d8C1vQ21Ony9iMxoN1H0OEe/L24twy9Ozu+Ae+0cVOuV
	 DMvNpMkRC6exA41I1k6LKv0TaY36xemAIBiThHlzb5jgH1agWXKRMIYJ8z3bCzegiC
	 c83Xf5cg8bd6V+QeBBc9Q6eaNvDhwjSBEP+OaH1EPgb7CqEo3DzOosVmlTwlm3qrnE
	 jKdU46X4LVEcQPCXhbkQHFXz1mJz1JiP+nUq5sDgqlbs5mf+JCRR8XHrd2p+ZUvIJp
	 keLzZDgqbtGHTGtRl4HOnJuplqzufpzt30+Ods7p6osodakBW0staa2MZIa3cxHBJL
	 1UBBM1vTrwpuA==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 583F640430;
	Tue, 23 Jun 2026 20:31:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, Mauro Carvalho
 Chehab <mchehab@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: xforms: support __SYSFS_FUNCTION_ALTERNATIVE()
In-Reply-To: <20260623190006.406571-1-rdunlap@infradead.org>
References: <20260623190006.406571-1-rdunlap@infradead.org>
Date: Tue, 23 Jun 2026 14:31:14 -0600
Message-ID: <87qzlxatil.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Randy Dunlap <rdunlap@infradead.org> writes:

> Add support for __SYSFS_FUNCTION_ALTERNATIVE() to create a union of its
> members (as though CONFIG_CFI is unset).
>
> Fixes these docs build warnings:
>
> WARNING: include/linux/device.h:117 Invalid param: __SYSFS_FUNCTION_ALTER=
NATIVE( ssize_t (*show)(struct device *dev, struct device_attribute *attr, =
char *buf)
> WARNING: include/linux/device.h:117 struct member '__SYSFS_FUNCTION_ALTER=
NATIVE( ssize_t (*show' not described in 'device_attribute'
> WARNING: include/linux/device.h:117 Invalid param: __SYSFS_FUNCTION_ALTER=
NATIVE( ssize_t (*store)(struct device *dev, struct device_attribute *attr,=
 const char *buf, size_t count)
> WARNING: include/linux/device.h:117 struct member '__SYSFS_FUNCTION_ALTER=
NATIVE( ssize_t (*store' not described in 'device_attribute'
>
> Fixes: 434506b86a6c ("driver core: Allow the constification of device att=
ributes")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: driver-core@lists.linux.dev
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: stable@vger.kernel.org
>
>  tools/lib/python/kdoc/xforms_lists.py |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20260619.orig/tools/lib/python/kdoc/xforms_lists.py
> +++ linux-next-20260619/tools/lib/python/kdoc/xforms_lists.py
> @@ -49,6 +49,7 @@ class CTransforms:
>          (CMatch("DEFINE_DMA_UNMAP_ADDR"), r"dma_addr_t \1"),
>          (CMatch("DEFINE_DMA_UNMAP_LEN"), r"__u32 \1"),
>          (CMatch("VIRTIO_DECLARE_FEATURES"), r"union { u64 \1; u64 \1_arr=
ay[VIRTIO_FEATURES_U64S]; }"),
> +        (CMatch("__SYSFS_FUNCTION_ALTERNATIVE"), r"union { \1+ }"),
>          (CMatch("__attribute__"), ""),

Applied, thanks.

jon

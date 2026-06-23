Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A535675B;
	Tue, 23 Jun 2026 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245797; cv=none; b=SIOc1I6Hv+6UDXh0QMgpVdv2MC5MGplXQapHevoEtBpdJdB0sYzhLWSSJ1Q3NHX45O8Qf9T2yblxz6jRi5FValIdwNQ9ax/Rzwl3xp9qPCOhHMuMSup2cP20Q037MQJVenlNolliwYndyfY8H5FDRv8kxETpcTv34NqA3lXMs6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245797; c=relaxed/simple;
	bh=FubUEgMsyaWAuCAka3ubhlrWabpeQJjBvAqgM0CJa6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPgwoUMT4j1k24PexDe/g5vcs7+YHCvVRjlkVqY3v72iKSnovDOUW/Vq8w589ikY+ufffRGevVMhh6W/pQP2Hrcy843wUZvf6J6bX2AsexElQQygheUdZVH/TYCt0Y1Tg9dFS6n4i4cKM7/mnsr/yQ3XqfZK5nqcQfCfcpICCS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BWX1rlGw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BWX1rlGw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1782245431;
	bh=FubUEgMsyaWAuCAka3ubhlrWabpeQJjBvAqgM0CJa6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWX1rlGwgc4iHigUNvpCZ8fZEtgjUtYnxjhtuimrXxzJ609vY8EXRXiIcVxnWPrfO
	 YE0r0ktK5uOQ9YaB1XoqbphSs7MxtZk0Iptw2cjMD6WsMPF/PUhKIYsqrAtlY7DdPK
	 auScnAPB4Mmai4YtGaUywW0XZuW8hfNkzGbHX4Pc=
Date: Tue, 23 Jun 2026 22:10:30 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: xforms: support
 __SYSFS_FUNCTION_ALTERNATIVE()
Message-ID: <c38eeede-b5cd-4671-84d7-c0b2d58021a4@t-8ch.de>
References: <20260623190006.406571-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623190006.406571-1-rdunlap@infradead.org>

On 2026-06-23 12:00:04-0700, Randy Dunlap wrote:
> Add support for __SYSFS_FUNCTION_ALTERNATIVE() to create a union of its
> members (as though CONFIG_CFI is unset).
> 
> Fixes these docs build warnings:
> 
> WARNING: include/linux/device.h:117 Invalid param: __SYSFS_FUNCTION_ALTERNATIVE( ssize_t (*show)(struct device *dev, struct device_attribute *attr, char *buf)
> WARNING: include/linux/device.h:117 struct member '__SYSFS_FUNCTION_ALTERNATIVE( ssize_t (*show' not described in 'device_attribute'
> WARNING: include/linux/device.h:117 Invalid param: __SYSFS_FUNCTION_ALTERNATIVE( ssize_t (*store)(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
> WARNING: include/linux/device.h:117 struct member '__SYSFS_FUNCTION_ALTERNATIVE( ssize_t (*store' not described in 'device_attribute'
> 
> Fixes: 434506b86a6c ("driver core: Allow the constification of device attributes")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for the fix. I would have expected 0day to catch this :-(

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
> Cc: Thomas Weißschuh <linux@weissschuh.net>
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
>          (CMatch("VIRTIO_DECLARE_FEATURES"), r"union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }"),
> +        (CMatch("__SYSFS_FUNCTION_ALTERNATIVE"), r"union { \1+ }"),
>          (CMatch("__attribute__"), ""),
>  
>          #

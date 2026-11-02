Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627315;
	b=akcwoUQ0LySeCHo0E0StcX4J4evV7k9BaUFtIyCUAcAPkDkdq/KtNjjNZwphdnCclYID
	 FdBAzXNMkrJ/Vdm18nPjtZFCKqOkNdcrnd/OGCdrcpWIivU/O9Rvo4mMoe6vaP873BpXk
	 QnVckctwn/7rgeFlp21RWSht6otqWMZp7QVmSpbHAu5JYoxKfUcErfmrS5xaX+i1M4eLb
	 /RYwTN0050aUalsi4OGOdDjaLmaJ+t6zyW0u5GBKhw/5bp5ZrrsDi03ruBxxaSGh44S1D
	 R8f9k6yDmk9JLHNPr38xr00XIrNPBiTBNxF2k8jykNhAA0N8aZ35eidT7FMeUzlXSKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627315;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ba3OC82NN/lvsRG6i9lb5qxN6JoglqcW6uXN9iH7vuE=;
	b=4p+RqDPqYpS2r/L4wdLxc7O+aUGDY8orGRTCxkaRwTNf55ej08MVhxifdXF6IEEFDUZE
	 DsnydxuPlzHtxhQSfosr+vI54TjrST/fvlKNRCAfg8qIPICaaJPtyEXti4xRsxIubOo2B
	 tgMV5eGaXLN6tDO19xDbDiTZ4NDjL6jmthzDV0XGcK/OIuOEA/2gIe5aObPPniO7MB8uq
	 bUDc2l/Y84rNQBcwinQojaA8MeQBaAxzfny8Z2VyJEc8I4NptXd3tbiRUKE7IuC7NXbN0
	 /jTYntndV/qQYuDfWiwXFkFyQMd1wlTEzGrOhtw/sCRA/Le8biI2XYAswKAZ4nNqV7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DimkgNb5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D9E5C606A326;
	Mon,  2 Nov 2026 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DimkgNb5
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E108B1F00A16;
	Mon,  2 Nov 2026 13:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793627314;
	bh=Ba3OC82NN/lvsRG6i9lb5qxN6JoglqcW6uXN9iH7vuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DimkgNb5p10enBsmXQ2DwlFYqqwGoRFkvZrk66VAtcC1UVqP/I9qluGDdTwZUVNNS
	 NxN5lA6BT820y0pLWtbn4XeiYSxEHXdit8g6ncWdNY7gr1GWcK5TVwSgnjjrOc+bbe
	 ny6N8D4GxcB8Pf6rTD7sYFPAX5M4uio6DkduyaXpecif0rtNQcimCeJmffVInEDFtK
	 w9BRsG+o6Dqi1HDqmyuUzLntUi/UUlKSq/B1iiL9Hf1dUccRvcP1R0plUUE0vFtuZq
	 miAUSTnvGNO96IvoZ0uIqTWTotKW92SpA9EMzRR71SXkZ3APc39X8lwqk/gfUF+Mz+
	 ZCXsXiLpMcwAA==
Date: Mon, 2 Nov 2026 14:48:27 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] driver core: platform: fix sw node use-after-free on
 device release
Message-ID: <2qx3dvudu7vjotw7t5isaf3sm2becvgqmuu47pwqbrgyfxjvhi@2zybktm7pmp2>
References: <20261102111420.1330760-1-johan@kernel.org>
 <20261102111420.1330760-2-johan@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102111420.1330760-2-johan@kernel.org>

On Mon, Nov 02, 2026 at 12:14:19PM +0100, Johan Hovold wrote:
> When a device has a software node, device_remove_software_node() may
> drop the last reference and free it during platform_device_release().
> And if the software node is the primary node then the device fwnode
> pointer is currently never cleared.
> 
> Use a temporary variable to track whether the primary node is a software
> node to avoid a use-after-free in is_software_node() and having
> fwnode_handle_put() call a function pointer via poisoned or reallocated
> memory when the primary node is a software node.
> 
> This issue was flagged by Sashiko when reviewing a related fix.
> 
> Fixes: 7d80509ff0da ("driver core: platform: unify release path")
> Closes: https://sashiko.dev/#/bug/linux-b860000b-f1d0-46a0-ab52-d47cec8eab99
> Cc: stable@vger.kernel.org	# 7.3
> Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

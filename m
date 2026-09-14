Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E0391849;
	Mon, 14 Sep 2026 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400541; cv=none; b=iy6ITvY205Qa2RNNicz2H+NbVkwvIRGt6lXeEQ7b928wLlQS+Z2yv8L5jdRvyjDy/H6O9KWR0XJbN3OW6muFGNA+bJw3sodr2/sOc3ruC608GL1VpRiM+ih7aT9vMogFa5IlGN1NgebAJK9hxFcOGSKPZw1hKcEYqdH8eArk6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400541; c=relaxed/simple;
	bh=javV2fJjK0oGZxuNzHFVmubotezA0jKkwk57Ow5y78I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LHFnO2dW/7QjOpTv63uNlz7QeKnHZV+3H3macJVT12ywlka8jhTNQJlluYyO6LOmE3+1A9IgugqjBVAKWUiM5Kh3D18I+UrdYrP/2+sV7Kn7bQw/NDuRInJktrvtXzxCbxDIkPUzyHdqgS0InLh6OwpgYvhY3f4zLwbkDcgFBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWnM/b0Y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWnM/b0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789400539; x=1820936539;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=javV2fJjK0oGZxuNzHFVmubotezA0jKkwk57Ow5y78I=;
  b=TWnM/b0Yn8aN6SU/m6pt4M47qWygDoVjmmBB3mFQuSJNxRauaYh8MqLq
   WeH+5iRpVqJSduUFrszQGLS60xRVgaWkWBjlYEwInOYLpRVHJz1bbkxjD
   qVu+j34mb/XLmJKkpOKLHONGvvGkh/Wniz9i2QRJNkMEFbovEqq/fCsib
   kf23fOR64/PFlzYYYPnbCcUTFB6AEsYfh0/ShZQd28Am70pi/zVlMyCFQ
   9WGqnTmNbIVBgpHZTA1T70FIbPJCWd3qU8K+xWr1WU1JyFMBE+KFn7Oaj
   bdAQYqrha3LHo3nWpip0C2aSJojsChyDsZUj+2eoe1CKOpbieM06h6zI/
   A==;
X-CSE-ConnectionGUID: AL1pXwtQTcuvfa37CVCwiA==
X-CSE-MsgGUID: XClifNgVSMWNkxav9+UNZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107266860"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107266860"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 08:42:18 -0700
X-CSE-ConnectionGUID: /0LaOMymQGyqGY8I1zJORg==
X-CSE-MsgGUID: g9edpmfcT0GojJRQJIgUsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="877464"
Received: from spandruv-desk2.jf.intel.com ([10.241.242.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 08:42:18 -0700
Message-ID: <520030eddcdca4950a7f5e42f2d91b75e2f1a675.camel@linux.intel.com>
Subject: Re: [PATCH] iio: accel: kxcjk-1013: disable autosuspend on remove
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= "(The Capable Hub)"	
 <u.kleine-koenig@baylibre.com>, Siratul Islam <email@sirat.me>, Matti
 Vaittinen	 <mazziesaccount@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Mon, 14 Sep 2026 08:42:17 -0700
In-Reply-To: <20260914112053.1686061-1-lgs201920130244@gmail.com>
References: <20260914112053.1686061-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

I generally prefer the first letter after ":" is a capital letter.
That was the case in this driver then some other changes didn't follow
this convention.

If you happen to re-post, fix that.

On Mon, 2026-09-14 at 19:20 +0800, Guangshuo Li wrote:
> kxcjk1013_probe() enables runtime PM autosuspend with
> pm_runtime_use_autosuspend(). The probe error path correctly undoes
> this setting with pm_runtime_dont_use_autosuspend(), but the normal
> remove path only disables runtime PM.
>=20
> The runtime PM API requires pm_runtime_use_autosuspend() to be undone
> with pm_runtime_dont_use_autosuspend() at driver exit unless runtime
> PM
> was enabled with devm_pm_runtime_enable(). Leaving the autosuspend
> flag
> set therefore leaves the runtime PM state incompletely cleaned up
> after
> the driver is unbound.
>=20
> Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> path.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: 124e1b1d0924 ("iio: accel: kxcjk-1013: support runtime pm")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

 Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/iio/accel/kxcjk-1013.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/accel/kxcjk-1013.c
> b/drivers/iio/accel/kxcjk-1013.c
> index 166fb786425f..c6b030f64be1 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1547,6 +1547,7 @@ static void kxcjk1013_remove(struct i2c_client
> *client)
> =C2=A0
> =C2=A0	iio_device_unregister(indio_dev);
> =C2=A0
> +	pm_runtime_dont_use_autosuspend(&client->dev);
> =C2=A0	pm_runtime_disable(&client->dev);
> =C2=A0	pm_runtime_set_suspended(&client->dev);
> =C2=A0

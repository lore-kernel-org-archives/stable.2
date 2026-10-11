Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC81381E86;
	Sun, 11 Oct 2026 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791725161; cv=none; b=IVYXJiXnajkUl1Qv3g+JiO80BdI52DZvF+vq+L9GJGjvbVnEjvRQtDJV30IH56qSaiu3q6+2Ad6mTY2WBWp4qmcdqj1UfpeCWwlOQNtJgaqKqnNLxRx2UGMx6dXeeUwUKzQihqv+1MeD4EyAf1RXEPdxFwdJQepOsSY9fOlvjEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791725161; c=relaxed/simple;
	bh=q4u4xYb3rrulPpFoaAZHYRcV4GVi1DXfLyTqeLrN14g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4WG66N/TIO1Cfsd6xdlwXX3B3wE1HJJekx7dyB4A/4aaJIDk6N3eDgEpx0cSNjGSNngB6KTsFws1rSUbzCiT2MtT919x8OmvyPIOYC2EAKo6cn+CXOgYehm948sCbGEU84uDhDvdljuNApfwsypEcH7HiWhPY3lQfAJgqXBx3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwDLguI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwDLguI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEF91F0089B;
	Sun, 11 Oct 2026 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791725159;
	bh=DV2ix/Ea1kPpWspAgewGjA0T6tS84+dqwFV5LCPnMR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EwDLguI6vsefUIlCGnSrdIcd1Vzcpiy4meHhKRVGwwNELeqJd6r1T4S1LtfDowy0+
	 iQQq963iolVJ4gc2g5I9JtZyeU3IASIjwlO822TCDJQ3LOGNsH0Pkf4/SQGVkaPfL3
	 dX7p3N5I1LmWLVYjohsyXbVQ64MgpDs5EaTBaf38spQ+B1XOOSDn0wu15zRFJfntAk
	 3sThxXcd9KZOJBcln7xmIewFBgPYA56k7w35psPpJozL9jDFrgbMYEyU8P5EfWGexj
	 828pt42yCFJS/lXNoQCMz8kTYX0IIVD7gXsEG4l9Ke4u1iKkol5OkduaZY5kSHVidD
	 vr9qSCb3F6yFw==
Date: Sun, 11 Oct 2026 14:25:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4] iio: pressure: dps310: fix overflow in pressure
 compensation
Message-ID: <20261011142532.71c0a344@jic23-hlaptop>
In-Reply-To: <20261003185716.32732-1-zoone.rupert@gmail.com>
References: <20261003185716.32732-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Oct 2026 21:57:16 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> p^3 * c30 and t * p^2 * c21 overflow s64 at most oversampling ratios,
> and pressure comes out about 150 Pa low on a DPS310 here.
> 
> Use Horner form, dividing by scale factor at each step. Overflow then
> needs a raw value far outside sensor range and returns -EOVERFLOW.
> 
> Checked against datasheet formula at all eight ratios.
> 
> Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260921183132.233136-1-zoone.rupert%40gmail.com
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Dropped v3, applied v4 to the testing branch of iio.git

Thanks

Jonathan

> ---
> v4: -EOVERFLOW for the overflow check (Andy)
> v3: min_t() line left as in mainline (Andy), comment cut to one line
>     https://lore.kernel.org/linux-iio/20261001121616.109973-1-zoone.rupert@gmail.com/
> v2: (s64)BIT(20) instead of BIT_ULL(), min() instead of min_t() (Andy)
>     https://lore.kernel.org/linux-iio/20260930085819.886339-1-zoone.rupert@gmail.com/
> v1: https://lore.kernel.org/linux-iio/20260928101803.547005-1-zoone.rupert@gmail.com/
> 
> Based on iio/togreg, since the buffer series reworked this function.
> Can send a version for fixes-togreg if you prefer.
> 
>  drivers/iio/pressure/dps310.c | 91 ++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 85df58ac1809..1d0b3232db9e 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -19,6 +19,7 @@
>  #include <linux/limits.h>
>  #include <linux/math64.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/regmap.h>
>  #include <linux/unaligned.h>
>  
> @@ -660,72 +661,52 @@ static int dps310_write_raw(struct iio_dev *iio,
>  	}
>  }
>  
> +/* Fixed point one for the compensation fractions */
> +#define DPS310_CALC_ONE		((s64)BIT(20))
> +
> +/* *acc = (*acc + coef) * raw / k, with coef scaled to match *acc */
> +static bool dps310_horner_step(s64 *acc, s32 coef, s64 raw, s64 k)
> +{
> +	s64 prod;
> +
> +	if (check_mul_overflow(*acc + coef * DPS310_CALC_ONE, raw, &prod))
> +		return false;
> +
> +	*acc = div64_s64(prod, k);
> +
> +	return true;
> +}
> +
>  static int dps310_calculate_pressure(struct dps310_data *data, int *val)
>  	__must_hold(&data->lock)
>  {
> -	int i;
> +	s64 p = data->pressure_raw;
> +	s64 t = data->temp_raw;
> +	s64 prs = 0;
> +	s64 tmp = 0;
> +	s64 pressure;
> +	int kp, kt;
>  	int rc;
> -	int kpi;
> -	int kti;
> -	s64 rem = 0ULL;
> -	s64 pressure = 0ULL;
> -	s64 p;
> -	s64 t;
> -	s64 denoms[7];
> -	s64 nums[7];
> -	s64 rems[7];
> -	s64 kp;
> -	s64 kt;
>  
> -	rc = dps310_get_pres_k(data, &kpi);
> +	rc = dps310_get_pres_k(data, &kp);
>  	if (rc)
>  		return rc;
>  
> -	rc = dps310_get_temp_k(data, &kti);
> +	rc = dps310_get_temp_k(data, &kt);
>  	if (rc)
>  		return rc;
>  
> -	kp = (s64)kpi;
> -	kt = (s64)kti;
> -
> -	p = (s64)data->pressure_raw;
> -	t = (s64)data->temp_raw;
> -
> -	/* Section 4.9.1 of the DPS310 spec; algebra'd to avoid underflow */
> -	nums[0] = (s64)data->c00;
> -	denoms[0] = 1LL;
> -	nums[1] = p * (s64)data->c10;
> -	denoms[1] = kp;
> -	nums[2] = p * p * (s64)data->c20;
> -	denoms[2] = kp * kp;
> -	nums[3] = p * p * p * (s64)data->c30;
> -	denoms[3] = kp * kp * kp;
> -	nums[4] = t * (s64)data->c01;
> -	denoms[4] = kt;
> -	nums[5] = t * p * (s64)data->c11;
> -	denoms[5] = kp * kt;
> -	nums[6] = t * p * p * (s64)data->c21;
> -	denoms[6] = kp * kp * kt;
> -
> -	/* Kernel lacks a div64_s64_rem function; denoms are all positive */
> -	for (i = 0; i < 7; ++i) {
> -		u64 irem;
> -
> -		if (nums[i] < 0LL) {
> -			pressure -= div64_u64_rem(-nums[i], denoms[i], &irem);
> -			rems[i] = -irem;
> -		} else {
> -			pressure += div64_u64_rem(nums[i], denoms[i], &irem);
> -			rems[i] = (s64)irem;
> -		}
> -	}
> -
> -	/* Increase precision and calculate the remainder sum */
> -	for (i = 0; i < 7; ++i)
> -		rem += div64_s64((s64)rems[i] * 1000000000LL, denoms[i]);
> -
> -	pressure += div_s64(rem, 1000000000LL);
> -	if (pressure < 0LL)
> +	/* Section 4.9.1 of the DPS310 spec, Horner form to avoid overflow */
> +	if (!dps310_horner_step(&prs, data->c30, p, kp) ||
> +	    !dps310_horner_step(&prs, data->c20, p, kp) ||
> +	    !dps310_horner_step(&prs, data->c10, p, kp) ||
> +	    !dps310_horner_step(&tmp, data->c21, p, kp) ||
> +	    !dps310_horner_step(&tmp, data->c11, p, kp) ||
> +	    !dps310_horner_step(&tmp, data->c01, t, kt))
> +		return -EOVERFLOW;
> +
> +	pressure = data->c00 + div64_s64(prs + tmp, DPS310_CALC_ONE);
> +	if (pressure < 0)
>  		return -ERANGE;
>  
>  	*val = (int)min_t(s64, pressure, INT_MAX);
> 
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68


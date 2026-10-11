Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DBF37FF75;
	Sun, 11 Oct 2026 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791724834; cv=none; b=owsOw7U/M+GjX9l910CYDp359RokVRKiwy+p8n9NmMvqx9MDRCx15BSFgVRbznuCkIyCQCLDRY2Nwqtfs/EYjHMfdWkK0e33x19XQ7TfUbIfx7CIVcEqSwneU36HUMGlebl+vhw68fPCPIv31ZjwJjMt9JV+QYFxdM5SipYMA9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791724834; c=relaxed/simple;
	bh=MEXh0r6rKRtCozat/0TLXmCZ/vNwcI5S/ZEwmwaESAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CG1UzY02rQstsZZLfINCyOOAcChB/C8h0qJtWwm6DUbtujTsUY9HbUREbRTMi3OvcwvN11gXS83d8Ke4AJVDw3vdSKmd6czP0ymRWkfFL0L1nX1NGXVlfAOxUr4yNkrxCRXjp3il0F219C5m9b5NZW63AwX5XOjCwk90W3jNFuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRrv9FEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRrv9FEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BFC1F0089C;
	Sun, 11 Oct 2026 13:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791724833;
	bh=mCUDoIEInLH5axhQXPHfYVpG76/NuG/7bP0dzGRQs1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JRrv9FEFkWYKPYUx8jVEf2mVZelkP3igEKgLPTpaJNke5npG30UhrfBcTIcEM/Rjo
	 LdCP5CiI7WR9E10usYXWkrCjzzQ9tpQORfC6LcNTUWCejuuU7R0Kjaziw7VLn+eRe2
	 A1iJMbvwuAWMXxYJeNPw5jszLxHQ/yL7jUmr++vXdICCjisSjC+ziGUoJee1P0Ml1n
	 FV+Ye2T6fp9PpnV3EWtiIEllMe7GQp3VazhNRi55AhLYmoVx2N5ZdqwAR45l7aviGf
	 zNaP1FerFPwZcKB/sxVdMGredU26xmDGEay3XO3zPdDEael195TYToe8Pts+NfOJr3
	 +3iV0hcdG4MLA==
Date: Sun, 11 Oct 2026 14:14:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] iio: pressure: dps310: fix overflow in pressure
 compensation
Message-ID: <20261011141411.06bf9209@jic23-hlaptop>
In-Reply-To: <20261001121616.109973-1-zoone.rupert@gmail.com>
References: <20261001121616.109973-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Oct 2026 15:16:16 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> p^3 * c30 and t * p^2 * c21 overflow s64 at most oversampling ratios,
> and pressure comes out about 150 Pa low on a DPS310 here.
> 
> Use Horner form, dividing by scale factor at each step. Overflow then
> needs a raw value far outside sensor range and returns -ERANGE.
> 
> Checked against datasheet formula at all eight ratios.
> 
> Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260921183132.233136-1-zoone.rupert%40gmail.com
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
I haven't checked the maths closely but assume you have that well tested
etc.  

> ---
> v3: min_t() line left as in mainline (Andy), comment cut to one line
> v2: (s64)BIT(20) instead of BIT_ULL(), min() instead of min_t() (Andy)
>     https://lore.kernel.org/linux-iio/20260930085819.886339-1-zoone.rupert@gmail.com/
> v1: https://lore.kernel.org/linux-iio/20260928101803.547005-1-zoone.rupert@gmail.com/
> 
> Based on iio/testing, since the buffer series reworked this function.
> Can send a version for fixes-togreg if you prefer.

This is fine.  Ideal would be to then chase the merge upstream of this patch
with a backported version - but always up to the author on whether they do that
work or not.

Applied, to the testing branch of iio.git - though this is more about
the other patches you have on list potentially making things more complex
if I took it through the fixes-togreg branch.

Thanks,

Jonathan

> 
>  drivers/iio/pressure/dps310.c | 89 ++++++++++++++---------------------
>  1 file changed, 35 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 85df58ac1809..2682615b69bb 100644
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
> +	/* Section 4.9.1 of the DPS310 spec, Horner form to avoid overflow */
> +	if (!dps310_horner_step(&prs, data->c30, p, kp) ||
> +	    !dps310_horner_step(&prs, data->c20, p, kp) ||
> +	    !dps310_horner_step(&prs, data->c10, p, kp) ||
> +	    !dps310_horner_step(&tmp, data->c21, p, kp) ||
> +	    !dps310_horner_step(&tmp, data->c11, p, kp) ||
> +	    !dps310_horner_step(&tmp, data->c01, t, kt))
> +		return -ERANGE;
>  
> -	pressure += div_s64(rem, 1000000000LL);
> -	if (pressure < 0LL)
> +	pressure = data->c00 + div64_s64(prs + tmp, DPS310_CALC_ONE);
> +	if (pressure < 0)
>  		return -ERANGE;
>  
>  	*val = (int)min_t(s64, pressure, INT_MAX);
> 
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68


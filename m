Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367102FFF89;
	Thu, 17 Sep 2026 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605981; cv=none; b=ZEsxWVrtUNua/RSId7/tBh2MdsoUQoYUT+V0erIpl3+HBLp9xOG/1Xm4HvRXrKkFISEeEMma5gy70TvJk5jmOHtRPYZ0AuvvFJeYE/ah9sSA9AOBhritYO2acBgnZAawJR3fPODuwIry7u8KPZe5iw1FO3MMznryLpIOBGwb8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605981; c=relaxed/simple;
	bh=iqJYXgEH9qZMvSzZ9xBTGk1/A/W8HLdmT9OV8hVON3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TblwHpoI8CLeu8LBNgdwOboUdtKKjbbpahXbraDmOGt5VleuAdniSEe/AJAnscX6d77myteyh9XMCzN+3O/8TSvz/MmiOynFpzeC4ZT372LZE4g1ZcefGMXlTYecTnnZOfjTDKVKnaSQ3zNShmBJe0vzci+MpQZgBFDaLxDuzw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5WAWCnD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5WAWCnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1011F000FF;
	Thu, 17 Sep 2026 00:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605979;
	bh=kODMTwp9UdPIjAoMzL9lKaKV0Ew12+aWAZOelw7CRbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z5WAWCnD4svSQvzB4lJ+lYh+cI//DC4gsH32lN/lxIUoQobN3bNbDiwVh6TFUdrir
	 POvuuRtP1ruUE7nCjDNPmtzyfMyWT7cwG1J03FZFY2fIiWhGFX/ZG5uX5EVndIDLkm
	 ulUYmxCvUEfV7nG06i0NRjHNUUqqJLY5pjQVRQ6wz9LW6NMj/p7R2b4gt5IoBrYQxz
	 vc/ITFsdDQiu0ZEy+is1T3Qiemwntg0J3LgZkzI2BOA34xFOhqR20/tFtt4Mt2Go04
	 HNvdp5ZL1Pet0v/p5uLRwZH7ltyQwLNcnft/YN9wDUBqZxw01WAd+Xtgv783v5X2wR
	 JWk+pO25j0F2g==
Date: Thu, 17 Sep 2026 01:46:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, William Breathitt Gray
 <wbg@kernel.org>, Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 01/15] counter: rz-mtu3-cnt: put runtime PM on
 initialization error path
Message-ID: <20260917014616.17b5f0f2@jic23-hlaptop>
In-Reply-To: <20260914203614.2035277-2-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260914203614.2035277-1-cosmin-gabriel.tanislav.xa@renesas.com>
	<20260914203614.2035277-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 23:36:00 +0300
Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com> wrote:

> If rz_mtu3_initialize_counter() fails, the runtime PM usage count is not
> decremented.
> 
> rz_mtu3_initialize_counter() will fail if the requested channel is busy.
> 
> Call pm_runtime_put() in the error path to decrement the usage count,
> and flip the check to keep the success path straightforward.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>  drivers/counter/rz-mtu3-cnt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
> index 7bfb6979193c..48f183f0b54f 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -506,8 +506,12 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
>  	if (enable) {
>  		pm_runtime_get_sync(counter->parent);
>  		ret = rz_mtu3_initialize_counter(counter, count->id);
> -		if (ret == 0)
> -			priv->count_is_enabled[count->id] = true;
> +		if (ret) {
> +			pm_runtime_put(counter->parent);
> +			goto exit;

I'd use a guard() for the mutex and return here and one more case
above. Not quite the minimal fix, but will give a more readable result.

> +		}
> +
> +		priv->count_is_enabled[count->id] = true;
>  	} else {
>  		rz_mtu3_terminate_counter(counter, count->id);
>  		priv->count_is_enabled[count->id] = false;


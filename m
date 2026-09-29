Received: from smtpdh19-2.aruba.it (smtpdh19-2.aruba.it [62.149.155.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752383D7D64
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670202; cv=none; b=m0ksqbXJcVchAWazWrFn60U++5PuLEi2a7rMOUSLnaAAjkHqBK2/Ief4OBn3CuzNkoXZRhGblK/d22gIlQ774IlNh58TMbi7Bvr1VsOWv/b+C/3ej0R6YDgj2PK/Qe2wQc1lTvnZDlEa87hSx6ZkqhixHIDHJlK2f4FWMiXVGDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670202; c=relaxed/simple;
	bh=hH6wFHZcqV5QAPROldTmx40Jya4IORDEg+KMnchDpqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHy7CBEtMZ4wgkYJuFK9FDTQH3Gbc7BEb3ig6IN1SiBtrvtrGWHUHXV1O92yYoBeNFBjM66R9duNV/f/A9R1WhYJDy7niF/KftzqaGBQsKIaXtkmg6/MoWAolWP1EFs6tuvhzTslVQXL9wuyR/t29Ok+FC+eixUAb75R0s8Qgbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=Nfhuhoxi; arc=none smtp.client-ip=62.149.155.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="Nfhuhoxi"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id BT4Ixtaiy5bAIBT4Ix9aTM; Tue, 29 Sep 2026 10:20:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790670008; bh=hH6wFHZcqV5QAPROldTmx40Jya4IORDEg+KMnchDpqI=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=NfhuhoxiaQB/Y2Fg2Fz1OmknIdOuooek24KcC+a48CAQlWiwFc5rp3aKkGUxN2g5i
	 Xu3kJN57eX0EkjSADOfWghcXbtW1Vyxy3KElZ0Y3rl7d4f/sPrvlcRB0wiXJICCHqV
	 JUb0fjCNyOT8q7vw9yMGpDW7Y0Mnx7CYZRugtk4UvVVjo8FQMdqu6/zN3TlYosU7+e
	 Ky2SAOPK0L+bep3MV71pK7WRc0y9K0miOXCJO1h3n5azs5zoxup07i5JlhmDFSQ2Ki
	 zwSCBnOL4EtkFdkQHaZQUKZUG7vQ2XcDgh92eiW2Hco2QzdLTxCdIFkn2OFSCHK9jk
	 XgwAFjpSnRUdQ==
Message-ID: <c8eb7663-484d-43c7-8092-280a68ecac0d@enneenne.com>
Date: Tue, 29 Sep 2026 10:20:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pps: generators: don't use the driver's info after
 unregister
Content-Language: en-US
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Calvin Owens <calvin@wbinvd.org>, Yibo Tan <lhfff@tju.edu.cn>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260929022219.212024-1-danishkhateeb03@gmail.com>
 <20260929022219.212024-3-danishkhateeb03@gmail.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20260929022219.212024-3-danishkhateeb03@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFQH/YbabTwp9O6unY4zh0waVgfemXjiMGt4TEBC0Mo7RmL5JYromnZc65EZDNdb7XAhWWKisnI+PWtE4EYvsH/fzRU1acmiU8a/2dQQMuBF8rHb+taX
 21zIP4uub9sVhThY5ZBVJ4bkgGYUVzXswf1G/SpgerFrGhhIqGDON6Fbq9BwUr5xMLWJgwVJ6FyFGTRzHWkNmqSlfohvj+72wMHKQvLbYGdwD84MBTOh/Vjm
 4FpQXdETfzuBo0xLbWrnEEd0Tmjtj/DFGSfV/6LZ86DP0gFTUYewO3+R/P8cv17EQsjpB3gIAElAxI+dqQFhm9lXdr0dZYityFaQ+U5+mwVgCJ0zf7VY6hJe
 xd4uLHCxy/7gmAbLIr9ll6AssmRQNz5k/UHVWE1JCRpzHSg8uGS1ywtfmGFZDDIpk+iV20p9

On Mon, 28 Sep 2026 21:22:19 -0500, Danish Khateeb wrote:
> @@ -212,6 +223,15 @@ static void pps_gen_unregister_cdev(struct pps_gen_device *pps_gen)
>  {
>  	pr_debug("unregistering pps-gen%d\n", pps_gen->id);
>  	cdev_device_del(&pps_gen->cdev, &pps_gen->dev);
> +
> +	/*
> +	 * An open file keeps pps_gen around, but the driver may free info as
> +	 * soon as we return. The sysfs files are gone now, so wait for the
> +	 * ioctls using info and make later ones fail.
> +	 */
> +	scoped_guard(mutex, &pps_gen->info_lock)
> +		pps_gen->info = NULL;
> +
>  	put_device(&pps_gen->dev);
>  }

This closes the window after the unregister, but what about the one
just before it? The two generators in the tree stop their timer before
calling pps_gen_unregister_source(): pps_gen_tio_remove() does
hrtimer_cancel() and pps_tio_disable(), pps_gen_dummy_exit() does
timer_delete_sync(). At that point the file and the sysfs "enable"
attribute are still there, so AFAICS a PPS_GEN_SETENABLE landing in
between re-arms the timer, and nothing stops it again before tio is
freed (or the dummy module goes away).

I don't think the drivers can fix this on their own: if they unregister
first, the TIO timer may call pps_gen_event() on a pps_gen that is
already gone. So I suspect the core has to disable the generator itself
on unregister, once the file and the sysfs are gone and before clearing
info. On top of this patch, something like (untested):

--- a/drivers/pps/generators/pps_gen.c
+++ b/drivers/pps/generators/pps_gen.c
@@ static void pps_gen_unregister_cdev(struct pps_gen_device *pps_gen)
-	scoped_guard(mutex, &pps_gen->info_lock)
+	scoped_guard(mutex, &pps_gen->info_lock) {
+		if (pps_gen->enabled) {
+			pps_gen->info->enable(pps_gen, false);
+			pps_gen->enabled = false;
+		}
  		pps_gen->info = NULL;
+	}

Could you add that as its own patch in this series, and test it with
your unbind/rmmod setup? As a bonus, pps_gen_unregister_source() would
then do what its kernel-doc promises.

Also, a reader sleeping in PPS_GEN_FETCHEVENT is never woken up by the
unregister: after 1/2 it no longer touches freed memory, but it now
sleeps until a signal arrives. Worth a wake-up and an -ENODEV while you
are there?

1/2 looks good to me; I'll ack the whole series once this is sorted
out.

Ciao,

Rodolfo

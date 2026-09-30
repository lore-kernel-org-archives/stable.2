Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320354D37D1
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770396; cv=none; b=gqAgM8qUxNfRYR3X7Yx5OTKTP5Iisskml/ZhKJcOF6lTMsDC0wo2ozGuBB+EgaLEI8jvFXSCCpzl7mDkWgmitx7Nst/ih+GSt6lXkC1oO83/fzh8BGaAHR4BUF15tTiWISu2X9vY2Zg1dpHXdLH2KaRc/ZJzqjvAMKM51q+jtb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770396; c=relaxed/simple;
	bh=Nx9YWV6XI3NauaHHm2JdhBoF5yEbTx/VtF5q9345wlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzpVcfpIcD2SAEaibw+l+sF6XVoMkpJX5SyJNufMrCGgPkx04e/EAw1jejsr6klD2ZSLlFCsXUaND4Fy3mXLUJ7D0Zfg5R4HX09A3hzxVOcC0mpuRMyrx3/ndAhAajCo2PkuZRkyifDCzXKfUcv9uLgersT9gxDIMQk2ZyWulQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=PXjYOmMW; arc=none smtp.client-ip=62.149.156.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="PXjYOmMW"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id Bt8KxwoBsxUh5Bt8KxVwuX; Wed, 30 Sep 2026 14:10:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790770200; bh=Nx9YWV6XI3NauaHHm2JdhBoF5yEbTx/VtF5q9345wlk=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=PXjYOmMW5hnae8Lnk39sVK29qGLuGQVcVJ8au4BYss4iGF/LABcHCAhC/OVAtTQEO
	 ApQ/GXGnYp2sF6quyz9s7p0adtMhmBy1GGOLajgrcIgUNkQXcTJ2PZYQMSCNAq4Xiv
	 pUqUhPCUVXsYHHlSygYsu8pZpjclWBXdTMOqADymCkWIisJzYN1y5nL6zMfCAFbOqT
	 odFEmcU+t3sSTEGkDFCjRInyy8rdIceSfSh5J0mook3JrlgQYv246nKwrzo4kr6Eqc
	 9wMGcqN+Vq+Vt8OiMCnfnbURwqifZwa1+oeoFHhmiTN9tQ7jSrr+LS5uDacwP3NpoY
	 8mqxKP4/77W3w==
Message-ID: <72e36b18-c501-4b54-b415-fb1b73faa463@enneenne.com>
Date: Wed, 30 Sep 2026 14:10:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] pps: generators: stop the generator on unregister
Content-Language: en-US
To: Danish Khateeb <danishkhateeb03@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Calvin Owens <calvin@wbinvd.org>, Yibo Tan <lhfff@tju.edu.cn>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260929124937.51114-1-danishkhateeb03@gmail.com>
 <20260929124937.51114-4-danishkhateeb03@gmail.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20260929124937.51114-4-danishkhateeb03@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHboRSRnK23J/i9rY12IO7cWM+J2f6i1BWkpbGAqxeKCdCrGkCEivYlSS7EbRz9X+ibl8Uzd5JecG4nU4lassT97TnzDzPuchJ5WWDJKA44hwAraXJwu
 47Ru/4l+MyYFg3tRfRVKxi/8Se6Wxdp0IGEbb/nbY4pCabBtyOw31/YF/qQHre32gZp1/6T0YznG2qM5UyNS65Ovhvc4CT0dTjMgf1wM1UJC62nxvxvrgVO0
 OiuyTS//Op+HmKBZAAmS/469MawQmB0mTKJX8/xSx2tOZJ9xnhovKVGrnSfCEMt0n2EqKiVK1Vd2LHtkJmPNmFQ/k1PKJvByQW+WAYFm56RHqaxkyC4k6BSc
 5N+D/oSMGsRTnZsogMQrmJWjq3NaIL+gEA11TqQOJLqb7Bcsw+MMLLDTehNTpw/iVaEfIAI7

On Tue, 29 Sep 2026 07:49:36 -0500, Danish Khateeb wrote:
> Both generator drivers stop their timer and then call
> pps_gen_unregister_source(): pps_gen_tio_remove() cancels its hrtimer
> and disables the TIO, and pps_gen_dummy_exit() deletes its timer. But
> /dev/pps-genN and the sysfs "enable" attribute are still there until
> the unregister, and a PPS_GEN_SETENABLE or a write to "enable" in
> between starts the timer again. Nothing stops it after that: TIO's
> hrtimer keeps running in the devm memory freed by the unbind, and the
> dummy's timer is left in the unloaded module.
>
> The drivers can't avoid this by unregistering first, as TIO's timer
> callback uses pps_gen, which the unregister may free.
>
> Stop the generator in pps_gen_unregister_cdev() instead, under
> info_lock after the device and its sysfs files are gone, when nothing
> can enable it again. pps_gen_unregister_source() then also does what
> its kernel-doc says: "it disables the generator so no pulses are
> generated anymore".
>
> Fixes: 86b525bed275 ("drivers pps: add PPS generators support")
> Cc: stable@vger.kernel.org
> Suggested-by: Rodolfo Giometti <giometti@enneenne.com>
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---
>
> Notes:
>     Tested in the same setup, with patches 1/4 and 2/4 applied. The test
>     driver got a periodic hrtimer in its devm memory, like TIO's, and a
>     remove() that cancels it and then enables the generator again before
>     unregistering, as a PPS_GEN_SETENABLE landing there would. Without this
>     patch the timer keeps running after the unbind:
>     
>       BUG: KASAN: slab-use-after-free in rb_erase+0x174d/0x1a70
>        __remove_hrtimer+0x138/0x450
>        __hrtimer_run_queues+0x2c5/0x7f0
>        hrtimer_interrupt+0x3db/0x910
>       ...
>       Freed by task 175:
>        kfree+0x25a/0x6d0
>        release_nodes+0xd1/0x140
>        devres_release_all+0x10e/0x1a0
>        device_unbind_cleanup+0x71/0x250
>        device_release_driver_internal+0x41b/0x570
>        unbind_store+0xd9/0x100
>     
>     With it, unregister calls enable(false), the timer is stopped, and
>     there are no reports. Unbinding the test driver while enabled, and
>     unloading pps_gen-dummy while its file is open and enabled, are clean
>     too.
>
>  drivers/pps/generators/pps_gen.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pps/generators/pps_gen.c b/drivers/pps/generators/pps_gen.c
> index d80e28dc31dc..452cc12a96f2 100644
> --- a/drivers/pps/generators/pps_gen.c
> +++ b/drivers/pps/generators/pps_gen.c
> @@ -228,9 +228,18 @@ static void pps_gen_unregister_cdev(struct pps_gen_device *pps_gen)
>  	 * An open file keeps pps_gen around, but the driver may free info as
>  	 * soon as we return. The sysfs files are gone now, so wait for the
>  	 * ioctls using info and make later ones fail.
> +	 *
> +	 * The driver may have stopped the generator before calling us, but
> +	 * userspace could have enabled it again since. Nothing can enable it
> +	 * after this point, so stop it here for good.
>  	 */
> -	scoped_guard(mutex, &pps_gen->info_lock)
> +	scoped_guard(mutex, &pps_gen->info_lock) {
> +		if (pps_gen->enabled) {
> +			pps_gen->info->enable(pps_gen, false);
> +			pps_gen->enabled = false;
> +		}
>  		pps_gen->info = NULL;
> +	}
>  
>  	put_device(&pps_gen->dev);
>  }

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

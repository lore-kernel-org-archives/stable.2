Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.203.187.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701329;
	b=ctssuUS0/n4Xboxj20g3T3MxthbLEgJiSYLZQFcISZvHzyv4wGD/7qxNgPzQSrgkimcS
	 tNSIiQk8MWIZ2ofFCHqmxlC4O6hOn5nf4Y5tSvhTyPuxG8fYJdvkvftJUkX3m+oDKAld3
	 Eei4BxJTvIam4N6Q1rpxHqHI6+JKK2FVph8s+IMciq++1iE9L3bF04m7+qQxXhIHRap1F
	 O+RYWOd9/Qga0b6q60exwYwXcfeI2jHuMYp1GAduqYYc1KC1RlIbku0kNmifUtGUcHyNR
	 QlHjNrCaxjvPc6mwa4ZvhX6NcEm4k/BALMeY7KMww4VxxPGmZX3umUkYkxbxTtESaGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701329;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Classification-ID;
	bh=XBGYXyG+q5C5jiAPKuxNdMQjml1qU3QkBoOAjcwWNXQ=;
	b=dr+Cf1mS8asXvKVPRt3jSuqnGk+UZQgbKUBpqGXoBj9Ooux6PLu1cOW/8/n6wRUpU9Vb
	 QSV4seuhLfcY8ZMEKSzuA1xgZE6O3VvSEYsEp8KhZltDdKs3Wn9IvPNxukBSDMAxUSvlY
	 L/EEJKiUzXhnlv9cYj2XoWOIKJ+ZxAkfVVyYvbWDIRXHlKJ4/AjT7JYpYMOJ3EdLBATZg
	 hu9U6ceFw4bB5NY5yvidUCE/9KMFrnzrktbbjDmTaQHNKD9RD38vHV1I2FVZyeNYXevsc
	 Ltktm3jzVQdQSoOEVsAgZsXp75cNJCBN3WCuv2t+TX0ZCvqxhTdeqPSD7tlLUVvzknw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=D6Xow631;
	arc=none smtp.remote-ip=173.203.187.86
Received: from smtp86.iad3a.emailsrvr.com (smtp86.iad3a.emailsrvr.com [173.203.187.86])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD40606D82F
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD40606D82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=D6Xow631
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1793701317;
	bh=6BGIec/cDOqNiNea/OamAjX1uzgN4KXehG99Ixpwcb4=;
	h=Date:Subject:To:From:From;
	b=D6Xow631lGGCqpqeV+mIuHuV+IPC3l9DntGOIP54kZeLvDkodLu+gbL8jrmQBCBE5
	 tjXf3JiUlGfGc2DZ8gsO+ReNHE7falFxpr60V1FpTD0JO5Gnz4+e3rXkpRNWdIDS9b
	 7360G9xhmfG9eZkrXqsjZwAR38GE3OPdfEoRiwIE=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp19.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 0AF0756BA;
	Tue,  3 Nov 2026 05:21:56 -0500 (EST)
Message-ID: <64edfb9a-183a-4719-831e-c771c6eec559@mev.co.uk>
Date: Tue, 3 Nov 2026 10:21:56 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: comedi_bond: Track opened devices independently
 of subdevices
To: Wentao Liang <vulab@iscas.ac.cn>, hsweeten@visionengravers.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261103063301.1025860-1-vulab@iscas.ac.cn>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20261103063301.1025860-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 53a150ee-45cb-4729-9aad-4a6ced7252d4-1-1

On 03/11/2026 06:33, Wentao Liang wrote:
> bonding_detach() closes devices by walking the bonded subdevice array.
> If a device has no digital I/O subdevices, do_dev_config() never adds it
> to that array. Its open reference is then lost. The same happens if
> configuration fails before the first subdevice entry for a device has
> been added, for example when allocating that entry fails.
> 
> Keep the device returned by each successful comedi_open_from() in a
> separate array indexed by the configuration option. Close those devices
> on detach, including attach failure cleanup. This also removes the need
> to deduplicate closes for devices with multiple bonded subdevices.
> 
> Fixes: 3cf840f65ad5 ("Staging: comedi: add comedi_bond driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/comedi/drivers/comedi_bond.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/comedi_bond.c b/drivers/comedi/drivers/comedi_bond.c
> index a10cfbd04c72..ac8937550ce9 100644
> --- a/drivers/comedi/drivers/comedi_bond.c
> +++ b/drivers/comedi/drivers/comedi_bond.c
> @@ -55,6 +55,7 @@ struct bonded_device {
>   struct comedi_bond_private {
>   	char name[256];
>   	struct bonded_device **devs;
> +	struct comedi_device *opened_devs[COMEDI_NDEVCONFOPTS];
>   	unsigned int ndevs;
>   	unsigned int nchans;
>   };
> @@ -215,6 +216,8 @@ static int do_dev_config(struct comedi_device *dev, struct comedi_devconfig *it)
>   			return -ENODEV;
>   		}
>   
> +		devpriv->opened_devs[i] = d;
> +
>   		/* Do DIO, as that's all we support now.. */
>   		while ((sdev = comedi_find_subdevice_by_type(d, COMEDI_SUBD_DIO,
>   							     sdev + 1)) > -1) {
> @@ -312,24 +315,28 @@ static int bonding_attach(struct comedi_device *dev,
>   static void bonding_detach(struct comedi_device *dev)
>   {
>   	struct comedi_bond_private *devpriv = dev->private;
> +	unsigned int i;
>   
> -	if (devpriv && devpriv->devs) {
> -		DECLARE_BITMAP(devs_closed, COMEDI_NUM_BOARD_MINORS);
> +	if (!devpriv)
> +		return;
>   
> -		memset(&devs_closed, 0, sizeof(devs_closed));
> +	if (devpriv->devs) {
>   		while (devpriv->ndevs--) {
>   			struct bonded_device *bdev;
>   
>   			bdev = devpriv->devs[devpriv->ndevs];
>   			if (!bdev)
>   				continue;
> -			if (!test_and_set_bit(bdev->minor, devs_closed))
> -				comedi_close_from(bdev->dev, dev->minor);
>   			kfree(bdev);
>   		}
>   		kfree(devpriv->devs);
>   		devpriv->devs = NULL;
>   	}
> +
> +	for (i = 0; i < ARRAY_SIZE(devpriv->opened_devs); i++) {
> +		if (devpriv->opened_devs[i])
> +			comedi_close_from(devpriv->opened_devs[i], dev->minor);
> +	}
>   }
>   
>   static struct comedi_driver bonding_driver = {

The problem with the lost open references could also be fixed without 
adding extra storage for an array in struct comedi_bond_private by 
calling comedi_close_from(d, dev->minor) from bonding_attach() if the 
device opened by comedi_open_from() does not have a suitable subdevice, 
or an error is found in the inner 'while' loop.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

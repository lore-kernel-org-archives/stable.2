Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8168A23393B;
	Sun, 12 Jul 2026 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783892827; cv=none; b=YZ4e23jOBYOYAtrYX6zdZNyH3xLGKYiLX1xP7mD3N8Fp+zzZDE3GJw3jm+4Wp32EGMG8zKkc1NUlsnkkHm73U6zos57PbOpmzZyTGulYLchqRP7iYNIEhNTOz40ygw2f7K8/mTqkCFLy0UP5DTHr3ji5C8sUNdgOAIq3laeckq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783892827; c=relaxed/simple;
	bh=DZyAZSW0M1Jb4tky+YqpCy22LbXPgZrCd3S2OOGG1OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doQVk/v4iWh/h9vVT0Vde2ylZmLyim7wf9d/NhkJSd5hbTIKYIezFLlWb0xXQIs/mIiDLcI+n5mNnKPDHDVmH6wyxnSlpK6cNVrjvGCMFFpxJz7gSvC6N/z8jrfWAFtCvTpa/GXm/U5GEKLIWAJXAcGf0yXpqfR2bK1ByGWP7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.225] (p5b13aff1.dip0.t-ipconnect.de [91.19.175.241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0B60D4C2C37F00;
	Sun, 12 Jul 2026 23:46:50 +0200 (CEST)
Message-ID: <b4a2c370-382d-432b-ab00-b9a198288345@molgen.mpg.de>
Date: Sun, 12 Jul 2026 23:46:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btrtl: validate firmware patch bounds
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260710172503.64964-1-acharyalaxman8848@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260710172503.64964-1-acharyalaxman8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Laxman,


Thank you for your patch.

Am 10.07.26 um 19:25 schrieb Laxman Acharya Padhya:
> rtlbt_parse_firmware() copies patch_length - 4 bytes before appending the
> firmware version. A malformed firmware patch shorter than the version field
> can make this subtraction underflow and turn the copy into an oversized
> read and write during Bluetooth setup.
> 
> The existing patch_offset + patch_length check can also wrap on 32-bit
> architectures. Validate the patch length and range without arithmetic
> overflow before allocating or copying the patch.

This improvement (second paragraph) is not part of the summary/title. 
Maybe two commits would help.

> Fixes: db33c77dddc2 ("Bluetooth: btrtl: Create separate module for Realtek BT driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
> ---
>   drivers/bluetooth/btrtl.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 49ecb18fea45..7f54d2d2d13a 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -797,8 +797,9 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
>   	}
>   
>   	BT_DBG("length=%x offset=%x index %d", patch_length, patch_offset, i);

Unrelated, but btrtl_dev->fw_len should probably also be logged above.

> -	min_size = patch_offset + patch_length;
> -	if (btrtl_dev->fw_len < min_size)
> +	if (patch_length < sizeof(epatch_info->fw_version) ||
> +	    patch_offset > btrtl_dev->fw_len ||
> +	    patch_length > btrtl_dev->fw_len - patch_offset)
>   		return -EINVAL;
>   
>   	/* Copy the firmware into a new buffer and write the version at

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

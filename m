Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005B43D333E;
	Tue, 29 Sep 2026 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692917; cv=none; b=t9tfGtoES2zyFzYGhmcR5yuBAME1PE0UI72tGpmULFk7h4+SE62i8Sdcpiw/6Qymm0sS7lFxT26ahXA7ime2HVSM9fy4QKMhcF8Dw8b5hjPpRsFzHPQS8ZXe79D6ho6K0FagVwpaHwAcZHzSqmymri5ikqQGMr3AcTsnyY9tKD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692917; c=relaxed/simple;
	bh=+c3JSCNRlVf7GQPvxqGKsXim9O25iUlh6rMym0DW97o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAChzImHCVR3wIMHOb0IrFCedKZid1jzRkHmHJH84h0n+WAYNkLCLVW14RORzweQfTyxi75Wcipe3Nv3w81NoxP1RUHEvioRF11vPjlcqmWT+VP7jbeM2nlKlcKDpjtIRVotVMHrY21kzEbTnpU7gdRT+7xjFGdrKhazajN7qXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAihl2lP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAihl2lP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16971F000FF;
	Tue, 29 Sep 2026 14:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790692911;
	bh=mEp1E5ZkpK+YzCmL02lu7CoOG9w1iP9j8LGhTzBnrFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RAihl2lPJAPALLEiZiOTDo5TmUZMn/dNqVYiqoKmJ2RSToc0qIyUA21ncx/34uvLD
	 dqqAxt1NwPkguSDbELCnMEFR9RGbll8biNSxSrzRbp1jI1apw08QM1ZgFf4BvUSlly
	 B3Iio7hQeb6nCDDun5Rn5LCH5FABx336HT+Mm+PfN9vKna9v7xE9Y6v9OFqgWKPSqc
	 yYA92i6rLhepYXAOl7GeQ1AMnoSBtO9sTrHa9AQ2W6v1EKGnOn8fg984Y5Xy6mSutV
	 52E3HRLtkOM//b4Y3kaRoyvLL4/LmIcaaCE0OQwlZSIbiF4oCqkkMF2x9yGw/ClBu2
	 TaCj/o2lGxbvw==
Message-ID: <f6587a8e-b744-4be9-89d9-dc7079e97e22@kernel.org>
Date: Tue, 29 Sep 2026 16:41:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: uvcvideo: fix output terminal type check for ID
 namespace
To: raoxu <raoxu@uniontech.com>, laurent.pinchart@ideasonboard.com
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <ABE1FC11603F6BBE+20260810091624.2159038-1-raoxu@uniontech.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <ABE1FC11603F6BBE+20260810091624.2159038-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10-Aug-26 11:16, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> Commit 3d9f32e02c2e ("media: uvcvideo: Create an ID namespace for
> streaming output terminals") added a separate internal ID namespace for
> streaming output terminals.  The namespace is only valid for those
> terminals because their descriptor IDs are used by streaming interface
> bTerminalLink fields, and uvc_stream_for_terminal() intentionally masks
> the internal namespace bit when matching that link.
> 
> The parser currently decides whether to use the namespace with
> `type & UVC_TT_STREAMING`.  Terminal types are values, not bitmasks.
> Since UVC_TT_STREAMING is 0x0101, standard non-streaming output terminal
> types such as UVC_OTT_VENDOR_SPECIFIC, UVC_OTT_DISPLAY and
> UVC_OTT_MEDIA_TRANSPORT_OUTPUT also make the test true through their
> 0x0100 bits.
> 
> Those terminals can then receive an internal ID that differs from their
> descriptor ID even though normal UVC descriptor references still use the
> 8-bit descriptor ID.  This can make later entity lookups fail or hide an
> entity ID collision that should be handled as a regular UVC descriptor
> collision.
> 
> Use an equality check so that only UVC_TT_STREAMING output terminals
> enter the separate namespace.  The issue was easy to miss because real
> streaming output terminals make both the bitwise and equality tests true,
> so the devices targeted by the original change keep working.
> 
> Fixes: 3d9f32e02c2e ("media: uvcvideo: Create an ID namespace for streaming output terminals")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Thank you for your patch.

I have merged this into:

https://gitlab.freedesktop.org/linux-media/users/uvc/-/commits/for-next/

Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index e289cc71ba98..acfc5797a1c2 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1130,7 +1130,7 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
>  		 * so limit usage of this separate namespace to streaming output
>  		 * terminals.
>  		 */
> -		if (type & UVC_TT_STREAMING)
> +		if (type == UVC_TT_STREAMING)
>  			id |= UVC_TERM_OUTPUT;
> 
>  		term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
> --
> 2.50.1


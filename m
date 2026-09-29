Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CEB5437FB;
	Tue, 29 Sep 2026 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695203; cv=none; b=WiGybfhc7eFprX5F1vOCVfTyaLdXM4Ie0x/B1Wc2WQFR+sFncfLah2g5BFVQ/5cMuR3RSnpkrnneYtwdAo4APErYSr2yK6LBY1Y3UloNs4VBs6TxdryuwkWx8cK8/FANUupwZSfzm8LkZvaJywhOjTDj1Ct6qmwk3njrWCQrhSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695203; c=relaxed/simple;
	bh=aLi8VgUny7UmDhFV817x0I7gfsW1LYDeKDGG9bLdeik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sg9R36J6brIPTWUYEaerHPEVRvjIURP5OOkxiZwvuQ9GLACz+liv8bUNfQeOCnttYT1OAFo4z3j9hXqTT+NzpeNtDSKvPfx8I1/SeN7iCKTKJY51NEv27tMMHpi7sAisrmL7uQteQDY4QezYbuBPt1pUeNDIcxTY4SCjoR10xIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1ig8QZy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1ig8QZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277831F000FF;
	Tue, 29 Sep 2026 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790695190;
	bh=ul9re86qiAEUEGC0C+NImqJjR2X6/U1CIeqjrhshSCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=m1ig8QZyNJJK5va/cqGiJJgsu+Pi3wUGBJvBzwEVvagMpW4kteBA/Ojk1YJEuLbrj
	 vHayCxDIq7nTsZscV9pXE1MBhKdXh0GW4ADijnkxCh+1fizEExvvbe0NYzn+Kar2dy
	 90JoXjp/+Kcrq0L+cEuM3mxfuehRpv5RcsPKstj/MGvBFoyBCS9rso1iHoxRicHYV9
	 OT5QW+CxdDgVA9Yemv69KufS3CJjTsmX5H2mQZ6Axr8hMUz857155n9CDCR7xhMjFz
	 zhm36HbhlDzW525sUk2Mu+Zsa4ND6Kgk8JrdRug/edxYWJ9fH4mWjqyqKNjKmm/2ky
	 7FDvDPISG6gTA==
Message-ID: <35ccb0c5-430a-430b-a4cd-3a53befec028@kernel.org>
Date: Tue, 29 Sep 2026 17:19:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] media: uvcvideo: Automatically handle invalid
 uvc_versions
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Edwin Gatier <edwin.gatier@protonmail.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>, stable@vger.kernel.org
References: <20260928-uvc-version-v4-0-da0e983fcb95@chromium.org>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260928-uvc-version-v4-0-da0e983fcb95@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 28-Sep-26 16:31, Ricardo Ribalda wrote:
> This series changes the way we handle invalid uvc_versions. Instead of
> just failing it will try to continue probing.
> 
> Now that we are at it fix the way we handle device warnings.
> 
> Thanks!
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thank you for your patch.

I have merged patches 1 2 and 5 into

https://gitlab.freedesktop.org/linux-media/users/uvc/-/commits/for-next/

I've held off on merging patches 3 and 4 for now because of the ongoing
discussion about those.

Regards,

Hans


> ---
> Changes in v4:
> - Handle invalid dwMaxVideoFrameSize.
> - ctrl_size -> video_ctrl_size
> - CTRL_SIZE->VERSION
> - Link to v3: https://lore.kernel.org/r/20260911-uvc-version-v3-0-604328d8a0dd@chromium.org
> 
> Changes in v3:
> - Move uvc_video_ctrl_size to uvc_video_init()
> - Fixes for uvc_warn_once
> - Remove bmVideoStandardParsing parsing
> - Link to v2: https://lore.kernel.org/r/20260911-uvc-version-v2-0-395f27b0444c@chromium.org
> 
> Changes in v2:
> - Add quirk for Avermedia
> - Change the way the compliance error message is printed and cache
>   ctrl_size
> - Link to v1: https://lore.kernel.org/r/20260907-uvc-version-v1-1-34e45dfe04de@chromium.org
> 
> ---
> Ricardo Ribalda (5):
>       media: uvcvideo: uvc_warn should warn not info
>       media: uvcvideo: Use uvc_warn_once when it make sense
>       media: uvcvideo: Automatically handle cameras with invalid uvc_version
>       media: uvcvideo: Do not parse bmVideoStandards
>       media: uvcvideo: Force UVC version for Avermedia GC515
> 
>  drivers/media/usb/uvc/uvc_driver.c | 17 ++++++++----
>  drivers/media/usb/uvc/uvc_video.c  | 56 ++++++++++++++++++++++++--------------
>  drivers/media/usb/uvc/uvcvideo.h   |  6 ++--
>  3 files changed, 52 insertions(+), 27 deletions(-)
> ---
> base-commit: 58348f64125e9a3e44d3abb275ca7f4e6c9641e5
> change-id: 20260907-uvc-version-aedefc4384ce
> 
> Best regards,


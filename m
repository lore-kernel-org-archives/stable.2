Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37212CDA5
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788095809; cv=none; b=ZgvwkCHR+19YhZcYu5VB4N0qdhBqggufKXoygvTG2QP2rZ6U+1dmqxQPO6GJas5rxLBOMc7xyc90MKG4LhxgaYHz/VAOs6mr1tz/nHoD8CZXsypp48lO9DVGS/v26ARkpymZaolQAuRw9n1fWu6DrFkUZUfuVhsSME+GRp+X2D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788095809; c=relaxed/simple;
	bh=5rfPCwxFWMkLClEWi4NYbbz1jCx27ILddopJupAIldk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d48wSVSDh2pzULdVU1qRBtn9BmSKyc8DTj3cH4NgoYo4hQDSyxAOM9i/S6THQE/4Y4nwYXmt5yGgHprmrBbRA2HxI09mMsmoq+1q+qhFMiozSuLTDELEkjtym6rUWu34VLc2A73VopzSD8kt8p+DspVHtPtKtWdwMexRfHth7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIJNS8Ct; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIJNS8Ct"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-482e5733a5aso1521168f8f.0
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788095806; x=1788700606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icNPW3M/3H+DC/HtcIMTV1PUotNQMztTpBOHBNJ960w=;
        b=gIJNS8CtACWzetGti2ErcSJIo2QvFjY8jfze1Y6sKyZz8wRdPirw/ZwB6knys0rrKB
         XsxhmyDNukJoIGD8yBtVl8uGqbrlplR7MkBRdJQCwx6A8eIL0kkcJUAfQxpx8O2hfmgV
         546t4SlB4MH73hKipMyBJMW4y0iaqvs5jdS27tViKOnF7xEVj5LqSAjoix0iT2QZSJht
         1c0uTa1ld2tASj3MTbhoPPUbHzksbDUadhUCV1fr5X4E8FpY2a/BDgGrf5cozOFKyfYd
         sRTBUAGnNRgQ7cQ1+u19eyD6vJIvUT6At7pNkb4+VY55RNUY+Ip4gaW3XVACp4KuF5jA
         HT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788095806; x=1788700606;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icNPW3M/3H+DC/HtcIMTV1PUotNQMztTpBOHBNJ960w=;
        b=nbpk9HjGix4G12efSNqOfwugmK1Ka7Qxi1ozqRLvv5C5JpOTLxYVXq3E7FwL20Z+Oh
         mMO3RUdRx75IZTq+D5F709yANDrQ9SpEvcbqxxBWoOXMeYWEiDWiT6KpzpgKh60DJxAH
         xWZLFlX8mWyG5lCIfYnzAzz+1PYEgkR/A/JTQRo0frXsEXEqH8K9sea2Xz3dlIc8kr2y
         p+sMDCRQQBsNOHQYUVIG24gvLfM0gDeKTDpTxt5oGROgrAvc5xzI9U/qUvxjAFk3c1Mw
         7ws6bl5IJf7QpdZiPLaKPRYkq0lhSe1QxAM1sEL6Jk2OLEF19iz6l446iAshQqpraZgD
         /PeA==
X-Forwarded-Encrypted: i=1; AHgh+RpGTboHpR5TEUQftaIOrXiS4dTDeKQ0cu6WanYt17r9LcYotj47SXrNeW2qyFrUBrPfInYC9bE=@vger.kernel.org
X-Gm-Message-State: AFuF++nYCj03aZBRH5lz71xb3vzZWE+8/ewptK5p8krnpAN/P2poXOZ4
	RDPWSzCjPWVjXz01MLt5KLuC7tqqxCb0uLE+TUZQGDTI004B0dlWMvlp
X-Gm-Gg: AR+sD1316n0liicazMV4kgKUPWmnuBXgxbR/YPngtFBr+4UCTMiqgl0LPpT2D0ib8uZ
	bopogi1cQPMZr2DEqGRwSzzN4UO9JXtD6Q0/anGgUQmQukIiKzGdJ8NfAOQQzgMC8i5T+JubuSO
	RkwMpYdv+J/hVIa6edvdPnbc4QnXjXv5Oo00h1LyQTTzd0BcSviF5pvib08mSEqeT8X1QzKD+ty
	v6/6BlmoKWHcmlMk9VXI5N8Xcb3IgPDomUwwF81arn9kVf3kyu0ZJ/RlAzdJih9cWnhTYGEumJp
	zfbCkCp+kCWuBsN9VmqLOIXxIjEHbsa91xdJbsS61jHCHHIsRfXQIylwrIJdH7Q76NDiBw9v/iN
	Fv617sT/Duek/i4b/4oxMuniMiNdXOvwzomHYbtz249T3iBLHyfLuOZBnCbJOFT81AAmZ26Umvk
	YnrGXYFhywmVEKZ817WB09wu49CCzylOEUI0Z0gFP+w/XMQWm4MZcwxBWvAecJXzLN1kfNNaDg9
	lNzyTu40m7U5tG2SPcY34aJpBMRLfdkV55i3r+oHqGjieNx3AdtE/lpCNhR8uieCbim
X-Received: by 2002:a05:600c:8106:b0:49b:9161:db26 with SMTP id 5b1f17b1804b1-49b91c5554bmr301653875e9.14.1788095806010;
        Sun, 30 Aug 2026 06:16:46 -0700 (PDT)
Received: from shift.daheim (p200300d5ff3cee0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff3c:ee00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b926874fdsm208362965e9.4.2026.08.30.06.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 06:16:45 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.100)
	(envelope-from <chunkeey@gmail.com>)
	id 1x0fNx-00000001Jrt-2is5;
	Sun, 30 Aug 2026 15:16:44 +0200
Message-ID: <aa32505d-f756-40d2-88bb-cd31470f4eb3@gmail.com>
Date: Sun, 30 Aug 2026 15:16:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: p54: validate curve data length in
 p54_parse_eeprom()
To: Shengzhuo Wei <me@cherr.cc>, Christian Lamparter
 <chunkeey@googlemail.com>, Michael Wu <flamingice@sourmilk.net>,
 "John W. Linville" <linville@tuxdriver.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260827-p54-pda-validation-v1-0-bdc2b0675056@cherr.cc>
 <20260827-p54-pda-validation-v1-1-bdc2b0675056@cherr.cc>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20260827-p54-pda-validation-v1-1-bdc2b0675056@cherr.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/26/26 7:07 PM, Shengzhuo Wei wrote:
> p54_convert_rev0() and p54_convert_rev1() walk
> channels * (2 + points_per_channel * sizeof(sample)) bytes of the
> curve data entry, with both counts taken verbatim from the
> device-supplied EEPROM. An entry that declares channels=255,
> points_per_channel=255 but carries only the 4-byte header drives a
> ~191 KB slab-out-of-bounds read past the EEPROM buffer (verified with
> a KASAN reproducer of the conversion loop). The sibling converters
> p54_convert_output_limits() and p54_convert_db() already validate
> their counts against the entry length; this path was missed.
> 
> Reject the entry when the counts do not fit in the entry data.
> 
> Fixes: eff1a59c48e3 ("[P54]: add mac80211-based driver for prism54 softmac hardware")
> Cc: stable@vger.kernel.org
> Assisted-by: GLM:5.3
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
>   drivers/net/wireless/intersil/p54/eeprom.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/wireless/intersil/p54/eeprom.c b/drivers/net/wireless/intersil/p54/eeprom.c
> index 95580921d933827c5eac55b79404e26bd7a57ba4..968ce9a411358e0e6b83117b1a077becc3207090 100644
> --- a/drivers/net/wireless/intersil/p54/eeprom.c
> +++ b/drivers/net/wireless/intersil/p54/eeprom.c
> @@ -763,6 +763,8 @@ int p54_parse_eeprom(struct ieee80211_hw *dev, void *eeprom, int len)
>   		case PDR_PRISM_PA_CAL_CURVE_DATA: {
>   			struct pda_pa_curve_data *curve_data =
>   				(struct pda_pa_curve_data *)entry->data;
> +			size_t needed;
> +
>   			if (data_len < sizeof(*curve_data)) {
>   				err = -EINVAL;
>   				goto err;
> @@ -770,9 +772,23 @@ int p54_parse_eeprom(struct ieee80211_hw *dev, void *eeprom, int len)
>   
>   			switch (curve_data->cal_method_rev) {
>   			case 0:
> +				needed = curve_data->channels *
> +					(sizeof(struct pda_pa_curve_data_sample_rev0) *
> +					 curve_data->points_per_channel + 2);
> +				if (data_len - sizeof(*curve_data) < needed) {
> +					err = -EINVAL;
> +					goto err;
> +				}
>   				err = p54_convert_rev0(dev, curve_data);
>   				break;
>   			case 1:
> +				needed = curve_data->channels *
> +					(sizeof(struct pda_pa_curve_data_sample_rev1) *
> +					 curve_data->points_per_channel + 3);
> +				if (data_len - sizeof(*curve_data) < needed) {
> +					err = -EINVAL;
> +					goto err;
> +				}
>   				err = p54_convert_rev1(dev, curve_data);

please move the checks into p54_convert_rev0 / p54_convert_rev1.

Cheers,
Christian

Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C09382F0F
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788695014; cv=none; b=UYeEQovFEYZF64GrS2Rh2k9u2wQJixWFUaEgc8+3vmlC2ns5M8RXcBUvi7hMmJg+vXg3dmCNyfjHDS6dVoiobsh7ss63XYUNlKomh+JJ+FKXSP9TtckiBjFfry2rWvWUXo7CStTYbn+ulSWSs5IW3Xwq5GVAjdGVtNLZejWTl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788695014; c=relaxed/simple;
	bh=4K1s1AQ/FgjCmH7yjjU/gqsqx+7f1Mdt5UNkaHrqoP0=;
	h=To:From:Message-Id:Mime-Version:Content-Type:Cc:Date:
	 Content-Disposition:References:Subject:In-Reply-To; b=Sa1090X9Xcvtqt3/4wzyGVq5+Ct1XwAKF+yaGEk3iLyEoLhxgBdB4SfOP2ZpVkinLxqZF7nYXvO3na0bbeXCR/ToVZrhE9zcbkyRwEjo/FsM78OCsDCo70dlEuLiGHVSc8JQtFLCsWK+T4aWVkVo7mvSLKgu5fWrJzDo665xe08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=Si4/uHmN; arc=none smtp.client-ip=71.18.227.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="Si4/uHmN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788694999; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=kF4XOpxl2FOCXm+aoX2z5PQbLq1Swi8wrCG8/hWWD30=;
 b=Si4/uHmN6Mh4m9OlewWy/Rzsm0ZOlXSVeXWhsEdZVRzUb8k0xy61i6MbCVMpbRIIPn/Bne
 rxAZBicc6H9p/Yp+/wvI8VSnAuMRUpCofcUp3nnqWsmrvIS0u1+2u6+qbMrK4QNWpxd8/Y
 RLP28H0eDLH5xe3kge17+qSoRyftXn+k4JtHTPNQPxfn0xS5CNDNjbVSFqt9kdKm5i29+4
 6LhBFyqZxvqYJngNwnwH2Ht9YEPyPnftNOffPvO0kbw6ur5asLfyXzOwV6C3GUczX7NY7V
 7ha93/Mpu4PbUHMPhYcZDc5p2Rrq61dTjet/DSaGrWURMxeoN/BCxerF3sPIJg==
To: "Christian Lamparter" <chunkeey@gmail.com>
From: "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <ap1R0jU3UMVGI3ml@pve>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shengzhuo Wei" <me@cherr.cc>, "David S. Miller" <davem@davemloft.net>, 
	"John W. Linville" <linville@tuxdriver.com>, 
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
Date: Sun, 6 Sep 2026 19:43:14 +0800
Content-Disposition: inline
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Received: from pve ([111.40.58.231]) by smtp.feishu.cn with ESMTPS; Sun, 06 Sep 2026 19:43:16 +0800
References: <20260831-p54-pda-validation-v2-0-dae566b388c8@cherr.cc> <20260831-p54-pda-validation-v2-1-dae566b388c8@cherr.cc> <f3eb0dfe-3b9c-483b-b802-2207fe8b747b@gmail.com>
Subject: Re: [PATCH v2 1/2] wifi: p54: validate curve data length in the calibration curve converters
In-Reply-To: <f3eb0dfe-3b9c-483b-b802-2207fe8b747b@gmail.com>
X-Lms-Return-Path: <lba+26a9d51d5+de2f2f+vger.kernel.org+me@cherr.cc>

On 2026-09-06 11:31, Christian Lamparter wrote:
> > diff --git a/drivers/net/wireless/intersil/p54/eeprom.c b/drivers/net/wireless/intersil/p54/eeprom.c
> > index 95580921d933..0dc848d77c5e 100644
> > --- a/drivers/net/wireless/intersil/p54/eeprom.c
> > +++ b/drivers/net/wireless/intersil/p54/eeprom.c
> > @@ -414,17 +414,22 @@ static int p54_generate_channel_lists(struct ieee80211_hw *dev)
> >   }
> >   static int p54_convert_rev0(struct ieee80211_hw *dev,
> > -			    struct pda_pa_curve_data *curve_data)
> > +			    struct pda_pa_curve_data *curve_data, size_t len)
> >   {
> >   	struct p54_common *priv = dev->priv;
> >   	struct p54_pa_curve_data_sample *dst;
> >   	struct pda_pa_curve_data_sample_rev0 *src;
> > +	size_t needed = curve_data->channels *
> > +		(sizeof(*src) * curve_data->points_per_channel + 2);
> >   	size_t cd_len = sizeof(*curve_data) +
> >   		(curve_data->points_per_channel*sizeof(*dst) + 2) *
> >   		 curve_data->channels;
> >   	unsigned int i, j;
> >   	void *source, *target;
> > +	if (len < sizeof(*curve_data) + needed)
> > +		return -EINVAL;
> > +
> 
> Hmm, Puh. Interessting. Several things. But yeah, this should work.
> 
> Acked-by: Christian Lamparter <chunkeey@gmail.com>

Hi Christian,

Thanks for the review and the Ack.

> Still I have some questions: Did you write/touch any of this yourself?
> Or is this patch straight from the model?

AI found the bug. I wrote the fix myself and used AI to review it
afterwards.
 
> It's because I can grok (heh) why "needed" ended up as a separate variable next to cd_len.
> But why was the sizeof(*curve_data) not included there too? It's only used once in the
> if check so and this sounds like the "needed" needed some extra? Maybe because it was
> already checked?

I kept sizeof(*curve_data) separate because I was thinking of needed
as the input data size without the header. But since it is only used
in that check, adding the header there too would be simpler.

Would you like me to send a v3 that makes just this change in both
converters?

Thanks,
Shengzhuo

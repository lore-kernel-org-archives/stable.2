Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82197471246
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936560; cv=none; b=ab8IqPtjG7PTPaMUDa8LTmQGb0+ZZAVDWUl5kYAreLO1ANKp4oF6t9SZ52CjTtFyp37QbuNHHarHjwN50rRg7eMBFa6871I9YwV9mMeVnLomBVu7JToxgDI3JzqGsQN7f/xC8zTxImdDhp9L2I1AzZP6o/sn7KllsogDzgchS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936560; c=relaxed/simple;
	bh=aZv75vqQuSfDhybgQCvJFR2oOc8Rnl22JKQVJ26UtyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7jtG+cAN6OrIypqsFUXJyFQ8mCqu3Lih0+M8o+Rf5+B2UJCDFSs/40nkNCFY2nzjc82fb7jlN0oPoMGDIrAGaM2wXWR8OWgsBOV3ezCabvoGQejtQCAM8Ews41Z1TCiGoeKZJnzzHc6syvZkdHaxsDFsibZWXDZs7uASLUgpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNAWbJhk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNAWbJhk"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47fecbb7000so526091f8f.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785936557; x=1786541357; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c5AywMh2QUy7FWyUdoRzpQILQxe1QIW/kUrBNPej2Zs=;
        b=HNAWbJhksm1mAYu/wfd0507oe4ELlbYDYlcqHNWZdOAAsyS0FJVP94SPnCwz9/umxO
         J/b5KGSSkyJkKCSGkROggGbqu7JQlMiF/6YWW2MqPCI9I6ZqhXi6uGAUHMsbPC6W0EAS
         drgstUdke04QLWbKN6EE+5cmVvHnzk21pojWibnqQm2s62m1uaN5Mj6xEisfTBQ/Bde5
         qfp8TvzgSYm4w4IFa6RnOf47EXVZApjlocgAjrVDepJ8ydUmCsufwK5Hh2jOdCLbtsso
         R6eNNNgw7r1Z3XbYU0C55i1bz9u4lpDPopS5OcYfHvNDdJZo03w/Dn7tFiii4pn9o2yV
         i+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785936557; x=1786541357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c5AywMh2QUy7FWyUdoRzpQILQxe1QIW/kUrBNPej2Zs=;
        b=c8VJWM0DGVmEUVzn3MQe4NKY2+EcfNYU4LsW3dDsFXCG+Itcz/oOQC9JerBSivGIbh
         rSB9PUhFlCRnF8rmHBbxqenFdPMcW2yBbDLTC6yVtdL4H4lW6U2iVfNAYrpgclPVXwom
         V07UJPgihSVpcy2XVjG+ITTIWEy0wnNID6wVDYRX+BlFwyge3fMLrYkqCFGjucBhpJGm
         WwfMK9bST1HMkDVSaW5JTONBRvglpvQTqP53inhWFo9l2/0i4fgN8GLC/c3s8c4cJqJG
         UgkQ8i9agF6ljQwn44d7yx9cck7XqSIHuEm9KD/CIfXMygCy29TXjtXnJHDYJBkANmpa
         kdRA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+5qRjLOKkmaSbKg1uis9bWwyepuKI7sKlCY+duTI2lolmG78Wwn65qNyq1+DHcuFTE2xJnbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJdygK7qokTVZ3vVnw5/tDiTZ/FtuIpT3aETTVAwVoXFcvIbw0
	ZX6UwPniImUzLkLxvvY7Nddz2uAPmS98G6LMdw1eJ8xYN+dcV23U+PkTseo5YJZ1
X-Gm-Gg: AR+sD12qkkjBHjPxsIKAidVvLmlmAEA7repUWoJry0piM6Dmda9fKR2T0oSwUrnfEwz
	axGFAEuZQsw9kw3DzibfeHxCRP7uqhruiW6yD5MP14Xxif8R3NIygPlfVTY7Qdw1lfl+pAXfLff
	Hx1gWORZJJENNYmGV5leXkyQxAsHK+AKbNfdZ3mbzms9PZquCie6E5aKOSszTaxJf0BTqDW0FBW
	0nLQgsO1npGuTrMS0/m48cg9CD60hS+ccGLnsOaAArbN01QCMIkE+JFOCtxP2E9E+vXaxyCn0lG
	vs71lfPXuLeOOT18BKFQzZrvAHpnoK9domBC8bW4hp9o2eBSF19Rb9usWqK1XOEpyX0q6qPw56Z
	3CAb4I/looliN0keyjhxFqPbmEGB3uihYmdsYIOle2GPatC5msdKqmGkd3ooCVUY4CBAfOJXdy5
	5GaMasVTemgK9U4hWX23EmczfbXo3/dddYiOkqaD9rRaBn4qaEUPr9
X-Received: by 2002:a05:600c:3422:b0:496:c18c:f9a1 with SMTP id 5b1f17b1804b1-4994e7cb6abmr62213045e9.14.1785936556356;
        Wed, 05 Aug 2026 06:29:16 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994dfda556sm100772705e9.5.2026.08.05.06.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:29:16 -0700 (PDT)
Date: Wed, 5 Aug 2026 14:30:26 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	linux-sound@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: adau1761: sort the register default table
Message-ID: <anM63ohN5_iJeAPX@nsa>
References: <20260805122713.11376-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805122713.11376-1-peter.ujfalusi@linux.intel.com>

On Wed, Aug 05, 2026 at 03:27:13PM +0300, Peter Ujfalusi wrote:
> reg_defaults must be sorted by ascending register address, as
> regcache_lookup_reg() locates entries in it with bsearch().  See commit
> fd80df352ba1 ("regcache: Add support for sorting defaults arrays").
> 
> The table lists the ADAU1761 specific registers (0x4008 and up) before
> the block shared with the ADAU1381/ADAU1781, which starts at
> ADAU17X1_CLOCK_CONTROL (0x4000), so bsearch() descends into the wrong
> half and 28 of the 52 entries are unreachable.
> regcache_reg_needs_sync() then cannot compare them against their default
> and reports that a sync is needed, so they are written to the device on
> every regcache_sync() even when they were never touched.
> 
> Sort the table by register address.
> 
> Fixes: dab464b60b24 ("ASoC: Add ADAU1361/ADAU1761 audio CODEC support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---

Acked-by: Nuno Sá <nuno.sa@analog.com>

>  sound/soc/codecs/adau1761.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
> index a70c46dd5d76..27ce03b0fb91 100644
> --- a/sound/soc/codecs/adau1761.c
> +++ b/sound/soc/codecs/adau1761.c
> @@ -68,23 +68,33 @@
>  #define ADAU1761_FIRMWARE "adau1761.bin"
>  
>  static const struct reg_default adau1761_reg_defaults[] = {
> -	{ ADAU1761_DEJITTER,			0x03 },
> +	{ ADAU17X1_CLOCK_CONTROL,		0x00 },
> +	{ ADAU17X1_PLL_CONTROL,			0x00 },
>  	{ ADAU1761_DIGMIC_JACKDETECT,		0x00 },
> +	{ ADAU17X1_REC_POWER_MGMT,		0x00 },
>  	{ ADAU1761_REC_MIXER_LEFT0,		0x00 },
>  	{ ADAU1761_REC_MIXER_LEFT1,		0x00 },
>  	{ ADAU1761_REC_MIXER_RIGHT0,		0x00 },
>  	{ ADAU1761_REC_MIXER_RIGHT1,		0x00 },
>  	{ ADAU1761_LEFT_DIFF_INPUT_VOL,		0x00 },
> +	{ ADAU1761_RIGHT_DIFF_INPUT_VOL,	0x00 },
> +	{ ADAU17X1_MICBIAS,			0x00 },
>  	{ ADAU1761_ALC_CTRL0,			0x00 },
>  	{ ADAU1761_ALC_CTRL1,			0x00 },
>  	{ ADAU1761_ALC_CTRL2,			0x00 },
>  	{ ADAU1761_ALC_CTRL3,			0x00 },
> -	{ ADAU1761_RIGHT_DIFF_INPUT_VOL,	0x00 },
> -	{ ADAU1761_PLAY_LR_MIXER_LEFT,		0x00 },
> +	{ ADAU17X1_SERIAL_PORT0,		0x00 },
> +	{ ADAU17X1_SERIAL_PORT1,		0x00 },
> +	{ ADAU17X1_CONVERTER0,			0x00 },
> +	{ ADAU17X1_CONVERTER1,			0x00 },
> +	{ ADAU17X1_ADC_CONTROL,			0x00 },
> +	{ ADAU17X1_LEFT_INPUT_DIGITAL_VOL,	0x00 },
> +	{ ADAU17X1_RIGHT_INPUT_DIGITAL_VOL,	0x00 },
>  	{ ADAU1761_PLAY_MIXER_LEFT0,		0x00 },
>  	{ ADAU1761_PLAY_MIXER_LEFT1,		0x00 },
>  	{ ADAU1761_PLAY_MIXER_RIGHT0,		0x00 },
>  	{ ADAU1761_PLAY_MIXER_RIGHT1,		0x00 },
> +	{ ADAU1761_PLAY_LR_MIXER_LEFT,		0x00 },
>  	{ ADAU1761_PLAY_LR_MIXER_RIGHT,		0x00 },
>  	{ ADAU1761_PLAY_MIXER_MONO,		0x00 },
>  	{ ADAU1761_PLAY_HP_LEFT_VOL,		0x00 },
> @@ -93,20 +103,6 @@ static const struct reg_default adau1761_reg_defaults[] = {
>  	{ ADAU1761_PLAY_LINE_RIGHT_VOL,		0x00 },
>  	{ ADAU1761_PLAY_MONO_OUTPUT_VOL,	0x00 },
>  	{ ADAU1761_POP_CLICK_SUPPRESS,		0x00 },
> -	{ ADAU1761_JACK_DETECT_PIN,		0x00 },
> -	{ ADAU1761_CLK_ENABLE0,			0x00 },
> -	{ ADAU1761_CLK_ENABLE1,			0x00 },
> -	{ ADAU17X1_CLOCK_CONTROL,		0x00 },
> -	{ ADAU17X1_PLL_CONTROL,			0x00 },
> -	{ ADAU17X1_REC_POWER_MGMT,		0x00 },
> -	{ ADAU17X1_MICBIAS,			0x00 },
> -	{ ADAU17X1_SERIAL_PORT0,		0x00 },
> -	{ ADAU17X1_SERIAL_PORT1,		0x00 },
> -	{ ADAU17X1_CONVERTER0,			0x00 },
> -	{ ADAU17X1_CONVERTER1,			0x00 },
> -	{ ADAU17X1_LEFT_INPUT_DIGITAL_VOL,	0x00 },
> -	{ ADAU17X1_RIGHT_INPUT_DIGITAL_VOL,	0x00 },
> -	{ ADAU17X1_ADC_CONTROL,			0x00 },
>  	{ ADAU17X1_PLAY_POWER_MGMT,		0x00 },
>  	{ ADAU17X1_DAC_CONTROL0,		0x00 },
>  	{ ADAU17X1_DAC_CONTROL1,		0x00 },
> @@ -114,12 +110,16 @@ static const struct reg_default adau1761_reg_defaults[] = {
>  	{ ADAU17X1_SERIAL_PORT_PAD,		0xaa },
>  	{ ADAU17X1_CONTROL_PORT_PAD0,		0xaa },
>  	{ ADAU17X1_CONTROL_PORT_PAD1,		0x00 },
> +	{ ADAU1761_JACK_DETECT_PIN,		0x00 },
> +	{ ADAU1761_DEJITTER,			0x03 },
>  	{ ADAU17X1_DSP_SAMPLING_RATE,		0x01 },
>  	{ ADAU17X1_SERIAL_INPUT_ROUTE,		0x00 },
>  	{ ADAU17X1_SERIAL_OUTPUT_ROUTE,		0x00 },
>  	{ ADAU17X1_DSP_ENABLE,			0x00 },
>  	{ ADAU17X1_DSP_RUN,			0x00 },
>  	{ ADAU17X1_SERIAL_SAMPLING_RATE,	0x00 },
> +	{ ADAU1761_CLK_ENABLE0,			0x00 },
> +	{ ADAU1761_CLK_ENABLE1,			0x00 },
>  };
>  
>  static const DECLARE_TLV_DB_SCALE(adau1761_sing_in_tlv, -1500, 300, 1);
> -- 
> 2.55.0
> 

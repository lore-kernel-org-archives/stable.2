Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87D4F405D
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368594; cv=none; b=Lw7TYjFYGxcIFSwCjAPHlfYiAdIsyVlgxNFGQPnVnwbmtNBDbeMynyUgtGCpUxX9onaWWBsp9sp9rIMIx7UcU0OmKgHVfjOXx1TgxrBhazG273cITV6CpT+Wk9dVu+tcu9/dVLYyEhws0gT9FQiaWXCYG2s6QMeIoIUgLIovkl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368594; c=relaxed/simple;
	bh=JA1MmlvysdwOS02CEm2fbSKD0SzlpVAbqKq6s8T/mfk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qal4fk5QSIEqRqMa8MV/fPcAqsCSqMABZ3ZeYhGzvF6cOhk3hQUCe1Q0UzfUXdiu7K/AbUP6z4enfE5CvExdJV2o9KBAaPCh9EZUgrbChiHP/b9GSaVZT9DtpKQeA/LxXkN2NoQJwB7YLFCI1Y5SA5SjXPFRDmPlyDP630VlGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUQoARdI; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUQoARdI"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04f7f2so1098639c88.0
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790368585; x=1790973385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4RNJ5nQR9k5gmyuH0UoJLYl6j03ODsgZ0SnhdOWBbVs=;
        b=rUQoARdIqa7zC5jv8hEpX+gubV1tNKAP/VULSdvg4ONtky2R9Bk6rSfbWJEPfamK4A
         b1fzg38bIjCaXnVivkD0QGNNl4gijLyUIFIJZTIvg0Id8dZsDgyTC16/DzWoULc3O87P
         JcaBhIjwsvcs0wIj01D7sC/OGWUupO5DYVcL8c6h/twInBtbabpygzLoaDHO9MWhALPL
         pJ7Gyk1J6VcfzdVxWae2SrFiRpewXdTndy1GJ8I7J5Qbj0qJkqlKvI94DGjK8532d34I
         ES1v1CzJoglwra7xBNsyijJ4skcl2qwaJSnmMSlOwGRWtsFUx1Futcv1p+UQRkhZ0fzZ
         GGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368585; x=1790973385;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4RNJ5nQR9k5gmyuH0UoJLYl6j03ODsgZ0SnhdOWBbVs=;
        b=WZ54Hpy209XdLEGek/7RMzkfMJwzbJQUFUIYHwkHIdbLczxLyC63GJ2c3bUWyz40Rj
         iwfE6XpwFRrLLuXzZXsGelsfZbTLEUBpRWcVMTvizHjrhZ6WSaydGW5mvDyIcEAd/V2u
         AUZVMxXxBrnB/Vryb24NelndrpSPZZJ9NOU+lWbCfkhf0h9ci/kRcLMceccRlWm/yfVh
         7ok/POICWA1wSuYteKWJHU/nvuu6SrxzPzclhHd98uPvcTuPrRyrm22rYmOGkD66ylco
         NEi/wRRbVLJsk8y+wAJ7aRkTypuX04tA7Jg3ALeJRQ96x7pZzCjGiW6jAEYd14wLv93P
         CLmA==
X-Forwarded-Encrypted: i=1; AKwUvBycjJKqCNhcnV6FRcUMb2M4gTmBlv6luqYivQWbrDx03RKyn5/0suGUXsTI5Hdd0IZ3LuyzZEU=@vger.kernel.org
X-Gm-Message-State: AFuF++nGDRm54BY7N4JJgdBdjuIeyWwY4nQLGwc3NdFlX70aXQ2Sdv5W
	8C761pYvUmIjpKCDusvOexonlhxW91ZU8YExR2rYypkGRD+IO/7zZ55F
X-Gm-Gg: AYBFou2GyPI+Fr9Syc4h4winmIuXsXpC8f68bTzyaohU2nMtaZLHnsn8H3sZ4Op0of4
	6dihVtw9tw3SrDcf+jevOblvOeXP2vq1uTUauyFLfRZzM7fp5h4wxzkgm4hly7Qxh643zys0zAu
	andgZjrIET29wBDnAuqkhIb5V1G1guURa74/Xz0SCe/LG3qazHwhD5LIzg99W5Fmj1tvLY0YkPX
	Pl/EzrW0vbhE2WgZKINH/JyndOBAq/BdrV4xD4Fe3+ufeVACpnlYMsxOleMLJOJ0A+h9W6EjIJ5
	8c1SNVe6LasZewCuig9F9iZ+Rl+gMhjkR2DFG325WingAq2CAN03mP/vWXSQI73wFwx2kK59JbE
	JEPprYN1WdptO5gufMk6ha4xbZEdmkU0s+U2NbqhqLWY9aOFssDH3kohhBvidnpjDYTnHqESZMg
	089MfDCw8kpvztOF6iZOARgI23EOTpIFOF2j1Im/wfiK3xsQitxjFf+m0rIRx7vHPsSASUkgtaQ
	sJTHrGe4Bq+FzAiMNz+1+n+OYipTIT2jQQ6cGV2NNO+NWGDh8kMgTukt/h9IsQFB2dITA==
X-Received: by 2002:a05:701b:4346:b0:13e:aa58:89f8 with SMTP id a92af1059eb24-146ce86dbddmr949798c88.15.1790368585236;
        Fri, 25 Sep 2026 13:36:25 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:79e1:2e00:6c01:e929:591c:a76d:ca9c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad9e097fsm8107732c88.13.2026.09.25.13.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 13:36:24 -0700 (PDT)
Date: Fri, 25 Sep 2026 13:36:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Petr Hodina <petr.hodina@protonmail.com>, linux-input@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_1/4=5D_Input=3A_stmfts_-_w?=
 =?US-ASCII?Q?ait_for_controller_ready_after_reset?=
User-Agent: K-9 Mail for Android
In-Reply-To: <b684b88b-55a6-41a9-a4da-3bca33550164@ixit.cz>
References: <20260907-stmfts5-v7-0-4a53381cd038@ixit.cz> <20260907-stmfts5-v7-1-4a53381cd038@ixit.cz> <arbJrK9zfoO1dGzy@google.com> <b684b88b-55a6-41a9-a4da-3bca33550164@ixit.cz>
Message-ID: <B0EA1BC5-3B3E-4D31-9A37-974E38309C74@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 25, 2026 1:20:56 PM PDT, David Heidelberg <david@ixit=2Ecz> wr=
ote:
>On 25/09/2026 21:27, Dmitry Torokhov wrote:
>> Hi David,
>>=20
>> On Mon, Sep 07, 2026 at 12:50:19PM +0200, David Heidelberg via B4 Relay=
 wrote:
>>>   -static void stmfts_reset(struct stmfts_data *sdata)
>>> +static int stmfts_reset(struct stmfts_data *sdata)
>>>   {
>>>   	gpiod_set_value_cansleep(sdata->reset_gpio, 1);
>>>   	msleep(20);
>>>   +	reinit_completion(&sdata->cmd_done);
>>>   	gpiod_set_value_cansleep(sdata->reset_gpio, 0);
>>> -	msleep(50);
>>> +	enable_irq(sdata->client->irq);
>>> +
>>> +	if (!wait_for_completion_timeout(&sdata->cmd_done,
>>> +					 msecs_to_jiffies(STMFTS_RESET_TIMEOUT_MS)))
>>> +		return -ETIMEDOUT;
>>> +
>>> +	return 0;
>>>   }
>>>     static int stmfts_configure(struct stmfts_data *sdata)
>>>   {
>>>   	int err;
>>>     	err =3D stmfts_command(sdata, STMFTS_SYSTEM_RESET);
>>>   	if (err)
>>> @@ -593,42 +602,47 @@ static int stmfts_power_on(struct stmfts_data *s=
data)
>>>   		return err;
>>>     	/*
>>>   	 * The datasheet does not specify the power on time, but considerin=
g
>>>   	 * that the reset time is < 10ms, I sleep 20ms to be sure
>>>   	 */
>>>   	msleep(20);
>>>   -	if (sdata->reset_gpio)
>>> -		stmfts_reset(sdata);
>>> +	if (sdata->reset_gpio) {
>>> +		err =3D stmfts_reset(sdata);
>>> +		if (err) {
>>> +			dev_err(&sdata->client->dev,
>>> +				"controller not ready after reset: %d\n", err);
>>> +			goto err_disable_irq;
>>> +		}
>>> +	} else {
>>> +		enable_irq(sdata->client->irq);
>>> +		msleep(50);
>>> +	}
>>>     	err =3D stmfts_read_system_info(sdata);
>>>   	if (err)
>>> -		goto err_disable_regulators;
>>> -
>>> -	enable_irq(sdata->client->irq);
>>> -
>>> -	msleep(50);
>>> +		goto err_disable_irq;
>>=20
>>=20
>> I think the logic is becoming quite convoluted here, and factored out
>> stmfts_reset() does not help=2E How about we make it look like this:
>>=20
>> static int stmfts_power_on(struct stmfts_data *sdata)
>> {
>> 	int err;
>>=20
>> 	if (sdata->reset_gpio) {
>> 		gpiod_set_value_cansleep(sdata->reset_gpio, 1);
>> 		/* a short delay before powering up */
>> 		usleep_range(1000, 1500);
>> 	}
>>=20
>> 	err =3D regulator_bulk_enable(ARRAY_SIZE(stmfts_supplies),
>> 				    sdata->supplies);
>> 	if (err)
>> 		return err;
>>=20
>> 	if (sdata->reset_gpio) {
>> 		reinit_completion(&sdata->cmd_done);
>>=20
>> 		/*
>> 		 * The datasheet does not specify the power on time, but
>> 		 * considering that the reset time is < 10ms, sleep for 20ms
>> 		 * to be sure before releasing reset line=2E
>> 		 */
>> 		msleep(20);
>> 		gpiod_set_value_cansleep(sdata->reset_gpio, 0);
>>=20
>> 		enable_irq(sdata->client->irq);
>>=20
>> 		if (!wait_for_completion_timeout(&sdata->cmd_done,
>> 						 msecs_to_jiffies(STMFTS_RESET_TIMEOUT_MS))) {
>> 			dev_err(&sdata->client->dev, "controller not ready after reset");
>> 			err =3D -ETIMEDOUT;
>> 			goto err_disable_irq;
>> 		}
>> 	} else {
>> 		/*
>> 		 * We do not know the real controller state (was it powered
>> 		 * off or reset)=2E Let's hope that this is enough time to
>> 		 * initialize=2E
>> 		 */
>> 		msleep(70);
>>=20
>> 		enable_irq(sdata->client->irq);
>> 	}
>>=20
>> 	err =3D sdata->ops->configure(sdata);
>> 	if (err)
>> 		goto err_disable_irq;
>>=20
>> 	/*
>> 	 * At this point no one is using the touchscreen
>> 	 * and I don't really care about the return value
>> 	 */
>> 	(void)i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_IN);
>>=20
>> 	return 0;
>>=20
>> err_disable_irq:
>> 	disable_irq(sdata->client->irq);
>>=20
>> 	regulator_bulk_disable(ARRAY_SIZE(stmfts_supplies), sdata->supplies);
>> 	return err;
>> }
>
>Thanks, it seems to be better (thou would be nicer if we didn't have two =
branches, but=2E=2E=2E what we can do)=2E

That's that enable_irq() in the middle=2E=2E=2E We could have more "ifs" b=
ut that also looks ugly=2E=20

>
>I added you as Co-developed-by :)

Thanks but I don't think the change was large enough to warrant it=2E


--=20
Dmitry

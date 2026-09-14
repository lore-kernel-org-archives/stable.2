Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01785483BF4
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390169; cv=none; b=Ss9A+HhIMU9BSeNx0kBiSERg5E6uvkHPSugEWUf4KzmMNaKn0vMx/v8IiLq+p6QEd1AxrP+8iBNM7O3gGE9eImqxzUgrrz0Rk1eeO/cekKk7tiOMVSDfd7BqTRke4gnnq5lLOaUVtgJ3a7Sc9RkCCayOGCtczbircS79ift6gQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390169; c=relaxed/simple;
	bh=aQYzR+IvQykSVUn7rBpK3rQlkN9oxeBGlmz382e3/mA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WslONx6Bg0MI4FfPwfBShT8vunrYLDqsx0Y2M0lTkwe6PdWJxmTunag1TwDgWLgXw842xZFXgSsMa1uvjOWc30p98rIVrvEuqwK6+NVA0zW1aqi8LdpoW4M19o8rObbVUsKPT43aw8ugJ0XdNiABO9pxFziP6dPWtZvRtZNVLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9CnNKXI; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9CnNKXI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so16536575e9.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789390164; x=1789994964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Gq+pmsPFihIMk5W7k1MUPH9S4la2uIzpj309XLReH8=;
        b=D9CnNKXI5nHcsFda0H2dor77STypOKXJblNRUIaQ+aR7vU/2XWfxiXlJTvFSiFovhK
         zcfrX4vgpXvi5FPPBbP5nf8wIkQNKdpvkwQDrdxB5MCByApPWtPLKL56wXxBj/qaPLH5
         hITKlnQXw3x5rRvlnyPB2TDduN/ct0b9l44CAgVatnP224tZepwmFf6a4ajXdKD7tbqw
         mz4Eb9OM5NouWpbYG4VxNDsI3XtN2KfwjsP/2tPdoAS0KBofb8uxlClrIqv1s4mxnNR3
         Ji0chWYxUrg6phuLvUBmlEaKzhpets+/aQ3kK4K3iLu7RgBsjlluveR1asVBsWbtGL73
         Jw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789390164; x=1789994964;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Gq+pmsPFihIMk5W7k1MUPH9S4la2uIzpj309XLReH8=;
        b=Pb8RgprcKm+vJkSZYt3SQfV7PHaqLK/SjNhVPtAk5WdR+GU3lwOONIslzCdmWNsotR
         jWP4qCFrUgcidq2yKf5TFza9sYCExlAGXd5uM9J8D9X99rFQc6cdLPTPWkjDXiDY4fIj
         +52QNQrVN1OX/jIntZmF81RBQV8XP4B5Z3owvZFN9//t8JehdgAl4J1IdnNxQQ9Muy2J
         8vYYuHDsM9nWroTp0AwGeIxSxLR9LF1SsVx4AX8a95z9MrVSZI/pQSYh/qPAzA0mcQRh
         s0DThqDdK2HbLUkQUoq3YVj7GcQ0guWC13xCBy3/duCrSj4ieyoNqz/LgLz2fq3mE/HD
         nAcg==
X-Forwarded-Encrypted: i=1; AKwUvBw/maS95CgbMY0AOiWFkfI7LH3/Q7kTWsgu/1D2EcJJ5cRiuRjHpXV+gmmv5WS9kMx28R7Mnj4=@vger.kernel.org
X-Gm-Message-State: AFuF++mLd6P3EflF6Hf50VtwcAhhyjWUYXHZsR3Bx0NA5uUTjyc3wgIw
	G890EjJ6hRrjRV+sixL0RMhi5EVMrs6jXjw49OIUw6W4sTu7jFYPhWqt
X-Gm-Gg: AYBFou2TANyqP/wE/kxM+/X+UkRSGYiTt+x6WDxM1srrWPhxmnuv141LWzYuWWzax60
	n26ZhaxK5psLnM8n5CKbt9Q5c1ZLhU5/BkX34JgYHTYltuTAoOP1T2YRzNUIDEhG5hLuP9DSIc1
	ufMbTCHzS7TsNQZAtonBDz/2P8GrEuk7EpUunGdm3ghHCd7Rb0OGXwva/YI4r0e2TVCIpErG7Ws
	Epmar3Y8DUmhMTBCFqe2Z2gftjiFA6GwUwSk/nk9TJxqmMfdtGyDxKrczv3EJRLTw3ZP9x/Hv/A
	RlglK53V5GZa+z7uZkoQLMx+4GicxmdzMilqJW7izOROnQQIS+n0rkQ6OWdd4s7eaorytNQqxWl
	XGAUrHpoB8y50WZ/wnEdTsjcNnMagyHWMqiz2xPBHg/dDYlGZZ85fMzbe8Uc5IERttDOBfkTmg/
	TdRYlstDmFT/tnyjh3M/aiEXgCaKkAi88AefG/IlFOuBjENH8D346MnxD8/4sCkg9mNI3LGvuy5
	IguLH0Et9MsDUli3LUhVGvkkwYqW3wBCMtLWfseGE32qZpjF2EXSIN4gBaSaT5H9vM/pRkThBIF
	Ci2qXVgbTvh1BU4gz0aae0vPf6vnMnvda7WMIeXxLaxeINqQ8r2wLkC24zBF/PDYEikUySi8clM
	/TEQQmSmDvXzreA+o90Tx1sxNEfPKwNShlOZQ3sYEeJLr33YQNpe2TcDwhnM3FO9XKnbKZJOJhV
	WKsafj
X-Received: by 2002:a05:600c:3589:b0:49c:d818:8764 with SMTP id 5b1f17b1804b1-49e7a669271mr34433685e9.11.1789390163869;
        Mon, 14 Sep 2026 05:49:23 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e63c9a7c9sm527964885e9.13.2026.09.14.05.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 05:49:23 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:49:20 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 (The Capable Hub)" <u.kleine-koenig@baylibre.com>, Siratul Islam
 <email@sirat.me>, Matti Vaittinen <mazziesaccount@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxcjk-1013: disable autosuspend on remove
Message-ID: <20260914144920.00002f7b@gmail.com>
In-Reply-To: <20260914112053.1686061-1-lgs201920130244@gmail.com>
References: <20260914112053.1686061-1-lgs201920130244@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 19:20:53 +0800
Guangshuo Li <lgs201920130244@gmail.com> wrote:

...

> Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> path.
>
> This issue was found by manual code inspection.
>

I'm on the fence whether this sentence should go under the ---
 
...

> @@ -1547,6 +1547,7 @@ static void kxcjk1013_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  
> +	pm_runtime_dont_use_autosuspend(&client->dev);
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
>  

It would've been better if you sent the 4 patches as a series with a cover
letter as all of them are the same fix.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts

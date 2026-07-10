Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744843191BA
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695246; cv=none; b=ezRWrIbygVE4LsgCjzB63vzUS8RJiADBhBPO9vBK+Nzzc4SmSrH9aTtr+XfteAlO6IhYqTpSEh0IkHmJx1Gt3XxknW/8IAOVH2Hux0v+LpqcGfJa6gtVilvVKh0a+959Qp539vSE0Y6usfkNy11wo6M3P8N+/yuknrIKQ+ciuD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695246; c=relaxed/simple;
	bh=zjjM4SgtY2ZYsY/pfHW4NTPajyUYDKNVs1BgTxWTkMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hrz4hMqurND+Mtica+jj2EMFDTjeOf5GBpvtugF39MAET/RrA9u7wSN+Wttu4Yf4FE3NciH2NfENHp5HjtTcich3kcj7kpT71SoPCWNL05RAE1RfuXqjvq2F5Db3lKoPm0DwIahjnxxqCkbwqFqr8w/uOtbEgzCfA5LbbYxTE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rm1wYWQq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rm1wYWQq"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c953950dfso7275081fa.1
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783695244; x=1784300044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gl9mT3P5+btuz519aywW8mP891xmb+W2d22pXd2NmlU=;
        b=rm1wYWQqfe9kNet0YRksaxshVnFvKlMQqu1NqflcK2skyrb21qaVVlEVtzG1briICD
         jfsAHsqEKR6lzqSFpYTliMwS1mP/2MSwI6DuLIPixqdSwy8GPcLQX6aVNnwBCRBEntBn
         RQFz/n6OyHk26ucWOMM3DaZULDWe5Xj/Yrj7erHzBER4ZfYtOjzqmuXLo7DSmX5L12ON
         QxZ39XkG1BluztfCBNdaPHksd5i0htwpVjNg+1PAVyMc1kjyT2+XK9ZhA/ojARKBTFmM
         RVbWXXGwQEZT6f2/iREw18054rHpwffPzVY/G9Pu9zmwUN2v49WnD6m7rhQtKDataa8j
         Oh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783695244; x=1784300044;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gl9mT3P5+btuz519aywW8mP891xmb+W2d22pXd2NmlU=;
        b=qjcweZ4MBLRhN+qkDJQ3fa8H6uDYsgiKQxDQtpL0Cb1feASKX9JJ6oWDuKfFVHNFel
         fcwx1/Y0OamQmCICGxJvCk1FHeom0ykNx4gR48qDcdAqB88LvxbRJpnxgGCkpVSg1WN4
         sLXhnm4MpXyrKxU1Fs/Uqphs4Uq4yMH7fmAI+QUupqlLZFAEMyCS0O+c4i0N1ayMyh59
         ppjWfDO/b1uXrjGrqLoyR1jGMhck6U9KYMFgDdq3tnkexFpBRa5tNxXQ9RuJ26WTc+u6
         lWfb4cwLIZe5Xmgyz7hYzk7wDNVnOhEWNDvS5QJOgcntu8qWrs0QjrFor7ujzTrUMozB
         tptA==
X-Forwarded-Encrypted: i=1; AHgh+RpobYOFMGBbqm1DzthV/VbwC2k3rlgT58PUYa29cuLk01dPVotQGJ3uKrv4XIDuWEbnTjj5XoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyThSqOQUaLZhXWxARJIfBYi7cK+kZF+YZagtb77ADj0Z+nKs67
	dLx6Ga2rOq8Yr+lt5wCYhHZrTPspRGJ0XSSJe3DmoV4TUCwRmiY5c3r/
X-Gm-Gg: AfdE7ckPtdo8s/68Yl/IHcfpkTeN0eHbHiwM4a2Jx+u4OJbp5muoYOrWPgYh7aNRgyN
	6I4rJ/TLnZQBkPd12TE9TMtBKeGeKsgk1p1aYWjRJa3Zoqf6cBpMhL615ML2FSeevuCSQd6bkYe
	EIshkh74l51jd4pCF0jKYWIbzKAAAFnVMrq2K5wFZCrTyC6+XuM0ljpd0a6dM3hgi48yMCgwV4l
	MTI8HHQt7vSbcufa9rbYNcxBXceB+bI9Sd9PYJ9fh6f46zVMXobo++GZab9EITj2WzoeveAg9tw
	VLzPNC0YZx7cNbRn++7B5z98O+n2vI5Nrt4BqgSrTgP/33MaZv9LpqIbszGlCyd4E05XGvzDvG5
	W2RtEPeK9/TYia0jm97KqqxEQSdDFXgkl8hg8Y9x3+zGZ5swimk4bL9fMDshF4v/Ei5gEDqg2Oo
	57FCnL2UYhqP8Q019v0njpwqv/OBt5JAYjpR6JlH0CVE4tZjSa9+Xvi0QaIUZ0WhTuHIl+LPzU/
	LjzC+4+kxT6f1vwqmDFek/k8x1xeXfUuLHeT82wSFz6A4Ro2LUYbES4C+seJQqewUVle9X9Xmk3
	rxfXsppXXf1p2/gj7p6wCJw6DB+Gce6WVtZHoMY5rO65e0MTQMyPVJV/7k3JohJIIV49Roa+aT2
	fGYmt9qZ+BYSc9jNnaQTix4s=
X-Received: by 2002:a05:6512:159c:b0:5ae:bcc4:c071 with SMTP id 2adb3069b0e04-5b0113f95c0mr2985552e87.0.1783695243458;
        Fri, 10 Jul 2026 07:54:03 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01caa60e4sm680375e87.60.2026.07.10.07.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:54:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 16:54:00 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Yasin Lee <yasin.lee.x@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: hx9023s: validate firmware size
Message-ID: <20260710165400.00005108@gmail.com>
In-Reply-To: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
References: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 20:07:12 +0545
Laxman Acharya Padhya <acharyalaxman8848@gmail.com> wrote:
> @@ -1058,6 +1065,7 @@ static void hx9023s_cfg_update(const struct firmware *fw, void *context)
>  	}
>  
>  	ret = hx9023s_send_cfg(fw, data);
> +	release_firmware(fw);

Why not move this after the if? Keep the call/retval check coupled.

>  	if (ret) {
>  		dev_warn(dev, "Firmware update failed: %d\n", ret);
>  		goto no_fw;
> 

Otherwise this looks good. Feel free to add my tag with the v2:

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD

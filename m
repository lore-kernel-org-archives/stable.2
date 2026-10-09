Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643243BB112
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556890; cv=none; b=F8Gv/HCcc4EmZAr81B0a5NJyV9PLys4MJNq7i6rg6WXD1PqTGw6A1E6agbfGoZi1nUMZnMYDnhX3T7lk+Frhykoz+2myj05/1k+WP7jEeZNwOJVMozPdte6fEUAhn6IuD5+pU+AXcePN4eXQqf0o8T/RpvCjKG5/wZvB3hlBNKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556890; c=relaxed/simple;
	bh=7d1WeSxb2gZk5Jg3fVfLfWhNCocXXrKL12zPE5Mm2Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=koR+jFKyiys3E+JgCP8FLocKndd/l5iSBxOnT57G1QmKhGlqhG/9cIj8x+1fqZ89KDKk0Lz7ehKak6de1bh0OVb5XBM3MkW61eWf9nJK2kE2KxiBFKs/umOAazssGTaiWRTvk/EY+k+4LNd1+UpJPbyYwDod4+/Kiy4mDkk8o2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noQ2xUp0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noQ2xUp0"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b9d8055dfso5031850f8f.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791556888; x=1792161688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yidcfjkfrj4Zyo9jVtuaHx7UroWIKt8wJaYuDFgeJYw=;
        b=noQ2xUp0asDnwLMlzJ5XjEd63btir7mxiioQ9Ri8ayda3ELt84ru96IETgPJaBaa+v
         Rw6dixaAuv/Bxha/oJBRBcMG2JlCuyhYS3Nu2O+bQZUz4Bb950wx6HD03cdfENzqZH9x
         XYcIognrK+1BiRTxmc9so156uIFeZgGhWUZgTcYB9b0c75BPwDIdCXcBU5E45x/PpsHD
         1rPu1t746bjyDKAtlMzlmtcpqf4xCqfiA72bJgkFnqIBdx7wwn8m5t0LPsij4an3ZqY4
         y98x55vJ0hUJ+CFcVXI83c0kE+Go9xX4uIZC3zRbzMIZyr59irogmMmgLLYI0iVt0AAm
         COSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556888; x=1792161688;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yidcfjkfrj4Zyo9jVtuaHx7UroWIKt8wJaYuDFgeJYw=;
        b=ikPhjKqAWk9oCXdu9aW86ZE62HwwJiiMS/F4Zx/bHpLhepIjj9B/FdlZbgKYsmQWfk
         aCwojLYe8uKbVzmCHgL2QcWPuxjLCOVVFaZBKrgpiuy0RnVJQL+IXc5t2t/AL+OzpceL
         79uToJTIxVrqdnI8KF/nUJ3YpZ4Nlr92cbuu+8wM9DdN9uMuZ3e80cGlfW4/BXcnKrbB
         VVQBFR9aAD9tnOrKgd+ylwQa29soWpJDXZieZhp5BS1abLS2dL8OvQVXG2HsMiAI+Lxp
         EpxN8rTNTujVgpMJK3Os6FoqQDuoHw0NwqFHgRoCg9JctjxCroOwIkmr6trb1IblXV+B
         5jLg==
X-Forwarded-Encrypted: i=1; AKwUvBwr09Sc7Kdq2nf+JopJ1pmTPjpNw9O9Pp6wrjRpNYAkg1J9WqXxBDV7DvA+pzmeoPeCgP/o90I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxHQ3GkJGczSSwSgyczpjmxVCigD4HgYR1ym8cJQZ2JEL83Trx
	mFrRhjjIlyvVIS+5vZQX0a2OjOuovIy/L8PhCOtbje4gY6PJeH7f3AZoIzfHCR7t
X-Gm-Gg: AYBFou2o+0VHyVsM8oNcSkwJx/MlL5/zGoeZU6T4BV+APiUpyVwyOZC9uEvYJzEQ25c
	TDPiINC6iQkRLGBJQ+hz7bkS7N68/lASJeZEXAFwb9VTaXudlCl8IrBxgxXho1vZo66eTQklBnG
	kg75CSxOM/eKIc8FABkyesQAHSraIe9Zwouu6IhzNFeGtdcP6hZmjFKZ9b3gV7lEcWK8a/iSJ4G
	PHvfDHdgl5+b8Kg/L9XGhuxhm++dTKMD95Ck3dn+kbXAPidKv3HJ3a60AJsgW07gMzC2GbekHLg
	pVMz0FM4mXv3tydCknstiPd7dD6gOeg2stadeMmmVyzUoMrHQlVerZSrIpON/CoofP2k6WsZ3GR
	W0+CMK+esIHAxy6oeb66EYG0Fx2HVuw45B0OLdj+C52XwDE8dr/D7HYFbIcA+18y8z1iOAyUZ6a
	jvSQXH8cappVkQRSzuJJUnvZbgMRZCSgaXupL4MIjFwjUyS0LUCJeJkXmzycMLVyDa3VYalynU4
	0mZB3yW0hrQ/HbPmNsMeKb7XW/5NcpH
X-Received: by 2002:adf:e005:0:20b0:487:2443:7526 with SMTP id ffacd0b85a97d-48dbacf6f1fmr3038323f8f.55.1791556887464;
        Fri, 09 Oct 2026 07:41:27 -0700 (PDT)
Received: from [192.168.147.140] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acee65sm4173410f8f.49.2026.10.09.07.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 07:41:26 -0700 (PDT)
Message-ID: <6b6874d3-5997-40cf-b5ad-88f8c33a0e92@gmail.com>
Date: Fri, 9 Oct 2026 17:41:25 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] iio: light: rohm-bu27034: Fix infinite
 delay on error" failed to apply to 6.6-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jic23@kernel.org, jonathan.cameron@oss.qualcomm.com,
 stable@vger.kernel.org
References: <2026100659-encircle-snout-9f76@gregkh>
 <6f9295f4-3feb-48d3-bf1a-4e9aa3c6a7f7@gmail.com>
 <2026100914-obstacle-unify-63d7@gregkh>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <2026100914-obstacle-unify-63d7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/10/2026 17:03, Greg KH wrote:
> On Wed, Oct 07, 2026 at 03:06:25PM +0300, Matti Vaittinen wrote:
>> Hi dee Ho,
>>
>> On 06/10/2026 10:47, gregkh@linuxfoundation.org wrote:
>>
>> I see two options to improve. First is to drop the whole driver from the 6.6
>> stable. It shouldn't break users because the driver does not work with the
>> released hardware.
>>
>> Second option is to backport all the patches which bring the support for
>> released revision of the hardware + the fixes.
>>
>> I am not sure which makes more sense. The 6.6 EOL is approaching, and I kind
>> of hope it is no longer picked as a base for new projects using the sensor.
> 
> The 6.6 EOL is still a ways away, let's just delete the driver entirely
> if you feel it's better that way.  Deleting code is always good :)

Deleting the broken version from 6.6 (while still keeping the working 
one in more recent releases) is definitely better than having a broken 
one there. I'll send a deletion patch for 6.6-stable next week when I'm 
back from Prague.

Thanks for the guidance!

Yours,
   -- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

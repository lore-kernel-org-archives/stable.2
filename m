Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA456380FE5
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209881; cv=none; b=sswL05aQLRR15OP8Gvp+6QZMoBAoQ1vrgpTiZj9weRbp/G7CAlO37IZFAiA/I0a/dKt8d7BGrPal8mXnQ91MBlkcWS1xQTpmoV3CYK+H4ych+tw5hP3JXr01xZjnIBsLwwzm/hcb78mV29khZT1/5xvmWL75gFp2UnGLGM2/lpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209881; c=relaxed/simple;
	bh=7XhoZc+d+Npz+Cabc3A0TtQ6BwVo5jOIjEe/ClwtPew=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bOC0mtxhJ0X5DN/8+97wiaawgA4zOsDyRgj8A8r/OiIHvqa0g1nhzHbnzn25gZfSTZm5pLwNJgDc6EJg8V3Sfpny/3758Z5Mud44z1booRG95UIoRIfXgFYgAK9VwfwXn2g9G32cB99b2rUF/8idB4I88LUsZu0BHsoStsnfHtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loOZwuEj; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loOZwuEj"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c2a818fc4so39335821cf.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788209878; x=1788814678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ro9e2jTWieCFdtrEqKTJDij7AqVySynjSHA79dJ5Oyo=;
        b=loOZwuEjX4fpRIRIZ/pDo/EXj5jITX5hstp8a6LQ6AqEHjKNRoFq8a1Pq8OaDsi1Ln
         aprms2zFjjhRM0OUUjOhXtSXIi/IitKqTTKrqfpxdihjhrBaf0K4P7qQ1sFQRpTExfCA
         CA538nxIZuqkcMsedOTgttpotn1ojegq7LSUwDD0G4RUPgspoNoy+gYbBinmEBIOPs7D
         uf/7bcrxNssh5H1fJKHprjIdrV2PWYymLSxSgB1dlSoUJ0PdqgHf60Sl2dJt/jKeECdR
         +8Yq8nSFKMne5LiLXdNUkl3oo8G+rPESCDamluc4QR8ma5GqPw2kkbIlKBM6wMr0+eCy
         7/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788209878; x=1788814678;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ro9e2jTWieCFdtrEqKTJDij7AqVySynjSHA79dJ5Oyo=;
        b=ZJIqkM/5/T5RfB0f48sCgDJVJcYBeTKorIapRprT+GRSkNm/+rdYUdM9T9MTBDHzoX
         /4Lq01gP2Sy1Gzv06X1cp81Zp6/jmZP8Ynz6aEQW/04hAdhrUtPsSTFImoetKYWhYbL+
         /DYnnKic0pa8gz3o/89NYDfRC79BDzlxR5NflG0oEasxf4GBmNEg3VXOwbwor4XKTavC
         A/SN/0rezoeUkwhPIwW0GDikMnxX2ZIf1KEDx5WkAFUyWnq6uERzhPajbNb0dlSXj6rY
         oFak3M4DHSbAV8PV53pMJmTvOi8bSafst7YergHjXVtN2Fsup7agkLa1Jep+sIERzemX
         Ltsg==
X-Forwarded-Encrypted: i=1; AHgh+RowkC/cRVRla4M1HbsrGKNpnQmCV+DXO/BVcGB8zYcvXoVM/IdEo6SPUnJenvTQJraY3gJITk0=@vger.kernel.org
X-Gm-Message-State: AFuF++kaFMYC2PxWFtQzOMDVis1GdKm+LBeo1+Q+PRhaZeOmX3ovBcar
	wxYVLQ9FBoL3XBbgU6a8RdLE4wWcrm0pgXurhngqSEHWrZj3Aeh8hcs=
X-Gm-Gg: AR+sD10i0xTv4/yIFMazIOVgVn94ExLJUeCBVHMYgMpvbm8ReD1P15/+quBohWxZffV
	DLR7cupYt0CUWqWQ+OSbvKr+YbtsEPh72pVonh9Pyr9ffrExexb+M+drDQCeFICL1UgASoksFFF
	bwYo907+t54zrdJbe0GaLbFgDPdWTxdC3m7OveA9dpwMQ7Mwr7aBqHGA635HhBUt5uQghY9FYri
	XJxkTdyZgDREEzQcNGs4NOUQHZpra76M0Nf5eWZWOuZJNdbTdribgod2J4ljdjVjNmBJAWVab0J
	gIBiN5KnY4N3dgRaeU4IWLwK35/7sVxa8HQ4K5xzZgy6oLiaWEe8brty5t/aGzaBJVfKmop3HnN
	ymLHy82nA4ci9CQi3ERzJ2nNYh/YyJbDMh1vS2W3lWXiGSZLSS5fQpu46cVqldCxK9Dg3s3Gk2w
	FEnQXRfIakHRjnGdtApvehbOONJi70B/WflwLGUpNKE81y1YNiP+XgmxX1O1YNDKyLmm4B6iE5O
	HChJOMp/lQGBK+QfgH62kXKSw==
X-Received: by 2002:a05:622a:e3ce:20b0:52f:c0b8:b619 with SMTP id d75a77b69052e-52fc0b928b5mr168125111cf.29.1788209873697;
        Mon, 31 Aug 2026 13:57:53 -0700 (PDT)
Received: from [120.7.1.23] (135-23-94-154.cpe.pppoe.ca. [135.23.94.154])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce4515072sm91956876d6.36.2026.08.31.13.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 13:57:53 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/43] 5.10.269-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260831133358.571886287@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <ffd3fcee-cb98-0821-3544-4da490e546a8@gmail.com>
Date: Mon, 31 Aug 2026 16:58:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101
 Firefox/140.0 SeaMonkey/2.53.24
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260831133358.571886287@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.269 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
Compiled an i386 kernel, installed and booted OK on a 32-bit EeePC.
No problems noticed.

Tested-by: Woody Suwalski <terraluna977@gmail.com>

PS. Should the 5.10.269 patch include the fix from pchelkin@ispras.ru
[PATCH 5.10] Revert "USB: serial: keyspan_pda: fix information leak" ?



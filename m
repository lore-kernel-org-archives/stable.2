Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3FF2F12AB
	for <stable@vger.kernel.org>; Sat, 30 May 2026 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157059; cv=none; b=M7teWrXD+jLAdiqhWrezIKqRYiJ4Tm5AZHR/blSOzH+SqpbfWiuOWy+KVoJZkDKHUVCZg17otLFk3kJGJid661g5ZkDu83ZexsWV3/fcaasdbQwkjlOzjmDLvwmfT/BbkaO+B/dO+kwe+WI36Vod6D/W6pEDifyx01XHhe4cq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157059; c=relaxed/simple;
	bh=xXxKuCv9C5Sk5Uo6qeIQl3U4kQRoZ6Q2iWeCQq8TpCc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dC+IpiHXzYqi+8PjnAOFCWDtF/0q479Igy84useJh6L/fcp1MPN0UYpfmN620d7LalJmCpSlmPAKOYxloj8LAgyl0AgsAV3y8Ey7C5KYHpVYjOYqSfwdJ33uOWPO0H+l78/jIgXb8XwNbmGzRxevAS5bx/6fLs+9QDEzrGJE8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLHYzslG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLHYzslG"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-369576666d5so7363775a91.0
        for <stable@vger.kernel.org>; Sat, 30 May 2026 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780157057; x=1780761857; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deyS35sW7xxAEWAbMjy4W01B6avoqZW8cF9xd++xPC4=;
        b=TLHYzslGLZtvbxICj4FvkKkfMaVEAQR+EDKcKu9Xi8f8pkH7oEZeHJbS3gEhE9Mo0U
         NS+lNnkfdcdvSUlEacQvqFpmmCI2y9BF55xgekUgzvwYFrTSLUvkOzwJy19oXbUWfbT0
         JAGil5NTWbHqtVdTdjtcAVRti04JqBU9BE9kOT1FLY1dWr7/32Qne8F80zsTO/YtZk3q
         pCvVVl0Q51AyKXAwkkHotRtA+lDVTbfjNt5AhcVJuU+hhb6R6vly0cLfx45v8K5aHJP6
         7ZW0INCKyyyGw3ZoUi6plo2JnNy9ECKCtiXlRoW3GFsAPQui8PI6aOf+WViS4uDYaHZf
         ucXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157057; x=1780761857;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=deyS35sW7xxAEWAbMjy4W01B6avoqZW8cF9xd++xPC4=;
        b=jobsVVgZlYO/lvK+pJut8jgYGtZU7gjFwtpBTJyqBVbQY3pB+egM+68QULGT+IfFca
         vLR/RVoWvkrw8GT/ZqQ1diWPE+cKkskeLRgvNLaGo/pP/lputsasZkEJauCMVOuyRG70
         NKkkWT6WY3q4QHPM1KPX00MsWc5TPzPe6IOBEEFMeF949/KeGEpMz2R8mXiq0qMkDMQU
         XvK9Alw+8UHwj8MYqByvDf1ZfB/PH1ceijVKsapWEHzCVMN4ekjyblnpyoI0UtEi6Ym0
         msp5nfr6ZyWpKI5/ZDWTeCffkhGpquaQo6nJ5AksPpxcKHCbJs9ZoKQ+h8aFyvOg9Qj/
         9U6A==
X-Forwarded-Encrypted: i=1; AFNElJ9SfywiyNFdrgIbMzYcsvYgR8wXaYZ6vlzaYTaJ0cfydYeLu+YdYwhcVB9XXwF1+mU3o3DC8K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPP4H1ieWbG4P5C2YF8FznZjEbxPLu4AX29j7rIzI4/3nHEL+
	K6kwUQBKooPH0SJRiKxwPTR17haZIrU5TRSRLbr4xrzVGOvqM08fXnWQ
X-Gm-Gg: Acq92OFNAOgy+MqBM3kV9bZVjQbr2bF1A/jKIxRZWrMF8oNLc6EbdyDDsQDbueTTPbK
	yUBZIFZ/voqe3V1OPYEm9ldpa+FJrsEC/bj4uvBH8T1smqg2zIzq6QBLrzY1CIOCbTqEMQ1gw0H
	M6vuBokFY228fLDYCzaviRscpTC6yNWWcFkrPDpR5UXxhr0SZQNZ4v5Cn+7Hcw4av8dCqQhVwsO
	MvKulUl+TOShBu24t/VTGkXa32D9JOw1Fg7wkivwHGcCW8uaIkm95k8xbpEuOxkuNMPSzP+t73+
	EBqHn8PT0mj8LHREDahfG84iEUfDINX2ZkvLyLOIY+LyOt/poJvE9aoalCzK/GnHt9ur8nmYWiv
	+dg1SApMGxr+sxb9n6wRslOIhE8oHcqQfYFBeppqQhbDcKycAKiwjPqiHys4Nh9RePCrrFWxn/8
	6mFMU4xY4vKoGKVtdhGt45D7PKuteQhthCWnu7wAoS/G+Ju9bG
X-Received: by 2002:a17:90b:17ce:b0:35f:b647:d98a with SMTP id 98e67ed59e1d1-36c4ff24f36mr3607856a91.5.1780157057059;
        Sat, 30 May 2026 09:04:17 -0700 (PDT)
Received: from localhost ([159.196.47.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbe1ebdcesm3308822a91.6.2026.05.30.09.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 09:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 May 2026 02:04:07 +1000
Message-Id: <DIW509R30JL7.1DWMKKJ9U5JV8@gmail.com>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@nabladev.com>,
 <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
 <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <broonie@kernel.org>, <achill@achill.org>,
 <sr@sladewatkins.com>
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
From: "Kalden Elphick" <kalden.elphick@gmail.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260528194646.819809818@linuxfoundation.org>
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>

On Fri May 29, 2026 at 5:42 AM AEST, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.11 release.
> There are 461 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 30 May 2026 19:45:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.11-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Successfully built and tested 7.0.11-rc1 on Arch Linux.

CPU: AMD Ryzen 7 5700X
GPU: NVIDIA GeForce RTX 3080 (using nvidia-open-dkms)

Sound, video and Wi-Fi normal.
No performance drops running Warframe through Proton.

No regressions or stability issues observed.

Tested-by: Kalden Elphick <kalden.elphick@gmail.com>

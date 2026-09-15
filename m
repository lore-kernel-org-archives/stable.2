Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C0C3ACA43
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459602; cv=none; b=lDL3H5lwBkTB8RY4ijF3l0ngAsuLaXJ7+XJajx3SFmDQ1wnwmXE7NojkZ2y90Heg+5ve/+obbr0ykkpACvlrMgmjFWr2NutETKX9CMZtV8ut36nabtWTHyepsYLu9J1Jr7q7O5uwTHG89R+33zkjLSAgmzyWlJPRdwAC4Ap6ttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459602; c=relaxed/simple;
	bh=heCFy2bFPAFPDyeCf8OpyG8vFQyBTqauqjXZX0i22bg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BUnu/HGZknNkBcD9rjrTVKvekYiJE6jEhpmYzO6kBukjinlLqueb8ZhwTrbELIoKSrmVLJHbmZS9uBO2b+kSifl0wr6vyZWvLh4roLC0j376K+wRJocj/9zzdcr5eDaMCY6sMGKgKSzj/fXsthElonXmRbLKikYHDdOmrK38+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WXx1KQmd; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXx1KQmd"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98505364aso4538036a12.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789459599; x=1790064399; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=heCFy2bFPAFPDyeCf8OpyG8vFQyBTqauqjXZX0i22bg=;
        b=WXx1KQmdnlWnDaFGOTOy9pYGdWvh+3Cb0IrnAqrjYMzI5GBEkgU93wW4hIRwBjODlD
         aT4QqCyf5V2jlMjmN1l+NALCkyBKjlMta7gpL/ZeMRDB3vigWtK45lKwt5OnzkEP5KI4
         +LrH+CiPYcpqd+yrK2camCGNXIGJfEts5jRCr63yVMX8Wd8/i9YOiFjUwOzVePneJMB9
         ajnd4JTCaaefZzx/7WOkWjBTKNDgpfdCYbW2Mil58TE+HPbLpAWaYMEDW9VWHzw/l1t3
         lsibGxrg99sap8ezFqv5Qu/RqvVgDegwlzNxCfGv5DYunPN5ahff9D1CH0FGt3oqe3zi
         QB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459599; x=1790064399;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=heCFy2bFPAFPDyeCf8OpyG8vFQyBTqauqjXZX0i22bg=;
        b=MQ8JtSn2sZpQsp5hJHdz6W0N08bQRqCKmr2HMFjaEf9QRpxxt4g9uZ3C+i1Ca5LxHP
         lSbMEnXnEtYP1Ng2ysepTLceKZm3UsA5Nvc3t8IosVawUSduEfbhd1tc2M0n4dFMPanR
         vXe7ISfXnWLXUGNoGntFzRfHwIJKW6olGSbaCSxCgt5VoyGLQnMPukc85sPgpqkofd10
         dYGyuAMfB9g1+qrlgmpqrBNODXr1hcJAERgEg5JnTcv1nNBr/E+IcKY4tth3oCKgGU1w
         ruSR6UQLlCsWlNPS6eK/4cT803ncvc2KCj2RMJo9OnxLY/hwztMcdZl794xzaYUz3JB1
         Y1rQ==
X-Forwarded-Encrypted: i=1; AKwUvBzH6aHs/Pvntfs5K/5mb9ZmsfRdq4Vh+OK+2UWVsXsZuJkwLgoD+/Kz1eUdxIBr6HxxYpllykE=@vger.kernel.org
X-Gm-Message-State: AFuF++nYAR23BlRSSOoU6lV/cnBTe5741mZzOUbrBQYVOq82SsTvPDRV
	OOaNSlQQceOSDKO1ci1MwqV5C++EN1Ue1GhP+nxwpkdAHclxUdZXEz6J20OiQgAS018=
X-Gm-Gg: AYBFou3ZcWrY0pQlFtY8DCJo2cjSdFZNoca2IQpjhLGwzNCBjq4CVUOo36yFm68v6FA
	03RPwlaubuv9qM8NvI37T11BVuqhlZSyaXBukFXW/lSViyMWb4BN/lnNRdbdBUT6aKpOo0/K0q9
	QT9sqg9oVXloTFphM3HiquLUpZcwBPN0KMeaZynYI2BnY7vOSMcyEG+9cxyp+v0iwDi4KiNkTIm
	v+CzWGtJcCbzOQJarjQtaiGx99eO6dot02vYPbgdJlEbyVbW5Yx1v5zHeUMRzXUDJEnNzjTWSM0
	JibflV+BEZKhgLT5S6w94k1oP4MdTAN1lJESXe2z7apAv1KPDg9A/F7qRugnueURH/tXV3vbGc9
	0qwD4HZ2UO1KeO9o4Zx7GZOCwvmlKsMm+vwCxESxTnU/JN9ggWoEn7ucS9CExgCN+oNQsp+0Uf/
	FbHqZeWwIMj6q0WTu5pFVJLAkGDqQY/Wbe2LFzRYOiYTeOHVmlCX39Kj9oKwTvLG0BrD7V5djwS
	oc=
X-Received: by 2002:a05:6402:4510:b0:6a9:9cd3:a07a with SMTP id 4fb4d7f45d1cf-6a9f626e2f0mr4077380a12.20.1789459598660;
        Tue, 15 Sep 2026 01:06:38 -0700 (PDT)
Received: from draszik.lan ([109.255.181.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b5831187sm5396669a12.1.2026.09.15.01.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:06:38 -0700 (PDT)
Message-ID: <321bcc9b1752d7fd2e1488270cb8bf4bf2cb5224.camel@linaro.org>
Subject: Re: [PATCH v3 0/2] drm/drm_crtc: dma_fence_ops fixes
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal	
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, Philipp Stanner
 <phasta@kernel.org>, Danilo Krummrich	 <dakr@kernel.org>, Sean Paul
 <seanpaul@chromium.org>, Gustavo Padovan	 <gustavo.padovan@collabora.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Peter Griffin	
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, kernel-team@android.com, Simona Vetter
 <simona.vetter@ffwll.ch>, 	stable@vger.kernel.org
Date: Tue, 15 Sep 2026 09:07:58 +0100
In-Reply-To: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
References: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-21 at 09:21 +0100, Andr=C3=A9 Draszik wrote:
> Hi,
>=20
> These patches fix two issues in the drm/drm_crtc driver. Initially I
> was hitting the BUG_ON() in a scenario as explained in the commit
> message of what is now the second patch in this series.
>=20
> After posting, sashiko.dev noticed another issue, that was previously
> masked by the now-removed BUG_ON(). Since we can't have a loud BUG() be
> replaced with silent data corruption or worse, I've also added a patch
> to address this issue highlighted by sashiko.dev. I believe its
> observation and analysis to be correct.
>=20
> Cheers,
> Andre'

Friendly ping on this series.

Cheers,
Andre'

Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA438B157
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 05:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785994070; cv=none; b=en/BkZtEszWPaFi+DgeteoZvTDipyyGj7ioPe4nrDZ3xVOfB225fQ3y7500mVE8wWDcFgOKJt/uVmz5WtpVBs8A09WDmuRITBGu12/SY0LuEk4wnXZhMXnsJFnn5GeCHYY0Br7pHNWvJ7GUjlUACUbEdFhVccSPzaNOeUhgSxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785994070; c=relaxed/simple;
	bh=6rrtB8pGPVT07ytC+YYV19x77TRlUWmpfOJEFWshEOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwS0oRdFj9U4ZR5iwp9KJqCUtKQTRFoML5Ed9PBo6hklKvnLPSePN5fo3sEx+6lFnvIbEiuLHPH9beHPCE72gdvfSVPALDvVve2wNG2U5TTw9y5ypuJJAyLBMIIgYz/oFP2EqqlO25yRFYdCu01a3YT6IdpzcRuqLEPIdNeS8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0FBuWhm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0FBuWhm"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so26648335ad.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 22:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785994066; x=1786598866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6rrtB8pGPVT07ytC+YYV19x77TRlUWmpfOJEFWshEOI=;
        b=S0FBuWhm8cbpvJZx0BkGXIbZKySpGkn80EipTvNJ+4p2pSLHkq8kVpseisVfY69M3y
         lhsyMlc7FmqbdKccGqP1pV8LHtCpVdMxikCi9Nj5/SdtvboSsnAQ+DalbLhSjAF5WJ9F
         q5qxROlq0jeXOohQL49Cjy9IoZwtgf1U6aknQSvi+aX5Gm7aFLap2pVaQrYrBeBUd8WW
         K7l1fxwsjPkXFbO0cVbUHIgXFKvvr4PtqMau9vys0q59qrBaznDaSGv31LTqkd4YgjRo
         IurRLozk17SWiF9tDjL9EBNjHtRHqdFoA5iGjyHTWEfLH9F0V6VAvrNeo3SbpEhcOmQr
         RfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785994066; x=1786598866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6rrtB8pGPVT07ytC+YYV19x77TRlUWmpfOJEFWshEOI=;
        b=QUOeHhUGfjXShd7xODXx3gOAtpJ2YkMulyfO+EEaNZYwwUFNzZvzMy45nzCkixMUmq
         wJi7Znf/sCbHp/fwNq3JZEX9vcVfcQpILF/cZcPE4tlXG+qiAmjz01itCrdhOCS2MDpJ
         X/SfWLpEcvM/xRkWe6A1k7HAPMFzc6h2SgzqeorKJpGnlldF7MYCVE4qMkOCli2lxW0o
         uApX+KiYVIkKS8nxrkjVLcNgrX/Rr9Oc96sh9T15eEl6y1V993sxeQ5IfkEw9Ho64cQL
         4gFpkvZ2NlgVfMLh/PgAI04CT9np4emj9WZWVevHoe3+6FlnrUpKaF4yQxfbQhL49OqM
         gdiA==
X-Forwarded-Encrypted: i=1; AHgh+RpNahqgJJtQOeTIqE4fEsS8TQ0KdMIG10bgh+tCtU9vHlQjQBqQamPSs43xN2t5elysOoJtLC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnScZwohga8jFLIgvNIl42IdwPF9riNFrqCwqUP58P6U87Fmd
	e5fjcNIniJer43Ty3qLAztAy+rd9y8OLvUcB/AwLecL2unBJEcWDNkZt
X-Gm-Gg: AR+sD137AoXRaTU/7Ut7fGi6lm3K+rba8PoTIfhtFGrjDRwwq+v3a3/HzK33gHTR3yo
	wYpGI/cTWrhYq4XDMfCl5P4O3Hx9RCxt9KU62hHyMyzy3CSd6BgT/Qne0L97R7obB3+CKF/hXJU
	2Pc52Gkm+uC1JS7HnLLSUDNFEUKKkshuImMvY5xyMvNQcTmt7GDxu3Ess+0A5jEOUSoFtgpQqVJ
	m/yohIO0AbKdCk9Km9KcX233ILdBFkX4PM0a2YsCcd7qHC8yBvSFdF2XRPpnbKOa8zZkwewygAN
	Xtd4fGid187FWz1OjqWy76+0I1CBSI5zK32w5wO8/Jr57Lpdwx9E13/lgGDgmce+URJ9YJvtKRX
	vNBma0Ojrk1EQDVKx+4l9mI9IObuFUk7B7C/vTIOh1MPR7bjgAEQySKeURdGQa5ATn+2ZBK6KK2
	yQcju5TVdeilbC/oI5ZisTQJQbhzrC/TVa6MTWz2xStLKTq87uXtpIp6Y5mB3IXQeu
X-Received: by 2002:a17:902:d486:b0:2c8:1c05:16aa with SMTP id d9443c01a7336-2d0ca984bffmr122923235ad.19.1785994066275;
        Wed, 05 Aug 2026 22:27:46 -0700 (PDT)
Received: from Default ([2409:40f4:1038:e01b:68d4:26a8:ff11:f316])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867d4929sm23908027eec.30.2026.08.05.22.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 22:27:45 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: jeffinphilip14@gmail.com
Cc: gregkh@linuxfoundation.org,
	i@zenithal.me,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
	valentina.manea.m@gmail.com
Subject: Re: [PATCH] usbip: usbip_host: Fix null pointer dereference in rebind_store
Date: Thu,  6 Aug 2026 10:57:26 +0530
Message-ID: <20260806052726.24793-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806051726.24343-1-jeffinphilip14@gmail.com>
References: <20260806051726.24343-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 06 Aug 2026, 05:17 UTC, Jeffin Philip wrote:

>rebind_store calls do_rebind which dereferences udev without
>checking if it is NULL. If busid is registered using match_busid
>but the device is not present in the first place, it triggers a
>null pointer dereference when we attempt to rebind the device.
>Fix this by checking explicitly for udev first and returning
>-ENODEV if udev is NULL.

Reproduce the issue using:
echo "add 1-1" > /sys/bus/usb/drivers/usbip-host/match_busid
echo "1-1" > /sys/bus/usb/drivers/usbip-host/rebind

Thanks,
Jeffin

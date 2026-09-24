Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B947FB17
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255289; cv=none; b=lfo1PQLuSqoLpT+FEkRAZcBMIUSyk7jrsoucoylvTfm+thCWkqmxEVAIyABqGNG8jl5MYYUjyjR2x3qRo5Xbl2ckVEljWXWsx7KMBOluVZQzo6oVfbgUlw650DN8IuE39LxZyIEI6jmJLfGh2aUCkMJE/fD1Cs/lOBi5bYvUIG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255289; c=relaxed/simple;
	bh=b5tBw1OWTW9anYfSrkLvoNb4hmDJ1qh/u97cT1sgxuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Wr9khAQLeyqjCbTdqcmJeoIxIORR9E9LvJMOQS/VJKCUAYwb7/paRAegBAi1DMf07xH3VkruS/YB82RSZDQQ9QtM0rzm2cDliOL/rgE2fZp4muQSP9Q4lbLB8IPzFy+4ocV7oSa7JfEkx2ajJeuGufqoGADwW5X74yXxp1ryKLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P7w4Y77M; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P7w4Y77M"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a4aso281232466b.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1790255285; x=1790860085; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SkvVSwE3EAXQkrsnsyLf5UySEA7ECtLpxiG/B9QOEQg=;
        b=P7w4Y77Mn2w741nWFbF3DiMqTHohZABbZFDtwSCKEXJPzUelM56QwnNaYGURM4tR51
         kpx4ko/+cSDh7prjuN01lovzj9AgIs4oIXra2C2q+c4k8N6U18cqMvu/Ar/4W9rCGyY2
         v+zn9LSdYfg4DpoylyKZ8TyN2SGZcUBMiDid0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255285; x=1790860085;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SkvVSwE3EAXQkrsnsyLf5UySEA7ECtLpxiG/B9QOEQg=;
        b=jIMYwCmALPadlEIH6Wdk/Gt814FK8YR58FGHqbhTO5r0bPy9s/bh8zpwbB/qutrQWi
         6VwdzBidaNtGIqhABrrU5tTOtKcAV0PgKJ+un3pMmMGh4GyVVQdvgcPt32lpfPMZYDuh
         W3/CAotgDs9Yhefb+XKbKXZ+JpDEo0MXpJDzoaIlnzu0wWycuPyhLPzIpyUKwV1Fb2Ov
         0VwEmnPtHcLC+pWWJG3MZVuCGkStmuWQmzFLqGSEuRCEsFAP7zNC5FIo89bH0bHYKaXm
         VhpVPpm6vysS2qYKEaRzqP67nE3W9pagq4f+qHUazAkEzcEt31no3Xe/3vOGLBDNJlw2
         19IA==
X-Forwarded-Encrypted: i=1; AKwUvBwswEL6RRBySTTahKgRQi7X5LEWRe4YNvyKaboA3A8YO/ycsmVksOQUrIA1wYS1EP14FG1Aepw=@vger.kernel.org
X-Gm-Message-State: AFuF++mZQvCJcX4pE3UsG1/fvCS1mQ7S7BaLmURGnbi+LeW38enU0Jp1
	ZTkLSrWe00d5Sdx2d3C/po9apnFBFzaZUVHTBirgoc5xZ0GKxM8yYtIiHwfHWDO3cnPKrxo1uT+
	ualEwrPk=
X-Gm-Gg: AYBFou22atqxudlArml8KXOqK73Uv1WI+VVuDhd5WhNFYYAZttYEYVRAyfUjq6bO4va
	tuwSGp+LNWyQvghCBxzcXaeQ0PRYj2wCujX2vv2JdPedg2PvxH0odIDYsPqsBDsRl7JZZ5irvcU
	9EvBgVjc07OAvUZH4xyHfZ0v54TioEHde76FyaRsiurpAD0qb9dQaBqMOCSnODZ4j3mHWNR+4Xg
	GNyLeSjWzUAJO+DuqWn+cwJNcDqD6vE/jPd5PQrySYemua3/NOLwtMRxMi554aRECpCZiEtLSaB
	kXNiJLQImcWD3+5igB4o1pQUmoIpbqMyJT7kMkyY5SXpLg8LpD+TXkxp0MJU0ic8Xmj3yJqw+ZG
	N6BO/3k/e288AvDcV19mEyiS40MMuZrDuuvjWwFIDRWRgNpczCjv2q/YWDsPpzH806iL4nnFemT
	xfH9iU4rH3QHdxdJ1WbUUPrAzYvD2aLw03pa84QwCKehhkggELiB866hqAJK6RHEP1uuRTMBuZ+
	XQdU3eGG8gawy/37e/2G8JB+OE20ZYMYnckKxgPj8NruQ2cKIcXvGkcyAXV
X-Received: by 2002:a17:907:86a2:b0:c29:f0a4:a4f8 with SMTP id a640c23a62f3a-c2ac50972c2mr188194666b.0.1790255284948;
        Thu, 24 Sep 2026 06:08:04 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae60e4c8sm291720066b.26.2026.09.24.06.08.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 06:08:04 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a56so256763166b.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 06:08:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwFTNp8gQehr+yAzFsH2KFZheUvui3Cb7YgGjgp+r0EjPQ7V1e/ilKZi2zQBwlIF9yhPWIGdqY=@vger.kernel.org
X-Received: by 2002:a17:907:8691:b0:c29:5420:cf78 with SMTP id
 a640c23a62f3a-c2ac5521ee4mr166938266b.45.1790255284248; Thu, 24 Sep 2026
 06:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924032636.GA314300@sakamocchi.jp>
In-Reply-To: <20260924032636.GA314300@sakamocchi.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Sep 2026 06:07:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRVQhcCGHCA9LL6oPf5CQe2Sw2ru_Bm-qJz_bp-dZVmg@mail.gmail.com>
X-Gm-Features: AclHuK-YDZhU2xM-WhDeYIRR4JvOEWB2H3VNVQf3esI054-WSXnmZZJP9gVpznE
Message-ID: <CAHk-=wjRVQhcCGHCA9LL6oPf5CQe2Sw2ru_Bm-qJz_bp-dZVmg@mail.gmail.com>
Subject: Re: [GIT PULL] firewire fixes for v7.3-rc5
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux1394-devel@lists.sourceforge.net, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Sept 2026 at 20:26, Takashi Sakamoto <o-takashi@sakamocchi.jp> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-7.3-rc5

That's actually not a signed tag.

Can you please re-do it with the proper pgp signing?

               Linus

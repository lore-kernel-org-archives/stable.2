Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0D041B8CC
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218645; cv=pass; b=e3RtPuYMWrv4QTjtUc+zeg5blQ9vrbqJZqYehbUWMsmqjfUbslLIsLhQYBBdWwoa7evXcQf2lkbsICuApYA8WrEjMEo7kK9IPSeYPXxnXHV70DakOenj8s63GgcZzxa5HtXUhZxCTtBF8tMHdLWTPFX4K9In3wFoQA/hOml/J6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218645; c=relaxed/simple;
	bh=b3BuLr4nksiuTdGGbza0+L/t26x7/BGw9nuugk+E24I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRfnniYJAmfldo5vnN3nBTc6583rN4bFYb+CMkP7v3xao5WCIWo04mdStekdfqer3THYtFG0XP73PIjk6KNm5GQY9DOxiqaRc2Gpuzcm5M2cv1NY1c0/Excu8QYXFUn3qynITa9Ywd0a90kRbqe4J459p3E7eUmcuFvCjaYyTt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBMKRMmJ; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBMKRMmJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2db3305f94fso26788345ad.0
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 06:10:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789218644; cv=none;
        d=google.com; s=arc-20260327;
        b=hyuHriSwVgvwEO+vxwMvmC5GiYJpu99tcr7rS0us5nkv7zXjKESLv4qK2NgXEIzgVK
         d9GzC1p8jT57/yNgHKDJN92LwCkGmkSkQLkwEihNLAX37diuy/YV4uxeDiXLJJNcfIQM
         /mPSe835dabgwsxFoZ72/UutSKeBFRcqeWkhqU2Exk7Gn+AarKyNjkzHmvRhcAPezama
         zlaIWnckf0AToO0ytJxfv2Pd/nUu+9jviJbFUvWTgIbhmqILehKFPpW+CT7NQ/CdhTtT
         SD9dZsLmsYapkIaMzwfxxgUWZt7x4L3lIovIVxNLHH1Tosq53cnQ3UTP98g7ejJndbaz
         LU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b3BuLr4nksiuTdGGbza0+L/t26x7/BGw9nuugk+E24I=;
        fh=bgPP777//GoltfnfeAveeBcwYDTzFB2Zd0kc182tj4c=;
        b=hC4We6B49Bz9Aw2AHY5yvsP5w3rzZfMvcoVtf2Ta7Niy84fcVFUVNKZcAhojjvhOQN
         us0bXgPV6lyd0nBREVbG9M2Ov2Wqv/U2vOE4dfVuYglh7YjpufKoFNfujiVIql/3bu4i
         VNfbCufAzkF0kxoqG8jaQ1Yv3Tk3nm3H8sEUqharknccHh2nTl8lwW4XkBOBiWzUA466
         mNq7FjShEccV0vJWs4rG7KDwhIN5XLBaEYTvdILO1ywv9gEHY+oHwT0Mml32CKf1y1Pk
         sXg1dsNe4MJySayqxA2muvsVobC3G1vUTEwgGg4ZT0NYRg+uNOBUUZ/RK9JqQt1Wu2j9
         XYCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789218644; x=1789823444; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b3BuLr4nksiuTdGGbza0+L/t26x7/BGw9nuugk+E24I=;
        b=PBMKRMmJlHHN+glabFodlZXANG8S10Biwr/+jQYPx852osBMWDJwgEBL5JkfCVGrtJ
         gObcDxPrubpaq3lpCPseaGZpta215F5RlKdFhElZilV2lEP11QPGbDVLPmWF/8Yp32ff
         nqwvJxKVh8Tq8cP9cS4BqQ3jt9Yl58TTvwdqZ+LVB4UGi/QX8zjEjhooUjFKUK2DB6EK
         SKSqmNNqtYBttBrFAkf7Me3tdToPssxLgysYyXBE4ZY3+mCmY5CW3xaKJhkXNEcDZN1u
         8F1JwQzR+awFtxHVGlWMOib963siRB3x2DpPLKYLpx0htcqYn3DaZ5V/DfiY8RRUccIk
         DeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789218644; x=1789823444;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b3BuLr4nksiuTdGGbza0+L/t26x7/BGw9nuugk+E24I=;
        b=U6G/tAMRM7DAgl6V7ijx4VASUNjBFDtccknZJPN6+iJKOhT/jlUhuEZn334FjNdLDl
         H7uqMEi4Ap/ltteIYtUxestaJXpSk8x/wSVo/6mObDpDgd3+0vKB2/qnbZ5jai1CJZnt
         qHqKoS8qHTwYVjfziNS6Q9YfsneE9fnp7TocOyPVRNO0rXRBHzo21LFaRaMdszkrKwGk
         4Lg3Xqrrz0OLPu/7mQF5jf1LkAwyDqJhJvION/rSN6hItSL38dLGekNUMzAeKWpXdZmJ
         //ZvjxsEVkA8899C30vY/gESQ2QuFhc7ppiIiliertz5cTCiFdvStkafaE5YjQhOkzk0
         CcWw==
X-Gm-Message-State: AFuF++kBy77ISWJsDZszM1tzX4HemRvGyyj3zx8jkvN7d4lqflql3UmF
	6c+lsRb2dbKhS+RdSExxfLxZ8k6Y74gSKzbrUNpMrekV4Br8ISvPNtAxBEUQDVTzS7tK/H5GNeD
	MVh+sZVtgeC+HIYFy1y105LIV6xg1Na1v0zs7
X-Gm-Gg: AYBFou3pUy3VErt2qtQVcEyHfbNxy2Z7IoucHihe6l7FcWEMlZzGVCdTUHia3Psb2gg
	Ts/bIwMfV1YKS8p/OP2C5iY39PL7jwmg14lOw+3WIjDhUks5oiNMs+XhLnMNcFXo3jbQiETrd7v
	wiqtJ+d4Mk+W24LlF/8xrBiI/MS8xEwiBSCYUghgN9SHQPWWw7lHFjENeR6dYW28GEm+gsANxi7
	8h2ddv9oJfVvo696Em4TjrAPifSkB5+6hHv33e6YMxsGUEodhPNYseTXRKA3uQTFwNTCM472NZL
	HgQRG8jHLRCPl6Fpk/BT9qN36WcGJhtqr/lyoVHWJ1sC1ahkAAQ7WPEPCS0KcG3SrLEtrhVPhA=
	=
X-Received: by 2002:a17:903:198e:b0:2bf:dd0:c8b1 with SMTP id
 d9443c01a7336-2dd29ffa6b4mr172203635ad.0.1789218644005; Sat, 12 Sep 2026
 06:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912065648.999753832@linuxfoundation.org> <20260912065657.541103882@linuxfoundation.org>
In-Reply-To: <20260912065657.541103882@linuxfoundation.org>
From: Yee Li <seven.yi.lee@gmail.com>
Date: Sat, 12 Sep 2026 21:10:01 +0800
X-Gm-Features: AcwNN1Vk9KvM0MoUqi-HCq56xMnk-5e8FkCUOTA2kTsLggWab9zKiXk997gdL4I
Message-ID: <CALX8JfSjnAd6bY8zBCHuG=_+f4JiVCrhT+sW4DPEpUM6+5LF-w@mail.gmail.com>
Subject: Re: [PATCH 7.2 0368/1815] iommufd/selftest: Fix dmabuf leak in iommufd_test_dmabuf_get()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

Success path return rc was changed to return 0.

Please refer,
https://lore.kernel.org/linux-iommu/20260902085414.549830-1-qinyuntan@linux.alibaba.com/

Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35AE4AB1D1
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280526; cv=pass; b=jfDHqg47+JEQqqBKGCD6LckL0qr92zUPcaKwfpI5Up4ovFlQSCg0eyOCcjktD+9QFP0iuWJqQlrWuet0AiWtyabUkmosI7lG6uiar5wqP7nepR6SUpMSBOAilL8Zn0zrIqcIo/byZAhFqQQporIkNPoxlPq1HWbiVE6uSBgET5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280526; c=relaxed/simple;
	bh=RNSm98fgEHKdHpWR7CX29C+rFj4qcatPCgl55FRB0yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIv+z9fVQs+/4WVpbOSmaIT7ajo1sBXp6tuwQg9nOS34TzoZWRBGj5ZfqbVt/+w/65bsDQ6MMOXnaYcR5XIhlCpHGlJHbjUL/KEfmuvWqOOjRxSo6/fJ43P9TwTlcm4T2NMLtb4jWNjQ3RK2NSiAYOusRl8o8MW810Zjcy3UFD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ/Ty/f+; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ/Ty/f+"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b1eso26858266b.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 13:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790280523; cv=none;
        d=google.com; s=arc-20260327;
        b=NEUZJiGM5SYuvEcsnIF6u+BZpfrv0tNoEtuZZf1ZjvelU5eb6SIFaivS6JrtmJO8Ph
         TtsdPIqN6pLu8iK3hkKNxMzTO5ymRbVQB6sgQSZZEgSzlKA1stAoNRSM4FEER5OaF0R+
         EoKWPRdkLaoiXIxPow4ZLk3bBxCclcJWuSUx1u8dZJnieQmxLQ/wTjFZ+TlGOrUIlGV6
         xsk9vnxZTtmmiGlX3XyuLZAIPaWNdSXdlm+H4qDoi1aRojgXRmNkWwbAACHGZGmmcHnp
         G24IBBN3otYrlW83lcOMCpYi1X6/eftEZSj3lx9VXoaHlDu0A1m2+mLZXx4EIVC4Ih5z
         q1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RNSm98fgEHKdHpWR7CX29C+rFj4qcatPCgl55FRB0yM=;
        fh=1+m3jLAqzVW4I+RPVB/PyTUFa/Ug4HLnUJ7Ud2OM8xE=;
        b=aWzsUpvqOcYLNyc86z2IHQ8LBrrdmQZAJVx9MTSBcPGXljEmIuB8Uf/TIwuMhy5sID
         znzcpZvR85pE2fcwhBuNJeJljcSo2XZ3gsVzDnJWXgE0VkLu9rmRfoj8PHC5NBxG/V6w
         U91XJIPMI1J4Y9bifvq186MQmSinbXM0Jpjz/RBGXY59d1magjGPc12uXPlb3kFGIxsD
         blANBp+1yWzVci/lsrmskWWo+JSqvCqoe8xojybMN8x1nVTX2ew/Hw5RLY2I95hqoHi5
         skx8PHltkTNobxZF5NETCd6+JTGYvoEk+1wTmFH+ElP0bwOmmTQHdUumxnAl90SiJhym
         dhnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790280523; x=1790885323; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RNSm98fgEHKdHpWR7CX29C+rFj4qcatPCgl55FRB0yM=;
        b=NZ/Ty/f+M2VyjD4sjRWNH4RgktHNCorEHJS4XpGWi80kUFuByGlMRmcET09zXM0c/i
         rImvsFN09G9ummavVpxQ2O9slzgf77qFJeTaPcqOJhgRqVGnA8cnUDjQRt3Z3bK3xmfp
         YJXJ2XMxi66xbIOpsog/D/kCCj43Clrw/P95opB8elhjPA7RjpWx5VZvGvI+5nTrmhPw
         BexEWrZggwE8Gmd3R+e28roYbaWX2L057z3zpAMn1T9409tF+3ikcDyhNouMTEfDwHam
         wPQG37LEyDwIQHhyXN4i8OLU6P9HytF9wwjdWhGoLt9+WpfQlgpYZVR0ei75Wtb9TNkY
         tX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790280523; x=1790885323;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RNSm98fgEHKdHpWR7CX29C+rFj4qcatPCgl55FRB0yM=;
        b=N/rFrHvrlOmr5S8VecfqzFqis0dhehKI/6qmtYbSwaimjsFHCJuUZCE+m7Sjzl5Dz/
         FnCJ2Y1yNDCuai++/B8EBkFoqG1v8uPh+kUzDzmflwbfdk1izYuQOtIy99rvbJWKSf+X
         P3tqfisIauZp19zVDgrj65YRImh+xV35DhJbQI5hp/r+xK2kvMfxAnPFnUskF6XDGj+x
         hr+amL2qOcfeo9oQbTI5LNGqTFuILsQgyVjBXuMaGUmJELm1rcF7+F/1VNnwqVHimsa6
         NbnJnB7klYUn5Jw4rtaudS8OeLYYk8zKZbt7PNrUvuV2SWVLzzOsBVVvOoNRP43AdcvS
         xOuw==
X-Forwarded-Encrypted: i=1; AKwUvBxKhtKqqkuDj72LAjCknsPA1CUWain4G/H5oNDITE4URGfR0W1yXDP1RrRthn0M8EktRDp/PIQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lcJL7hjaHNZ0yRJfv4AYja1Im9f1xWZEPuk3UYvDa+WvH6QjQ8
	YZDrKBgDbyJUq0Dh+wl+vbFe0v7CdvdyR1xTLHgXHYggqKCjThbgulO255POgWCcpP4SpY5td6i
	OA919ntYflQuGz+m1m4g58wnzPse+jIw=
X-Gm-Gg: AYBFou1fHWh33rWd83ljb3De5uPrlhjavMF96G6dxr6lpJdQU3GJgVNMs8N9GbrI4Bf
	7YHz0Mq7oXimldJ5NmrUod9Ko4iqfsBNIk+2vQHtb0uoH1badFWy2zoQ1N96FhjNV7s1CCMDylk
	NHOz3Gjnt2Zs+mvMT+657Xtvs7tGV34A8hm2XgHOI6im5CqWhKcH8hpiuSPGX6QOVKF4aEQJpVB
	Yadm7olfBYK1eFmBftLVc+PQnyfyz6cUk9jWW8DyDWHdvU88S6/NSTB9nuub6b5QZnLfHV7EIEV
	XEOJ0+iA8O3H1Vm3Lh52fDDPKoCcngTnrB+CoRx6maKYC3Fs0WH5V3fn3p+h1aG72ly6PRQ9lua
	9C1820SZwYCIe7zcSP8GzK/4WydfQtWLZPIzRCY6DOYEUZr0ycA==
X-Received: by 2002:a17:906:8d8d:b0:c29:c213:1ec9 with SMTP id
 a640c23a62f3a-c2ac20ab8ecmr322667666b.9.1790280522730; Thu, 24 Sep 2026
 13:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919191524.268810-1-meatuni001@gmail.com> <3aaa9d04-6bf4-46a4-80d7-9828405b7468@linaro.org>
In-Reply-To: <3aaa9d04-6bf4-46a4-80d7-9828405b7468@linaro.org>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Fri, 25 Sep 2026 01:08:31 +0500
X-Gm-Features: AclHuK-fj4Cn0W_vYW46Cg7xkxnoo5u25tZsTVZNPJ2G3OF9fblSULPtGigaufI
Message-ID: <CADqcGBkdFjoKF5Oa=zVshe92ay87CFUu8KzZHARB8WV6ajVXbw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: tdo-tl070wsh30: Remove panel on attach failure
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	sam@ravnborg.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Neil,

Thanks, I've switched this to devm_mipi_dsi_attach() in v2.[1]

[1] https://lore.kernel.org/all/20260924195512.336690-1-meatuni001@gmail.com/

Regards,
Muhammad

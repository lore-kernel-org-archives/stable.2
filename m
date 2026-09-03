Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570844968EC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436280; cv=none; b=fjcy/4Pzarl1Mi7cVTNyeJSrrpYKcmsUzqRRAQxH49xoTyIobnDuEi6/eyZSeDI1hk7mgdF8cmRcHALIfgMHJPB7dxL/+rTLnVg+fo+xQxf6jJFNP9vxpo6/DvxtM0SM5RbVem5hDVIH53cR9Q7w/XSjfj98eB1b0QB96eUXLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436280; c=relaxed/simple;
	bh=C+QWB+KZzeonLvV0qDuesLnMy5eu8R+OizXBY3d888s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1KbktzwKoTrw1wT8PIasf6dCO/QGuGBuIlbhYeoFFoxydICmJN7BWNCcTmcp1nUAUjr255rFZnR7U7YWlHgjAqDUDqf7i1zcW7Rwd0evy34xos6/rLTMsrd5urrBKaYAjncbw9NaMfFOrhObaKNk9zBba7wdW93kRQfI9vU0jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuMsJK6I; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuMsJK6I"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4843e397f74so1317073f8f.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 04:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788436272; x=1789041072; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1LiMV9lpRiXnBE6CK4fygOV5eeeeR5AdD/GCs6lVbQQ=;
        b=QuMsJK6IPyQoldLxUmoNS8vlhkN23066FUD8gMtVLSfPwrcA0V8B+oGC+OsBPzuOHr
         YIPb4F0p4CrJSOvCV0YUbQ086PADTWdAsxcinxy4Pm10a6gzblDtcOeMqTe3L5WrYzq2
         LkKA9YNCMkx7Y/W+6pj1HEx5JBSBB6GXoFdOeoccfNTtyxmSsRAXKxVBIcHRkJa6LHdk
         3J8xI6RTRiGT0rTNrLg3l6TpB6GFKWStuO8RCY/CNSvSXcpfmJw2PVfCwX0dxrOGuxoq
         MPUrkweb4VYWWqu+89gf9nHf0oucmQmNnwVC34o9XTdW+iU7kqW+PIn6ob3tfV3mpFDs
         qFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436272; x=1789041072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1LiMV9lpRiXnBE6CK4fygOV5eeeeR5AdD/GCs6lVbQQ=;
        b=nD6C1LIwzpLDwIHhMaskPlLEihtfYl0cYkdOW6cJd3IEGdvV4fXGm+ssbONb/SnGLz
         Ys/pJ5hT+JTbQUJ1qAQ5fWmKcUP1ixLptJnt4Fm3dy4ZdSqSBdmaU10TnDnefTlkiB+L
         HvKdIXAwRwJJdX+IyR6+nKeG+EcMGhbbEstp/1A2a7v1CHG/jDXeWa2JP2ZMulm+ek/I
         +V1a61l1xpqpQh1mlpMSCazuK5ZABhHlWIRa3NOF1ifkw5bgd6o0wbAXOuAXc7jSTxGS
         RfUCdTnrSrmUA7CTDVyhDB7VfKZRFSwdNYtPsRXBaWVhu2kepobE02QvZoy2mb0BRDK5
         w7mA==
X-Forwarded-Encrypted: i=1; AKwUvBwTJLbR7TmTWFATlSMx6kp9uyjdje0JAYM4ML42VPukCM3a++ltfU3VJfRfvoInc8/PcSYpre4=@vger.kernel.org
X-Gm-Message-State: AFuF++lTEVHfp72t166qcf4wTBD8HqE8SrUISE/xhNIs2zcjeoF1nFxl
	+LnPLyLX6aZ5zczI6MlJwGzOM3OobYg5sFPJL3vxOaz0yH2tkffGiWlF
X-Gm-Gg: AYBFou1fPBCjADGZfSvunvk9e92vY6iafjV/AQQvoEYFb/aHXJfas9ozTFDad79/Md1
	ERcNzH5tC23h4vwqX8GfraIUFc0jOUJCdO00Y9EkbBw3Q34sbelyVUV9GZMRml8ZGdpAMunm1cG
	J3WX8lMn9X7kHFPHcpDu7OlG17jUzCMtYJPcUrjppNt4FLEfL/Uti/NB5t35RvU+glYLHIaAElS
	RN0PMPNf5sTZrDjh2Kv4J308MSPWzKQo5zVfbyFfqe9OVaLZ0SZaAGAhNIBwddBIgQfBkuZB6l2
	KCoVigzQnMky4VmHnqxWlhjvuqM0aRshmU5UdypxlAeHS5kj6oJ79WdmAVjS4CvS6d1XmB0XOFg
	rZqeoJ/UZJngIvp0QLC7QCpKFghYS1I0BkVtG3AAki0zs+igCZVUeZ7dyNf49d8PcTQAQd4qub2
	vjYvEQfUeL8iSouHywpM5D9HJXmR21WnYRhYx4A+NtNfStP1UQSARHNK9QRcYpI0jqGcXqhEGz6
	CgoMu4/OGoVahLGWhy+EBootN3sDHijt0BGamFDPSnlQldXVBTH9MoX7JuQvd0nMezmzjN8Gg==
X-Received: by 2002:a05:6000:542:b0:484:361a:1c7b with SMTP id ffacd0b85a97d-4857e4eb54dmr6750369f8f.7.1788436272260;
        Thu, 03 Sep 2026 04:51:12 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e6f604sm13185506f8f.2.2026.09.03.04.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:51:11 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:51:10 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Herve Codina <herve.codina@bootlin.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Linus Walleij <linusw@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Leonardo Costa <leonardo.costa@toradex.com>, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] of: property: fw_devlink: Follow GPIO nexus maps
Message-ID: <hxtrtbmfb3jznfw7ooiyx533fzuuagxlhweq6yo4n6j5bne2uh@omibim7aiobk>
References: <20260902-fw-devlink-nexus-ready-v1-0-68fe1996e78a@toradex.com>
 <20260902-fw-devlink-nexus-ready-v1-1-68fe1996e78a@toradex.com>
 <CAMRc=MfN73=K1nZrqUbhrMSijjpzhF_z_U9JU4_H163W0vRpqA@mail.gmail.com>
 <qg2nemg4mlxpancg7az2vsnjkfc4anxkieozoxh3mj3zgkyifd@b5b6yiz4uew3>
 <20260902185513.4867bc92@bootlin.com>
 <874ig664ih.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874ig664ih.fsf@bootlin.com>

On Thu, Sep 03, 2026 at 11:57:58AM +0200, Miquel Raynal wrote:
> Hello Ernest,
> 
> On 02/09/2026 at 18:55:13 +02, Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > Hi Ernest, Bartosz,
> >
> > On Wed, 2 Sep 2026 15:22:36 +0200
> > Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:
> >
> >> On Wed, Sep 02, 2026 at 05:30:19AM -0700, Bartosz Golaszewski wrote:
> >> > On Wed, 2 Sep 2026 13:41:39 +0200, Ernest Van Hoecke
> >> > <ernestvanhoecke@gmail.com> said:  
> >> > > From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> >> > >
> >> > > GPIO consumers use of_parse_phandle_with_args_map() to resolve specifiers
> >> > > through gpio-map properties. fw_devlink instead parses GPIO properties as  
> >> > 
> >> > Unlike PWM, there's no such thing as "gpio-map" properties.
> 
> Just as an FYI, there is a pending series to extend the nexus
> node concept to clocks, this may also require some fw-devlink magic :-)
> 
> Link: https://lore.kernel.org/linux-clk/20260807-schneider-v7-2-rc1-eip201-upstream-v5-0-8785f9531cf0@bootlin.com/T/#m16ddef087544db31b5f434fa44be70aad0b5e37e
> 
> Thanks,
> Miquèl

Hi Miquèl,

That's the reason I put you in cc and also the reason I went for new
NEXUS macros in this series. Clock would hopefully be the next consumer
of that :)

I should've mentioned that more explicitly in my cover letter. Your work
on the clock nexus can certainly come in handy for us, thanks for your
input.

Kind regards,
Ernest

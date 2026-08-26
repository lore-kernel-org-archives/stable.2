Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA73F58D9
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747741; cv=none; b=UGbkKJDkFFmy84i0kjcSjD1doKHEsE8QYfNkdP+2ZJVrieOsojjxMI3AkIBu/D+FlsHvULY7O+i3XLrMOLlEhqyjMvpa7bZJsr8Zi7ismR1euIPcFqvkMz3eGFZKWc9OcOemWdeLjZsQtyecfpdTzuGrnhJ4gwSRlqQW10SSkWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747741; c=relaxed/simple;
	bh=VjrLxq41uw4BiWdFbGzXauFX3ga0sq0gdX7yYyoSq50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sG++9s7QWLdFwnCxqMBlXRBhybXy8b8g2Zonw+sxjusi9YQUsZCFJYm9XNYGVB2a5lFjnoMFem8JBrqwFhjWgS6yot+xzSYn6HO1KBGtieWdj+iK0EZKtvTPaPLzrStnqbs7imnP4yI5af7mszA7CC+kOVgR90VKI0CthqbyAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhesQrLX; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhesQrLX"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ee4399c3abso952541a34.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787747739; x=1788352539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VjrLxq41uw4BiWdFbGzXauFX3ga0sq0gdX7yYyoSq50=;
        b=dhesQrLXb9fihi+n8MxxbAcAs/a1aOnOA32/+Jp7NuKM4v+DuVroRc/w6fM05YuwSL
         fdRCHXS78CeY5qKCRky9pgKtm8YcqUzGaHxac2Hn0i34BZL0Rvj8M+FBBlxGHwjBQbQ5
         wnbfisQtWC1cz2xWD8uwjlEkC3e0+7PQOsDStaeNeDLHEet0qejvndPH/obYvukGETOE
         53vdn0/OT26EKUuzBRavr/6ON4ivOrzVFLAIkMmdmPDVPyKQPyyqVDw6RnDFZmZ2z7ds
         C/peSkruINVEjpaU8VlvEgFgwHxB7iB2L76E829+iXIEVLlKtRiNg1n1DLfe7PavkmJi
         Vyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747739; x=1788352539;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VjrLxq41uw4BiWdFbGzXauFX3ga0sq0gdX7yYyoSq50=;
        b=X9DGZVzI1AstUNd1SagpYvSgnU48mJSZmVxoA3UuyDabpIf7f0Pma54S3TmOLCO/D2
         d99h172fjHo78bwj6QcVEopsH3UnQyeqke8+hbUmNuHTNAlSFfP4HEltg+RLlLEv66cC
         LHyNeQmxk96HqU7JzLyy4oOPI5uBkAU+/yP8UItynjC8nybob17TI9c+7RrXsSQd0sEa
         ytkl1VxmlniVT+sptwuvwfMtSv2MowPyNgMC3j9sXxKyHLnlyJh6czVxrJ0hEMuGKg23
         J1dMwupE3Dr4TiorbOIIIUhaqIekObF1mICF0vaNoogAbgRjMp0Yi72QnF9SBjWMViqG
         6WeA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6pvEQeS3bb692GAhVpm0hmkFeDtZRSajlCWXNKD5MMgvxTfN2aGAhD2K7+wr+s5nL4HE/on8=@vger.kernel.org
X-Gm-Message-State: AFuF++mkpU7unbS8nSFnguf5iq3EJa/ub1+pGbYAcZ1KJNqB2EWa9hD4
	YOYT+slTmSEkEakWc67APeCOxED9VDgElcfb69R4S6+7poWM8b9tXa4S
X-Gm-Gg: AR+sD11sBDNi8y3UYuR7NOHhWnWCXVI+CBTbiQWXKUhWibBOGWew58FWI6yqBemRNVu
	r/grdBjDGz+X9+51gf8N4MH6q2oxhRTUN7SsPHSNXB239o/REgTyFpyO3MDPWKw0xHawiQ82WKB
	Napg7sbUrtIEeFARA/YPIz4TIemmoHSQc+3Xe0iTyhelhiHVLGd53InviFvvP3h0oztxoOW80G9
	/mNawFU8gmGOeSbPIOJae4XR9kYmLr8bridDrRl+t1df5Ku4ezxqeOD93mf0gSKC+NxGL0umWdN
	j7XDcSPwoI4sWhVOuMMJJfW/c3alYkQWtzE7gRf77BVzo943HqYsat9GSioBw99uqgv3SpmfMWA
	oUzbD6anQVBicH6CJfz6QsJU+LcpNnsC5Hw7r+hBlge6dlchRkp9kzwuLlF+woBB7wz5BS8dUCs
	0foPt4oJmcscMSN4BaUgE/S1UD35+d/GwYkCFzWc4RlulDYnOdjXs9PYFDqm2InN/+KKykDfZYc
	Jo7C5SKaRuWMPkcNi6Em4LVfKAcnw==
X-Received: by 2002:a4a:ee0e:0:b0:6b0:4170:59ae with SMTP id 006d021491bc7-6b1a04ffdd4mr5407369eaf.27.1787747738713;
        Wed, 26 Aug 2026 05:35:38 -0700 (PDT)
Received: from localhost ([2409:40c4:3158:4e86:efde:1f4:fc9e:35b6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eefd98sm14998290c88.3.2026.08.26.05.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 05:35:37 -0700 (PDT)
Date: Wed, 26 Aug 2026 18:05:34 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Mathieu Fluhr <mathieu.fluhr@gmail.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Mathias Nyman <mathias.nyman@linux.intel.com>, 
	linux-usb@vger.kernel.org, regressions@lists.linux.dev, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Forest <forestix@gaga.casa>, Slavik Dev <developer.slavik@gmail.com>
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
Message-ID: <ao7aLXk9q_v_jEyX@eggarch>
References: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
 <CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
 <CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
 <07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info>
 <aosGtkE_diwVJJtB@eggarch>
 <20260823174059.46fec036.michal.pecio@gmail.com>
 <aoser8dLytrwqBC2@eggarch>
 <CAPyJwA8m_Xd2oyV1i9k+-6f7A-j0FiC97yXL=Ci8ZAErs5W4vA@mail.gmail.com>
 <ao1ovvdPAy6n_F7I@eggarch>
 <CAPyJwA-QALkCQn8J1+=U-nuE_7WSEPhVcUEKb+MMYMaA_1AVjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPyJwA-QALkCQn8J1+=U-nuE_7WSEPhVcUEKb+MMYMaA_1AVjQ@mail.gmail.com>

On Tue, Aug 25, 2026 at 11:43:22PM +0200, Mathieu Fluhr wrote:
> The patch you sent makes the issue go away. I am now running the exact same
> scenario for 2 hours, without any crash.
That's good, thanks for confirming.

> However, I am not sure if this can qualify for a proper fix, since I
> do not have any
> external hub connected to my motherboard: All my USB devices are directly
> plugged into root hubs (and at the moment, there is only a keyboard and a
> mouse).
Yeah that's the point it only skips the 200ms hold for root hubs. The
external hubs still get their fair hold since a parent exists for them.
So external hubs are completely unaffected by this patch.

On 'proper fix', I think it is, even if we keep this bug seperate for a
moment, it makes sense to not give root hubs hold they don't need.

I'd love to hear more thoughts on the patch.

Regards,
Lovekesh

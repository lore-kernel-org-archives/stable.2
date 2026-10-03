Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20EB18C02E
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790987607; cv=none; b=Ih6dZN9Xptot2c/Qx0nNKY0yiSvu629QptRzWHgvai0KxGL8+3fYY+Q1OylfusPUr1anF9HfuA1Q4QUdoR7JGY0FAFe193aeneLSuf5mNjL/hGiVEqafOFOou0uThrsGQmxOl2K/FVo7pc1ZErpeEIBFBdMiVpTmdCDgH3C4uX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790987607; c=relaxed/simple;
	bh=lJrX9fLYt9M0fTdX5pauUjLPWBj7AcXVtE6UYAm986U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UDGjUEgFMvkf46r0vwIGog3YfelPx3bfQb/0Dcnj4vPqpzeGYBsjH4NGFZubcnxAjOj0+iSYKwJx1pH4kMKlEjT3c2mw1Ta6Phquz8LBCXViGRODAsd1n/3Ja32acIwkmdxxFDkWGZzP5lWm0mz5lo37znfl0bliT3iO/qG1MUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XiDn/vCg; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XiDn/vCg"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2df8d686d10so18395ad.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 17:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790987605; x=1791592405;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lJrX9fLYt9M0fTdX5pauUjLPWBj7AcXVtE6UYAm986U=;
        b=uCUW4Lh7fd1/Uq8ObA4GF2CwsRsTJ2hFNDGoS4stYLxpaO+EfV63L1ec8P9WjN3Ptt
         WuqLVOCLMYRQ3tcyz3vLtnu2aH8pxYziS+iiEUOC0i/BfOjxfP+WEMGMKPWHQadIiaiF
         0LwOBlME/4wKqFvH5iSoyEC6VCMx8VHI8oNrR1wSpWcHRKXgVJg4zyMDtQN4f1kk2AoO
         XJArFKUuvUpVX6yxhUN/+6U2JcoYNeDr0vpTAln7+HESq0H4sGX+XBYNtq5Zhl55m1ax
         0NwLEwBiNU48CuAu8Ek4onpPBZ41ai2neADYhOr/v8jb+1Bs8sXW23LEK6qXQZr+bQPI
         lOSg==
X-Forwarded-Encrypted: i=1; AKwUvBx85WOyYLEu1pcPf3T2X4li9snXDCfycDlOcs+kY10JvB/Jtfqfk8TVdxX9ZC6sdVClb2qoqNA=@vger.kernel.org
X-Gm-Message-State: AFuF++lq9e0dcFaGiJhuZWRpVroZESkzKR/WscrYXr/4TrLVi5PvsmX4
	bF6gAmQKFT8eTPJBRIx4EpMA//ZfDckPOnu3M/8zvSQQJ6aoampz4QHB86cfao6k7IpaX/6eOGz
	b02n0BCtawOMXqm+jLuZ2fndTqLoLVv8Tc5EL9tnP0GCxR/HkTDqrHsGd1J0rr5xguLodJFz1PL
	yEdQ1kozQpNmQix5zoCl3ZrFGStGe+/fPXI1XlEXzz8pQ4NBAhmYbgoH0I9b5mJWhaDnmJG9Zbh
	d9uA5RbKDTdMiNX
X-Gm-Gg: AYBFou1Abois1Qz20cWiBoYZW1jzJe2mXIXLsraD3FDV5dgcPy/BQI+vUH1HRktHrcW
	ZaRYpbwbqLkavWLHj2lI1jnd8k+36/xRzaCTLn49wriN6Nfpnh1w4caAAHpjQHRNudpvRNV9Fnl
	v64w0uM2JDCRYQvL0w74sJ9O0H3KKweKWUmupMCr62cg1Z68p+fnx09ftFYmKPTyAR6VsQSitYY
	0c8i0luucJ+Cn6r9pUbe9LIt/8xdC9F/39m/U+JGqC+BSnubOgDSHZS+F3qsWiPmS3EOf9iQNhp
	FcsWqLCz+7JyV9+A3V9HHgibdvJXYtseZCtahxo0qDBB73gzcUUVtWuL7ssg332vvDsnoAlbVsu
	Ey5gZoHjIeO1bwzwFYkiEvPBjIb2TzuxP7LFLcVfPx4v0BSXgzsY10uF6KPydkitmJejMAXOrHs
	rfh7MPd53qrvK+7vxAhRK2YBI3Dx7RvLENTfPiLGTiL/A=
X-Received: by 2002:a05:6300:210c:b0:3dd:d881:7404 with SMTP id adf61e73a8af0-3e0bd16b759mr4349509637.47.1790987605048;
        Fri, 02 Oct 2026 17:33:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-ccb73cd14c3sm89802a12.4.2026.10.02.17.33.24
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Oct 2026 17:33:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-313d1015161so214923eec.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790987603; x=1791592403; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lJrX9fLYt9M0fTdX5pauUjLPWBj7AcXVtE6UYAm986U=;
        b=XiDn/vCglcE23we3nPMzmHG9gHAmV2Y6+vmn+vmkMQluACiTJVGt6TRYP8/Y/yjUxY
         4JoHKDbzPORvsjQIYHaaKj31ushNJe8c4x7YBvZQQ/z/sBrNBiCZ5MaYv2N1HUS/HZlq
         rCn18RQP9D1HPT0DFBHzzMAy7l4r0tSnzJH68=
X-Forwarded-Encrypted: i=1; AKwUvBxItiBfr6dbAbztF7nds+x9Fbj3+zqQr7zFgIC/DikhjTOaT7QvoCa6ugt7sdTmgNKsnLLE9bc=@vger.kernel.org
X-Received: by 2002:a05:693c:8810:20b0:351:165a:baec with SMTP id 5a478bee46e88-351165abed5mr171029eec.37.1790987603188;
        Fri, 02 Oct 2026 17:33:23 -0700 (PDT)
X-Received: by 2002:a05:693c:8810:20b0:351:165a:baec with SMTP id 5a478bee46e88-351165abed5mr171004eec.37.1790987602572;
        Fri, 02 Oct 2026 17:33:22 -0700 (PDT)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f15001196sm8595075eec.27.2026.10.02.17.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 17:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 17:34:23 -0700
Message-Id: <DLUS51Y9OLMS.UQR4UY71TFUP@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>,
 <dri-devel@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: do not hand the embedded sg_table to the
 PRIME core
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Aldo Ariel" <qwe.aldo@gmail.com>, <zack.rusin@broadcom.com>
X-Mailer: aerc 0.17.0
References: <CABQX2QMUUf1ETuLmvrzQ9_rsX4+KG32YAQJ-9hV3uakAyPiYrg@mail.gmail.com> <CAP48HfviFZXacVY9Lj4Hv7+brObhmxWLYAM8MNiTUkJNchnp1Q@mail.gmail.com>
In-Reply-To: <CAP48HfviFZXacVY9Lj4Hv7+brObhmxWLYAM8MNiTUkJNchnp1Q@mail.gmail.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi Aldo,
Using your POC, I am not able to recreate this bug you described in your co=
mmit.
This is on a top of tree drm-misc-fixes kernel with kasan enabled.
Are you sure the bug you describe is not fixed on drm-misc-fixes already?

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20


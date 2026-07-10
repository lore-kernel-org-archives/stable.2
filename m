Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480283DBD49
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674927; cv=none; b=puqDo9JTMcWtuGJAkJ6uKPUVQWu47NtoT+jSX3pAZkAx3Mi57rtq0o/Fb19tPtVcwXiDQ60SxM5PYss/epwiUaMO5YGrLey4bmiSJz5PX3bIMxiTHpmTxBvD0FpK8buaH9VVUze6KUgHL0vaKjlFdnI00DDdV+A8pskv7d8t/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674927; c=relaxed/simple;
	bh=HjXDWk3MKBpRnjJ0Hc7ui8/t4Sd/U7arMoF7/wKjNIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQVXElyD7hTBPU3ilQY1czJ2nGuvYMyUBxp3K9nXHsjRIqvbGpZTlR43MCFMN8V7bWkjCf2u1dd1kgrtsmFTkR0JRIFGcNgfSljbIFj1jZff3nUJO0EkKE6jM78SPPevirwDd7udfVwQTprEB1Hng6ikgeslLm4bnd5vBXcGN+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=b+srlDwE; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="b+srlDwE"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so677115a12.1
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1783674924; x=1784279724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HjXDWk3MKBpRnjJ0Hc7ui8/t4Sd/U7arMoF7/wKjNIw=;
        b=b+srlDwETNSMS9bi3YHpUsAUUohmyLqII3DNd4Bi+LfVeF1GsvLskpvVJwe+3Mngbs
         KanvOBQbnZT3n+kL1vVtl9mPSOXCQ2Zv2fNzWJ6eUu9R194gU8lhgh8ELPQqMvkvVPpF
         xdTtvWO2FVz+eNbf/N3Vdy8Q1+ISQhvOvCNwOwO0pD8k4u1gwSKtCxBRjhdRadiJG9o5
         ad7HdrRIEty7HgXFlPI2aZlr6idYSsc3a2133ttO/BJtUmvb5cZM3YzU0jN21fMoxaQo
         geaqo990FA8/ltmY7tazosUPrCgXUtYSMr7l7FnDkEvcjqBs1HyuvGCiMMxUapK0U4jq
         45MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674924; x=1784279724;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HjXDWk3MKBpRnjJ0Hc7ui8/t4Sd/U7arMoF7/wKjNIw=;
        b=CJGuNWdHv/W0+6Vgx8mVP0zK0NsYHY6Vdt5F9YuFc/hZEFRuArll/X7oAQIM/cH9PX
         sfphyaikb+5HTVzlfO1P8PRRh13u2kd1TXM/AiMqvMwfcnbEgH8/XknI0VzX2c1LkJyA
         KwdAy0fbXUWJmWXtp2nYLuvKu61wJmxxy3f+bkeb187LbLlTBvh0ID9Fc5JLeK1tBfyt
         I8c7WbVeU775A96hG21oKySqWMvGmc+Ge0W5NdH+9jAi0+IfFci+aFBFYHKLSPHGj/0I
         DuxGvdES+Keyrvu6fmdKTjNuCcgkpRqJILAXUGxu96yo4pjeIBXsobmhO4bRt+//rlIs
         ZeBA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+VLBmmkuVCsd/ry3Lgbp+zALJUlydbHRijk8fLhWURXxjIKpGCRMug7sW191b17PW8vTWoY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqKepmYRNQEKAFGQ80pMEnOLVBXSDTkFfih+0Iy33lkfNYfQ2
	6s8NBzksavH4aqtzkDZNWGAuJ5xDIUGiQpmqfLVqpNUr43BN457PPse5axY8L3MOG/ddj2Q0AAQ
	YrUyrqEw=
X-Gm-Gg: AfdE7clfODJehXWPZJv0hJ0WVOWIg8h2iF2uRfDKl9Gfz3CJlO0WTeZ+5DL4XyZZQRU
	V2O7UiYGGS7CwJsXLBjUYzPPUzBA5mtVYpK7nOVogg68zLAFUKkeLkIZPxZszA6+wPKl2M7uQ3A
	zSNRLs3at3LlOXT6HCg5WD1TDvCKYQXo+aRM0PcWovMF1x1CSR52kcErR6UD+dMXQcRVWcen8rj
	3NF0wii5FAZUE4kYwgzGMHVtIysyr7Zc936SuF4XtOEW9ekJdAxh4ULZ+LXTfClvbOSe4ODNb3I
	yjn+KUSIgiz+pGB6JK4HYafieENyG8Ek1Dvyq1msOwx4tRmLaefaqeoqwy4AwQxBIvMHRQIrMbx
	65e1CqFkgwoI3pADdho5LaWfSQmn2i0XWtW2pARz3ps9PmolYdJUWbMchfg+h8jndyRcl2FGcMM
	g+Ox3uHYDKMqNTtITVSPaKB1cdD09tteSu/6DGDilScbMY5FUdIM7KXYyAs4b8Kl8YswJOJxG3J
	45OQl31NkJUx6hB6MCqxGb4sn/W
X-Received: by 2002:a05:6a20:72a3:b0:3bf:b9de:8570 with SMTP id adf61e73a8af0-3c0bcfe37d0mr13262984637.19.1783674924356;
        Fri, 10 Jul 2026 02:15:24 -0700 (PDT)
Received: from Metius ([103.158.43.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm68691402c88.14.2026.07.10.02.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:15:23 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:45:17 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btintel_pcie: fix memory leak in
 btintel_pcie_probe()
Message-ID: <ugmtkr7xseugii2hectc6lqiy5jkl4jtb6ry7zcydgkh5kyvgf@jaiaju4ctucv>
References: <20260710060334.136987-1-nihaal@cse.iitm.ac.in>
 <718783b3-89ea-41f8-8eb1-48bf0876281a@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <718783b3-89ea-41f8-8eb1-48bf0876281a@molgen.mpg.de>

Thanks for your comments. I'll update the commit message and also fix
the issue pointed by Sashiko, and send a v2 patch.

Regards,
Nihaal

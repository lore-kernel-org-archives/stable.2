Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203EA434E21
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417526; cv=none; b=Ot82DgMne60rNUD6PXsPXaNf4W0hDDCSP5P3FI9pI05bxdqKKhcXFJlpROeejRPLPvjLaOzHbgcSiQgF1pc2IGYOGvR7K9FY7tAi5jUVDY/Jc7HAuscptHba4FgVHSC2fMGdewtP7eCeV03SR/MV0D3rFEcFDB9Y1+yCCXww5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417526; c=relaxed/simple;
	bh=xyZv2VmTQLPI23xs17apnap01Rqgwa9z+jjUANCkb7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HE9vs3eBHiyO0JCU+mk+4ICqXz7GcZz6UIVUOCfstszb3bqZOhkSBNbvdh2XlL9sOWUEE6bJZCvKHur8wMDnkzY6Uw2Dw0xKP6GQy//8umz8aA3hEDEIqS6KeFg+LEoeceCZVS+cuRo0V5I1zFtbeJEj/TRjjM0XbXQJxi5Ajfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ser6kfmN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ser6kfmN"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d032846c95so8653225ad.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785417519; x=1786022319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AAaQWvcNiNvM0OrKoPcMa7qyZNNUq+voHRPWQFnYeoI=;
        b=ser6kfmNmobBZo/GB1o8oiAUsPDVFeIR+GJldnFK50eQSmNMy6PyrOhWCRNcCkNz6m
         Plx76tr+e+7gStccH3J66ReSDNdicXJDTfCEo21V7Izg/OBP1ldWg0VQUh4huQjwgCtQ
         Vib0hGrIInKurk17r8W5iduGGivsdTU+EnRYfhe6md8zoKIY4H5ae/EjSKeBeKFIlUwB
         OQVXg1qBGkWnt2WxMlIWKZqQf97Ro1DC4Uonjt40sfr0kdO00idkk4tkK9ZlQKcaeTbz
         aPsE5RKh/yAY/0D7/3us8/ztB1yQbsstefiishlq930wt4pIlEbrxKSvXjUCNmBgdfGY
         /o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785417519; x=1786022319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AAaQWvcNiNvM0OrKoPcMa7qyZNNUq+voHRPWQFnYeoI=;
        b=Lq1SUZ8NXL2rYIYWM6ITCkS1ck8CTRw9QqyXkNXNt08pJoBy5mFjCTig5YETf/liKi
         xQVwf6H0ofNpw1Q14t0zb3z7JAxwRtdzLfxIwl6SaGck7+QrYGBZipX0HqojhB6tgDbG
         gVOMT1+xROVuXoMpLZjaBfUgW3wgHWdmdtSAhFBfYhayQLo1Qf+0j/aFVH1A95eUhqx/
         OnEzhKsNB8L9LA0XtPjFcBwaCk6buGE41AZeZ3OB+lRaQeaWbuS011nHMiIkGQbQDMO2
         D7sYaXQSOBs7HPvF5O5yG5pD4sa5FrAA1pHRE2NChbDsb+wkmS9Yokv5pNbXj/tWmwrF
         mrGg==
X-Forwarded-Encrypted: i=1; AHgh+RpzNoAH67d4d1tsFV1g0CeZJjNnNJyL1EoKeHRk32OGk1sqQ5Znr1KQ60rqyfMXkB6awwYraf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEqGz1UqwDIufwFiKdlDjFwoW3dTluuus1xeutBsaieqyYuIe
	Lb/S1ATUs+ZsHE1c6+F/cjzn2ZRqZJyNV5AqG0b261IiJ9S+ZU2LN2E2
X-Gm-Gg: AR+sD13XOByXEKSJN1gA0cE4c5l6kWG/bRXv7F+DE1rS8K8u7M1FUMVFNSrX24ijiq5
	hbKpiec+PR4qK3369WitOhJLVLrjPw+U/z1jXQAAWCvSmyK6B1wLs0NLPACysv01dfVtD1gRBNl
	FjdbBoTV0eZ+2VciOYrEABPSFXDayzdjeuO3NhCnrzBMZeg0LIkPeKh10L6AGR3J1mg/0U5FcNU
	56cqZnR4gJTbbWfq2z47fajbVpAQ7ujYMuYxtPJ97fQabBv9KF1UsNv3GJucLYsuZeDNpUkFPX2
	JoSCVgYROgadZiJc5hTx49XIn9xbdTNyEldSAPG6kOp9U3GqTVD4pk/SZTbr81g7Rm+Lbb4fkD6
	oG3HuehxuwVCs29AOSqyxYR3wEwNptIU8s0S2OLdfl78+ETiFWsxgK74OWPX0Va2fmMa5xVJFWF
	VjEaDipVT/NtOCprfxv7JN42VGxokKndEhpKc2KfIEYGFEXnGSTtAj+a18yj1M/Em7
X-Received: by 2002:a17:902:ea0c:b0:2c2:bd7f:ccd4 with SMTP id d9443c01a7336-2d035c4b360mr23200275ad.21.1785417519033;
        Thu, 30 Jul 2026 06:18:39 -0700 (PDT)
Received: from Default ([2409:40f4:10f3:2277:aebf:f6c4:d4e2:70b4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm23063328eec.14.2026.07.30.06.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:18:38 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Frank.Li@nxp.com,
	jeffinphilip14@gmail.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	panjunzhong@linux.spacemit.com,
	stable@vger.kernel.org,
	syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com,
	xu.yang_2@nxp.com
Subject: Re: [PATCH v5] usb: gadget: uvc: Fix Null Pointer Dereference in uvcg_video_init()
Date: Thu, 30 Jul 2026 18:48:20 +0530
Message-ID: <20260730131820.9143-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026073005-shadiness-untracked-9efc@gregkh>
References: <2026073005-shadiness-untracked-9efc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, 
Apologies for the noise and flooding the queue. I understand the situation
and am stepping back.

Thanks,
Jeffin.

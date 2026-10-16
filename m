Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3348546D2A9
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156841; cv=none; b=VikKY4Un6HsHjX6eyEn7HtFx5q12GSjg6U5odIGM/vydsPPxhxa14Lddt8+O1YkIXXwAmwK3QTUjXPXaBo/6B+yLnj8S3XXzQimKi9GuGVpGIBgPggC70MnhfqCdJ4g8D4SGA/1/QeROe0Mh0XXB+Mo6O8Bpc1gSudDz0TYidHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156841; c=relaxed/simple;
	bh=8LZRcG4RAXDCcewy5ZGkTw4K/dxAa6eoPk3+1qnhNgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcMGIN+yB5TYS5PJQDbr22ji3nH7HAscwjRnzTS0TQNyefo6K4ujBUPOCIRERYyYfCuQ6BybJwfOkvTaa1lxdwy+gFz2IAUXQ0018fgY83NKr8+HRS795XtOMVg/m9EUxJKcDTHHdrc0odA5+6NhKaNlkpy4artIPo2VlhgTf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZervzatF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZervzatF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8fe8e343fso27777385ad.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792156839; x=1792761639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8LZRcG4RAXDCcewy5ZGkTw4K/dxAa6eoPk3+1qnhNgs=;
        b=ZervzatFkoo2sXjhZ1M4J+7RUPhjB20lIDF0+czu65Gjrr9NrUEmc51GmMWp5zbm2x
         HhdULtZrHnurc2nJtN9M11X4rRFICm+1nhuggXWKHZy8K/t4wp4HYusiCw0LSjXXIRLw
         +0zpn2VClUnOQW0t5gDM2gdBhZONmtLeNvctPIeGXJXzvB73Vg+mohA8D6BV6lkXm89M
         rtF5P4OTnQKSpGQ8Ofxri8bxU86XUrfKEOlwcEYK+06njysL8IDVgpxkfFnUdarMGlaz
         ddExseChODmoo++5Ie9apti65rLv0VvOOuviKi7nznOysmcYJ1aYtCgxRweNEK+bwe14
         libQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792156839; x=1792761639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8LZRcG4RAXDCcewy5ZGkTw4K/dxAa6eoPk3+1qnhNgs=;
        b=eKV3kzL+BnC2a2JNb2oEW5lGJCQjGvlWGQtDRGGd1CTU/Bm6m6DhjKChgaktdn/1/q
         FdldjWdFP/9izP4lLjR26z1ceKL8ROp54i0K4KLErWJafvnZfzD4kiDMNrryAQRfGQif
         TswAN3TuYC5E/UxvJqLjJe6NLnC7fgmj90cI+6IuvCeHhhB/0+zttdUTpzLtxil2imv6
         Bwkg8GcB6U8pxWVbiANcJqSAQfbTEzKXL7fkJWBlpOujymWAIVqsoepkd0q3SsjLObLH
         kxrsKueqplYoYufR3fkG1CXXXtIMCW1rgl+8ZECCIwqMpgo7G5OEvmFiHPDyTnYBegQK
         Ha3g==
X-Forwarded-Encrypted: i=1; AKwUvBz7KCBUkGgPRwSwYFDTTu8k6an0lWDGuf/clEPeEYm8lZRWPkFDPSluqR4Vu5ly2MAG/1SQSRg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiE2MKHIJmKMI0eWV2Wk8qoKQXeFCwRxEGn/Sw4DMQA5XVdbBt
	ioMsm8hHhroUyRi5PXbwWmrg++epMj9ZQJ2eJmojwfbmtuetFiQxaZ04
X-Gm-Gg: AYBFou0HXRHPccoB9IcZm4gafllfa6kNCPccbnj8I2/vTo9IX6A30XuIRHMzrnaOQDM
	HNH9xixloslohn8g+o0i4GUYgCbRk2edkG6hJa+INhWiNWhUcqbl646fVuerjh9EAM4xwKMmQXS
	H7M1DDv791vot8mV+Zsx5+yBagVL6Cj1hieon8BaIaB3Z7Gg5b0c2agUd8/1amlwAwT0TpaOO0G
	L9dOe0D1D7FmvkZa0NKfgQAyctH0h0BN+fy+O8on3YzlRclB2E6MNc5+gm2XL8ACkmnR7g9jlma
	F8erO8S18mBhmPS7qiz4oGDrcZBNoPW6bR/1lZjYxcxgOvHNBuVp4OUDsxtqn+d6Loj0BEpagSp
	YfUcio9GUf2aLgRhP3l/0FBtFpv6CyO6YMgre/HRKQ6WZdAuVjbtU0h6IImm5IfJEU80wjk5u+Y
	8gBw2w1H55TMMxAO2/WPeyLf+CndM6irW68+uPN/8W+522TWpaNByaVsToyKo2blFvUhgbDKsfD
	DcFBqISsJ9TvQ==
X-Received: by 2002:a17:902:ea0a:b0:2e9:492e:1688 with SMTP id d9443c01a7336-2e9492e1786mr75900865ad.8.1792156839354;
        Fri, 16 Oct 2026 06:20:39 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8997edsm10013245ad.63.2026.10.16.06.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:20:38 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: mani@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com,
	pranav.phansalkar@oss.qualcomm.com,
	andersson@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: qrtr: ns: retry service announcements on -EAGAIN
Date: Fri, 16 Oct 2026 22:20:33 +0900
Message-ID: <20261016132034.711-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <bbdaabf7-ffdb-433d-91fb-f6ca03b0747c@oss.qualcomm.com>
References: <20261016124600.31-1-26rote@gmail.com> <bbdaabf7-ffdb-433d-91fb-f6ca03b0747c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 10/16/26 3:14 PM, Konrad Dybcio wrote:
> Please remember about Assisted-by tags if they apply in your case

It does apply: I used an LLM for the analysis and for writing the
patch. I left the tag off after "docs: remove Assisted-by references"
was queued in docs-next, but I can add it back in v2 or note it below
the "---", whichever you prefer.

Thanks,
Joonhoe Kim

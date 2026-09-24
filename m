Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F7E3E3D80
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268501; cv=none; b=LDefsF21oWbxBkFGKeAKgGFkvgOQctTB+y8FU7KUn+o0iuc59UnbN0b2feBT3tqINe9w1MjTcu3EdBFLVW9JqXVeB5PVkCUeiDHDNm4AOJu2FNP28SiVIYwfbNSC8S15Om8uSjd6KZ1Fu0SiCKBuy6lI8Uj1Nz/wyazN6KRhQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268501; c=relaxed/simple;
	bh=09gWLrxV9B2YL08j33NGm5uI7VMhjtGXOM0U4bCV5Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp3yOBtiAG0QvPY6n6GyKhjNZeoIxdeMrfOA9BRo4HCtPf19+52zGBn3JmCol6imO/15AMjTwENI2Inp4/qIRySe9UWhud2/JEfPeEQ8FFKRbUejSixcVPDGSYQ0Lm2Bc1o49TOSUaC+d9fJkZxoet0+OkQsvzBXr/jJGl++lAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zit9VWog; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zit9VWog"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso113956a91.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790268500; x=1790873300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vcbua5mIvOolDP5npCwiYAbITQjIUK3wgIKLBNoELyk=;
        b=Zit9VWogUurDYmJnES1DV2o51mAVb4WfWQRO805+UtMdRTDq1OUmqDW9fl4LTHpLLJ
         5qP9o1NqZnWEIoo6n8BJe66bVhyHkQPvVmbEjk30uKBtGhxFPK4c/I8cKHeYJCrg1BmW
         ksLitFj1o59y0Y4t4ZAhA+0H12YTcotc+3lNyZFUtpNZUPdJ1vy9YBRhfMpKDo6QTJCu
         72NKJ+ZaB5sx+/FtZocryqrF+1UqEWq+syn7Cci0Yy5+nD0ZcBnkShISzzug3Hhsi9wP
         b/OXovt+uzsXFuV5c7pBc7Gd3KOyyUxpNJdXCfiXSweo6nHiY3s/LeUQvMb9wSMxmig8
         6cVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790268500; x=1790873300;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcbua5mIvOolDP5npCwiYAbITQjIUK3wgIKLBNoELyk=;
        b=FKZiTwKFSGWu1+b7D+CzG8qxfTqOKfDwXdghootG6quageqScK4CllCX8hQEtj3bJr
         Zmac+STZL1XMIE3RiZSIlzzOh9NFeMJqGJfQDpgwYcPAM3PJFC7rnzjKdQ6IVwNwjap2
         oEihKwpORM9fThdd/bmghKPUKQuIA436Vo6a4oaugh0QkVByq5sa84P7pHVnRVTOnq6e
         SRCa1Vfr1YJOeGnvuym2SS49I9dCWd4JAEXfuZZNE/F5LVkMmNNWsaxViZWaLZ28bDWF
         Qj03AD/U+BzXfmn5g79VkjiAhTcxQuDa9mtY8qdkxfthY/CbHFhBrZ1JDP/Z0wxyfwKp
         D1vQ==
X-Forwarded-Encrypted: i=1; AKwUvBy90NoxmmY/s43iTtKAn2WSM2GJov8AXarzMkEhrXUIWDxhjwwnl+gNjBWdfG9fBy5NaE3aY7o=@vger.kernel.org
X-Gm-Message-State: AFuF++n0c5UTCsUNaHNCd23G57ZRRf//wuBdo3iH/S0URv6OvMk9hIa6
	8Ic9mP85tF++XTOY5I4fNMOXXhJBvAH/frO9cMhu5F3kH7/KPHuXW+Hr
X-Gm-Gg: AYBFou39FOhQ0nC92EQ1MPfcEGXIQ9AiaZ4KQz5EJNLo/81wht5K/D1MK0xNVbs5ZQ3
	yTo//7sS908pBnzz9P55FTXyxootGHIvhZjy1lVMmnJnPVLFeoLHF1uSuGovjWsH+FAmN6FsA6i
	UESKhffAcKzVY3J2gL8q491RR/iDtWYxIsGub+r5xEKc9S3Mtyg2QM71sQ38BfG7NJLW8CF7/Nl
	gclG3zZD1isFqt/xrS3rVMM03y1ypx+zEtJyT8KN8OJHWdFZvAb5qPR1ZaI74t26/I6jeSUxdK3
	1ElPFYB/7K7iCp+DW06ZM9+lLgxTE0okOO0TYENIa9G2Jg4Pf3TZ8S4C6QETzvjS/1Z764XAc7j
	6iku4W1OAUBC4WhNzvJwyZdu4Ey53dzcrvKUXl+UzexTMrNk+qby6ycj7ogiHK+scHiFFMyRUBx
	wVNvvmDpPwN5M9bhPW7gxw40e1CtE4rrf+RLRnrORyCLvxKEXgBVEAHumr3pPaJ/0lStJnDwPhU
	7KNUb8tKK0g
X-Received: by 2002:a17:90a:1108:b0:3a0:9ed5:5420 with SMTP id 98e67ed59e1d1-3a09ed559a0mr1484080a91.44.1790268499752;
        Thu, 24 Sep 2026 09:48:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09733f48fsm5863409a91.11.2026.09.24.09.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:48:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 24 Sep 2026 09:48:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ridham Khurana <khurana.ridham222@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (lm95245) Fix negative temperature conversion
Message-ID: <0d7f2c30-a775-43ce-a74b-a2019558e5a6@roeck-us.net>
References: <20260923172551.1593798-1-khurana.ridham222@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923172551.1593798-1-khurana.ridham222@gmail.com>

On Wed, Sep 23, 2026 at 05:25:48PM +0000, Ridham Khurana wrote:
> temp_from_reg_signed() uses only the high byte when the sign bit is set
> and drops the fractional bits in the low byte. Writing -500 to
> temp2_offset stores 0xff80 (-0.5 degrees C) in the offset registers,
> but reading temp2_offset back returns -1000.
> 
> Negative temp1_input and temp2_input values are rounded down to the
> next whole degree the same way. The chip reports -0.125 degrees C as
> 0xffe0, which the driver returns as -1000.
> 
> Treat the register pair as a single 16-bit two's complement value.
> lm95241 had the same conversion fixed in commit 0c2a40e2fe4f
> ("hwmon: (lm95241) Fix negative temperature results").
> 
> Fixes: fffd80ccc1e6 ("hwmon: LM95245 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ridham Khurana <khurana.ridham222@gmail.com>

Applied.

Thanks,
Guenter

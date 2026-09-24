Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9213A48E6
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 04:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224321; cv=none; b=mubRSJEgG1qe3lKDMVLPTl8f+KwN3zL3rIJ/mHvrKMz0m2L8/gDR+W8KD1kstV4XhGikhP6lqCOZjGMRNqPwwvU/NnPiNRXJMBr5WL0j+j+AqdSNNY8DfRYw4/+rJPV3SRfeZGbn9bUejEvwAEsTLvGMFNaONb5j7H32XqbZmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224321; c=relaxed/simple;
	bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOb9J1KihL7mlf6ZZ86Qy6ckrin7AjBgc7VSX3pFtMyJR2mOR/SXFzsku+ogDB63Qgte0eWvn2GGuOlNjEDdgy5ufLnvNqjsS9lpyLOJc9u2r1emx8JnOANgjSPOUeo6GU08KstP54lagm6LnGYWXzpW/eU8wavkvk6swdbZ030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn9nur6F; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn9nur6F"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so734376a91.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 21:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224320; x=1790829120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=Qn9nur6F8AFN2P6ahcZ/4fYYZtVG77XTje1XnUUKFFtj5e3DzByEgv3B5GptoLuQYI
         4GPvf3Wq9LPdNcO2k7l/aeJ2egnX0zbfHvRtjXEd2Y9v48vEyhI4+vljychf6VOTMoMX
         /g9CGDmARwzCMN/2eaMdYaORMN/9N/ddcSlL1QamxGsuwGQRD4WfNHPMz+IIZGl5yRE2
         HM8Rtc23z+QJ8ztjCbo2GooCA5lNwLOixfSP8RzppHaSWFLJ45qAIRJDRupn/g+9h3HI
         GX3PqacrdgpkvUFO0LWIx3GwvxhFlbkfLVn6j5VL8aFUGZUaH6en/XeF1UGl/hLIKCsy
         954Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224320; x=1790829120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=jsuhGT0vjzskcTL2a/PAZuo8HAGj1dl83dPvFL3ezGOUTS5dFMIMosAP9cZEJGUIEN
         VJQr+M8jOwCg02i33G4esfN6JWatBvSV9S6C78eOkCalQ/1v4yD1Fm0NcA45f2eksK71
         nq9jkYE6fouu8MZhB0sgYQ+kheUG7npOlo8l9/0Kdwtam+og/AK8gm3wHJQqqP6vtDWI
         Hs+vTU77/IDyKKr/I83H06mjfG59jBKmRS1rN/PxZN6uHjf8uD7XipY5ei4661leBuRy
         rgswXyEWBQOPJ3Wo0SuZgmNPZ29w6ioPnOwQSsk6h4e9bG/tqN9LK1LZGPhTQYKPbNHc
         uEgw==
X-Forwarded-Encrypted: i=1; AKwUvBwNRsADkFlgzmyTgy7NqjKWNDAlgBaPl/r6UyAVC3lr1S4GPr5qTmzX4YV2rO9QVlp3NDQWcm8=@vger.kernel.org
X-Gm-Message-State: AFuF++lF2SHeNlDEeux8+oN6XIL1ogRHyPP/C/gMXPfNTwg1H/aUnf/Z
	m8k1CLKCPwdvnCFHI95Jb7hfD9VCUX50Ce7bFY1wNIWg9VwQL25lOIdH
X-Gm-Gg: AYBFou0doGxmisTwNPXz9y86rsJhtrQSWhohJ+8uU9z3ue7c3ETPfG8W+OFhQ5RbVbT
	ajpyiUMF9gkc/PFgrYS+zpgAYjs0PyP8JoZ3S9YOeje1tvRsAeJd+MqrT2tABaV09ZFmcvgpPqQ
	EHBvgWTv+cYPs7kXnHuNKTh2Zmw97N2qgZvvO3WnkcpnI8pYe+ST1GsbQ5b3Is1WUw3SOp4EEr3
	8E0XlKj2esnt1yms/Jr0/TXEMCFgY4eHgZKt3v3K7ADkJd6YDLZYPbN0cS4sFBdfR/xydO634G4
	G9nMijGtukK9VbfGrf5IJRGjcL6McZDr5R0smDw4K2E6GX3KNoElWGtX6MTgDB1ngk1bWjOouV3
	Y94peiLYU6AmYWnggNrSjhqjj1A1Dzj6VDJc8I2auHO8IPdVeDdBnWcdv1pqPTzfkPAp2y3ts4S
	wRXlWSDTkkCo1div9LRS5252amK5gO0/eQtF3OC5QHfTrvAOz0YWpisfSKh5ybkzcMV9MKT+5CF
	U4+Fxn2T9TeaQMScYrYrrBhIGDt+vlWsdGR9IX9qOe7lo2o5jtWAkXC37WI9zRmm+f1+en7Z1dn
	dsSn5EpKH6Fx3/GIXsbqf+KDwmAVYP6h/k2HJa/IiMJFROh1QLZGj4yh6Kc=
X-Received: by 2002:a17:90a:f94f:b0:3a0:2614:2077 with SMTP id 98e67ed59e1d1-3a098b93d4bmr850160a91.41.1790224319843;
        Wed, 23 Sep 2026 21:31:59 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a092d9797bsm1496938a91.1.2026.09.23.21.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:31:59 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 6/6] qnx6: validate sb_blocksize before dividing in qnx6_mmi_fill_super()
Date: Thu, 24 Sep 2026 12:31:55 +0800
Message-ID: <20260924043155.3898135-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921042511.1473629-6-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org> <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-6-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to 1/6.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>

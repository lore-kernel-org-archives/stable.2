Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0F547075
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446770; cv=none; b=Ass4wWRHIBo6HuKjlgo3ZhvQAOft6BIWFeLI3RZGSJibRwLEkmksOVNt+njejFFIOpVAevNSz8mBeFLO4Uj3yhixSBGEFWtQpzEcbqEnLn32AgVkiJxJtExs0GmcP8ZRCokfqazYjZALN/eswySDhXlnB6aIFZHASIbTqiknIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446770; c=relaxed/simple;
	bh=zqhjOrjahKnz2HWIqkVU83xsJUR6G8K08BAJhiFtEb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGBZFcW2WUu+ENHtJVu1meCFawuh21HGX+XNstFTg/IlXeHbpEpYfeKLH7bAy0A/9NPFaqpmsbFy2fyN6q0Nj+JGq6tGo2CYW/oyN8YlAmQXIoh+86unkUZ/pCR0xZ8ndb4r8riCEOvGF+RStS9dFJQnhm6I0yqDLAbZgykYDlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkPcR/9k; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkPcR/9k"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8874539bccbso2483471b3a.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 01:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446769; x=1792051569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zqhjOrjahKnz2HWIqkVU83xsJUR6G8K08BAJhiFtEb8=;
        b=lkPcR/9kJCO8fDRmPV7Q9eQIljHAxhy7OKnFMNSq95TasvBrCfZ3f7ZvfnFspqqF+j
         EDYKd/vUTbwIY5llh+PzD6/IOxpZzZ03Zb9whuVUBLvCDs4kyzHU++8sFrW7F/eeLlD/
         O7bbVJrY10t6zGONCYkJiBn0Mrn5U5ZE4Wf4MlpuYx6mp9081jUejYus1Wk+CffqGMTU
         RLzKJ9gJ7CrKJ8UnYmHxE772pcLNYJrhKDYU2Wx43+aZ0gwacJymp6B/AIJI32/zuZ5h
         7xriE8RFZbmTuFtMeZ5CfzRhaFK63JOiFF6un/UQSrLi1Cr5Psi5jEbeEWHfBOW1/HbT
         7r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446769; x=1792051569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zqhjOrjahKnz2HWIqkVU83xsJUR6G8K08BAJhiFtEb8=;
        b=qW7ad/sJJTksIO53teO+H4GRwft6tT0v6dZByFrY061HgvY36g0/4zT0r8UCCB1GNn
         biezbUxVXMzGwKoZtKXKZj7qK2XTGeZ0hagCIayPUrqhop9jolM3qD8RiIfsLIrljZUn
         gwZzFTBsdw1pJtmW/20xR/4OOErTOKqoa+bQDnpLAZFhtMD6kcxGLzNJk/meUFbHOUNe
         V5mCoCPtujxfqpxlPfT2nBE3ZdtBeoWRAUdS3vk2R4I0Jb5mW9ARtoRNuUxWqBXKf1oK
         k+xF5jbd7g6W/GG7t5zH/mD/P99O2Ui2uQhvwMcR5i3rWMhSjNt+u0MBbAVZkh03GVNS
         P7vQ==
X-Forwarded-Encrypted: i=1; AKwUvBwEA0VROK5PcCRGJ4TbCbPgMYgbFCFeHop/F96lgd+LwVzpbpt89844JJqihGyzbb2wlDCPs4Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lYCTTOR964aXist1AAaWv2ik8U+p6zz8j6cn0PqjbNpVf86rPS
	XkAMSUqCquESXKsT/o4MyBradLSqVb5+I0Osv4Z/MllJ+DIekHTmK+GJLFyL1E0+VVA4L7ig
X-Gm-Gg: AYBFou0gNc/5WaA3e15VyKbwBXMM4bXXFleBmHfNxeYAkqwLPPBtVASziMVUXX1JN5W
	KR3BBbmO6r6Ve2mMp580uzt/XL1p8zIuv2+mSxeV8Ke5eClQxbjJwCZy9dFuItjEJUsaLyovHqa
	H+iniq1iqP87NxdPeiY3cUucynvKpZAH/rgIBEGC/yi1/SheElJAFISnoTYDe/UICISCH1eNBDH
	dCUxvM0rST5BLfw1suB6rPtbPpXIF31bmA6RiKVB2lLkQfLvEry14zUxbIukxoo3QapVZ6PpCjd
	vN06ZupBLHND2NSTAjHvssfhs6TuB8tD/gOWU1DilKigBL8Var+EP/8cqb4yQ5WXPIZXiqctaHa
	D4sMFASMNSIotyAbp9lvK9xg0SsuonxVE8ggkEOo3aL3m5A+NOcZh9xNoHd11GiSG6hmdYBiZZ3
	2A/Ulj0vv1Y6Sv6fP3DDpJZVJxP9ZguC6l5ynhimYikf7okTqMKirx21y18cZd0RQg9utoJw/WU
	q0uAFJSnTdvQO38N4Y8rLYLcPiVSB0A7TONz3IARcucbhiN5DEMBns/plz7bJufo5+JNenmedXF
	nzl4aPhHpgw0YA93/09TjDO4YnJE10kptJTG
X-Received: by 2002:a05:6a00:288f:b0:890:a995:1f61 with SMTP id d2e1a72fcca58-891b138d421mr4452911b3a.15.1791446768676;
        Thu, 08 Oct 2026 01:06:08 -0700 (PDT)
Received: from cs-107073042055-default.asia-east1-b.c.uac61c9752218803c-tp.internal (191.247.80.34.bc.googleusercontent.com. [34.80.247.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bb49f494sm1276097b3a.34.2026.10.08.01.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 01:06:08 -0700 (PDT)
From: yang <yg.jiugui@gmail.com>
X-Google-Original-From: yang <ygjiugui@gmail.com>
To: Fuad Tabba <tabba@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Will Deacon <will@kernel.org>,
	Zenghui Yu <zenghui.yu@linux.dev>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	yang <ygjiugui@gmail.com>
Subject: Re: [PATCH 0/3] irqchip/gic-v3: Lifetime and range fixes in the GICv3 and ITS drivers
Date: Thu,  8 Oct 2026 08:06:03 +0000
Message-ID: <20261008080603.1987-1-ygjiugui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CA+EHjTx-MGu=Rh90WDnTWMS4=8vcOdbhR35g42BtRBy7wqXBXg@mail.gmail.com>
References: <CA+EHjTx-MGu=Rh90WDnTWMS4=8vcOdbhR35g42BtRBy7wqXBXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Reproduced on /dev/hmv (HarmonyOS KVM). It advertises GITS_TYPER=0x803ff71 (IDBITS=0x1f), which triggers the unsigned-int truncation and causes nvecs to become 0.

Tested-by: yang <ygjiugui@gmail.com>

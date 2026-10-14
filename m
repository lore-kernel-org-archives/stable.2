Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F73F2116
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997534; cv=none; b=AqcfR/qv/OxuI5vynbfyCMChNk7wgF4S485gOiglqg3k5LWaJ3CYEfXOWCm1GjdhjI3/DYYWne+5JYl+MR2MpOZTZts5h7d3seH1+Sywr0aMzIfKCxjIv1LfjZkvtartYC0AL0bZ6x9IeD+pLzKEZhxSq57Y04Qz4DXVKEy+gZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997534; c=relaxed/simple;
	bh=+W1Y+BCj9c18kizcf8WLQBA90kA+0tB4dl0oI8EtLFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOCxwaJvNacb+lh5WyLgFIlA3o+sevpLCouqm41rGM5HctCDov72+URIk8NBwmHdBGSGnzY3MGW3eegRXXFmFUV+xfQR8ukCu1UGhS8vzMT+XseZjH5akmV1MYbhYZWYsHoMrI3vfgzi/B0Bco8LHQUCGRiq68jwTbMzj3mUkTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEeeWVrq; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEeeWVrq"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48de72fc832so590309f8f.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997532; x=1792602332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVk1zQ/OEbMRFp/NCWXuyOatJombWw8MRS7/HS8mm9o=;
        b=rEeeWVrqjZNiFICgc1pRrJ3vFyLaFv117riu1L3oa6g60Cvrh6Ns5mhmUJxeRmeOaa
         SykTDxSb8QR4iFG/6/hllD5mXaFvfGpkWvCiNm1ZPv40LtSfxToLjrvjw1qIGc4KFGxU
         iil6itTTaRQk34fvwildRHRmAWFEi6FDV0FBs2G0Eiqe3SO31CHDtnUWAyhAAtdINTU9
         Ityz2xhPqPH2F44a461KjQU8XSKdvjsncQkJU8E+JVgjyHkONMBvizk5BZYRvSlVR6Rk
         sG4AzwzAGrZ+TnVXNiu6FP7eahn/Qbfk0+NCVFYipJ4KnRCeT1znpAzs0BQiFb4CMsM9
         a+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997532; x=1792602332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVk1zQ/OEbMRFp/NCWXuyOatJombWw8MRS7/HS8mm9o=;
        b=t/cGXY+h3Hq5cs2/Pjg9awxLlC9iJmD1ssVAQ6jrm7icNum+ZMR7MngzDtXIhIa7v9
         0UxyA4f10xPDY16Lwe8PLHNiefpbSd6znmuTx6/3EwNs6eEjnE1ITA93WF3QFgdrvXz5
         NMERNDRE3phjDSEvxF1Oio5rUsiBSJZQDcKX9Dtu9a7BsBh8mSqmX9FWHrMEPJ3+ZmCW
         GXwF9zHooKt3tZjkXQCvIceBUs9qftLaHY9O3Xsd7RTZBR/xJ7re9FQdrWFe1UIAEFGn
         Z0LriU+rrBhlI7HkC3zsvmrEWA2AkM5+uHmDGENQmvVHpjaiZNCVmGVeggPQWJayR09n
         Q/lw==
X-Forwarded-Encrypted: i=1; AKwUvBykZKww4/OeyWU44tjZ9h3Ufjh5jfeVM7RxsWEM7irdyNG2p+s6O6QINGp9V++LdSL303IBoNQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVEUNMQadKOJt/h3JRTtukle9/Xdn9UTTS5xLrl6W2xVSs3Y2f
	paM8ZIqp1kCaphTpBwtZZ5ZOBnXpA9HdP4BwDy8ZwQn2uN884fhW/luh
X-Gm-Gg: AYBFou3+0KA79ki7yps7Gjr8QgMcAIKUEJoy7LSt5fQ8YmnhxbEZfGx7Qa6ORMyDgNv
	5VdhXkjFTj8I4wjjHnC5/LWv+lwMYUxAh3NOps/riD9wdcYG9MpjP+/0MWFkQpVbNCK1frysgGv
	7KtGLO1if93Qv+CjBXTqMooWotj8A7D7vFPU07Jz3EMqM81Rr3PcB7H4E75NOKjMM25R9sVkY8q
	eBgcy7UT+xfpytGsfZ7bOQ5ZFs9pZzewSKpLv2s14zLYzOQpL643pxMXxkTOF70QN+d/BE6QnnR
	8M7H8OB1jVCIAmuJWiTK7PfKUziWjdfTkbBnzmfeNizHYshZ3o9YDgpNTyNQatKtDiJ8tD1Blzs
	juWztraj7y+OQ4u1XUhqY0ep6WZqQ00Ap6dUETgffwkdebfnuJ80GiVdXM6couWoYsqheqcbhci
	9b+9l9CZdKUmEc9aJBRS7D18Mp9QWV9WDB2Q+0ECcBckJahPzx12lIxqSa4DuAgp98kZq7me5d4
	P7QMx4tbyjNsyxitSDzCSZC0yRO5OZuykKXwAMzw05kA3M=
X-Received: by 2002:a05:600c:19c8:b0:4a1:777b:8a12 with SMTP id 5b1f17b1804b1-4a18e4adcdbmr328508655e9.14.1791997531763;
        Wed, 14 Oct 2026 10:05:31 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd98637asm4863305e9.8.2026.10.14.10.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:05:31 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] nvmet: zns: don't leak stale memory in zone management receive
Date: Wed, 14 Oct 2026 19:05:23 +0200
Message-ID: <20261014170524.3151-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014130431.GA15622@lst.de>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-3-parri.andrea@gmail.com> <20261013142554.GC14759@lst.de> <20261014110001.95212-1-parri.andrea@gmail.com> <20261014130431.GA15622@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 14, 2026 at 03:04:31PM +0200, Christoph Hellwig wrote:
> Just to make it clear, that's not to say we don't want these fixed,
> but they are considered robustness fixes and not security issues.

Thanks for clarifying.  The tests are now posted:

  https://lore.kernel.org/r/20261014170046.2516-1-parri.andrea@gmail.com

Andrea

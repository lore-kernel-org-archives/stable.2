Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450780;
	b=EI9z8/VGt0g4Qi8aCN1PwrnZB+gbgtQFVYuow6C/1q1D6yLt5J/icuTpJH0D8Le+B5u0
	 S5pzGhn+iC+DNmqC4IKSROfn3Au/YvB5jXcF1iRa5RRN2BZg379pgDahktRA6LIR2HWuC
	 Axkh0qb/+aou5ssu/ul1v/JXO9YNXK/fU28sqGHR7KQYodKh8TbHDiGWExYOFgeAChqlk
	 01pDYWkvYuxyIZh6iZQq/Dz4CHEjJiNNYbKu0ewFPKgWzQMNXfWB3Pll2z8sOarR1sPoJ
	 R39kTWYd/75eyQkYQWAtg9Kpl4dMfkA5I6e7bbk0Xz9XNUp+qrSluCNZaT+SJ3wwoPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+BRgZi/ru4kt6Z44lXsT8xtnCbwbkOnntJWrR5mZ6uk=;
	b=Lf8gzLVzzLuo0iRof11hhSazfozWTQmryFuBiCT2k37fb6HQ7ghvEVv+6HpLj7C2bJHK
	 EElZBK9UWBfTr/U5BqEBBReQSR6M/Id9PsB6+sKiAPdKMVXngqoVd2cdoogSI15lMl3+O
	 yz+x8aSDuCrw29Yr8tBjIaDDEkjznVuErzNSlDxRv5HHHzJHC7GMxZchdSqoZXblaqOLg
	 1eceeKoMY1vTK4nFndsMY+4/bdBYwfpi3JgkjAw0FvFa2Ah3KVVRSDoYvsQzkIELEupOe
	 GZsG6/gtwnA3A9WbNXiNfqEEXlF6Oxg+FBDeLBTWeykwBP3X7Ce69mx9g8+vhsyTHBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sf1ye8c0;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90A606A326
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D90A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sf1ye8c0
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e96502e447so31095925ad.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794450780; x=1795055580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+BRgZi/ru4kt6Z44lXsT8xtnCbwbkOnntJWrR5mZ6uk=;
        b=sf1ye8c0sYH4D0xHSeFLJxtpIO8jYTtz8n+aCV9WLa2DhH7wECKLKrebKKCVoWtJN1
         XGDXn6GnRtwi0LFCkr5wcuX1LiSqzArhl5OwTuIsjrLsgEvzwPOpsSUmcAve7cyy6RWn
         n7b2ddRE5kWsPfU8zCVrQh4I4H2MYJf+a120kMCM1Q0eNu1zj3kSuJA0MGoEFAbndMfv
         /s1djguR280b44OTKyZ9pxBwsRBlDEey6tRTGXTNXUafQh2jyBFBo/3/YWktc+tZcBDC
         2In3z9t3Y88yQ8U5dBYtfgb4neN+C8mfjmz7hYjnzm4MMpAq8UFO4Y/IAZbhHjdyd+98
         BwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794450780; x=1795055580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+BRgZi/ru4kt6Z44lXsT8xtnCbwbkOnntJWrR5mZ6uk=;
        b=et2IovIQi+w1ht2YU1JUctxdb/+r1c3CQ8BuhqaQ7HUf/LxEqw48OdZf0s7mixAjvH
         t3M1r51KItRFsrOWtSxDQt9i5ghslcx0EWG07XKhcIbPEJWtKtVKO7iKtjorCOlP1ssd
         lKO0yZvI8i8O0ta8HDlTXd59F+yLgFwrjJauJT0tYFgN1YwJjl0utzhUPZDohHPAIYqf
         GheAJ052tGuBa8++J2fAtlcDZxNj6i5KhYJtZh9mNo0ZG8UljxD3WvvjzvzsBbSVBbg8
         jhLxY5iz/U9v5I4TagAY3Nki2kV6VUE2zcw8nE0VEqiHiJ9TathG2GzA/C4CG+DsWV3G
         IFog==
X-Forwarded-Encrypted: i=1; AL+hErGYc7FwyUkVn7WGpO7sYwSiK3Uq0TY/319oo38Tz1j9WdykdhqGCn3pL2+8JiNjgxensyyZyG8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9l2UoMtCZgUFSjO4JXZTee3KXMnhBN0FE34P60Vo5yPfaBlfG8
	MUTOvFiLs8C15tA4ZkdPTe2yZB7Hm1MFAEc5eiBxgV3gGacjpqeWtcia
X-Gm-Gg: AYBFou2IH57BoR/cMIHz8iaR/D2L0n/iFXFvym+BH4+mRgg4oVysL7hZpatYZpDp7m5
	tjB0lavnQDsqbsWYdIteRXBCHDZd9e9rnFNTLdZ2NYQCtMLmdbA8n3njJNFTi8XV2urCo+Tv2CT
	sJ288HWQB9KJvgyCAgvnl8hceBwbyBanbhXGO6Kt7jR6MEqpaMq0uisCbNp8NezPEZc7SFdCyiP
	yefn5kDQDvxSUWMHCG6KPKr9o3C9wzdWkmHsLmEsUWnT7QGWVJ2WQi9S79GtUjDGMP+ef+oeAqg
	v/0oT1xX6l/WiP3eEkV0cWcrG2+w7tgyYYZBcb9G+xsX7ZpAndYDnQV3lc6ygHucYvpOJNw7//y
	5oqCekd50Km2Q9p2szS7xA97EANlrJ5zzvjLKa30KTxooKwwbTHlBr5ouUmt6kkfiqejOa2XrZC
	kZSZ/mZlt3MgtBVyD3V0rKsCw6iEcbv/84o2Hq1NqjoasF7DSAd46hm06QvBzN3cmwdfiRP7cqn
	uLUgVri4e1GrvC0YETaFe5AMJI+Z95q/0iVRnjNX7hDD7+7dh9kAARboDs6wv5ib664YF7hFTDn
	Sgr+Cbex+RjXdRw6zCPtD+BLxIyuiahuWsXQbMWixIGV6fpc
X-Received: by 2002:a17:903:32c6:b0:2e8:1910:e398 with SMTP id d9443c01a7336-2edd76d5e01mr46318665ad.9.1794450779567;
        Wed, 11 Nov 2026 18:32:59 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.124.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb68204d4sm26378855ad.0.2026.11.11.18.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:32:59 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH] mmc: tmio: disable dma_issue work before releasing DMA
Date: Thu, 12 Nov 2026 10:32:53 +0800
Message-ID: <20261112023253.7607-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <avRXf6SJuXxslsbx@ninjato>
References: <20261101063739.89331-1-0xbeac@gmail.com> <avRXf6SJuXxslsbx@ninjato>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Wolfram,

Apologies for the handle in the Signed-off-by.  I have resent the patch
with my real name, Yuansheng Yang, in From: and Signed-off-by:.  Only the
author identity changed; the code is identical to the RFC.

Thanks,
Yuansheng Yang

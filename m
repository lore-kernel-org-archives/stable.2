Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6831BCAE
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905923; cv=none; b=lwyWrbkVaJu9xV7G1XVgxlBEtABhXQffrUES7rDKuBCSWTNq78O1OrJXsY+w5waENzkW7taMeZmAN0H5CMCayVGxKjRdXHRISqpD8IlXeosqSmeRR+8zbUUefEbs3wwkWTPrA//JRFT+VApSbxiaASq++Rw20AZTE59KDYsU1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905923; c=relaxed/simple;
	bh=pSJ/mpu9THHCxyVaJXMtHO5kIH5BdHN/qJvYfu/IK/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiGXMF8Hw/iBBY0bsL4TJbfsqef8BghKeC1bnWZrtfoXvIK65W31u20rqNFWtxlKuqFu16oM4U3jil5mbohLL3XEqJjeqbzZvC0L/OLnD894RbWxh2FvYLkcpukezq0jD0mfawUC6SHc44rmOgoCJyNpENJWWiG+v+Id7CqxLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=xDjVuS1k; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="xDjVuS1k"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4955de8797cso4342775e9.3
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784905918; x=1785510718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pSJ/mpu9THHCxyVaJXMtHO5kIH5BdHN/qJvYfu/IK/k=;
        b=xDjVuS1klKAqe+1oMpP3HxJOwKBtHM44vRalT1fGYPj9l9+JNImXKtbdWffA7dLdKL
         a5xnOKDoPFZ+UaXd1f9sbJWutffFhKjDH1mt3CYw/Ec8Bk/K2zTpj8qy3Yiq/ZZKDrgO
         A4RmWyxZQk7hcNy5uu/fvs+AqiCoXJQ8oab+XGA+0GxSwDWRICxAbUT/71wZ6x249Va9
         8R+BBR7h4bkFzJPXqqoCZJzMGiZdQfhE333FPN+rhjSGPPeqKyglpS3TXLEkCIBUrENX
         0zodDXeFXxxWQV/hF45Wwrqah1qb6FYP/04OSiQYmvthOeKjReeHSYE9Yz9mk12uXnhg
         tkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905918; x=1785510718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pSJ/mpu9THHCxyVaJXMtHO5kIH5BdHN/qJvYfu/IK/k=;
        b=bpRkdM1OubFmEFSHZZSicZg6byuDGGbbZdFSp7w6c+DmmN81F5MTf/SJ3kYR1rQupy
         lqbVzbfbD+iLhVYdFNOXKRUevHRDmyeJMsJAfWpLpYnbiE7UXPw4EZWmb0rWQtAUbDNp
         E3TKUooZXF8SAUlGtshxkpgIDWf2kvTYKmOEHhLjgjs9RdjTJars2HYJBbZ+/bajwUaJ
         c5Z9zsG9z5DyVXksndiWpiF9/5InrkIZ5FGHfu4gf+zTrlJYYT4a9Df21HrkFFuhOsmB
         tAwsByAWUXZ1ya8YFHxh1iA4XYPclKGe08tRv/Sja1zOz2i/P9eTaxeMtCSzggF4fzGJ
         zevA==
X-Forwarded-Encrypted: i=1; AHgh+RphgZjpniO5oCDl/bmwZ9b7cT0ws+hlCHm4XHsj0GiecM0Y+2PJf5fs04RTUkvqakLokYj1E+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmjU7gkmdjIyVF+K+NEVReA1qmTCaKR1kEU0gUrQEgjz8fWtYI
	Yad0vDGaJH+hXYYU7xh3a1IU8KVkZzH7tGJyIAVBnCiVfGAbRTv7OdiTAMTBsse/X/CW6KyG4GS
	6RtmC+A==
X-Gm-Gg: AR+sD11DnSOM2+4ssu063UdvcCdEOW3k6UtHc0kPv6oP6Zv8q+ur7mzDyxjzFXXhgFG
	L16MYGCPjoRxpCewDVqBCeYAD6a4KrhUbUXI6bGh1JPN4MiTgb4YCLvTuGK60rndHWYj9WXxqEK
	LmWBlOLK0w8pEP9S9Xyx6gW/G6iDLDdl69m6gx/6b1tW5T86m7RiBXJzSaFxDa3ZOBciHT3qs3w
	otWf37rM7OfrliiY0vIEvRON2gByP3Wd2exa/lpvXGUf+fcOIiv2LC9qpalOTDmdz5xQCydEygQ
	cFyuAD1IQmlHPr8zTgvgVJVHmYq/o8PmiZFu14GARwJQniUF5/qTXdjJCNOT2UL7g/Hw2gCf93T
	sWBYzhOwmDorfuJ83hgHj01dI73L1XFRn2nF/mO8gCIKiHp0zZAfx+Uo9wvEIPXXY0VDIgt3YSC
	eSNqFTVX0PfridCM5Q+ml0ouxLD/VyVIhmajhUR8UCMuD01d/Y5MxCCA7QMYh4Mqg//vVF4DL0y
	F+XhFs0cck9VwojOatKolD+vw==
X-Received: by 2002:a05:600c:c492:b0:492:3754:15f2 with SMTP id 5b1f17b1804b1-49573ce95b2mr105427725e9.32.1784905918158;
        Fri, 24 Jul 2026 08:11:58 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.219.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4058c21sm525885e9.1.2026.07.24.08.11.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 08:11:57 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Mina Almasry <almasrymina@google.com>
Cc: Doruk Tan Ozturk <doruk@0sec.ai>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] netdev: require admin permission for the bind-tx netlink operation
Date: Fri, 24 Jul 2026 17:11:55 +0200
Message-ID: <20260724151155.74551-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724150156.72816-1-doruk@0sec.ai>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It's intentional that NET_ADMIN is needed for RX but not TX. Maybe add
> that to the documentation.

Thanks, that makes sense: the RX binding exposes other traffic on the
queue, while a TX binding only sends the caller's own memory. Sorry for
the noise. Please drop this patch.

-Doruk

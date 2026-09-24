Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61D3C3F5C
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 04:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224309; cv=none; b=q7NsLP+UBb1b2vkPvBVOiO7MQMCj8rqu0DBWvhnvtjo5wY88zSILxE9/7RsEVTAqfc/vvArKyssps1+Qo3/ix6iuiH5sTAxo24souQnUABV0z33D6QpaE0XBjtIp1YD1iJJDY0hwI4nqGdybJP3ZbJzh1iCBZCQ3zvolJCVrkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224309; c=relaxed/simple;
	bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPKqAx0FQiS5MjNIIWakL5BfOL0GjRPS5kDlGFvQ9Lx/OltD/7JMphHz/Kk+Mmaqvu3ISPJHR0/31+S4dgHcBMM9bXU8Older6e/A8BB9+zohSYPVSAxLEZtV5aOw0WnaxZxk9qNhPKXdkcyX9KsIVQ3RbopunpiXGbGXPZBwq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHUYopcu; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHUYopcu"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cef0so983861a91.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 21:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790224307; x=1790829107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=aHUYopcukK3QY4q9TRA4dBKUeVXo15mME3s8O6Jun4Te0EHY27RXhkTEo0WsZUOw8P
         /EGm/Xy9ax2khwUrG4QqCuZEQ7XW7oLS+lkBeoYoPD3TV4v8s0rT2wLtOZnw4FTwdNC1
         Xq0q7Go72/wkeVn4fZQHGI9tdZRKI/LEvjRv39vWGdjjpweE8WalOmAD2Rzgn61QK317
         7TELFXAptkDTCjcsxDEcCJHmf2GR6YBwSa+B7eGWKK4oFhRBOHsE51UBNHPiI6n1Yb6v
         NNayT5YvpaVFLAaSBO9LUkG3B8nPcKs/mIfASz7LNMjYIyrNG2ZF4/HN79lxEs87lx2L
         e9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790224307; x=1790829107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JAG6Ij9c36PXq4bgsIh1K7CQfbf0z/ay7gB5qrwte4=;
        b=iweJjVim46581Q4wb4sn0D00dVmm6upHrczEgXi4j6aY7dDm0pAYAxaNLR1Q5HlV2Y
         Z9VYCQH8C7GisSy7E5pIyd1YkL6BOTrKeLzx4ExssUR7KGuDtNn7rSEOwzYWiSb4AR/Z
         DnMRSTKg2+2ADjJDtMzNuHPaF9bfaS32YPzHQvY2N9GE7Y7UZTpZ0oDjZndihT1k64Dz
         yNk051rGcRN/mtmzayMb9z10QUs3arGVie0N0U/6En3yrkzVOboqenjBMjfhPo4Qk3Y1
         2eRheQ4qdq1CEcdig/TrK5MyCzUg7JiNPGpwQholA2bUU75Zap3gveW1DHBRWjjo99dl
         TEbw==
X-Forwarded-Encrypted: i=1; AKwUvBykOmZIxZtW0W+plfhVBhb/Kfg/QZqyqXxZ7GorKAjoQb6eg349bCslhemyvSZJStRW6WS79x8=@vger.kernel.org
X-Gm-Message-State: AFuF++muK3m57ao8X3Phv14q7B2iooGeF3Jo+2NGP+yX+O+p3RQwFPgH
	6lZejgH7C/NG5tamA+rOil1nrAM0Ft8T0S6TjrIKS8n5hq1pptUDo3L0
X-Gm-Gg: AYBFou2tHCCRNM/QGIZBfxtzyStBkK+x4YrpoFKdtfcme337BTA4dAcrESlgucZBQt4
	as9uZtKGTyzMHT+E8bfiHwJ080KcCIFNas0dadCycxZTI+ndyiuh3poaqh6mB+25iRd5LbcgMkC
	8gzSmelILSbJF290tDDIInPzFAsI9/GlCYKTeGkTfiCLBEry5+r/2u99ZRMlrDSzXHk8rAYFsQn
	J0FDS8iFvY9N3XFC3eI1hv6fg7Fj75NgzXAIS/157KZbgwjjwHW38vxcj04FyPcDfKm3BGMUZ6m
	/Wi3CHnfQp3CE9eLOsKBMoZTIXZfs0cxpiWmipC5wGeVDSKyrzfT9zSA3jBZGEGLdBAoPTx9nah
	7pqrsmIas+xLgDx8SqUepMlOkAvkbxNH7P0MuUOFDdFhV9HretkOSrZaw8OLsz+IjWUSjO8gfS/
	6dx/ABiL2vSNY4GUv+xAuJuIIksRqnKvW//F+rTc0AGw/CjX6Oj0qBE6woOsLtpN9G6sAD1barN
	HmT55wtuoYyaz0/vNM97OpAR8pD2YCPf1iRB5tccvzsmcmmu9zB6ZLKm3J10GvQHaylOp3R/Wxx
	tPifLBw6ZERmX8FC9LJ8bLeJ9UIgJsw6unIpBraUeRoiAN59ycfx36dAtOb8
X-Received: by 2002:a17:90b:224b:b0:39e:6a81:f34f with SMTP id 98e67ed59e1d1-3a098bb63femr995846a91.41.1790224307113;
        Wed, 23 Sep 2026 21:31:47 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a097663fd0sm2333830a91.9.2026.09.23.21.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 21:31:46 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 3/6] qnx6: avoid double brelse() on error path in qnx6_fill_super()
Date: Thu, 24 Sep 2026 12:31:44 +0800
Message-ID: <20260924043144.3895742-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921042511.1473629-3-benquike@gmail.com>
References: <20260919222556.3792829-1-benquike@gmail.com> <f68323da-e90f-46a4-b3ce-70d26de115e6@kernel.org> <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-3-benquike@gmail.com>
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

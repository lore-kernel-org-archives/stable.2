Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F003A3E96;
	Wed,  3 Jun 2026 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499671; cv=none; b=BqLdWPXfLWc6ij7G61EdVQ8ohxTcORNWga+kwOkEB5gmechyRbugF6FSL38xJJBvroltRFvL+xIY7kB6dBGOz8OUXN10O64qwSmCO1izuDj2lBl1ZT+gpZw8lwdjfyP/LTeJ4DIvPbJdTR04bwQdNSgY/GeoEXalLLCDWYrU7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499671; c=relaxed/simple;
	bh=LWpoh2wA/btNiWpzg94x5uh5gldlcM9LK50m3PbINfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WW/dWFPFsLaH++15OGoj9YKqno7Ma1r5D+EpQ6ussjBfLReoz1H9Xrr17Rug8UKbM4oxfFv38D6YsxuyGPG00QtSVgtldwJHZHulkrfZifBfwUidAcJeDEo57AZJ2P42O0VYscvKbw/P9yOLfO29RfsmWclZuaPhOULrftl8zoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDctzG1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDctzG1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC8A1F0089A;
	Wed,  3 Jun 2026 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499669;
	bh=+wuwf2ftrisBFINYpRD8z316BLkLaL0eaknsbJEFTTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bDctzG1L3Iiw/XTSEeMbRNzsejtZ6wApKhlG/qZ43gDcrDSsTn4pY2PIvZMFNSi1i
	 8EwBdei4/zgktkOcmZkmLTPn86JmWWGa6RtHUyY7INHAewrC3/r15YSVyogdOYZ7og
	 DHWMhuUZr5Bphu++nSYOsSyfSmlFWmezJWOxeJcQ/ezow7qByWb1WUMvSs0mucLF9o
	 Jq4Ygr4B5Jw0IzSSi92OxxrlTlnVjjdm8EjytzzFRa3m6oTNCi/b2NV8wjScaYqcEW
	 GYllxAJjS19yaKt8NWE0kIfEEt4pYlYMM4N/2H0C7XtfA0rceb8sNN9B1aX0lI90uX
	 AQd6suJP0CLyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Wei Wang <weiwan@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Robert Garcia <rob_garcia@163.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] ipv4: start using dst_dev_rcu()
Date: Wed,  3 Jun 2026 11:13:55 -0400
Message-ID: <20260603105137.ipv4-dst-dev-rcu@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528030554.3147155-1-rob_garcia@163.com>
References: <20260528030554.3147155-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y] ipv4: start using dst_dev_rcu()
> [ Upstream commit 6ad8de3cefdb6ffa6708b21c567df0dbf82c43a8 ]
> [ Minor modifications made to adapt current code. ]

Thanks for the backport. I think as proposed this introduces a bug: in 6.6.y
the predecessor a74fc62eec155c (which adds dst_dev_rcu()) is missing, so
skb_dst_dev_rcu() / dst_dev_rcu() ends up being called outside an RCU read-side
section here.

-- 
Thanks,
Sasha

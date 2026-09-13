Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F63F12EC
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789327461; cv=none; b=q1JRJBXYaGul5HLYitDHt0d1YzDB0D2T6uy5pppauYO8qt5ZnCJSV6D5M7+1fpSrrkr86kN2HeFjZaxh2JbZoFl3YDSNZXV/jsQq//o9U3prIQ7wrU3RSUI/aZSdvg3/P4FFGsqcVIR/5IWwl13FuFTkq9KzwBT8oPx3WEba10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789327461; c=relaxed/simple;
	bh=MsBIWxnGB8efzWyVPfYnG4AD87LpmzRzjMaFRa8rZ6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QqThBaODeqAei1C6JseBm7XjBrlf6H6LxynV2H2AkHKWR+YeoIneI4QWM3cEZ0kot4xlVRKOoB2qdUsdtM0WjHsRYO16iq5u4DHtVIYC0GkDOiaxin1sqV59AkdiMh3IoiHgY/Ma9KRxl+OfJCl7hOwlk/aBTp59D9XFpCdO1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX5XVOEI; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX5XVOEI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so8719935e9.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789327457; x=1789932257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MsBIWxnGB8efzWyVPfYnG4AD87LpmzRzjMaFRa8rZ6s=;
        b=kX5XVOEIc8xaR5LzONR111/lDCNtk4smM7fOl5CvcRkbPNRpeEAYRRX9Dp9+sHrbqJ
         fem/RgEit7KgHqX1xyIZjcyuEhda4avESgfEnp58WhL5M+kLD7AyRT0kjkFw0V845Vhz
         1hF8pqHl7P7Xd/W2YPjzqTnBPGTxZ1K36UZs1V+8gZVFooyzcHTSZLQDcbmBttIaqHFY
         CPKS0UQxdMzMyXwe1Oc7ZhO5y4rDMX+U6K5OYd4lBJuGyMIvT8IjI3W0v+NLjLUtBbSD
         x6zWN2fGHGsfh8KjA/g3r9GUgYrcdBFaNpMjiW2EU7OwnVueemQUKxPZNkW+V6SBf3OC
         oncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789327457; x=1789932257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MsBIWxnGB8efzWyVPfYnG4AD87LpmzRzjMaFRa8rZ6s=;
        b=qS3xJ3pAvKyBa/V9jKcYIKk6GVv5wqORpg4OD9B+hSsTlY00l3DeQKacrrWGp3X5fc
         3rAA92rNG3GQ52ZafB/GKvAFqaZnilRaIxeB6hRezS+vhiopGsloVh2KP6E9ZpnS2qU1
         ouN5KfJJFYGf89I+UCmsKOCCclKY03Qh7dMzOPM8zAJh4GV/wZMaV7UfRcTTu1evIFl6
         nl57XFYnG9wSDNPlU0u2bjkisqrxROqwyjR1JiTYq4E3TREvGfUt1/l+QD/ghkBGPPpa
         mgrBUkRwN9LxC3uwB+xeF2fLRVfCGj8NrYMkH2RM53lMBD59lyl983Q2Bk4XByYFByOU
         hPuw==
X-Forwarded-Encrypted: i=1; AKwUvBycpWS2f7ICW67lX2xkqJL4+HV6wom3z7NbAgcbNoZIYg9udHV7PLkbNLOs+MiHBhtVE66bYGs=@vger.kernel.org
X-Gm-Message-State: AFuF++nvWuslgB1s1xeGV399KEhu7oNc8QLfcHBou4U5OCMbH1623UPJ
	ZRO8qLlCW/TNLi252cHEDi53/lZ36QQSuzSVR2SkDGT70aI2LE+qulgO
X-Gm-Gg: AYBFou2Lno6f1jbYZJoRFIyWId4+28cNdelyPGkhL/ygKunalXz6JXLakToOjjEuIZI
	i/oJxTkK3ElPOcQlhV4Z5Gs0lPXnJ1HXvIZBxbmQgncVd4Rtk490omMlBjaEUtyt72Qw0u8zTyx
	PC3e0I1xbJGn9hXpqmivsMRYKX2YpOrF+ZfTQW31DWbJYnkQ2jsYwauCQ7htiajirfnIvR6/A/n
	BytUYbpQg+wAttwW25zsgh3u0+tgMNM+3Bs+fL1uqoLqULG1Ix1KtxnyTtvXJzOp1rF3GIiSw5S
	iiA4E+xrR+L+9xWLPApU+E+teJfCj14QFmlBTx7JQQFD3pbCMqelA9zf/eExYxJVZnYxrI9/0Ah
	iYXnLYgVN55tz7S8DgTkoP0HGXIdHchvSQkMSQQYyuTTOpNr5YPB/k80Jdd61ja4HIk9aFGhjHQ
	BCPMCoq61V43CAxd9MaPRf2HKin14y/+f3tVn3mPMEzk3p+KuVnE61l2YFCE/R9IR0rLXdy/2n/
	hJ01d1PPqogXL9UOiKmTQm2JkndDleryxbqof4taXCdy6r5NOOLYN+6pMU5mKcARzFpMGaRTp8h
	n0itmEzH07zZ2cf7OjgovDK2pPefYvLx1L/zvXMX+sZoDo8p9ylbXN/vwhWCw3ELEjI4QpdHxxm
	1QQ==
X-Received: by 2002:a05:600c:c493:b0:49d:2607:4ada with SMTP id 5b1f17b1804b1-49e619bf31cmr259676135e9.14.1789327457062;
        Sun, 13 Sep 2026 12:24:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0e6-2301-7846-2cfb-35f5-6359.310.pool.telefonica.de. [2a02:3100:a0e6:2301:7846:2cfb:35f5:6359])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c2a419sm373655895e9.7.2026.09.13.12.24.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 12:24:16 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.18 0435/1518] bpf: Sync tail_call_reachable with callee state on entry
Date: Sun, 13 Sep 2026 21:24:11 +0200
Message-Id: <20260913192411.2427-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912065633.289865658@linuxfoundation.org>
References: <20260912065623.398859879@linuxfoundation.org> <20260912065633.289865658@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please hold this patch unless a 6.18 backport of upstream commit
54c27ea6dadb ("bpf: Fix tail_call_reachable leak") can also be included.

This patch resets tail_call_reachable on callee entry, but 6.18 lacks the
parent-state restoration it relies on. Returning from a clean callee can
leave the root state incorrect and make the x86 JIT omit required tail-call
counter handling.

I reproduced this on 6.18.52-rc1 in QEMU: the unmodified kernel hit a NULL
dereference in generated JIT code at ffffffffa0000118 with CR2=0.

With the applicable 54c27ea6dadb hunk applied, the same bounded test
completed normally and stopped at 34 program entries: the initial invocation
plus the 33 permitted tail calls.

Thanks,
Karl

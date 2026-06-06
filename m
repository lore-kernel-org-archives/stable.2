Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC2155757
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752689; cv=none; b=smmXmBlzHDBSvwfnUbjHzrWN/FLilyA2HBu6AuhhDp77ATusdAQvLBLXjtL7A/5ZaamXHT4+B+q7gJzODQr8Ywq9mvXYiSNtc1CTx2RwkWFGSAvksDz5+5d9EGTShZoMxaHIVFZFoEdZyrB4+OTPGjkkhiFKlWmAjwZoiAG2Du4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752689; c=relaxed/simple;
	bh=S0Y4vTzhu1uVbgQSJv23zUAtEwJgda+GHw5VKxaOXdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlgoW9XoHL6+A8mVz1kOHQzokilYLqNEF3+21tKGYvLxxSbXyTLSW2LvmgJ/DU7umRgirImqe+tzB0obQxzDk408ApoCCg5XyYZjbIP4XNr6Um78RHXmTGnKwNhkWgELFweXmRolmW1uWbkFsBMp7+fw2LRthcTVsBGJnkmSNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTOgLMkB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTOgLMkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C211F00893;
	Sat,  6 Jun 2026 13:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752687;
	bh=iYlUnCtiF3nT5sjh1FybYoMPA5WXEzUG7/rae560OPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZTOgLMkBJmlGSpeCljhEUbHovvl/aaTC13iieZn5zL/xQd6k8BOUNGbh5os3PbDND
	 iprOXJC0YGSY4nt9ICo11iVUC1eQDwxqNDzwq34liN8MpXLyp7rSiMENUI0tIN11yM
	 nIueukPnrn0MXbi05Ni25RxuvbGVBurenj5ttvE1F2DXiJBT/1oCTLGnFiCsfiSYnt
	 r3ARosqs+hcrqs9CGiMaLIgm0sqJN6DLZ14Qi4jin5TNFt1f6hryYZVv9oR6KEreNc
	 Ic01wMrzBjv6o7mN3pA3VRqqiMgO/KTblBWUKcL660xjBDBdfr9RtLmT9RvCBICbb7
	 kcT/R7v26o4Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dongchenchen2@huawei.com,
	kuba@kernel.org,
	toke@redhat.com,
	almasrymina@google.com,
	syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 5.10.y] page_pool: Fix use-after-free in page_pool_recycle_in_ring
Date: Sat,  6 Jun 2026 09:31:15 -0400
Message-ID: <20260606-stable-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604204110.2083434-1-doebel@amazon.de>
References: <20260604204110.2083434-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

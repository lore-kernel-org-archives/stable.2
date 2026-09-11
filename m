Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93EA44C4EA
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125707; cv=none; b=RBJVOyQ8xPAjAB95W2MJI+Hfn/Gzx2Tjj48dtC2XE2O4KQYjwAPHzH0heSX9UN8gHgZxizbBg+IRI++nFCTv080bfNXAEXTnNtSrKfMaF5SDiRWJagMBM3G49IL2j5X7zDwFe0CWi81Pg2Tsa5jtekd0f8SHAQROw102b+UxPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125707; c=relaxed/simple;
	bh=PTE0UF6wD2BfMy6h9iWhPesT4eXQTowu2T3FBgjztlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5UN4xxjAgiz2x+7gMscwVgosuXTamL4Ue/ez2hTANlwhn17WEOVEmXFDJeu/EOJNHjLG8vPI6HQkJFkaSk5J9dhQxk/1/r0VNPG+h8tQGgDU4T0NmC7WB86QIdU+dTnTZKor3oBWDo8rj+tNKeca8H4w2EDsmhQ41fy61vy+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVoBTKYA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVoBTKYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734E81F008A0;
	Fri, 11 Sep 2026 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125701;
	bh=cCXcjRfoRtLztvvsQf21Ryur/fX8ZI+dod6+JwMb1ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JVoBTKYAksanCi4xpTCl3hvOjhkq/mC9NEu9O/Ve4d8/B/y4MxMUM9+xKZwBLS4OS
	 3aCLi53N4ZkSnmyudtYEmHQb4Mrb59JEDjLlphNYDBcsGjMx3hfcxaXW7PFVNTdrBl
	 oBXXzq7ZPBph+vzTCl/9tTFjbXfz7/1+64V/2K6gstH9uET9eP86T4yhSi0TXZzSrq
	 HX6Ioyk0i+1ImB+BHhxrwNrSw+k7/8zP7oLAUJbw29cC8dorbsOrdIJedo3WQaBv88
	 4yzD87ejyKK3Tjztotq5sN1FeMCKd3d4zkNuKK25HlSZbOm+lOQ2OPTgocSCThS9JL
	 bxo0VmEwJBTMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.18.y] batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
Date: Fri, 11 Sep 2026 07:21:02 -0400
Message-ID: <daily-reply-0043-re-batman-adv-tx-priority-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909184910.948787-1-sven@narfation.org>
References: <20260909184910.948787-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 7aedb59b80993c912ab45ce24386a2775150962b upstream.
>
> batadv_mcast_forw_mode_by_count() pushs the skb->data for
> BATADV_FORW_MCAST forwarding via batadv_mcast_forw_mcsend().

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

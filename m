Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72153A1A23
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548416; cv=none; b=hXXGeHvvarxO19hHrXsPRxb3FQ8uQMe1FJSRVLCaIrMexb/2WQHszc0hP3PeN0s+/gw2ObzMGtFoDAwyouYiZge+TKYUq5pKcg5k9xVPMQcxYD4K6/egoFi6rccf8kjN++g3kPllpo5u6gY+j2RlkdBgQ3A4l0DouPofgtwZ1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548416; c=relaxed/simple;
	bh=2h1eUHxiNxUxONOC92BeLt+31pWnyG23qAB+2BMcAqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUa7Fm9lehRPoDxTkEkXROt9aPzdr6ii9JDV1iNgPfIiecHw+CbOnesN5c5AZomvWLNF0WOdr+t3C/Lo3Q845Cm3pJfLJE9R6FciZC5D0lsk+RFU/l9hioyFUoNXSD7aOeBvk3nu1qjxwgN0ZacVwzrCV+kBhbivyEseu7r3wp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB7s+xSz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB7s+xSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AB61F00ACA;
	Sat,  1 Aug 2026 01:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548415;
	bh=rL5kuPXymDLgCkkVNh5X2umo9SCl/wD+sDbzJCqgBR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AB7s+xSzxatpFmAREakAq7nAqcsGTPTpTe8EHgpNmlBr0PecThYUWZpBLeARGAlOV
	 2IG2D0Jjdt+pAehzJK7+ePKA+qlLVo8Hmd64/mfYsuEVKZZaEcfHOhGWqH6b4f8W3k
	 z0i20p242PCSy/nNT6rpF1r804Duu7oWvz9Rtz6TqRBuezyzpt/FZzBWPecr6dAzSU
	 uwtjyY6HJVyUw2dJziCFKRXWj5IsLHvY332czhgTW0bScizQoTB89B2bEknGK5Q/uO
	 hgSYcIuYFCmsJEkTgmf1MGv9mc171rEayAs2pDnAxCB5OnfTIjlHqkcbvArM6GBW2J
	 CEazfEXkwZb6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: Re: [stable request] net: mpls: initialize rtm_tos
Date: Fri, 31 Jul 2026 21:40:05 -0400
Message-ID: <20260731211003.stable-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731093210.1820903-1-yhlee@isslab.korea.ac.kr>
References: <20260731093210.1820903-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 31, 2026 at 06:32:10PM +0900, Yehyeong Lee wrote:
> Could you please consider 295dd295e213 ("net: mpls: initialize
> rtm_tos in mpls_getroute()") for 5.10.y, 5.15.y, 6.1.y, 6.6.y,
> 6.12.y, 6.18.y and 7.1.y?

Queued for 7.1, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha

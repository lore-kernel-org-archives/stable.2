Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D63D7D9F
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996806; cv=none; b=iKQu4CZEf1EWH9AVifKsvWZGsxzWYVYiamRA6umm9DDzjL6rN9jHXKQ4CWlTGmPbdlcPCbegC0lm61jGDHpyWDF9Zpy4T/sZBpm0CQzCom/pmENoWg8goS/lTdtZFQA6jbS00xRNICbS86UbyYSMX8FuWm8sBzR0O1a7pCc5wyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996806; c=relaxed/simple;
	bh=ihRHW1HdUmampHdtwjYy2/VwkZwtb1tErUPaZWk8SUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZvjfRyz0bBWJ1FGAKttLt3RyzeSJLs2WxcW07p6hkwLi4Wtg4BhruF9uBpwIIxR7WU+l7gypmkow+laLxXARWUN3rQycxy2Tl+eZylXuoguMdMtpCCtABUcVA8yxuNy0Q4lZgXJhFL78vbJqqC4CBnXmEVZNhk2K9L3zqyizjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sdh4bmep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sdh4bmep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7E11F000C4;
	Wed, 14 Oct 2026 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996804;
	bh=0cIooDbZeGbUhcvHwK23wiHX0dgq86xuOSmrUNyJb2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sdh4bmepvi5GppMfYg/A8bviNBmPK08j+1U2qd3yvReCu6Qa8HSMCdGFXSvxf/bo0
	 6d5k/XookEdDhF419U0LfnNcXv6AuYIY/nNkB9Cn0yMAY6Vmy9+E4EkZSCvQ7xgSqq
	 b8cGe9Upn4dEC5lDAJnA6NNKq6dek2S35jpRrhSbZzGXBo/1wahRG0ONUF4+sM8y7M
	 ldhP9xunQiPJn0YJI31vR91ckLJqoo5RCsHh6BOOPIv9afcMFsY6EiLlEfQMPAefxW
	 /NPYMRsVUn6YtvFyMB01m7vln/hF+rKvwVUumse3vIAG6A/VYDfTuy6alHQPW52NMP
	 iWdXvOO/1+e3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com,
	leon@kernel.org,
	johan@kernel.org,
	broonie@kernel.org,
	ethantidmore06@gmail.com,
	peter@korsgaard.com,
	sigmaepsilon92@gmail.com,
	gregkh@linuxfoundation.org,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	joro@8bytes.org,
	zhen.ni@easystack.cn
Subject: Re: [6.18.y, 6.12.y] Please apply five upstream fixes
Date: Wed, 14 Oct 2026 12:53:06 -0400
Message-ID: <2026-10-14-1-daily-reply-0003-five-upstream-fixes-6-18-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013174132.80015-1-artem@trailofbits.com>
References: <20261013174132.80015-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider applying the following upstream commits. Each applies
> cleanly to the listed releases (6.18.56, 6.12.112), and all are
> already in 7.2.y.

Queued all five, thanks.

-- 
Thanks,
Sasha

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423634A8A17
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387278; cv=none; b=lTq/q+FTi7m9pMzpRcqppIgX+Ua57NivoPvmdb90tBevQfvUuBhhVnkBgJZ6uwE5hjFJroWL6uaW1Thzd+dsZvL7xU82ctVBf/uR8YuK2sVTnOYG3spwJXpaH0X5bY4/tiavG7MJ8Ofk3NiPkLmxTbMYwOygBQ1kmxAc2einSZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387278; c=relaxed/simple;
	bh=8PEjD1VYduiCfEZY1wxWAu+w5slkgqHBtimWI+gf+a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIYMDAaUSlKKiTxfg6oNYOPooeiNejKsUV53m22mhUrCdcAy4mhETdq+ruI577jLsJnMURVCQA50Ix2QrbBpuaTuGHN0zs2hBcJtKy6Zykh1bvRu8X/VOraXr2xYa2YKVOm7TFK8LOcOeUzlvGzvZQ4pNcCm6CJR31gVLVfHHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDMoTMpo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDMoTMpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA3C1F00A3A;
	Wed,  2 Sep 2026 22:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387274;
	bh=XFL7wv6YAoL0uq97dnbPCotfuHh2RBmQsukjUdmEzBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nDMoTMpo9AOC6gdwwh7JCazX5qBajILc4QIsQVfWsqvAZLTxOYAQfq0/UwE4os5J7
	 mo6YagWFz8CKH/UoRWJF9Y5RkLyfaJdhtDFHdZdWUaKANe3vDw34JWJ6+fT+SaYJqm
	 SkY6I4dgz9w5APjcLXPz2GCoh9jotqYjFfNTGQ7tScSXtYXxNP68J+0ShC6Vonil1U
	 nETF+/OGBj1kSs1Acb20t0yn72cvkXiTAxKYdfbc9xK1PDLv8Jj7Az5yWmBXtNBRZ1
	 LzrwFhsfVz7Pj4UPlnLkRrZcOdD8rQwWHMrsqgKRjhsTVFLQYkYPIWMVf6b3NmbrVK
	 aMV1RfxDlkaOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: Please consider these upstream CVE fixes for 6.12.y
Date: Wed,  2 Sep 2026 18:14:11 -0400
Message-ID: <20260902-daily-reply-0012-cve-fixes-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901011909.58400-1-artem@trailofbits.com>
References: <20260901011909.58400-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I refreshed the 6.12 list against the current stable queue, and these
> eight CVE fixes are still missing. [...] The first five are already in
> 6.18.y. The final three are missing there too.
>
> Could you please queue all eight commits for 6.12.y, and queue the final
> three for 6.18.y as well?

Queued all eight for 6.12.y, and the three you flagged for 6.18.y as
well, thanks.

-- 
Thanks,
Sasha

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED24E4C5F
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613979; cv=none; b=QvDC6tLHd+3oGNWOotOgFz3LFl7f7MozY1ly9Ifo9GQvQpwpLi7OIn1JtrS1H+6W3N3WrUtD348Po3fY+v4EGsdKoY2RZrkgs5ZXyaRHmR7+qjDs7ffcopEtxAADx/b+tCFa+h8gnF3QinVOqAy9gBvtmIqfsUsTIFWVygaX4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613979; c=relaxed/simple;
	bh=IPi4VAabVQdFDyRZnqol2npuZ/zSk0XzfwOyF56Kw6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mi8+1GY8q3mRXRr7LIedJPhneRq2Y/kq+i8KDZR2YTGAHvYVWQrHzSy+o91Fr6gmHN4Ig5QpdVye27858dVanb1KKp9/xSkSMfeXVigcpnH4VO61exN8lm1J0GSFW1d7lrfJ9IPz2fr8L2hHEMOMt7Sbd4VRinqCeIvf6+kE7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6/Qu6s9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6/Qu6s9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38031F00898;
	Mon, 28 Sep 2026 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613977;
	bh=R6uPd1/ozKSq66b30a/Of6a0r829ckqyNti3/cvOvkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e6/Qu6s9HNNFW4Of+AG5ImRLKnPbt9jZTQDsw/OGskQWRXLfz0+cmLBRGWlpSl1Vv
	 /YyY3mMFHmGelW+ssZroBMUMw50l8bc74ntUd4AE5NP+2t4baTRspn0c/VvrBNadCQ
	 PQWHTCMeGlzxCKNOmpaSWr5a+PAnM//eVf5cFfnkafwYQHbQFsZHuHIet28NveOAOG
	 QDUx1ET0f7RuKHhTICKONduL7uGdo/VJEw9dgD9AcJttfSjwZP/INbiPXb4cVpp2CG
	 Ie9OArsSg+pcZ/wNeK6PZKrdxoWavuiE69o4JJCF5sPFLZp6b/hHpXt3sY56PrR6+w
	 yGmc5O/ILsdiA==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Stable <stable@vger.kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [6.1 - 7.2] Please backport 60404266ef3e ("mptcp: return sk_wait_data() errors from recvmsg()")
Date: Mon, 28 Sep 2026 12:46:01 -0400
Message-ID: <2026-09-28-daily-reply-0002-re-mptcp-sk-wait-data-errors-6-1-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <69b7f728-49fc-40a2-8c9d-879a14dff167@kernel.org>
References: <69b7f728-49fc-40a2-8c9d-879a14dff167@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Is it possible to backport the commit 60404266ef3e ("mptcp: return
> sk_wait_data() errors from recvmsg()") to kernel versions up to v6.1
> included, please?

Queued for 7.2, 6.18, 6.12, 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha

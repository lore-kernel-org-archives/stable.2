Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239612;
	b=GfA1Qj2n8hP5wPIUk83xKfPKy3JgAfLYOnCat9NlG/v0w5xYrANRGhhMmopPIDmIP3kf
	 7wxXjZPnslwSkdUtpB3XuzCzELoq0lTaMp0XvMRhdU1E9qNjrgYWzgTWwS8x/wZPKOW8M
	 2aIQ7+uXBriHVP2z9BgUXpvHLovFIx0cwlLC9hzt7KzNdXwCicPy+x6HcbPozmFRLDoFc
	 5W3GgHlCsVyyFGteW3iVph+sQhL5/vmsC5w8QmXRMdgzc3SPIzia84TE4G9Qm+0Cez6p6
	 6T2bT1PkRrus2ucdDFKcP6heBXRFoVSQa3GO6Me0CbN4v4i2YYlAQ7lx48Vf0Et7eeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239612;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CUbtoRmAXmon8SeBWgUV/uAcfaIMu4ahFPhkKZsraz8=;
	b=knfZSVszfA9/0DHcZppSRwGILmWjEQGOfXlWvXTpBLsKQTei80ns4xsgY/0HSok0p7qR
	 jgs1IrkeP4OVcCR2rXcYX2+GmFoLvKXCwk5hHzVQBMwASL+HQtJdUOGUOxcwbW/ImdEKl
	 g2GttD5AavbnDB4bC20RLb/4J9JjLhrwjCT7UDKUqht3oGvzXE+gfAixh3xWmXZre7t1G
	 3CFEYtMuo0Xul7KkN3U7XeTq8dKqgD01B17RqQNdGorZaZ1KNu8kbHtr/7KqKFsDLmMHR
	 iyWJaUQJtd6X+gUC8Vkp//A9Ja0VUZKxDXEk6V8onjNKve8gkIHUpQZrWCQlG8/upQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mH8yfnjo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6B606EE80
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mH8yfnjo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDDD1F008A1;
	Mon,  9 Nov 2026 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239611;
	bh=CUbtoRmAXmon8SeBWgUV/uAcfaIMu4ahFPhkKZsraz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mH8yfnjoHWPtiJKFmHiLNTQJjh3Ihy3VwuTsrL63ZE8pj3i/tjQHzSpmt3hncyb/u
	 3eUgiO0nuOhzmtvy3VVbmDGTQse/9z0kPQYc1jtEu067OB0Ea3Sgy1o2xrBls+coUG
	 6AdX+Ka7VvCMDkSBGG2e2BwI/ISX9KyX6mSPf4th6tP4sHtICTgDVhTTPD8wLRGvWg
	 /GaWunopqKp4ALLlTLSkiiBfXyyWPdKqOJtlQa/5UE7abtFiNfT/vF1iYsBlKc5K9a
	 qJ9FBEWjhJwW2OU9IRtCOO7hoi4foD7/ez4xCrFqBM9DsOcHXN3+EIzAdsFy2l1fSb
	 yWzIbXsE5N1Iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: Re: [PATCH 5.10.y 0/2] arm64: kprobes: fix KPROBE_HIT_SS reentry regression
Date: Mon,  9 Nov 2026 10:52:47 -0500
Message-ID: <2026-11-09-1-daily-reply-0005-arm64-kprobes-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109113646.3140767-1-wutengda@huaweicloud.com>
References: <20261109113646.3140767-1-wutengda@huaweicloud.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> arm64: kprobes: fix KPROBE_HIT_SS reentry regression

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha

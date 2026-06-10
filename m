Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957D437DADD
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092967; cv=none; b=NGgDbfKnJlJN0MTP3YfBuMOjN9W8+HLJBzaS0bNggMTGsklR8mrja5YSCJZ6VBBfbMh7xzBROM9+kcr5xqXc5H2qCk0pKiVhmQQ1TvMUuS5SGRtudVgS6HcCL2sjC6P5vp248AJQCGd7Z2dIfrlHTk99q48E0I1K2kAeM7E3QHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092967; c=relaxed/simple;
	bh=pv9RFTtNm5arVBCBflf+ahRfWBo6K8a/HPP0iwU6sd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMj/fLnefGHRQobJCPbpGEpKKUt1/55eIfkXoNuE9B/t3nPKIboFU8UfUhIYe+9vseIIkpgvJdcSUWGBSVuqq+kWCNxu81sebIhRfcNR1AvkMbN4DxqNKt6FY34ITL2I3YZ9RmgmpGFtxSy13ffVv+PE0RzCPgH195jyRXJaecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH3k/qTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH3k/qTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA841F00898;
	Wed, 10 Jun 2026 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781092966;
	bh=dAQfVRnnqdGLMxILrOcFoZgH3rbxmrYXkXLaqjMI/Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bH3k/qTYKCuksM1qCZZuN7UxWtcsPpUF3rU+pUAtLEaWPml9Ip8kQspdJ+k5u7mPl
	 /Owox43O7lhKow9vosa8TnpGatYir/zEqkUka9Z4q7bMQZxJsUVXObwzHcuRhuXqTW
	 oJqqeOmAGY8rtiCmekvZXa0yI9lnB1lGQ+SdyoM8NARhHW3Qvw8taFACO72LluqwwJ
	 d4CKRbgSu8U7hCrTcX/2k0hJFuSmLO82cGL/5qsfXb89QkzcLIeEuGAHuHdN/cnQL4
	 p+nGKQS3StTETTfrVR1jhMRiQSz3itROMdDNPUL/RPvuyEGuf7NEclGgIM7iRgZQMC
	 XG+YMptFgVifg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	maz@kernel.org,
	oupton@kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH 6.18.y] KVM: arm64: Take the SRCU lock for page table walks in fault injection and AT emulation
Date: Wed, 10 Jun 2026 08:02:41 -0400
Message-ID: <20260610.stable-out-0002.4bb2adea@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aifhWIyS3A0Bdmnv@v4bel>
References: <aifhWIyS3A0Bdmnv@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jun 09, 2026 at 06:48:08PM +0900, Hyunwoo Kim wrote:
> [ Upstream commit f2ca45b50d4216c9cc7ffabf50d9ad1932209251 ]
>
> walk_s1() and kvm_walk_nested_s2() expect to be called while holding
> kvm->srcu to guard against memslot changes. While this is generally
> the case, __kvm_at_s12() and __kvm_find_s1_desc_level() call into the
> respective walkers without taking kvm->srcu.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

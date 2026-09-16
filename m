Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0513242467C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586960; cv=none; b=ifcGs79CXdv8oARNAGjk5Sb0oUUQFkh3ACNZNUYk/dB+Fjiis3s6A12ekvyyNiIpsaBVDBDYJrHiOvmGHmcYj6tTe9QO0YtyOGrQYT2cKdQxslYmeogoy6rxVCfzhS3jkoCYCQ5RIEuylIxrzSwrYKR5lR1o0nu42nuL+BpSYfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586960; c=relaxed/simple;
	bh=+y47BX7oTIdDKEl4QZHS/0spXdlVe+kWIu2Yz68CRfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTMJvOBMBa7N+AkaOqrcSMiyKQgBgScJMB7qDD/p2LAPUXC6QaXujEfzIrme9RMOqDUziqpdTfM1+SVtVJ9H8hKefXS3t5m189fK1otlWHxz7OQNIFhtAFdd4LFpGhQR8ojv43V+T7alTAayatledXjvIR1QzEvTK7BsEc8PZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFl64cmT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFl64cmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0372C1F008BC;
	Wed, 16 Sep 2026 19:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586932;
	bh=ku15fYOYjrwrfu3+rbLDXqFqBwwPquAYK9jEOUpI4ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mFl64cmTxDveXv5lEgqO4uneD6s7jiL8hndwO+SdVnfuJNJCc5OKyytpI+sL0D26S
	 wEqyrqkGdlLeq56syduT/527agTCUhVIVFRO3kDKYw0micqgnZgl0QJCsBv4a1qrAg
	 YoatbdMf8f6BWeD0Et31S7y1CgX7bzkuqxOlJZ7+JMh76P34QzT79VpKMZUICqUnZA
	 1RJXJYVQaN++L2E3wcWW+7Xv9Tk6ZGJ0TTyNWDomHVeRphAomG3DgEFLeNLnBfEIha
	 swN1N1QM6Y2JY2hqP3Yl/JierGN+gjso08kzM8xWmwzuUhth3poCqj66BD8riAB6iD
	 djTGdOKSyF53g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kazuki Hanai <hnkz.64@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 6.12.y] ALSA: us122l: Prevent write upgrades for read mappings
Date: Wed, 16 Sep 2026 15:28:12 -0400
Message-ID: <daily-reply-20260916-0022-re-us122l-mmap@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916122437.3439484-1-hnkz.64@gmail.com>
References: <20260916122437.3439484-1-hnkz.64@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Clear VM_MAYWRITE for read-buffer mappings after rejecting an initially
> writable VMA. This keeps the separate output-buffer mapping writable while
> preventing later permission upgrades.

Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha

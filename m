Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20D3AAF67;
	Sat, 17 Oct 2026 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206037; cv=none; b=Jd4B0H1kfp2dmjo2oPPNpequXs8WX6HLY3tNHunKN/XIs0IMJai8qZ2/ek9wVKDWRvjqvu2ryxJbfAdCCVbTtYhjE7JRv7Brd2Yos7etY8NSA6rNZx38cU/DMrueKjhi1pKFL53Tnpc1m1cOd7RyJeDzSwbuyNqM6hIAYuFfJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206037; c=relaxed/simple;
	bh=PCIhtikeFldSmOdgfPbVx3VTw6+BtQ7VT+bytkNhhBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eINo/4DgSRkiAUAkBUAxt2Qd1sqy/Jl+1/vcuH4HuE7pSURUOhvcfMU8FLWxRoA4GIJcJ/CNmgJXUjHdrQyPvok1XOUCwx4NJ9/L596x3rl/L1vc7QlFkZ2r2WZ9+KcZ9leF2zbGQP3BlPDqT/yvix17gs9PKj9+dNqXy0lgOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6KD7jtW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6KD7jtW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD391F000C5;
	Sat, 17 Oct 2026 03:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206033;
	bh=ostKh87JK/EU95R+F8toJ5luoLJr5yeBgB6K3dkVWH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k6KD7jtWyOZQdr0S5VmuQLkESk2VE1zujvnorlJZFYUq81uEHYLJayvypmwEJdX0r
	 2ZcECfwmkawa0d1hIg4SF0hQPf5wCPAigrMl5W6z+AwLYPXyZSsFwjwPtR/BLVHRpd
	 oq0VFNXz05NT9x/hSRI8Oj/A6haeOOuywyWGxkRy67Q6cMRDOANQC9Eekw907aXzW1
	 dGXTofTcPQcXTs1Wg/A4LAfq0/Ap/TTAvUsPJmkD4uKyS19/PELCn9OfhzHh73wLMq
	 gbZCrrKkxICtVItl8k67J+Wst3eDhod9Mszk7MuK+tXS6usCzqLs1Oo2RJt1Up3DJF
	 Q/RB3pKW4zJIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	ngocthang2710.1999@gmail.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y 2/2] Bluetooth: hci_core: Fix queuing tx_work after workqueue is drained
Date: Fri, 16 Oct 2026 23:00:12 -0400
Message-ID: <2026-10-16-1-daily-reply-0007-bluetooth-tx-work-drain-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016021047.16461-3-artem@trailofbits.com>
References: <20261016021047.16461-3-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider this backport of the fix for CVE-2026-98297 to 6.6.y.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

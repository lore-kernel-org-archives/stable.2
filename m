Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53003D5C1E
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407043; cv=none; b=pAcF//CZjsAfs0NRvHgiIW0kYMxjtJTPMhFUyncer/25hsQc7sxAJTyJH7AIEKrrEaUlpMKNl1jDxFmtVTySaALEaL1sUWU+GRY8HDjPHFZ7Bx89aW8wxcKK8hXi64hfxqoqoGYcY/WLEZrw8FY31743yPUR5ymyAAAr3Gs/y1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407043; c=relaxed/simple;
	bh=EJA0xaWuggtf2dPYC17ENFtdof0rPD/lScSPpKL4LLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3TNA/eZ/TPaXUPwTM3yBYUFqmiP/0v6Y9DjYp77MYxxIbhCgmKz2finbMO0LyE/F87ffW4Vz2nwfuALgh7hQAK8skfkcY9LXKy6IhLlYO7E0IT+N6IlQOhCSr+adR2b5pVBK4gauMVSqSD3mLUQKiQ5X/4SXZ0QI/u0eDIOOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6avHXbi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6avHXbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA431F000FF;
	Wed,  7 Oct 2026 21:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407042;
	bh=trQkX0SG5Xd+Q1uo3Y5wn//qL9pH0CgoI/o7b7TuHJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i6avHXbiudIf9iO+yvxVf5vgWv0B05oNs/DBLnBg4uM6eJ/0ZqlFrAbg/M9KSO+5l
	 pizsXJNNbyyiiQMW2UDq2mjZq+HhnlSiKnVtrAGCSg6+hEGIL1lLH0q8s7Y/MtlqEF
	 d3kWsM2Pdv9wrvHvTA3mW7K9rIHd26K7hdWQJalzNPPWnWe57R7YyGSM6LQo6VlRXt
	 aq9/rNcndYoGZEXPaZbL0MaffWakivIBOWwDVMo4beWHsSZzflhHmXRo7yCeo4t4Je
	 GlQHmi2oITuYZtjwFzDxahKd5bCQrf+OmhnnfIOc9ARAsqWBD6zymJZGgmoUq4hpL6
	 hoOXBDkzE9EQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Beata Michalska <beata.michalska@arm.com>
Subject: Re: [PATCH 6.1.y v2 1/2] arm64: errata: Factor out broken AMU const counter cap
Date: Wed,  7 Oct 2026 17:03:27 -0400
Message-ID: <2026-10-07-1-daily-reply-0010-arm64-a725-erratum-v2-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006123250.2385089-1-beata.michalska@arm.com>
References: <20261006123250.2385089-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Move the workaround from the erratum 2457168-specific cpucap to a generic
> broken AMU constant-counter one.

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha

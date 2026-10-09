Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCA63B1016
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565814; cv=none; b=f2d1D/0DM2nG3i3A+dZSZDENnaZYxs/lZ5NmxWEthXvF+mnDIHJ/bkZuTVN+ezz3Zn/Xi6HIuT4VilKI9mNKzuhGm0rttDkvPVeArthI2V7jzUq1CEACkg8+rnqr+oi25Ja32TdZTV8+8by8e1e34B0stfULzbcrwNiT3lQGQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565814; c=relaxed/simple;
	bh=RV+hrDxg1r1O9mE4+DcaAxh1I13/ufS1AkMGV3j/aYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFse1oGxEUslbNd3WewuJNOliGG2qE5qobi7hzkg8CGh3dy9qTc8W0KsV9oHa3AcYZOQMfMXpsOoWNMH3qSvpuSgE4GN2sj3hFYC1jKk01HHczn+8ZUf0TjrJ1nt34ROyUqhHG/HXW5eD0UlPfgzces0chACLoW6W5aueJZBH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOpJXqlR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOpJXqlR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073401F000FF;
	Fri,  9 Oct 2026 17:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565813;
	bh=+YYUKPw08mScW1YwxdyO5vXcBnUaOKKph+CNbKP7ZLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lOpJXqlRhAg8TkqBRAYWJAhTtUhMwWTEI8qFvn7bHDh6lOGnR1C1FJEaw1FLdT1pI
	 un04Uyj7APBM8KluZdZr8SjVThaNB3VHHb+1ofMFZLs9OtJXZL/Pad1qQgh9MvSur3
	 Fy+5pJCrjuIKM7cfGenFbW0/MVqnpcg3zeyXdeWPJU6JgVGAXbgPC2uZOa3W3o+zSV
	 rFEu3mfhREmrXQIu3qkzf25EPcc7jaED24E8GC1ehG11TFhWympL0TCd9EyDKhUU4P
	 TAD8DnuRKDL1H5+ol53SbPtl7Lr/Mmt/4bzwB3LPYKaqmzHLloJAsELFSF4Xm4got5
	 MJTBCZMBnY9zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: Re: [PATCH 6.1.y] tty: port: fix tty_port_tty_vhangup() race
Date: Fri,  9 Oct 2026 13:09:40 -0400
Message-ID: <2026-10-09-1-daily-reply-0003-tty-vhangup-race-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008141627.1183294-1-ue081723@gmail.com>
References: <20261008141627.1183294-1-ue081723@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Add the missing serialisation to tty_port_tty_vhangup() and
> tty_port_hangup() so that the former does not return until the port has
> been shut down also when there is a racing hangup.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha

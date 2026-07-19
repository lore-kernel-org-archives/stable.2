Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA739DBDB
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473253; cv=none; b=D67+tN44ZPyKSWkMR5wD6YqdNP+auTpG/ZjtWtpJZSsDVxiQmOFn+oJXg4MBjylJBi3s8Ti5MVa+82d8ypUSjELjVLdVF4qqLQbLKs1FS2mQfK2ZoTIIvKqocXnMaJbUXawjkk4CoLeT9h4WrUryZMX7u9hFgZSNN3Kzmeoq6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473253; c=relaxed/simple;
	bh=dcQm3TCgZm8RYJXJuAgDcJNiIaWJ4wdYGcBYxfUyd6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmF0p1DBxmMRGeIpV9zpG6iyKTUf89TVB/qkaWy46Xu4hgKEbPDLrXlq5zfENDp7lwtSaMp2D0O7m10onRIkchyftC1gFcGLNqlZqifKXTfm58KCLcrq+NQ8JuJY6vSOETB6P6eOQ4pgqMatf1duSJssrRJaV9dVwVRJl4SKMxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uge4R16g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uge4R16g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2FD1F000E9;
	Sun, 19 Jul 2026 15:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784473252;
	bh=bAVTyiHUpq9LfQKYTG5yh77MjW7dqKT2ue55HZIU+dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uge4R16gbOSQheXiiArqtqts7gKUXlXV7K3IISF/qBF/PJb0WXEtHuPYMUL/8rrlY
	 uAhDElXcXUi3W14DWsHOfu2ZB14egGCkQZZsE/R5xRqK9Ih7dWdmM0sH71AyeUpV7i
	 NHtRQPuPUSv2lilmclixEOPbWu4SlUfsyn/jDjj8p6tRQkAwVuHAAehLmohRco4JzN
	 wl4ZYVqLKnwKN2ZnSGuSY6kejfSNOaBTKUnxlPzVpQpfcPKhi4g/u8yJ+tuiwRIni1
	 elkBBhd5phEu7G7aScSjLMckX2NxPyJoumQxc3HcKWUl6R5cgdau88Q82fmibzdlS1
	 mzV3a8UWX/HHA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	mikhail.v.gavrilov@gmail.com,
	leitao@debian.org,
	oleg@redhat.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 6.12.y] timekeeping: Register default clocksource before taking tk_core.lock
Date: Sun, 19 Jul 2026 11:00:25 -0400
Message-ID: <20260718192718.0011-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87o6g6obwg.ffs@fw13>
References: <87o6g6obwg.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Commit f24df84cbe05 ("time/jiffies: Register jiffies clocksource before
> usage") moved the jiffies clocksource registration into
> clocksource_default_clock(), so that it is registered lazily on the first
> call.

An identical backport is already queued up for 6.12, thanks!

-- 
Thanks,
Sasha

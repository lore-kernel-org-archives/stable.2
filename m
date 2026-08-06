Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0E382284
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038605; cv=none; b=nV54KB5k2AJGe1QDyIGAUMj4FA+cnXuqq2alA62+cVie6WXc3y+lvsH1Gl4/di/+f42OpTcxXTlnXglURK43ioUWzWjU5jGIS52csL+A8LiJdllCcn5nxHbBndIBU+TEcKBOsstpuT+/iVW0JPbAI6OD1db3whs6YeviicFFDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038605; c=relaxed/simple;
	bh=UAyZ9N2W5UchFdGOZ/7Kff0x0EE/Z75sjcikdLV8z60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7uhs459LogctVABGPCZBbMtD5WFYsPzNhGh2lCeSfxxy3N8v4943kOanYSgK8di+VaVOnBp7lkIqHUwalNHoMTZrWzd8CR7nG4lSxWLJy/DCLIG5GUrH+8RTO145InJncUzAGpF6reBsIo3avNOYudgfkTRYb5jwoTrk2Mbe7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpVx+V+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpVx+V+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C167F1F000E9;
	Thu,  6 Aug 2026 17:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038600;
	bh=DqT6xTBPkNlwB44cgpBusqeWbrYU7hDiasQWP2Wa/xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UpVx+V+d5aLR94VCotwo5APOL6SAebL3T393GDUWiYn6QKtURcodY+BNgPUMJkgEW
	 EwAWWbJmOJusCnDb9BTWHfW7D30pIbqjVxsTT4zhS9swgQxzHhbX5Gzfmlv9GKMXVZ
	 THjt3Agvvk0oYkaT48cVP6T2D8iYsixlodALArvTEwj3UWsZ85QbwocbffXXgYv0li
	 CnmCIIz+jdIEBsiStVrPBd2xY2t3CaCARQ//tJIfIuppjE257m91QyXVz3USfmzhp2
	 i1mz8uF9nSVQFIHSIE+FY7Pb0V2TbgNMbwWmEshVASwAJ/PP1Kcy3z9KwrJ8I0nt+P
	 +Scs/Hc2WKlAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Junjie Cao <junjie.cao@intel.com>
Subject: Re: [PATCH 6.6.y] gpio: pch: use raw_spinlock_t for the register lock
Date: Thu,  6 Aug 2026 13:49:44 -0400
Message-ID: <20260806131006.stable-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806021934.3225570-1-junjie.cao@intel.com>
References: <2026080540-oversold-buggy-b5c4@gregkh> <20260806021934.3225570-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 10:19:34AM +0800, Junjie Cao wrote:
> pch_irq_type() is registered as the irq_chip .irq_set_type callback and
> takes chip->spinlock with spin_lock_irqsave().  This callback is reached
> from __setup_irq() -> __irq_set_trigger() -> chip->irq_set_type() while
> the caller holds desc->lock, a raw_spinlock_t, with hardirqs disabled.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

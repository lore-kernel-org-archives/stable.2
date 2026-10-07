Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4618F37DEA8
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407033; cv=none; b=me0uk89kALNStxP9zWspcIjxBVrknN0izIIifK6BTIa8FG+uOGgn5td3B3xf84bbJqFQWw4BK+yff1ImN4Tsfah1/YosWfZwxoPyob2ySIeo/hg1jxbwsO+ClmC+/bhhj3pwxrkZZOyY0r9NyCCniLWsRTNXK1ElwEjvjc5tZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407033; c=relaxed/simple;
	bh=gkMVSAUfQ6o9CH+pi38J/KZj/qyDfSv3EV/+LzDvqA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r82+lLvQ925Iu2RBAaeh5WDY6bUKpR3Vz1IAuzb6NWtqA2GO2ZCYmkVePSN9ScUkKBuL4X9KBO/Yw4FFC/P3UqrZHTAai/n+rukqxZWHLHQdZfZB4oYO9nZLfj6XludNyEqc/UAv7X7J7v9qQBUsuyt2dVpCvG7AJGLr3JOxorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaNUIjMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaNUIjMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC31C1F000FF;
	Wed,  7 Oct 2026 21:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407031;
	bh=x9Vf9r+y3lz2g8PUo+vQFgpM1lOiRQ45UadepkrGJaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LaNUIjMu5pxGhklRNRMLpqA6PG7jMyz33PSVR7Zy+1Lhm2RJOQZw/X5eSdV/LK1ly
	 DO7bkgUF4ETJBJYnT2VGXyzhESZiHJeBuZ5U1V/AXJ+FjucuOd4v0yUo+0RRxQLud2
	 Ccr8ppjTMoBcC6kiTjNJWTDKZUEi6yNjWB1EAag7k7lkBfKxV/kJvPqox2m6BIX55P
	 afYFMHeqvqPuOUKaEzf+QSXvb6Na7IcZ/FFcej+hBgpg0rVfp9R544FgvSsdCxnsrN
	 ruqMp1qO7QxtBY9tB9DkAgMgwM8v7DmT53RVladMeOWHny+I5Ips5K7TRcbHgA/WZ7
	 pZFsV12pDmTeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: Re: [PATCH 6.18.y 1/2] net: mana: remove double CQ cleanup in mana_create_rxq error path
Date: Wed,  7 Oct 2026 17:03:21 -0400
Message-ID: <2026-10-07-1-daily-reply-0004-mana-double-cq-cleanup-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006132523.2742871-1-hamzamahfooz@linux.microsoft.com>
References: <20261006132523.2742871-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> In mana_create_rxq(), the error cleanup path calls mana_destroy_rxq()
> followed by mana_deinit_cq(). This is incorrect for two reasons:

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

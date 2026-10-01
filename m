Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382C51120F;
	Thu,  1 Oct 2026 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862769; cv=none; b=YeJ2iqcVZIFbvvznSnuSKcjzMD3An2KNIFktRrYzephxZ6zWOkOddiyNoGtVb0vt/W0pzsruEwQem0Yk/5yH/TfJgbOYM57ie8wE571CwVQ+d/m8+wMTnJrdLbzq4c6KkUAjASo7aEfCybmIxKkyBYJUZql0PTOeZHvQyVc0w9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862769; c=relaxed/simple;
	bh=cFjN55wjDAYScxHpsE+Su13GYxwKPM6IgOW6kVCCHu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLX5ua7AiaMVReA5qkg8FUbABtuotPEmc0yj3CK26V8DaE/pHTmqkbNR7sdW+9Ea8sIQ/lR/NANUp3hA2k9Yu4YM8kio3aTNevb4dSYub/uGzxhVPy9V91DFgN+fffTvFkpfAam6YMoePG+UgQzKadf8aBq0U2aBPerLMXg8hsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEiKnnrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEiKnnrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E443E1F00899;
	Thu,  1 Oct 2026 13:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862763;
	bh=tU6NNV1emcvlTAwZ5qZuHpzsfE/F4WTxLxdCPlXxq24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JEiKnnrfniNFGdANnvsufaBO+ckQZzZ8CrLCcNO8BtvtTDwh0fUCnmu5JvloNrvhV
	 2y1dPBAfOXIzZR3EM00AjnWbMgQfzVeP/3o+SRYy1v8fVyQUW5P/Nb2QaGFNTb0i4H
	 7J3soqznnhTYAqwRJKmftNnKZUvYuMr4gTrE9ER7NB72uzfN1O+mVmsV8Dj2jYNQVu
	 NZ3OWA/H48waodVPU0t16F3sKQE3wLAw2j/0SzJoeOnOxgRO/KAP3w9BazqiSnCIZs
	 iyZbBs3cQ7eA2uVPNnWJikRZHedWBB0M7Klw9PI/1eumKevCYvkBhILPNJ6oypWXst
	 yz0HeejRElSJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 6.6.y] media: av7110: fix a spectre vulnerability
Date: Thu,  1 Oct 2026 09:52:16 -0400
Message-ID: <2026-09-30-1-daily-reply-0012-av7110-spectre-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930011353.94864-1-artem@trailofbits.com>
References: <20260930011353.94864-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This one addresses CVE-2024-50289. It masks the validated CI-slot index
> before using it in the av7110 array lookup.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

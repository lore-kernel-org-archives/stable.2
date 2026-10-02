Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FC36B91A;
	Fri,  2 Oct 2026 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950816; cv=none; b=noZgzkPyygsdFymcp2Z3alPMFRbroHrO0D/X2MAXzgRJ3OqblZAd1YnzQIya8vCrh03izechZuzoKkccDSUSZvk+MhwCYvNDGF92P4j35NUuvNxf/eW3YBZbR/iWsvWa6qHSSscDyIlVUL5b0LhSv3F3lz+xMFRM1bKkupGphnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950816; c=relaxed/simple;
	bh=4gNL5hAAUvN9utsqIqTXkPz06R8ZPLAV6wC5gh1Wx84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2nzAmYJTUDVuT1Ks1il7jeqHTg3hC3DOo/XhgHK8XPrJez7lTiWAfWWFO0O2UxhdlAIyPvmVM380OtQJVoM7xNSWxIq5/dsky2h5BjbyCsV+rAv49WCq/Nxv1jNWPKJbJxxdbvwEnkhmUDQZLTtzjF8RNooFcukmb60ljvBNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdRKAkgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdRKAkgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF741F000FF;
	Fri,  2 Oct 2026 14:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950815;
	bh=zZJhaUmniz68tditQ9lH3G8YYp1vap6JfMpIS8Mv4pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WdRKAkgbQ7O7qfEu92L/yI4pBtRkF5LgmuPnFI/nYnqtnU5AB5gTbrbCqHKLLiGZl
	 nxqrpb0aYUj8LZnL6heILr2WZAve6f5TJzB/pYOtX9EAPja5EiUwRbWvGlxIGwqsVQ
	 XbmuP9Knz9LbUBqN4JgXOxWHyqbYTXOeXSxPZ5q5eRkYuQ5tKwllT4HQl0XGVnplMM
	 W8ruXDAyAnqNN6CnaaGagkN3c7yapzvGVTev86+ijb7ONA7OwdFGky7GJm1Ejqm5wO
	 hWVKKCXGIya9S9dD9rBOYsGz1CUwMRxRHE2ECnDYtf5vDmRGtHyz6C6f4HLs05ebP9
	 hHuyCgpkGGv7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Florian Eckert <fe@dev.tdt.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable 5.10] tools/thermal/tmon: Fix compilation warning for wrong format
Date: Fri,  2 Oct 2026 10:19:57 -0400
Message-ID: <2026-10-01-1-daily-reply-0013-re-tmon-format-warning-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001160156.814419-1-florian.fainelli@broadcom.com>
References: <20261001160156.814419-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 9da39ef332c417ce52732564c1c682a6e1209302 upstream.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

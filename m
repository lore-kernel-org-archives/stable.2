Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82B7344036;
	Thu, 30 Jul 2026 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379237; cv=none; b=HMcx0MtzQcBbPz/QasKOtzBWTvaMAXR0AFZZndX1yggfPRakKcRwJEqMRJqG51B7dhDApbYt/jmk5Key23YgVpdcQsE2dDoClu2Qh/SSrNbW4uDS1L5ZG/huq2xTHyF1ZmDVRGILOSX/68vxcyeqQQnK+DM1DH0IUX13w7BkRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379237; c=relaxed/simple;
	bh=ohrbQ3kAjZe6XDupBMD450ay5mMm9JqeyTaRXoM4KdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UO1fL4UO+pFgGnt1LC9lguheeUqjhugVeGolzbKh+y2g9XmvyWJF0pWQfErLyptDtXpV4XEhqhfZfMPyPM/n4s2sqbfA2yhhcZM/ZK14eg477WG826k4cjfn2c44THdjBW5PEMl9l/IwgAkBorDG+BQrmoOyOtoZRlsbAveFkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbMwtTFD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbMwtTFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0329F1F00A3F;
	Thu, 30 Jul 2026 02:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379236;
	bh=n4Sux8DbjGorILfBN5hibZO+wt5nEtOpm6ZrXOCwtiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XbMwtTFDR5TzYMKIr2u1Lbb1ISJi8U/rplJRzEK0MSL4ISxERqVFg8hBp+jVU9HnH
	 cHkLaJUzIeYWQerMXQwChZ8/4z3+6QK6kZ4B/3juG+AtXQVoJdpz592nmRwBUDd0F7
	 ozo0zoqSZP7ac55tzFf6HhYl6yTKUNK3Ljg1W4FiD7Yk/C0FU14iRGehHKWZR0Q/nK
	 xvazgoJUluR70Zel3jtiC3eyvWt+iaY1L6Gqt/PWWBO1rTyXEv9KHHyn/d2hSYkBdI
	 pI9Hju575ouThHMlrdULXnmxEdipbFhSUnp57qRQbJZ+zV9C0WcWzRrs+nZ46IGwez
	 GP2R9xeGNAfAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH 6.1] ipv6: ndisc: fix NULL deref in accept_untracked_na()
Date: Wed, 29 Jul 2026 22:40:02 -0400
Message-ID: <20260729223316.stable-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729090809.76178-1-alexevgmart@gmail.com>
References: <20260729090809.76178-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.1] ipv6: ndisc: fix NULL deref in accept_untracked_na()

Queued for 6.1 and 6.6, thanks.

-- 
Thanks,
Sasha

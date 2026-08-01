Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB6921ABD7
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785622414; cv=none; b=scz3MRaebPecxNsNrum5iYJVPVDikpEXIsSJmnw7u8yYm7MUZknHjT4f7K6kKIy8BqTzLY/QRbP82mdhE/JT3kR+dJGH3X/EX4OvmtkhhHr/j54JjHjlUN/XhRZs8LTTLM/tiOFQHALvJLG4N2hrEgG1Z72rCB75Xq4kqzf4Mok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785622414; c=relaxed/simple;
	bh=/aVrhvq3qYDNcq5Q8ZPxUypMye2WOX5Lii+LUQEWRKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGN9qcmbAkmlA0AZJZ/nUlsYirMip0E77cDZ2j956BF7nZisonJUKk4eFp65j0se0D2S2eFWvFEg/2VgBXdaMDZk0Mn6u5ylBVzixNrOFr0vEmVLaJm20W3i7UJMPbATnKd6gk0OGggd91jtfOZR0QKC7jNtAgli3ufvJEorduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfooD3RX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfooD3RX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E1C1F00AC4;
	Sat,  1 Aug 2026 22:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785622412;
	bh=S5ygApX6YOH+eSS6Wf1VHtl94uU6+JfQwYrciF1jC2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DfooD3RXCrOVqwFv05qvD2xt0jOkgUnaqpebJwEQtAAv892mqn3tmuQFjP3XkYqRT
	 XZTZHRBBUiM0jX5+OT+RKz7/lZoKFiQM2/fhqIK/7Am1Ia8djxXtFmVxaju8YojJ/3
	 FnHrpjcmlzCiWBvj7YWBXZDlqzOfGEFvKK6LGKu5KXRWqDWvyPodlWlv+cmoaifGsF
	 FkOAMXIJCelABevKNhXeR62l8sRchX+ZTr4u3mTvIFYV4SQ3DrRKscss1kdOK7j2vx
	 nZMRljor1NKJ1jr3jdi87rt3bpdwfSutwgJ7XxA2Qnamt2Ie46nAfOs8d+EOHaTTvC
	 9OQn6uMNa3SPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eddie Phillips <eddiephillips@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y] gve: fix Rx queue stall on alloc failure
Date: Sat,  1 Aug 2026 18:13:23 -0400
Message-ID: <20260801154223.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731155925.2769961-1-eddiephillips@google.com>
References: <20260731155925.2769961-1-eddiephillips@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 31, 2026 at 08:59:25AM -0700, Eddie Phillips wrote:
> When the system is under extreme memory pressure, page allocations can
> fail during the Rx buffer refill loop. If the number of buffers posted
> to hardware falls below a critical low threshold and the refill loop
> exits due to allocation failures, the queue can stall

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

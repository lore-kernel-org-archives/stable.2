Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDF3546EB;
	Sun, 11 Oct 2026 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737316; cv=none; b=S8B0jgEA81Yzj6q3udDKX2jMHEucbg1CLaWtXv4qlIJjoFeR5ZqauvM0dEIUop3wvd9I4f/azHoY4AbqjCDCv7UIqA98XdI3600au+aOVKJCPRiuutICNU/maClF9u6StmpAA7QJB2IA/8nl+ypyMqgpQRIsFQmcO/b2ZWXc2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737316; c=relaxed/simple;
	bh=/rsWNMg/nsXzMvPnUr0F14gaf8ZRtZ2HX9prd/eaSDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFNzV/0V57vJ7OVlaqg/NhZs5rJab6kkXhsRcz33jEmwEAFZDoXZCRuVkKpiJA8sYJ75LprMMKdqQnUwV7e18GBlHd1msZHUJMf79tr0NDZj0RuzTxJmjYRWJZFnhIMiGrH5yKQtHlmEAgyAuD93uNj0Ea0FCLXHdvzp8lHbIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbutxCJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbutxCJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A531F0089D;
	Sun, 11 Oct 2026 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737315;
	bh=fVEbiCGJkz6LGx8IU72XRlFet1ix+jfmxBA9eJo4Iog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QbutxCJzZ7AQ8IAZEtR3BeVv8pZc8dAhYmVgtjQNXiHw3fC/oc8s3YgO2uxF0vCRp
	 6dFoHjZuUJjFb2G4k9C1SaqO8ELOQViROe2zNQdbj8mQXqB+4Wfo6VEzyZg0Rrg1aq
	 3D7TDJ3CNJW5sfuzNM2JnYemTz7kLbaT0Za57zif9XPgDf+uZqtxAI6+E21rQZRw6w
	 g6Ly47jrsb//8gmEgKQDHY6PaZ9Yuqgln1BLX3fS3iI62hY8h6E61MEjEk/6xR/6YN
	 lUrMwYitVWx8Wto0oLoK4Pww1EjIrv7z9FDA6zZeZlaCK/zpZwVd6U3hcAPpO200kh
	 b1t3UN8Dcj+Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	Rachel Menge <rachelmenge@linux.microsoft.com>
Subject: Re: Request backport of bf5a54bc0e3d to 6.18.y
Date: Sun, 11 Oct 2026 12:48:12 -0400
Message-ID: <2026-10-11-1-daily-reply-0005-ynl-netlink-raw-max-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <899bd843-fd19-418e-8913-91bfb6e760a2@linux.microsoft.com>
References: <899bd843-fd19-418e-8913-91bfb6e760a2@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider applying the following upstream commit to 6.18.y:
>
> bf5a54bc0e3d8962474fcd611f1266eba036232f
> doc/netlink: netlink-raw: Add max check

Queued for 6.18, along with the schema check fix Anton suggested,
thanks.

-- 
Thanks,
Sasha

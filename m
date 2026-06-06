Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE523183F
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752687; cv=none; b=bEY8CRZ1o35bV2aRgLujeznN5VhOINL4TA6V+A0T3WwykC0z6ddv7PCFoKgGQONaMUyA4FrcTp2FKkpCgNgMBkNsE+UrupkOZmVLw4RTwOFrT7wfo6s09MXFumQehH8vK3lp/eGmr7/v6+4jZR+LQ0k1DGiuCILri0Cxr4OO/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752687; c=relaxed/simple;
	bh=3HzAmxbHLtK3XRYOD+GQMkne8MWGT7yxsAMYToruO1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdsvrPr6MxaNRAqSX8nclrl6BgOkNUVRBtEegasWvuRFE5J+KeBKwAfrYdFS4aFezfrI0AgS/10DUqL24anSIoDOhDmD1mTQiwHXH6S9ANNwoqkKcExD8rk3j+8tbnC0cPf3TBoRU4nBV/qS7UsOk7UVTEErho1+78tJGY8yM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di/Kk4ZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di/Kk4ZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7E61F00898;
	Sat,  6 Jun 2026 13:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752686;
	bh=t73p2I3zof5OTdzUFh0Y+Fxp//BaqZzHgLjsEtNLW6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=di/Kk4ZY+s51NVv6YLzok9h1x9jk5PtqrBKESGrLq9yKPRFhFHRrPOOWXxIrUv/wo
	 HiJM8v6AUzuZgrYDrNGrAoTxYMRCZyEfaDBywfqJCIaLqqU2EE3EqRX/LjB3fM4mqJ
	 pwyupTaq2Xp1JL5Cb+QyYpk+CfbEqc1ZC6TaF64/YLd/WQOEAVrDiWdukovEWRXIEG
	 bFwoOU/IE37GEpoSEOE+6EVAtVn8ZtKJmGNPYsz1vYqMAcUEXzjn7P29xZeElltglo
	 So4xTrQu5a7sL9c8IZfU962b5ulej2Nfnmd8QA3nB5p3ib0dQNlo+Fn7a2oHum5jTK
	 Uds/ZdEvp6ecg==
From: Sasha Levin <sashal@kernel.org>
To: jiayuan.chen@shopee.com,
	pabeni@redhat.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Rajani Kantha <681739313@139.com>
Subject: Re: [PATCH 6.1.y] bpf/bonding: reject vlan+srcmac xmit_hash_policy change when XDP is loaded
Date: Sat,  6 Jun 2026 09:31:14 -0400
Message-ID: <20260606-stable-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605060744.2302-1-681739313@139.com>
References: <20260605060744.2302-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.1, thanks.

-- 
Thanks,
Sasha

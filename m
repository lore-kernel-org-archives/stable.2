Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6E37DEA8
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407035; cv=none; b=iKVtP9mx2mCGUId6cUxgiE2k8QAUxLmjvVVqkRlQ3ACNMNzHFkQL4kxOckeA3ZIpa80QDUNlUpOfrHT7wzCc7lS4H/4/YYA41pgkstneIsbyeqnHfKYab7wJvCxZpozAKLrHgeGoRjBrzoQnPMfCOZpuurYENXxLmOzsJhoEmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407035; c=relaxed/simple;
	bh=nArq/Sr6Jw6uQdCuSy0WH3a4U9yXN9e+Vm8PpspnMZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7JBZaYCKV/k2jSHwXymsHZ/f57Zf6bLnT1tfOVN9Dhd3ndSn6Z0wqVaCE8JAY8JnXeRHRfRYV9GLixtXPb1jKBe3CgcLCMaJh6nbQZp15yfFEca6MWIOevwZ8dVsBJ56gu4QSf2D2o7+rYWM/PyldhlJ4bgNhNbUFd9fIbkYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QA/mUwBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QA/mUwBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF731F00893;
	Wed,  7 Oct 2026 21:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407034;
	bh=JxIxBWLm6n8sLtxGedPWgFAZtdK392jcZFGCq3SOtkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QA/mUwBeLLkPjW18ucrQS5+3K2HhpMr4w2mDwBq4BHXU5DfydNIkf+7q7Rwascv4Q
	 NrmO/B/Qu5i+AF4v9+R0CWEgWT+O0s5a9PcDiudg7eY8DTOWXDQSnQdj/qcy+Z17HN
	 KcIDOQcUZk/Sm0VDkw/Q9oY2liQ1R0XByq17m69MuW1L8AnSA5kFSe1U5BNtbbXzdC
	 ug5QDeXtARHwgWl6/ex/1ooMgooBnVYXzcSWk+S0rwErDqvZ0ykNUqMBeHbkqjgYmb
	 msBZAXgIhVEw0Qj2cdWjoZInC8kXBJ6G0U7FLYy60l6BjwemgEKT0Y0FxpPGcTET1K
	 0FmfmlzqLuj4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: Re: [PATCH 6.18.y 2/2] net: mana: Sync page pool RX frags for CPU
Date: Wed,  7 Oct 2026 17:03:22 -0400
Message-ID: <2026-10-07-1-daily-reply-0005-mana-page-pool-rx-sync-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006132523.2742871-2-hamzamahfooz@linux.microsoft.com>
References: <20261006132523.2742871-2-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ hmahfooz: resolve conflict with the earlier backport of 55d20f50a221
>   by passing pktlen to mana_refill_rx_oob() from
>   mana_process_one_rx_pkt() ]

Queued for 6.18, thanks.

Passed pktlen to mana_refill_rx_oob() from mana_process_rx_cqe().

-- 
Thanks,
Sasha

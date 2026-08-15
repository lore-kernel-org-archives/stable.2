Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FD1E7660
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761225; cv=none; b=QYt05EDWFYn9rs0/SVAvfPgZrFp9emttmdbQhlRbP0F7QvwAAQBjz3EannGQ2W0UZm4TqSjcQrYNifVUa3afSydUpppJMSY+VlvE4tGt6EdPpT6mx84GYAiheynbRZnJ7cdiWBioystgqQ9cDXZaY+4fvivgmpfwntkUZIKB0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761225; c=relaxed/simple;
	bh=0ZJ/bJcbBgz+5xTAQ4fcj5wDsp2dXpIo1akKwHtljNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkIKrfoBAK6MggQ1pq+fBcOA/u9240Cqht6PrFMSkfBSgI2s0SFRC1Wt4ZiwQKH2C9vFdleT3Vz8Ei9je3lnXuh/WphE34uEJK9wgrZXBYD7CfFFrjtIRE1NEuDid594NZRMUHQlSab8tG85oc6VKAykyiRDDAAzJQ9lAuIvXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uf/iMOpN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uf/iMOpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5CA1F00A3F;
	Sat, 15 Aug 2026 02:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761223;
	bh=58wWBOlU/x8BUZR8H7okQ6aXgeOnVkk/sJYaXd+7kDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uf/iMOpNNs0ZaSPOES8N+mVgvRZHRO1r680C4V8XrDQJzOdZfcYfuNi8EaoEPmpHY
	 OqCkCWXg5BpBMVLiLcZBTnMT5zJXefATDE8GFFNZRUTFrPTlB0t2ev0uW+iBRkjN3w
	 i5uf3GwyggWO6ciMZQukx7ucfeiN0QECdIXKfWchMNqQjUupP2oME7mgAu5/NeUppV
	 yDGPK4YOmKsR9aQS9kknQY7YeDj1/kDkStYcH00V7q48oYYlX5hxgz3Ia7+19npIXK
	 zfN6EKtebW74kL+MpuC6Xl2Vy7IOnXpxvW7sYyAmhnMYhu0ArysOaexFj6bpnps7Hw
	 HVk/e+Lmedpbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: Re: [REQUEST] netfilter backport for 6.18
Date: Fri, 14 Aug 2026 22:33:17 -0400
Message-ID: <20260814193000.17@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <anyrKBU6iTymdAI7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <anyrKBU6iTymdAI7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please include commit 7e7a817f2dfd ("netfilter: nf_tables: avoid
> softlockup warnings in nft_chain_validate") in kernel 6.18, at it
> resolves a softlockup and the prerequisite patch is already in 6.18
> (i.e. commit a60a5abe19d6 ("netfilter: nf_tables: allow iter
> callbacks to sleep")).

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

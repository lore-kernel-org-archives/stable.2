Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C5D3B3BF3;
	Fri, 24 Jul 2026 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892170; cv=none; b=pgqLB+CsCGVWM9NkY/3NMbjY6j6/HwjIYzeQN7R0YsNhB7dhWq3/0reUCzem3webal7AEDoVOjTYa2Zy+PB2KGH4U0OW3FwaYlI9fDfGZCE6QlapLzfY2Seq2iaZnW7by4Kr0mT+Q40nj2TSLMTL/C4N4b5VCXEIjr0l73a7JMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892170; c=relaxed/simple;
	bh=Pjurzdn5JH+7BE0Xbiwda5DMuAy2DZXw1MsLoiY3Xv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSlQ1rEUrlMkk5YriwzrUjo2m4X5VqbZ43Z9xdOUNp4gtu8XoXrHweedVJDhp3Ls8pL5tP0RMBBdRIi9Szb4SemYFN5TBPEzpNxoAvVgi8+N3ODTu8Glh6EBkj5/h8/T8B4JWvPpwM88C8NcZK8lUbXOjNmcbpGoa9x4EHQIC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SplOHt4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SplOHt4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA57B1F01558;
	Fri, 24 Jul 2026 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784892169;
	bh=a6hXrve42aU+M9zjCTfhBkfLMhDJ3e6a0jynuAyz5GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SplOHt4L55vaYRB3Aue2vh7TLFX238e7IaJTpuQjm73rsLYl1IrxcTG6i+SJbXhGZ
	 E7TX5YP3YvQgqP/Q+Ftk7Qyr1qVr9IbSjVQeC/XZWtX/EL1AnN1IG5gkXdFU6g21wa
	 UUL+fGWw46jNQOlcXmXk9+l5vI1H5PD428E2oW3Vfiq7YM27t2Q8H0C/CGYe4wtxSI
	 g2JCmjWTx8DVrouUYl2kBNOKlRYiBgs+o6YvFuXr6s9W9ln5GL6GtwVXSNf9qOGrWj
	 VIlCJLDaL0P6CEzMTORVrvV3B/JKoUkHCCGS9mhdJR8pouZa+2SxAQ7tAeM/EA6fHW
	 ThQYdnpVqbtNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	Brian Witte <brianwitte@mailfence.com>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Konstantin Andreev <andreev@swemel.ru>
Subject: =?UTF-8?q?Re=3A=20=5Bbackport=20request=5D=20=E2=80=9Cnetfilter=3A=20nf=5Ftables=3A=20fix=20reset=20request=20deadlock=E2=80=9D=20to=20LTS=206=2E18=2C=206=2E12?=
Date: Fri, 24 Jul 2026 07:22:34 -0400
Message-ID: <20260724105500.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <07b303cd-03f1-4d0c-ae58-7439503247a5@swemel.ru>
References: <07b303cd-03f1-4d0c-ae58-7439503247a5@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Please consider backporting the following series to LTS 6.18, 6.12
> (listed in the order of appearance in mainline)
>
> 779c60a5190c ("netfilter: nft_counter: serialize reset with spinlock")
> 30c4d7fb59ac ("netfilter: nft_quota: use atomic64_xchg for reset")
> 7f261bb906bf ("netfilter: nf_tables: revert commit_mutex usage in reset path")

Queued for 6.12 and 6.18, thanks.

-- 
Thanks,
Sasha

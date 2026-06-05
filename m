Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865CA404BCE
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688278; cv=none; b=EU8J3vthp1NHADIKJPysN73rv6rMwxckGR2apkbV94yk7gU0iRPfDgIfjZfRylU8Qk+5JaBXhej+iOM+uH0+qKS4hcn2K+nx7RUvB21ZbmKckbKkl+T53e4VXbFFrU128H52BhwGnnO8+ia2NhiZqY5NvfrLMuf7K5jVKHYuIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688278; c=relaxed/simple;
	bh=RsB2D6PxRqvXfiucJQ0rsB7SdrO5hZVKG+osTdli/Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N67WR3nFtYdGZNMysQIcqSmQVccc1MkEBGQ8h1K/kspzRQLyik0ciMhO+4/cCglX4wJ/8+2YWKcdrlzwVi8O3tESQMcg/3+V+q0LNdXUBPS41m+e6Cf09h/MeJYgaAD6DQicT/taXsQaM265RS7oeYZoDZzoCoNmHMKJgmHGKo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bjpc0fWV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bjpc0fWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A701F0089A;
	Fri,  5 Jun 2026 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688277;
	bh=D8l4osT6iPo6pG/N/mOQl3hQoFF2eVN/rdNPxcBJSds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bjpc0fWVoytwJuqApJ81sIMXDSqsryhheRZzVYKg5Y9/awB/xRLo4jSathziRSQlH
	 SFNao9vRpPFMlRrKUzgrB17gvFIVEkJRGIyfFPdy7m0am8DX0AANGtFnvFDAJhE9rt
	 bPajTAppu8/pVsm1v95/7PD7DuWZ5Df7ndn7DkQPsKDMPFP5AokA6ve1hGi+w9A91i
	 N62WCOTXVU8n0VBjKvYlhM3lGyUMjbVHBD/onDrBw70hKDz0DlduFHj5gc8eov47xJ
	 1LvU/88epaok5PzUqOSX+EMSsEj37OJAayASQEf5bGC3byk9Rg1nbScr4P7hSiHKRT
	 SORsrWyAzTF5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jordan Walters <jaggyaur@gmail.com>
Subject: Re: [PATCH 6.1.y] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()
Date: Fri,  5 Jun 2026 15:37:30 -0400
Message-ID: <20260605-stable-reply-0023@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604015614.123281-1-jaggyaur@gmail.com>
References: <20260604015614.123281-1-jaggyaur@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.1.y] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()

Same as on the 6.6.y posting -- I can't take this as-is, a v2 is needed.

-- 
Thanks,
Sasha

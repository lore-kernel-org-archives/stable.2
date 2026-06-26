Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8723AFAF8
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496511; cv=none; b=O8FDIBkcI/gM1VZREkvrPSaIpgXGxG6zIB4u9JHIBGK9KWOzgeTfdXcDT4Haapp3x7NRNu16ApSO5d6WxdOcwYqkbVPT3DfQo2C/Jo+4nz71Vot1CYFv2yjy/bGRf0aojl3MexiAVYpmlBXk6lKyOjrinZfP4wcssFX2u4EH9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496511; c=relaxed/simple;
	bh=08qjnFRPbwH1m29GkPCxmTEB23dLTY4X+Rkdgc0uylk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJW9O0qmU6sGdaDMzH2jKPqtIMqE5vchC/J8nm95gs2d8iZUSBmUpQ4+ui9oyXWhlD6N0tUL8L4j9FcPY+Dr60b2XIfj0j4GdZ5r46GibD9KhAcyNwe1FAUtZCMZWo11xsWmUui1gK1Rgrn7kC3cg87TKh29xq/QBygaVByKxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY5U6LXP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY5U6LXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A371F000E9;
	Fri, 26 Jun 2026 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496508;
	bh=hmfo4tcLyrbO4umhNRIfaO8yj1v/8tKp32MrVOg+ykE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RY5U6LXPnyVs1vDDTjSSKhQBM4+mH6MIfzaZbnuaL3ybT2/qWEHQygjkdDbg68/Z4
	 QEAYWIEXSEL8TOMWCPPyOhkLok1eMvt2kX6w8f6FYsbegZXCcLAB/nG+q+nLcTBbAO
	 kx/mOTILAzYgASbVZu8YEUZ74HLrvJ7cHiQ2baHLwXQDnVh6iD9NiC07n5pSz8oISW
	 AaAbx0reJngaOvcBJ+fZ313xBr+gwRB2c9xN55BU0x2o6OD65dzTHg1No/AhnYixMA
	 RzK13KsDagAvU+4wg0z65e3TotpHc9qoo5Z8aI+K16bxiTEIDPnMop3O2nV82dIJJc
	 Rb36VmtrYeRww==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jack Wang <jinpu.wang@ionos.com>
Subject: Re: [stable-6.12 1/3] KVM: SEV: Ignore MMIO requests of length '0'
Date: Fri, 26 Jun 2026 13:54:34 -0400
Message-ID: <stable-reply-item010-sev-612-p1-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626124539.201250-2-jinpu.wang@ionos.com>
References: <20260626124539.201250-2-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [stable-6.12 1/3] KVM: SEV: Ignore MMIO requests of length '0'

Two concerns on the 6.12 adaptation: upstream guards a merged MMIO_READ/WRITE
case, but 6.12 has separate cases and the !len guard was added only to
MMIO_WRITE (READ left unguarded); and there's a stray extra break; (two in
a row) in the READ case.

-- 
Thanks,
Sasha

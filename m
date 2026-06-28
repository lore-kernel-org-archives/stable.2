Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B21F872D
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782617626; cv=none; b=HbT/1KMOOrIARmxkXVQA+9AXGRlGl5Tovp32uugQqqywWmS1MU8kpk24o/337/UqkmY6BpHQB8o1rUnDSO+MdwxCe/TPhbwUJ0JZ03tp8ztkYfG4KbDqjsPLg7w2FzLmsCOZ4RN0YQOyabHeenJHJ8zfkCBE2AGqqCA1drz9Apc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782617626; c=relaxed/simple;
	bh=PyLEN6oOOCis3XcykYO9fXOE5+8Pj+5s+pwz/LIS8Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejfsMx7sQJH8EHQHLKtRithWWiSik/29hRxC/PmaE9MgrSsokUNKIxatNwHCzUFrRqkXaplDY7u/cbdWtTgrgr1o6Q2lcTbjv4Kq+OW+PyPrwKVbLL13iZKQNK8Fn5DI2iqMESnHWXyr24Gg5raNDmQJtCsfjIG8if6jOh33pCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCW6nYEC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCW6nYEC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC2C1F00A3A;
	Sun, 28 Jun 2026 03:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782617625;
	bh=PyLEN6oOOCis3XcykYO9fXOE5+8Pj+5s+pwz/LIS8Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lCW6nYECnZXkOhpNaLR4bZ7Q7adME0p4z8h5CH5LC62Q3/CeLopqGJBTZoJ/lC8Gn
	 WpUCRmCIgK6nnuG12qigOgyEkDVp25vtT0jBjJg6F7TA7QtdFCm009mS7VOsGZPoii
	 oIMDXtD7naAuDof8SOv0c4U78Q0HaFW7oQt7/IwG6oZqc4gf/S8PV9BSjS58qWpMgm
	 v/OeXQFAkTxLj3hGgEnl4ZZh1DT2qEmfx00BDLWOutRRzCa4NirkB80ff9Tndz9gZL
	 TxDqubqQAwDn1GVyY2lJ22EizNiM/5s4lCd2DPRBLQG0OwH0uE8WdotM49t2sDZsf2
	 WTME9P/r4WQEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.18 00/26] batman-adv: 7.2 merge window fixes backports
Date: Sat, 27 Jun 2026 23:33:33 -0400
Message-ID: <20260628032401.0003-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626161210.124712-1-sven@narfation.org>
References: <20260626161210.124712-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 26, 2026 at 06:11:44PM +0200, Sven Eckelmann wrote:
> [PATCH 6.18 00/26] batman-adv: 7.2 merge window fixes backports

All 26 patches are queued for 6.18, thanks.

--
Thanks,
Sasha

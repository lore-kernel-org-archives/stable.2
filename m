Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD03DEFFC
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322594; cv=none; b=EHAsfPopUaGlL6iKrYgaFXyxpmjEVsx+yeUdPBIhBESlTH2uPWGojo5i4V6cpZ4Kr3ZKm4BjR8HuN+0T665PVIr/WPYqMoSC1e5N8wWKIJTbMSjNdHWt/75O49A02KjMaQKPL702o5dmmkbjTPPFHA0HmoFL3rXTlQzjKsmo7LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322594; c=relaxed/simple;
	bh=mam/n6/o9XuPYGtY3GgdgirEcHyvdqKR+e+Bi15LRK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVxJUcp6G60riCwuDYSMGhf1pNHWwj90LcCteaLR7A5qpfEk4yofD/Si3ZvvGfpP3OB162KEFCzrg3wGQlbyuvN7cN4ugzqM6CGYexjx+N36V5ZWh0stba/Z7HhfGX0TAj43v6NHuPBCgQCW3jVnecSr6hwvO+smxrC9uXKkKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3Z/EvMy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3Z/EvMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A961F0089D;
	Tue,  6 Oct 2026 21:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322593;
	bh=DI0wG/l7YHsqEPe+7A0CjCLS4HZxQrS79Rt4AdQv34I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z3Z/EvMyLqV2F171ckojhC3tZB6MrwoBSczrzMwgtFWb6my1OwHl+b6wLIQQ6yWTI
	 A/uipUq4OxazFwDz5TG7OETILV4PB7VH34vbLtvenBteb/RyedutvXXD6HDIkMAX4B
	 WVQpeVORTxoDoAqdxzsxhYi06Qu4mzxPjDq+s4PtbBCFjEciVcjjwOZQsNZ70HTl7F
	 MgICSCZKxkLqQ2iqV6cmhlKJqIuk43K6L12LMG8XtiKzqUxZK0JumgnZ0CI+9Xysl+
	 aBGB9PimaGH+riMUjTjhv9u8kM/nuSRooNHzAWfieWfvDkNJAKmrCqjt4ZO/9mVWrS
	 dmzI1DwcZ+hxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH 6.6.y 2/2] mptcp: prevent race between disconnect() and rtx
Date: Tue,  6 Oct 2026 17:35:46 -0400
Message-ID: <2026-10-06-1-daily-reply-0014-mptcp-disconnect-rtx-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <83ad680c-9f5e-4328-b87f-ad0f14de9ed6@kernel.org>
References: <83ad680c-9f5e-4328-b87f-ad0f14de9ed6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Because commit ea4eb2adb0d3 ("mptcp: honour configured min/max RTO in
> retransmit paths") is not in this version, this line should be adapted to:
>
>   msk->timer_ival = TCP_RTO_MIN;

Queued the series for 6.6 with msk->timer_ival = TCP_RTO_MIN, thanks.

-- 
Thanks,
Sasha

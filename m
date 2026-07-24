Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2904322E8
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892174; cv=none; b=Uvm00RSclGtt5GkeqAinlyoRfTM7DXGcWJb+EUlM9/od8Qy598/SBrkunhZ/RSi5JIFojtwlzOfqSfYwFGGNjG5VeVkNxbHch+hWkaZcCMN4qhC244PMoUf3A9pWRMLhDt98VgZ3zd+vNL6X4TxAFiPjEXLaTeemiB2Ri1TMuSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892174; c=relaxed/simple;
	bh=JlERNsDclZPMsabhEw0QyGwFL3hg+G4sXW3XLbhn/uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdE76qzez5IB5YoNUVNq8Evq/3Fvd04cosdA2RkSxguMrOCO+8z/gvmMEoOsKN05ZnhafgSM7BvW69fxoAJdW7EIhvA9KIn10XrN5+Ag4qX1PzpWCgT8QjRIdtZ/+Jv7Z4aeJouy6Cf4TEEGMkacpXjER0ARwx/FhY4BzwGIOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC7EA2la; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC7EA2la"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075FA1F00ACA;
	Fri, 24 Jul 2026 11:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784892173;
	bh=qpcSrxKxD8ZnISLtklUK7lr8dfOhzin0Nc6m+yzkQ6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NC7EA2laW31Y0AlTGu/6S/4BizvX9XT8eTWGZB5tddRqasrs9y5P9goBjVKXmvZ8M
	 uynkt9FOYmroyBuwne62X5lUuG82mGXXZhtBLB70KUnocwKDZHjB4etGj6P3uWDWY7
	 0UrPFsTPjQH4a/BtQ5TEfIHyWmuVTy+iIh0CoQMuJPhxxFTrbHoa1DjOncMo5WqopW
	 b+cCMpgoQZYUAj1FITpAGQUa27q4ii+HF3rMmstnPb0r45oHNeS4gOJxSoKueOwb7k
	 Rl1e2akBD7UOS+K7tkxt/0Q6l0aBCrmu2j4q1NQD93bDt9tRqWcHFr1MAiK3fytlu2
	 qDLNi1k2OBWgA==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Janne Huttunen (Nokia)" <janne.huttunen@nokia.com>
Subject: Re: Please backport 101f3498b4bd to 6.18.y
Date: Fri, 24 Jul 2026 07:22:37 -0400
Message-ID: <20260724105500.stable-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <PAWPR07MB100715EA5D8FCEB34B9987DF69AC02@PAWPR07MB10071.eurprd07.prod.outlook.com>
References: <PAWPR07MB100715EA5D8FCEB34B9987DF69AC02@PAWPR07MB10071.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider backporting this patch to 6.18.y:
>
> 101f3498b4bd sched/fair: Revert 6d71a9c61604 ("sched/fair: Fix EEVDF entity placement bug causing scheduling lag")

It doesn't backport cleanly. Could you please send a tested backport?

-- 
Thanks,
Sasha

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63310F1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595398; cv=none; b=Z4ZqIdAa7fZV0HpaTo2TEvrYnvcud9FMuVKF4hijmH2tLRYS+/ZyxiQdyhMPwLEgf0EasqxABpBaZ/XwsGHD0Oa9G0zd2bG8WDoDP6hMpCLRqYzjWHK7vJbeE4mFqm1+hn2ULTEfutM3kZzaZ+6yJupEkroI/vWyQpr0dTBqqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595398; c=relaxed/simple;
	bh=bQHNpaMbLEXOeM08jWxUvwxhlNeMbnD1zwIMPr1Z9fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KERCZZB9caWCZ65g5KSODeom7CMI4sofqP5wKBK1ht18QkcZcMWETurNQtWJzK6H++JorEngNOHKkvqRvEUwdiBt78Yl2gBT3Bgmqn6TIQ+bcVS1FZKKVu0B6mgqyfYNStTVVrLhMzH8sNsOZjFX813fSPPDb3Fz1dyKOlixP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4O9fMxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4O9fMxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1476D1F000E9;
	Tue, 21 Jul 2026 00:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595396;
	bh=rdgy+ILSSmZhf0Om6lTMiRhXRsEEifnbniE33GrWp+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V4O9fMxgHl4nVaQLKnERzA1uwbzzJPsSTb6yukWm4JbTHqEBaGzRxR7aC6dPQ9MIq
	 V4FRShMX1P1P2zZ+iXnMCG+HrJ4ViR4JcRDD4ZPf7QQu+qqJS3PzKBSXcBw7XztnfB
	 ZrvTf73NMm35qtJHI5PaHmat0Ku7Xhbsw1chm9yqkEMav1RV1yyWnYyRDf5YCiQICY
	 kRBYr0ORFR+wbqbzm3IKA7mg0Pt//lCnRMmngx3062bpkq2BULxAPl5qO2QggRcCFQ
	 1byI32o69XxD5ydl+XyQThJiaF53bJ/Bw/vTCYi33ABfHgQEpTB9Zkini633bAI2Iy
	 Y11P5WjXUYHcg==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: =?UTF-8?q?Re=3A=20=5BREGRESSION=5D=20stable-rc/linux-7=2E1=2Ey=3A=20=28build=29=20=E2=80=98vdso=5Fstart=E2=80=99=20undeclared=20=28first=20use=20in=20this=20function=29=3B=20did=20you=20mean=2E=2E=2E?=
Date: Mon, 20 Jul 2026 20:56:08 -0400
Message-ID: <20260720175500.0001-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178455954409.13463.336399957099402658@kernelci.org>
References: <178455954409.13463.336399957099402658@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> New build issue found on stable-rc/linux-7.1.y:
>
> /tmp/kci/linux/arch/riscv/kernel/alternative.c:207:41: error: ‘vdso_start’ undeclared (first use in this function); did you mean ‘vfs_stat’?
> /tmp/kci/linux/arch/riscv/kernel/alternative.c:210:41: error: ‘vdso_cfi_start’ undeclared (first use in this function)

I've queued 499578e22ae0 for 7.1; it's a small header-only change from
the same series and cherry-picks cleanly.

Thanks to the KernelCI bot for the report.

-- 
Thanks,
Sasha

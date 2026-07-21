Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E423EFD05
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595413; cv=none; b=lFUNngBmEtlm1nxpGct2WRgAMIAl54zU7I95GjwRyVrG63oF0MSihouKuAcnVUFHsIiur/ON4mBQlR0m2f/PHxwmNW540V9tanFE0B54UP58/q2zGQPMilbeQD9MmBq8KO8y2iddbRiRGS2KVuoKnpFR7WL0pNOEAfguFmiqtuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595413; c=relaxed/simple;
	bh=Ivgxm/4jhJflqy9+QTAQ3Ep6g4MlXarXRjekPF6v/V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOxpyzE4xcx3cKYhU23O2po/Ua3Qq/PanrO7e7pB8draQv85FqZuLmL1EJsKObbVEqoJtlKC3gjtz71TOJvxGxcpyD/UtlgLoo+6Fb4Wu+Rsz+X8ONvU7J0r8gGgPjh+zh1/yAoyHlTrBBTH6hUdDGBAFN74qCbUG3FUJSAi6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/TQ50cK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/TQ50cK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFD91F00A3D;
	Tue, 21 Jul 2026 00:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595412;
	bh=JiB8/K5du4IhfHz9alR88GqYg1KaxHIy+ZfCsrvtmu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A/TQ50cKiG03viFeAFvDiyj1wrG/SgjKw2PE1FTp2JB5CaXXGHU+JQkTHofnsPBwp
	 zro2ScKyBrnalEFZONIlD+X9mvoXb7hAVIsIDA01QQ0HxUUXN0+FYdt2Vo5eK0h0qi
	 bjPNZP+b17vzoTfKyVO29q5jDCwTrO753ItCuxP85RLXkQWmq6Xl7HUNZVR3c353To
	 +2gwjN11L0smTzODJ5tH2wwkUc7K43GA9TLRMTxMD2dxyBJ1SQgQ0ve3jtU8DOU7G3
	 JBp0TtRp0MiV+gNtPrHWr5AmssGkZ0shD8RH/5OZ6F68JRiY1YdgS+7jmV3gHfa8Xz
	 /h+Jvhd/55Mew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5.10.y] nvmet-tcp: Fix potential UAF when ddgst mismatch
Date: Mon, 20 Jul 2026 20:56:25 -0400
Message-ID: <20260720175500.0018-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720140748.17471-1-kumar.shivam43666@gmail.com>
References: <20260720140748.17471-1-kumar.shivam43666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When data digest is enabled on an NVMe/TCP connection and a digest
> mismatch occurs on a non-final H2C_DATA PDU during an R2T-based
> data transfer, the digest error handler in nvmet_tcp_try_recv_ddgst()
> calls nvmet_req_uninit() - which performs percpu_ref_put() on the
> submission queue - but does NOT mark the command as completed.

This one doesn't apply to linux-5.10.y: the diff context assumes
4606467a75cf ("nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in
digest error path") and the nvmet_tcp_finish_cmd() removal, neither of
which is in 5.10.y -- the ddgst error path there still calls
nvmet_tcp_finish_cmd(cmd).

Your 5.10.y backport of 4606467a75cf was queued today, so could you
send a v2 of this patch generated on top of it? The end state in your
patch looks correct and can stay as-is.

-- 
Thanks,
Sasha

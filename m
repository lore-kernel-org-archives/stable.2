Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798921;
	b=uo7iQeUkHRSM7DI2nnEhY6rCuXfH8d7uHpXyS6shAP9tcKBhUPcVhrFqENqE4AUMKMpU
	 6IgZ8gX29ntZYyH08BVIrVcb04ooGeHrfvb/52MMARdgWHIJdQ22SN2FBw8XG42/BN6TJ
	 sEBZSRwuwJHlJs6iqs1tVu7Edxic2hG4elM5zUHTPSnni/liM1qRg3Pcp+z/wbn/j9Cs8
	 6g2bo/whzvvm3ewcJo6v4I6OAAxgI3rL1g0+SwInGFyyfNHuN3/nYaXlce3dQawFm5lbn
	 77QrVyOXTZxBIWCScMmmHzWjVWMSofiwP61Mh4zlGQSsUuUCtasQ+hi1LbAk5yrCrrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798921;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MC0ZOrLDH4fTK8u/4XFXAJb6CALxPf5Qbceq2GSaxAM=;
	b=gBrSrwp4eo1ID/0nGRJzEmJ/hL8nCvUcFf4dUPA6zTsRVMua49qz64XeAHGTWzj2nzHc
	 ChqjcWSz0EIEDmfTuhV5Pwom5NbuckFKtnV+AZGs3C/DMjIJG53xsYXwGvQDIJskw+Gk/
	 DUZts5tLurDO2DWyNIDlVMN8py+rBHuFNQuHUhL2TwDbS8AXR1hclDprg4e5SwanLp5P1
	 iKlrMcesut+HOUu2k8vYb7vT2tq6CxpB7kv9L9XNO6VLyjmKnpjWJGLTscNhBzJVaPZH8
	 hE0vrVpHJjzJquty3mXTQi6mCjD4PgMrBTyxcuE3AZ6oa9HwBJdwO3XfQ59W8vO8cLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkstVbq1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9570D606A31C;
	Fri, 27 Nov 2026 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkstVbq1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E8E1F00897;
	Fri, 27 Nov 2026 17:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798921;
	bh=MC0ZOrLDH4fTK8u/4XFXAJb6CALxPf5Qbceq2GSaxAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZkstVbq1dDX42iHvaob/roKuZQoYRKqnnSnBpPEByQBf8G77Fr6HFdiopnEN1Wpdm
	 hVg1IGOArp/DlJQnkOoq6DBlH7cQMmS3lOCcQZHGNpgbpeEwEKysPxujO7ET8p/Wm1
	 /821Ji7wy8lGW+ZprYo9otQhrBLmKvg+O9hv+DKCDzbdzdwgKP0A4w2pau9PZjcdp5
	 yATzxPCqa8A4U6F6RYezv5Ps4zvyZ5EFkTp8d/L9ARfsvaBk8Pu/Xf5WH6/b/zDcJn
	 CCRIelqYNfys/F9wm83CDXZRKM4/qqqb2M7j8erjgHq9uujIfv3KRLk1Wp2AblOxtS
	 3SYR/LKlY0L/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kuba Piecuch <jpiecuch@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Sashiko <sashiko-bot@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.18.y] sched_ext: Read exit_kind before flushing in scx_flush_disable_work()
Date: Fri, 27 Nov 2026 12:01:04 -0500
Message-ID: <2026-11-26-1-daily-reply-0016@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125134541.3432982-1-jpiecuch@google.com>
References: <20261125134541.3432982-1-jpiecuch@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> scx_disable_workfn() sets exit_kind to SCX_EXIT_DONE before it tears the
> scheduler down. scx_flush_disable_work() reads exit_kind after syncing
> disable_irq_work and flushing disable_work, so it can observe DONE from
> a disable_work that was queued after its flush and return while the
> teardown is still running:

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19A3AE6E2
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490414; cv=none; b=o/zwf7WwGWY9TJaXT8iwIYj6T7XOxcAWSDoounRrNtSyJ0MZIJC0IzFdYsZ3jA06yIXKrz3mvQod0bQNn3SFqbD70ypJ0U0BGVtDuXxHQDzdEnp0Ms/GM2Qv+qx/DzACOl3FiSPQXeYPvfhlGOHZZu69bYItfYdcEFRRlCR9oIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490414; c=relaxed/simple;
	bh=1u7kZDTVZc4xsLYREgBcMmq3guMtTqkNdBghq0vpiXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCTtOwQYqhIsRx+t5RsKq60IQU56jUnNSRGVrvVsnesftaWfnYCapdQ6m5vWK5mYg9y0tXmqm4kRPOpw+8cQtWLhVMsSjhyu80UVsY2Weof//+6+Meyqlvp2XjlDEN4Zees0IkqfNXf1mkMf+rl7+AU1JkIWDfIdAH3oQ43465w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixNU5hvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixNU5hvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BD91F00A3E;
	Fri,  4 Sep 2026 02:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490413;
	bh=AhI/GdZzVxI5DuQfQlAGcWsdE+gZSGeStfsOxEIaFRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ixNU5hvIBDKrms6cvirJNzwpfdMvFtA4y3Jkwjwr7nSfbgysXGgsWMi0cG6aSrHbl
	 RoUOneTialz4orXpcOBcOeemaFLEA51PDILTGoAyX7y4ZyITheDCfN4QVbOixG3WV2
	 SZMk6qENxJG2lTw+YtsdwAF+15LowKlKN5Ig6ZcdYGz0wxvUucSjrqgtGs/paMG2HE
	 gfXqxajpD/+N7v0bQ1ZgUhQa3PQh06qPEJLobHxmTOYNCM+I5t4oaNkoBJAz5lSjt9
	 zrv6+Ng/7BTKKVqoxAiDQmRBdaC0LpmJVrIjMCtvOdilSXjbU2YXCLI6EBjznnC7f4
	 dfq1vgs8vsutg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	gargaditya@linux.microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com,
	shradhagupta@linux.microsoft.com,
	tglx@kernel.org,
	wei.liu@kernel.org,
	namjain@linux.microsoft.com
Subject: Re: [PATCH 5.15.y] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
Date: Thu,  3 Sep 2026 22:53:04 -0400
Message-ID: <20260903-daily-reply-0014-re-pci-hv-irq-retrigger-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903161922.87232-1-namjain@linux.microsoft.com>
References: <20260903161922.87232-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Install irq_chip_retrigger_hierarchy() as the irq_retrigger() callback
> for the Hyper-V PCI/MSI irqchip, so that a pending interrupt is resent
> on its new target CPU via the parent x86 vector domain.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha

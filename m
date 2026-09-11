Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22A44F55F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125690; cv=none; b=mRljFo5h4alIfGkzfapKvNtY6jtQbU+t3p1MDcvoEiuYAb24j+hx4TZX5G7kSt7mX+gqsQ5HsDfWnk51HA6uz6dd17cj7mBvf8SafoHngh5gJz12V3cUMp7/OTsPkEQxlKau/l3PmUM8FoALdxwv8rU/JI9/GIQ6Aoyvx3E5GDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125690; c=relaxed/simple;
	bh=u3nm9omIgM1Cqa3cWCfqV0NB6a3NODVpxcyjBIVROvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXn9NSuT79RFy1hNL77Gs/MF+6wm95/0YRxHA0no40i+EdxMaQI8mihjfCYB/7K2Fr7HqB0Tg8W90gIo86tsRDvJjsl3y1jkrY5r8e/UYMGzlVPWZOWuTbVEj6FMCEgPEkxy6NTecn9aU1858VsOvHRPYbA8iSnygxMf+DQdpEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX4ag888; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX4ag888"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEC21F00893;
	Fri, 11 Sep 2026 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125684;
	bh=FZNLP5Jqmo3KhzG74xy3qhNMFTzw+ZVaH1txzNHwFKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GX4ag888JSoEQzKv5mLK5MflyWeSpWlEGCU3KIcpy/0ZzmZgbfgIixo7HzTXOY2Zh
	 zzMtxduYMVqFQrHM6sy4/eygpIeUG7SAIzbQKFYm9KnC2SrvATaMmTP6wU9qbPFiPA
	 nC6TzDVAkNX+P6i9otHnJ+XACyxHiR6pkxZjD+QZbRgzZVMz7uyq7z1nLJlfR+hJO5
	 XLTvjBpxv+ucFsfb6PRf50Wq8OnHHSxNq6HTAXBqesECq+QHE+Fn/yjYo3rz0QPvFD
	 CvexrAnirMf6jS/XDm9yVJddF/QRL+IAdD0sR+vdbyj27m/4U7015rnIc1e0KDNBHD
	 G9sn06GhfZSxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	doebel@amazon.de
Subject: Re: [PATCH 5.10.y] perf sched: Fix register_pid() overflow, strcpy, and BUG_ON
Date: Fri, 11 Sep 2026 07:20:45 -0400
Message-ID: <daily-reply-0026-re-perf-sched-register-pid-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909210503.199459-1-doebel@amazon.de>
References: <20260909210503.199459-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 5949d339f5ec98752d56dcd4e36f619a59d513a5 upstream.
>
> register_pid() has several issues when processing untrusted perf.data:
>
> 1. Integer overflow: (pid + 1) * sizeof(struct task_desc *) can wrap
>    to a small value on 32-bit systems when pid is large.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

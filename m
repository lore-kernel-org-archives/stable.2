Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B515E3C8C52;
	Tue,  6 Oct 2026 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322576; cv=none; b=oRdG9Gbc5qTwExqEoNZMfSy5SvKB4RChIau4Ixgl5+UczdKuPBmJLYRPTn2rfsPdSCFLFaEydOz00QBUkg6wy7jBdAuLLW7UoCRdBOxTvBOXJNJQDmK+GDb0nwvy2NUqZ5oYPXPgk1JlC5RbS4y7hyNvDw3bgfvs8hBxLl3VYd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322576; c=relaxed/simple;
	bh=qg/lFfghrEKb4+9sUga38vja89DTLmlQa0bAxFczg6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nsm7/7Ly7inhvNVSoiu9GpBgCew/vXr5effXm8RiokckUyimBzeuOxpdho48xYiJFZzVqPJjZdIjUBDni/mAhCYasvD9waKHP8OrcOL25l7h/Gd0WCXn72QpcYArT5QuEqVqHg/BRd/TvPcoTvffk0Dt3oY6Uvf+teau/eGaM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyC+Y+J7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyC+Y+J7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B159B1F0089B;
	Tue,  6 Oct 2026 21:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322575;
	bh=VD8XgKRzjcLjdCKIiE9Oujn+hm07QmggJZ/aJgrgA9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PyC+Y+J7CSEWi4tKumSww/zjHGPqWorQLhMPRgrawU7RLpdX1Nt3B8RlGYXvQq7mG
	 DbAcejKKY6zTbItfs9QvHxwZdYOUU4F1XplDW11Gi1Y4KwExTlW6+sPVWDXAuQWGtl
	 Mkh2zYdCc8lB/7JKugPQJXyc9aQ7iP3+1D2Ik1zul7nKZ9UJlDUs0I+ll8P26DUyyC
	 gJseQ99SfCGFNwY4fjT9F7p9tdHRYa6OW+PzLkAaFJEG9HZsGKTOlAx1tz8L3b+weL
	 tcHU4rOMEoD9WmIUn6WCke3rWpf+YEZEeVyrfoT1U0yFMikSrDcrLoD9otFZOl/9yw
	 KCJw38OM2UYNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	John Fastabend <john.r.fastabend@intel.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.15.y] net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
Date: Tue,  6 Oct 2026 17:35:37 -0400
Message-ID: <2026-10-06-1-daily-reply-0005-cls-u32-bind-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005-cve-2023-53733-5-15-v1-1-caeaaf7de3f5@bootlin.com>
References: <20261005-cve-2023-53733-5-15-v1-1-caeaaf7de3f5@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 9cb36faedeafb9720ac236aeae2ea57091d90a09 ]
>
> When u32_replace_hw_knode fails, we need to undo the tcf_bind_filter
> operation done at u32_set_parms.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha

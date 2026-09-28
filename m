Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3BA4F3EAB
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613979; cv=none; b=CNJrfTb0PX9kIl2KzbawHLNA3dfe62wh5FXVtmBMu5EcKKgDbGrMpYECdFeUwISspQ3X9MV1wMsEv+CgOPp4qtNKEFM7cYGhf0bdKWUWM85AZkzc98RPGkewTje/9CbU2soojbpaH5xNxMnCkSfCpWwipGb6HXKX/8ZO+2P0bmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613979; c=relaxed/simple;
	bh=VIRBYGZfRi+eMw+k9XkHAaU2RMfhps6UUzSck5xPo3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVZVZBuZ71OBcYxJ3vkYGEqNOebQ+v0Dck+1TgsYCmOlvjXwvI4FeKODT2S1VYezMHU8JTz6qNIfmIdQTbu2/l1npbE0fJmMi/Kx8hPBDualXG6rrbOyv8fciTVjoTym4csM7WyOBb8Z5oRhGs7vyyzbS1Qhr1oPSJ+ZtqrsT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+/l1n0S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+/l1n0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737BE1F0089A;
	Mon, 28 Sep 2026 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613978;
	bh=vo1+nWtUwuIB0FIUMoq64ArhyLWG00ImyxW9gdcK0HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k+/l1n0S/TAZhZpiTkn+U1/JSqdlDujLgCDAd+I199a51ojZgyfSDVZRmglKTBJTt
	 Eqz4MSWhrEta1xql7n7Ssggk1VFwKdB21thBPdEtavqRtD9aC3O97OAjmjDoQeoNsq
	 EIlH0M13gEQrBOxsdAYWqLH90xQVDoT0Bns4CsHjTCjdR7AEsiL/zeJPFUtrrHo63C
	 dFjNTS9drnq6vryjbSqHYJDd4dyy4Mw0BuXjGKvhgfr24bK52rB224ZxMn+8GhU6Gf
	 rNGWkYU3CrmB/kjn/q+7E0i9mTcPzisganr+CVz1qJf4y5OxzZ2vKf9f6WXMjjxLFv
	 YZkibOfi+FSGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>,
	miguel.gazquez@bootlin.com,
	thomas.petazzoni@bootlin.com,
	"Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Subject: Re: [PATCH 6.18.y v2 0/2] netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase
Date: Mon, 28 Sep 2026 12:46:02 -0400
Message-ID: <2026-09-28-daily-reply-0003-re-nf-tables-splice-list-rcu-v2-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928-cve-2026-52988-6-18-v2-0-6492e680c52a@bootlin.com>
References: <20260928-cve-2026-52988-6-18-v2-0-6492e680c52a@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> An additional patch was backported, which adds list_splice_rcu(), which is
> required.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha

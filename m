Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E894F4039
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613986; cv=none; b=sBFVEEUZ0d3aPiFgyPLjbyGOSpmmBesLaHEKdn3Td/zp+V+fUbbaMtTnIT5g+PzajPTFcL7dILVTVWUd9iHMT65xQuQs5HEhvhPRkyOPIsdifQykAXueU2DTOdWfFg0lmeXuu56P+2lMEiB2WYk7six1NPSwJIlma7QhfZzvUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613986; c=relaxed/simple;
	bh=cP5GPbEISMjQ/6+KxvHcZeNsbInjH9YJnVdPD/qv5A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DB9/05paVgE/NRSq/U/0BEFoxTUXt2RouQEOXa2c5JBoE75zy5eePfSolaSlR+geikMwhKWV9x4eXfvUEm+q+xh9bRcfse8+DH9nLe01W/2happrXe6csPAXNgnTw+r/am6F8PetLELg9NMh43pV8dIlgz3VgshBUQXp+0X9Zv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxa317g8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxa317g8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78BF1F00898;
	Mon, 28 Sep 2026 16:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613983;
	bh=JC4HQQLFrePboV0UnDiBgMU3ssGWACU0nfMR2PwYw9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lxa317g8mjPD+/h88nn7FjRQbsjVqp8WkdfIs+yj41Hddk81SC/Zd07cXCkwjAtI/
	 8MWgHSn08XlwKXd/IrF57r5YGBgjVJLhzTWy8bHnAvTwLx3i0/eZuZinmkuSTfcP4J
	 ixuWn/OyqoY3x/TZd5ZsvIsvbdk/TX0IKR8tkboAJJch1kLv7OhhEniXr61Dnxx9tX
	 2d6JcFwj+xlfLqQcr0BLgJOhQKKTAEA9q3uV3cKTq1aKBzJuGFfIaq/cVrSR53MfS3
	 ++lEV6ebKNaniggnhSEQ4XwsWR+NZ4pqIatmnYbiDwkBZP11qMonfZXq1f4eMVY99M
	 XVbAE/hcnZFMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>,
	miguel.gazquez@bootlin.com,
	thomas.petazzoni@bootlin.com,
	"Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Subject: Re: [PATCH 5.10.y v2 0/2] netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase
Date: Mon, 28 Sep 2026 12:46:07 -0400
Message-ID: <2026-09-28-daily-reply-0008-re-nf-tables-splice-list-rcu-v2-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928-cve-2026-52988-5-10-v2-0-d44de149a5ac@bootlin.com>
References: <20260928-cve-2026-52988-5-10-v2-0-d44de149a5ac@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> A conflict was resolved: One hunk of upstream commit was not taken since
> not applicable to this kernel version.
>
> An additional patch was backported, which adds list_splice_rcu(), which is
> required.

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha

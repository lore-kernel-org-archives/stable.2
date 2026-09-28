Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED814F3EC7
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613983; cv=none; b=DqesP5nP5GX4r0VarNYB3fmHkDFA2w2jnWWFsk5gGGahwjpVj4XXvBkRUeAU3KDHeEu0zTfYIQU2HTJjyDxwDpTG1AcBvMB6IM5WgeTk+r9yI+yv9fEfAkiIO9E1t5D1ibtK8IivXGd+oHF4NZhlif8FahL8HgX1vM3Zvi/hU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613983; c=relaxed/simple;
	bh=QyzwGhtIQ/AusVj7KgcqDgEAoLRgC8ChEt/1RTMj21Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kezKFK4bNzktHrb7WAfIxQSWme7Rn3pSxHPiP+bVaHnfQpjYF9kimR7pSoc/l74BZfXDLEaf35sWTaKnM+mh/TVAMsgT1Qtd/oYbuQa9W8ZRkl9RjslOrxi/aB2WeHWCrAEJ3acd89BJ7MGqBu6V/LwaLErsK2hvgjMMi1ahWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6o6v0RD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6o6v0RD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF251F0089E;
	Mon, 28 Sep 2026 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613981;
	bh=lvYub0jGuCBE/bRRUP6NjMCRusQLAH671UrUbWgYNgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T6o6v0RDfEsa7jSM0tq8+BArAWh53lJpFdEHS92TmdqaOCZc53WSm5tNF0X0lk+zW
	 5KlA2PBtMXJZs0mXbJS/fNlf6WRlyo5UUAYaZh4rWQOU7BdTtaR1P4CwHH9CpAiTO0
	 rX8CGOT4hDPksl1fqqZVfuS6RIyOOS1PP9Me+ZIllmTMHKi7MFDd8knlDur9w1NjLA
	 BXWT9Kjx+BGj3EC5YujMl50pregXexys65hRsmIqvfk1cFejdjEKQGdrsAH7sAG6Co
	 vL4KgAZLP+CGYHmOdjgAFRm+B5m75lYzrjEqlpnFJIpWV7cZ75hTN+uv/OAZh75NvM
	 ZnBirpXhNMRww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>,
	miguel.gazquez@bootlin.com,
	thomas.petazzoni@bootlin.com,
	"Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Subject: Re: [PATCH 6.1.y v2 0/2] netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase
Date: Mon, 28 Sep 2026 12:46:05 -0400
Message-ID: <2026-09-28-daily-reply-0006-re-nf-tables-splice-list-rcu-v2-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928-cve-2026-52988-6-1-v2-0-727cab14b35c@bootlin.com>
References: <20260928-cve-2026-52988-6-1-v2-0-727cab14b35c@bootlin.com>
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

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha

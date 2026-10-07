Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F93A8736
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407028; cv=none; b=HGuaMl9spcH++CZmbzJaAlpl/yPMujLb+YjQSZAv0nvLvzs/aAKOzC/urgI2545WH4EqJCGNL4u0iEI9N0ZiAEXkDENPQDI9XcKuThOKP8hTENh+WtYDyeBTp6cy28kX1OENNx2K+ObNULhD5/6ykGXAOg29eg8F0BfS/2do7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407028; c=relaxed/simple;
	bh=koqsQmabQP2woUiTLQFnr0Nl5QvzagB34hPhks2gEF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvAJmDtHzlos1BtoZ8eqK6p7e+h8+d8tfziFWFZJ2Nq8BCaoCLfwX/xwWUhMF8RRflxS2B+yYuPevEips3cN3qy/IW1ozVFC+/Lc7FQ21aniFSpQoUvx0LXzFui8a2LuSItLIiE0WBbvKwJIpWlHkKk//cNoJoiXKeYoXCCCGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eU9Yiw9g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eU9Yiw9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CF41F000FF;
	Wed,  7 Oct 2026 21:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407027;
	bh=GR6T5OzhpwP5C4pSqXuvZJrW9yjuc2/BoGkf6CwiUTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eU9Yiw9gN8IaTCYaqVFX5+OgF7NlT10dgnMilGbPAWstPfkkGPeOct1Nom47UUrd0
	 zvg4lJlCjahKbUARX74EvPHdy2zQHUTTXKFZ+6Kux7Tx7vHqbzxNzg4++u5fzBxJR7
	 MudwQFo+faTkXFgN+TSi/6zc/b80u+MSKOlcf78g5qyAsptjkqA9CSs9m35yhrwvEi
	 FJrpgdilW70jLuR8DYhRs3MyhFl3zsCYMqNecA7uKIvr3y+9QntLPYX90lE4SOy6Yh
	 F1tj9GziJc46KWwiklWK6KygoPNYVP3Nok36ezJG4Ut8mzzuqg690sKKHTcHapM424
	 P3mKy3E7RLdXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH v2 5.15] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Wed,  7 Oct 2026 17:03:19 -0400
Message-ID: <2026-10-07-1-daily-reply-0002-smb-setuid-clear-v2-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006161421.1948193-2-doebel@amazon.de>
References: <20261006161421.1948193-2-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When a file has the setuid or setgid bit set and is written to, the VFS
> strips those bits and issues a setattr with ATTR_KILL_SUID/ATTR_KILL_SGID

Queued for 5.15, thanks.

-- 
Thanks,
Sasha

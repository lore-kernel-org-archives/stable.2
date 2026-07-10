Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59913DDAE
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717404; cv=none; b=ltuwRFlHtYA1UYqZZFf6jAp7uklDiTEq9aYegFD7kA6vmod9VrjDLtCei5U7ZnND5UER81SGON356YWOoLLEtp56LZ76V3vXgm6yqertD+yR0xanvIcHlFU7nu4tGlceI6BqTud6rNiXX/0ciU7yxC+zrJ634lFG/PVlDFovzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717404; c=relaxed/simple;
	bh=lIJnxvlIwgA6sqRomiMmwK8h8P780UosP8RqSpcBBWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDQH9iOouLZiEHDMzIDNZBRGvZ9HD9I9ztahVqOYLjaJ34LGF/yglXdyqQGI/X0H/loYGzR8BQA520udyfsCDwMpIHZTjUNzvryuNB9JhZK6C2O8ZcmYsvYmsDHAm6/T6G4NcQWqziMUkn1fw9naLv+b/KZaafskgifUHeWdaMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7DTBjDq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7DTBjDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5080B1F000E9;
	Fri, 10 Jul 2026 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717402;
	bh=axEB03ikE3WNOka1h6u7EXJ7M1J/GFCH9nwucBuKQwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E7DTBjDqyTDPoSydQO666jxqcCZgb6W9T63RlG+QUEdq6RST3yTBG6RnzaRa0KWdP
	 ElrzYWLXdthcxhKyN00x8DiWtcavLG17vrUd3fW26c0dNnSzBQ2doegBhq6Q2kzHKj
	 HxDuYVO0aomipl/uV8Z6l/FX4d1dtTH7WIbRv4d93axBUsd6usfb3CHfPj/FAcSPtr
	 tqEw1dwV+7FZn9+JSeXAp/INZrHnsMwRCRctvRMg5ifaGkKWTAV2pb7aStogHic2sU
	 ZCX5p7csCFrfO33dGs2054r3p9Z+GbSFY0/Tt3//oeF1mGMXV8DQCnP4bn77s9lbTJ
	 xP9qaG+u3JXjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Taeyang Lee <0wn@theori.io>
Subject: Re: [stable] Please apply 037a3c43edfb: perf/core: Detach event groups during remove_on_exec
Date: Fri, 10 Jul 2026 17:02:57 -0400
Message-ID: <20260710163023.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAH-2Xv+SPOO=O1kiBzra1_+KD9snB6eEUCHkhROMN+Txco5S4g@mail.gmail.com>
References: <CAH-2Xv+SPOO=O1kiBzra1_+KD9snB6eEUCHkhROMN+Txco5S4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 09, 2026 at 11:40:03PM +0900, Taeyang Lee wrote:
> Please apply the following upstream commit to the supported stable trees:
>
> 037a3c43edfb597665dd34457cd22b14692f2ba3
> ("perf/core: Detach event groups during remove_on_exec")
>
> I checked that the upstream commit cherry-picks cleanly onto the following
> stable branches:
>
> linux-7.1.y
> linux-6.18.y
>
> For older supported branches, I sent adjusted backports separately.

Queued for 7.1, 6.18, 6.12, 6.6, 6.1, and 5.15, thanks.

-- 
Thanks,
Sasha

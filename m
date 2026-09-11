Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C9449EA6
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125679; cv=none; b=HTwE+6PVnfifKNOrL9JjC5tHIqAUj8mSSUh9pjB5sPHDUbd1UDr8X0b0UE1W9e9x36y8misYK1jrIjva6R0IXtoItvZdjzi5wcHVl03yzIOzDoQhxAL4iEIxR5L4rAC9aQT5salj2DLxSewAuz0BLVOSIZkgJp7VbEp9R0/CyXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125679; c=relaxed/simple;
	bh=WCfrrg2pJ+0QzndVoyRCSk1c6n7fySarrAfiub9NmRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAFhvKWb167xtnO/19DcjF8WzSUtCgFYI7DcoSgBTdSdxHWk4mjOiqP9q4mbe+hGY/A33eaalJWIBXAUvtx5a8/eE/UmfcaLL8GYrXaw6UesounWFgd3byggu7autuXoVSS19ov70XZx6EjmmwRHnSsobzBFt3pJGiaCk6OCj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbdDA/6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbdDA/6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F407D1F0089E;
	Fri, 11 Sep 2026 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125674;
	bh=lp3BdfxaJCjHQqtZdkhRXsB3y/nQFixhY/743vU/MbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VbdDA/6jdMWPrj7sDYa2DWpLFHxNqyPfePyD6OIxOPfEyth9ZEBcBVGf9UE0cVLF3
	 +HjuSyrdIM1U4qeeMzn3iF9GyekjBW/0YdH9XkTMFHq9DJRXOO9jcSVC9VWku8W1cB
	 WZM9qJKwHKYjIfr5NylAw8xG7u+HL2/8jtg80/1Ji6jumc54D+g/mOCzKflxf2JU/f
	 +TyEfy4+rPYdFaxp1m60mcZXuOdlVREGgYLM0+6UiuQvqSgv06u3TGBoUTt31WQvg+
	 6dwSkJhK5HTBv6rnFaRLA+QIQsB/YREwz/4DMVkUOLp/UQtC44zsG4AUTCpeBX5RN/
	 LdIM+5bbf5kjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 5.15.y] batman-adv: dat: atomically update mac addresses
Date: Fri, 11 Sep 2026 07:20:32 -0400
Message-ID: <daily-reply-0013-re-batman-adv-dat-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909191250.1126868-1-sven@narfation.org>
References: <20260909191250.1126868-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit e6de568d3eda3e3c01c868fabd7a9535d5ee4a73 upstream.
>
> When a MAC address is updated in batadv_dat_entry_add(), it is done
> using a simple copy function.  A parallel reader might only see parts
> of this update.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha

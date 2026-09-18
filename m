Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9184A522EE3
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760760; cv=none; b=UJevakGKzsra/p+5UT/Z6PynjhZhND3SC8KPuMsQD4usZtuo6XLp6bi/ineOKSGWKa6j8ZmjHMWuvOFjwtgGPmZB6ue80TK02lfTpc2d4dIaz+y5jGN+FBoc+8TV6v8VTgWiPXj2eS7kM7EMd6yWhkYu3Gtim5eoXe2MKN1XYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760760; c=relaxed/simple;
	bh=Gg097xY+dI3y3zEr2JJRJUf4Rt9V+5hso3IHcJ51I64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0Io0q/feW6SmuLVLR/CFfdd8Guw/u5z2dTYxAzjBf7OLMMAI7MO/FQToD+j5h+NQOmFjKZM0UDofJ+Yep9Sa7NKzkjYosKLRstpm9jcFjLyr6vWV8hpa8bVTEfxhX+EJBhqYylvyAFa6cjG2f4CCxVb7w6DuxKv9YVW3TsgN5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyryJofT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyryJofT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C4B1F00899;
	Fri, 18 Sep 2026 19:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789760759;
	bh=38tMtFrnP1ZwBqtuwuaaks8w6JRU0yG78mgM5K1sSG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EyryJofTP8PYsNZIWNeBWYN0ExikdE2SJfK5+vvk6wET8cmp00kHhAisHTZpDiss3
	 vBNjK2xouCey1aw3wj7u/IWnBdxOlyDdb3chyrVsJtOQVBv/Us5kE/KBh2jmBbrgCD
	 DhFGcEydVL8o3hgllCQFol2SSduCkt1QBuun6YgOs7KAnRWm4avOjS8W6RH25Pc2bm
	 a8SuIafxgojM719/LLd3s43A6HPxFHp5N9gS8kzDftRgD0m7d7MjQKINdhJYppbUHM
	 X1nVsTN9vpVH16YaVHA5IYePYmhh7utgvy/oaeBHWzBSxVBCKKCQf8uA5bTlbmDlIR
	 dzca5z37306SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.12.y 1/3] hwmon: (asus_rog_ryujin) Rely on subsystem locking
Date: Fri, 18 Sep 2026 15:45:39 -0400
Message-ID: <2026-09-18-daily-reply-0012-re-hwmon-subsystem-locking@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <82dc4e6a-0114-48ed-9fa1-1696cc5fdc08@roeck-us.net>
References: <82dc4e6a-0114-48ed-9fa1-1696cc5fdc08@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> No, it isn't, and if the patch introducing it ends up being backported
> to 6.12.y it will trigger follow-up bugs in a couple of drivers.
> 
> NACK

Makes sense.

> ... and commit 52dfb8be29d9 ("hwmon: (emc1403) Rely on subsystem locking")
> should be reverted from 6.12.y.

That revert is already queued for 6.12 and 6.6.

-- 
Thanks,
Sasha

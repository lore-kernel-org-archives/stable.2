Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597016;
	b=o1DweMDeXKaj8yf5JDIRfcsb9DPHJhFepBZgYPHwRnyHF1LaAz+tYv4Z+pzLNwr2mlr3
	 Fj32563uj46lKKNe/5cgD8XgAAlT8YQyWXWbSq3XdKsRgk1RPP1q7849uA7TXc9O7/34d
	 teh4HvCl1Wvnwie34lVaOlTgX+uvEXUF24CWdyVacXw7SsKXdVgASZSWv3xsCqENj1x20
	 cedSM24FOpNDYnNXrASm13ff64l17FyjPwXQ2meSiwxBJFP+g3MiF4+OJjXRPfeKhIiph
	 9NzmCbF10fmwLbzwe6Lp6P+GziBOTzNQviIeI8pgTsjAANrK6g3YwoV2VlZa+wDJglw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597016;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cLM2HZqELisUA4BveOj4NO5IeL79Rpr8KQsa+m/2nNA=;
	b=dLdjBlExz/BEmwUhsIdYGVxRIbWZFlrJyzuX8Z44nlhXcGY+iN4Sck0RFW+/FqEJ+xee
	 /6lAvMmZXcpkzxhESI/N1EMNaasvdRqnZdfjHCF7iVsuE6RAS1UVGz+Swz81e0tQgsUp0
	 J1SUJHowUZC9yFwun+R5az8xYU9HFT5mP0Qwyff9HF2rD9tcizTu3fFlH72G54aE0GGft
	 n4oHOrAq40E6GvgNAdmooHNOwrTYb6l6Ek5jNxSBLjXNLqOEJQ6mXZg2J1RLzaXKyF6Dd
	 p3ZW3+HXIjSVaXzjJip/8QZwCETcoJCgxXAEuvAVhAW/K/ItzrerKY/wpcF6rAitaxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJD8sFm+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BC60A261D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJD8sFm+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1205F1F0092A;
	Fri, 13 Nov 2026 19:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597016;
	bh=cLM2HZqELisUA4BveOj4NO5IeL79Rpr8KQsa+m/2nNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lJD8sFm+aQoA/k9lJUPOvyxMOCmKnvbrJxnuQdoDwBECLIhG49QqhJ7LSKB7rPPjX
	 q7MLvUAd4ngqMVQeJR7jCcm6/DxjrIQBSFNoLhmjWMixPts75JYX3N+4krqU3UoyWW
	 EveDRjSDjv6HwNNINmvL2Y3PziWEGCIzNQ4qt3hSbwRY+tKnWjXjvvNF0T4U0DEceg
	 PgW0jI+CxSRsuJ/usBGebuePF4v2/LR8lolDjGimC6KLACT5Vc3SZmJQpqX5MAKRrV
	 5vTf1DWpR4EoH2PoKHLaQhO/WUSchd48aGGp1/n5rOCiUHJEB3C0iwEDmyFFFEsjHh
	 CHKonnJLauPUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	john.johansen@canonical.com,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH 6.6.y v4] apparmor: check accept index + 1 is in bounds
Date: Fri, 13 Nov 2026 14:10:00 -0500
Message-ID: <draft-0010-rezhuapparmor66@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112062917.663882-1-zhugl3@xiaopeng.com>
References: <20261111063859.496645-1-zhugl3@xiaopeng.com> <20261112062917.663882-1-zhugl3@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 12, 2026, Guanglei Zhu wrote:
> Please
> let me know whether this partial fix is acceptable as is, or whether
> the runtime side should be closed first (e.g. evaluating 2e12c5f06017
> and its dependencies for these trees).

The partial fix is fine as is. v4 is queued for 6.6, thanks.

-- 
Thanks,
Sasha

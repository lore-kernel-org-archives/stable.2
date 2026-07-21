Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528812343BE
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595408; cv=none; b=IVDz0YHFmNUHglkb/TNCHzjwqpa8O1J1xH3YJT3sFOXALZ4SQrS9vleQ1ODrSEh8p/5VTjsaymqMmResSstlqCJd24xClSvcTOfxpsoBsLhrOh7Edz9n5Mr2IyClrsTtp1hJsRkBu+e13HsQWRVTlx/v5ZXB3lajLXLAvXodhg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595408; c=relaxed/simple;
	bh=ow3NU2JX08yTfYvxBE3IKZO9Y2wOorR/6/jNITpXqcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRmqtDaQbXrqPIxCzRiUHgMB5yoqNFOIyFlr5RGppEOoGp5ue7ZwTCIOIw72kzJ6YxwKKOPd0Yxvg/kPbFToyvkEoQTyG98tV6TBGHvXQbu6722gnyvEvb2fcceV8Z/yfjTR8bwHceStsxjjQ/V49AwMQJrzBPzb54l0eJe8tYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzYsN2E7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzYsN2E7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42211F00A3D;
	Tue, 21 Jul 2026 00:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595407;
	bh=HxIbwcfh6fLaShVhxeWNzagJ9wlV+zwZ1omBGus+T2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BzYsN2E75R+sDH3kwF8cQa2Xl15V4Jx7G/Oc4YcqsZE3zN8FSxLea3VIZJ4f+gVL/
	 0a/jA0cUfhE3qvvKMSgYAGFZIZC3C5w+jjoP7WmgSCtH/aHpgYIBDM22uj/lw2J9Dx
	 4c/J2uy91s171phuLHE+ywaSr5lgFHmqe0JK7g5cJ8afdKqexwTY9dBPfqn5Z894a8
	 JcKqlkQVEkSfnfOo84ZlIZBClzIADRoM+cFSHGYkyTJI3kH5vlq1OApVHLKqTRKuuf
	 xi3/OaK46ihyjyq0QQAiru34RGzM6gThJJTB7AbzwngyloxELWEoa8yXZ0CNSgKf9t
	 UvlR3vfV3wNpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 5.15.y] batman-adv: ensure minimal ethernet header on TX
Date: Mon, 20 Jul 2026 20:56:21 -0400
Message-ID: <20260720175500.0014-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720133430.437468-1-sven@narfation.org>
References: <20260720133430.437468-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The batadv_interface_tx() must therefore always check itself if enough data
> is available for the ethernet header and don't rely on min_header_len.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha

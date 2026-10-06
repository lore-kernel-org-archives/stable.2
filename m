Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02751A6822
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322602; cv=none; b=AYpLzMb3LfvBfdPGHSplAUrwR0AjdQ3K3fxITPmfaMpE10I4hGp+Mbg5qS7Y0WRibvleKECK/1MhdRfkBa03/3mc24sRTXhpjoT7SXSU/vV9DedgaW5fLLMNUjnONf8lulgcMXQBDyxM+0H/wvSj4ESGVJ9SzYHs60FeyGo73xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322602; c=relaxed/simple;
	bh=3I7yJ9T/CHkqZ1TIaVNi36IwynWs6PsJfCZv3+9zsKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/hGDhCROqAur2Hgs5mna8//u1u0PT6pM1mQ1mGcU2CUnl3mF4EP4WmqRP3KY7voIxgxU+56qfY6eqycKBMFdQU+c0ojCpK+rdmv8ZhBtlZbAYpxcgRxfs1qAB1FMv3tcyhKZrHtenO2RimJ8KqjRZspT+Gp3OZv3sl8+6zkaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bETaQVSj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bETaQVSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE241F0089B;
	Tue,  6 Oct 2026 21:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322601;
	bh=yMOJpoio2NiP24Hc1tXOwhQOI68TKExY6JF5u4W5FKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bETaQVSjX0gAkDe4Iv2Kw9+TbcYIL4bINdK153suAcpATgBjn0gMQAL6B20LxiH8J
	 rqWboxbTwO15LgsH7S1Y0KIBOG55xKmaKEcEvXF9ia7sq2lEWzjfDbny9JHpdyN0qk
	 33xpV81o+9q/5JvhsZPxTeoaNq5aWKECJ3Tss0x3bBFQyx4MWht3iyokaTUpggd4K2
	 LSkPNhFgDQrPgxcuQ/zX/aVtp5Jnijke3sx0OIQjUuFUIHu1/qonfjUG+HdDmq5N1v
	 Ec8DUcPf1fUq/Y0lQTn9hQQ2b6pGTaw+WnUovxey59rSMdHcTRy1pUgFVnDBdNd+VZ
	 xLSfuVfztph9Q==
From: Sasha Levin <sashal@kernel.org>
To: Bjoern Doebel <doebel@amazon.de>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [PATCH 6.1] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Tue,  6 Oct 2026 17:35:51 -0400
Message-ID: <2026-10-06-1-daily-reply-0019-smb-kill-suid-tooling-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <asStCruK73iccnIs@amazon.de>
References: <asStCruK73iccnIs@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I'm guessing you found that via some kind of tooling - would you mind
> sharing so that I can make sure of such things ahead of submission next
> time?

No special tooling - I used AI review for this, but there's no harness to
share.

Looking forward to the v2.

-- 
Thanks,
Sasha

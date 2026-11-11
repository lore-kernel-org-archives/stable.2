Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434107;
	b=LokKCD+ahgaLmDm3NM9uU77OKkg6Qz3SQAHpqVrPA7owShhUmniv7Ms+0ZgGUXxCBr9c
	 8f9gCCxaeBmbtd0whpHGHFSwJTrp8U2ajUv+hB4USV6O5w/EdT2zyAqMfOOrC0tbL5DV/
	 pkq44MrhoBRmWIx0FXv3gpe62JjsmYr4Hq7lTIYPDcWg3JwuB6euUXQaOZx/amnUvEikB
	 SJa0MZOd7zQ+vgdJa6zCtbjrYa1WTiCGcJJCVkI2hYZl2oYIZ1du3a4n1IauS2v1lPqWB
	 8iqgb1RcFjSDaPsGBKzlEb0UMRPtbk3Q7c3emyBUBRr1hXTK1oV2ajo0SvEWdpW6YIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434107;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wOD/fY2R++BFSebGz1UZywGp6Kmsxs4a6Bhn9RPcR4g=;
	b=hMyMlMHLAAfDYeVJDwi83q4HaZNi1X32HAx+Wan2r2lYOhoU4ew8dN6+u2B2DoKkghks
	 kvvBmngO/m0PlQkCL0Buz8MEkounNvJ8xPncRcitRjbL8kN1lBr4MbZKTtZIedEjxmTKd
	 jg7HKIUU9VV9I52TOUNGpRxa5n1tIRhPtvdybwK/1ZUBknG+J421kFVLykcrA7y2GQdht
	 OaN2fBy7Db6p1YdVHeLGXqGydMOrc4/WmfKx8TBSg7Xk+c2iCQjKw4iI18swHxEjNLLFa
	 1025GSVKbKls47dz3KzIPaXUxld/2WtmMr7zR2X5/+mmSolkli2fHiOgi6BG3wN+Fow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RkX2+KmK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338ED606A8B0
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RkX2+KmK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB251F00A08;
	Wed, 11 Nov 2026 21:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434107;
	bh=wOD/fY2R++BFSebGz1UZywGp6Kmsxs4a6Bhn9RPcR4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RkX2+KmK95EiGSn7Ai/Xyszc2W1ApMMf8UrH3wabOVqfPRy6RL3kI3iavjtNftgkn
	 wwN+fGkKcJ1FY1Pjiycq+8pdjY4pHCWU6sllI06VCnwxyPk4aUX77HFzZo7A0igZdV
	 rgNnwjEysxK0I18QlxeOMnFHw94Wx6NSpJLdvdEhX42r9zosmwCy/bTYfz86ejmFHS
	 B2qmAs0nZNmcla/spaUJJPO5018KKe5nsqi5RuURRoYamNp7GqcfaNO2ok37Vq5QUk
	 TPpYI3chkYn3Q3n9GyZcpIp15WI6JV4eAuneqmsK82VnpkqRBbguJzCV8/hX5tgvJF
	 H7cQSwfsYv0FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.12.y] batman-adv: tt: only update flags for TT events
Date: Wed, 11 Nov 2026 16:54:40 -0500
Message-ID: <2026-11-11-1-daily-reply-0007-3a3787bb9ef4238baa81@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110190503.115883-1-sven@narfation.org>
References: <20261110190503.115883-1-sven@narfation.org>
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

> [PATCH 6.12.y] batman-adv: tt: only update flags for TT events
Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha

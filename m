Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702079;
	b=in8Oz2nl4fopqR4HUTZrpMP9/1crjuYm9EJj5n0EzLwu05aWkdGZdr31MRYZS1Ov8aA+
	 WSAPr310VLhK9eJLjVr44GSYanEy39a3c/HOZDL/cQn7VOHTOvE0Gv/MAkT/NgucPOFAP
	 1aT3t0TQ0wStJL7ogoSnmDT3oObRbLDde7GfKBkjhTWAJpVITFwX8RfMMtSUMzWXo/akJ
	 509BXNPIFqXIFncQbFfzyORR6TwG3H2V26wFEzY/g3NL2m9ht7HWy1WV2xxG6p0IH4LkO
	 QFsuDotLhusYE8UXFcJVGZ+/x2uXmHogyBnFu9JinQyWqYtLUnRrlxNVMJdxPkLnmxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702079;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=jLIcQvXBzyUakPAQDCuqFKVnD0CCPYEJttYB28pFdyRoW1wqmyaoTMDU2J0bLELcD/yh
	 PBfzmlnds9up2e5xNrSG6fRtuFTnDSKschlAKhydXtif/QvPvbXYxF6LVbO9nFVqHxsKD
	 2oTbFq/MHo/nIaZv0r/KtR8bo6eMYT4MHzwh9rKqBPKe3hdvYnaMbjGSkzcxIc5BcWi6e
	 TUZ32vlvK23EU8ior0L1BZrIM24SfbFPqOM/mQZszqo8/2GN8N10InrKAFdJEK7G2o/Jn
	 Clcslxt/yrfzAf86vjJoHmOnqvylTU1YevfkZPkyuvRVfmW7XhSHpzEBhod+V7OcWDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dupApXeh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B086072CAF;
	Tue,  3 Nov 2026 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dupApXeh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570DB1F00A15;
	Tue,  3 Nov 2026 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702079;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dupApXehiBaqP3jN10iRqYbpNyFl9jy0PbnPU5w/buR0o0sPwfVXBdIgGLvyQLFfA
	 PyiHdnIukzVYc5kvElp5HX4kL8ey9s+XkeWYM7hDUNCfQzC67EO5rVVt+fp4sPrGnm
	 5hT7wNu3WsIdIclQVR/DRhaXJlK3msjWLAnz1Vxr249FTyBQ67WmnSt7LgvtWYiDFh
	 +pp6JZRBcP4WA6noP6mRJFjKWKRkMS6ZgwnlxST9deWS0hirU9YVeRCvIJE6wz5+Rs
	 xjijji8abSp26Xwf2F9grHrhKA2cjJEFiWN4E0gMP0zH0DLS1dTtdznpu8T4Ag2cZM
	 U3Ou3UPzlGC8w==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: stmmac: release MDIO node if bus data allocation fails
Date: Tue, 03 Nov 2026 10:34:37 +0000
Message-ID: <179370207786.488859.17799263929240060160@kernel.org>
In-Reply-To: <20261103102856.1340705-1-vulab@iscas.ac.cn>
References: <20261103102856.1340705-1-vulab@iscas.ac.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

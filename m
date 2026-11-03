Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702066;
	b=bMo9ULVmDqNVPIgM0X7aP+q2TT9BxVJL5bq6bSdCO2xLM+xDydgCYgvyyVckGlB/Khu+
	 498TOnlew/AZOlAQCJ/GBk6GnXLxNjSdXenPtTV8n+0OIADA0ehVTFM3+Ucj2nxkSyu8M
	 uu3XID5cpbwHgGQhMrdm7qbbaYZSMN1LcNOfroZ3UPrRm6JCauI2+by8yzJparGgU08bA
	 kMmimDwecCkJ6i3+/GKY+o85GpqMlGDvT6rING+zMga4JIdXZcDOCtMQa2rhGryLxNlKS
	 /T4pQXM2xEZz8JpzYl9zNnGcZ0vIrs6+pUHO8XIze/BhRsh7ZHt8PIX8z6fNeQfx4vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=mK4dpBUDNJ1IwMjeYDq64f0A7hbg+7yoID6Ncu9HM9+0+BUNYNrpdJmAID9Uul9LGbHL
	 cwgOlgYyRozuRmM63Ha4KON7wgWEt7ekA4FgW0uX96LYn7nR101SQmVJD2evFis1UjvVp
	 jlxx1y7GNM1IhrzF3e8oc7Bo+44M49yxk/M2pvqbO1pbfHumzO2QPyTVzUFQDuwCl7baZ
	 3Ik+5fLXfdRR9j72XhzLCdTpiT3GBa5oSz4yxqoiOfCt6UyWYTsZSmKHwzZU2LyQe/Zvg
	 3dSoOmamqnTgu/q19O0JtSSYdmH0bpMbtLy3HtMmM79ZrYAFy7J38dUYexdpAvd8rZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrQAfm5h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2534607DA34;
	Tue,  3 Nov 2026 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrQAfm5h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1A71F00A16;
	Tue,  3 Nov 2026 10:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702065;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KrQAfm5hEM5h+cn4Ihbg1fdsrQGFD4YadRh/3089AD2LXL93RL+FVEYGBta76gIJY
	 viXBPBgBfuI5gqUehXNwox4iP8EodmCfYaStzCR6Z5nWWzlNmMQXv1ZvYOrLjp1zaW
	 Somj1N01CsLCFacHL3Z0x/gu22n/t7NN00dNiUDjcaTAgOjx+0aePeWX/XYqm7YkWh
	 gSlDei4uzx+LLQZ1TIWSqTVn/GYTjDxGxllR01nXvV3PYLo/Z9hX48YvLI8jTpH1Co
	 rH2FHEeZ3IWNC1xmMfdvSKCgnweh/dYbPlp3JPiFJ+mzcvjAKdj5Nmcpb6oBJXX56p
	 ncDCqS3Havncw==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: hso: free an unused shared interrupt state on
 probe failure
Date: Tue, 03 Nov 2026 10:34:24 +0000
Message-ID: <179370206447.488859.10114944889130468790@kernel.org>
In-Reply-To: <20261103102900.1340894-1-vulab@iscas.ac.cn>
References: <20261103102900.1340894-1-vulab@iscas.ac.cn>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

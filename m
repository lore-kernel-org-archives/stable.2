Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700610;
	b=GCc/rN9cJ8lDlRJIwIB15dJQ3RKYQAuyrJskBo7fM1LubAnNFZ+skSztdBubTt83+VFC
	 t6JZeftqjVgO7P3nG1D8suWfg11fgzpBh6iPDoRXlOr7u27ESf1172+BwIAhindM6LBCO
	 kHJar+BOteHkmT+YUPHV8MOvusRCWs9telSH0gPF58dgwea8af0F7fO3JOPfyHq/YF4S/
	 1lO+1+lySjkBAFtwFuW3EM5ZMU/CQrfyFuZboyvhzf6iG/Jh1K0NbgaA0Ll3IeWtZWTDV
	 jH0+HM4DDWeuAeaje9wCIv+21vRPd7asW/gKFafpodUNSADD759vJtTmgTV4MT4t6WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700610;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=eQrNQ8Sb1/C5FLVdPSOKwo3jTjemOdA4ZE3HeSAfTS3Gzud5UTlVT6gNz1980t2d8Tao
	 pe8uzmM3iLvPmg54JTZa4vXNk1nCnID3hcxhOvrR+INbvn/EezaR8/BAZUAgYr1kzwUrs
	 Yio/4CrD7yq34l0Ry3fMGYvINtqcxNAd3VICJx/mU2lDssa6rBpdYWiS+F0xVRsWf8qMK
	 ekIb7vQtNZbS0hld9nfENVu0e5mskD8KjYrTqxPZv68nyV6ZgaszjIdBiP8nYuDfu5yyP
	 SoW2yJyr+/FAi2Z9Rm/UuFqM+cbuqhkJDJKIKxoExZPmOECmMn/9/WJr/lBgpdB4QIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=loVsu3aA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C13608508F;
	Tue,  3 Nov 2026 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=loVsu3aA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778D31F00A15;
	Tue,  3 Nov 2026 10:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700610;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=loVsu3aAWAhB6SZ67+G9qtqF1FyBWopDk/aTMjbfxFs25Tq5bc/NzXsHCiIRSIlJC
	 2ZXplb/P9od2G/X4idDbJs4yuxA96kPk+XPTgHrgAzhgVFlzyRzhRMmDwtAJ8vYowd
	 JSiC6Kb+54cHzjdOmM3Z3TF03jwnIOhd8zJCHggwmpBVqvtMjfKUHzme7/CE9J5H7O
	 IgcTDNvt9BNNvY2jmbBaj3gpmQoAyl+JvC+r97K0zaZ5MLVeekZ5hvhJk6PioulGdE
	 RNo/lUGsKUCyCu5cuBkT/AOV3F9K/RRg4jL8v36IclqDgqoMbMjev/asw7I1ufgmqV
	 LUCvG8+JRCZUg==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: microchip: drop the parent MDIO bus reference
Date: Tue, 03 Nov 2026 10:10:08 +0000
Message-ID: <179370060898.488859.16550389659027639807@kernel.org>
In-Reply-To: <20261103100531.1309946-1-vulab@iscas.ac.cn>
References: <20261103100531.1309946-1-vulab@iscas.ac.cn>
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

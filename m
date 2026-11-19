Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795061261;
	b=dz6455PONjf2AMctcm5BBJqmntk2ue/53UZj9rFm1VcM85lVj5PJpiGEqXmAAqwVDCCb
	 irNuJ0rlhgskmAlraXw9Zfa2MN8kDzVRM5jHa1sovqDdSLjpL2T+qPBJSIfIiwDFFx/++
	 WDhj83MgIuFmDbQ5hmJ1tdqjRCb5isZIaLKQO/7Wy6iu1BUeQ0i3c8ebcyGICEFR4jCM5
	 UOZnym8jBa6MXoJhU03MmGp1EbXfA/C7J80YliaPxups4rIAB9KgySXtXquEMR9sKEMpw
	 UWmkRaD0YS2jWI0ap7mM1LVRLZcZefFuM927sfsnDse0dggmoOCkHFxe2D0e0eX1xxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795061261;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=x2/QjRDVPSzUNqLMZKWFwPJtgVc/fv/SSUDza6b7npZ6uQEFdeEtsH4b6Zk7Io/CreR7
	 zAYqpdv7RXBz13sIq3OI93RMcuEg4C/GVECqg2ItEqRMWBIaaEFJIz9QAHf+VbC47SJrw
	 +eTj1swxM+TJrXB7kbRQf7xAwGi0YNIS3FFiLwesLXzk64O0ZAf1/5GlF5eQebhBxtD12
	 DH2xML5a75FgW7xnHf6EB5uMJUP4oVNd7kuVebp0ozL+Pk97foZmznyN4A+CBQ5mynn4z
	 PHrKl1Ptj7TNAatl8//FBiNRksy7f+VS/w86nHNmCqUVIVz5CSn4DOuCbs/U/jeATUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h6kQxpk/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C92C60A2613;
	Thu, 19 Nov 2026 04:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6kQxpk/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADAE1F000CA;
	Thu, 19 Nov 2026 04:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795061261;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h6kQxpk/wUTjV7qJfAlwrxSj3pldJJBYbuVI8F9mEP51oxqZufUgRIO9X8wxhjALn
	 ViCJptmYX//dGFWjGRvGCu+ZSTIDZWgQLbpg1XF+doHibF7M4LkT5BHz8SraHr76Ii
	 R4EC7oGW5yMXDeepn4TRhUpn8Ydm4/Bj7FGGpUrQIXt+JuUMskR5dduu3YcAu4D0lW
	 gnU0q3e4oWvp7W95DxOINQzgCRv/nCsMhXXigmZRKZxkpSiZt4ZvLSWSTgZaivHR5X
	 cKx8/BOsVVMPRv06dpQZ4zk6I4aAAiubk1O69NXNPsu8+VHOM7szxWGKn4VxfR7Ald
	 DX0im1dM/cyBA==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Yuyang Huang <sigefriedhyy@gmail.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Daniel Machon <daniel.machon@microchip.com>
Subject: Re: [PATCH net v2] net: zero the tail of ha->addr when allocating
 address list entries
Date: Thu, 19 Nov 2026 04:07:40 +0000
Message-ID: <179506126016.3291.768995268008269701@kernel.org>
In-Reply-To: <20261119040153.158372-1-bsdhenrymartin@gmail.com>
References: <20261119040153.158372-1-bsdhenrymartin@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

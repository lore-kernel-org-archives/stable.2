Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700603;
	b=5hRkgcAzePylND//sWd1UrjSc88pRhFrkTQikPk8Yb8iu/1p07DeK8bNP9uaN2pokas/
	 JHxqTCO3KJcd35PvwPcIxD5sgbrOR9+r3KerGOyoFuHvyUEu0z37xvncnObjwF7NAhJ6g
	 PBVr/cgOEaPOr8ab9/QKNYEvmcpPZA9cZpOaLjlDTwS/rM3Us46UMCaXqHQRbwGlUNL2S
	 pJxjLDcRZZClVIKexBgHTrTW0xYYUnHqI3g5Lz9/ZRgfvFhwgbqrQxLmOmyXcXK6VKHmk
	 vo2jv9rJI9XLMh5ANVZYlyiWDqdL2xorY9mAA2Cott9s7sjFoivw9r52VKzbp3KNHRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=YZvMZU5M259iEwWhJ+T7KTu4mj5QHelzjKjUgIYpOkY0U5fDEDg/xoNROtImwNKb+uWw
	 6THLlv5qQ7zdC8S6016sWR19GInXdl//nZIQ2ma28XsoBjAWxLX/STCUyXVgE8lHUGg+H
	 OumsbjPTzT0KhgnZxMP2DZAA4PHno4nqm+MFpKVlc7jCp0gWoqqwqTDoPYgD4+mbi9Z5Q
	 JV6YyU1iKrq/3Q+DZRretAvlUjCs/kGwCt3G7vldHz9Em70Mi6Jn3+jcxrdniTzVTNmTx
	 lDZ5eUpUZttoiNkVfwj/wo/j+tivp6QaticfBmARoCB+Wu0ySiaghbRF+N9IE+gIXBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaHchsmK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C9606C57C;
	Tue,  3 Nov 2026 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaHchsmK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DAA1F000C1;
	Tue,  3 Nov 2026 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700602;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aaHchsmKkO0zMlqP84/iDgv+hDRQYchxcOGcePo48lwilaOmpNTsm9RZFP9WL8+RY
	 Gb3onY3ya8IWZK/WbH7nrezV1zc4u1ud5Cc2gJpmQ1UEDdrhlANVw/fvg9zPSymkIA
	 +xXZM8PYeL5DPL5Yg2FYY0Lp3Xuy3huEUoRF7t9gkzEraAefvXbfOWasoS3iaZHWt8
	 4YZP+NW/u/+6X3bEwKo08cSx+0lNOZ8pBNDmsvcsjZQIUI41mC2RaKWC4CVxl7SZSt
	 o8wf7ldrnfnFcuaMs7jxo/ftgesw0ZudU8tliAP2QOiAC3pAj111yZDoLefU1+uR7n
	 LkYY6STUf9jJw==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: hns3: destroy the page pool if RX buffer allocation fails
Date: Tue, 03 Nov 2026 10:10:01 +0000
Message-ID: <179370060166.488859.18036785445567619705@kernel.org>
In-Reply-To: <20261103100533.1310018-1-vulab@iscas.ac.cn>
References: <20261103100533.1310018-1-vulab@iscas.ac.cn>
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

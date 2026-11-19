Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069438;
	b=0zuA7kfWieMu0R233MA8Q/fWHDvGC/Ms7wmn2KQIb4bEjXVheojlROz2iDHWFEX+tsO9
	 rqvs1Cjez43QnIqWZtrmKJxbEHg4gxfaTxYOr7uybgzrr8MkIThJcTRggAXMjI9SzfFaG
	 vinsISY4RdL8MYKQUKeHeYBsk9rbtJao/FVl/g73rsMKlCGPfcg7G01UpdvzxIW8xkpRp
	 jMdQ1CnOnxySQfW2V18tLOg58BnxMVhQAOlQ51Zt+h94ryG1wTx5+JXhY7yD5LLbW/4G/
	 baynKQWz1i8/WLhToinXpQ8h/FL9pFKhwnXkLL9ne4Oc5aowlQsPQlVxr12I50jerMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069438;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=s3tkgzYJkcpsUA+Nw1aGNm4ArJbdTfhLKelINm5eGy6N/Ym74E48BAfUn9itCETiCTU2
	 YcfcbKDa7+K9TfU0C+JnpuDhP7WmCklwJ0uMgi3XJfOcETYsXzInw4V9kJVw8OqSBMUpH
	 UcRp3tWSJnSIPPHLJNxvSAguVc8brajohVDENEakRaeBHBynLzvU4bVJQOeY9D/G8k4eb
	 GgtG1fBitq1QBkw1qXxLUfEA8BOazq37DYAFK72gA/j9GKCCz429jJ3A6hMzA3Udrct/x
	 5WEyx7QTF2ldn+vdJFkQ1RLQ858wKxNij4jcYKtfurXP+XCRiAJPvAdwf9PbIkdRS6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmobXEA8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E7606A326;
	Thu, 19 Nov 2026 06:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmobXEA8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4498D1F000C4;
	Thu, 19 Nov 2026 06:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795069438;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nmobXEA8BY8H8yKoYGfvS0Ym1tOcAYN3VYvO3aifoMfyvBhEffu08cnHXGZi90qJq
	 QPPnALrqPsdSGnpUqLFx1U1BLh6b2xbWNFj6sYAX60Zij//ti3LZ5PCp4v6DB11nAX
	 qyr1iV3XTig+OHxucPEbnM/2ky0hnz4S35tShrs+zNPWYLezw70BpRORDfL9jmKywi
	 cMcisIhbu0W1ZRg2B/wamV6+reVmqxe4N+ctPFYMCD20aPx+kDnrtMLJv5U3vpKUlh
	 dImjPnrVV/n21OrQmhXY8XIQNGX3d4Ak14Cls9ddcWn69aJlkO648bBJOwhgLBk9lh
	 qK47uGlQ7L36g==
From: netdev-bot+sinfo@kernel.org
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 netdev@vger.kernel.org, Liu Haijun <haijun.liu@mediatek.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Lin Qiaojie <linqj@xiaopeng.com>
Subject: 
 Re: [PATCH net] net: wwan: t7xx: validate PIT data offset before skb_reserve
Date: Thu, 19 Nov 2026 06:23:56 +0000
Message-ID: <179506943682.3291.10326179398413921657@kernel.org>
In-Reply-To: <20261119062044.72261-1-fangxy@xiaopeng.com>
References: <20261119062044.72261-1-fangxy@xiaopeng.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

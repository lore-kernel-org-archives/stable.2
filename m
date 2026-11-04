Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784546;
	b=zo8CoAVqoGAFMoNbLMwVtXY/hxpdPfprtEGiZSmv7rDek7/vADIgEjK4kTfKOr5B3lD/
	 VRLAO6BxCj3gZXPh6cyvvW1MtnNI2mzEHAH6Y/AVM4BvDCbW6x0QIRM0lpE5nioU9Kvye
	 Gkgs5yoeSE51fOTW0sF+19XjUqfwC4HuTMpZC0LtI+NDvEYDRm7TXDD07/Fht2c1sRyUK
	 ysfzUQ+h6lXv3QlxgwlZQ7IX6ACKVxLA8Pr+MPKKfKAtVV5GJEgT3IaEgPaRc4D+YbOb6
	 YiW4jkJ381FcWfvxTzhm+QokMgMKdpIFME2ZqBe4KqQ/ke8Cd5dI41vXeRnZJXkxDuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784546;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=4ACIkhkQW7T3X+SA95bOde21cWy0wYaHuRYzPg7ld5okwUOfcDPmjvZEHqAzraGm9rxN
	 wGEEiphiDwn7NjQ3MW6r1RlxwSL2XNP/ikONJEAO3RuLYimneRfo3698mojLpaRWQbLYx
	 9pRay7vzyjVuEBSyK0F+siE8DOx72omigoRICyi9WA21XHoDImxsxC6QwXNVVXf3EaQYV
	 RPPvC+ZTD8bpN9AYFN45uPvA7SGcgd214XG930dWjGgF7Gds+4TQxQFlMR4kLy0oylero
	 nNprjWU0qIte16FdRdru1Celh0EwRNAYGdN1NWjt2/gyClIJE6Ly1WpL5qFpJ6awaCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTIhGWX+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B55606A31B;
	Wed,  4 Nov 2026 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTIhGWX+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F5C1F00A18;
	Wed,  4 Nov 2026 09:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784546;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oTIhGWX+ZczREnIsePV8Wtug/whCSotDQdP6E559D4aWu76zTm5aM9ZmfMmkPTGkV
	 lCKM0iudTVLOl/q/W1PYNKka1zU0uqBjVXoe1OdQf9O7oyC+8KMm8Qf7T/rF1YrwS/
	 +WAxBmHm6CTACtTNjmNLy1rSwBKTpimwn/NUKwE87cV7LOqfz2dcxcsEr1wlixwJIZ
	 7LQ4MzE2lfIZxov0/N+e7uUGMIVJjDMbkHuKmwOeOplAV5D59GFYaSzaIN2T4GeCN/
	 ikCqj7e/VIZd6XoSVbFa+rBTWZW2NAQ7CyLWqxabfFvtG+jxRqX13XccWiVXwXRamu
	 8o8syFax+uzRA==
From: netdev-bot+sinfo@kernel.org
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, willemdebruijn.kernel@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yana06070@163.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, willemb@google.com
Subject: Re: [PATCH net v2 1/2] ipv6: fix cached route reuse for SO_MARK
 control messages
Date: Wed, 04 Nov 2026 09:29:04 +0000
Message-ID: <179378454460.488859.3601103924224875787@kernel.org>
In-Reply-To: <20261104092240.15649-1-yanxia@cmss.chinamobile.com>
References: <20261104092240.15649-1-yanxia@cmss.chinamobile.com>
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
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

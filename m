Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163656;
	b=E7lKW/47WqaJ1iTjRhPEmFjPDjBclepCY9bWe5Ry41CPxQXEgm7mLGvb/rnN11DU4Flu
	 g+QsNEn+FvEY4ANgeZozizXqq+odNMjawEDlpun93w4HDRB9bytfq4R6CkaHdRsmEFfVO
	 711HOnC1GZ/i4k3qG4TwM/GpB0nMlARbr1nm4FgnXETXUsOUEVzQS+nvXeRmvt2WHLTxv
	 PlMMixJOHxarGiH6celAoMIf/RERgdgCYdUYnIdDU3ueLWOwC0N1vEGrjGiT4OkH3uJOf
	 MEIo7jmkfkttlWsJlELrvGxRJEX5OuTmXKItrnIHcOWhQxiQ+fQzuREGwvbCG6D7uQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163656;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=hJYiQXyp1lH/y/qQMz2Wkw6ewVNI7oDPXq7rWrmR2YAfjzqysLIGZHqoeiKyxTXIRdN2
	 8UgrWFTU01LMYvKlPO1Q8RQZ0/mmja72IHcLaG7YtBiQYOIcBGFtd+Luh2JpzCoQKnVF9
	 nKWbIvwkdPQFDpOMEUYT4idLWpA96P8ibMg07sBMohhnPdC1CSV41X3FNXVP4ySWebnTO
	 bjGskhZHqSX30jVqko+jGQPxZ58Gba2sWDxeh2QCjY0EQvbl+tRXBG/Jh7a6XULn/1imW
	 mB5ECXMj3LDa5gyl8au31BgI0fzr/K8oNDYlIQXL0pZ+Vp1Y293WfCTsNmF6LZcwcsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EI/kQeMy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D44606A31A;
	Wed, 28 Oct 2026 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EI/kQeMy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7A51F031E0;
	Wed, 28 Oct 2026 05:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793163655;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EI/kQeMy+yW2553ckcoHDO5Ae5sOsjhBImzDjBOSJAJnORY2l47kbQg+FFpw8FvpP
	 RVaWRuybHaCluvs6cvVAdnOU4pV9hfOfLchAbz2pMSo/L+iksBjPM6uh/bDhIWAiG9
	 Nh+LZnnwuCxrsCZt3V6fxpefRnBikPjJCytQlvigxDpGDBSx/L+iY8+xzUZPIuMBRX
	 mErd9142ZE9HzvjXGUao1W9qfkev6/NsmVccRSk/b0hnvgyFbWSk7hT4wbwecCDhf/
	 eyClPANXZhuf34GDCuNe54LMJ5JBewVF61pyvx/HscCmmZBhNnwRW0K2ADE+o7bAyX
	 WnAw3sdPO6WkA==
From: netdev-bot+sinfo@kernel.org
To: Jiale Yao <yaojiale02@163.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ariel Elior <Ariel.Elior@qlogic.com>, Yuval Mintz <Yuval.Mintz@qlogic.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] qed: drain slowpath tasklets during teardown
Date: Wed, 28 Oct 2026 05:00:54 +0000
Message-ID: <179316365462.3327.8032613341391656021@kernel.org>
In-Reply-To: <20261028045535.110688-1-yaojiale02@163.com>
References: <20261028045535.110688-1-yaojiale02@163.com>
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

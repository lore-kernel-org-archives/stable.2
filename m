Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702987;
	b=WEVd8oWam7/iEN4WC0VR6ayG67gOybade6+C5SfguHq6h0Ehl7myFKj4zvh02pWtRHon
	 60q/8fMicU4RPcvKtPAveIdT1GPsotG65hRXdKwgfuGWfwP635wWH+x/XTnnkwpi+BCp5
	 iEoUfIwPlg0FEpkSPB02QTCo60RRR6oUgqAYIfNQ9a5rBovLj3Nr8HEg0i9qR22eZiw/S
	 4dMVUZIn5DoTCs3q3tkd+HcNRjsBQ0E+Tpk2uCor8pEmVOYgnSgrc7agufAwnEsW6tyvd
	 OGH0iYQty71SzF5Z1EQyUAkYS33jQ7wQ3+ueAc5qmpxNiCBUFSF3axp6qg3FENkQj9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702987;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=kSE0EGsqJOQd0k3vyKj6Z7vvpfg3UMIAEO+Nr2chvobtf6qvgshH++Hfgsulg43ZUQ+k
	 cg7owzcv26C1PYgJihuqqk5fSh4RBKS+NxGkyNCqswYVMV+wbF05qCSG8FCuNE2lr/7af
	 yO56OPMXZ882O3vuvwrM8hS1tW3sJ7DXtRrB5azR4aKKQ74x4zaQCHuee7n38uPEoxJDU
	 X9yLQbcPhfG1I0xT9eEuKt+BrAyF7LaAtq6gCzVQgm9KoecwKAxSN0kmcJy/ep4iLyoIC
	 6gndv6wHqu+84r2ITzh5ZD+3bFctKkV260UXBcQYvhBy5vXqMEQ7Cb/0+en/URbmUsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vx5KxwKh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30472606A828;
	Tue,  3 Nov 2026 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vx5KxwKh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CC31F000C1;
	Tue,  3 Nov 2026 10:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702987;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vx5KxwKh2n86yrd4SJOATo27TrL2RNNSe2jMDBKUQ1ldwm0tojhu+AqM48yRijjoG
	 /GTOYQLCgM0gQfLiZxW/3LZ0g7aeIltCuSYln7c773oyM1nzj3alyCSXIkjwBObwqV
	 kvAwwnohGpYGLaaolElrYpSu2oZO37WThxptmycO/iubNt4H3HrJTIm3265Pru9DJR
	 BDkJ1w8/4SMi802eqo3DFNp+BIi2gfGuT7DFvqs3rAsYBGbugHNgrVPhXbpZ0cz/zq
	 XlrVmFfl86S+MTkJJRzyk3naP6ja265j4c6EDm+fXviToYTbNNeXGIHfRneJV5uWe/
	 FjLmaoZhxXQOA==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Zhao Qiang <qiang.zhao@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: wan: fsl_ucc_hdlc: release the net device on remove
Date: Tue, 03 Nov 2026 10:49:45 +0000
Message-ID: <179370298589.488859.8331776188055179026@kernel.org>
In-Reply-To: <20261103104237.1373675-1-vulab@iscas.ac.cn>
References: <20261103104237.1373675-1-vulab@iscas.ac.cn>
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

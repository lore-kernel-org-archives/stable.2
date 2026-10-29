Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291936;
	b=nmO8/maMGqTHjtQhEMszHqztQiD+/gX3Y0bZZrBw+p/XutEZ1ZxCHvP5wXnmgshYzujl
	 ZuflO2kmVmsViOV90ODbZg8DNNh/YJMhu9k3ADmjCLKR4sXncTSTvEOs+wIJfHcgtbIUp
	 4AgyxJHBeKd3bdGlVwoQUnnhOnRPMan6bihkidct4zVb0bGJsgbBVp3TMQMdRrKcmn17q
	 17Na7OAaN8XXZF25wKqlijU+GggCuNVe0co/FJg6K+bGLlI9CHD6y5CWfXDhq6eGjIq6c
	 NOpQcF5DHZB9xxLDizqD2/eg6TKKDfHQLQmEYN4A+MnT7gfQUFIwdtMdSy8JnKWfy4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291936;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=sULVglHJCgxRYe1Y7bllvtopnRakgfyuZFWOLnKgUXa9BfLnYO62h6tfcuRWv1Vr/KW1
	 woMSxbagFyGmi0JpXzU4ZwTP6702xZOkbtoi/xT+fNfF+0jhQXf0iiKHKjn5GOsq++N3d
	 dKGFt2+wHR74nglHq9z3xCr/rZjjdYhfDep2i4/sr4vGmIMSeegplhO/KirlShB/ZSE80
	 zsfWomY8finiMxoiV1YXN0HVEoKZFwWLE93xZcHsgvqcBsyOSkpN4V6Mhk270dKWF3Q7X
	 RdZmag9mh1DEF5BNVu+HNlWaxBI3zLWs/a3ZmBqPceh4Uppim8rG1VhaeREEUTze8Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEaMPKb1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261C606A32D;
	Thu, 29 Oct 2026 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEaMPKb1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A6B1F01824;
	Thu, 29 Oct 2026 16:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793291935;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BEaMPKb1ZK4zTVgDeOY9cgBdeAaQGlE8TMe8d6BcMx0qoMXDiDgrpLWxTE2ptiXKh
	 QtjTqlIvs+DmbBjF5t1js3MUjHCgV/Rbh3o2dfmCQ8Gskcb9zNGlluNCpea52N8iez
	 l9pLjKoRK+kA1ZV2K6sGUZpbxkhZ9DeTgmh6fxi1rKlUcggoUewrTk3Yy/VZ1yNVdu
	 nJL+oagpCORGPvK62fqR5Pl1S3X0clsj4F96Txc/FW0ReZS75KnlWe0ppzkuIr3u5t
	 cSY/CciQyQPtoEWxlITgIievz8KS2Tp6he6z52Oy0JOCefGeBtCg+ZGvE6YAllXgu1
	 xjRTJWyedgRRQ==
From: netdev-bot+sinfo@kernel.org
To: hyunjungg <hj351016@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] net/sched: em_ipt: reject hook values >= NF_INET_NUMHOOKS
Date: Thu, 29 Oct 2026 16:38:54 +0000
Message-ID: <179329193445.3327.7941488029152521409@kernel.org>
In-Reply-To: <20261029163516.2476127-1-hj351016@gmail.com>
References: <20261029163516.2476127-1-hj351016@gmail.com>
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

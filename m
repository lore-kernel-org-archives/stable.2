Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702015;
	b=YBy4gpg8Hz7iIbTqUBlfZqOtKytt6gC6yq9lpUqajgB7azr5OkjsuER0aJKBqUnZng5H
	 awu62Qxn+5FsIxZdDrnuBvJJNZFOpZby+DhKq7TLv3wuwuY32USJDmxX4CPAemNRdCRpp
	 79o/KxGfNU9ns+s+VrAPnK3GtwdHGhS9g41xJccM6i1pAlB9RJldx6L12ZxQ/tV7dRhF3
	 AdY5lsWCvCR4/EGyfNBAuFVb6md0L+9IzyQQ0Xy+ZC1lmrzJc5tQCB4dA8n/C0T/ltLWA
	 ewFEMKWS+Da5Vt7ebm7hSFLonM9a6aBdzlZK43BFwhq+wXbC1oW+8e31fGoD8tvBdVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702015;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=azBKLNB44DnxH59fA3pwnfTw33zR2GMc2HQbe2vB9wqcCxW81gQfvGySp/7Fs5/7mYJH
	 Kd29/DXEziN7AaibCUfHgXUz2H588Q3pAFHcFJIUJ5DvS4d0ybaYLXRFBsinhhLPZZrFp
	 +07gvszniBGD1HxIlibDBHwdDxvXrOmr4vClt74R32dNdT9I1bKjgjJYxluQx0MwYZ+yw
	 ef9q+Besmg3s4ajzS6PnDmZk43ke1iE0HE68t0Fj9RlOasAquTyFWuWMiV6pe9lZqw+LC
	 IF24ubBmwKolLfmrKUuNXNcUCmPUs2hBdWrymagXp/FDhH8uU3QrdRWO+1Bpx7AHpqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=COdMJRxV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F7460711F4;
	Tue,  3 Nov 2026 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=COdMJRxV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF3A1F0093A;
	Tue,  3 Nov 2026 10:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702015;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=COdMJRxVRMNBPJ2eLUzvpQ2oK+tHXZ/h0LVNcWYOa/PBmXamdAOWXKkFDghFyycOG
	 7w+ec7jFVaA8z2ihY9HIedjOTLH5d67ongye+FgVM1ym19VO8dHD9w6Hm3gklNiDNx
	 mCs+Z6uKmuxOFpdv2K9Pv9guevn2Tr1IJZNHMdpsb5B1mSAMC4zvgAfZ9v4IurXoWu
	 qZjNDLUZckVEvDN92xq+MXr0UwNUFwLzPiKRwJOBEnvoIovxGFhY/hV8aKaAauTeKT
	 njAHMLNn7wECTThIm4ycsajPnnJA5reJPzfJCe2uPgBVfMnw6XWfTFbhBhQUVgW9W0
	 fGAtOHu4AIbuQ==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: ethernet: sunplus: spl2sw: release the port node in probe
Date: Tue, 03 Nov 2026 10:33:34 +0000
Message-ID: <179370201418.488859.14883668724268761020@kernel.org>
In-Reply-To: <20261103102852.1340500-1-vulab@iscas.ac.cn>
References: <20261103102852.1340500-1-vulab@iscas.ac.cn>
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

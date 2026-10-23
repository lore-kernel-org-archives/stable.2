Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792755987;
	b=RgilDV3BvGvDWTt/SQWofZ+G1L1lST2qs2Rv/PbYK/0NPpWqkeenZbCSqDUaFxLhSzqT
	 ZnmXIWZLFFPonPNxlDAoo8UwjQD6T3onuQdHkvzcZrrYojaxbJsjpjPzGG4aNoKHWLEo9
	 vEFwpOaTwY2GgDkFAjjN0//hAGoulETa1+c7Kpz9jNTkpBib78KENU0RuHfc5rlmCDRfW
	 BVfQs1CDiNKuUshdIeCkQWUvs3JGigAe22sV2NwQBDsCHTcNcKbMLRDQAiROaOd/t9iwU
	 pQqT7eYntt6BDMkbRIuZnuSEZl0tBBo0LZFbz1UVCjRLg3ye0/NYAieRMRyETi4MgHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755987;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=mGeWf9nTMw+93P2OW5ZbZePGIgtleMoRLGaqRwU67LFhfugrF/NzZO+xJN8/os0UIfSJ
	 Xm2kxAsdJj/9IGRMuuOkhXGD0mZv/9Tv3TcrfRxXdwOrsBPsprd7gzw4mtAJlLU5SFmVY
	 04zIIbdSCyHd5numG4/Mk9mYDzVMF9NUVATVhPcHx3Q+R1bhIVpiNGNx/OFKfLPTMd12A
	 6FQtCzQboioxe1sVmJ5OueGvXo6TYTwOPA/zUAxICeCtV5krBpkTPFm2VmXUPLd2vu2RC
	 m96i7QFohdt9RrQcYEmxnG7PZAwi6+qQZutOSwiB21hOozUcl4NMGIm/vGXF3C6L+sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tb3ZUHuy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37346606A31B;
	Fri, 23 Oct 2026 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tb3ZUHuy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232F11F01825;
	Fri, 23 Oct 2026 11:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792755986;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tb3ZUHuyVsU3Du2oKgwtye/S/V52V91RB47cfH6GPBWZx40WgQDa5AtCXvKjAKRrf
	 asi54nTokCza2FpL1WJDnPAM+WWqtPm/VKcO7oziKOthzB+KzbZD/jyi1Pa/QikuZ2
	 J1rT/s0cug40Xpt6FfZ0noOvCG9RjE28skTQVdLVEYafd4B30HwIhLS8PVqYkludLK
	 zSJUHiQPQP8FqxCSntCmDCetCiY7I/IWa1gajyOHtn1KSakoz/ZFhY3BAqy00q+DjP
	 sztWFqV7DQ83OyhhAMD13dmC3HhcO9MYtmboNsVGytEV3mPK+8ZQD9qEbFaQk3X68D
	 +mZSAj6MojPig==
From: netdev-bot+sinfo@kernel.org
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Neal Cardwell <ncardwell@google.com>,
 Joel Granados <joel.granados@kernel.org>,
 Matthias Tafelmeier <matthias.tafelmeier@gmx.net>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: reject dev_weight products that overflow int
Date: Fri, 23 Oct 2026 11:46:25 +0000
Message-ID: <179275598563.3327.1063511858982902916@kernel.org>
In-Reply-To: <20261023114228.289161-1-jiayuan.chen@linux.dev>
References: <20261023114228.289161-1-jiayuan.chen@linux.dev>
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

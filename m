Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795142442;
	b=za6aL1SEERN5s6RXTMQ6yTC6sZGKrDYIxXzcPy8czY6D5CMCljQAi+bT0mmW3LkIZsce
	 kA7WavlCr5Xego6Fu2u9wXbqH+gfQFiYmoRwbhBH54YsXASVPY1FKmQlyaWEbku0lNj/p
	 yc0vUvQP84q+noPUxzljPzOBPfzCaELlyFp6A+LF/94ASKe1Jr/4r4LziOxweYw8Daqz9
	 fQR37olMvImI3HGCt4XaB2dj4AC2m/Bua4BpUfVM8YFN0pbf30zqjh9e7odXbQF1V7I00
	 C3xZ9WoFkiS6VrWbxQ9oyfg1j9h6wMVIVLh4ANBYHNa6ANJy8wtCcoh9mgx5RjwK0cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795142442;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mfZO18oBQCqCq+e1KaZpH5JcESLIsSMc1CQXDKdj9vQ=;
	b=LIXDOAtUW/LMPk1XjtkjF9MK2DxuRBFg9A8EceFcqxewYvq86DVi7QExkREq3MwuhRBS
	 a+GUzabuxlZzAVVqPr1MXAlu19jH3IDK2+nsLhIGAO7fNOdDCp06by4OSGqe1ama4jr0D
	 /biuBMrpS9i+OURlysV6V9gotBURnsYOSNQnHC5W67DLcAkOIdX/Al4IVusRHqPW7RkDY
	 KMaz/C/cg+coOie2YMJKbyuZ9HmJLME1FHCPaD4UJX7KVml82lb+s3A75t2DaSsTCNzFN
	 0qKld4WLcso+71Bb1BtomOtiMfw3QUXffWuQfMywJSfKOLt3Vf9nOI7GhErfn+Gjdig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzpN55KN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE0606A320;
	Fri, 20 Nov 2026 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzpN55KN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700CD1F000CA;
	Fri, 20 Nov 2026 02:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795142441;
	bh=mfZO18oBQCqCq+e1KaZpH5JcESLIsSMc1CQXDKdj9vQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DzpN55KNH8/zEt6qh3mo1+T/3Bfkc64+7CO307ROnadCVmKibu0VuKniwggNmIDDA
	 fgq2AyFAgD0R2W32HmlefMLQFSk2Kg4olhOVZrUl2QbhBJhhp8sUm4CMgI6BRrQhNL
	 fm6/L8k5Lxi2qGWSzO4puoIP98Eat8oD9xeT5CnMa9qO0kfqTLoLAP0M1Unn2XlIOs
	 YNEBy2tZZfIUuXdW+AOvEQvd2wBRnAbcsy/2hjViq8Rvlt80RZV3X2p+ydLqjoTHqg
	 Xw0KJhlw56rqx4ASLuhQzN6HxNWMt0GMCGyzFCzDaCRXNFLQDD/X7oMQXN/dCyX9W1
	 reHd7EHnIRV4w==
Date: Thu, 19 Nov 2026 18:40:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] tcp: fix shift-out-of-bounds in SYN-ACK
 retransmit timers
Message-ID: <20261119184040.6a4542f4@kernel.org>
In-Reply-To: <20261118144249.358481-1-jiayuan.chen@linux.dev>
References: <20261118144249.358481-1-jiayuan.chen@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Nov 2026 22:42:37 +0800 Jiayuan Chen wrote:
> req->num_timeout counts the SYN-ACK timeouts of a request and is used as
> a shift amount:

As Eric predicted this does not apply after Chris's series,
please rebase & repost.
-- 
pw-bot: cr

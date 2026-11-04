Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803394;
	b=MT3Ksfx4+MW3pDzlpkzdkUcsOuFt6swFtGdVgW0ILFgoD/kH5S9R5ifRuHCnxwAqdj6k
	 mQGIalllyzAFus6WISbC0UTccVvrtMs5uSgQM/SsffAunulCSDWeCbEGoFuMf0ehebpqa
	 VIj9Bt5sNa4j6jD775SBoKJCrch7ZTwlJblkHPIBBOtQBcoO9XY4h+UtD5UbuUE5jYt8r
	 WCzxy95NeV4bx+SgXLQhFgqqOFIy2S+syU8sJT2SCA2a36Kv4yfQqRqueedmP0h6qXBAV
	 hwFeBkkOFdihQfZFPNlXkQBGoajO1syb6IjuudSxtHEAs7jcK8fEIECazJh2nbEkNFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803394;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jrtokQE/RgxkkYzzF49cdR+5C0s6jUzSVCuRBLTOprI=;
	b=HuBzP994nm6TIImgGuGMmvZsj2YJy5nAJ5G7u08b8o7CCDIXztlMX12e++UbxcUNV61o
	 T6g+ouSxpqaz7F0kkOFjUdlWzl+bxZ9v3Ve16m5xQydxRZvTVrEkapLbtkegOwydOxTM5
	 5a66uDP78QmwEX8iaQNlp3/8isMP7Dte9uz4bMNNe0TcTe9ukMcHds+KNPmeKguIrnfmn
	 ZRXnPCr7VHJvaA1Zqm62YurWrK/XzWGXzMaJjZg8xGUyzDxy1T3KPP6M3UW/a7HU84U2N
	 nJKQDrdKqNakXh7xXay0uA7iXXvqQPDsP0ih77yWKxU19fFimDIsm3dPdi54Qa/R0wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=El2cdMbT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3DE7E606A31B;
	Wed,  4 Nov 2026 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=El2cdMbT
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 634411F000C1;
	Wed,  4 Nov 2026 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793803393;
	bh=jrtokQE/RgxkkYzzF49cdR+5C0s6jUzSVCuRBLTOprI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=El2cdMbT9/Ycg08xrNK1h/3RGRI6E2bIZujS+lh5VKjo631kbMKpWQQVdn7QoJ2Y0
	 TPYardS7GvwoDTTPMVamG4mWjbV0G9qDnW3VCnDCcHY9LRvdfQ70AUif/h9Jf7W8KR
	 qxoHixYDs9Lriqk0kmSBkxZ/OMs6ndP1LJokWOCb7+R/ThbParGMsbbwixuyths59w
	 uyuX4WADQ8187FQRsexCeUjQfK65Xn6qtBJH9rKXcvUYlXj+G1pG5q0Y8JLDnbUT+j
	 gUT5iVsVK149iijFJeaWrRGnjzNbTG9t4G9EIg8v5R7yySvLo1TxPjF7GKUx/H8guT
	 fdePnMrirXG4A==
Date: Wed, 4 Nov 2026 16:43:09 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org, stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Hannes Reinecke <hare@kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put() call
 to nvme_tls_key_lookup()
Message-ID: <autEfTlEWj_OrtB5@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
 <20261103053303.GA1382@lst.de>
 <aunTlxXbRJ6ZP63h@kernel.org>
 <20261104090440.GA30968@lst.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104090440.GA30968@lst.de>

On Wed, Nov 04, 2026 at 10:04:40AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 03, 2026 at 02:29:11PM +0200, Jarkko Sakkinen wrote:
> > And essentially what I would want is key_type_dead not to exist.
> > 
> > This version is based on module pinning, and  thus not having that
> > key_put() would keep key type module alive in that case. However, it
> > turned out this approach will not fly as AF_RXRPC and DNS resolver will
> > hit the wall given e.g., the remote pinnings.
> > 
> > The approach I'm going for next is to have a type registry instead,
> > which is independent of the module system (to put story really short).
> > I think I'm doing this with right process as this really needs a few
> > trials in order to find patterns that stick.
> 
> So what's the plan here.  Should we merge this standalone as a fix,
> or are you trying to get an entire series in?
> 
> If it's useful as a standalone fix, please resend it standalone.

I'll send this as a standalone patch.

Br, Jarkko

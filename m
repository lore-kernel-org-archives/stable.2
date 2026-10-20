Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530983;
	b=W+OfFHenLjyb9cloemckiXX5GpdTV6czZdJMDvBsv7fsR6JeC0mGbAueD5gGzRDDVsoP
	 UUGvGtmN34rVZOdiph6whQDfQVlj5scjZGFXh35yIsk0kxWtNbNVygff7t8L2MNtH1j2v
	 md1x7DzBdXVm6Sh4S6pBmZY2dHTOpv0aKgqrzw5xHQX2W5wyl7FZlz4ahIPYgiYJ9JuIB
	 ogcI4cXFYfQ84HfP4kq9ZYHS5d974y+nWdOloZ6f1HiHTraEc3KM/jlwFfvTgz+SsqF/P
	 qanBs2MX8LV2q0hOlhsLrp8h/6cvgDLxVEKakSY+KreezhoG8CxUdTVFH94y43/CpZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530983;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jwIdPduBcOF9gzlmolZZ7anKDU5BdFiR508ngqTOJ98=;
	b=dVApaOaZ2WXJJPf88Xmr7FAzyqbE1iwm6TXWJS6E+M2Hmn/gJKo8/CYiBaYBzRJpQeeJ
	 I/e0I//8R6TcNi+vkVKn4+AikvU2r8WXu9biLkIrhWkvbrLc9RvDsorIYkquD5GovPZJq
	 pnjTg5pkFN64K4mfC9LEPu4K9FJuKrHO+o+uiBW+DlSHknmQP6eGEFkbJ+xNIfuCZXOCT
	 z+xGr2HFv/ZSukDUNhPpfQRoZhLWiw90hdGE3mUKvx4mJ+EfodaTWhjGLYUooMZ7aM/me
	 ho02dnVnkwW+zsdGw0VFtrQSAyrGFJjcpNj643qx5VQZIG89euI5gCwI1BND2TMB3bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mu4CXBf8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A01A5606A31A;
	Tue, 20 Oct 2026 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mu4CXBf8
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 987E91F000C9;
	Tue, 20 Oct 2026 21:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792530983;
	bh=jwIdPduBcOF9gzlmolZZ7anKDU5BdFiR508ngqTOJ98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mu4CXBf8+W2LfTJyCMEn4R0SEGt4CygSPLo8U0pdiyjdSvh1atC8nPcLp1uB9MK1q
	 0UFM/ZePHbFdwDBuwxXzSTutM9Kd+FPr+Uz1nJinBWaPnyKoaxdTBodAHebvRZCcRA
	 5dKtWra6wyoN6SIIpjnPKj6o402Vp1DVDqkHExHHj3xa7xf+jc1X9okdClMguNzatY
	 uuvLKdulpuGora9ZuprpcCMAa4Es02z+qpVcMSLRjOEtaiuzerqZ0+lCWs8A0HwVGk
	 1czVPazrJfdU+Ng300EG7dhilQSDUoilgMlxSYF4YeBc3z6iKdRltHf9BUvKdYY+p0
	 TSIu6GIcTmncw==
Date: Wed, 21 Oct 2026 00:16:19 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] KEYS: Reject descriptions larger than
 KEY_MAX_DESC_SIZE
Message-ID: <atfaI1d3heLgX5jE@kernel.org>
References: <20261020174325.2229448-1-jarkko@kernel.org>
 <20261020174325.2229448-3-jarkko@kernel.org>
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
In-Reply-To: <20261020174325.2229448-3-jarkko@kernel.org>

On Tue, Oct 20, 2026 at 08:43:20PM +0300, Jarkko Sakkinen wrote:

There is only case in key_alloc() where index_key.desc_len is not set:

	desclen = strlen(desc);
	if (desclen >= KEY_MAX_DESC_SIZE)
		goto error;


Other sites match to:

	static int keyring_index_key_set_desc(void *desc, int desclen)
	{
		desclen = strlen(index_key.description);
		if (desclen >= KEY_MAX_DESC_SIZE) {
			return -EINVAL;
		}
		index_key->desc_len = desclen;
	}	

Given how long setter for index key's has been broken at some many sites
and the bug has been buried for so many years, I don't see any good
reason not to make the operation explicit with a wrapper.

In this the size of this patch would also shrink as a result.

Br, Jarkko
 

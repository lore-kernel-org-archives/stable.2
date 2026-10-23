Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785310;
	b=oECQVaa0Zkct6fxv0voeYsvv0R2uJ04zKbFDCQdg5pAkV94lOGnIXzkg4KNX4vV2v1Eg
	 Ve4r43h1EjJfs+nM6uXdxRNClcDvbtn5q/NjjvSgYu5uLv+IAoOEzrW464WLv+9BqFhoD
	 PlvMuFU8phDoh/fZTFuGXq0EpAtAEskhfO9SU4oQSJGeQfxMTdGtVKsgz+Wupzkzy9C9+
	 L7hRcNHqYDbkkWIZ5KXST0tkPaKolLBzkncvcxq+H87OBQiv8qX3vn9JVB31uBM+ucRyF
	 WnsCdtw5fN9vUiGMkGBtQLPZZUPv6/eR1fM8n5KQtrmzg/GEYZlDnKzWfgz4QE98Qdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785310;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=1L1/mahKtRoRcmNgi4aGIWMdd9Mb0jQVD3EjXzQfav1J2ZWtgbFRrHF07oVSvVYcfFU1
	 qiE5suc9kFhElH5qhUi2ut9Zihi52CHyh7CUqPo2P6kAHc52KM/8RiRkvdEkWeRKiDvG/
	 MJzsCj+HCDdWJHKCpMUgo0ms6Tw8qvpzoVrzJlw/vaN9QiJ4k7SVpFt5mn9Csz9Tp+HF4
	 WbYKTzydIMq/pX/UsfsYl/Yn2gI8QuB5/xqL8BCBM8X0vN3rRJu26hIZwduWXQHhyWy3c
	 z+IcQANuHGo9E5POgMjzJ+bVofiTZ2sKNV1pEm8JFy/yk7TjbMy6tRBiojy62jtYSDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NC52wE2K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E2060A3803;
	Fri, 23 Oct 2026 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NC52wE2K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E8E1F031E5;
	Fri, 23 Oct 2026 19:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785309;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NC52wE2KMfWLaOAcV+cS8hmbbEsfAgyuQop22zsFH7iMa3h/444qLIzj3MRF43Nmr
	 2DdTl5OEupGVN0HNmXP7E5+eAsnAhSjUg7lX9zKvHe8dOg7FHj4jWHUtnXWA7iGBot
	 zSBhqHvFJFmGZBoggfoc5OPAiEFbeJ+vHaoPebH+DBlZ1BOeeWczzmgPSvkeXt/C1p
	 OKLxx7kP0KDoWZtZ+XEHEeh9D+LTwAaT+LN6HGYgSFb1ys2Vki8Nq9tRObxhKoiOlv
	 JwS8V01vtb/239JDxRzGcnmgUFvhr/PB+7t46nAlyuFuuARjBNSQMJatQrjTcWc/yF
	 /VYoljf/lxWAg==
From: netdev-bot+sinfo@kernel.org
To: Tristan Madani <tristmd@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: 
 Re: [PATCH ipsec] xfrm: fix output state cache TOCTOU in xfrm_state_find()
Date: Fri, 23 Oct 2026 19:55:08 +0000
Message-ID: <179278530870.3327.6992676893660130130@kernel.org>
In-Reply-To: <20261023195323.3528192-1-tristmd@gmail.com>
References: <20261023195323.3528192-1-tristmd@gmail.com>
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

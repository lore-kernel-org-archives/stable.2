Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804617;
	b=u92y/fewH6ibGMKghUwa0B1eMub8b7jIhHL8iQv52UPDOUBIVb/QCLVS1X+a8gdPXr/K
	 keGoRtosXfGcir3XT4RRi2lonqVm+lVOXtSfmymXNBdFN5pS1gGgb2xiF0fBi3NaKF7LX
	 TrFuI3nMlrfghRNgwCN7tdic+FeWaATL5AKkmKXH/5mUeFBDFdr5jLC+kfKe6st7wNi7N
	 ThtWg6jczeJFxuhmdv/5crvQjcrgBTc+srxXmrRkRtIEbm+PdbrnZ5UxTSZpyH8iFMy9D
	 ghkyEdtkyqqxR3c+stEETBQll3Rv0tHLV4HYtHj9uv11lMm0E/H/2qF/BS6qKeOiXiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804617;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4LBH7p1faAYyFFRDwMoTw2KoR4cWsorn4nLhR9MEoBM=;
	b=KRphI5mcTmVVZY9BIDV1x8DvyGFulsrhryj9ywKFyipXrZemBy1OR86QhTRBwsUwQCFo
	 hw4d3+Uz+i/NrPNpZnScgwWDRZ8twUDHCljYnCLP5GnotMA8WWbOKiJn0hr0emqqviixA
	 ImTzS0PDh/2bILZkhimvcNpKHv8CnPSKijZHqCo2uKD9UxAuBifN4SRIsZmkE6he0zVnz
	 5uuGWxj7y1J8OX/l9zRY/e7gunA9MG0+ok9ctYfzKZxL2XZi7KSEJhYQb/KLQLH2taQSb
	 7KesMpdrmh515wDtfDaPs4c+IdxSNdYvaN+Y49bGHBi7b36IIaT5qrfwjlKQ3fxfS3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Iu8U/Cv5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A204606D80B;
	Wed,  4 Nov 2026 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iu8U/Cv5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FABB1F00A1B;
	Wed,  4 Nov 2026 15:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804617;
	bh=4LBH7p1faAYyFFRDwMoTw2KoR4cWsorn4nLhR9MEoBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iu8U/Cv50u9AC5+N0R1roXnywwj6dD379LFel/kc+QiNuwcxdO0z17L8jTHYODdHx
	 ph1XjQo6YIhWd7aZT9DUzYfHPYjlE366vvWMo97I152RaSDp29wZG4Ra0HkynUZkAt
	 WRKM1vmr8EnWcHfGwijEH/5f05vxVc/+XfaK4wlnfoTKA96k0MOGPG8ZMhswn+d95Q
	 IxFJN7cyKxT8bnqic1JWJDgeye8geRekjmuyW86HBsDkhZjY5/1Sa1dD94PB8+i8G5
	 znF1kKa4+Y014+2vqL3ljczmj6hvurTDLxJsKEYqpvtlfcKkEYOqCjWczd9ZFzKHiE
	 epIBxmzdHRepA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Subject: Re: [PATCH 6.18] Revert "net: Convert proto_ops bind() callbacks to use sockaddr_unsized"
Date: Wed,  4 Nov 2026 10:03:18 -0500
Message-ID: <2026-11-04-1-daily-reply-0009-re-revert-sockaddr-unsized@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103174541.85310-1-abuehaze@amazon.com>
References: <20261103174541.85310-1-abuehaze@amazon.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-03, Hazem Mohamed Abuelfotoh <abuehaze@amazon.com> wrote:
> Revert commit 946dc5835c8fbe5eb5ceb13f5717778911ff4586 which is commit
> 0e50474fa514822e9d990874e554bf8043a201d7 upstream.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

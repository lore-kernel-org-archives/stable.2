Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597020;
	b=ldGuMxFYS0ZuAq1w/Yx4wSzJp8QhnbqAx0efei1pRweZC+18cjM81AAnkIT83G9TMQ99
	 WqYrmLzsQdO29msX/wvrzvLKgeaSnStIX5hxn//wKVJ+GWZNwKbqg0ZnMN262tmfshdpK
	 bZhi5bP+TU3ztvy/Q56R9g01UmFOrrHlAnTAp19LG02lIRKRtin3nrMh8d8dAa/JBhpnU
	 J+e835XjSK4RPFP9qcLGSyjikU7kN/FYX3WFGExY6C0AOlpfnfVYYJhULrNwaya7WZ4rV
	 DRy1vL9AObVc22HTqj91lvRLw60gW3oyYa4fr5pIslrktGzTD8cMNlNdnUB24DxjX7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597020;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JlCk0fZxI4n5JDxLk090CwQHqy7iWrEbFNbW+/ZNy2s=;
	b=Gn+KWCTzE0trasxu3gQ9USNt6gRyHh3bpjBzEqEK82lUR+apD8UBtRl7V9pYu5Whcp1J
	 oQE86DmJ/4cf8ZmvomUaIu1l2eeO3hPPCm5h738xMHx1FiNvmpxpAvlBbUn5F48Usrg/Q
	 4QDOzNGKC0WXAExyYh9YRu1zR89XBCFxMf8zwKAKix5U8ndKVIV4wbn9bemJxUIwoYDt1
	 Nm0qmlvnFMaN4SDq8aq4+1iRXBM53i1Gzyuz/CDml61QBmW1QpUDwAwTTYMa0MUmlv3Fs
	 wKhJnRSaVtx+AVUi8mIkFcAyCbr/aRXxNusp6m6LlJmmqrFb3sYShtmd7ZZULWLrGLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3LIuizV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9A260A2636
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3LIuizV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B141D1F000C7;
	Fri, 13 Nov 2026 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597020;
	bh=JlCk0fZxI4n5JDxLk090CwQHqy7iWrEbFNbW+/ZNy2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b3LIuizVF42NTilIvUFMxDG6ST/tTu3hs+/+LskmtrK+lm1tGTWij2WBfNGgU6/uD
	 ykNXudfqPIJncAazh/8/aNWUgxug8PNnOASaYMU9ac6zKzfflUZxdQ9xZckGOZPKQE
	 m+9pTMFnVCGlV7VQyhQfJ38Mj9Obyc3WlvQvSsQd74OwZ46sVEkr8ZtxoTpE+8vj3P
	 fxVtbu9QtlPOrTLtvEOgJwDe7xFhvy89gA+Fi9MIWnYCrStqbIeee41LLr3O7FtnZR
	 luL61q1tMpNlUKubEBbTPQQon2jHa0EAZNUpKtY3oqIGx9rW2FvbX7pQqNW4khhGye
	 BJNmzvhhqEXLg==
From: Sasha Levin <sashal@kernel.org>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 6.6.y 1/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options
Date: Fri, 13 Nov 2026 14:10:02 -0500
Message-ID: <draft-0012-remosnacekcipso@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFqZXNtKr5dkGTHu96et7hvWHvXKMTn921mMcfB6CMxcsyGxPw@mail.gmail.com>
References: <20261109201138-failed-6.6-1f1f8e8c5176@kernel.org> <20261112023938.1396308-1-sashal@kernel.org> <CAFqZXNtKr5dkGTHu96et7hvWHvXKMTn921mMcfB6CMxcsyGxPw@mail.gmail.com>
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

On Thu, Nov 12, 2026 at 3:45 AM Sasha Levin <sashal@kernel.org> wrote:
> Friendly NACK (for the other stable branches as well), for the
> following reasons:
> 1. There is another commit fixing this one (6d25ffca055a ("cipso:
> adjust cached option offsets when removing CIPSO")) that isn't
> included in these series.

Ack

-- 
Thanks,
Sasha

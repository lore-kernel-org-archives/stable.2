Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387815;
	b=1sK0TH4nxrGIcGwGub7mCfxe6G+BBiAlzYCvFdyjbH+RzczB2eObMUQoYRBiFsX1Km0d
	 NlKXOrwn2g1R38GvpxJX/+2Gspoi0Utanp7LB3kn3cvXaVeDY5J4YehXDY7DA5A0UvGLa
	 JK/lDktjNPXRulrQTQxYEMEsPmbugldjUAKAsv83NlMMaEHuXxxrwqw1ESiqh0xSS1Vll
	 WjXfHPWq20xvqrjAKLz9IleK+Oiie8IUmGXxCyrXnFrd9gJKbogt+tr6SGPwL8Ceo5uxK
	 6eGM9VlM/y7VzfC/obpWHzsQciY0ksJOyi4VaS2506s8LnqX3VUQeN2thbpD/yq/ZuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387815;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=XPc0ymz1fegnjG0/xfOKb+0xJezyhsAiBFRzOUtO/Jw=;
	b=z8g6U1tEdLqmtVBLWFptbj52YsZYWwO22G8RvUq7FhVjwBypu4+QkOm+Ntvi63ZrKdqL
	 jfwRujayr5pF9OySJOCsN/FQM3akxZtHXVNbXPzEoz6/lyhimy3W1cuzRWZzO0ap42DY5
	 rMvdQhQp8IBO+Ce4gUw31QldK/NKeuAajl2Jzu64SzuM8+fCC0yCi1RUtUP8La5Tv4UQX
	 bpuw9EtT4rW/n0oSBxfe2LhiSaZ8Pasj6oL9byltSl6M+o4l3vNY7BVD0/jjcC3o8DzD9
	 NCxEy51nbbt7Dtu9iLxDmFDBUVwyVWTq5Wj3B9U2Itp223KYHyyDm5d+S0cRh4zdnVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=innora.ai;
	spf=pass smtp.mailfrom=innora.ai;
	dkim=pass header.d=innora.ai header.i=@innora.ai header.a=rsa-sha256 header.s=protonmail3 header.b="WpDYFL/R";
	arc=none smtp.remote-ip=185.70.43.97
Received: from mail-4397.protonmail.ch (mail-4397.protonmail.ch [185.70.43.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B7606A31A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 22:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 295B7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innora.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=innora.ai header.i=@innora.ai header.a=rsa-sha256 header.s=protonmail3 header.b=WpDYFL/R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innora.ai;
	s=protonmail3; t=1795387813; x=1795647013;
	bh=XPc0ymz1fegnjG0/xfOKb+0xJezyhsAiBFRzOUtO/Jw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WpDYFL/RvqYDiOoLoHnrgoNwtt5+ie7qbhA4+Nca2C+w5QZW/JuAbRrXmKzIgq3wr
	 SHywyO6lpyg4XPSoVydIIWiuSOPQANXEYzV0/B7gYjDhbXGMULCFvXqRsHlH7hyVkM
	 8sNkrdXU+WUaNlJWNroABEYKy5fog3tQQTGdv2tP+asYgI2epzDpCaP8lJpRlmo7do
	 l6eQYGJRLSd8MOajCjQD2ENmHCzf11ujAO8HCE2uX+SrVTcz90Sf709FsBQEhWYu3o
	 yGH8dMcnlP0aRMv922RmhRhmHhnZD1S0RJByXxlMVeS8/dhXCZJfUeQZ1M0BLZKQ5C
	 pkHv5R9xP+4OA==
Date: Sun, 22 Nov 2026 22:50:08 +0000
To: Sasha Levin <sashal@kernel.org>
From: Feng Ning <feng@innora.ai>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.18.y] staging: media: atomisp: use array3_size() for overflow-safe allocation
Message-ID: <HNu2kNl8VPZydoqH1v-jjdpwhELQ5PgOrhTLBHAG94OZL8Y393wS1UGm0BouUGOfNbnCk7LKjYChyF8iTO6UkikpyRq5TUYZ-51-nrZgMoA=@innora.ai>
In-Reply-To: <2026-11-21-1-daily-reply-0014@kernel.org>
References: <e4e67ea4f7d14636a8bab81909764adc@innora.ai> <2026-11-21-1-daily-reply-0014@kernel.org>
Feedback-ID: 140578448:user:proton
X-Pm-Message-ID: 900d2fa69f7451edba3af1c20382844c02e6ff55
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2026-11-21, Sasha Levin wrote:
> The code is fine on all six trees, but please keep the upstream
> changelog of d178c7ca8fef unchanged.

You're right; my backport note was wrong and the changelog should not have
been reworded.  I've resent all six as v2 with the upstream changelog kept
verbatim and the backport note dropped:

  [PATCH 6.18.y v2] staging: media: atomisp: use array3_size() ...
  [PATCH 6.12.y v2] ...
  [PATCH 6.6.y v2] ...
  [PATCH 6.1.y v2] ...
  [PATCH 5.15.y v2] ...
  [PATCH 5.10.y v2] ...

Thanks,
Feng Ning


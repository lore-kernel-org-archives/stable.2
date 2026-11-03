Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717552;
	b=dKCzEjCpuilufBB/S7HfjxeRJvKW/bTlOA39pFkw3k8spG9d3VAY5gzkMBGZ9ownwgrO
	 tW0EaDZ32yx6hwRYQX7cYj0BZg2khF2JO0EK4kkSfncgS95MPD6AaYboYbIvjeIgaTTOD
	 +p1MGh/w09wkhh8EDYVVa9VEvIsNePQKJG5AyScMASCqSkRfEvY10keovDtZRYhcv6aCG
	 8ECZNSz/k2B7RE6nWGqmJxw8FzXzPaqYFrec065DwE38wAuREr6CPC0SbtNKU2XI05BeE
	 b2oMeG++VEjGVKCqRyK/J+/TPronXH1l0FijvbkDP91Z9GxviUCdgbBgSH4O3+N6pgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717552;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kAub1tPkaiW7ickeMvkeoo5WLK9wk008ZxVdUkzf0oU=;
	b=Ad4a2M8E6l/uTCk8GZlt7sPOsPwQ4Dag0tZwRPe1841qkS3riGugassoTIbWwzB4wuGt
	 JddT+Jq8USZjdng5/44vKUuARk9/mw5Sb5YFwb59oAEYotZ0VzXVgpWWd2ziGPi/vXiju
	 O56FyW41j/a2zbuMOEyNtKJwDyy7rLEiHugbFhxBa6y4/xKfJHY+SiOiCbWYAOp6MlnX+
	 i6FROQ+ojYxQ6YSVjdYSQ6kAbcHA7HhUJ27p1We12DqaftxQkVRNDKybsl51tYTCIhoSo
	 CpYYjj7r3sAEBXiY8Ee8Pf2YA+Pcc/luX4zCyrq+gl0672EcEvGUp8yjOd3rVt0l4aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5MlS8u5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E9260A3836;
	Tue,  3 Nov 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5MlS8u5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB211F000C1;
	Tue,  3 Nov 2026 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717552;
	bh=kAub1tPkaiW7ickeMvkeoo5WLK9wk008ZxVdUkzf0oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K5MlS8u5brJ0kGLN0lIfLSvU7p/qmEZb8ZM3VjITJFzjSUFDgle5gk+2afjP3cEAs
	 LtLlYql5rujbS6RXni1a456Wiy/EPjW9XR2Zg8NgsswUGEll5z7NVv2jU5jFfQ2E9+
	 GhFvw2Qsb9IBypnT49GUI9OHiSNrdYv7QasfjEuDGhbbn2fIxSLp2dZ41RYI8nO5t9
	 UnfU2XwFNs25xI9PbDgk9AiS7lzKHBzBeOJy0xEquVZNA9CU1+/+Ahs2B3HhSgxDHq
	 1s2BgTZc81A8NMnU4JSOAdyTFiKZxKRQweU7jSbyFimkwCxHKS1mNVNraZkfc6oPmV
	 xkQCY5pSQkLgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	seanjc@google.com,
	pbonzini@redhat.com,
	kvm@vger.kernel.org,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 6.18.y 0/3] Backport nested EPT violation GVA bit fix
Date: Tue,  3 Nov 2026 09:52:04 -0500
Message-ID: <2026-11-03-1-daily-reply-0016-re-kvm-nested-ept-gva-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030103643.573356-1-doebel@amazon.de>
References: <20261030103643.573356-1-doebel@amazon.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Backport of commit 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT
> violation GVA_IS_VALID/GVA_TRANSLATED bits") to 6.18.y, with its two
> dependencies.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha

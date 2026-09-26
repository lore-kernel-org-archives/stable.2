Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC4B367B7E
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790438539; cv=none; b=IMNzASnlNvLwGNAIu0oP4/f6YznzIYfPkILaY/3cGUrMlXf3yqdT3eTYeX1QrJ3TcDetIhUd7md2AhRxfQ+m7mYUwwG03eZSStrGNV5NOV12mI+BBPju+jHuyXxtObH850BJ+xvfZigY+s+4qKMeXJRcjtxipgUNkLFdgMq9RlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790438539; c=relaxed/simple;
	bh=39XEBq1MI6OnsD9yc+4TxU/OT9omjbn58qrqcxRX0Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXcK9s8+68Vvz71OOPMQUKjKgtoMJgdZptnMpj+vILEzH183WAfGhPAl5ppBEmUEZnWW+pbc7IR6C0WMotgU7LwbW5fcIudiOgvMmYlbLXxPGkxAbobLG6Eitdbccl+uLzVH4IuOi7AhSV9cgmMO3Xx5MPm8HgbuQ8FZiVNl0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=uTvmV2jA; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="uTvmV2jA"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc79f8a6170so116968a12.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790438537; x=1791043337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+37thVuHZ/gLtuhuUGe6FLXA7wHfSbWyBu28cwLiRZE=;
        b=uTvmV2jA6qxYji/GJOLPDUoGBnNY6O8G55vynG4Y+LvaWeBE87kp//aOf7PfoTNPR9
         VuwQpDWhMH4sKcE4iCmKfoPyHXHRR/U48ZxH9ExkwQpF+Qy7OKRxxOl51UHsmcno5BXG
         QrjxbkWl9BfCHOsfm0qw0COlZ/Iq62AKjVIUVMR/mUgcO0wTZPZYAa1ftvYw+UauFVsx
         WwjsP/FtlpV0aWz71/znpH2kLGGqXWanFE/77i464KHYR6/wYXXyJ7RXPy18Rq6ir5WJ
         iNl5JaksLY3kUonCV7t106Xr6mH0eLhQCvVGjrBg75erP53SXPFlSYi82C7oDh7Q+MFI
         xf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790438537; x=1791043337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+37thVuHZ/gLtuhuUGe6FLXA7wHfSbWyBu28cwLiRZE=;
        b=hiZn05c/Tsb3JK0Ky5VtZ8dJ7E82SeuTtdI1fVLaXp6mkFFmcH/4w+d+/u+WdyeSPW
         Zo4O7wlusEHvugEH0GDeo+gXU8akrL07y2WN7L8t4UAf5LbIaaasgW++tsVUiKAIbyFC
         HhDCbzimEuFtVu4s73KuP4LJdBg3rdEWBFyUGt3Y+5IzSKEXjUM8BL/pfP0nxhbN5em5
         wzPAL8PWjpBqRSnq7WKwpHm9/oJ1UvKYCtYN6iYA3zFsYgpUizXAxEFGy1OaE1gf74ZC
         OfSFAQpV0YfT67SZtRigeCT8VB2ouC0PUSKHLrNCNwBp2e49PJJV+S1TvkXqr5UL70vF
         Wxdw==
X-Forwarded-Encrypted: i=1; AKwUvBxOxOyIkpqERBRsHD1ddy5oe/Qr3MXMdtpMnQT6rKwdwe1QY0y8T0LtFdEdVLcpBC6R0+o9T3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbwkR/JUnWE3T4uxxkyLB2J0wwADt7h0CSReTdRE4n+7r2+4p5
	ex69GON2U0CknxEoPszxvrU9978lr+kDBB3h9qVrQqmKe5LpT8qN0SsSwLqWtZjZTyU2
X-Gm-Gg: AYBFou3CCQBrm3rv3zWL7IlPb+YHX1CK5k7aWZyElPRxOKTahm2Uk/p/Hb+y29OXsfD
	jYGf/CQmrhSbEHxwBxHq24aP/DlNtQSqOqN2a1G+ASUFHn0+mT+ezQcJppgRRkzYvHiv8vCMzqD
	AlgLQJJNvTkwKb+2ptDGjsrah/yh7OMpsUusV0tuixgg2Y9VsaP3RJWsbv0OFuaPT3KSVlhYynu
	+8bBvvIc7W0SGwxKqBzhP9BrVHKbVRz/1KzZtPi/jkdSicjeuR4RMnkqtF+tGlK1yxIaxAOsdl7
	vBIfjmYJgcJkzGtj3/bqyvP0iPZjBoDfZU/yfmo/rjsrp2IycdO2Tt0a92aL2KC3YX+TT1cdaR1
	JqYnbmzF0fw7CYd636sOEJOuYlQaTB6uf3B8wT4Y3+FhMsRELPgZXvJ/J5y9UiF6zagzg2ouwJW
	YAUptEt1OX5srtnBcYaAv1efqS32S6iA4nY4sYrAPdPDhMAxvMvUrQrjr5CaTeV3jA0rZWkMESp
	QL5keqSkMZubdTVZLwdEP9mKXa1JA==
X-Received: by 2002:a17:90b:4ad2:b0:3a0:b312:1fb8 with SMTP id 98e67ed59e1d1-3a0b3122489mr4434989a91.6.1790438536817;
        Sat, 26 Sep 2026 09:02:16 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9356f48sm10449199a91.6.2026.09.26.09.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:02:15 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v7 0/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Sat, 26 Sep 2026 16:02:05 +0000
Message-ID: <cover.1790427022.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The v6 fix is not yet present in net/main. This reroll rebases the
UDP receive-buffer accounting change onto net/main at a7bfaba4823e.

v6 Link: https://lore.kernel.org/all/cover.1789608557.git.zihanx@nebusec.ai/

Zihan Xi (1):
  rxrpc: fix encap_rcv skb accounting exhaustion

 net/rxrpc/ar-internal.h  |  1 +
 net/rxrpc/io_thread.c    | 77 ++++++++++++++++++++++++++++++++++++++--
 net/rxrpc/local_object.c | 24 +++++++++++--
 3 files changed, 98 insertions(+), 4 deletions(-)

-- 
2.43.0


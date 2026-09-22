Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66842388862;
	Tue, 22 Sep 2026 02:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043836; cv=none; b=AGYbLt14QemmCDVYOKVsgEhdVUlweCW/qGfim0jjscauThWaqf9XpLXBnkGot0Cpc0cby8AOGrzqC38pQAHz46yMptwP3cvP7emi5D5Kh0ykFUtqJA1Mz1wzZJeKvodx0eciqxS/UmHgsEIoX9hgCAM8BsonZOI0Lx7GL5Vl7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043836; c=relaxed/simple;
	bh=/69pLndjWH7kxc921oPFmvamDvNpin/J0SVt+oCcUKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1pld+CYZIjOG7LpanYws6IHmRiFIVbGMUqsF2JVxX4PWJQPy7XRQDNECiHXSRozudMP3rUkbpunScNNC+QsOvIJHNVYLKZT1b+9rYjjhWU6OhnlLxWsmjJNh2LGrfKEqcvXjMWBC/vAuADdYqPrBWOkHu6hsqkXAKXP+eOWWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN0vabS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN0vabS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7268E1F000FF;
	Tue, 22 Sep 2026 02:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790043835;
	bh=O3tot3M/nkB5OY5V+6AYVhaJRB+0S9XMhYvRE22D05Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RN0vabS65L5zzt0epKp9ARDbk+7nr8gHeZ4CHxeyfikQ71AExV4OJS/4i/exGuINl
	 s68BgWKS0h0QwDZVGW8aZGfnBkAMDieZhxCZ33fcZz7tZhpjFQHY+nJrDQHBkLJ3dD
	 jOv8gBG3I6rqh8CfehHmKfiJ4rmX+oMfvvd752rMvLc7fV8YtyoJq4CRDuN7BvQE85
	 d29VkKUFcAXpvkoCFivfISrH57orCd2Oion0TKbLvz4keghMNOoCTeaALc548fUfNF
	 LbHiz95CWem2wFZpJZrcYKvJugZBh8fw+uYcjYDKIiqe+IOxZKx2ze2F65y9hQ8EZa
	 t6BZNrPw9vB9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oded Gabbay <ogabbay@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	Tomer Tayar <ttayar@habana.ai>
Subject: Re: [PATCH 6.1.y] accel/habanalabs: postpone mem_mgr IDR destruction to hpriv_release()
Date: Mon, 21 Sep 2026 22:23:44 -0400
Message-ID: <2026-09-21-daily-reply-0007-re-habanalabs-mem-mgr-idr-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921172640.72798-1-artem@trailofbits.com>
References: <20260921172640.72798-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please queue it for 6.1.y?

Queued for 6.1, thanks.

One note for the rest of your CVE backlog: 5.15 and 5.10 do not carry the
unified memory manager at all, so they are not affected by this one despite
the published range starting at 5.1.

-- 
Thanks,
Sasha

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344390;
	b=4W/mKAostcxQK3PzfqfLa9MJs4xO05AK5Tt3qcvVf7dUSPS/TF0ITbhJGMPZlcuenUZT
	 9t7KbzqnNZhoYqoVduRiFH9TD0YD9ik8POCn+oTIhoC0p81dhz+U4NhXz8pUZLNN20ASU
	 hzAzOraLU2rx6T5a17SsDxHFiopOokMXUr7lFgC7CdSizU0wnUFxJ8tSj7+/20qFMwmaR
	 77Cxh0l6immkNShjTN2/eNqVaEjoGm4Qr3+5GFK6EkYZkD9zo/+5GenwpR/N8rQwALxh3
	 p6bdfIpRNqA8JG1KPanz+AYrXwLSXwsayOZCSSHIrgqUYOEmAPktAg/2+onC5W0SjbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344390;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yAum4YEoEIEJ6BUFQDVV6qdx2C9cyyRluy+sCwncPAY=;
	b=VfUyT1rbbw8pYvZd7M62lp3JQd+8rQhTY7wx/q9jvF6UAfOJCR0yXSvFDgd0j+Oain9o
	 aHvG5IhHu4ISzW1Es9+likcZywn2DGesxUU5zBwgSYo6Q3nXGeTEip6Z4ilAwn1Rb2u8y
	 Tmz2M4vKBXl4y5NgNya2ZkGB34Q7tzml82c5QwHAV86B2qJRGx8EKrvsm5NMRrFbrOn+b
	 ydZGzYNQESdq6lSnVDg8uxwbNwSdBGe9n41ZtepQDR+Q5sFQN2eBnkQiV20X8+T9QaHEm
	 Lc/pmVFC/LtWTgqElo4GRAHfIp9/vLEg6XNhtT3Xe9tku+v01cvxd1V3RAM1evZlzXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJn0Ufvz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD9606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJn0Ufvz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75411F0089F;
	Tue, 10 Nov 2026 20:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344389;
	bh=yAum4YEoEIEJ6BUFQDVV6qdx2C9cyyRluy+sCwncPAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hJn0UfvzRQE5Zp67h4sSUZvjv9eq5iV5ucRtrbSCn4OJUwY3hHkU98jb0aaGcfbt5
	 t8HRvDEBmE1ArixxRuA5Os9DDXJbH90KQYiXVnDYtyUNpTUmZ9eH2oagYSg0Wdc14G
	 YptH0hyVBDoH1xwXE4k7E+IY1TcqhA9fZ2eLsJ27ls+kSITt8ddoR6NqoKPlYIhFeK
	 zH9hHAtb5yeBwweelcZdRSD9QPaF3VZ1dVJ/ZWb9DZh3RyFxuZWnJWMeK07pUV1Hbk
	 WMWsfniSDsxk2q+4RK7iiafIyftFKTSsjYv6vPZUnjghiGiaAOdTNh9H3y5xfbRU/8
	 IrFGIfii84EVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.12.y] vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
Date: Tue, 10 Nov 2026 15:59:12 -0500
Message-ID: <2026-11-10-1-daily-reply-0016-vxlan-nh-fdb@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110164904.2294593-1-idosch@nvidia.com>
References: <20261110164904.2294593-1-idosch@nvidia.com>
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

> vxlan: Stop rejecting dynamic FDB entries with a nexthop ID

Queued for 7.3, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha

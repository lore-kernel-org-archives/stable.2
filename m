Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537221;
	b=h7YGMB7aRi5GfgSkVHFifZ9dChFOBq466IzZfSFgms+6dX/yM/E21KH65js5JyljJVQs
	 WqdszKTklekePiPR72d+wrVZW7hwCVaupuzLfPFah7bRT3c0sT3HuuEIICqvmYIYjPSDI
	 aSuFB9Cgu7tt3vieprgKGwMz9LZ7Z402Ad2n3tfZ+nELJe9yUAeUqoXGo0fy+QGUtM7ce
	 3rh0JcZrOy0Yti6CywM4FHDS7YxwPn0aMj62ceD3+lv2XC5h9ZQyBeg53BiSy5wfxf7ZJ
	 mxtBNqejmJ0LEGrvuYniXC0Y0bFZrSCFCZF58aTtwgMOnyh3kpsmAZznqSHO8FuBwtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537221;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GNtMBA9P/YuD0CwM1enL+gQGAVdvi0+9oj8sCTa6uRI=;
	b=qg6/h7WsKJRcTKfWAZkzgGhrAX/2WMV+W8l7CwnXvO6xjH1GV5Y8fmCs2vN9IFMOuvxE
	 6L4oZ6oI3/rY4DQGo3t4q2xO1CwPOXHp59FmBJdQ6oFvoAHvwnTQipSbg4Tjenmd2dr+j
	 rqzONamw0PIUebCGyC8ZiRLenSOKTlgaxWfAupGlGgYRzVjzEA9+np68XrKpfhLCZ8uwQ
	 gJmPN5ppGcqgTiofhDmD7kcWhGrSvnDOMDIJ/svXQAI/kGkHaBEvuAASThKlQbOpu88j7
	 nGnB2apg9zkjeilNdWR6dE6Leezalqwe1sbXSogjOCp+x322CHeoggmj1ujYrX0IzxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S+/CMHYl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C24606A33D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+/CMHYl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932CC1F000C5;
	Fri, 13 Nov 2026 02:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537220;
	bh=GNtMBA9P/YuD0CwM1enL+gQGAVdvi0+9oj8sCTa6uRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S+/CMHYleKCm0sYUi3Bz5giZ6mJMsTxdM5y8vgEZvOLzLx01wmAX1LXj7XZmsUIE7
	 ph9zXsCfpTXrPlkWM3zdcNuLb5mB3tO2yccNQeW43hcfHn2IjoALFOJUgIC/hdibKH
	 hq7P9cR+Q9Voolq1nvbB1aR8Vu8+R9t6y9rkynyXAbeSBKnoy1jQFchafY2Xf3Tatc
	 luGhxNb2zdDX3iuVt/xF07y5QYZoDH4GMfw43NBaWmjt9k6wRy0n6l1vEPcTZquOPU
	 KjbyrKVX6mEJoNHN3hpEE3Yg1bvIcO7O2x3I8BM8bJDV72QS4dFoy06YHoxKuCnDA3
	 utzmY6VaCQv6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	Martin Belanger <martin.nvme.dev@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Subject: Re: [PATCH 7.3.y] nvme-tcp: skip TLS control records while waiting for the ICResp
Date: Thu, 12 Nov 2026 21:33:20 -0500
Message-ID: <daily-reply-2026-11-12-4489291895@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111-icresp-stable-7-3-v1-1-c9157e951b3f@gmail.com>
References: <20261111-icresp-stable-7-3-v1-1-c9157e951b3f@gmail.com>
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

On 2026-11-11, Martin Belanger via B4 Relay wrote:
> [PATCH 7.3.y] nvme-tcp: skip TLS control records while waiting for the ICResp
> A peer may send a NewSessionTicket as soon as the handshake completes,
> ahead of the ICResp. nvme_tcp_init_connection() fails the connection on
> any record that is not application data, so such a target cannot be

Queued for 7.3, 6.18 and 6.12, thanks.


-- 
Thanks,
Sasha

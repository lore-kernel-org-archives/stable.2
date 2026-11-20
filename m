Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207176;
	b=Qln1y0xwNjn4uqpax+3tLP4sH10zTk1XYe4ZbCoeymgFrHxDSQauSKwGYhbQ1DhXQ1aS
	 FPcmDcB9tLYm2MYwDiihjyIvGjsPPv9/F2ieMJPH6dUMAxoueGg17GLkCEI3aLdPg/hrn
	 PaSy0RyDg0X2vW88vQ2UBxXPccV9sgXhuBqavHNnBgM7g/aNspFRJWoTBDRVlp+3a9zXe
	 o/NRxTPS4M5e0v8PM8c4YpoUFKe7eQkq/wi6ZMSXw2rXKJbziE9ZHtLHzHQ1aByyVKseG
	 QyfNRodjlca4iMgJHfbvgCgZXCf1OI0ryKJCsDtAn07l8ZooapqMBOd0JwgOStKVrDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207176;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4EgKd54HFjmRFZnRU9ZR6qePSH/pDqL5bvuWPfrN2X4=;
	b=GFvQMhh3zZD6x6Kel9FBYC9hM+IjM2Be9hfnw07hhAK0Nqg0HQUmYeBV+3I148IkApR2
	 R+Suq3ZCekJmYwajb2/+l1KOPSWxN9IjGJzaztzm8dvGnuGPtd7UjaAVXiqjfNC4pdTgu
	 9Bz+bdcewp6NsHNb2thTYP32XWH5SJ1KbbYTJBqOBJrM7O6KRdWzvi40lg9N/dwclimVA
	 Kpi0E+xHnJoX+xRtfQLxlMfIUEN8ZbH546sDrgOItcQNGALagcjr5E4/QAi1PvHOaWqtf
	 rfUS3J4Ctq5d/AMOQiBoQup+jzDF64dhMSkLz0PizK1b+/XNQqe5WKeiOKJ0g1ryQjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3lpWTc5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81890606A6C6
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3lpWTc5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7914A1F000C0;
	Fri, 20 Nov 2026 20:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207176;
	bh=4EgKd54HFjmRFZnRU9ZR6qePSH/pDqL5bvuWPfrN2X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y3lpWTc5mI2r4H4mWua2IBkAkmRksmgIvd7rkmXd1zRF1lW39Rm8AQs30gnlVYs6Q
	 LZiuwqVP+R1UrBfi7FzpaW+y4p8RtrgumWYdyL8G4EHNQLjPniw2X13RzLGTqRBoqO
	 4IxY7LDIhBqBWleqaTOFgdnlXc5jAaw8qGLyijbOaUD9Cc2KJpvE2DyLl3d70CgfQ9
	 RPLlPik6YiUiRc/4MQGaEZrK2wcpER8UkSoLmTGXsHOIqwhcFSK1JbCnQqE2+uSRMw
	 H1ELvfI2ZSlBOzWNhhNAcqby19DNAQ+9RbFvuEAsoMWJHtTTp6TXOhm8Btk7y5d9Ed
	 nsHk4RiYpD31A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	zhenwei pi <pizhenwei@bytedance.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [PATCH 5.10.y] virtio-blk: fix implicit overflow on virtio_max_dma_size
Date: Fri, 20 Nov 2026 15:38:57 -0500
Message-ID: <2026-11-20-1-daily-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1795137257-10563-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1795137257-10563-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
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

> This may lead overflow, Ex (size_t)4G -> (u32)0. Once
> virtio_max_dma_size() has a larger size than U32_MAX, use U32_MAX
> instead.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

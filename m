Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804609;
	b=dB+cnCCPayJqAmbt/IhugMsv1nnUkTdpHvdcjY06X8J/otaaeedAzkHJ1m3xgIZ7L8ZS
	 P370Q8OBDS1+57SH8eliWQ5mP0IImJqy7jEQGa4yTcSQkqAWCKB165LqPXhs/xEBqby6w
	 yAf84+Orl/YWpnVZBL/BNIbrDySNmJBn+fCLZzk0QGuAMfdZd8bOnIQOJ6Y1f4nV5jWcI
	 DG42SoLL6wSxTZqdl6hpF8jbQ/zdC5Jj53faEIccwmlsVwJPsh/mPIedcmzRCUJDiQBtI
	 epAFj7cu+xgmGsbPhH11X98SYf1rNt8o/O+LXnD+2bqvXiojGQ07wl3C5NfHo8GD2Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804609;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+i/k5lmWYNUo8Oks+yv0/1IBxz1D2YKU4FUdMr9yxDM=;
	b=P8RAU8PwlyADZnzJ+wdD+Fnk6Li35KDyqBAZVixgak6FMHa18j6pwykuPfxscr/5cZil
	 kgXcmFL/D1yJDU6B3HN7ecY7y0feWD5qxTkgczyjX9UoR80tqv6gMtez2Q6ENWOzy9Nyf
	 TrKrQkKZjarzRA8tcdl6i1f76FAL6ThVCy/0/PuQqN8QPURwltikBj1dMdD9fHGR8LrqF
	 FJhFLXxy5fB1a5kiQtxHVOW5zpVth774JAW6gjFvnLnTbPv2l9vy7P1Z+6j1fT58KZQBV
	 RBiDA7ac+TGJCNi+VwEGYA/Xri4cq87Uq/BKUdUVYgOr0MCNQ3FreWzvSSQdMnJ4umg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVW02NFI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEBE606A332
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVW02NFI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68341F0093A;
	Wed,  4 Nov 2026 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804609;
	bh=+i/k5lmWYNUo8Oks+yv0/1IBxz1D2YKU4FUdMr9yxDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CVW02NFIGwx/eIdERvLPf1BiKVD4t74bZTUfxROaB6zFt4ONZKQSg8LYlXraHtd4C
	 9YE/E+AFKeoElSk7opuVsSa7U0LxGZNUCEvgi7YedT/RMnpT280IEIffKpKxK1Ytv1
	 /3ESx2fErjzM8gNU7RDeVtEuw+3D2XJwBVUyg5GX/WXuANkmcbmFNy/frnoz+uhEkd
	 mSXnEKLL0Tsd7ZCidOuhw6VrfuGc4Blza0Jw4CnHb+tYo2LTFCbTEQrUxmXhkI26i0
	 H4x7Ccq9bcUcY9MBmjHzMtncyBnl3k4qA4XmLi7Wbgkg+lgYkIOQ1wxMjU2OrKzFiz
	 fnYiG5w+/NYWQ==
From: Sasha Levin <sashal@kernel.org>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Subject: Re: Backport: FAILED: patch "[PATCH] ksmbd: validate security descriptor offsets before pointer" failed to apply to 6.1-stable tree
Date: Wed,  4 Nov 2026 10:03:11 -0500
Message-ID: <2026-11-04-1-daily-reply-0002-re-ksmbd-sd-offsets@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DB5PR08MB100620A5BE5A4EE2F978D001AFD682@DB5PR08MB10062.eurprd08.prod.outlook.com>
References: <DB5PR08MB100620A5BE5A4EE2F978D001AFD682@DB5PR08MB10062.eurprd08.prod.outlook.com>
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

On 2026-11-04, Ratnaker Gautam <ratnaker.gautam@kuleuven.be> wrote:
> The 6.1 tree uses a void parse_dacl(). Preserve that interface in t

Could you fix your mail client and try again please? :)

-- 
Thanks,
Sasha

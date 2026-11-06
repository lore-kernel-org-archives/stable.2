Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982960;
	b=qxUjnt2KV0uSisib/6U1nh7Qh79+9LkAMIT78tAgX0FeCw1/m9miRGZubsTGoa3geHXM
	 dLyWQxeeq8P8kG4kN8ELDlra0eKiQbodUjSZqJFM3cCaAz6ZlTjzb5SrM9f17pgH3vC8C
	 4vshGNGDOrooTme+P+f2R9usqgkjRLWp5mpmkUDTb6x8w/V0FseBVoqCBQxSroPbFcPTE
	 l+uUclB1NIrp4Ro5FNh0FJeu2INDTD0Z1q7PYZ/lTfgbxwDGpGi49MDnWa8rSdi3XDBu9
	 iNIOiYTnnikGJOLIgpKOmIddSYwasD8+rjF/KxiatVFWa/e53lk6QdgGmyI2eEE3OdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982960;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3oeqBU35963Msw0BOiqHb4shwFE42DE6caEpxLbV7JM=;
	b=aMGFR2lElxINV/gSpbK0/dZkKAXVeCTVdlhSbGZZU7I2S0UPpbLKSS2+GE2Sw82Y3bW1
	 Z+mhce3Zw8qir/Wh2CF36uvOjsS/todCujN7rZV9yaV2uAfZ3lhzvq4BPgoGph+qadPnY
	 EGyk1W3AO4CAtkyNOh9NBPB8Bd33JgwYTIZdv0f/Jt27/rP9aYJOZGQNdhbeGTurEcwjk
	 3iBlx4kXRXQBxCrJQRWhb5fCQM7KQJugBbMSTnlheAaS/+OHtkA8suNqE7ROEEhknAPe3
	 8hBjP3X3PqEnouLE0X5IxkMybimXiWpTIjoWHJaRP2Lfi309KVXV+4kOMNE9tKOnmfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3lVL1LI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF6606A335
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3lVL1LI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4600A1F008A3;
	Fri,  6 Nov 2026 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982960;
	bh=3oeqBU35963Msw0BOiqHb4shwFE42DE6caEpxLbV7JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a3lVL1LIocyWN3aUGqRlq3+qaceHFdxDsrKBvN+DiiN9MlMEjgm/fFdQnAnCkyDRw
	 155iap89xRamlFo2CfonngznzBha4o1vERd/jx1xIQvk3hyF9NWeBD0QxWvq3xATF9
	 zvjJcgk0O+6TdNHmvSjSZWrWJLo3woYCyfJBWH2NM6rH6ro94z4RlIyBVMqaH1gXbl
	 mE96CN9zI+L6CS50RSFtJfVlyDtnrknMNi6O1llXVEsHzSlunevNAKO5+jMyT9abIb
	 yPSamrDzd7zCuhnvzwXCbTUduCN+Im4YQWJbH9dT72c+h1w4E9Pvf8K8yQqn492mFN
	 yjdSFVEoU5QmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	imv4bel@gmail.com
Subject: Re: [PATCH 5.15.y] inet: reject unhashed sockets during established lookups
Date: Fri,  6 Nov 2026 11:35:38 -0500
Message-ID: <2026-11-06-1-daily-reply-0003-inet-unhashed-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <au2WK6rhgkDcs8eu@v4bel>
References: <au2WK6rhgkDcs8eu@v4bel>
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

> [ Upstream commit 4e2b3ef19e0e04adca38442f07dd6bc93c712bf1 ]

Queued for 5.15, thanks. 7.3, 6.18, 6.12, 6.6 and 6.1 did not have it either,
so I queued it for those too.

-- 
Thanks,
Sasha

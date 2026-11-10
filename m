Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344380;
	b=NU/yKCmvYd4z+lXeiuZhWyd+mIc25DWtg7kGmP4+Z3ysMwST0fqSyeXhBib5G/pEX7PX
	 JRLCPW9ld+bUMNx/6Me2OAxjM6sFVXhCful2hi1yoIha30hbj2dfwDI6HOmDNmaYBkTgw
	 2Vq1sa4N6u672+QugI1M2vhLX4ua6hJ4fur6wKuTiTKI9HgMTHF7tZ2QyfIRc5XEMb+F+
	 e2JRuFOMRXFk6Wj8OKHuibDRwB36yov73qkXTtPFLyc2uINN03670v7rH2SwWAB+JWskz
	 a7nLZD3eW5aIORBUXRXGDn0KW2bEGNXHoOlC8XTBX+7XA5NPOdKvvvuqH3XIFU7cV6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344380;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rEhyH04+R/17OYOFhWWs0CHwxDxLEw5dOmSsfQr/lLs=;
	b=CZ/1hkXFfwMC2cL/1ogoe58qCnPAmXjvEgLRO64kuEbHaPihkSkvR6ez2r3yosFpOEQJ
	 ThlnwpG2a14C/QViQy750Cd8p9kCw6NaGPi8KTXLR1P113n4/2QSpgb+7GaiZp5tERb4o
	 xyqxqs7RP0ZQn02ygXDKQQKisTzcBkKxiZuGfFe3TAuDv29sj83GehkGCHoneYJguZKvt
	 tdj0Tl0f9lkWr8pAn3vCY9lVWKR3Va/gpM8p7jhPCtbS4Fn1jIw5DRrVVuZDhjOYp9dvR
	 vVpDGtptAV8tEcPctSUc4MO+KS0GXKcpDk/01jrO5z1Ldzxlwz4OLvXaCk8D2YO7uww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ji+hOeC/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B302606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ji+hOeC/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1231F0089F;
	Tue, 10 Nov 2026 20:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344380;
	bh=rEhyH04+R/17OYOFhWWs0CHwxDxLEw5dOmSsfQr/lLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ji+hOeC/cq6RVi5dclLcifo1uGmfcOvQAFV0KAxXjbTtwOEbMBxkFNKNEa/47m/Ll
	 A7PZeZudPOx7nIghEzwuSJ0VXL9Y9znWFTTWqa0ciJjoiFGhH09AABFQT+FJHQcp50
	 SePgWSRNj3dFLmgsHEnwd2lKIJgrp62freHNptPmAM3dtbvuMgmEsxDGA9+BtIV7EA
	 dfkB1SChABZY5qr2BaTg+Ea925ix9zRtPv2GG4fnDjA+aoRwgp4CQ/Z+1GrGPmP/Py
	 qCFUaTpfKPuaHg8tEGvDt1ogaKZ+/2q+tkKGNQv/ubTnbw89BAwvc1JG64juDxYBpA
	 FawXaKf6EyiAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH 7.3.y v2] ceph: clamp the inline data length in ceph_fill_inline_data()
Date: Tue, 10 Nov 2026 15:59:03 -0500
Message-ID: <2026-11-10-1-daily-reply-0007-ceph-inline-7trees@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110015638.469378-1-zhugl3@xiaopeng.com>
References: <20261110015638.469378-1-zhugl3@xiaopeng.com>
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

> ceph: clamp the inline data length in ceph_fill_inline_data()

Queued for 7.3, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha

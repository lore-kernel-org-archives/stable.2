Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479118;
	b=HCBYDlWoW9q7+vhZH6SGYvHoSQg33lirRiOHuhhnPSTbz7Xm97LNGEBZzh19RddUwt4h
	 GojxVS44YNbSG4qn525Rciu0WsJU8+7I5amdOMgGWTyxuaXPKlBdANGVMxs7nBkgG2BVH
	 8oHkD/MNjoqekUqyXR/Vy2167sHbaoK/lH/Rn1Noy6s1EdLo7kINpvQlZqTvjClhHsloF
	 EVIGMaD6toCiOY+u+c6qS5BL9hZ6JNB6/UlUx/uI4uwlbYgArjrCPH4ZySuDvPy+Ss80a
	 ODQ4DRpHRxlOd7AhlxxdHRt2KaEoEN6JBudbQ+LUlA5WIHXJyZnqmwHxlN1KwbA+WYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479118;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yoqPdvjwinzy8oZGCpRPIDilwyHR7FSnYK/u2CTA9Vo=;
	b=CPtPJUY6n3uCBY2NzliW89DGvBk9YXBSHw8lsUP/wCLE9+2Uep7iZXO06BoeU7OTkDOv
	 kXOPlLwQ/1lAjrphh/78ZVqbbcAZMgTWzfPYnDa/QKnjppsnGqEgZcslyQhqAMhygXu9W
	 KM54qprNdKyDVXyd7tZdyvBepbke/DuOaXTIJwF3z51hjFvRBJQljzxOsSrbSBORA/gxa
	 MR1fS6eHRedtbGtJMWxMdfGajpyuyV8V9TnURtu+0orqkYMjEvUn2CY5EhVdFc+NGbck7
	 Z0PTo1ZMRyNAD3TSIZUZkuYUFCUZvDm/zwSyYPC6lwR6rENfLDeASnaPfzU30spw6GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itPWtf3o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0F606A333;
	Tue, 24 Nov 2026 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itPWtf3o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25501F000D3;
	Tue, 24 Nov 2026 00:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479117;
	bh=yoqPdvjwinzy8oZGCpRPIDilwyHR7FSnYK/u2CTA9Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=itPWtf3oTqcOjl6ABMgGluSHiR3S4rZ0+OUK7rthALLHGINuMwbaTalC69QaaiqCl
	 fwyWnLP97uPEhEB9pxx2+g/u7SUmFOJopQpsPdfSd+Lby0GyrkJA5frD53iG2vEH17
	 REJ4BfRS2j2k47wUFnIK4BxX2uM/jFf4UBe2/YjfMqAUGlld9fbWQLiEfO+H5K0Xez
	 ICrve7XPEuhY1xo92sYA7EN9scjfNTEI4+yahpUrc/y6HHtGIWy4nRgU+hEDxiy3j3
	 gz5QsUke7fbylLwtF3Os0UO4+XhR5aqe8oGusNv4MBiRQQqi4aMF4TI0hop8OFe1BL
	 +9sPnXaolSdzg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier (merged out-of-tree in linux-netdev/mod-orphan)
Date: Mon, 23 Nov 2026 19:11:47 -0500
Message-ID: <2026-11-23-1-daily-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFAa3YDcX=a7PKbX741FtG-tzUZ6ActKC-sao46ah3_r4_ZzHg@mail.gmail.com>
References: <CAFAa3YDcX=a7PKbX741FtG-tzUZ6ActKC-sao46ah3_r4_ZzHg@mail.gmail.com>
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

> Here are three bpqether fixes merged in mod-orphan today, for 6.12.y
> and 6.18.y. None of them has been sent to stable before.

Queued all three for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha

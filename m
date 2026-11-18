Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961378;
	b=P1ONLUdvD6gfp8u26drVFVY/GPuublQrDrdH4prZ4o4MYpVyg3UIxOHl7jMa7eN6R0W/
	 bSe0m2/bdrXGBbGFat70K3R6JzF9WQ5MrG3em0XjyF3sxVVlesHnLAsixDGhw21+Ddzd8
	 6BexZNZdIJUh5QElZ4EroJFXEXO/3BxEW0TeSc87mPXt6U+NztTXBzQ7VAf9MFOCZ7IjL
	 Fb+9vLTXW+1T4YQVn+XBC4ZfAY7eMIVn/yYDUL43FGBIS77qNX9I6I1e2PpnzL4Bb+5nD
	 Zlzgdw0OtasXc+qX4KEISD3s55nFNF+IaQLSJJkDIjnSdlBpdT8nKJRvlPNwWvwwI3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961378;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4bbODQ8lbn47OYKS3LDBYU7IVB/7EA0DDppuHioC3F8=;
	b=VXF/vGXpb4IjDs2Mn5Fo1qUVAMQhbQGT0EGUOXtn+O1u2/rZwZboyJMJr5MdABJq6L8q
	 0Tt4yUpheS7qwNe3liG6KLP6+wRZ8DozN9yNKwt3OXEhc/JKO7dvmVTaMYH8FyzDwYDTT
	 6CRnrcp97rD942k40wtg8A3wWp7zHIUxKoBoj/r8kxYpX4sGfOCKms4pv60DMp06Nz/Sy
	 5K9sjxMtQE179QnyDEw3E5dAunDZSuOpMwLTAdOg8z6VVfWXkecH+BoZHuIMG3jJTtIsL
	 oVjO8YLTplSSCKpMBqrqbsaxGuMMJ9EGExkWlTZuVjP/dC98+7/GaX4IZ5ieSnBb0xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALA3doDG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C52606A331;
	Wed, 18 Nov 2026 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALA3doDG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63F41F000C7;
	Wed, 18 Nov 2026 00:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961377;
	bh=4bbODQ8lbn47OYKS3LDBYU7IVB/7EA0DDppuHioC3F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ALA3doDGplrt6rvdM0S0w5W5eJ0XShkOelbhJW0pDBopI8tBAV3yzPRfLZZxW9l7k
	 T1/h5Uxi6ckPV0pgkGNCIA8EQ6gbkkmn8zJaaNbtnS+jDsslVHH98Tl4UiMRgNPCPY
	 ScesjaCETi60JZfff8+O2Ww6uZIN5QewrhjQfTRkMUKI8GfL7hFKWjNHBH+LDVWPVn
	 cJQwaPaEUFC6iyga6gotxAOE1JWK7j83xClPEQYIBfAFbSe1Gp3IlehBD9cOhcoN4E
	 2ODTQ22TIh3s7xsQmbpTp/tBtdGb5w9qSYoUmSH/aqjZhDz8VQzfT+fL1VyIQn3+Sv
	 KPOQ6XnbYbJ6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Patch "vhost: vringh: use get_user()/put_user() for IOTLB 16-bit accesses" has been added to the 6.18-stable tree
Date: Tue, 17 Nov 2026 19:22:55 -0500
Message-ID: <2026-11-17-1-daily-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAHk-=wjJ80Ajzu6vd6TOjaV1jSVgvBJ04nMT0qK3igvqgu_Oxg@mail.gmail.com>
References: <CAHk-=wjJ80Ajzu6vd6TOjaV1jSVgvBJ04nMT0qK3igvqgu_Oxg@mail.gmail.com>
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
Message-ID: <20261118002255.ZMGHqvAxq4xhl4UOEKVqaFaWj7rECEDh_ZnEJ0lZNE4@z>

> Note that the "now disables page faults around it" is not true in
> stable kernels unless you also take the previous commit:
>
>   05fb07c40e00 ("vdpa_sim: disable page faults around
> vringh_need_notify_iotlb()")

Thanks, queued that one for 7.3, 6.18, 6.12 and 6.6.

-- 
Thanks,
Sasha

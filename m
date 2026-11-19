Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104538;
	b=b8Fkr6gA+YDm4gMFGT5bMVlbnSJCM/OgeLeBfOSPBP29Rua8pfLP4o+TPxKxmETKTGpl
	 rOhVuUQ5PkIQNaRB+fPvTYrMGKERGDDUL89ldJiJQvhgSkNq8mUkIdB2QXRlP5c78GM6e
	 /mzPQ3srdFApMWxpEDso/p7/ra6NTxZvdcMvuaexj4exB7nnKC7mdKx7cv2ObtXirLUJ3
	 43Gi1+Z7btsp3mCF0PvUpYTNznGUFjr5qlkeduhVjNayRg1UdUhc0RBh4kUGYphtvoYud
	 hV9EWRSgD2nsDMGQuHMVvgMHuU7lb0cfZ+xmgU/atgqcQPub7SU0rOX3bwXtFr8gJoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104538;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZAt/AfltIvtygUWr0TiGKoBgFdU1nsfWF9JkdihCRP0=;
	b=KdjHghFK7XO1H+0k7Hq2IQpqV5HYDQq7uNqwUux6iH8xVodlh7LyYhHP5aUzsm9Qw278
	 ge+k2pvnXgoHs3UqY0jUFsP4ufLdgczHnUw+lfZAdZca27+y5qwVdfLeB1X+a0OuEobwr
	 VG4aUmDDaSaOdBOECXqcFDWKgRH2MY7lBBaTj+z6Gqj0FbclcseySOe59FV9wUVQ/DNP/
	 8ASJu6Ls715YRTrohtkljlQ799fStiGEK+jGxkvsyyUiWZLhX27y1VrOe4u1UaSX7U0jd
	 rM7iNMVY9BaiyYDKzLRpXE67uNZJzyy62ZodHBFe9wltZJ8Jx9ckUUsSuikjb42ObQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdWbNGf2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8EC606A333
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdWbNGf2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A221F000C6;
	Thu, 19 Nov 2026 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104538;
	bh=ZAt/AfltIvtygUWr0TiGKoBgFdU1nsfWF9JkdihCRP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GdWbNGf2iEDlMzxO9h3u1tGdbRVG4wTpN8VHm/DpJ/gJMZ5A8kQrKGdcJ7jRJHmdB
	 eO+e6sbTFpNrE9T9UkFZRnPq4iXBQaGeefN+s11A/1FCgdeZy3OHPUnUBfopTtPB3H
	 8815SSOFDPcb6VZgJEXFssP1Uh56kiCSrQPDK2OJVfgVLPCP2JjYgqMo0QFzTF5v/6
	 XSmeBR69v5z4O0A9uVKpA/XZe5/aaciy/ieYURoX0Qr8SZ/b1m0tA21JPiVODFSdqa
	 Zg5VNAPvuGvf1ukrXKDjaox00Os7B+C4OFbNuUsSXNYnRPxEwGFMzA6YvjCFRCIsDO
	 6geea+ScVOLJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	Liang He <windhl@126.com>,
	Mark Brown <broonie@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [PATCH 5.10.y] ASoC: mt6359: Fix refcount leak bug
Date: Thu, 19 Nov 2026 11:08:25 -0500
Message-ID: <2026-11-19-1-daily-reply-0023@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1794986770-15554-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794986770-15554-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
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

> commit a8d5df69e2ec702d979f7d04ed519caf8691a032 upstream.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

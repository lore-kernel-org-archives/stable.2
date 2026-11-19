Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058692;
	b=eCSF1/BYZmWACeJZAKlTbrH/b/B4xbLs6cw4U5Jj9Vz68CaKEQu1OJ5cCpD9gvoImQ5e
	 LRZeY4XE2zisdY8OS7YetKyRL8hVET8zgAmP/1ANqGqYpnsnsrwEq/4M/fsOx1WzMRKf/
	 T6TI7eht+8X3ELusqh6IErZjjnkyEnxd2+daLEgytvrwzX/MqgEizu0mNACuV0WZRWs9N
	 FeXh5lvqljC/0pqBn1RjdX0Q5yumzlDs5ov6yuuJWu6ox0gtF+wB6R84+D9Ht5nd/voQj
	 j4E68Ct9Hp3wfJwmm+Acf7UW8PLZtXYjw47jwVMtQM9AvrTe9bvntoM7pCVPWvS3OpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058692;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SqARUBr9hLQLgSL2pE61prXhXyEKNkMCJtddnrzAKJ0=;
	b=YD8LpQpgQYjCmT1AnpI4I5OhasHbe4xbg9A/Wcww4t5jeuodEl3KgU361aAi6z7tZlkD
	 XwIh2wl0l+FU/WEBUXzDzX0gJuT0LXyE6QypfeUp5U08ObyLbdqQ+cds8lJz1ZSU2YBTO
	 4/6SHrgXEjFjTWQGBXC0qM3WqC+/KUygGUjy7ySp4Fyyo5Rf1IDzvWWhZeNnBqW9AXLes
	 5fafgozmZJZn1fNd/7oINLpbTnY9q8TKEPkyMAdCtE4GlKJgWDLdHiCQ8r/R30IxdsOfI
	 JCZi3pPt6wTwP5eL8NzTHRnrAFwr/lnsMK/vZ8drNDQZaIb1SKcou0H/cy2q/QacSIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b="Nrx/f87i";
	arc=none smtp.remote-ip=185.70.43.100
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11311606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11311606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=Nrx/f87i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795058689; x=1795317889;
	bh=SqARUBr9hLQLgSL2pE61prXhXyEKNkMCJtddnrzAKJ0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Nrx/f87iDo1wQZVJ77TSgcbKB+Osw0UTF4XK/p5Lo7ylk3U+SeUYsaVApvHQLcnd5
	 idfmCkqNaEYjc/uyL2v/OuEI8RnF5iNOrk2DYE92qr9jWxPUL1IFpDXfwW4hA7HWdr
	 tXgO+6bFx5SWZvv6RbI95Q9L1olXZ+UidZXHcuIwE+DuW9fmt+x+jyiVyMTEVDlWud
	 Brs/2dp6UZQlie7KnC+uINizeXrHEO2r6hN7PMXLe0NQNmnYOC1y3Xq17JAQdKG4AR
	 Iq7dRPXB8FGat6PDASItcxY5oDiztQ5S/EtDGQ1m17nJlPcTwC9POX+zHupR7GAtu2
	 wWqUbIA3IBBJw==
Date: Thu, 19 Nov 2026 03:24:44 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, Yichong Chen <chenyichong@uniontech.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 7.3 1120/2651] debugfs: make debugfs_create_str() read-only
Message-ID: <20261119032437.37062-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 8af8912c24a1f531c684de7242b1c33795e263cb
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

This is 3/3 of a series, and the two before it are not queued:

  493daf5bf2b9 ("interconnect: debugfs: replace writable string helper")
  98421ba5925f ("soundwire: debugfs: replace writable string helper")

Without them, drivers/soundwire/debugfs.c and
drivers/interconnect/debugfs-client.c still pass write permission to
debugfs_create_str(), so the new check warns and the files are not
created. On a Surface Pro 11 (Lunar Lake, SoundWire), 7.3.6-rc1 warns
twice at boot:

  debugfs_create_str() does not support writable files
  WARNING: fs/debugfs/file.c:1078 at debugfs_create_str+0x57/0x80
   sdw_slave_debugfs_init+0x18a/0x1d0 [soundwire_bus]

6.18.65-rc1 (0934/2151) and 6.12.119-rc1 (0740/1756) queue the same
patch, and both trees have the same two callers. 6.6.163-rc1 (2497/3318)
queues it too; there only the interconnect callers remain. Please take
the conversions first, or drop this one.

Sergey


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794747012;
	b=Vwx1pYPauCYy2d7Ybg5qmFAQ08R77UUePthBUKWAzMw8ltm9PaU5bYqpc8xP6/Sw1aBs
	 k5UeYugUNnQOwR9DoTHFRivxdb2U7ovSfQ+znX/t/HfmWAy2jvBU7TJVmAKThOo3ErtL9
	 zQOJFDirikjrOiwUSoUN8XjRuIxIuL2lHAZes/FJ0a1G5SMdYH5bi7xbuw6Kd3NrA209D
	 N0CUWprqtoOGw9190JgaUt3e6RjSga3OYTWQ0St6whLkbsRDlvYceR+8gvpgpmtrpGhtK
	 RVrKW76Z+pBZ+BPunQcb90s9i1XktGfieo3b41udBTeE2UdDXY0Ql+uC5b+QHt5xbiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794747012;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type;
	bh=mVNyqoZPmWVu3SKQuwZrHrfUspenGyNr7ONwhLH90yo=;
	b=P8JEYkf/qEVbKO4YNpGCSfrdIm5FTYbuhN6RRxRjSc32fSfZffysjgGRi/lBsKkfdWyc
	 EsME2eEtrUZne5LQBGHKV3hrjU1klx/loM4tf0UM81+OejAKViuHLxyo57q8u68wiyEJb
	 Agi+tEBwAQZHyrDOFo4pd9m9NMxKzb84OmbgyED115Pwoc+rmjZCe13bmZH7VXEkzsoqc
	 ZtLPj76/NJvDaliW+/GJ7htd9efWbJSxnSEfKlGiXahvP59wTg19ZQmN+btZ99rVqSOKb
	 s0YoCtU3a1MIWtCtHWgkSC0TKIFZ9TEsyGT8eqejTfwuBA3Fiz33uE8BoOqg6toXnSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=feldt.systems;
	spf=pass smtp.mailfrom=feldt.systems;
	dkim=pass header.d=feldt.systems header.i=@feldt.systems header.a=rsa-sha256 header.s=protonmail2 header.b=Z6rO7xwO;
	arc=none smtp.remote-ip=185.70.43.23
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718A606A31E
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 12:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8718A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=feldt.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feldt.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=feldt.systems header.i=@feldt.systems header.a=rsa-sha256 header.s=protonmail2 header.b=Z6rO7xwO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feldt.systems;
	s=protonmail2; t=1794747008; x=1795006208;
	bh=mVNyqoZPmWVu3SKQuwZrHrfUspenGyNr7ONwhLH90yo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Z6rO7xwOeaCPF1nl2j/O0ICdnwWkRxg7BDBC24YB/dCJaOzTh7lN8mOIwUnFE7x0m
	 QlmwWE8RMW+4XMGkXUXANKxIsMFkFZOE6UqZ/vJqNv1adRtH8U/m3LFOK2xzynVDwt
	 4/44dv4E/awHfcgHCwWVdW5CF5bv4CPVpM1qcjOqe7iAyDJd5fAKK0GhyQ7glao2MZ
	 Cg2D9U8fl6G3k7B5w6jZe9RIqkFJnc4LuaPjSptsiZiuHKVDfWZ2SgyxRnfXLCnN1x
	 Oxv9yjTksvsdk3/wnpvaB1Sae4rIaBIXuvPihdeexW1SB/93gyXAXRAIUfGhW+4tAz
	 A5y8IhP1V4ikg==
Date: Sun, 15 Nov 2026 12:50:02 +0000
To: Shakeel Butt <shakeel.butt@linux.dev>
From: Noah Feldt <noah@feldt.systems>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: mglru: splice all generations when reparenting a memcg
Message-ID: <20261115124954.7146-1-noah@feldt.systems>
In-Reply-To: <20261111000913.22943-1-shakeel.butt@linux.dev>
References: <20261111000913.22943-1-shakeel.butt@linux.dev>
Feedback-ID: 113045274:user:proton
X-Pm-Message-ID: 7a8d2dffe38d7e29b15abfa03649c45efb904402
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------b27fb500e8faeb49fb14a6758c7ae9d2468896a3db128a3af62cfaa1f52b3fb9"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------b27fb500e8faeb49fb14a6758c7ae9d2468896a3db128a3af62cfaa1f52b3fb9
Content-Type: multipart/mixed;
 boundary=05e0afd5b3cdf604dd06ded9ef01d0c6e448bf611d31394ba37e012cc31c
From: Noah Feldt <noah@feldt.systems>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: mglru: splice all generations when reparenting a memcg
Date: Sun, 15 Nov 2026 13:49:53 +0100
Message-ID: <20261115124954.7146-1-noah@feldt.systems>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111000913.22943-1-shakeel.butt@linux.dev>
References: <20261111000913.22943-1-shakeel.butt@linux.dev>
MIME-Version: 1.0

--05e0afd5b3cdf604dd06ded9ef01d0c6e448bf611d31394ba37e012cc31c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 11, 2026, Shakeel Butt wrote:
> Noah reported list_del corruption on single-node hosts running 7.2.11,
> which already has commit bf4ade7dbd76 ("memcg: keep folio's objcg same
> as its node"). The bad pointer is an MGLRU list head in a freed
> mem_cgroup_per_node:

I have already rolled this patch out on our servers. Since then the
panics and resulting restarts from my report have stopped, and we have
not noticed any other unusual behaviour.

Tested-by: Noah Feldt <noah@feldt.systems>

--05e0afd5b3cdf604dd06ded9ef01d0c6e448bf611d31394ba37e012cc31c
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - noah@feldt.systems -
 0x9B02BBB4.asc"; name="publickey - noah@feldt.systems - 0x9B02BBB4.asc"
Content-Type: application/pgp-keys; filename="publickey - noah@feldt.systems
 - 0x9B02BBB4.asc"; name="publickey - noah@feldt.systems - 0x9B02BBB4.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuMTAuMAoKeGpNRVpuV2ZveFlKS3dZQkJBSGFS
dzhCQVFkQWpjOWlieHJoOExkN2E3YjdBM1hXUnZSdGt6V2cwcEZUaUpDTgoza3J1ZnM3TkoyNXZZ
V2hBWm1Wc1pIUXVjM2x6ZEdWdGN5QThibTloYUVCbVpXeGtkQzV6ZVhOMFpXMXpQc0tNCkJCQVdD
Z0ErQllKbWRaK2pCQXNKQndnSmtFQlN1OWFxLzJDcUF4VUlDZ1FXQUFJQkFoa0JBcHNEQWg0QkZp
RUUKbXdLN3RGM0s0QUt5ZXdZWVFGSzcxcXIvWUtvQUFFSjdBUURaRlZLOGpTa3FDSk9oS1NsTVp6
T01Ibk4vQjhyYwpHZzlXei9UdW1lejVwQUQvV2l6V2xGem4xT3NibzBzV0U3L25FLzRMaXRKS2k0
bjlObUVGczRob01BVE9PQVJtCmRaK2pFZ29yQmdFRUFaZFZBUVVCQVFkQTc4U0JLZkc1Ymd6SjQw
bVZxTmNGUnhqc0lTT0ovVW4rZU1TaC83MkQKVUVJREFRZ0h3bmdFR0JZS0FDb0ZnbVoxbjZNSmtF
QlN1OWFxLzJDcUFwc01GaUVFbXdLN3RGM0s0QUt5ZXdZWQpRRks3MXFyL1lLb0FBTWJHQVA0anZ3
YlBacnFSY3dzRk5VdWI3aSthSFVTY2pwQTJIazFUdTBKTG5HWTlMQUVBCjRBOGQrWGNsdEVhUEtp
Vi9sbzh2RFdPaFBBQVBhbTFuQi8wQWhlenh1UTA9Cj1jQkVoCi0tLS0tRU5EIFBHUCBQVUJMSUMg
S0VZIEJMT0NLLS0tLS0=
--05e0afd5b3cdf604dd06ded9ef01d0c6e448bf611d31394ba37e012cc31c--

--------b27fb500e8faeb49fb14a6758c7ae9d2468896a3db128a3af62cfaa1f52b3fb9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wqsEARYIAF0Fgmr5qnoJEEBSu9aq/2CqNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcJY1tpAvGYVk58XJVYWNHrFiEEmwK7tF3K4AKy
ewYYQFK71qr/YKoAAElkAP9khqOtjveDcbwTuViuCxaBhfOSAVQoH+cQF9d0
ekfMBwD/XqKUWZwBK1v+fl/e6jrZ0dwuxvsCOdhSvhM1UKKP4g0=
=TNjw
-----END PGP SIGNATURE-----


--------b27fb500e8faeb49fb14a6758c7ae9d2468896a3db128a3af62cfaa1f52b3fb9--


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429263;
	b=ZHRotbrMId//36suZwgDm6HynBY2lUFiIIweERET0xZRdoS8CUoh5ixbR2cK4Jho1AeC
	 6AVmDluEZSw0RfQOsP7TDHlpURA7/uKNSVHgxIdHXC5MzXMhilQIq8zhpfTbfZ9cxg/T7
	 M8OqsDy0zgEBsMPL/l6wcrQRkcLoN8ga/S2BfKNC8o9Zx0+UpEg0729KH/mUJFpKxym1R
	 FEbv/eNmDjc2fkiOlzhzEF0KIys+Ly6gWJbe6M2lzNvRG7ntOKXgb8x7OqpA+62NBWvR0
	 iDquYa7YL680zR/dIojFBWhxTHlqzMkqqPGmVOEBrCyV8QSA4hyTaZLkX9xCTeU28XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429263;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar;
	bh=unvIegtiiWufjlz8mTDtQiaX659dqxGrn30qdGWch5o=;
	b=QAbIGRFRBcSDCYjFeXlniGVJO/H94G1jAsqNeOY9UfyL3oyab2E3Q/sjREeyF8EwD1tX
	 0fZZfg+6JGJioucsfi3XkvrP3d3U99t3bxQ5R4lqYOjJUJ2VFAYHk7EUUt1rwhwj4/kj5
	 64o2vEadyhMUbVsvo4LjPX1+jvm4nJtHIFZiETr+XT6/Z8QAulp+mzB21NpbQcBWgHVug
	 KWqR8iGbkh7QqEfNHEMx+VMUXuECxhDAUvBYjqZI34AhzcRMSi2WKOHn6ToaHc2vcH1Z3
	 5XkL2ybc1C2UmtKV6lNWHKqi81lt34Db3TQKirJYJqvXpGfvCPalJX/4vfl8YhaFquw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=ibsaMZN3;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE5606A31C;
	Wed, 11 Nov 2026 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=ibsaMZN3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=unvIegtiiWufjlz8mTDtQiaX659dqxGrn30qdGWch5o=;
	t=1794429262; x=1795638862; b=ibsaMZN35FBg9OyDb0heU06kJHSnbifdSVAsgFTFNabcXyG
	aIHcSohFm7AmG9qbkeSb5zB3Q+dXN1DrUPqacwiXCAJebGc0SQdMrEZBFW+SHQfj+CZTdZk01b3wD
	TKrh92KOrRj9SpRe5tzJv5RumLaOnfWP8Rhb++3uJCFmX40XyA4pUaPJx5axoeoFX7rS7zGBmDyG7
	hYIBa+3Ei4gurtFr5rIZFn7Y/yFqG+DQq/jY9kQTX5BxVyIn7I/yoInyW1FQJmR7nr1Kl7QpLkVyh
	+tSF+YTSirQOk2GzLRiXkyXqzp1NOMm2RyKjk/lR6A0KZ/igW/PsbibKoKa+T8uA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xRF1I-00000004qBM-3Fo6;
	Wed, 11 Nov 2026 21:34:12 +0100
Message-ID: <27d2c98928859d47b2c3cf76870d868882685809.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: mac80211_hwsim: serialize radio removal with
 frame commands
From: Johannes Berg <johannes@sipsolutions.net>
To: enderaoelyther@gmail.com
Cc: "John W. Linville" <linville@tuxdriver.com>, Javier Lopez
 <jlopex@gmail.com>,  Jukka Rissanen <jukka.rissanen@linux.intel.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 11 Nov 2026 21:34:12 +0100
In-Reply-To: <CACHPgzw-JeorCAX-b5jjd6d5=L0oYpPdGtstUSaz5sPKZE2HsQ@mail.gmail.com> (sfid-20261111_204546_211086_1FE84B1B)
References: <20261028141751.6728-1-enderaoelyther@gmail.com>
		 <20261028141751.6728-3-enderaoelyther@gmail.com>
		 (sfid-20261028_151822_083722_A5EF7A18) <76bc126fb977cac0f0a124fc80eae9fdb803264d.camel@sipsolutions.net>
	 <CACHPgzw-JeorCAX-b5jjd6d5=L0oYpPdGtstUSaz5sPKZE2HsQ@mail.gmail.com>
	 (sfid-20261111_204546_211086_1FE84B1B)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2026-11-11 at 14:45 -0500, enderaoelyther@gmail.com wrote:
>=20
>=20
> The underlying problem is per-radio object lifetime, not command
> serialization. get_hwsim_data_ref_from_addr() returns a radio pointer
> after rhashtable_lookup_fast() has already ended its RCU read-side
> protection. A concurrent deletion can then unpublish and free that radio
> while a frame, TX-status, or PMSR command is still using the pointer.
>=20
> I reworked the fix around a per-radio reference count.

I'm not convinced that's necessary.

There are three users of get_hwsim_data_ref_from_addr:

hwsim_tx_info_frame_received_nl() just doesn't do anything that sleeps,
so it could just use RCU protection directly?

hwsim_cloned_frame_received_nl() uses it twice - the inner use is not an
issue as above, and the outer one is just acquiring the mutex for
synchronization with ->started, but given that mac80211 will sync RCU in
stop that's perhaps just not needed at all? Or maybe hwsim just needs to
synchronize_net() on stop.

hwsim_pmsr_report_nl() uses the mutex for pmsr_request access/swap and
GFP_KERNEL, but both of those could change? might need some more work
for abort though, not sure.

Dunno if that's better overall? Maybe, maybe not.

johannes

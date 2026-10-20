Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505966;
	b=iH/shcQAMb/RiDmMnEWhPmZNuN2SfaRUu+HgMdYKMPsYJw+/0DR7/i0XOdxYrr67yiss
	 5UHbX1TjU3yk1tWbP7QgO9xL1vb4oGkp4W6xrrvGz9snrLchO5J7+LiLlcacJ/xEAoc55
	 tpV/mru4siMfuwZhhn5iCFsT4JouI+a6QHVEFFCkEv6D0qxgGbYCXmm+BXo1LfW8go7M/
	 RngzZ005a+6XvPVEuF5VsiSuH5MIhmsQKvurChJalHhg8W/4qTSNxwNERk3vl283VReEw
	 w5swUw5D3IKgJjqHiUoCBU4lix59Jce5KWTgbbvw9ByJtCYr2H7Yh0HZC9I+nQ6iLHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505966;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Message-ID:
	 In-Reply-To:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-Mailer:
	 X-Authenticated-User;
	bh=kqnEF+q2yzunlljkCgMnTGrBrqEf3TIoC9fVf9hGPjM=;
	b=BA4NF1Pc5TTHiiDFluM2Onf0ky5C2b6B5BB51iP96xZycvtWzjNdBsTC+YzHtaaJFOYr
	 ELdNuic0V6TPj4bUCIkwaNzgMr+znytAKptfhb/RTv/bkYUEPlqBEs6dRufA41YTcLeWk
	 Ni577s75Qp+HDcbNRZwnO44DXn45pypMojokao/zTv05DrPjlNEXdBT57jubygXd3n4LC
	 iQKFdX2KBHCgCVQNqnR3FyyfeS9RB6cYy5I4wcNGRZRHIzW+zWi9gY8drOE/n8qvf8QxH
	 cp4SQrZzQMqbDO/Vda5+yiZitP2zIubR3lXfurCsffAGIGtuP11+dzwnvK/eEpWMQuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=bp42wrWC;
	arc=none smtp.remote-ip=212.27.42.3
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEED606A320;
	Tue, 20 Oct 2026 14:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFEED606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=bp42wrWC
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E269214095D;
	Tue, 20 Oct 2026 16:19:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792505957;
	bh=H1/mP/b1Njxs6cmNY/GEagmuoC+DP9CLfbABpipPGxw=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=bp42wrWCKRh0RX9w32gnS3nFbPhJO+wJGUHq/1c/YcpJ6dPC7jLsv3Raxzpz2/phd
	 GV39WFPY+fZQtCHCyZHWhkFVKoW9nGEePVF7pDzWWhnrNWvr4ev/l7WNdOFGEcMgUM
	 qASKW914X2F0tJrgLwqBfQ55hwL3E3IqSmnh2b7GRPHANCV4DRcnnMA8vtS4vouFKw
	 CYskQgzuKbZxUdLg07N53za/W7EaKmfcfs5BWMoqdY2HmhxY28KHwthpED76guW+oJ
	 Qc0sOuQzb/ZNcuRcUhy+hPa1E2ghHbthysle6Q5k/0NXWQKT8ZnZBhikws9QAjXmQw
	 tgYWdBBQC6Oxg==
Date: Tue, 20 Oct 2026 16:19:16 +0200 (CEST)
From: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@free.fr>
To: Dan Carpenter <error27@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Stefan =?utf-8?Q?G=C3=BCnther?= <stefangun@pm.me>, 
	stable@vger.kernel.org, s grosjean <s.grosjean@peak-system.fr>
Message-ID: <899587980.1227073500.1792505956589.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <atdybEUQ9EUdZ9A4@stanley.mountain>
Subject: Re: [PATCH v5 00/10] can: peak_usb: fixes, cleanup and input
 validation hardening
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
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC154 (Linux)/7.2.0-GA2598)
X-Authenticated-User: stephane.grosjean@free.fr

Sorry about that, and thanks for the reminder. I'll wait at least
24 hours between postings from now on.

Regards,
St=C3=A9phane

----- Mail original -----
> Could you please slow down.  Only resend once per day.  Otherwise
> it's
> a bit like involuntary pair programming for people who are on the
> list.
>=20
> regards,
> dan carpenter
>=20
>=20
>=20

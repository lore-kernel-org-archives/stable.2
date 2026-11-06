Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=87.76.132.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977379;
	b=PKKF940oKghAtrW6oIjbE6dD51Q+v+S29ymF1tgx42KME12ar97qbCRIPJeMOZPmwIcm
	 H8oa7GXhlkDjhTkmlAEYdQgp5HauzBMBVwb3YVQ4emovJg2U0I7XxNokhBAhzYr/4SAcB
	 GX58mcwVVy/yiokdBXz9CxEwCGs2BtwEBwBab6FPyLbkuO3cUNth5qA7kAAvzKDWmDACu
	 Qgl3HL90jMD3KjvrR/ENcfy26fupN6frz2zn9EWRtkbFxGGQoQ3PJWdPsRK3BkN/r+3Tc
	 tVp+rhjt7wGx0CRd2PtQrdAlE34dfcq8WmJ7+5N1/pafEylS2L+6ruAdrd2oBSBXYHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977379;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=AqLwYFD1acvqKqgSna11OUhpAcBUEnf2H0+i+I6PAG4=;
	b=w7Gots5pY6kILtP8WuxOBcqwUf+ooM4D6U33cyHTcLWoh8elCZmachCotjkfOokvyki8
	 JMZ8vRRMnQtjfOlCD0RMGqZG+8O6ROSKzK6BdmuzA1/U6Xv+ClHHh/ycXojPTcI0P8YyB
	 xpPpvT0oWwRweBST3b/mqKcOr2eyf5gxAkiS9yaAbxVbxfR3/zNN0IgdQOPkBBCbzNIsJ
	 0Qdpbd/Yd11UGlLXBGRryNzl2tYUNFqnT9qS1mf/8V+4bu4pAQNEvw/K9NJCuqJUKr5iP
	 QDjTWbuStHrIR23uDSjbD1MMK1rYciwenULvaMXCGr5Xnj7F73qIPGCPsEsleL91CMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auth.ink;
	spf=pass smtp.mailfrom=auth.ink;
	dkim=pass header.d=auth.ink header.i=@auth.ink header.a=rsa-sha256 header.s=dkim header.b="G2cCtTk/";
	arc=none smtp.remote-ip=87.76.132.165
Received: from mail.netskyway.net (mail.netskyway.net [87.76.132.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAE7606A32D;
	Fri,  6 Nov 2026 15:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EAE7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auth.ink
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auth.ink
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=auth.ink header.i=@auth.ink header.a=rsa-sha256 header.s=dkim header.b=G2cCtTk/
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B62AE30A29E;
	Fri, 06 Nov 2026 12:02:45 -0300 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=auth.ink; s=dkim;
	t=1793977367; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AqLwYFD1acvqKqgSna11OUhpAcBUEnf2H0+i+I6PAG4=;
	b=G2cCtTk/5vWFHoegTIYquDycnJ6NatDpWKQb+rdREtnGcsW6jQSO+dooCWTORiYmuoAUdn
	eLN9RHN6tIDrqX7553Au1VFdJww1GrGzjXjpL5YJaHBRPqVEDWwVnJA9nOmKN5/JFLha7Y
	yl+C883e/VapntmlHipPoQeMbFWOGA4iP6hkPGGly0YWCDiKAw26J7m7e4L8Y2m/7ulxao
	Hy8E8jFblrr26wHdP70UfpMIsidQFJj0FN3NDeO+Q5WgnmuDGv+JLM9ZseVZ7GrDKf4Smf
	Z0BNKWiXAcDALuupXvTdDWgeldEhrsm8Ycg3JF8vAW1MeMf5GeHXxobEVgft3w==
Date: Fri, 06 Nov 2026 17:02:44 +0200
From: Tamir Awad <tamir@auth.ink>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, lee@kernel.org,
 netdev@vger.kernel.org, Rodrigo Zaiden <rodrigo.zaiden@canonical.com>
Subject: Re: [PATCH 5.15.y] af_unix: Clear oob_skb in scan_inflight()
User-Agent: Thunderbird for Android
In-Reply-To: <bb79cd2c-0edc-4e78-9b20-5f3ec976f1ac@auth.ink>
References: <1685aeee-c65d-4a8f-9bfe-607e13e114a9@auth.ink> <2026-10-25-1-daily-reply-0005-af-unix-oob-skb-5-15-hold@kernel.org> <4ADFAF9F-7A76-4897-9374-914E5A384D8F@auth.ink> <A37FE39D-BD84-4FBE-A160-1ACE5AA98D39@auth.ink> <CAAVpQUBA89A5qjL85pavgcYCpQ9jWFiiQXs9eBbHT+zAX1nC4Q@mail.gmail.com> <bb79cd2c-0edc-4e78-9b20-5f3ec976f1ac@auth.ink>
Message-ID: <08E5C4C3-189B-4B0D-94F5-5C049EAF6DA8@auth.ink>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi, is there an update on this?

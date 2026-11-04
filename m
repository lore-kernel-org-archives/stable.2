Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773150;
	b=ynBVRPoMIMYPGF3VBrikVwn58TQkQf37DWDYyqU6LhxgiR01NMftXgdn4ErF1BnfvaOB
	 XlakWcmRpzrTXycGJdkixJhLrVilRzy11LhRlXlqlD3MWj941BLAWs2nMgWspNDhAdWDZ
	 n3hB8tUCO+fYLM6nsZCrt3GfxYg1HX3YQ1d81jho+1aJme5nE9Bq4EipGo9HwxgP02RH3
	 O22R9qRbM0sl27ECLRPzmlwcJgAd98/y2Kaw+1wI4PLrmjy9dRO6i9pleExHtoseXxHlz
	 DKFUZmG74J822nZ73E081Atg8OFbU2EPPBQaoRYhguTUVoA4lQwq/t/Mja5djnA/L/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773150;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	b=ap2GK0W8bLIUUX0/hSC6nYJvCI8tAjdLtRvFT+mmXCk9pABHMa4UPHxAU29Rirpp4IyG
	 U4v4LcqIAhgGLUsWqOM6PF40CYcUNIvGcnpoHedW3vipS88E/Be51L6R158BoUoSef9aL
	 bvbToAkIwuQb1bAF4GIp51YBcRx2V6Ey/bphIBBBJvYIGiIY3eahyqgQ4pmMWiFFcTmh4
	 69LFoZNf25NxqVeznpn/OEJoeoKoiI6jawOnbI3ZNCwaqGGVlrKUD+4/p09wRcPpDvZ5h
	 VhkSrY3vak1hhPfbjrxTvGDdQzZahpGhVvZD4M35d1RQlHu+buL/S1Jym2C3ufCCdXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsNIxUDt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172A606A326;
	Wed,  4 Nov 2026 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsNIxUDt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7941F000C1;
	Wed,  4 Nov 2026 06:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793773149;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YsNIxUDtfeyDcYt8sJ34QTw2tmm+0IbDKbcbXKiB7jY7xxAdrr35W5f53afkV9TeW
	 nv3F+SfFGiQt9K40RVcNBvQ8cLqIbBQG68QE5lfTDRlcYecnfx3usbfPUtLAOrLKRf
	 DFtqUGeRhi3RFCvD6mer0iWDuZy2kiD2MZArnQ8/p1+E/x2drJ35zmSecBLaYXUCig
	 ycbLRHA/CSPKXREi1iR7sp8JsfWTf/0RuxJ9Nn1P5Qs4VmoBzEtwHjyR+HRcSFAUdX
	 DwY3o+eDzjOJkMTWSacullqcYFeMEbHG/jIxIEHmXz8gqHjL/iLDcAD1lXQModUNxj
	 Y8iOCRXB3T2Ig==
From: netdev-bot+sinfo@kernel.org
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Jeroen de Borst <jeroendb@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] gve: bound the device reported rule count in the flow
 rules query
Date: Wed, 04 Nov 2026 06:19:08 +0000
Message-ID: <179377314801.488859.9571867900418118906@kernel.org>
In-Reply-To: <20261104061329.1881388-1-yhlee@isslab.korea.ac.kr>
References: <20261104061329.1881388-1-yhlee@isslab.korea.ac.kr>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

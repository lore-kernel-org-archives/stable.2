Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002A52120F;
	Thu,  1 Oct 2026 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865195; cv=none; b=U7J7MUndFxWlLchvEP6IWFgi0a0oZ1dtcWcKhTwa1Kto7dF78VhlafqPRwTCnmusA+lQu64zsPbS5HglExrZORrHlszOgg+K4elBKsFkA6WHq1O0QdRSPJ70oFb3O3eZdUFKHOkwrb9j+L6xGK36xZYeFKwuyi8aa/q/PlpLxSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865195; c=relaxed/simple;
	bh=yRIClUGyEu/COpa6JB/XyyLCadmCOVyyClxIjg4WllQ=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=Q1/ulB0JbmtVniLIB6MykF6/Npcpd2SNW+KMydxMtFQjN+zgCTI1i5i9d0t073UMutEVOyfLFHIx7tFGzi+UJurRXeMI51keiEvBQdCAZwy2lkSEiuJy/eFkNoizi8XyhxH0atkuyz4qQqhNrZvigO30OSqXQlBnq6+oK5L9+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=FMdCAWb8; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="FMdCAWb8"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1790865186; h=from:subject:to:date:message-id;
	bh=yRIClUGyEu/COpa6JB/XyyLCadmCOVyyClxIjg4WllQ=;
	b=FMdCAWb8fKHMN6QtDUU6QKfemhfPdgOQ+VUEAzjHOG4u35Q2FxKf0g7Er71F7mtQU133qDC5zSH
	h1PcFsPTa7pj/6b+JX8o+v8bmECEAP50JRyscWaqzmDPL5cAtKvE7EP5qC08MVByuTHBAQaBdGbOj
	FNwV3EzHsNVLQ6R9bC5qp4CtqY9+SgF3mBxXKJyUNKOZ/EXN+LZTNf/F4APWI09zpAJ0zTQbaTdOq
	bHdOWAHM5eFFARn0IrHKTWjPZEIe3b6NC2UOK1zIJ5WYOsNSqGf1CebmwSdEwBO1Z7SC/kSJ2jfq0
	yjq0F9XWODB+Z8WC1sjCNd//jBeufpIrOthA==
Received: from mail.amicon.lan (192.168.0.59) by mail.amicon.lan
 (192.168.0.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Thu, 1 Oct
 2026 17:33:05 +0300
Received: from mail.amicon.lan ([::1]) by mail.amicon.lan ([::1]) with mapi id
 15.02.1544.027; Thu, 1 Oct 2026 17:33:05 +0300
From: =?koi8-r?B?7s/XycvP1yDh0tSjzQ==?= <naa@amicon.ru>
To: "netdev-bot+sinfo@kernel.org" <netdev-bot+sinfo@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	=?koi8-r?B?8sHaz9cg8s/Nwc4=?= <rrv@amicon.ru>, "pchelkin@ispras.ru"
	<pchelkin@ispras.ru>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5.15] vxlan: Fix potential null-ptr-deref in
 vxlan_gro_prepare_receive().
Thread-Topic: [PATCH 5.15] vxlan: Fix potential null-ptr-deref in
 vxlan_gro_prepare_receive().
Thread-Index: AQHdUapKD1cz0+vAD0GNXi7u0omuY7bowA35
Date: Thu, 1 Oct 2026 14:33:05 +0000
Message-ID: <f89842dfc9014dc9b5c3905c4d65d51b@amicon.ru>
References: <20261001132039.21201-1-naa@amicon.ru>,<179086197227.31693.8704060058711859109@kernel.org>
In-Reply-To: <179086197227.31693.8704060058711859109@kernel.org>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Resending in plain text because the mailing lists rejected the
HTML version of my previous reply.

This is a 5.15 stable backport of Kuniyuki Iwashima's upstream
commit 30a45c0bffdd62350261e2f2689fdba426a33578.

The original submission does not specify how the bug was discovered.
A later report includes a KASAN diagnostic and a kernel panic.
Kuniyuki confirmed that the upstream commit above fixes that issue:
https://lists.openwall.net/netdev/2026/07/06/423

Validation of this backport covered patch application and formatting,
but did not include runtime reproduction on 5.15.

Best regards,
Artem Novikov


=EF=D4: netdev-bot+sinfo@kernel.org <netdev-bot+sinfo@kernel.org>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 1 =CF=CB=D4=D1=C2=D2=D1 2026 =C7. 16:39
=EB=CF=CD=D5: =EE=CF=D7=C9=CB=CF=D7 =E1=D2=D4=A3=CD
=EB=CF=D0=C9=D1: stable@vger.kernel.org; Greg Kroah-Hartman; Sasha Levin; l=
vc-project@linuxtesting.org; =F2=C1=DA=CF=D7 =F2=CF=CD=C1=CE; pchelkin@ispr=
as.ru; David S. Miller; Jakub Kicinski; netdev@vger.kernel.org; linux-kerne=
l@vger.kernel.org
=F4=C5=CD=C1: Re: [PATCH 5.15] vxlan: Fix potential null-ptr-deref in vxlan=
_gro_prepare_receive().
=9A=9A=9A=20
Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

=9A- How the issue was discovered, e.g. hit in production, hit during
=9A=9A development, syzbot report, manual code inspection, LLM or static
=9A=9A analysis tool scan.

=9A- Whether the issue was actually triggered, or is only theoretical
=9A=9A (e.g. found by code inspection). If it was triggered please include
=9A=9A the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
=9A=9A=9A =

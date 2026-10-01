Received: from mail.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A551D513;
	Thu,  1 Oct 2026 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865313; cv=none; b=RnDcJKLPV5Cgox7tJjRkPx8l7E8vHf4Bhd0tCt1iSCgnw+XzjSJFQsCU9D6PoziOwnehE4zrekRJm8GZg1wZnco2r0Ck5IKp1s0K90XyVcJBhvsk+V2yJ9pcxW9PLO/KBKFez7sBz5y7Q6f27Muh5vKX4M5vI16yTxhBSRhsYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865313; c=relaxed/simple;
	bh=qsqIbI/MQF1POUY7iB2VlRTyr9xmBgTbFwXU+dRpCJQ=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=eSnM1twVc9FPlmTkn360xUq5PzhJnG7rkEn1CG6TYXGoerPyY75UNjDQFQnozzx3zWeXjEOSHCxacn2OpJN6ViTNqnUwN4fcTpLjfcO+WKeCoeiRuh0jTTW8wdJSFiulshktmz47euE7slhbhKFeqR8LR6eI3/OWCJc+I3JuQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=dE7D6jeI; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="dE7D6jeI"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1790865302; h=from:subject:to:date:message-id;
	bh=qsqIbI/MQF1POUY7iB2VlRTyr9xmBgTbFwXU+dRpCJQ=;
	b=dE7D6jeI39Qmktt/zByOGzbUCvwPnAhHosCI3k/K36uy7ool6j8RNa3Ep7OZLrEnfJXw9+xaL7p
	Tnypoqw5Vb215c06wdMG4HO7gtDiVeJ6+a1ny+KK6+lakn11dBtP3RPn6Oji10Dqn5oD7xKUsYtCB
	OqWe0YUiW3Ibrci46K7LutIgTjSQUZOb2Nis8nezHOe8WROoIBEXK30R3WGKee3HjBV+1fhCLV5wx
	5cJregKb+/tmoZn9rSzLvtUdHCHO9rF1d3icvBlKFzrKYW7VcC+fK/iITeyW/Qee78Jku6ojvuLrz
	nTyLBEv13VGDAswvfbwoOai6D9hQMSzevvMw==
Received: from mail.amicon.lan (192.168.0.59) by mail.amicon.lan
 (192.168.0.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Thu, 1 Oct
 2026 17:35:02 +0300
Received: from mail.amicon.lan ([::1]) by mail.amicon.lan ([::1]) with mapi id
 15.02.1544.027; Thu, 1 Oct 2026 17:35:01 +0300
From: =?koi8-r?B?7s/XycvP1yDh0tSjzQ==?= <naa@amicon.ru>
To: "netdev-bot+sinfo@kernel.org" <netdev-bot+sinfo@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	=?koi8-r?B?8sHaz9cg8s/Nwc4=?= <rrv@amicon.ru>, "pchelkin@ispras.ru"
	<pchelkin@ispras.ru>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5.10] vxlan: Fix potential null-ptr-deref in
 vxlan_gro_prepare_receive().
Thread-Topic: [PATCH 5.10] vxlan: Fix potential null-ptr-deref in
 vxlan_gro_prepare_receive().
Thread-Index: AQHdUagP92/JFJlF+EWZfzxIJCfcuLbowIOd
Date: Thu, 1 Oct 2026 14:35:01 +0000
Message-ID: <62ee20aae4004f87b03a0e618572a1c8@amicon.ru>
References: <20261001132038.21173-1-naa@amicon.ru>,<179086101460.31693.11225223420004934540@kernel.org>
In-Reply-To: <179086101460.31693.11225223420004934540@kernel.org>
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

This is a stable backport of Kuniyuki Iwashima's upstream commit
30a45c0bffdd62350261e2f2689fdba426a33578.

The original upstream submission does not specify how the issue
was discovered. I don't have additional information about the
original discovery method.

The backport adapts the NULL check to the older vxlan_gro_receive()
implementation in 5.10. The adaptation is described above my
Signed-off-by.

Best regards,
Artem Novikov

=EF=D4: netdev-bot+sinfo@kernel.org <netdev-bot+sinfo@kernel.org>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 1 =CF=CB=D4=D1=C2=D2=D1 2026 =C7. 16:23
=EB=CF=CD=D5: =EE=CF=D7=C9=CB=CF=D7 =E1=D2=D4=A3=CD
=EB=CF=D0=C9=D1: stable@vger.kernel.org; Greg Kroah-Hartman; Sasha Levin; l=
vc-project@linuxtesting.org; =F2=C1=DA=CF=D7 =F2=CF=CD=C1=CE; pchelkin@ispr=
as.ru; David S. Miller; Jakub Kicinski; netdev@vger.kernel.org; linux-kerne=
l@vger.kernel.org
=F4=C5=CD=C1: Re: [PATCH 5.10] vxlan: Fix potential null-ptr-deref in vxlan=
_gro_prepare_receive().
=9A  =20
Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

=9A- How the issue was discovered, e.g. hit in production, hit during
=9A=9A development, syzbot report, manual code inspection, LLM or static
=9A=9A analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
    =

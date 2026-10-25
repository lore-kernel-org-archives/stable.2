Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792905694;
	b=zwWAtKmJocQvvTujikhOVAlPkNXLxVYQw4acFfm9EL2fRNg808Ggxdl+3/Uc8MWWDsTv
	 K9PXaFyfvVMclJ5Ja1fFRmvjZOgl3bHoAsB8fTR0sPWwkvlK0DbYyVCjqQrq65MAvUqD0
	 7yQ8H5hpVWM8NGK2ZtpfxlLRQPa82eLjoyCwD05FtVuf6wTt9SRkwauE1I1kGlLEQEWR3
	 jpZ8JwuD2y0NndntB859L4OLYNf5GpevvtL+nn/IVHa621U2nHsfEsRU3V9nvKTHPzM1F
	 MJQS65Q+dpiseh/08ksHvJJAgS77+ZA+Ppp/VByesWYE68P3zW6Fij4F4c06I5yHfqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792905694;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=+oWjWsRlQWDM4ECrhqBSL1LIWNMet2nmph1dwUQMceI=;
	b=0/UP0OGnYgBxLqCpwuSOIIi64uRJRzqVOlYgPX0RAC2oVj9l17wAxa3fmqfNuMOREjVC
	 KW/Y82Tpui98iV7W8RMKXv6FoPrzXnhzNii1xfj6IktnLAPonunMCTdH9K+VRUER4Esol
	 rozvdcZkgkQVBczfomhs/02rui1/V2xQojKnAir+3c1OVkEz2dfUynynenToTmVubLeNS
	 DVFm4TuLhVl8E0ujy5rv+JM71Ev/QyCXhgsDiwRcks/spSa3sACYOpAU+xWEhObwrPuAR
	 Uo31AF+ZiZj2CGzdX3D+VZukDNUiAxolMNOnva7KCn24LGsq8Kt2cYa0yw/5e9niaAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=b+YnExW5;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60AC606A31A;
	Sun, 25 Oct 2026 05:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D60AC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=b+YnExW5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=b+YnExW5OmToQqKfgi8ex5KfVV0KXuyrn+i1yFgQUQnEX3fCRz91uexF7PBIsx9nHcDdb93czEzn1
	 08MAY5Ofhy5JOXGbKvyiHwe3HKogamE8BwvdQEknMYuOLyg8aebkOI0pCoz+8DtLxnm50lOzveiB2J
	 hnxTIo6QfzBjzYQM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76add91d8816-44428;
	Sun, 25 Oct 2026 13:21:28 +0800 (CST)
X-RM-TRANSID:2ee76add91d8816-44428
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46add91d60e4-b5f34;
	Sun, 25 Oct 2026 13:21:28 +0800 (CST)
X-RM-TRANSID:2ee46add91d60e4-b5f34
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	dskr99@gmail.com,
	maheshb@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: Re: [PATCH net] ipvlan: fix RX byte accounting for local traffic
Date: Sun, 25 Oct 2026 13:21:17 +0800
Message-ID: <20261025052117.603790-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179289279836.3327.9494173903555653580@kernel.org>
References: <20261025014251.542973-1-yanxia@cmss.chinamobile.com> <179289279836.3327.9494173903555653580@kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi,

> - How the issue was discovered

Found while comparing ipvlan's local forwarding and external receive
paths: skb->len still includes the Ethernet header on the local path,
but no longer does after eth_type_trans() on the external path. Both
the unicast and multicast RX accounting added ETH_HLEN without
distinguishing the two.

Confirmed with UDP traffic between ipvlan devices in separate network
namespaces: five IPv4 packets with 32-byte UDP payloads increased
rx_bytes by 440 bytes instead of 370.

Thanks,
Xia



Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792458744;
	b=2YvgCsEUh+viDq+ieP57y1TUcppZyubUYMpVFDaaODIpxJ0aYPMdXeonyAD3X/6QxUTi
	 b+FVu3tFhBRidjPOitVmDheNl2+mzN7fiA7U4LZGWpBaIxOR0b/xKKbxPpPfq/1QwAiFA
	 T2A06DE7+xFUoFLDEApE1IzsMOBGqbzNI9U+17vKCrh3Zuwezatvb7t2kLm8o8QUNsvCl
	 KtDvxVCkvG6Ha7arKDpEuQS3bT1E1AKAFE/Bu+0tRho4Z/TqeN2M9klPBPUwmZ90l730y
	 3pPP61lqFpecOUUJYG/eVmAkjML6Qia8C17c7gK0dPmPRAeKE5lU+8QYDJG02hqg8Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792458744;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=gkztiRa4rmEUyRx1tOg3Q57r8P48/+lMWD280TOtrgo=;
	b=KXmne3V/nyJsIVcV4KGS7wSvA9h0OWALSVmNKnaSaSy1jXJAX1dcfuxLJ8Zl8NvK+XdK
	 qgdEIljoIILBPNFJK/F0NhYAxN+t5y8+rChAnWCVsd8BG+0eEpowdmKuSWhC1xQDgAh3B
	 AjaryFow90zpuXtPEKPsfiZHrM3oarC0ZN7zmq5cQgN5xGkd9Ah8Pj9D6nJeLAW6yawm4
	 7qJ0EM9XLGrrSj7IR+rVE4lqCS4BS+ecuSgG60HGgyv9LRS4xS0/5HGGPw7xLt39ZCL38
	 8wmQpEhqPq6EEajCnCD7rrEQO1iJ4818KzlNXpyTmt5OTYnlGCht1Z18y1L6630iYMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=S4Ybn0Qr;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8744606A319;
	Tue, 20 Oct 2026 01:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8744606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=S4Ybn0Qr
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gkztiRa4rmEUyRx1tOg3Q57r8P48/+lMWD280TOtrgo=;
	b=S4Ybn0QrRqvtioDlcTH9hrRH7L61Jz42yMo6DiG+7Ribu3FOLdv6YZxebVghx9ylaS9jsIP7c
	D+nvLaJKftShjXXxqnZZ5tM2QVIyGcd6hUPWvxI+Ur8oJjA6rGx5YHycYZND1b+dlACdnP3Y67J
	lxXvxDye8YiN1HmmQN0/PbY=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j7vXC5xzrz1prMk;
	Tue, 20 Oct 2026 09:12:11 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id E57C440577;
	Tue, 20 Oct 2026 09:12:14 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 20 Oct 2026 09:12:13 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <bigeasy@linutronix.de>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <stable@vger.kernel.org>, <yhlee@isslab.korea.ac.kr>
Subject: Re: [PATCH net] hinic3: bound the Rx fragment count to MAX_SKB_FRAGS
Date: Tue, 20 Oct 2026 09:12:09 +0800
Message-ID: <20261020011209.13736-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261019221306.d6dfPY_y@linutronix.de>
References: <20261019221306.d6dfPY_y@linutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> On 2026-10-19 09:10:37 [+0900], Yehyeong Lee wrote:=0D
> > Thanks for the review.=0D
> >=0D
> > A well-behaved device can't reach it. rx_buf_len is fixed at 2048=0D
> > regardless of MTU, so the frag count is ceil(pkt_len / 2048): a max-MTU=
=0D
> > frame (9600) is 5 frags, and LRO -- off by default, capped at 32K when=
=0D
> > enabled -- is at most 16, both below the 17 the array holds. Only the=0D
> > 16-bit length field in the completion descriptor (RQ_CQE_SGE_LEN_MASK)=
=0D
> > lets a device claim up to 65535 bytes, i.e. 32 frags. So it takes a=0D
> > device reporting a bogus length, i.e. broken or malicious firmware,=0D
> > which is why I treated it as a robustness fix -- I should have said so=
=0D
> > in the changelog.=0D
>=0D
> If this is something that in general opinion never can be reached then=0D
> it might be something to target net-next and not net looking like a fix.=
=0D
>=0D
> > I found it by code inspection, not in the field, and I don't have a=0D
> > hinic3 card, so it's untested on real hardware; I reproduced it by=0D
> > injecting an out-of-range length to get the KASAN splat in the=0D
> > changelog. The netdev bot asked for these same two things, so this=0D
> > answers it as well.=0D
>=0D
> I see. That KASAN splat makes it look like something that was really=0D
> reproduced. I assumed jumbo frames and aggregation at HW level.=0D
> Just because a field is 16 bit wide, it does not mean the hardware will=0D
> utilise all its fields.=0D
>=0D
> > You're right that the bare drop is unhelpful. It only surfaces as=0D
> > rx_dropped via ndo_get_stats64, not in ethtool -S -- hinic3 has no=0D
> > get_ethtool_stats, and the stats series in net-next doesn't export=0D
> > dropped either. I'm happy to add a net_warn_ratelimited() on the=0D
> > discard path in v2; it only fires for a misbehaving device, so it won't=
=0D
> > spam a healthy system. Let me know if you'd like that.=0D
>=0D
> I would suggest to target net-next if this can not be reached and is=0D
> just there to address a possible overflow. Maybe a warning if it was=0D
> reached after all. Fan has probably an opinion here.=0D
>=0D
> > For reference, eea does the same thing -- it drops once nr_frags=0D
> > reaches MAX_SKB_FRAGS.=0D
> >=0D
> > Thanks,=0D
> > Yehyeong=0D
=0D
Thank you very much, Yehyeong and Sebastian Andrzej Siewior, for your=0D
investigation into this issue. The current hinic3 driver is a basic=0D
version that does not yet enable Large Receive Offload (LRO); under the=0D
current configuration, no out-of-bounds behavior will occur. For packet=0D
sizes reaching 32 KB or even 60 KB, we have a complete solution that will=0D
be enabled in upcoming submissions. If Yehyeong's issue is urgent, could=0D
you please provide more background information so we can assist you in=0D
resolving it.=0D

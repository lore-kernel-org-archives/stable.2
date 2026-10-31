Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417558;
	b=M0bD4UZFYJFdcFHGmSD4fKX/2FYZl8rzctsxl2k/xnOGhoBgHf9+tKgTZDAtXlonZ3js
	 tp4YGnQyo+qe9eYYpzshS9U0dGRwGKJYjc9EhD7U+gd5XSLVED8fkNlA9jELGKPMSh52V
	 ZdvaSB7V/rauJN+FpnkO1I2K+veqMqwj5NZxsAbDslYTp3yRi2bmvZyPK8dP2Zd3u8ZuU
	 uzkGpgAhCecVFLO0YZJWS9WTtyMn5edt2hzO80tWknbF4lmoCtQ+kHs85p7nGuYXqbozF
	 NoN24Xk4l2w9sxwJgj6T0mFqscaxRiCtBGD/w2feFe/vMxI2I4Te6rPxDA3T9jIXTXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417558;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LLh0hMSYPClbIaAf9ZWKusyEJ2zo/z5lG9EbIZ0BBxY=;
	b=mJ0g1oG3jJizr95UnZaAyO5YeRunIfX8gSz5TUQCjUrRDiQAVqEC7LMBVZ0pcHZdwI7A
	 d6bE0wO2s4IZh5Ap0me/pAoHJtyGJr3NnpZZqOvFyjibosp0F0mwTrwasxyMwehyGzNn4
	 APVKfT4aoyBqkUkURFK2OEe61ZgVPOpcuBgq4F8CsyFuXNikvmpXpVUBNoL3+FzxGsR6Y
	 PMG4w0LL53rlwPQuSB0w0DHXOxGkfauIILKSEpSVj3DyXnYBHM/apu569h9KXb2oPdjcn
	 JT8IEi5R4qC/EJ9/ajQDBE7qL65Ps0Cwt2YJpCoEJ0AuNIb+wJKoSbO7KYywM4dccHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=oSmS8zJo;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468C6606A31E;
	Sat, 31 Oct 2026 03:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 468C6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=oSmS8zJo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=oSmS8zJoUihLJyxyF2z5/tWOTkRlnU7PWYFE8k77sbKL5Ocn3ukKd782noKAleWDh5xLpURs2z57S
	 kvn4d8jqw+qCpbPOT5GQxtLD81zIofBkyBcuc9bJgnmEYvK3B8hmzOq08ATclaoGQyKQzkNInHb51n
	 T2XUHO0Dnmda1PQ0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36ae56142cb1-44d1f;
	Sat, 31 Oct 2026 11:32:33 +0800 (CST)
X-RM-TRANSID:2ee36ae56142cb1-44d1f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[222.93.19.82])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26ae5614f123-76365;
	Sat, 31 Oct 2026 11:32:33 +0800 (CST)
X-RM-TRANSID:2ee26ae5614f123-76365
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: Re: [PATCH net] ipv6: fix cached route reuse for SO_MARK control messages
Date: Sat, 31 Oct 2026 11:32:21 +0800
Message-ID: <20261031033159.2712-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <willemdebruijn.kernel.6ba984cf38a@gmail.com>
References: <20261030141435.779302-1-yanxia@cmss.chinamobile.com> <willemdebruijn.kernel.6ba984cf38a@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Willem,

Thanks for the review. I reproduced both on a 6.6-based kernel.

With a connected UDP socket and a cached route, an IPV6_TCLASS cmsg
bypasses a DSCP rule pointing to a prohibit route. Clearing the cache
makes the same send fail with EACCES. The IPv4 case returns EACCES
with or without a cached route.

Under ECMP, changing the per-message flow label keeps using the cached
nexthop. Clearing the cache selects the other nexthop for that label.
Packet captures confirmed the requested traffic class and flow label.

I'll follow up separately for net-next.

Best regards,
Xia



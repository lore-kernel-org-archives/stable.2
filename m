Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189542;
	b=Ml27RumUl4HB+8SNJKVea38Qnwm6qaYNODvsdsa1iGzBiCK15/zEOXUyVpbXApBEe8JM
	 jd6Yd47EpWpoF19CIfCdqhOKGXDvGKY+O4Rmn3Dvb9coGdFz8aDIBaJ8KnArYSaxxFuiO
	 H9r8gzh04ejmhyFOUmTjTH1f9y7qLUz5ck7dCXrjy/OidtHJjGW2ZEHri/7XZPIwsU1jI
	 MM8LwhHwes+97bsd55c3QSZQHiP5xnFBjyTTGvCz4aDTD7OWlr6b9mzLt2ApY/owHu8Da
	 SEuFuyonEGcEOW2vuWx3XWSLR7HPANLSf+Uu/5WwsfbL1bJICmPUPaXV1ifjJnRj0qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189542;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+OK9DbeBognNQm2Uppczdy/4MmLJ1Qm7DUxD2VxghhA=;
	b=4V8YNTdEFdoDptxCynXAZODWBT6RY/xqimHWRVBLYBWmxDsJpaeLFcX3Ub4mISYuoyje
	 lpM12czrzdV5i0nnXUsZ3c3TU6zh4sCEu5yQKtzCUWrQuk+6aaDNc0EGypEXgC69n97OI
	 1NrOrDlIb/TdTlrBkA9awr3fzy4cDzP+rjmJI1+5OKef7GvfGVFJq8y5e0veXsYwWA9oJ
	 egmmXotHJUWSC+fY+RSu9DFum5G51Na2+TJThRl8EYv2uZdk1Obl5E5fADEGfi+Rn2hfQ
	 KGsgwEYZ0B5ZsPlgL4rpZ7RbixnlTHxFFP5WEzjoekl72GJkyyNb9HO+6EWJIDWUZwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=m5yBrWFa;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC86606A32A;
	Mon,  9 Nov 2026 01:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAC86606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=m5yBrWFa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=m5yBrWFaxKx85D2r0pdfxUKdz4+L0/lw50/JGGJjRFILU3SuYmpBQVsrxmzTDyosFUPu//pXARTyu
	 mxdoLu65PvtCoZvZ+/QcQcLbdKJWc8RkVSSw4v/Y7gVDCZX4YkIid/FtpsGCnzND/Panv3mluJVQA7
	 eEnzj0zISyy/3DQs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af128e1877-8af85;
	Mon, 09 Nov 2026 09:58:57 +0800 (CST)
X-RM-TRANSID:2ee36af128e1877-8af85
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.102])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af128df0e3-7caff;
	Mon, 09 Nov 2026 09:58:57 +0800 (CST)
X-RM-TRANSID:2ee16af128df0e3-7caff
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	stable@vger.kernel.org,
	tpluszz77@gmail.com,
	willemb@google.com,
	yana06070@163.com
Subject: Re: [PATCH net v2 1/2] ipv6: fix cached route reuse for SO_MARK control messages
Date: Mon,  9 Nov 2026 09:58:45 +0800
Message-ID: <20261109015838.14237-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <willemdebruijn.kernel.1e0038bcc3ef8@gmail.com>
References: <20261104092240.15649-1-yanxia@cmss.chinamobile.com> <willemdebruijn.kernel.1e0038bcc3ef8@gmail.com>
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
Content-Transfer-Encoding: 8bit

Hi Willem,

> Would this be a viable alternative solution?

Yes, I've used your approach in v3: the cache is read only when
connected is true.

All 54 cmsg_so_mark.sh cases pass on UML, including explicit mark 0.

v3:
https://lore.kernel.org/netdev/20261109014400.9025-1-yanxia@cmss.chinamobile.com/

Thanks,
Xia Yan



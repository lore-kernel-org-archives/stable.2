Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931229;
	b=IMUuvlRSHBULsZOPIMRPUg6XQQTZEf3/yxFfFGQxJWX0OFK7wn1/c/EMV/5t8SHcKnTr
	 Rr0n88XLEM2XusXYMu83VLaNBFLwjiFwJyuNGvYwQtRZ8AsoJ24CL0Rc+k2TGPKzVDLac
	 fzWnNJUA5n2cT/0BiLMxurD/w6lgx9YH1qsbfW7LFEHdceEhRUN4z9+oa9zd2Ah0l7ors
	 mh8IRa9aVhimwJ0lY3xDfbc3e3VvaYjl0zPPD/PyhUzkTegzUb22SCzdKj+FQ8Wu36e/2
	 1Knx8bydvOkoexdfHAx1ZCOk0VUWtlPzYNETF4pMwkRC7Gxkq7W0y4AHBnJFngaiiug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931229;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yBKPSv9wPtgQc2D10+KX9vKSUfiTfJxDfSRld3KeklA=;
	b=d3TiDhl2gMFXnDdL9STit6T08Wh+qMvugNb970CJ7iKyKgEr8zmNz9AEocsbrtycmVUp
	 4yCbdXSsTlz9R7hsyu8WRnF1mU6IN6+UNgn0Bmr3W/xxvq9DdC1LY3EW4wu/3NX6kO56M
	 DCpIYpFFBJc6VQa2ogHYYZXkWa2ACpoOtjUysrxIkX6hkL7McVwHn6G0d0zh9VG9QDtxq
	 26xCkL2FtdbNE4QEVmm+fXL8YNcL7n/ISRMN3jcPWlViXtqQUpG84LuNaqQET6PSLe7h4
	 0cQ5q+IC+bdl8/QbE3+/UVq21TPAjXU1I1iAgjuJpJ2K904hp8ihLEThwZW8jaCEa+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tHl8gJ+0;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4486606A31B;
	Fri,  6 Nov 2026 02:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4486606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tHl8gJ+0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=tHl8gJ+0qX1w8HAaEWi7zluGSRQ37eZ1Y1z03LcoMKFskjvakFRX09I0hAif/JlxOIlswIt+aDbNb
	 xYj+3ZZMPi14vA+dvYWKbGRWDx8r4zB17CN3ccTHlvUYV6opRag1fpiZV7bsWmh7gYjrgBeTb59dsE
	 Hu4CtypZtwl1M+es=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aed37d9fdf-77866;
	Fri, 06 Nov 2026 10:13:45 +0800 (CST)
X-RM-TRANSID:2ee66aed37d9fdf-77866
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96aed37d798a-0dae7;
	Fri, 06 Nov 2026 10:13:45 +0800 (CST)
X-RM-TRANSID:2ee96aed37d798a-0dae7
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: willemdebruijn.kernel@gmail.com,
	netdev-bot+sashiko@kernel.org
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
	yana06070@163.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	willemb@google.com,
	tpluszz77@gmail.com
Subject: Re: [PATCH net v2 1/2] ipv6: fix cached route reuse for SO_MARK control messages
Date: Fri,  6 Nov 2026 10:13:33 +0800
Message-ID: <20261106021245.246267-1-yanxia@cmss.chinamobile.com>
In-Reply-To: <179387153949.488856.16266299848614841295@kernel.org>
References: <20261104092240.15649-1-yanxia@cmss.chinamobile.com> <179387153949.488856.16266299848614841295@kernel.org>
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

Thanks for the review. v2 fixes SO_MARK sends, including the concurrent
sk_mark case that came up during the v1 review. Sends without an SO_MARK
cmsg keep the current behavior.

Willem, you also raised the flowlabel and dscp cases in the v1 review:
https://lore.kernel.org/netdev/willemdebruijn.kernel.6ba984cf38a@gmail.com/

I'd like to keep the SO_MARK fix targeted at net and handle the
remaining cache issues separately in net-next. Does that split make
sense to you?

I'll wait for your feedback on the scope before posting v3.

v3 will also add a fwmark 0/0xffffffff prohibit rule to the
connected-socket selftest, so reusing the cached route instead of doing
a fresh lookup fails the explicit-zero cases.

Thanks,
Xia Yan

pw-bot: cr



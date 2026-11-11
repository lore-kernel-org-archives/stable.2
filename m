Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396890;
	b=kIbk7I8uh6jsu1GfmEVIdQHAetVRhzNgdv96PSfzEf9++l82HNe3OxUsHTAHia3PbNBq
	 cDhV2ezgCeiEIZAilHW+HU9PPKQmvfFogKNsJrjTH15mZ/PnfZD4YiFul1vLWYQXsmAv5
	 1obXLkCWIUmJ3s6jicz1fy/LebY3abk8vLR6gwc9XoXD/60IaG8evNqE6D6TmQY1lDI4C
	 iSqVo44znFv24OXwQU5Kwng6X3kvnH0KEMHP0YFLidULYvVnOTmrudg6qF6RLaiiSiUka
	 G7fUwmu4vQToUL2t5bF2wbGNNMUVI9g6e2v4I96r0iWUN6FvsiP1SfrMqvxp3YyAZGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396890;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Oa9aSrgcQ/keAfGp/EWOhyWjNC/LwhuN4v4uWbRyXVw=;
	b=rYr1rKvscTlnXFo9NNFb08RcCoKtx7mHOD/7tYV5pAib3LSikGySGjg5syt6suELxV7v
	 e84RBOAnFj+2Z72a6udPYyvEfy0WN4F2jbpdAcZ9V2aaON3rRjOQMWHl7QkCx0L3oHrbn
	 J02PEOZ5tIg7Y/nTIfsrXMdeQp7BQRXoQfCFPA4kpC4kTfVAIRh+de58G/J6CO8YiXTGX
	 4sUwQ9AaVgLrUWIHojeWsRkTmwWTqKFrgbABm9yVEYVAV7ADyYxjz+nVjVa547UCqqCpV
	 Wo6Y+HGMajDqhED8k+4klwsArbh8PQVEGeNLChgNkkk0+XOhZTJ9pm9erROppPqGoDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="B0+/Enyl";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C484606A321;
	Wed, 11 Nov 2026 11:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C484606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=B0+/Enyl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=B0+/EnylbocB/N1Citc+8qKIGkYD9v9/alttrLQFqB9zg5kr6o+Ju9BLaSjMTEw/h2HQSYR1HTtYg
	 9cSiCIvGYGJNnyfitc2iMsgLsOpTx2Mpflh4ZAojC8DwT5sGXyAvB1Hu+fRmYU0a7+2Tw6pFD2jrbR
	 9pUBFQuzNpUV14Tk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af452d1b43-ddef4;
	Wed, 11 Nov 2026 19:34:41 +0800 (CST)
X-RM-TRANSID:2ee96af452d1b43-ddef4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af452cf795-dac82;
	Wed, 11 Nov 2026 19:34:41 +0800 (CST)
X-RM-TRANSID:2ee56af452cf795-dac82
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com,
	netdev-bot+sashiko@kernel.org,
	jiayuan.chen@linux.dev
Subject: Re: [PATCH net v2] tcp: fix device binding after failed IPv6 connect
Date: Wed, 11 Nov 2026 19:34:27 +0800
Message-ID: <20261111113428.283925-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110100224.57cbf548@kernel.org>
References: <20261102143352.135769-1-yanxia@cmss.chinamobile.com> <20261110100224.57cbf548@kernel.org>
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

Hi Jakub,

> Just restore the old_bound_dev_if,

Done in v3. It restores the old binding unconditionally on native IPv6
errors, before TCP_CLOSE and the bind2 cleanup. It avoids restoring
again after the close callback.

The UML tests reproduce the stale binding and VRF warning on the
baseline. With v3, the reconnect and both VRF cases pass without kernel
warnings. I also checked the CONNECT/CLOSE sock_ops callbacks and
IPv4-mapped failures.

Deferred TCP_FASTOPEN_CONNECT failures after connect() returns success
are unchanged. I'll reproduce those separately and prepare a follow-up.

I'll send v3 as a separate thread.

Thanks,
Xia



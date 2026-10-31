Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793434158;
	b=am8Lpj2WAQiGoTKjbaA+dy1d1mf7siAvEI39u/WX2H2Yo/J25B9tO+NuUFs0J+lUHU9Q
	 HXB08YQ1xWckkNBUNubUgehJrCqVzuMbw4vTnAtAZNrzSxpOOVA+Eu3yJ1sSZfyMMw8gL
	 iPBjJnp9P4czR9VvVt5iQ44zFXhOp/vI7fwxE2JUY3w6or1w1c1ed7nuFVPz1GEiQYqqS
	 muDr774gAzheogpfc2FirHdnGPxbZSbQA4w86ui2OAd7D/oWlIX5WmK1V56rjcggz1fvH
	 iZHNf8R4RxcI16URObNVNiG7NPlwT70FjAyWQaKMlKhJsO5mIjyjnFS56gOjf2sPLuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793434158;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=RnvqgoSrjWtcRaf+Oi9x1iTIppA0pS994IV9buzFW1s=;
	b=qtLno47KPp5HFGbe1Gstdy6HmJD/JSYUQEprjSoK/OPFt9cy96MbgtiQdkA5FEgMsNRR
	 GTo+lhcUVFFaWmnaw4gw1GDNs3IKyx4PNGQp7sgb6vURKZklWc68CUjWXeu4ATH3iToha
	 CKV9G4eGSJl0fuJctJjjd9KLIsVxjq1nypfDzMCqqJPCEBq+5uqI5Jyt9eNesKmoQsA/e
	 uKRBpIxhVEL0836thXyAa63DMCXaf38Y25Bbe96wz3lC6G6cvykkh9KjmsvpGx6e6g5Tx
	 4gf2MEjb/pMfDWjb/oaW1M3NoihD4qO0SzgWTvIjosIwMbY7yfNXnm7Uy4SoSMD2P+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ugreen.com;
	spf=pass smtp.mailfrom=ugreen.com;
	dkim=pass header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=tGHCZvBU;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF68606A31A;
	Sat, 31 Oct 2026 08:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAF68606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ugreen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=tGHCZvBU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1793434084;
	bh=RnvqgoSrjWtcRaf+Oi9x1iTIppA0pS994IV9buzFW1s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=tGHCZvBUxYwfGQYKElZjMKZBk8eLryqTfJzbCKGnakvz9FqcbW14OR8pVmlCqELzv
	 kpQhd3KCv2jZHkT79bv/cIS8LfpKdPkLqsGkD2gzlBfUPySiEwouFxIyn5n+xeFmqd
	 fYGtHIguZRoYdIWzprJptq6b2nLtMA7AytB+Hugs=
X-QQ-mid: esmtpsz18t1793434078t1649ccbb
X-QQ-Originating-IP: c8GaQ2EYajltn3AmncXnv8Yt3WeNED7CfE6+ZY7iBSs=
Received: from exmail.qq.com ( [14.153.241.169])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 31 Oct 2026 16:07:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5247943412128054743
From: Hanson Wang <hanson.wang@ugreen.com>
To: netdev@vger.kernel.org
Cc: Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: atlantic: stop TX again before freeing rings
Date: Sat, 31 Oct 2026 16:07:49 +0800
Message-Id: <20261031080749.3688666-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031032308.2991494-1-hanson.wang@ugreen.com>
References: <20261031032308.2991494-1-hanson.wang@ugreen.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NdaCjfXsdP3wlt1RKLf7jtqv97F5vtNq70Fvrawe+X+PK3yNWyFzsAxh
	yGoQVA4N4uGwjp2mxlKTRGcz2isIyzn6Lo2J4JEMML25Gq/zizrfbMTbVs9MvQBDOuyWzEN
	VVZuj+Gjt/00d+XEz3aaQzSMSr2EJH1v9Z/h6upRL6V4AxekCb1LNIyRY0F6S70x9JXSaV8
	UliBrBf95fGa0R0PiFhyAZcp1/WU/0bihgzdsIz+G3g+t35+iN55tFGQYOflf2bQq8HsInz
	5wf35inqvNRMkYm7k5Ff3qktDPYzLxfII1WDujYO2PljxLNAFiehxXFa79SYte3pUbEIMmj
	sjLNW839NIoNJesayEe3yMZwFJMDOWi/o0mV31bccnImnJ+cevOdYJ1vo+Xk6XPJHz0EPmq
	YEeqQg7LTPVALip7KGd9AZAzMklJaIOcJZlBLpguKOMk2pkUeyORb5DTSCFplRjJt71oU1g
	JCYUOWSwpocSIVoXHRQyW644mZ/GQPDsRSjzkSHXAww//J6V3cnuLR22GmnJ5GwSaAPCO7m
	80CYBrDuK08OLWbUmVvRSB6nyDyOuJktcliEHl4BH3sRE1gV9TpdsPjaRyrSe6wxOwu+VRS
	hZAv6YCyRDpySSfUcshZh1uGSzD3Vjh/TMgcbvwcDKIyLkQz9LXKbcji/2boxfZX8zgrelS
	L8Vob7peJtOES039iE9odh38Dkqw93r9MF8JXYEH27NJ0hFjwQclwCj4fGYqPTu0USQpoxo
	2dTkdoH/OhCcyb9ngSeC87wsbLIIR4vJ28gGHLcFhhns6LVy4caIAwhj6Y5NH7V9AFZeq1f
	W1SyuXP4szqQ3CgmcqTTMcahu9gl6Fc+rheuOM/3jGYQij4ynuMiizjgI+aPIQET1KtewzR
	w6sRk62XJm/vbVX52weuknz/oql3MtnncJu/HvPJTtkccfahzV9VPd6CaDZnucZ4lrKdihs
	ZURpan/67ru+0SJsTI19txF/4B4JzHlOLolvYSJQaN13a853Bgzw0CZOYb7OBURXmm2Z8Jk
	K2ybPR5VduMWjvOKEU
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Igor Russkikh is no longer at Marvell. Cc'ing the current atlantic maintainer.

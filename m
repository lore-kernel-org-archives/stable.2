Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795247765;
	b=RQEp9n0m1neGcp06F1yxsAsAhXDuERgNhzFArjS/ujej1W3IoUfdiCN7c3Nk8YICcypj
	 mzIfMNf+VRmgx/nw2jSgwUYCNFmx2Eo4oISjndW2WU9d4zZLf1rO0HAGsG4q+/dT2SBcH
	 PGQuMDIEy4tKxL1FPMZZg791fJh+r91K+3prg117wuqCkuhNpaOMddvhTJRaX2d3YouwP
	 EpXYHXLli78ssqw9kv+Vkq0n6lj8wuci8xgBNSHOg6fgE85KAPBdbkArnMdO+Fl6Crruv
	 7oVCoGd/or1XUQQ8JeBcpPrWOTFFtqql/QJAL0CCK/aJioWxW1QrKbKwmpwyVObEWhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795247765;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=7mxM6MIDH0aR1FQkJ1yLZRiYvWzEi04wwfe+JsQjwbQ=;
	b=4DL4ngGZVYlzwxQQ6NyOhIWFv72xHPnDfhn0g2F3j3B6Gj8WB8MnJ0XjQhu1h9gC0ie8
	 R4O9x7QRaybTBxE+jny0VcqylBVZmst4lTKTe0K8zr1Th+5SynkVG8DlQn7W9CgrbBTJF
	 bDUWgnMhOysgfY88tb1nynmBacrmZfPTKaIaJqu7BM14o8Y+vRMURUwulZ6djFntlnVhD
	 Oyx7attlrCTu6nyk0tuzb9pvFQao549YHfXbvsgojJboIKethV0LMV1T0gjzqOh0y7CL7
	 W5Wzj2Xlmw69R7LyNkcB5btVo61JME/HjPBw12vbDToLlnIcXjD1ni16YeDRDV+XFHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=TcRsveG2;
	arc=none smtp.remote-ip=203.205.221.153
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C9606A325
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 07:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F18C9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=TcRsveG2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795247755; bh=7mxM6MIDH0aR1FQkJ1yLZRiYvWzEi04wwfe+JsQjwbQ=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=TcRsveG2AbrsnaqpYfnks4PIZv+TQlPwTYUg8Io8uS1zdyW7GHsbvJ3vNRh573J0Y
	 x4KS5rMEXdgQoEuF39Mi+cdaC6LEcfCsxuc0dyk0JV9vQ2d9CMASUVKQAA7qLMJdg7
	 KSI1KrmrRhjFOtZO/8hx6oMFrle64+XZNCAEL0Vs=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-XMAILINFO: OSyReP17gB4cKQmSsJziajQRELaeaISQ14wOwDxwAF59+KLu8xv/uYqLReyat3
	 4Q3UxgGiGdJ3F6udmLTZez07vwbyQsy7fyZIckjcqljemmB51nOiP3Q6DGazjoGovuiy6yfVg1Nqz
	 nmH7EXEtISq8zxAn1vLcsz0TkwgSF18cYPfb56EH+ksnTdx/OBgXktG6E8V+330TXEwcXCX0mYZlr
	 VWdmgci9U4mJNKRJAW5Das2ay1Gh+yKV/iYfoMUbFBrlNwD4upv1O+hoF5BHrqnafPNnBFy/vQO2J
	 AwlNRDGHa5mtBpDxwbGGDkt3MO1njO+F1xv5m/Th9IKz9MS8RHiC0K/KzBYd2c3fFIFWSnnA+UMSh
	 siG/g+9TK0l2HthiuXyP6jgINzxrSxgXDI86EH4pV+dB4iyiFS1bg3pySa8V0s9O1blCOOYBM19mR
	 Im8UY855tvXBowbO9mXFr8SJD8n3uznWfGnbscZeFmA7WOzrO4EYTtuZsg4fUp+DqH9xjcMgscmv0
	 X1eueaKNCYxw1zOMeT0qvsL5VNyvaP/w+5DlYDmbGNR1eePXNwO0MMhYaRKyah9wCG5b46dccr2EI
	 daSQo+laKcjS3lrLDJWyAJieIZX7OPK4Gq0bHqlx1CoiLv1OHLqLLOoSclCJ2U5PZaRn+0dsN/fgH
	 2s+NXvv7Eqwkb4cRuwFtTwDt0iAam6TTt+Qf+MQI6b3sWPxT41E6DH7WpoUDMTEFdP2Ny+RrhQ5tb
	 qsD5X7XqGFHo+qNmpJ9gqqTz3gM5lSdJWnZgKVW/2KpKi9Ba5loX9yjyt1MBecuIweVATvLIskWD2
	 LHON63qGPDtdLqDrnTHXhtK3sIIHlnmaUSxb1282+hgBbhkCTQrdSUxQxpT2rCk0VPDHo25SMyhnt
	 LOBe+shDZGeMdGb12rvlowB3jUws+YMM2k3qrtjWy3K2Jj4ciZJabYLeSYT0s/LRSI4hIQQEMDOKt
	 N3UcJd2wBxZDpMBjVzhlDGbs7LvWt7Ri0Ao6Dfj0PQRtww9dE3E181bGqnXczvHWwx/1QuHdPgT2W
	 PIUm7gMeBNLM5Lqg+Z/x1CproSdkDVOoMZKdUw1CYA5UvmVNB/GOuzA5IcMGYv27vhAEpmnwXYBtE
	 CgotIPiIoHlyfpyYI58Sn+Nl
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzYXNoaWtv?=" <netdev-bot+sashiko@kernel.org>
Cc: "=?utf-8?B?bWts?=" <mkl@pengutronix.de>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?c29ja2V0Y2Fu?=" <socketcan@hartkopp.net>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?aG9ybXM=?=" <horms@kernel.org>, "=?utf-8?B?Y29yYmV0?=" <corbet@lwn.net>, "=?utf-8?B?c2toYW4=?=" <skhan@linuxfoundation.org>, "=?utf-8?B?cmR1bmxhcA==?=" <rdunlap@infradead.org>, "=?utf-8?B?d2c=?=" <wg@grandegger.com>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, 
	"=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtZG9j?=" <linux-doc@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH net v10 05/10] can: rockchip_canfd: cancel bus-off restart before closing the device
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 21 Nov 2026 15:55:52 +0800
X-Priority: 3
Message-ID: <tencent_A569B865F0120446D40306100DFD749AAA09@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261119-rockchip-canfd-restart-close-v10-5-df23913aa33a@qq.com>
	<179521933978.3131.189047644390163242@kernel.org>
In-Reply-To: <179521933978.3131.189047644390163242@kernel.org>
X-QQ-mid: xmsezb41-0t1795247752td0sekuhj

SGksCgo+IFtTZXZlcml0eTogTG93XQo+IElzIHRoaXMgZXhwbGFuYXRpb24gY29tcGxldGU/
IExhdGUtcXVldWVkIHJlc3RhcnQgd29yayBkb2VzIG5vdCBoYXZlIHRvCj4gd2FpdCBmb3Ig
dGhlIGZpbmFsIGNhbmNlbC4gV2l0aCBhIHNob3J0IHJlc3RhcnRfbXMgaXQgY2FuIHJ1biBh
bnl3aGVyZQo+IGJldHdlZW4gdGhlIGVhcmx5IGNhbmNlbCBhbmQgY2xvc2VfY2FuZGV2KCku
Cj4gCj4gWy4uLl0KPgo+IENvdWxkIHRoZSBjb21taXQgbWVzc2FnZSBzYXkgdGhhdCBsYXRl
IHdvcmsgd2hpY2ggcnVucyBiZWZvcmUgdGhlIGZpbmFsCj4gY2FuY2VsIGlzIHN0b3BwZWQg
YnkgdGhlIG5ldGlmX3J1bm5pbmcoKSBjaGVjayBpbiBjYW5fcmVzdGFydCgpPyBDb3VsZAo+
IHRoZSBuZXRpZl9ydW5uaW5nKCkgcGF0Y2ggYWxzbyBiZSBsaXN0ZWQgYXMgYSBzdGFibGUg
cHJlcmVxdWlzaXRlPwoKWWVzLCB0aGF0IGRpc3RpbmN0aW9uIG1hdHRlcnMuIEl0IG5lZWRz
IDAzLzEwIGFzIHdlbGwuIEJvdGgKcHJlcmVxdWlzaXRlcyBhcmUgYWxyZWFkeSBtYXJrZWQg
Zm9yIHN0YWJsZSBpbiB0aGlzIHNlcmllcywgc28gdGhlCnN0YWJsZSBydWxlcyBkbyBub3Qg
cmVxdWlyZSBhbm90aGVyIHByZXJlcXVpc2l0ZSB0YWcgaGVyZS4KCkJlc3QgcmVnYXJkcywK
Q3VuaGFvIEx1Cg==


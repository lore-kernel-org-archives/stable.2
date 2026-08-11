Received: from mail-m32112.qiye.163.com (mail-m32112.qiye.163.com [220.197.32.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027C4457AE
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453705; cv=none; b=C1TmnAhEgozZlRbrPBihWWgmHKSLT1OaT2uJGwVSsSm2iGTDXKNAoLKku6Jy0MEi0C2FHP9EWwCuX4uNAT1JVk68XSgAAU+UCoyCWoLRrWSZuEoAdcBms+YlRrU8Hu1yDLW6YOfWPxJvd4ryuxCd+EDdKj6T2EzyttWBcwuWo8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453705; c=relaxed/simple;
	bh=uCv4WWV/SkS+1Kc7tJxMQYIfaDXgev6XfbRRCNwjgDw=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=pVgf5EzbDKNuNhCfHaQZGX+YxhUnHMasOXNP4Q2rdk53FswtXhRJluPMxy6eqTju08sftXLd83bGRg+g0Zjiu45xFxcu/2vi+KDRcCxRnFDOd/2khoq5wDxW87F74YiU/B3Q7+c6Y5P9Cxvdwj8yXi7VZgkaGQ94zuvY91M5XFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=iFdUXQLr; arc=none smtp.client-ip=220.197.32.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="iFdUXQLr"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AJkAWQAnKi56swdGxAYI84oA.3.1786451567411.Hmail.220255722@seu.edu.cn>
To: Simon Horman  <horms@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev <netdev@vger.kernel.org>, 
	andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, kuba <kuba@kernel.org>, 
	pabeni <pabeni@redhat.com>, sashal <sashal@kernel.org>, 
	zilin <zilin@seu.edu.cn>, 
	"kory.maincent" <kory.maincent@bootlin.com>, 
	"marco.crivellari" <marco.crivellari@suse.com>, 
	"felix.manlunas" <felix.manlunas@cavium.com>, 
	"ricardo.farrington" <ricardo.farrington@cavium.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	"jianhao.xu" <jianhao.xu@seu.edu.cn>, 
	stable <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXRdIG5ldDogbGlxdWlkaW86IGxvY2sgdXBzdHJlYW0gYnJpZGdlIGZvciBmdW5jdGlvbiByZXNldA==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_WIN_1.65.3
In-Reply-To: <20260811091539.815827-1-horms@kernel.org>
References: <20260809105715.3669436-1-runyu.xiao@seu.edu.cn> <20260811091539.815827-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 220255722@seu.edu.cn( [222.191.246.242] ) by ajax-webmail ( [127.0.0.1] ) ; Tue, 11 Aug 2026 20:32:47 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Tue, 11 Aug 2026 20:32:47 +0800 (GMT+08:00)
X-HM-Tid: 0a9ff0cd34e302f2kunmf3b7ffc1dae8
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTUS6Y2fHkyPT6dc03QDwVaZPGiA09TnwhbhTj
	hLfuFZO94YXwX6xgvkjGVFFRKj5FTlUp4ibMu3LjbJqkzUirKIkshCL4DwobCwmqEl+iToklIC+5
	oJ5WddS7xBApRMVj/KXqF9KFKHuMUpDM645Zo=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHkhLVh9MQh5NGUNLGk9DT1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVU
	JCSU5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=iFdUXQLr4cIT6ta+EMX5Kjplo/jSRrJKxdve8sEqKRcT/KbogKoq/KLKhKS6lsL1oYlk0Z+7sQhtHcLTyV5LcMXTxfBa7BKxFQI7gcUPPicL4sshfO65I2vMsMBrwWNMgvyqYKbBvvyGU1xn6zvkXm4cNX76NhAcWqmBz3+yEE0=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=uCv4WWV/SkS+1Kc7tJxMQYIfaDXgev6XfbRRCNwjgDw=;
	h=date:mime-version:subject:message-id:from;

SGksCgpUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCByZXZpZXcuCgomZ3Q7IFRoaXMgaXNuJ3QgYSBi
dWcgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLCBidXQgdGhlIGtlcm5lbC1kb2MgZGlyZWN0bHkK
Jmd0OyBhYm92ZSBvY3Rlb25fcGNpX2ZscigpIHN0aWxsIHNheXMgIlBDSSBGTFIiIHdoaWxlIHRo
ZSBib2R5IGNhbGxzIHRoZQomZ3Q7IGdlbmVyaWMgcmVzZXQgaGVscGVyLiBXb3VsZCBpdCBtYWtl
IHNlbnNlIHRvIHVwZGF0ZSB0aGUgZG9jIHN0cmluZz8KClRoZSBkb2N1bWVudGF0aW9uIGlzc3Vl
IGlzIHZhbGlkIGFuZCBwcmVkYXRlcyB0aGlzIHBhdGNoLiBIb3dldmVyLCBpdCBpcwpzZWNvbmRh
cnkgdG8gdGhlIGxvY2tpbmcgcHJvYmxlbS4gU2luY2UgdGhlIGN1cnJlbnQgbG9ja2luZyBhcHBy
b2FjaCBpcwp1bnNhZmUsIEkgd2lsbCBub3QgdXBkYXRlIHRoZSBjb21tZW50IGluIHRoaXMgcGF0
Y2guCgomZ3Q7IENhbiB0aGlzIGFjcXVpc2l0aW9uIG9yZGVyIGRlYWRsb2NrIGFnYWluc3QgdGhl
IFBDSSBjb3JlPwoKWWVzLCB0aGlzIGNvbmNlcm4gaXMgdmFsaWQuIG9jdGVvbl9wY2lfZmxyKCkg
aXMgY2FsbGVkIGZyb20gdGhlIHJlbW92ZQphbmQgcHJvYmUtZmFpbHVyZSBwYXRocyB3aGlsZSB0
aGUgZW5kcG9pbnQgZGV2aWNlIGxvY2sgaXMgYWxyZWFkeSBoZWxkLgpUYWtpbmcgdGhlIHVwc3Ry
ZWFtIGJyaWRnZSBjb25maWd1cmF0aW9uIGxvY2sgZnJvbSB0aGVyZSBjYW4gY29uZmxpY3QKd2l0
aCB0aGUgYnJpZGdlLWZpcnN0IGxvY2tpbmcgb3JkZXIgdXNlZCBieSB0aGUgUENJIGNvcmUuCgom
Z3Q7IFNpbmNlIGJsb2NrX2NmZ19hY2Nlc3MgaXMgbm90IGxvY2tkZXAtdHJhY2tlZCwgd291bGQg
dGhpcyBzaG93IHVwIG9ubHkKJmd0OyBhcyBhIGh1bmcgdGFzaywgd2l0aCB0aGUgYnJpZGdlJ3Mg
Y29uZmlndXJhdGlvbiBhY2Nlc3MgZmxhZyBsZWZ0CiZndDsgYmxvY2tlZD8KClRoYXQgaXMgcG9z
c2libGUuIFRoZSB3YWl0IGluIHBjaV9jZmdfYWNjZXNzX2xvY2soKSBpcyBub3QgcmVwcmVzZW50
ZWQKYXMgYSBub3JtYWwgbG9ja2RlcCBkZXBlbmRlbmN5LCBzbyB0aGlzIG9yZGVyaW5nIHByb2Js
ZW0gbWF5IGFwcGVhciBhcyBhCmh1bmcgdGFzayByYXRoZXIgdGhhbiBhIGxvY2tkZXAgcmVwb3J0
LgoKJmd0OyBCZWZvcmUgdGhpcyBjaGFuZ2UgdGhlIGRyaXZlciB0b29rIG9ubHkgdGhlIGVuZHBv
aW50J3Mgb3duCiZndDsgY29uZmlndXJhdGlvbiBsb2NrLCB3aGljaCB0aGUgY29yZSBhbHNvIGFj
cXVpcmVzIGFmdGVyCiZndDsgZGV2aWNlX2xvY2soZW5kcG9pbnQpLCBzbyB0aGVyZSB3YXMgbm8g
aW52ZXJzaW9uLgoKSSBhZ3JlZSB0aGF0IHRoZSBuZXcgYnJpZGdlLWxvY2sgYWNxdWlzaXRpb24g
aW50cm9kdWNlcyB0aGlzIGFkZGl0aW9uYWwKaW52ZXJzaW9uLiBUaGUgb3JpZ2luYWwgbWlzc2lu
ZyBicmlkZ2Ugc2VyaWFsaXphdGlvbiBpcyBhIHNlcGFyYXRlCnByb2JsZW0sIGJ1dCBhZGRpbmcg
dGhlIGJyaWRnZSBsb2NrIGF0IHRoaXMgcG9pbnQgaXMgbm90IGEgc2FmZSBmaXggZm9yCml0LgoK
Jmd0OyBXb3VsZCBkZWZlcnJpbmcgdGhlIGJyaWRnZSBsb2NrIHRvIGEgcGF0aCB0aGF0IGRvZXMg
bm90IGFscmVhZHkgaG9sZAomZ3Q7IHRoZSBlbmRwb2ludCBkZXZpY2UgbG9jaywgb3IgdXNpbmcg
dGhlIGNvcmUncyBwY2lfcmVzZXRfZnVuY3Rpb24oKQomZ3Q7IHN0eWxlIGJyaWRnZS1maXJzdCBz
ZXF1ZW5jZSwgYXZvaWQgdGhlIGN5Y2xlPwoKWWVzLCB0aGUgcmVzZXQgbXVzdCBiZSByZWRlc2ln
bmVkIGFyb3VuZCB0aGUgUENJIGNvcmUgbG9ja2luZyBvcmRlci4KVGFraW5nIHRoZSBicmlkZ2Ug
bG9jayBmcm9tIHRoZSBjdXJyZW50IGNhbGxiYWNrIGlzIHVuc2FmZSBiZWNhdXNlIHRoZQplbmRw
b2ludCBkZXZpY2UgbG9jayBpcyBhbHJlYWR5IGhlbGQuIFNpbXBseSBzd2l0Y2hpbmcgdG8KcGNp
X3Jlc2V0X2Z1bmN0aW9uKCkgd291bGQgbm90IHNvbHZlIHRoZSBwcm9ibGVtIGJlY2F1c2UgdGhh
dCBoZWxwZXIKYWxzbyB0cmllcyB0byBhY3F1aXJlIHRoZSBlbmRwb2ludCBkZXZpY2UgbG9jay4K
ClRoZXJlIGlzIGFsc28gYSBtb3JlIGRpcmVjdCBpc3N1ZSB3aXRoIHRoZSBjdXJyZW50IGFwcHJv
YWNoLiBJZgpfX3BjaV9yZXNldF9mdW5jdGlvbl9sb2NrZWQoKSBzZWxlY3RzIHRoZSBidXMtcmVz
ZXQgbWV0aG9kLApwY2lfYnVzX2xvY2soKSBsb2NrcyB0aGUgdXBzdHJlYW0gYnJpZGdlIGFuZCB0
aGVuIHRyaWVzIHRvIGxvY2sgdGhlCmVuZHBvaW50IGFnYWluLiBUaGUgZW5kcG9pbnQgbG9jayBp
cyBhbHJlYWR5IGhlbGQgYnkgdGhlIGNhbGxlciBpbiB0aGlzCnBhdGguCgpUaGUgZXhpc3Rpbmcg
dXNlci1zcGFjZSBtb2RlbCBkaWQgbm90IG1vZGVsIHRoZSBlbmRwb2ludCBkZXZpY2UgbG9jawpi
ZWluZyBoZWxkIGJlZm9yZSB0aGUgcmVzZXQuIEl0IHRoZXJlZm9yZSBkb2VzIG5vdCB2YWxpZGF0
ZSB0aGUKc3VibWl0dGVkIHBhdGNoIGFuZCBzaG91bGQgYmUgZGlzY2FyZGVkLgoKSSB3aWxsIHdp
dGhkcmF3IHRoaXMgZHJpdmVyLW9ubHkgYXBwcm9hY2ggYW5kIHdpbGwgbm90IHNlbmQgYSByZXZp
c2VkCnZlcnNpb24gdXNpbmcgdGhlIHNhbWUgbG9ja2luZyBzZXF1ZW5jZS4KClJlZ2FyZHMsClJ1
bnl1IFhpYW8=

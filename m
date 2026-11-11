Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434558;
	b=4nN1+8VprxMQjQZ/RG4ozigZPSnSeVAn8kytLjRs7c7RckrDQhN7WjuByDxv9djdbFpM
	 DwZhK8N7V3o04FdhuI0vbRgTYDJUQWUhRFU2oXvRve0TrRYTL61c1se5Sy+8SppToYM8R
	 YIkQL02nCsw/dAwVLOqMtjrHoXj6mXmA6vSztOHkFR5dn8mQ7+FsncKtJNeetAXOqo/XD
	 KxbOEq4Dy57iu9IbKCZtpYNmDOW519V3BlDgvJqdx1T45AiaakDojvrXTscU58E651dHB
	 vt/UIWhha0wlVPi5t+L5dnvE6z9w8K0/Gyn+xsCSC9iMKrmggt1LOEL0wbvEoSY92lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434558;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=JFMs3Z/iN2Hdb1T/zPVCIJDe4FL7xAoxaJZd11ofvs8=;
	b=Sb0K/1sjWgT0gW9phyDs8WCm9ArkcTnuKI1+ST6fL05wssDcD7RbQf4uvXdnZqY9odYE
	 PmKqe0/BHdPQKu9O5aBmndOa4n5OTLILLeHbA8Xbquq5S1XKzbwlNQDNCjkisqQJRmBZs
	 ubfwJX67vtYb72vJGQnlYWk5Ha5xy8EtzIeqEghAhGPi7DV8rK1j+dQx3VqRETbboEjoO
	 JC4QQhwhCSiOzYqnOc05VMMYRK9a224AnKUarVZBa7UxNM5qspe/GAs5gK0FWxf5h1QFY
	 MxE9rZHtApRaEindNaVOek60tfoVl3F9FJ8ZeCxEJUo7kVpVATGb46cXD9v5Q2Ao2DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=gpcpZo2v;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XIvN7cTO;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9F606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF9F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=gpcpZo2v;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XIvN7cTO
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 465747A01FD
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:02:37 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 11 Nov 2026 17:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794434556;
	 x=1794520956; bh=JFMs3Z/iN2Hdb1T/zPVCIJDe4FL7xAoxaJZd11ofvs8=; b=
	gpcpZo2v+BsZT4ltgJcXAVMaYPg+MgN8UiBRgBBjrCE5pG0duQx2bORrcmYnh7IL
	8/qzNJA4P+CAFmuClzCtZH7msjXoWklFnxJa8hWqcO2C00N5MU7vo9sNPHfF6TRB
	3rgkS3MLCb50yrCrSSSemrc5sy3Q3yhSQzHteE6CtLIePzwcVYrXsZnk6Di4AWu4
	0Na+YQd5ye8fsDKPoHDLjxPzZdPfRKwV4fyfg+YyOFpWIk+R8f/kO3Rj6g4JQX1q
	bzpCm7xNVZjaDpNYvwzakgc4XEf61//yzFdSRRYSye1o3wAMp3iU6EzIvBIrg6H3
	O51PEi7/zYXN0Uwgw6nkEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794434556; x=
	1794520956; bh=JFMs3Z/iN2Hdb1T/zPVCIJDe4FL7xAoxaJZd11ofvs8=; b=X
	IvN7cTOjFP878u7YHA5kRLoq/mnP+2nrLzhnVEczEvAxNjTz7AqoqKsjXZEFrUG1
	kmdD/QsD0KVIFRmTJvEhn8egnmoJGUB8GvVkS+dZ+u3CjOrJv55VWjQG13rTUfUg
	Dmc5HccYmn9MyIO9WCkCLR0qPj5WE/UVp+hSKTUB88UD0bdlPCQKbWzxPk+f9d/7
	TXiDfBaSJgG2Kg95StdkqjLxGcp030vs0nTvbr/hfUPXBwYbZr7hGT2n7IM38m6J
	idGcYnp89Z3AVy4R8QsHb+cmq78HigO3iaxLVepCs6LRze71LYiWeflS/iMELTf1
	Seous3c49idXETLd9fDNw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794434556; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DqWfnBtkFPSpC+gbnriDwpQKblSK3IoHiy7Hoxkxp/OOROS
	AaM6xgZZ0nSuLG4dfkA+YEQ+8envRdCmVVd4KOxAwH9kgyIq/fym8YBsTeInZODy
	uFKu02Cse+A7C6kZm2zqj7PLwhGv8MLLf9dfCppvFrDdmpg3O0/26eBTj6s+k2fj
	RSkA7uIAX+hG40q2LZJfvOi9pVqhCDeYZZPcQB+GKnL8WUfx4jwCtqIHaWT/++7D
	ADuFbACca4Mnl+Ntl50kJtRH+MZRug5BJAtIwtfMu6UDuvf5e7f/kXXjLNglRQyC
	pjV5zM6Ccd8UYAhgijViJXX89LWOQEJmrcMm3/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tj7v9dsdS45cy+WsmzKPCZBrhEIL7/YW0qrZj0dKY7w=:060Gxnpn22/WHOoxODIUPFeXrkPZbjwHvUbKBMB9OFY=;
X-ME-Sender: <xms:_OX0ar-2BHHbFOd8eebT8RImzFFRnPXrdvz2McAzPyRMZ0aonAFCGQ>
    <xme:_OX0aig91FDHTHFWIN0cIDJyauQdZLWv6XvXnjZUfkaknlm_wbaK7ivq0cPmXDOMF
    -c7gyZaZXhvbPojucXGMspYgWdwx2I1xtXoDFsd4N6MS8ChB9wPVc_O>
X-ME-Proxy-Cause: dmFkZTGT4eNv0wX3eaPLmZvugYaGloltCuVSG5t+NKeaS6C/wT8FG2euEqG3iSiUpTVl0C
    kWP7K38HdLe/yEScxZpB587oGuVbMP4UlAMgJSx0evt+3ie6jgl+jDZxMeJW7gA3IwCH50
    wGin9tHLSLxYt30X/AuBU1pEnosVBkh1iqfijSFPRS0kqgmiLklDKLiQK9xFGOzzgJ818n
    FDm3aH+RiIglOQfDqoU1+BGKLzjX2M9gWKvQSVz2xbV356tT9+dHgK2T/qVjqn+SwMImkz
    EoQZv4IYqutv5JtIGjkz1MAVJpA8viMdI0uBEOICWCphZDilsFZM9I9Zk9y9nMLWhUmVOF
    vRZ+kd2UuVWG/mC8TQoDpKwtf043CCxkFB/2luNmd5B1ipymJTPI60CHWOTFTa9dGzAKhz
    KD7a5NUGuzELGZJAc5Mq7xQ1mDLAVqvRHJPT0yQnfur/obwgJxZ8ZVcYUq7srFj2sWEwdE
    K27JRfPxZ86NX5jzmdpM/JlvFbbzfCrGN+3xwHbo6icF5h4WwlThg79hSV+O2uf5rOvHAs
    +OHRrw/sqMy2NxxJxjXqjZi5LnDFPZbYinYX9CpkB5bzTUSXwGzpsvRfePwxbE9IVwhgQt
    e8KX63gvXH8/PkUBwzBZ+QHx/5jw7AHaIJ16GmCFGhaC3F8Qm2mjEHPFtV7Q
X-ME-Proxy: <xmx:_OX0at6FWyG6SX_uXpKicTB8Q_NJ6wOCCfkc7SrDfqfA0_ap55DrWg>
    <xmx:_OX0air3r0PTq187WWxMNTK5OgYxWQ-srM3flkd_tfeoA1BzgfwMCQ>
    <xmx:_OX0anh0FZspnKhW4DzRnyUAxbT7KqxHaARtItNyrY-_lxd2wSpnwQ>
    <xmx:_OX0akLo98dLvEhFTsUbddX8On_I3jjxi1oFxYpCDnqq2yD3HrhthA>
    <xmx:_OX0arJQnRhgGWLeHoH4VHuNdk_QL9N7RUfZdHzLR7lv96XBmHUE6wzt>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 938932160098; Wed, 11 Nov 2026 17:02:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AoMJwJ6OSIYV
Date: Wed, 11 Nov 2026 17:02:10 -0500
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Sasha Levin" <sashal@kernel.org>, stable@vger.kernel.org
Cc: "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>
Message-Id: <7ebf9b38-dd12-4ceb-a9c2-4fec9a8cd4ef@app.fastmail.com>
In-Reply-To: <ad33ead2-1363-45f3-a8d3-2e7816b515fe@app.fastmail.com>
References: <20261110191136.1748573-3-oss@fourdim.xyz>
 <2026-11-11-1-daily-reply-0024-b3f3824e55d7379b942d@kernel.org>
 <ad33ead2-1363-45f3-a8d3-2e7816b515fe@app.fastmail.com>
Subject: Re: [PATCH 5.10.y v3 2/3] Bluetooth: L2CAP: Only accept connection responses
 to outstanding requests
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Nov 11, 2026, at 4:57 PM, Siwei Zhang wrote:
> On Wed, Nov 11, 2026, at 4:54 PM, Sasha Levin wrote:
>>> [PATCH 5.10.y v3 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
>> This breaks outgoing AMP channel setup on 5.10. AMP is still present here and
>> l2cap_send_create_chan_req() never sets CONF_CONNECT_PEND, so the new
>> l2cap_chan_connect_pending() check drops the Create Channel Response and the
>> channel hangs in BT_CONNECT. The check comes from a518b9a9ef6e ("Bluetooth:
>> L2CAP: Only accept connection responses to outstanding requests").
>>
>> Could you add set_bit(CONF_CONNECT_PEND, &chan->conf_state) in
>> l2cap_send_create_chan_req() and send a v4? Patches 1/3 and 3/3 look fine.
>>
>
> Will do. That issue exists in 6.1 and 6.6 also.
> Do you want backports for those also?
>

Please forget about this comment. They don't need it. I will draft patches v4 for 5.10 and 5.15 only.

>> -- 
>> Thanks,
>> Sasha
>
> Best,
> Siwei

Best,
Siwei

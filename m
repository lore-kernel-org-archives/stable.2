Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795258803;
	b=DltneWjzX9e9yikxzKRyDQZcDND+8oDMrvn5vxoNr/uYoGyPxKqEgswcJv/EB8Ye5cuZ
	 F0cj8jPJ552sX73mr3BdOlXGD84hwjxrruCSB+tYE2Wsc8DOPmvWWUSgt223n4A6pM3Zs
	 uxCwIzCCRJvQgtCVQyDkjXCuYQjLbftuvU2y5lKc/xgLTJz54Ps/DCd7oGi4+158jTB1W
	 kiJOolW1eIpKbRSl1eXkNVdADM5X3Bl0eXg9IN6wERa61l8aP1/kpAycqIzK/IYNTqGfk
	 jX/4jJc3hgDh1cCBEU3E/llOY3FGdc+LCVsLIcDsoZS0AmbI4nR+ywb4382zw7HT/Ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795258803;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From:To:Cc:Message-ID:X-SimpleLogin-Type:
	 X-SimpleLogin-EmailLog-ID:X-SimpleLogin-Want-Signing;
	bh=mxpwphme3p8/7+XLeJahR1+ecqy/PNzspX4y3gTC0ps=;
	b=IQFi7VmHMNQkvTBd+7YYjzp37OX77BypYWrqC+8bI+Tc2PSvKL1fStvrmokjOojqxonh
	 KK286oRCn+88a2pxtEhHXXUVeSMwb07mQBK4pojdh6GamZTwnfcM8xpBVsRQbOd2LLNcK
	 4UVQCRqJ7FNTOYfF4Vv+W7c1iHCKs6WzfCBOmsiekKa3vjvK1ySzNMP9TNSxrRzfpFdy7
	 g+Wi/uTrmlbfJY+QlEUO2bHyRnl2U16PxEfgc6MDsmGl8EHfoeAGa6DmtlhNyluEwlaE/
	 owmX1OSe1D71/wm1dnVAu9ZSkHG6kj1MekAsbAQft889RLc2gACnbh89jIOiHMWcnxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=8alias.com;
	spf=pass smtp.mailfrom=8alias.com;
	dkim=pass header.d=8alias.com header.i=@8alias.com header.a=rsa-sha256 header.s=dkim header.b=QYWoH2er;
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.173
Received: from mail-200173.simplelogin.co (mail-200173.simplelogin.co [176.119.200.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579A9606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 11:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 579A9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8alias.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8alias.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=8alias.com header.i=@8alias.com header.a=rsa-sha256 header.s=dkim header.b=QYWoH2er
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1795258796;
	cv=none; b=h3a+LJMicfPgCWz4UF4JbXy+QxJBCSIXyUo/w6OYWtV99CSxAYlJ6sLIfK8fIKTrrkAlComdntjLH4yqNNXhtef291VL3MCmTGEl7iFMgRYWBRjILOPMp7TSHOZyFvLTsimQF1cq0Zd/Ys/oQJoog8dXL6bCSJbc5BPBmgNaiGuWW8Nf3Xm82ma9/vlTUH6BsiLi2UIT/meCajjxk6ASJH2xK9STJ5lCcO55ccFrWgLgLXsLNSbqsgh8AbvMCcYbs/6vMU8hP/wqgVKRaxkR1JB5Fr24HgoXKYLRjODyRG1i1Mmqvue6+iam2w3AscVwsmX1snjLL+cL20+gPdua9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1795258796; c=relaxed/simple;
	bh=mxpwphme3p8/7+XLeJahR1+ecqy/PNzspX4y3gTC0ps=;
	h=Date:Subject:From:To:Cc; b=EA9upLh9WiOj3WVqwdsp9J8OofT3eA0ZDiHjQnJQoiaXp355qT5GJqaqn3mp6zazqCZbLPGQBqa6CrZGKTBoMPME3bKjZPYTaFQ/qZHIjW79IDLfAmqPhyo2gyYjmoOcJYi960FcPk50/D+TI9tPzn184X9RnewqClNK3OA9wlNo0bbV9ZpSKC2hDf7T2Rh4F3qnWu9/op27ZSExVfLG7f+K3B5wjOgo/9N1EsoEfpUDWbkOm3bTkMfFhnXnxwXDnguun7M9wQv6qJ/SjL8hx97Lz+Fd5vClFofOmSMIBLBUVqmroceeBkez9uWjPnrbOIvbWYvSvnCZdExYBdJOFw==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=8alias.com; s=dkim;
	t=1795258796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mxpwphme3p8/7+XLeJahR1+ecqy/PNzspX4y3gTC0ps=;
	b=QYWoH2erMYlhx/F290X/HvoP3pwPXxcY/K/IbNOMhUWtoKBIOsPFlruWNuBtQV/i/Njw9Z
	FWU7rusE3g8swhX8qRsBGvRoSLmGp8nd2oj8eMQWbvaBovibBWN0Y7PmldYrKOdj93dgHA
	jpvE8Loa7XYpck4w1PECxfsIvysj6mo=
Date: Sat, 21 Nov 2026 11:59:54 +0100 (CET)
Subject: [stable request] Backport TAS2781 calibration address fix to 6.18.y
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
From: linux-kernel.supreme403@8alias.com
To: stable@vger.kernel.org
Cc: tiwai@suse.de,linux-sound@vger.kernel.org
Message-ID: <179525879604.6.759418222472508172.1791565667@8alias.com>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1791565667
X-SimpleLogin-Want-Signing: yes

Hi,

Please backport ba39a31448857da3b848174c9130b466b3ccddba
("ALSA: hda/tas2781: Prevent throwing away custom calibration addresses"),
which landed in v7.4-rc2, to 6.18.y.

The driver ignores custom UEFI calibration register addresses with
non-basic DSP firmware. On the ASUS TP3407SA, this sends factory speaker
calibration coefficients to the wrong registers. The fix was tested
successfully on that model with 6.18.59 and applies cleanly to 6.18.64.

Test report:
https://lore.kernel.org/all/179364849173.6.15547077920953953013.1741098232@8alias.com/

Thanks.


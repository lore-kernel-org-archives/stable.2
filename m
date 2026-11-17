Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794922641;
	b=ER01NFWmY7OPzo6OHCqlVV3sGbpitopGfDMJG9NhytYCR8qHOhdN+JCJyD+sYM56JXTy
	 Sad7iRI+zPF47omUghPbEvzgSGU/+rTfsl+Kb2YR0Is61Ebbmlsje1nn63/VIwhRZWFLz
	 Qc6qkv+3WCpljWBf4lw+AtzUz0usJdq1ULXbkCfCmRioo5tyV5+tZ+gXRRXcCum/1xXSa
	 UA3OkFWyCq/yA8ssciCYP1SZlGmtOZhvQpgWApktt0aIDXsbHyG8cqxilkopYBzNCGNSO
	 sUqu89/yrbSMzDJHyr/G5ptLXLy5fayR5SOJr2Xpl96DtbKJsvyyQKgtkhIEheEVuEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922641;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=nRITdBhip+rPBa8gXy4noT3SIKJ/ipRLqJOeEQwoUFA=;
	b=KQxhJ4fLXX8qM1MvP38JWlC4P4EVFGxgxugLcWaodI3gWOsiKHYJI9pXSj/ehGWqgOBL
	 jGfKy/1Kn1N17UQFZoSeZesUmc8Drh16v5oFQSb+e1rJ5SriwueDFDNeRvaPjDImHAyWa
	 LKox3wYwhgWBkmWk+J/xQ9JL76F1exMbB1HvRUNRVCFX6M6j+U8iS+ie2sTJCSldK8NqL
	 svTQOSXErITCn07F5YFUylHaNWoAWRkk/xMDnPUglvRO+h5K10g5FaqFdskMx71SzdPTI
	 1wvAoXNZDVZfnufYgb5HpxOyh9r6vckG+DYYQQxib85JV4CJNwwmIxetpKLx1WfurlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PW7Gjjda;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F4B606A32C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 13:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12F4B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PW7Gjjda
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AB0BC4E4156A;
	Tue, 17 Nov 2026 13:37:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 789945FC81;
	Tue, 17 Nov 2026 13:37:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D5DF11BC0026;
	Tue, 17 Nov 2026 14:37:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794922634; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nRITdBhip+rPBa8gXy4noT3SIKJ/ipRLqJOeEQwoUFA=;
	b=PW7GjjdawZqKohT3YbHhB6aHdlEkXLdbLt+fdJzMqQGQoMbf1mrwFjhwdaJbovT6U0mjt8
	YsUSPtTZhp3z2npTvl6CgdJr8Gj+L4zvonIEcVZLMQyee2XHOcmUREIPvBiiKg5Orc3Fwa
	ha4ZuI3hLlCopF02gL8mLNP5YsQXvl2zWxhYCUF+TPFrtJchCBHnUpv9i0o6ie0A+DF4VQ
	HQfGw4pfO+PTP4j6+vgxsWHY9ahkdyNUcy6fgdnRGC4D04YthJpFuytdWBEtLdsfVm6Ig/
	wt6QdvkYlhe3hxyt60LrQhhd50VPYnNQQTlApld7FL4e/1VbkCrbc36YiIMAMw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, 
 Vishal Satle <vishalsatleit24@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261027104345.172612-1-vishalsatleit24@gmail.com>
References: <20261027104345.172612-1-vishalsatleit24@gmail.com>
Subject: Re: [PATCH] mtd: virt_concat: Fix device_node reference leaks in
 mtd_virt_concat_create_item()
Message-Id: <179492263415.2237190.16195566122827499239.b4-ty@bootlin.com>
Date: Tue, 17 Nov 2026 14:37:14 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 27 Oct 2026 16:13:45 +0530, Vishal Satle wrote:
> In mtd_virt_concat_create_item(), several device_node reference count leaks
> and lifecycle bugs exist:
> 
> 1. of_parse_phandle() returns a device_node with its refcount incremented.
>    The validation loop calls mtd_is_part_concat() directly on the returned
>    pointer without releasing it, leaking the node reference on every
>    iteration and on early return.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: virt_concat: Fix device_node reference leaks in mtd_virt_concat_create_item()
      commit: d2a681eed8154900ed66c4f77b32d860b71d44cc

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


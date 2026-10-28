Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179577;
	b=xD9W8vIsngbBNU6N3bxw5ajqdGAY8NBHNB45JW/l6+h14rRZ/3c+QGWXGol5FSZi54N5
	 dyV97C4t3aLfLJRAQE5edzCroe/EwjZSc6cGOxWD/7MMtpjkATuh1+YAPJh/iWegQGc2u
	 HioYzgDR1boGi6a5I8QhgXjCoOmBbnfWgrtr5eZhSUW+yoA6UWFaEn6njmh9DKXnTe2sm
	 fn/9oRTEZI5zkwTjZCfX5kzLT15YeyjONYBfcKEpZLlDw5aO7cRGeM0MYU3XPjhNhB03P
	 nyN7rdXF6iP1Noxu0IBgVy/UAorziHCJnQxd8dUooGd+Xvx2rDtKop6trvVN8VdbfKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179577;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=mXgLara/EjSZuL7Tdx1QXEYE+faTveW8iNhYVRttLls=;
	b=fYbzQ6Eu3TRyaXBFZBBJ02CcwlXURPjoUHZKCb95LxQ2AF1aoA1FLImDtDWvulwBkgJo
	 jcQDy5ENBt8BFJPPg/8rYcihVqxymDzLiGyMkKEluT/XsuR81fy1+f8I+yG2V4U0Be803
	 JasdgI9GUF7u7byzHTizw6QnPks+NEhsDeZ0o6vxl+85UThPRePPLflHqGsIvfAl9ntLQ
	 CPkg5WBmxGmdCxsoNQHqqVJF1/D0ohbTAtOO7blf+WUPHTD1n33pis3FjFREcFhtzCeaw
	 JsmwDZ/DwVvnDtNt9v/tqeUO9SbF3jza9NSiiYTTvwbU+5i2/YaeDPpGoI+955umeCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b="LJKKU9D/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=V3lTxw9p;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C72606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C72606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=LJKKU9D/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=V3lTxw9p
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E72247A0012
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 05:26:15 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 28 Oct 2026 05:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793179568;
	 x=1793265968; bh=mXgLara/EjSZuL7Tdx1QXEYE+faTveW8iNhYVRttLls=; b=
	LJKKU9D/LmgeEvuXLpyUl4QlbpW7qsh4QKLsWzuFC4eYqCKJ/jiDkln8tofVfJhM
	tryiZlErJCtPqmBQUS+hy2kONQEdkyrxlwUxYtaYkGTd+ENoONbE5PlXUc2Erev+
	IJJqeUNsrgvsUTjivv3CRh+WNnKhOnxmSVGg0eSytff0I6BWbIzhzPSdy6ezYN9k
	6DpmrmYupsLVFzjYP45VGwqp/1YfwE1p7zm6AwM7d+9U6e3aAl3M67W05gZaQSoJ
	tk1CJxojdCYpxhMk+I3HuRdZppYP+d5DIZWCN7cXiZwTzryA+HxkvzbAq9LAdqdp
	FmkMcrzl4u1A2zePH1LmHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793179568; x=
	1793265968; bh=mXgLara/EjSZuL7Tdx1QXEYE+faTveW8iNhYVRttLls=; b=V
	3lTxw9pkPygJpBFR2CGu6h46F8CNxWUxiAvwCp6tZ7dbwn4Iqh8CjydfcLitfUw6
	i/T1EKajPgdPwwzDucdFKJJGriSpUZ90S75aIoLgfiFkj/f0O41SOdvUPVKugmph
	pryb4Nfhzp8w1WS3Aza6QUgNtnG6SsTHEuqX8bUoih7vxhF55cWIyqxtKQ8yvwvX
	ITmwFgO1+xEN2DCaIQzNeI3coXOLeIyLnFyPsfO+KcNAJcfGZJthDXh0qCZeNr6P
	ZNmpmsjcy1ES81lRQSSWf/lcJIgDThVHgDAjJbYVNdTgnS9yRD75Dwcl9Sf18evS
	TqDeezbNKuWQctM1Bz+zw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793179568; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:f2XMQOu1YrDQxdKIYW6vN5YH3VTBvwzwVnVz0cxVosbZ4pR
	CHrpN7L3ivsJZiYcNBUsjZ8DSxySsPUwZfqYgsOQ6XlIyWff4F1zmvArerD99vJT
	TF+NBblrgUo7MTyGTrf9yeuvD0a/gkkWy7zY91j3YHxEBsqoNEC+ary1QolY1F46
	IUdaN/Y669KvBNv+WQYUZqn+gj7zFAZRRrP38EKF9kTLpPgsUqX31CrHSRIpHYSm
	cuntrC8hXvz//wHkfTVy5r9klk8JAWWh7REE3tbiWgTZhb502zsEU/e56lPcurpu
	8R/rGeZb3xhOnkhQs9BigXuFN8bs/fxkcaKuPrQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:saPj2h/Hw9sYGEw5Zqovmm3ZpWLyj+iLr/+tFtskkBM=:0Cpu69qVeoPi+PIpa8JnZu9GWjYhDs2WgPddVOBPWpc=;
X-ME-Sender: <xms:q7_haijbVleJ2gksYxeV1z5yyh1PBMteCG9KzgrQ3EQcmr7wPhz8-Q>
    <xme:q7_hat0TUM2snARBownGdFAqihOhCsD_4k7DBVeYi8-DvSE4wX7f-0dFgALmsda7X
    1SKxCII0sCJwLyzW75bxm2vZ4a7u2ZqaLa0lNCBmQx_2bJM4_ES1OZR>
X-ME-Proxy-Cause: dmFkZTGmtGN3K9L1igNn2HhrNnFfGgZuPD+bJanTm7Ujz8pf+4TF91QSm/EPi/lOdAnWcv
    iD2XoGZBWcSO0DqbNVX6wivjInMvhU7k/UKF7vzAmwfqVEtnuqqs5aLftDfxSH39vvP4bR
    mFfS0hbAWlUYcqEqblYRug8o8l9yYzIR8upU0Ff5i4sR0qLLhBTcVKjzLXt71dowyb58mL
    qqMRVZ8V1KrqGyoyRiQAGKNrYL01iEpvrPwPyyPANlCaTMUKdFgiuDEHfskm1t+E8CqBd0
    zBN/vAmtoGIDBb8JawPuQc1hKpWE2ZT5jDcCGiJT72l+xqvz4kF26Dr6VlmDDNrpnW8ana
    GsdPRZwULbXjsF90xG4PzPKFjEyRsGaH3qhhRVK0ZhgRJXxZnerodIQzRxIIv4AEA3L+jU
    dJtB/qA1t+8DtJmU4zgsM/10UBtaQZXzJXgYvHUMlzgRsfSKKGxK0qY9ey7LoZOxCv+QZD
    dybmRz5Ie6uC2BRg72pFgxbazMLOVA9VbVzY7zaj/C9UPE5Ms5ZKESimBG/5YK2Uy7mfL6
    oDdXdPjRx9wGea5xqVuZopB5uV3kr9dAXTCQRPpNy1ckfjp4Z/8CCGGCIlpVVac0JBNwsz
    xrU6EvdFatUMI/hjS7YqOGz+BNqhQCPuw1JdekrcPWxOd+7oE21+wOcDFKXw
X-ME-Proxy: <xmx:rb_hajzG9A3ixH5X1sno3varL_LvMC5p2AYNjVJPlRQroB1OiUZ0-w>
    <xmx:rb_hahzvDwhQ4vk40pEwGAg7xOWbIP-MS0508wsxMStF95KniKuNxA>
    <xmx:rb_harUBVg4sJjPwJVg7mlZ7PL2Q_POuKMcOJJ9x2DbuzYaiXuyDuw>
    <xmx:rb_hagSkrfa5PgjyPXZvy4xYWeJkEDNbDm7oi8O3pMAiRar2jQAQ3A>
    <xmx:sL_hag95RZVbuuEKFfNOoj2DUq6qwQ85KPPzwLEcJC-bAoYRVi7L4USu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C0F6832A0098; Wed, 28 Oct 2026 05:26:03 -0400 (EDT)
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
X-ThreadId: AKkXSbyymION
Date: Wed, 28 Oct 2026 10:25:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiale Yao" <yaojiale02@163.com>, "Brad Warrum" <bwarrum@linux.ibm.com>,
 "Ritu Agarwal" <rituagar@linux.ibm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Adam Reznechek" <adreznec@linux.vnet.ibm.com>,
 "Steven Royer" <seroyer@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Message-Id: <67391fce-0db5-4ddb-afc4-6db0b82b741f@app.fastmail.com>
In-Reply-To: <20261028044828.96177-5-yaojiale02@163.com>
References: <20261028044828.96177-1-yaojiale02@163.com>
 <20261028044828.96177-5-yaojiale02@163.com>
Subject: Re: [PATCH 4/6] misc: ibmvmc: initialize HMC state before device registration
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 28, 2026, at 05:48, Jiale Yao wrote:
> misc_register() exposes the IBM VMC device before the HMC state and
> spinlocks are initialized. A userspace operation racing module
> initialization can therefore access an HMC through an uninitialized
> spinlock.
>
> Initialize all HMC state before registering the misc device.

It took me a bit to understand the exact race, as it's only
ibmvmc_setup_hmc() that has the race, not open(), but this looks
correct.

> Fixes: 0eca353e7ae7 ("misc: IBM Virtual Management Channel Driver (VMC)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> +	rc = misc_register(&ibmvmc_miscdev);
> +	if (rc) {
> +		pr_err("ibmvmc: misc registration failed\n");
> +		goto misc_register_failed;
> +	}
> +	pr_info("ibmvmc: node %d:%d\n", MISC_MAJOR,
> +		ibmvmc_miscdev.minor);
> +
>  	/* Sanity check module parms */
>  	ibmvmc_scrub_module_parms();

I would probably move it further down, either just before
the vio_register_driver(), or reordering the two and adding
the misc_device last, to make it really clear that it does
not depend on any of those.

      Arnd

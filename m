Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794385837;
	b=QFgOt7ohxX0HjsdcL1AP3zsOV726kOBzox2mel822UZI/NUZtyx6Tsr6nro1sNxxtdiJ
	 Zqt2fo/LN5g+e6bMp+jRDVikFv1Zm97Ms9Y5MJmz7PoAI4lFxZbtyUkBmExttGMnTOG9z
	 BdEfrgpFS287CEps5pRQFRMvnUjeixtr65ecjR0ZuxeD4i989INTAfW8RDpji8DB4Ejrb
	 R7+nRUtPuFrQ4xCbBLWfgFyYs8zsxG23LteWvQVMtpDYAwjMS9gXsfJjJxpqnASanoxox
	 ATwTRvH42X/+AsAnUPYUcXalPIMH8ROVv8YtHyEhuhQMoKR+32FPtiioYfLzmXdTF6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385837;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=WZLUhPOgu/Zp8GJ/VO9CF1NMJMRTVwtW3QQYGoyCbd4=;
	b=CCrlfPEXUQ+GAh+LygSsVf3dC7zUg91S/kBQ564l+Bo//ifHm/YnAo7/Irl91QhEDqnc
	 ABftr5t8OKV/5hA+MF1Rdu+7jK/tLqrRtW8siAZgo6opPlq8e4TapWPYb9Jw4wK/YJtu0
	 gDclQaH7OmUxpn8CL/mYPOJHMjb2YvY1Opx1gsZ5RVSsz+yq3JD3L9E+FxKdXr0nuHnea
	 DcqgZemjFlbKlXJQQHt+rUevgYPB9KfuYXnsvaVsVPGkfNXYMR8W1aGgl8FZvsR8qMYQM
	 NLkkW6Mj9E+GhU/eDRk9P131T1zI0q4+FuUN3whQRXUNH1ZBj4vyErHDf0jLBTLsvFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="R/XGonWw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F0606A320;
	Wed, 11 Nov 2026 08:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 223F0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=R/XGonWw
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 13666201B42;
	Wed, 11 Nov 2026 09:30:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794385834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WZLUhPOgu/Zp8GJ/VO9CF1NMJMRTVwtW3QQYGoyCbd4=;
	b=R/XGonWwnpcVCFnliJwQ8gfzJj6VIs+qsayWUS/fEgjUpm2S2W/SjZ58HVLnGJoOrFHEFq
	B9D1fGinFn9xyOVbCv4sFxsn1mcKH/YefEMlemreoJIam8K1fdLIUx5AM2uKjBMDR/vl0w
	5wLVqsyc8uFekrwi2A7jJ92eWDmMcsnFdLJiAzNpFYTgy+c/W80lX7nSdCw9uecuf5UcJB
	dlDtCFWlYSSrUp3/uOsQlO8w3025VI819Omh2afU7wKsD+DVRSotWsHsiOULowVhkVQ4fc
	m6N5xZVi8+4M46VSZZqJELO2lUQU7bdY4n9v0aWaqaTbwMuX9oJJ8X4mIjvoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794385834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WZLUhPOgu/Zp8GJ/VO9CF1NMJMRTVwtW3QQYGoyCbd4=;
	b=JMiPjx82cveEmBXRCwPtoF6DdUEm+U/q9rQAn++X5T5/L2msVraAUrCRi4Q5VxMpkFsw2A
	eoaN1THcxeO2U5E+HWxgfIwupOlrGb8GQA3EJEdZ36/3HDBRhsnYn2KcMQLlHlWofqMxlj
	xkfCTLh5FB3tDtzrHmbH+HePIpYMPgJH6gFX5dA06wBsDhDjdnX/5AXuaV5U9CxCRbPsIz
	pT/tqq990QMxc6mVI5XRd8kdZbNIlH6Lo8sggUFFGqy/Vppr3TIev05w9MOhgIKJoCU/uK
	61InUe0rXD/GESmhiD6N0aAotrMuX/C4F6MQgdKtCAkSmxncBvoaDTHcO1cf7Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794385834; a=rsa-sha256;
	cv=none;
	b=Dn1S43Ww455MeaY8DQXMYnhVErni1xx47v5TLXRh1X24ShJnPwj2NcpaNAJXLfu/uZa4yE
	alU24apeojdpkMZTyruIhGVTgrkkfHpedK778DxucmKxAP1QI6HBX6TxUqRj9vWDkJPGpS
	3OF1qp5pAlI/l46cUH/FRGo+r+RKXdX3VGSJRsNjHaFqeEOZG65J7zHkNZ86As9edplmZf
	OpKK9W580yk/9lPMYLWLyx73jouLyanXDCvjM5FOY/v3M2QTVcCR8TL7thcDR4WYuy7VaP
	f6L8Pl0t2aaQybnQjBaMQsx97B1JBpV+fNNyvGweXc4FCiHz17sDX0WrLVLfjg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xR3j0-003cTb-01;
	Wed, 11 Nov 2026 09:30:34 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xR3iz-0000000FQsX-3ltI;
	Wed, 11 Nov 2026 09:30:33 +0100
Date: Wed, 11 Nov 2026 09:30:33 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sun Yiqi <sunyiqi2@huawei.com>
Cc: robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
	mkl@pengutronix.de, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, luoxiaoxing@huawei.com
Subject: Re: [PATCH net] can: j1939: transport: validate the DPO packet offset
Message-ID: <avQnqSwcwhVIDIQJ@pengutronix.de>
References: <20261105065931.1302-1-sunyiqi2@huawei.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105065931.1302-1-sunyiqi2@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Thu, Nov 05, 2026 at 02:59:31PM +0800, Sun Yiqi wrote:
> j1939_xtp_rx_dpo_one() stores the packet offset from a received ETP DPO
> command without checking it against the session's total packet count.
> An offset greater than or equal to that count makes
> j1939_session_skb_get() return NULL. A subsequent EOMA can then cause
> j1939_session_completed() to pass the NULL skb to j1939_sk_recv(),
> resulting in a NULL pointer dereference.
> 
> Reject an out-of-range offset before storing it and abort the session
> with J1939_XTP_ABORT_BAD_EDPO_OFFSET. Keeping the previous valid offset
> also prevents this lookup failure if an EOMA arrives while the session
> is waiting for the abort to complete.
> 
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sun Yiqi <sunyiqi2@huawei.com>

Sorry, i'll need to drop this patch in favor of this one:
https://lore.kernel.org/all/1794300102.11111.1000002@163.com/

Chaosheng is working on this patch longer and attempt to address
sashiko review points.


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

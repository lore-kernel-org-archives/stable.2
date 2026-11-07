Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794036594;
	b=B+SDPwN+djtsLusZUuw03GAT1VbAUJ7f3yuMD4Kpa2fpaqsLT9Z8Nrs2f9MgW/+hjj06
	 qZdIGgIfRN0kKFySrZv33Sw9rWCKQ84kA4oJ99PhQGpH56tfB6JaLCJk9P/78/iyWS5fA
	 27jGOzhJceMM23OUATb2VFA8+fKlzF3DGe3am/NkMmfz1pAqhVbc3sD9FRIpzNxsN6pBv
	 AIqx1IZctxxEMtTZv23iug9pi8XS0N9Wtw9KxcO0llTXgB1/Cn3/b88YBtDJBN/CLmelZ
	 5uhRAMFUp+Hj42tJ6pd1noIlkzMgaOWQTQOTJI9sd9a8huKIxmwQ3bzL6PaauSy60Sw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794036594;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=zhFos9pLRdck+HNko2pfxCI2Qo5ud3StbNFSwWcCUlk=;
	b=U0IB70KTcnCcJfQ7JxQBpI/TUqENNqmboCxen+jff6HPMEO61GQhrnwQ6l4zvxqzkcCm
	 6oBc6FVB3nWC8sngqJ0aI8voeWq2YRXQ4E7jpZkmOLrQwj/+6W67hWopBymlrT10WGVja
	 +FIDyCbmo6xDcV/nuSoVjEXl1emIGwtEOuvipxKBMb/wRDwJq+Zb4FEl0pPHQz7YgMPmu
	 ARkp1Ebtm5jL6abfV54Tw7+Y56XvgOsdKBOrP30+/pdnEu+de6uS4ZhQNOMOEhAKmMs0I
	 GZ/VcdjprCTOP31C5L+qWI9zS/yidDYBpHyvN9Tc8FhPw5iThx4spTLDM79l6Ck7YeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PUKk83Ya;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C50606A32E;
	Sat,  7 Nov 2026 07:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8C50606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PUKk83Ya
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 615392006B6;
	Sat, 07 Nov 2026 08:29:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794036589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhFos9pLRdck+HNko2pfxCI2Qo5ud3StbNFSwWcCUlk=;
	b=PUKk83Ya5v7q1FFEP1aHvP7tbTC5KZFYVU6QFtcHISJXJjsSTcPOdtvVV3O583Rv91h3nT
	Ho9cpdbjiEQCnwxb433cxmcqgLNhkOawa6Ssy51WjV9x6UCDW6UAkTwkou+HMIeIkB2Y/6
	jOd59yDr1glR3nmTkV0PiKgiku9KLqOoj0FhYqC3RAeZ5gzVmadDTQo6/caK18RWxVXUDz
	QJar3yTFVo7VjcZXkDYdQneaJXqTTGnHNmVCwAhFU4doCxUol72QIUU52nCGeBSzlhlrwJ
	8XACFmyXoQi84QvLOtVVYfZMjjOB+Yn7PFDMs9qJIjivFXgkT72CnBmwKjsgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794036589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhFos9pLRdck+HNko2pfxCI2Qo5ud3StbNFSwWcCUlk=;
	b=EhF7yMhuTpptWCWqCmCx9FhL3Nv1ftHkLv+tOyhjQlMeIDXAMulTO3+EJ5DYEFv1OnnsjG
	ex83l6DnELlN8NXZv+x2DfmfVVd6ChjuP/vW5h+c8+3oKHQcBcbHacQYUK5hCscdcZSYk5
	OCNs9mqU3wRbMfU3+2IgySYIwx5h+r3kbXC7ADGCzOU0wL0eKdHDBMiNBcWAGT856+L/Qr
	t49au/398GGcvPMoirnpQtFC4WG67j+ZakSAzhh33oWZTR0qbqB98rcu6kD9yJwHoyTA2V
	1ZTaCSLs7wb9eDNEykOX+vLz3Fpe/g/hfu76lJSxCci9GES+05g9yriznthzTw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794036589; a=rsa-sha256;
	cv=none;
	b=Dr2oArMp/FV3NFobM9t7qxTNEhceCyP4DhRDPciFsHYFEFhsNbAj87fyFdma2epsdVvdAQ
	GnF9QhGEnuLq5A4ZOWdf7jZuztbwRLpx3ecHJtugmp8HUbv32lwUnIqPh8qpvgFq3Lzyx9
	0pQ3ct1VJoid7qblsJYk2XIOeij7rxhjwHPLmyJyLElpNe/e0VYvUkmwc9mT6+ysHcoF9j
	1lCtJ8pHwFL8Z7WiZruV1ViI7dR0HyQzRqgjU0Y5USOu2O67J9t2aEDbIQ2vySf3i8kAXz
	8Tj2xkFAvubT/H7bRMcrtjXtQL6mgPTNYgr36QD0GLXPMiFFQ5wL6dyW1NfmdQ==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xPas1-0031FW-12;
	Sat, 07 Nov 2026 08:29:49 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xPas1-00000003HIZ-0u96;
	Sat, 07 Nov 2026 08:29:49 +0100
Date: Sat, 7 Nov 2026 08:29:49 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sun Yiqi <sunyiqi2@huawei.com>
Cc: robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
	mkl@pengutronix.de, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, luoxiaoxing@huawei.com
Subject: Re: [PATCH net] can: j1939: transport: validate the DPO packet offset
Message-ID: <au7TbcX4A8LqOjss@pengutronix.de>
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

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you for your work!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

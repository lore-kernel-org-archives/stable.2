Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794564537;
	b=GeSD/EqtfASoM7cLiVaO9sn1G9OH6oMYLoZNUnih2YA3924NJeCBwiZwoTZDh8wk/Jd5
	 YQTq0iXQfxARwl2qn5R1F1TRmCL5GfhZpbpysOm10RVbo0YEf2MExrDuUCHMYF4IRvT3R
	 +oGm5VuevqSBc9JzsQAsvGUtxhIBG9cJYxwPSe2roRE8Blc8Lc0Qncv11aFo9aEE9U3ha
	 AYkJ9xNFwq4OOoQqffC3Qg1v1T2M12ArjHawAjtTODJApozuVPnfYA3gPboFulfDPggHr
	 wu8O8RHI4l29Fgq9DVO+LCkgWAX2x7tMm2njamRDRMIZZMAR74qVgT+UqQ8zYdcnzBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564537;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=6cqMOzRjZhRECM21udATCgBCEYUZW00d+/7h7UE8Xsc=;
	b=1qXCEvg9YUkZZdqlAzSmsXzoQFtOWgry6DYZP6uKqNRwPKRLZILdmYGu2x8ufmRXA+DP
	 ZGiSn3b3QjmaXfa5qe3cD4CcFTI1RCuJUU79spHM0vxK2B6czv7400BahizC6B3Bg8FxT
	 wTGOC4iq+XQWl/g8OQzEZGIS16AbXps3cAsZq7N9nu98Fyf2VTfBgUrCzHqlLzCtoJM4+
	 h+eWnfy7R4snPpVWs52CNk8phpuBO49qAup31U2/2anQj6gSwn9KHsd6bjibvCwCYwwNf
	 Ij9VG9mbyih0hwSQKCNsgyYPas1npnmlPsz04zHLVgIp2DjiiIjqlXH5Gn1cgmM+ZZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="E8ds0M/8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BBD606B11C;
	Fri, 13 Nov 2026 10:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4BBD606B11C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=E8ds0M/8
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 84C572020DC;
	Fri, 13 Nov 2026 11:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cqMOzRjZhRECM21udATCgBCEYUZW00d+/7h7UE8Xsc=;
	b=E8ds0M/8UJ6XY5ZgyoyDegPSO/xG8rxuBzVvJYJgcfzZ/F9H141mAi4aR6Pie5kZebIUJ1
	+nPqEe1WaEcHcc38RohQSxIe820BbaroWpibHaWS7HbT0O4kjmWLywJXBiW/fag8rF8Deg
	iVziTHDNmHq+NMmjPIVZ2Uwakqc30CG3cSjiRNqRtXazuc33+HCV1cY28ZtWzvUtBJgnSN
	jSCOkLK9cNp9zz/kZNZ50U9PPeTtU2gLY+B+C+TTTW3Hz95PzbUi/9bV+dvTCUHSLZ4w2S
	1sYQS1cpb4gNbWuwg1VUk2UTW30N9GDYok/hbZQnXfbe7fbfRyBOTKErL2URNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cqMOzRjZhRECM21udATCgBCEYUZW00d+/7h7UE8Xsc=;
	b=UeJc+GelSwEhPQUJTj6Qhcz8t1nWXCDSsWqIZY8qihQXPLMqKqpspF0Gq6WzRpXnU274Mu
	ayqTFGEBcgFd+AJRDJcouLMH5+shMr5s5zvZhx6mLuolTvzc7FZQhykEKILCOPSFZ5GCZQ
	FsFyluZ9ybdXrPj4GAOKBMzo9nxp5/QIWxClrLUBK91280T/ebYSu8eAUb+niWzlYkBUIL
	Z7bwfziEqoXC6N75mex/6kyNsrsFAlThrvVH0HBnEzwl58nhaVgOUF0d8zSSgjTIao3U2h
	Id6yZZO7zFVvUMSwSngBE4avk2RTraU5XAUo5ias3Em9tDVBr73SuJsNPlo7nA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794564534; a=rsa-sha256;
	cv=none;
	b=NR6eK1iIzyvXEx20K/UleZNhBSKqI04LUjIYpe+/nBgqwQEv0cL3ljHiWaC+hp7lfwzHgY
	fMug+czgSfdjKDJIi+BkbHTc+zUlVx/YMwysEKoUBbzklqHxzp7Gt/QdO2GU2R12TwCjVt
	JFhHPLYeYlUPpb7YMcyNkejAWF0JnU1c58FhPeiDBkb/YssgVj0IQCBdKsk80oNQ4VAEZ/
	LcGnUhKgLlbss9yq88rs8Sq457DdLRMs2pqEdZcDopsgcQuGlO7PfbhM4PXtJV0EKpOuSW
	HE38+k0lcOUBYTwladu9Y4bSlSwHFdExIuVzSyNfu/fVUvKDevbuMdXZjl5JkA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRoDG-003ySG-1P;
	Fri, 13 Nov 2026 11:08:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2823B5EA84E;
	Fri, 13 Nov 2026 10:08:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 13 Nov 2026 11:08:39 +0100
Subject: [PATCH can-next v6 2/6] can: gs_usb: gs_can_start_xmit(): don't
 leak uninitialized memory over USB
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-gs_usb-fixes-v6-2-0c039e1bfd74@pengutronix.de>
References: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
In-Reply-To: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=a6NuAStUzeESNtc4MicggnAylqn/ya4PCoKR3IoI5fU=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj69nB9aME9oX263d5n3F+xfe8LzeZ8t4fzdfXtw7Lu8
 veXm5S0dZSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAikhGMDHMqC+cb2UxtkrJ5
 phsT7HbDPCXnc+uixzFamQxSelJPPRl+MjJPbNByz9PcvlbgWFCmVuRrloAeyYbsJ1X/LQSuGGn
 wAwA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The driver allocates the transmission buffer using kmalloc(), which means
the memory remains uninitialized. Then various headers are filled and, but
only the actual CAN frame data payload (of length cfd->len or cf->len) is
copied into the buffer, leaving the remaining buffer uninitialized.

Fix this information leak, allocate the buffer with kzalloc().

Closes: https://sashiko.dev/#/bug/linux-0a8c0e8a-c623-426a-8db3-f55111f6cd84
Fixes: 26949ac935e3 ("can: gs_usb: add CAN-FD support")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index cac4ce323a1d..aa90cc58f28b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -861,7 +861,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	if (!urb)
 		goto nomem_urb;
 
-	hf = kmalloc(dev->hf_size_tx, GFP_ATOMIC);
+	hf = kzalloc(dev->hf_size_tx, GFP_ATOMIC);
 	if (!hf)
 		goto nomem_hf;
 

-- 
2.53.0


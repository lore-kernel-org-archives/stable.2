Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953406;
	b=3tx0IKQkVl1aTdmzrlfWIoMcB4M0+uBG/VrTakpO0hyQNoFMDWtDf55b1m0g5lFTQhr4
	 QIBuRE4gbPnZ3xozOPSVEeqZlmdw53jTCl1SUCHv+p9mKSVm6F0hUVws93ukIhziV43F4
	 mNJYL6th78iu+oYdnSrLA/auZZoJ1BCZIxogQoNUghpdqSfa7W9LTuQ74LkxLZ+hqTGDx
	 wpSPHPJew++NYIVo0tV+dTLoucM2aJHjW60UxxVCESbyk0hpVqVzbfPQVSBXASn5MVyLm
	 6TKgVTO5Pd4QvdzAtTxUCoHPoGrQL7T3Wbs1Nzy2MVTFUvQfCgoQAQ5eBlIVyGnRIPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953406;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pokTu+l1vM7o6Eh7om7s7KcxHn5AkgfsRI7hSQoz1Lc=;
	b=lkXQqzt9CpG09A4+Tf1TJnJNjTMopdAvUxrh9zz1qfCk0vMLDMXpiodwFgl4wYSHnnRc
	 iBAjUN1FE8dk0B3EjI9cXVlNs/JmFLzqgNhqVgbczYMmY3M+7W3OPMPt37Qcz0gdLnm6I
	 HeFSv61LRwjSMEncKt3zqGyspsZbpxG6XQrC7KTYehS2xIqfZV9T1rzCPNvaqL+pecNDD
	 HlhpFPIhQ5D0H8RKYw36ZdqagIZU0+u0QP9rjjk0Rmw+cP8MxCCLHpyBcITK/pxquZRqJ
	 xevpepUTPpIN/0EruEEWOUhOHHe0yUHNVc65hXKMhHa1jeVzVEIE0poMGgnFGE6AxRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NFaAhP4+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E5606A31C;
	Tue, 17 Nov 2026 22:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A7E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NFaAhP4+
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C900E205A36;
	Tue, 17 Nov 2026 23:09:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pokTu+l1vM7o6Eh7om7s7KcxHn5AkgfsRI7hSQoz1Lc=;
	b=NFaAhP4+8dQJOdtUfwiN3FQBbrN6QihGC0LF4S+rgjvrxvK8Lu5ZKh9pZDUz+nU4w+chWM
	65ZnoTsFZOW8mlY8mdzc82yi8N2rNZdYC2hdlHd3D95+Eieo5W1MCFcqUEv9jJVKPrPlDF
	leBr3c8+Qf2D+vjYUF4b6x342izDhJ7EhOUQVNmLTFT72c3plSKVqVnLcHEUGmPhQKOzzR
	77c993IHJLyQ8SxlknxpbNaVodf+TJ3qPbfIVupSVsh2H5jMWwJD79luTIZ73Pj6hJqZCE
	4TBwdVnMZJt2H52+nsbiNBuUEmsIUEI3eCjg9gT/55K0qfOy4PMUk3w0XINHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pokTu+l1vM7o6Eh7om7s7KcxHn5AkgfsRI7hSQoz1Lc=;
	b=dp2J36DVo+VCqbIfRAJ6dJLgDhM82qDJ61q0m/f3VUS6//BfBsMGYSZg0YLrv04RQNxAsC
	JOWTk/67rjVAlqX6OqpuPbbHbbqHtYLf78DhryXpJ5DgHXsUf7JIZnP2zFvAVizPNNeuG0
	Bsno6XrSfHqrMfhAfsfggfSyKUcBT2V0aXuUUcnYMYHNO3bVXP6R8eWDdRfClpjuF+/Tc8
	ADLf6A7iuPdUwsnnWzIaJQ5MpF0qv5RtYSXRb5ydJe21AALbby3WqG/prfpM+xrfwtpqcG
	1OdbS0KgMJWdqQtvckQE58L+IZZ7ugqvocSx7VAeR5zmOlGAUCqLpsQznTcRDA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794953399; a=rsa-sha256;
	cv=none;
	b=ASW0Y/XrvEDUV9heuI+zeFjJQ+Ck7hUJ4m+OKVutqdBiaZIf6efkj+VBvd5FFLr1Ll3pi4
	nHo18ntZJ/XYMfT8h2GzvZ65S1/x726PmILwZRC3lfo109K529u+SvAASDMg38VifsNkAe
	T6B0ytPlyWqYKUHXE6pjC1RrIwmgmdJ3B+1zRB7Whan6vclvgI+ZBYso0vjXtbXcwrhgaR
	1DeJrmLTbmsI1gECV42gZqumTMLvzuK3uUNTmzcpEFBhc3eWwW+jCMrcz7TJlh8vm5pwt7
	JYHTEGGQ4K8tVJmoi178oofBm8rM29WNfPICsRz4JWLlJonP7BAYkCCdvHrqPA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTRNH-000Fmy-0g;
	Tue, 17 Nov 2026 23:09:59 +0100
Received: from blackshift.org (unknown [192.145.8.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 506C75EDA2C;
	Tue, 17 Nov 2026 22:09:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Zhu Ling <zhuling0805@qq.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 09/11] can: netlink: fix IFLA_CAN_BITRATE_MAX attribute sizing
Date: Tue, 17 Nov 2026 23:03:14 +0100
Message-ID: <20261117220818.1142581-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117220818.1142581-1-mkl@pengutronix.de>
References: <20261117220818.1142581-1-mkl@pengutronix.de>
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

From: Zhu Ling <zhuling0805@qq.com>

can_fill_info() emits IFLA_CAN_BITRATE_MAX with nla_put(), which consumes
space for both the attribute header and its aligned payload. However,
can_get_size() accounts for the payload only. The resulting underestimate
can make filling the netlink response fail with -EMSGSIZE when the skb has
no remaining slack.

Use nla_total_size() to account for the complete attribute.

Fixes: 2290aefa2e90 ("can: dev: Add support for limiting configured bitrate")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://patch.msgid.link/tencent_D1C873B86B0E92011A264B0E196B911D5308@qq.com
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-3924d490-baed-49dc-880a-6fd1163cf08d
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 521e2496e2cc..10e7ccaf40fb 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -833,7 +833,7 @@ static size_t can_get_size(const struct net_device *dev)
 	if (priv->bitrate_const)				/* IFLA_CAN_BITRATE_CONST */
 		size += nla_total_size(sizeof(*priv->bitrate_const) *
 				       priv->bitrate_const_cnt);
-	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
+	size += nla_total_size(sizeof(priv->bitrate_max));	/* IFLA_CAN_BITRATE_MAX */
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
 
 	size += can_data_bittiming_get_size(dev, &priv->fd,
-- 
2.53.0


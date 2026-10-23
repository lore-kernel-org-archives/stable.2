Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761167;
	b=DJLUngOIuzEOSKFZZyUOVnCcdNAsGLOjAyr1qo5v0k45eehZMdfnikh9SXUxtLd9DlFI
	 RifVNrpGtRklkr47/40aZLOAbDkVhYfKyvnOpTnaxqIcoLM9RRFItI2pfzn6t6ZvNrkud
	 qcX8TUy0YLk9UhTZ4oDZG70WhV8UtnLxI5qbLxt5eM4S2RucacOf2FBi/mOj2BMBfC5M+
	 V8cSqbwxzuklh11PavgYbMETlQ8ErnO7qqEAOW9Uu+rU5zErRQ0CtCb4VOMJRkdxoW/mQ
	 odVeSGf8PvYukfsHjeug9lkHrRXgZxzTrTIIY2PlUNss8cyyQS7iIPOHK4wFyZIOjfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761167;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Received:From:To:cc:Subject:In-reply-to:References:
	 Comments:X-Mailer:MIME-Version:Content-Type:Content-ID:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=I7ZqURMaAeN/39DP/yFBhYf3zDxwDlmOr5MpmREWjiE=;
	b=rnlzU9HHKm/MWdjV6GBBMeA1eSLC5HmX3zQFANsZxAagzwCdUsmK+Q1hDzKa8ReOaWSS
	 6cztsquvUFpTTjP0i+AaKVYnp+T6Y/oKI+3YLi9NxAMvVwp41uay6g11Kh1m54nWm1nfA
	 iRQLfuBSu2c3cDQoAlEskep+WFzX/zGk+S7BYZd9lenrvpSEURPY0lth/RFMYmR7y8AwI
	 hudmzRT9Hqfy8AgrB+p3j0xnwU+ZRH3gs3dpVc/076M8Ebq0EzxYzMW9HzDN6kpuanneT
	 tBFkvlcJBO5PQdT9TnUb4WdOIODeFoRo1LJO3XHA3jEsMVcGvOJAZnKOFOqNwDV5AKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvosburgh.net;
	spf=pass smtp.mailfrom=jvosburgh.net;
	dkim=pass header.d=jvosburgh.net header.i=@jvosburgh.net header.a=rsa-sha256 header.s=fm3 header.b=rxggQ8g9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=phJ5vHpe;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3738606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3738606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvosburgh.net header.i=@jvosburgh.net header.a=rsa-sha256 header.s=fm3 header.b=rxggQ8g9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=phJ5vHpe
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 288471D00142
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:12:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 09:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1792761164; x=1792847564; bh=I7ZqURMaAeN/39DP/yFBh
	Yf3zDxwDlmOr5MpmREWjiE=; b=rxggQ8g92PXD2YZa7e8hWRIUodv2ny0mRg+v8
	4Wv8efTVAseeGqmhXoZ6Q7nPt+cLZuZwnQGH4rdrKqWYR7vSDFxV9nnziS2U3gsP
	Ohp7or/Ix1TWKLIiE5Wk2hTCmUdkN0XkXQc547vD6tk+4XJM0hMzvWvt+XLIR3gN
	Q9kfK8Sf+1bJpxxmdbiut2c8C0nt0/DrWTSEalNJwJ8eABJ4f36t3dERVgKnO7dx
	O5At1LOyrwT07Ap4k/Y4Oqw8n0EmOegcwHiDTwsLYN1i5w0W+Demn8YIL3mmX14V
	d77BXxMfXH194O1+JXBgiMqxf2xCQv1lANcu0cjJcCd4Ivb+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792761164; x=1792847564; bh=I7ZqURMaAeN/39DP/yFBhYf3zDxwDlmOr5M
	pmREWjiE=; b=phJ5vHpe6oNFRwPCX/Iwvg0+zovyiPGXU+J2mPyr/lhkZT8l7hH
	e2WeOnIs3iqwvjplr1Z7puiUlFR6sx0Or0vqk6Dv9bzMPcp99FGi3O+VMpvzSWmn
	AlATQa4I0Dj8zZsiZuLJpLa/xQ0VweaVNJUYn7zz6aclUPipVZGCazkgbXaJ1vNw
	ooHEg8qvFVBSx9T0Pr1zZ1yl1nM6t64Ym8gbamH5spr9CTKYcjlU/zjyOwlHehsA
	3H9doHEEJWm1VjfipcT6D+viBy59xvSCqFdYuToOGWitaucN858Ggw/uTabPDyGZ
	cXZWGEJRV8I9UZr4v8tbA3lC2xs/zCs1UAw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvosburgh.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792761164; d=jvosburgh.net;
	mf=PGp2QGp2b3NidXJnaC5uZXQ+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:g8TKE3U/fEv8BQbDltaYA2fJZI/nVkALCRC4iUJUHAbKXTF
	JaJdxhgu8Brq/ubwq9fEEvOfVUddcYuNiBdCIi2rpBEmAaJ9gL2O4Es2F+NoWJGM
	65IyQ4x7133M5Pde+6snROLs3dVX3oJyGNdvFIrtMYNTGI/QXjNNAXcnF2CtP+gY
	2vLac39jsY8roGJVhrhhTkz0+MDxG8w9cuz8xm+P1SdhHg2OVm3nrxdJaaB7vgFY
	WDv7njvcFewW+aA/XLAnRU9GEM6fp2zwXUyaCR1lcL0WymDU5ucDXj+JbRWf+LQD
	8kK750Rpnfv9cOrPlm4Cel7wrW+NL+oL2pbEemA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,comments,content-id,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cyNuzwzH37Dgo4zT0uDMMUicmdl+FixBz7RYHV3mwZw=:syrr1aJ1tjIcOOSawhAcgtFuJjUz9NdQ5F2zl8WUVR0=;
X-ME-Sender: <xms:TF3baqIyBTV1TknAk-KQckomJIbQGBn6p9Gh14CELYTQIcoBPbaIRQ>
    <xme:TF3baoKSDkGvTlKg79BJgI2n9ODgbxIcEra1ClN-xDT_MIkZXlwwQ-JHN2IQnWaXv
    s7zikXEoe5IglyQ0ySeEnI-oCtS-ubYgtFGyz4KCn2SCmSJIm0BJz1y>
X-ME-Received: <xmr:TF3baliWbSquHqAew1E0nhQl8VXF1Hd29JQsTqNwcfC3p5303qYE8aGeZpW7T5ckNV5BPxU>
X-ME-Proxy-Cause: dmFkZTFfRo1al3D2IO9ib2P99KdQTvrcUmBICI3lB8gtzUkSJFMmipja8+A2hgCvFraJbM
    ocsAPRaWJYldc5i47n/lfsDQdW813UT75gJ7wU9zas6C8HELTgr4/PNJ49VUuTaWgSmshW
    ucy4BqareE/h7towuyOhIUiBrjE8bYckffMWimx0Z/IuGke7hjF4MRihP06pxvTxoxrcuO
    SA4lqYqilH+thfQ4KTFZ0iSVFOFQ97mHwZMCnzULyAHGQLI4GSnWKJoXTmwYxYnsguguXa
    W7Q38FOPxQW5glqBeBpVJdnKzFxW90jD7uufEcg+A5JXRhMsh0B4YnOWzIghktpbjVbaRs
    /OU2d1JwKHqBXalSebZBRsZwXj2EmIrscdCMIuPwR1TMs1r0DSxmT8ykGjBx8ZcCC/cZ3E
    Ylpb04rOiKFAon77KR4vT41+0U020AC3jSGfZQ1J5xIzILviFT3Pv1MAjw2UB4+sYTg0OM
    Veh/o+56M/omttmdaijpNnbwdoB34g9Y2ncVvs1dlXjnU31yV9D5oraaOuiligmmTD8+LS
    QgVheIByz/cZ4tjcDlRMaSmWOx9HRuQgXizfbQ7X6rLfo1bUI2eyErLyfCCa5Kr2Jcd9y8
    X/b3YqXihLEbKDgSqmjavGluHzRwSG0psmvG8Nb9Yz3Qo6KA5iUhxbWX90fw
X-ME-Proxy: <xmx:TF3baiMkTjFtWLmiEAhwgZQy10xW6xidBPz3SjhxmtHB58_3TNbCOg>
    <xmx:TF3bagqXe2aNXTI-A-eviLOQN4jeRTpy-ozCBd4uckYuIQMKN9peMg>
    <xmx:TF3bak7RAvhRourKe658VSqu5Pnebxyee2VbevYTAdFSPvjq_weXgw>
    <xmx:TF3bauh1dbABljKCS7NlYbl5MO51JnqZFara79Lbad5oo2Qi5nkiTQ>
    <xmx:TF3bar-QRoS0Cy0tVB5C7eDcsA9jsla78pJKSdALuX5JO6cSfGzy3EiA>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 09:12:43 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 5A5ED1C0479; Fri, 23 Oct 2026 06:12:41 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 5977F1C044C;
	Fri, 23 Oct 2026 08:12:41 -0500 (EST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
cc: netdev@vger.kernel.org, stable@vger.kernel.org,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: fix out-of-bounds read of arp_ip_target
In-reply-to: <20261023104528.232427-1-jiayuan.chen@linux.dev>
References: <20261023104528.232427-1-jiayuan.chen@linux.dev>
Comments: In-reply-to Jiayuan Chen <jiayuan.chen@linux.dev>
   message dated "Fri, 23 Oct 2026 18:45:27 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52801.1792761161.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:12:41 -0500
Message-ID: <52802.1792761161@vermin>

Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

>arp_ip_target is a module parameter array with BOND_MAX_ARP_TARGETS
>entries. In the loop parsing it in bond_check_params(), arp_ip_count is
>the number of accepted targets, while i is the index into
>arp_ip_target. Invalid and duplicate entries are skipped without
>bumping arp_ip_count, so bounding the loop with arp_ip_count lets i run
>past the end of arp_ip_target, e.g. 16 targets with one duplicate:
>
>  BUG: KASAN: global-out-of-bounds in bond_check_params.constprop.0+0x114=
8/0x1440
>  Read of size 8 at addr ffffffff96e9ee00 by task swapper/0/1
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x91/0xf0
>   print_report+0xd1/0x630
>   kasan_report+0xf3/0x130
>   __asan_report_load8_noabort+0x14/0x30
>   bond_check_params.constprop.0+0x1148/0x1440
>   bonding_init+0x13/0xe0
>   do_one_initcall+0xe7/0x5b0
>   kernel_init_freeable+0xa91/0x1120
>   kernel_init+0x24/0x220
>   ret_from_fork+0x5b3/0x820
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>
>  The buggy address belongs to the variable:
>   arp_ip_target+0x80/0xa0
>
>Bound the loop with i instead. arp_ip_count never exceeds i, so it
>stays within BOND_MAX_ARP_TARGETS too.
>
>Fixes: 5a5c5fd48e3b ("bonding: arp_ip_count and arp_targets can be wrong"=
)
>Cc: stable@vger.kernel.org
>Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Acked-by: Jay Vosburgh <jv@jvosburgh.net>


>---
> drivers/net/bonding/bond_main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 09aa45d71fab..7019e5d8fdc8 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -6273,7 +6273,7 @@ static int __init bond_check_params(struct bond_par=
ams *params)
> 	}
> =

> 	for (arp_ip_count =3D 0, i =3D 0;
>-	     (arp_ip_count < BOND_MAX_ARP_TARGETS) && arp_ip_target[i]; i++) {
>+	     (i < BOND_MAX_ARP_TARGETS) && arp_ip_target[i]; i++) {
> 		__be32 ip;
> =

> 		/* not a complete check, but good enough to catch mistakes */
>-- =

>2.43.0
>

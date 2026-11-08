Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794160260;
	b=Gig31xn7Amb+pZpDWkzmQgTKUAkhc+3YS+vCtqgSMXHOuUKs7Dtxv8OKXuofEzwzA/2S
	 p6jqP+3gXgj7Yq9RzP1Zst/ELynxrLI8WrI0uMBcVVo+1iQlmWOeKrvapt5JmMHXVzSfj
	 7ZvG4871vh4ha0hxDQV9DlKuQ12IRHJ1qOZwS+FL5hGo6g40HyiCRuRmIax13dsrcq+qF
	 to43toVfK40jVcPX7W9w9MiyYHVlive6Fv3dTgbaD2bebfh+vf04oKDv7LLQX0L6axBLK
	 qdW/+CO/+0NwUYMKzCeoybX2rcA+AO9FnEB3iarp6clBUum1zUJ698t3C4+SxTZAhGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794160260;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References;
	bh=Il8xXxGs1zNnrSnUmdaHBhL0nHgZZbPLCzifbQIZsf8=;
	b=pQX8t15s2c0t6hm5tt2I5Gtd4FpY6Td1D7XdX4GATlJ0dTL6PB9oNzHtqcxd/FYj7Ov2
	 R4TkoJg+x/v+Vt2eh2S9wdDIzJUCASSqNbea8d+EMu4Sr0mmgGnNX9/XaW7JsyhoQbbj3
	 ASetI5Zh+dlLgrcg5Lny7Tl0PddZRTEki93oA1JAn+NCuIt4Y3i5VvKLHNoFr7RDplOZP
	 aotRFlZ/4qcYCchz1o3VS5ADFSAq9fXvXWG++quwLYxliz8NhVJYMCQD8ygHcrlFQaL/a
	 GlDmbqLur/EvZucT2VyEAKJg7fhbiW9gidSERDQ0mvSI0L9XNQwxEIc6XkFUvMlTQAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=ZXgpvEJn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F09606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 17:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F09606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=ZXgpvEJn
ARC-Seal: i=1; a=rsa-sha256; t=1794160249; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=SFn0DEAt9TNPsnbU4A5X4EUviuHdBQpIJLLyItj73Ra38f8s+TSNeRQuEnbdirED+pVMJfaYRPywjTjk9lAb8mOVXwJCaqFc/PO2q3/uKaBxtttj8OngqI53rCdhK/QEUfPtSHDN66sp5mEHH2D/akbd8A+PGeQnS0U3ERYFZnc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1794160249; h=Cc:Cc:Date:Date:From:From:In-Reply-To:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Il8xXxGs1zNnrSnUmdaHBhL0nHgZZbPLCzifbQIZsf8=; 
	b=flfMSn5QtyaQP5Ejdo0xv0wzhpMBdVb8cpES2yHbbctWozIT/oeVeye/NvsXBZJhP9W1Oii+vcWdwxFmqYMbCfsQ61wbv20BbkgIjxluX2dy7/Hig61KmMjr/hE1dOK6kQ+G9Tnpx2DlJ1PrHfR7Eo41zjRxOYQlI3Dgx52Y92w=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=ZXgpvEJnUKUE1MRPrDdEJy532TU+uBbU2UX6DYMEksyR0GMn5ZEqFHzUiQaVBXviqfuHuoKKM5NOPiLdYFsyX8ryKDG56Bsd2/E6YSCdhZPcrhHf31JwzoKzCQawiYpbRsUnuK30W5QlQkUmrpJd+rOcdSsI+pGpUxzADMXcuGk=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=Il8xXxGs1zNnrSnUmdaHBhL0nHgZZbPLCzifbQIZsf8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794160248552792.6191649171122;
	Sun, 8 Nov 2026 18:50:48 +0100 (CET)
Date: Sun, 08 Nov 2026 19:50:47 +0200
From: Igor Velkov <iav@iav.lv>
To: Thomas Gleixner <tglx@kernel.org>
Cc: iav@iav.lv, Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y, 6.1.y, 5.15.y, 5.10.y] genirq/kexec: Do not take the bus lock of an interrupt chip on the crash path
Message-ID: <20261108-re-tglx-kexec-backport-6-6@iav.lv>
In-Reply-To: <877binwiyw.ffs@fw13>
References: <20261107053823-failed-6.6-717862eac6ef@kernel.org> <877binwiyw.ffs@fw13>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Hi Thomas,

Thanks for the backports.

> -		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
> +		ret = __irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);

This needs desc, not i: __irq_set_irqchip_state() takes a struct irq_desc *.

arm64 defconfig, gcc 13.3 and 14.2:
  6.6.162, 6.1.192: gcc 14 fails with -Wint-conversion, gcc 13 warns
  5.15.225, 5.10.274: both warn
With desc, all four build without warnings. The 6.12.y patch also builds
without warnings on 6.12.116.

I built machine_kexec.o and manage.o (kexec.o and manage.o on 6.12.y)
and ran nothing.

Igor

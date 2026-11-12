Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486464;
	b=XoHU8Ud47uwDhUk+/W4g/+EhFqLZr0m6IWTcUH/6tWX6nYfvMmr4ukgvIzmsjCYFEjAD
	 Hm6GirGhnl/oTgJR7ZlQjrhrtlKsNGWbKZJio186XKe1fOKuCDaiSaqU+B1h/3OWsMmPr
	 +n72WK1PVWZSC5Ru53hZEy+xWZHKoc/KAEcXz3ItMJd6aLOUUf4PXQQGrsyd0lAKyHV+3
	 S5HPWbQldSe4jsYK6CGgnoQ0D/oSJJiWVLNtIEnbE45iA+tQ4avauEsPksHvNA6uk/yI2
	 kvOviGpQdsG5ic13iDKHJHEku/3KQWYp6ehSq5XnnsucdWoZVwrX6NaLf3213YYfEdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486464;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=d6RPiY0rklyeXAU+QYrLceLVeEm+P0hCcW/c/9VYRgs=;
	b=XGM2txk2w1F91MsjjUVI89m8YBGWgQJshkXvoUCwsPviDB358PViKk/tzxSmg4hPXz3s
	 Jm8SP5pRMk5AQLtlYbiOV5yfN+NfQpCySjUihNNT3lT7wtDDAAavaAypm4/qBFpzVlc8i
	 1msLXcvWCYHievSPidBM7lqKwVRePzmKVTfUCcNtBkDe92YCa9Awf8CuDhDiIKSOZpHeH
	 mC8uyiYKUSueIulCXSesLhxw70V/vFYgAl7zVFCbfXR+Pd/L9s89X5ushz8iDNuR2iq1n
	 7x0QvKTosvwa/HwtCcGvr0RrQC5Xd5DZXJX8a9pZ7vTzkaZx371mZGZ0kxwb4RrGpjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=LTh0NXy8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qd1kIe33;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D45606A88D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3D45606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=LTh0NXy8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qd1kIe33
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B201914000E3
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:27:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 12 Nov 2026 07:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794486461; x=1794572861; bh=d6RPiY0rkl
	yeXAU+QYrLceLVeEm+P0hCcW/c/9VYRgs=; b=LTh0NXy8XKJoWZZSPeBoJBjMUy
	8RUq1/PXKwLZMxl0BeQpEUJNvwsqTIfbzGPIXH+h8b9vHtyFkpOIcI1VcMeWrZJ+
	7zBOk42XeNYOAhOCYA2NO6ojM3yVdbJiOvOfd10SQg0nt8uO9vQ4QBaPomzxILct
	oFGYXgOoOjkdv4gY+4QtM7qME1RztKu18wjWSh+YH6XWWo1gpI3vlgFoPq2jh9gq
	dJ2a5z4JuOsoXQG0Aj+NAO5afkp/xWlEEBuAbHXDribHkFB0soNFEsuDKua5ifxI
	wFuSVd2DNbWAMcdIRPRnp3Fv7mtG5QAzaepy2oYVvd0la8sCbCij46XavJNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794486461; x=1794572861; bh=d6RPiY0rklyeXAU+QYrLceLVeEm+P0hCcW/
	c/9VYRgs=; b=qd1kIe33j6kLr3Ek2iLblOPfI5RRD2Yx1y3xvzh+tu/B9b0aY72
	KYFEep282WNH7e2JLaAb7i5dcki88cZVCIWifC3r+dE4KBtZiduTkdgf/LjPS+z8
	BTZYS5KtCUd5WLxDQvNCmO7Yg8ITh3PKsqYhmwWD0PO3BRLZValzWzIodqBiyA8B
	PEBpjU+QT/04miP5F3o+AZAPDmECIIzL1Wow/I9zY5cn8qcZgLe3yE7sYg8o7lYH
	YDR3BhaOJnVZetpZYf5LzfSCbbJXzoAMeDhYbiGrv0c37sPkLW45I0c35SkDfQiM
	ejiZKO9U7ggxOERgqeQe6QU7Y9DvLWIMD7A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794486461; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Ogn4HXKo2rrgV5ruUw5jGrsj2UFyxFRwirqlT85D1h+mO8F
	7lmfhLDgfkM5hKXyImLRN1Swqd7JZWDKYXpw3yfSSutO4BDPEyyi816YexNDZ/bB
	996qWlHwAnoRMK/QEMA+L6pmrYdWZ/eJL9ipepYDOG8pAkJUuTABEc2cAP6SarJ/
	MIY2BYgF51FBmzO5wLcg2D/5Elz39Rrr/V6TKSicRUYICUg3P0AVpMxQWbgz2Jvx
	ZlhcvuUULX4QtOXl49apW2RO5XJTUsLpnV89jXKDuTMFbYG8ozfsOzZFOD+NvkGS
	bbnzk6mu3ayaq7VbI3kJkkC85gCDNv00DPnquuA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ePUpBg+snje1PRuCyD7St6qpCMTNW4lHhAoyfu6G85o=:PgkBA+iUa585ZODLb7UCx+7LAKTHLPzt89fBhsZ3Ezg=;
X-ME-Sender: <xms:vbD1aoHSDDsuN4WOtx8FlZrHRrCJmFd5VacDEP7uS62lRB-4u3zxlw>
    <xme:vbD1ai7EL8kF9xuqkymplL4u3PVih27nEh8EajfWNYiX-9D3zf9K9auqlJsrjCUyn
    4GX3tMDJWvW4xAnSHnxgLYVJjzjWlZshAzeVFK7tKg2D4WXC8o>
X-ME-Received: <xmr:vbD1ahZyipggeBcq-mLDjo8LANvSaADrtZSvpX_8B7D2W4Gri5oKM78b_J6WwcyF7nB4qvd-_nh24kTn-SloCrMcCA>
X-ME-Proxy-Cause: dmFkZTF0uUYZJQrHiUD5AV8vgLI4qwsMjcQLjf6C8fEdquUU8XLtLx5cyMaNy183hgq9Wy
    AIEIW0a1BfaTFAAoX5g2p6ZyIQWiKTEuVXo6rdyLlxkGwU2lkj4GSOxOeUNiAdXPukOLRT
    4Fk1ssZSfp9gk+cIQnf4yk47ZmUlbOqrjDNdtTkWQD7FAv5SPqppvAbUQtVfFMpq5tyB0s
    c/XOhN2NGEhPomcBCaG1B0PjZV2auo+ciegKMBys5vPRTKU7VQ7YaXnJdoKN0Z2ad1Q5KY
    RwltziMY8FY9UMCg2SKXV7x1Q9hYvzpT3Pba642tpQQBwc3LRfJVpPEENwtiM9m7q81jbk
    X3SGYsX3hX8sftgCAVe2Yzt/+LXBpd6PlDQEXq3zWoOKowr2kTdJCzLPIlXC6PEwZXbH/H
    hvPvJVPonaEYJi5hyeO0XqkIXMwGYn2CKJjnmsDYzkO5zdveYPLJK8vNsgux+rBR2llKzD
    V6GJ1zheC3veXAtBfOjIDnUKGTcMS2dQ81LPj3hp3IkfSO+7HvifI44wbSc8slKwTamlyN
    wYoOSuhDwRgZnSVAgM7oOz3zW6o/BYsOAXuIYrg+saI7kWJeny2RETDq+9vz4W3LJXytGh
    5NgdVMLg+FiW47UAIUSGZ7ynsouLm+FIufNxQaBr83mb4SUST5Uc4bNGr5KA
X-ME-Proxy: <xmx:vbD1aggpucAWH0jwBWW37QavGd46oNRByZ50OsX4O5oOy-tPtU11iQ>
    <xmx:vbD1aje2rPZLbpuwWMJ1Y9dvOz3qrYKc1ZNJ6ow9NgjVKgagEt9ChA>
    <xmx:vbD1avl9XTKF9Pb2EmAe-hEKKOmWSBTpys-LWH2IlxQ2cqoJZOaLtQ>
    <xmx:vbD1aox6eP0pcO-pl7C2yjPwGUaMGQz99U6Uin10Cf9H3egzi4MdZQ>
    <xmx:vbD1av5hHSaKb98h-aTswvB-1cpjDBoPEubq2hx9ZDaCMMl-n4_JCQ0O>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 07:27:40 -0500 (EST)
Date: Thu, 12 Nov 2026 07:27:38 -0500
From: Greg KH <greg@kroah.com>
To: hh c <hhc436476@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Subject: Re: 6.8.0-149: forced 2.5GT/s->5GT/s root-port retrain drops XGI Z11
 VGA off the bus, local console goes black
Message-ID: <2026111205-tanned-empirical-b961@gregkh>
References: <CALJR0nehJ5+d7MrPk8rxkNmee_1L5FFsvuF+-swK1nyJ7oJJ8A@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALJR0nehJ5+d7MrPk8rxkNmee_1L5FFsvuF+-swK1nyJ7oJJ8A@mail.gmail.com>

On Thu, Nov 12, 2026 at 12:09:07AM +0800, hh c wrote:
> After upgrading from 6.8.0-31 to 6.8.0-149 on a Huawei XH320 V2 (Romley
> platform, C600/X79 PCH), the local console goes black at kernel handover.
> The machine boots, SSH works, getty@tty1 is active. Booting the SAME
> installation into 6.8.0-31 restores both the console and the VGA device,
> so this is a regression in the 6.8 SRU stream, not a hardware or BMC fault.

6.8.0 is very old and obsolete and insecure.  Please use a newer kernel
version.

> ROOT CAUSE
> 
> 6.8.0-149 carries the stable backport of upstream commit 72780f796468

ah, you are using a distro kernel.  Please file a bug with them.

thanks,

greg k-h

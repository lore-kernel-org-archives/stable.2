Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662321;
	b=2beeB02ukaB6uwWM5GZeoa9q/FLKG8Lk8rrmao5cW3ZmShGzyGgNyBm0RzxPiQVuVc77
	 2LjhjiSRHjaOy/45JBtFfYZEtvndGJr/0Mese0spyBC5C59nDmNSVxnzMVI64/C/uzyex
	 RX8AsenEsiYQRARkR9wCrsjn6xLQoY++zntzoaYE3dNaqHahlMio/S00eYZsFFwcRwrgK
	 Bfef78TwPXMc0mV4ePFHUNrVqYsMzizX2WbEnq45K6i7wG0UyZZAZLXqROE/Be7e0aMos
	 6qOZ0V7OaUOzbNaV83j+mv7mHEfMPw1JBo2ys5HeY7sNpAiFovYwZKq0Do1eXezFYAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662321;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:From:To:Cc:Subject;
	bh=7DSms2G2kzZgCzBY7xLgXX+yi06+ivwvU4sH/G2bJME=;
	b=dENSQD6nQpw2PvIJSGhL0cgTUjBKM1waxxZJTj24MSvj6M/1FVzUXXOfBVN9gOwBifFB
	 QVkNOd2N5IH3OpcT0lrcdnXJpmOBwHNAK1rlwrPIfQ20QDlVNsfViA8qrMN2ocfmDDpvY
	 tGF0TO288zQJiybIbSM3vG5uYF0FnLGehP8wNoH1x3ulJvEZjo/s9Our9nFRFgqHlZVSk
	 q/Vn1U4jacwzjwPpuoNLAtnJrRPEkvv23s91Y5ww3kFMwG87fp2caZWMDUjuZTfuPuq8i
	 C4bsBKTkwef15ESLdYQnCq02lsLFL1SznAeVoWXyKP2ziQPzyN/twzwBwl9FBGSdAsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=pi0GQmfz;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB6606A31E;
	Thu, 26 Nov 2026 03:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41EB6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=pi0GQmfz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795662310; bh=7DSms2G2kzZgCzBY7xLgXX+yi06+ivwvU4sH/G2bJME=;
	h=From:To:Cc:Subject;
	b=pi0GQmfzDMiwvMFoF0y+PnNKABzifYm5VToIZL89ir2Ti268FWLRyVQkAsipkLCYb
	 HfxDbDqMNhUxDVRoDtg7IyQ8a6vzxqyrDSkrmk1VbQaURwwlHmNr74SJ9c4mru4CCT
	 aLwyXXAOLW9SxxGLAnhsxYF6jiMSqr2q+K5h+AfM=
Received: from [127.0.1.1] ([117.158.156.198])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 148908A7; Thu, 26 Nov 2026 11:05:08 +0800
X-QQ-mid: xmsmtpt1795662308tm6ya3kp7
Message-ID: <tencent_6A656967162479FDA663DC52318C090B7707@qq.com>
X-QQ-XMAILINFO: NAU3xrec257RdwMfDfEeFg5BqtBBB/uvY0/FXI7l+E8ahHkRlDbdWmTrDyUbLM
	 pokp7theLjc4uEpiqGqrzbcaUZdxnZe8Xfyv1HnAhnFxfkgWxYX/cEwpd3CCSXKVloA+l+vXqXIa
	 hXubJmbk0zaFkmqt+odUQvHzInFXcU1nIUYq6fCEcpiIVIsjk6W3D74GpmZxq85HM6w929IOVQrj
	 YCggyX7mDzxv609zweCuw7jghB5UVUpdIHKhiigj1JY9AVo96REgf45Ry8/WYyi7SbUBHItmVDp2
	 XmiOnxZP8NqMi13F58eskAufzHh6jb4oBh/iisKerNY2E1gP+tDl/LTBMoYwliKaUwhbew50ktY1
	 Ctn2a3p/xBIhrTCIVKIWGyp4o4J+BkO7VSGtjZv+6JGsEl5LKjPPcBWIJPr63W/v5zqlORuzpRq9
	 a2mHKtkGelw9SOG1NppzYZvlrDajD9DIVk1yAuEbj45DRYVTK3Ei7HwNRDXQBkaaJiqo3XDlAfnx
	 dfTZn/6bMx13J95B/3mZkUkbJjn8IY8ce2KtNUo5pgyfGEThxy0q211jaCb1dARebHctni4APP93
	 PQnv1PYSepv1o5sbk6UXVgOiASWE1w2xreo1TwyIFqWAipvh+Oy+KgYeIxyV6JAh2YRRig2XjZed
	 YmL9zAd0j/cbtexdIKREEp4oOD6dia6o1YeKXQ7hCIwgNcH4+H+tsCX5+PIVEgHBkMjYkD/ZdlY3
	 0ZghVatOmloUWdSZtuLc4z4YR3kPsIlh6C2mCjUXPhtGjq/Ymdvoc9RhBTd+SDUD92cLvuW1aoWg
	 HUifQULixEvczpsetEX7hbtAv8TZoYhz51pBA4/TmCwYKOu1YLj9PPt/lGiHHruhrx6GxuoZl5vQ
	 ct+pK9NtWDKUdudBy5mtbkfU/55pOf+yiX5dwIpPZkxm6yyJAongLrfXFCR15NktnNYrQqOCw/RC
	 js3ThjFIqDHbmdPnmEuQXP+vrOURfew9nqJYmUmteIb33+gC+9axYlw/T4OFyaeq5RGHVW4GOV/r
	 xHHZSXIlSVoYBjT5GsYS736tU9aWHqH+8CVIV5K7of/n/nTA6L3dqaQf+rRHuN65RiXuoX3XaYC9
	 hJmwkwwuOy1UkWORT1mXWT3EPBS4zhR5nIVpJF
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Shuai Liu <847807867@qq.com>
To: pabeni@redhat.com
Cc: steffen.klassert@secunet.com, netdev@vger.kernel.org, edumazet@kernel.org, kuba@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] xfrm: interface: drop non-IP packets before pskb_inet_may_pull()

SGkgUGFvbG8sCgpZZXMsIHRoYW5rcyEgVGhhdCB3b3JrcyBmb3IgbWUuCgovUAo=


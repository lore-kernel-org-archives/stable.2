Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793241865;
	b=q2YTxqDuP+ihBvHDM+C2dEvB9kQ6KChjXkPwpxg/dyGhMyli9hgwMOPXmpHerq+HvcSQ
	 aCaB6jyorf/XPLaZuQtRAiSjyJfsFKAEk2NIDPNoGychZeB+u23xzwQ3pIElJvX6lfYHb
	 TUOciCmpBsWC0+ONFhdwnSLVvHxeLiGhVjrIjuU084MaCRf3/Z1GGpmTasb0AAzzaZTVZ
	 syk7O1fJQIq+Fh5uxeVNSRsBCHcSmSvWNpFUOWm9oJN/FlxH0GgkFHOsWxow8ZBRgPjfP
	 mM967qXRuGoRMHlMOmuuAXhvcMyxY6n5ZpuzB8hGVbK6Ftnpl4qYk1NKhbz9hbzNi4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241865;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/C3ujp+ELk6cWY49J49ntJXJJ00OgMPF/+VSpV20OUw=;
	b=eQG74xgnceE1IXem1IOaJR6u3bw+iuahVefGbL4o+QuOLn65pAKAOdLTPILhfT34QxmM
	 /mLvmsKgPAmYZlq1WgWtt4vDZXIIgtxpbdnQsNZZQNXVhGe2qSSG+fuQ3hIsYVW4FN2q2
	 s3bfd3UKSp3thAgj7JagKoNtZmIbpGSHS2zvocqR9fTv0JGXKkYIad2yj0g61tRBKgXwZ
	 kOs7dlfI9ge+BFDaTuYo/rz21xcOC6YWSwD8+4v4iqBdhQk6Hn9+REy3aaZY4gSkPbymr
	 sI2kLuxhJEOGGNsq6P+Xdl7c3QQXvG4JxSGzCBW7gwskmY3OgCTT6UMMuv1CF41wq+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b="Y156L0/R";
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9E5606A31D;
	Thu, 29 Oct 2026 02:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F9E5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=Y156L0/R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793241858;
	bh=/C3ujp+ELk6cWY49J49ntJXJJ00OgMPF/+VSpV20OUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y156L0/RA4vBrOpqSKuRn0XxErIB/85DOZrztqR3BCEUtDLTPMFi/D96joES+62Ga
	 j4+WC0xAqrI0GeQubLmD8e9VVMYe7N8vMBg3GLPfnbiMQ1XrPcWJb94gSq6zr+OImj
	 de4l4FvP+H4F9OLCe9L6d6YWXUrz0zZGk1tW+FrY=
Received: from HAPYCAO-MC1.tencent.com ([61.151.228.146])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id B101D0E5; Thu, 29 Oct 2026 10:44:16 +0800
X-QQ-mid: xmsmtpt1793241856t59axzimr
Message-ID: <tencent_365DE7BE440AE36819A526302155B355CE0A@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeHYdrtKaC9TgtzSqfUBYydqPt+7wm7Vhf3I5yzRiKgUYP8QohXp
	 qjoXJ4O8FQ2dN/ZXA9egApEPQuJL8ibgPyfgLcG0gMmq3Ae5mPWy7wCKQ83CN51PQ2oJ5Dyxt1j2
	 XOBiCFNsb0/un8ZWFn0sYVVhfCdJdvr97Ja00ZCXOZe6H5gAY0s0wqlNDTIRBDZOVqL275AkCsr+
	 +0fE8WRy5IFJc+HEnTFG1dXl9fRgQBKYObaN93kukgFtQRoqHzgqKNnMeAx2IO+pHR1QmMP7hXD0
	 9dJwFyyJSom1L1yKy1fNMisPWcXHFzPBdlOd8CM6aTg2H9b9vJBR5JeikOuQ7LU293CQVu1EDaLK
	 2FLqV2Qdr3uJYOZq3hEKoD4MX2sSnCFKvW6NuAuCKYAUn7CcMMJn4uAHXIgWWScPJZCSbqrS8c+U
	 cF0TIUNHV3NsQ3z02zqdCjqP+VeMjs9+iptFC9VAXhkCHT23rs4KQDFm736M4tz1tbc3U2tgyXAQ
	 MsOcdnyx3Ax3+WdygV1IICT0GjPKB3tbdR/uJ0/ezTsssHmmPlSiMjHnp7CBMXRdN4AslqXQPA18
	 NLfriL+UuJSxO3s4I2HDEBvCtg4BWg5P1Pa+fxqzYi0cAWjtsgjFu50zl8lC+By7pCrvrFaNQxUx
	 MuGiDJt1gQIZ9NTxTZLCyCoHIBDSfTyKzSieSRoVNmlSKvE11MoFRPPkMISyXXLGWIbsA71UI5lW
	 a/W/7n+3PC5IdfRi8I+1hF6BvXroW1YmG+p7EhOMH28bTB00l32zMtw3s36I/YelUZy1CqD2Xp1+
	 ZZ6lzCtpjIxP83VmGxBHek982y964pT6BMFncQbfrm+egPVtc5h/dd+NbpwbU08EBTQ2xEUMK1QG
	 mNtTXO1kCwGVNx0XOAtaUravMxk8i92lePMAZvqOsEDk7ZlPFU0vft76vM7z4Z4jhsiigPUdUH/d
	 ThfJiqZNO7CoIoItTC+sIwe3QQGob/MxS1Av6zmeVlUk7QRHTnruMFNPay8ZahZ0X3WXki5510rO
	 WG1K453JfehIpXVbhe7s+EOMoa9AI8Y+4FWdt39Usncz2+UsLEMMESnJU2zBBA9B+OLDrX8WssuA
	 wpQhhh
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: bo cao <treebacker@foxmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: fix dead half of the MTU guard in __ip6_append_data()
Date: Thu, 29 Oct 2026 10:44:15 +0800
X-OQ-MSGID: <20261029024415.33250-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <179324160941.3327.14128311361745862229@kernel.org>
References: <179324160941.3327.14128311361745862229@kernel.org>
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

Hi!

Both points, for the record:

How it was found: LLM-assisted manual review of the MTU guard in
__ip6_append_data().  The second half of the guard,
((mtu - fragheaderlen) & ~7) + fragheaderlen <=
sizeof(struct frag_hdr), is trivially false for any real
fragheaderlen (it compares an expression dominated by fragheaderlen
against the constant 8), which led to a closer look at what that
comparison was supposed to protect against.

It was actually triggered.  Reproduced on a stock Ubuntu
7.3.0-9-generic kernel (arm64, QEMU) with a plain raw socket
(CAP_NET_RAW), no KASAN needed:

  - setsockopt(IPV6_MTU, 1281) on a route whose fragheaderlen is 1280
    (a 1240-byte Hop-by-Hop options cmsg), MSG_MORE, egress device
    without NETIF_F_SG:

    skbuff: skb_over_panic: text:... len:61280 put:61280
            head:... tail:0xef78 end:0x6c0 dev:<NULL>
    ------------[ cut here ]------------
    kernel BUG at net/core/skbuff.c:214!
    Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
    CPU: 3 UID: 0 PID: 1378 Comm: ipv6_maxfraglen
    pc : skb_panic+0x5c/0x60
    Call trace:
     skb_panic+0x5c/0x60 (P)
     skb_put+0x9c/0xa8
     __ip6_append_data+0xf80/0x1948
     ip6_append_data+0x94/0x2a8
     rawv6_sendmsg+0x588/0x988
     inet_sendmsg+0x4c/0xa8
     __sock_sendmsg+0x78/0x100
     ____sys_sendmsg+0x268/0x308
     ...

    (put:61280 = 60000 payload + 1280 fragheaderlen, exactly the wrap
    predicted by the dead comparison)

  - negative control, same setup with IPV6_MTU = 1288 (delta 8, just
    outside the broken window): sendmsg() returns -EMSGSIZE cleanly,
    no crash.  The crash/-EMSGSIZE boundary sits exactly where the
    dead comparison should have been checking.

The v2 guard rejects both: maxfraglen < fragheaderlen +
sizeof(struct frag_hdr) + 8 -> -EMSGSIZE.  The xfrm transport-mode
variant pointed out in the review of v1 is code-inspection only; it
was not triggered at runtime.


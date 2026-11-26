Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662253;
	b=ntLWer4zZts/xoLyMuhdWA6T6zxiRbljH6i+HjCv5YBpfrcUvBgi9Py4vyUqfaP1V+l0
	 mg9JcNu29nBTFXFpnCTxh6t6o0rvCRrvJhdElqapNPxRw5rL8TtVvbHGcQb8SA2RogWNV
	 7cAbatQ24mjLNCsERIwZG42c4Who7vdnRrI/X1zAbv30XqikvSVN7ql+iMF3rtUaoUVxi
	 2V4SvDCzIxoFWqp692Zyg3DCA+jyiExu0PzC9PU8dDMRXEb69karXmcV7dR2oSd4h/rFf
	 mvudWgdeiUdg1T/QQ+2JfLu88rTMCk9elazvOsEvltqcwQGZ3iM9LLPlv9GtdaXaF3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662253;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:From:To:Cc:Subject;
	bh=7DSms2G2kzZgCzBY7xLgXX+yi06+ivwvU4sH/G2bJME=;
	b=H9jBntTiR2LMr4A8MybgWL+qpk80JdRagbYtz01nrd37h4Mk3yE9TfXh0CVkeMscolBz
	 VGYW3Z+8SwTKxt1ld1WhUsououuQJ9kOFOmhSoRG7WlhGNFL2RfkW70uAvJfwoJu6Kf23
	 BZR4PSXzzVCLBoYXaQV5xrCIQJlZFng/bM0wn6wSit/poFY5aI6KqbPOrbV0UXgRRMDvA
	 oPqy7V/Q5KJ0xuwC/rZp5Rs4SRbLY3gi83wtvqzAzv8FpoPhbFtA1yGdGNxLAuswqM1lS
	 /UtBwKFXQxh8yYyftHJbIaIIY8etM6oMLANbxRjv/8eg/gRbpB0qBU//xR4LTUXno5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=vHih3F2Z;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C2D606A321;
	Thu, 26 Nov 2026 03:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08C2D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=vHih3F2Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795662241; bh=7DSms2G2kzZgCzBY7xLgXX+yi06+ivwvU4sH/G2bJME=;
	h=From:To:Cc:Subject;
	b=vHih3F2Z6is/XPo6R2BfWRPzEIAxR2K9Cgps54Soki+9DQ6s22Vm6JyjTsIqPkKiC
	 PyPw27D8X06u5QOr9nGvLY+eKNtG60Ww5ADlqSxBd0CIEAHwou73ryMgDSoAlcaCXw
	 l0QeybpjtVey8d0+fwqWYnA97ZnGkDdP83RTSaiQ=
Received: from [127.0.1.1] ([117.158.156.198])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id FABBC76; Thu, 26 Nov 2026 11:03:58 +0800
X-QQ-mid: xmsmtpt1795662238t8w5bd3ws
Message-ID: <tencent_F3B1C5CA2672DCC7A5FD5834E4FD9A3E7109@qq.com>
X-QQ-XMAILINFO: M1JY6XCfJolW0kt7rNVD1MQqjbnfDGoiF+5WOizqXeZaLI4M0onlpsEcEdbfFd
	 ULj72UHRyWeH9gasWrWq453sEAdCZ+vp0gYo90T49yhMXTHYDLzAso6A7zpsFAwHMxsUDe6MOF9X
	 ObWyOb9oERzOdOmo03H36WGqz9YcjYBD0Y+2o9uuSmF5cSNBULPEQLO+nFcXSWpZVz1MFymcCx5T
	 LhHfV5Sl2+LgvKPkAIl29bAr0/ecsklyQNiNZjva5ugsXyN7lqizlEai3JgDgxzXP3gRFBGT5YvZ
	 lB7XFQboO5ywx+v3go+aZzpRVEYsf1vUXoaPhKSZ+jXPmA30E5m9a4WpyHpLjk0yzsBJd48ExF1K
	 dcI7CtUTyxlo75yo+FWUWSdOa2tjTwKfKkLUODqLGAMwm5p8IwcEeJ0XLIPXm/iMOByEB4LJDXJc
	 1zHwqyW58ReuvK6rXrCup6swle/iD84+APPNMjiAlX8gXp0kvJVjWS9eEzAjQ2g10Mwk8j4SNcVk
	 xcLT6WxoRvGiVrxIgTgYedDUyTjzcTtUYZqfU+sffQDUCAu1LiCK/fbPuvOg/Av8u7Vq6++6/3UH
	 83ayYQuOAU9+Ap0GZa0wkc22z7CcDHiqAbzYbLOqvx/PT+Xr0vOFBK22bBfOuAUlGj/lwEFQoLAT
	 MMeTkxHStC1X1fa05ycgJAOcek9TfIbutJ+xB19qnB2xRzW9KCcENIwLFLSPdLv8vL8fXYaCp1H8
	 0m6OLTA/93YisWiYX3qn0kneZOYNj4V4+AzaogY2+ABgocAkHXEOem3mWJa6VTZdsRfIvZhzVBLl
	 8DzvXYtg/jq7m9hMpC9PbOwwlEhZivI2+TIvt57cRvvFhlkXxkXkuqrVfST/BV/ZucKXrXyo07lU
	 6nRJoISJsNJdY5+oRzLh++JfJuFTsFbYwBlb7Hp/QTnVKtykcJiA1aZsOn3jKMHBBxrxe0ARADAP
	 nj9UzB+ToKwstURH8qQWaBhrktBez+tvCnEOqgaatvnovBFtfzmeiCnihxC5yAHealebFPIEQOE9
	 VY0D3dT5yTTlxkvbJt2Tnu0jUEljcbMPNp6Yd0lsRquQ75SVlQ
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
Cc: steffen.klassert@secunet.com, netdev@vger.kernel.org, edumazet@kernel.org, kuba@kernel.org, herms@kernel.org, q.hack.winter@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH net] xfrm: interface: drop non-IP packets before pskb_inet_may_pull()

SGkgUGFvbG8sCgpZZXMsIHRoYW5rcyEgVGhhdCB3b3JrcyBmb3IgbWUuCgovUAo=


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785848;
	b=KaP0DtOFB6HFh2YDkit8cj7NbmyRMq/n0n2fMKsEX66EQY8Dlf8ZY+TR6MaQWqe9iF1P
	 nhETP4jVSA8V/T4GNPusByJEkVaS9i/4RUxYnzLpUDk86rc76FZpy1Y6leR/x1O1rcvZ3
	 uFd653HK8CCqXRpi5RhuyNbu12LDddrtB63oPphVG4hW5zhgwiDtrf8t5N3jhutEnosmI
	 LyYPDfz3EHEI+xHLN3s7heKMhujUkySQPbppjA4FwgnBIjhhi5fYowpgdRjtE8mEyDMCV
	 sNnzBktQMUV6E2RYl8lumrhdNsnLKtmVGXfJdsK4Y/Nr8H5LFVfoYUBTe0x5VfoYVVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785848;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9haYXd/UWyFd/jLYHzcyL3Sy1SxVQ+wFOB48yCCIQmY=;
	b=LJmBVWAojk0XEe8ujzTYKoYOs0V7ehQFyYLgVHdgOuKQyfjbJTwPwQLkNQqa8xvclpcr
	 3j45eK6sti5nZo0SR6aeDIDIW5wjCv16i4/8KyZ0pOAqLIjt5CjOZG6smDoCEHl+gRPZI
	 R4pCv+jdoLMoYvsLDO33bbfomniFy7BT2YypjKv6ldiodeHVIj3w5XCY7DK3LJxk04zHm
	 AXAaKyhHs0xODPcIqbL5RH69no8tctDYo/MNFa2grddlCnSLV2egcQGsYPK3lo2IzrkFp
	 aNDKG8Kzwqajdcqlp7/4snbB90lFsSzVaLWjmF9qXhleOL4XXq8pzFEvl3yGpiTOG4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=LTkJls+x;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DAD606A32D;
	Wed,  4 Nov 2026 09:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9DAD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=LTkJls+x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=LTkJls+xs+UEK1jjhQ4cTmzm9D+A1TdCvCtsYSGSwxjMGdKVmPdRx5uxa0ezSSCzE5FgZxrr8yihD
	 Vff5QrYzuWwi3ZceRuY7OqnWK9a8iCe0msaiE1Q9VtfxTD5NS+3mFshgMOrHWwA6whbWrcZ+NBhFYW
	 TxwaPUYkTSKqebKY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36aeafff4b36-68ed2;
	Wed, 04 Nov 2026 17:50:44 +0800 (CST)
X-RM-TRANSID:2ee36aeafff4b36-68ed2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96aeafff2e32-1d21a;
	Wed, 04 Nov 2026 17:50:44 +0800 (CST)
X-RM-TRANSID:2ee96aeafff2e32-1d21a
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	willemb@google.com
Subject: Re: [PATCH net v2 1/2] ipv6: fix cached route reuse for SO_MARK control messages
Date: Wed,  4 Nov 2026 17:50:31 +0800
Message-ID: <20261104095003.23492-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179378454460.488859.3601103924224875787@kernel.org>
References: <20261104092240.15649-1-yanxia@cmss.chinamobile.com> <179378454460.488859.3601103924224875787@kernel.org>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi,

On how the issue was discovered: during code review of IPv6 UDP route
caching. v1 carried this in its commit message ("Found during code
review of IPv6 UDP route caching."); the v2 rewrite dropped the
sentence:

https://lore.kernel.org/netdev/20261030141435.779302-1-yanxia@cmss.chinamobile.com/

The concurrent variant came out of the review of v1, which prompted
the v2 rework. The v2 commit message notes this already.

Best regards,
Xia Yan



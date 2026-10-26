Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.31.73.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033489;
	b=c1QvfMP5qahnFUD2aMz34dC3FLjWDijRGeKbz/fgP7Qoig3z4Zy/3/bmttSO+bcB3o3c
	 ODjmwwMKE8AqkbRQmzg9wtJN4ODxuukIhdJNCsU8HPCv+gzCGNsjKD0/hhL7tylYqro8Q
	 L0cjWwMv7fo/lkzOvhDAFIi6iHfAVqynlMSKf54lwqVZ/l/J9FtOcNhhVJf613Wc46SF1
	 mYLbhoAg1d4ksFHY8e+qJurIa95ZZ55xVsBVmP9M7WTB3/gijKTBJscU0wX/OnEbUEeAZ
	 6ieWOkHIhFmMV+/E+iMFlD584qcn+9pio6R51q6cvqzsfn1k0nOsVqKzTSmWL+LZjpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033489;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:
	 Content-Language:Autocrypt:Organization:Content-Type:
	 Content-Transfer-Encoding;
	bh=JpYm+GipSnbcvCoj/V9iSt7A187EAklCfzrFeqvUtMI=;
	b=F62h9aeSKEybFitYfnoBUjmcEHUr9VND0lDlYR2UVYCKG4lLFYF7stiTNeJqDhJCw9g5
	 GLjPcZq5iaekJouQXIht3KuLov0IKdExidUaB9XFcEDhp99AbRfSJqJX4WrSSO8B9DDEi
	 nboV73gn5t8Jdous+6/VHmHnVORnB1XB3zYroCSW5IgXyfFjsb/3P8Io7/t1wgghCo8RF
	 xIbpxbXowCUJ4JXii8E4DQnFLc6g30Cy191wzIdKb8WpwXm+ziARToHcNmQaIAWYdljU3
	 MIJDM46fPPmL5wa0KawZlrVfYLwNcwTaaL+/+C1Ykf9EzDORBr5R/k0yIJNBv3QzRXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eosdev.it;
	spf=pass smtp.mailfrom=eosdev.it;
	dkim=pass header.d=eosdev.it header.i=@eosdev.it header.a=rsa-sha256 header.s=list.eosdev.it header.b=jA0Agd+a;
	dkim=pass header.d=eosdev.it header.i=@eosdev.it header.a=rsa-sha256 header.s=list.eosdev.it header.b=jA0Agd+a;
	arc=none smtp.remote-ip=89.31.73.190
Received: from smtpauthcli.interhost.it (smtpauthcli.interhost.it [89.31.73.190])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D7606A31A;
	Mon, 26 Oct 2026 16:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D0D7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eosdev.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eosdev.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=eosdev.it header.i=@eosdev.it header.a=rsa-sha256 header.s=list.eosdev.it header.b=jA0Agd+a;
	dkim=pass (2048-bit key) header.d=eosdev.it header.i=@eosdev.it header.a=rsa-sha256 header.s=list.eosdev.it header.b=jA0Agd+a
Received: by smtpauthcli.interhost.it (Postfix, from userid 1000)
	id F33ABA26AB; Mon, 26 Oct 2026 17:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=eosdev.it;
	s=list.eosdev.it; t=1793033477;
	bh=ZxTiioJ6b7RWNBjfsRuabOTUrn9zjNjT2s3ACaZvFcs=;
	h=Date:From:Subject:To:Cc:From;
	b=jA0Agd+aGon0Arek3u5MIl7qF8v5O3ewgmXlVBPItezZ5fboVqTEygjwSxGQRW3L2
	 12IecwNwJS+xP6glvOtYJ+VwSmenQChrmomBjUbkDMkzoydvRaPkiuo6jXyGtJCwU9
	 mQEIP3B13HbOUlZabLl6eyVLKeNLrZl3Lo44UxNwPshFd2XomImyKA2jDwhaO0I8aN
	 G8nPrrxeVb+3FSFsXEh/p4XHPxSO0r/U3k7ZFVU2BjZgIjxtCujQ/fQ3ApZ6KWA4xu
	 7XFhMuAWsAlv/+PiGnTGXUI24jvtuEHilv6f6nRziGKJunR2RpXVVqEru4Go/SjPYS
	 hS3RL+kc0QJSg==
Received: from [192.168.1.30] (host-79-22-56-114.retail.telecomitalia.it [79.22.56.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: morini@eosdev.it)
	by smtpauthcli.interhost.it (Postfix) with ESMTPSA id 1FC1AA26B7;
	Mon, 26 Oct 2026 17:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=eosdev.it;
	s=list.eosdev.it; t=1793033477;
	bh=ZxTiioJ6b7RWNBjfsRuabOTUrn9zjNjT2s3ACaZvFcs=;
	h=Date:From:Subject:To:Cc:From;
	b=jA0Agd+aGon0Arek3u5MIl7qF8v5O3ewgmXlVBPItezZ5fboVqTEygjwSxGQRW3L2
	 12IecwNwJS+xP6glvOtYJ+VwSmenQChrmomBjUbkDMkzoydvRaPkiuo6jXyGtJCwU9
	 mQEIP3B13HbOUlZabLl6eyVLKeNLrZl3Lo44UxNwPshFd2XomImyKA2jDwhaO0I8aN
	 G8nPrrxeVb+3FSFsXEh/p4XHPxSO0r/U3k7ZFVU2BjZgIjxtCujQ/fQ3ApZ6KWA4xu
	 7XFhMuAWsAlv/+PiGnTGXUI24jvtuEHilv6f6nRziGKJunR2RpXVVqEru4Go/SjPYS
	 hS3RL+kc0QJSg==
Message-ID: <50c31a4e-9a41-46bf-9c70-ccbc1ed07b2e@eosdev.it>
Date: Mon, 26 Oct 2026 17:51:16 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: EOS - Manlio Morini <morini@eosdev.it>
Subject: [5.15.y] Request to backport c567c86b90d4 (md/raid10 fstrim kernel
 crash)
To: stable@vger.kernel.org
Cc: linux-raid@vger.kernel.org
Content-Language: it
Autocrypt: addr=morini@eosdev.it; keydata=
 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
Organization: EOS di Manlio Morini
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'd like to request the backport of the following upstream commit to the 
Linux 5.15.y stable series:

---

c567c86b90d4715081adfe5eb812141a5b6b4883
md: move initialization and destruction of 'io_acct_set' to md.c

---

The regression was introduced in 5.15.181 by commit 4a05f7ae3371 
("md/raid10: fix missing discard IO accounting"), which depends on the 
above commit.

Without this prerequisite, running fstrim on an MD RAID10 array can 
cause a NULL pointer dereference and crash the kernel.

I have reproduced this crash on my Slackware workstation running Linux 
5.15.223.

The issue was independently investigated and fixed by Canonical in 
Ubuntu's 5.15 kernel:

* https://bugs.launchpad.net/bugs/2117395

*https://lists.ubuntu.com/archives/kernel-team/2025-July/161560.html

The prerequisite was also backported to the Linux 6.1.y stable series:

* https://lists.openwall.net/linux-kernel/2025/05/06/1629

My original report:

* 
https://blog.eosdev.it/2025/07/attenzione-fstrim-su-raid-10-crash-del.html

Since this is a reproducible kernel crash caused by a missing dependency 
of an already backported commit, could the necessary fix also be 
considered for the 5.15.y stable series?

Thank you for your work on maintaining the stable kernels.

Best regards,
Manlio Morini


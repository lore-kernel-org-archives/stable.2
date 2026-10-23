Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792721142;
	b=CXrQc7MhVB4myoaqgFfhJZ9zWgANr5iXaEidSF41xYfo7GbLoEbvi8IGBfGVumtemwo2
	 1yTd4KwCasFU7udr/R56josQ7yEtlY9wLfqphLFM4+qoU1rwoH9bppWjHFQRa+MHzSWHh
	 Xfme7I+fmdP/Os6vsDgS78YdL04fIrX/gOPHhHCtXnvsEhSKFMW6bSNBclLRMPP3uHnDM
	 adquvbjpajTX18oZFdHGXgi1UQ6N7lEjGwE5P+M0ToYuXO2A7WNdxODNlFY4AGClNQgdZ
	 pTv1ejqAOwGbCAJgkK139qsIGu41IyswqsSR7Xl97NWdrzFhzlkL64cZyLQYXniXBAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792721142;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LX3zxYQyvfrNwe42lsC8vf9OHuENbZBYZjIatYYVCTk=;
	b=WKiooHbQfzqs/Q0IIbDShkT3w+7vAbi43w/qA/0E/TqcUPbAEccNaKd7wKOX6S71NJ3v
	 //gHEju9Qc+WBxtnlg8koTTqQFgJfdhGiGmAYsOjDNrLeb+d7R1mVken9bxSzfvyTNSmU
	 /JxGZ8VMLl6VmTylgRjiHraWjUSD52LoAIfBAU+VOWm2L6q/4u04++sUQBvz+/09TRygx
	 6P/mhUpGlYWAWd3cHPMgcsfbJS3Z3Q34H11qPjesk+yf2uexGbHqwp2nt5iHuiS0AS840
	 7SQb7iKtsH/BI/jcBQfHiaoW6zvK89uanaRWn+tRk/RkU8+vXFvA5B5jLOwRnwgOb8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=EfA5Iekn;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7CD606A319;
	Fri, 23 Oct 2026 02:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D7CD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=EfA5Iekn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=EfA5Iekn2v4LS26q/Kfqe0Yo8u/o1lDimp7S0SolJBUV3sbxyitFMYmSpVnbIYpITpi8IlvJfq1B2
	 tZohCrA2g66Vf9CrHReC/hoIf2dMcfiLoHVH0BmwyDcCuN8F/G4V8r7EEtXt5xRtA6KFKrKh84+z+x
	 5k0aZ8FpwC1T6fIw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96adac0efa13-38fe7;
	Fri, 23 Oct 2026 10:05:37 +0800 (CST)
X-RM-TRANSID:2ee96adac0efa13-38fe7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26adac0ef013-2f6a8;
	Fri, 23 Oct 2026 10:05:36 +0800 (CST)
X-RM-TRANSID:2ee26adac0ef013-2f6a8
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com,
	john.fastabend@gmail.com
Subject: Re: [PATCH net] macvlan: fix passthru promiscuity accounting while down
Date: Fri, 23 Oct 2026 10:05:23 +0800
Message-ID: <20261023020524.277289-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022090809.12019-1-yanxia@cmss.chinamobile.com>
References: <20261022090809.12019-1-yanxia@cmss.chinamobile.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi John,

Adding you to Cc; I missed you on the original submission.

The patch fixes passthru promiscuity accounting when NOPROMISC is
changed while the macvlan interface is down:

https://lore.kernel.org/netdev/20261022090809.12019-1-yanxia@cmss.chinamobile.com/

Best regards,
Xia Yan



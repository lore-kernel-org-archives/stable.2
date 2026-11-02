Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628898;
	b=yJfeVQo8PhgmG4Cfbn4GNFZ796pewsmHDYllR+LI/dTOYSlmPQxeQCoUNXZtZ5FI+HjO
	 UnhgCPy4Myxk9avD4NjX6RjDjqDWdiX4IYJ7KxuNxDhiv4ftElOxfWvBRr73fBDG0aKfo
	 sS+6cYmF6mQBwL9AKmHJMs7rVgylDdh4CJhaeEJc34qAGYkMI+1mLYxKazd5Nl/vSFvLs
	 BB4skmZH2hklv0GmJixtMuWy/qzIvgEE6etBqSyDnOack749jMIIklNgLs4UNh5zDsE5H
	 hRpB9lL0iB+BAOeLrj/PuIZO55kh2rqt0ZG8bM57DVLdWgiRAFD786iAWIBUMUzUxeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628898;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8+TUm50QUxPlF6kV8aTnHh7tj4ymOgWQczPXKqcsgps=;
	b=Npl+0E7eQTVkB86k3mXvcNih27cv/dvFc9fy8z4OFBt4H+2fim1DsTOQI8Hn8sELcTpb
	 YjbuKdLEvfYi+LmIGufVyNkF07MXZ8Mtd2A+kXTwm4rKGq9Hp16C9in3Sp/Qi+A/Ma4k5
	 Xaqejm20jncYPVawvvgODcFL0GxdmmrU7biDzdZPVvQBlgEMueQCMM4eJ0WQgZjjMBoo7
	 WK97IrR6J7bhux2ucpvUSJxMM09FldNlQnxmPUH/cpS+MOl5aX+8F5AlGP7v+4olLTQyA
	 ZQXgWBI3aL/nKPtOcOQ1BmQrQvlMxIyzjN0aqOyGtZKPSbB66ZnkE96CcHRwgIkUfsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ycEcgu+s;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02EA60A3832;
	Mon,  2 Nov 2026 14:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B02EA60A3832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ycEcgu+s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ycEcgu+s+neTmnM7TKA1V0bx9kJSLfZbh8EqVAkprnKgSOiRbb7DKfeMevtPMsSflIuAMn26Dy6t1
	 feXlCCnHLj00Z4SxyM5vnLv3Pn/R2DV+EAo0ARMdJtTm2Qb9YIbZgKNBzxNPLNC/EU2iybj4fPyU8c
	 pEBlbL46tOwZyvjs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56ae89ad3132-88258;
	Mon, 02 Nov 2026 22:14:52 +0800 (CST)
X-RM-TRANSID:2ee56ae89ad3132-88258
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26ae89ad9a5a-d4486;
	Mon, 02 Nov 2026 22:14:52 +0800 (CST)
X-RM-TRANSID:2ee26ae89ad9a5a-d4486
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org,
	edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com,
	netdev-bot+sashiko@kernel.org
Subject: Re: [PATCH net] tcp: fix device binding after failed IPv6 connect
Date: Mon,  2 Nov 2026 22:14:38 +0800
Message-ID: <20261102141320.129787-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <062d02ca-e9e1-4f4e-ac57-0de27272a205@linux.dev>
References: <20261031074654.73952-1-yanxia@cmss.chinamobile.com> <062d02ca-e9e1-4f4e-ac57-0de27272a205@linux.dev>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiayuan,

> Reverse xmas tree please

Done in v2.

> inet_bhash2_reset_saddr uses sk_bound_dev_if too.

Agreed. v2 restores it before tcp_set_state(TCP_CLOSE) and
inet_bhash2_reset_saddr(). I reproduced the bind2 warning with v1 in
the VRF test; it's gone with v2.

v2 also restores only a scope binding installed by this call and keeps
a different binding set by a later callback. It avoids restoring again
after the TCP_CLOSE callback. The UML tests cover both VRF cleanup and
BPF binding changes; all 39 checks pass with v2.

On the asynchronous failures from the bot review: those go through
disconnect after tcp_v6_connect() has returned successfully. Retaining
the binding there predates v1. Handling it would mean tracking the
implicit binding across disconnect; v2 is limited to synchronous
connect errors and makes that scope explicit in the commit message.

Thanks for the review. I'll send v2 as a separate thread.

Best regards,
Xia Yan

pw-bot: cr



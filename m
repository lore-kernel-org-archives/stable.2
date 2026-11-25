Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598130;
	b=gJKyhrfAXMeYyiqNsN2HGBSKZ4sccGvJZ48CBeNKiN0BOasIWBZM1hN13/idkPLOPkdd
	 JyvJYMzUVP4HP7QkErgrq1sr0Xlte3bsluOWaESXK1awzchXMAbsiUHdf8ypFrZ0I+UHX
	 VGi9ehLxFg3sirKaxD4U3TA6W5Ki0nLimfdYPm+hy5nFGUfdNBhf0v5ecqoXf5drwbC9f
	 zECnrs3u0XVRWi/Rtwm0oGLky6qpGViZ/pik6GsFa8P4SQYfSOk5OLokoICfY34TF7dJK
	 lEbJiAwhgRwxy/VPyjXg831ad+8iJfxZgIOu0ME2SCryBo4NzvNGesLwukaPi2PmHkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598130;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=qL10nvHEwdTmUMJPxg7/+X8qrkeK6KAG0Pm7Siy/6nA=;
	b=2pshFOAJ03r3VkF3Lvz64QkDSFa7zfYm+qStz+CnlkxCah+w1vSIYiQoFG6jrc1ElN2H
	 JJ94NC7e34cqs9Zexv0dgeTF56PUMOX/cG2NMjWRw6reSORzkcCzKZCkorYie7SD8klxd
	 JmMW9sAJEOEJNRJ0jBMT7BEohg7b2PhoIX4TRJdUHBpaWb+oVUy+hj7vTz+PIvwNp2qZU
	 jtbO33Q8SpXeb7iisylg9xbKF36mCn+pW/aQALdMQQO/eDjWZqLVtUYtynv8ZnWHtZhva
	 WW//TmvelxhvkoB7qf1lAWNGqG1fRbYJvvJAZ26jwwc+bEW6FgDmleYzk4srgRTI/8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=kE4Zchjs;
	arc=none smtp.remote-ip=115.124.28.124
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1347A606A68B;
	Wed, 25 Nov 2026 09:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1347A606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=kE4Zchjs
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795598121; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=qL10nvHEwdTmUMJPxg7/+X8qrkeK6KAG0Pm7Siy/6nA=;
	b=kE4Zchjs3DlBh6GjN3mBQlBjIe9PqQ0vBkF6RpRHvZuDKmHg3YHivSPa8IXrD00sNBvJdtLKP+L0ex+W4cTOToeg3OiLiDY2joGyddB3kQ0N1ODiCIIco2muQkmgnDArH1Tmv0JU47WbDKu/Oi795Whz0QY4F4pY8VEtfNvC+l8=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1252102|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.13382-0.0232529-0.842927;FP=16697869609984783871|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045038069;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.k9n09Xn_1795598120;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k9n09Xn_1795598120 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 17:15:20 +0800
From: Zhu GuangLei <zhugl3@xiaopeng.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com
Subject: Re: [PATCH] misc/pvpanic: share the shutdown handler across devices
Date: Wed, 25 Nov 2026 17:15:19 +0800
Message-ID: <20261125091519.173761-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026112504-halves-payer-1293@gregkh>
References: <20261125080635.112699-1-zhugl3@xiaopeng.com> <2026112504-halves-payer-1293@gregkh>
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
Content-Transfer-Encoding: 8bit

On Wed, Nov 25, 2026 at 09:34:22AM +0100, Greg Kroah-Hartman wrote:
> > Register a single handler for the driver and keep it as long as at
> > least one device has the shutdown event enabled. Serialize updates of
> > the events mask and of the handler registration with a mutex. The
> > panic and power-off paths still take only the list spinlock, so access
> > the events mask with READ_ONCE()/WRITE_ONCE().
>
> If a spinlock is used, why is the read/write once stuff needed?

Because the writer did not take that spinlock: v1 updated the mask
under the new mutex only, while pvpanic_send_event() reads it under
pvpanic_lock. That is not a good reason, though. v2 updates the mask
under pvpanic_lock as well and drops READ_ONCE()/WRITE_ONCE().

> > +        mutex_lock(&pvpanic_sys_off_lock);
>
> guard()?

Yes, will do in v2.

> > +        WRITE_ONCE(pi->events, events);
>
> As you have a global lock here, again, why is WRITE_ONCE() needed?

Same reason as above, it is gone in v2.

thanks,
Zhu GuangLei

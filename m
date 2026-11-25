Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607772;
	b=Z7G1H0ZbPuaxzyZsVyurAkdlftFObmvUSpkXNN4csvkSrI62mQJkkIC8G4fLi8xyWld+
	 tK9ljk6ObVOBe3fOe+CBRZVCcx/c6M4Nf3VPMBCQU8+gOq5BgxzCpBFgf7sUAMNwiays3
	 RNIZTV51bCdOfYNBtj/CAjhFMyDj36IvB1GtVz28BrHyhHfPt7hMjN3ia1bQNiqVFz2Mr
	 jdruNxxoih+L4+v5HtAbernpccH2KAl/jlr/sppUYsgAVE3y9SQM4WHBv+dVIwmiJh68U
	 tQe9QqhF204P/PpWWe87QWN5yIse3YtqAhhE6PaRr7zTyIEXKYN2htKfxHMrXIwPoaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607772;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=VvmVmBtvADozdxW+2qoFKfY+DcernsxCu818DxNzpdg=;
	b=qpK8hl94onaxo/htY6KurGO1ZKp9sSMJ2WJwQBNwNS+ztT9qz8hBel2liVeGN9jdImMk
	 v7IcS4Gv8Zfy1xwVe0QFh5tQIKnCQVzbFR+DPjwXl1w2FamRs81F32poAYQwe6JcUNos3
	 k7VVJePlRez7nJFlrCRRmhKWqGIpjwCYlI9tu/IVZ5SKOX1y3LH0yAQ/tRJU3jNMI6VVz
	 y4MM+YJdRR2AXRxnrntGOxmQpv0hM5CEXueg7zstxo/sOx/80CgMK46hMoQSDu2/Uah98
	 5yeOXaS2jgvQuWCyiuWfBzrmUZkUHqkKNK1vW5lhcNJ29XLT2J6fCObk28bdT5fXwzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="K/bJGAlx";
	arc=none smtp.remote-ip=115.124.28.74
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82E606A323;
	Wed, 25 Nov 2026 11:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D82E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=K/bJGAlx
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795607762; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=VvmVmBtvADozdxW+2qoFKfY+DcernsxCu818DxNzpdg=;
	b=K/bJGAlxreAb/j+RjBVe8aYanIb3lZz/6m6z4gVJS4h3E44QLoPn3YE5c4WWsOaZJB7xWAK833EOQACP92TpOZnrv+lT822T3wZris0IF4pw7W7rw6caK/It994IH0IgOsiv2CSbWGSS97vVfJfhWIeg3dg4WYGBVNxS1ff3MqQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1358065|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0965889-0.00144499-0.901966;FP=16130414216441492699|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034254;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.k9zVnJe_1795607761;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k9zVnJe_1795607761 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 19:56:01 +0800
From: Zhu GuangLei <zhugl3@xiaopeng.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com
Subject: Re: [PATCH v2] misc/pvpanic: share the shutdown handler across devices
Date: Wed, 25 Nov 2026 19:56:00 +0800
Message-ID: <20261125115601.72376-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026112558-shirt-supply-0cf0@gregkh>
References: <20261125080635.112699-1-zhugl3@xiaopeng.com> <20261125091520.173803-1-zhugl3@xiaopeng.com> <2026112558-shirt-supply-0cf0@gregkh>
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

On Wed, Nov 25, 2026 at 11:06:22AM +0100, Greg Kroah-Hartman wrote:
> > +        guard(mutex)(&pvpanic_sys_off_lock);
> > +
> >          return sysfs_emit(buf, "%x\n", pi->events);
> >  }
>
> Why do you need a lock to read a single value that could change right
> after it is read?

You don't, the lock adds nothing there. I'll drop it in v3 and leave
events_show() as it is today.

thanks,
Zhu GuangLei

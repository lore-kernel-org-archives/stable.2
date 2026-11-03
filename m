Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676583;
	b=J288rwbbAWkVv7fKkvANCm3iUIubVzatvxa1TG7Uzwtji/KoJz3RQdsP1155P3rBCrc0
	 n5p3/3EMIpcHgIN5sTUl4M5K+HaTlrdnsK7jMzDpQHGMu3zkHW6vT7pqiYFiMJEjDiC/V
	 KJDGIP9QJpjXlznkIq/FtOLiOoOnRyjVDc5A0uLIlGik6Rd7UEkjBoMenuINXT7gb8Gjm
	 GDVM0VZVQXz1C3rC1JnkfRAU56HvruAFvOAwJWoYFdsrxxYa/yba3CuhfsN7AdJXXf6qj
	 whpxgQx4QXsV1y7g0pB4eQ1GSNKOWXuL7UtUZNyaMbbtLqE8C+7zFs1MuaDWKj2rRJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676583;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ss1QRBiOdnr9UcY/nCSTQQvqTaweAfZZQDUzoYpDMUU=;
	b=n/KEshzwmOYJd0UM+VE7DTxOsf8LVRWmJ06SUhxC2xb+EDtNPsk7yqgUF/nPYOJmQ8J+
	 VPqIvC0wOamQW4Ez6Vd/LalqARvo+flLAYK7Muz27ywWgnsTAoeadDHao1EVyJR40kC+f
	 j7u4krxq8KLavKjYPbn0T7QCiEnFnZ2ONZ5BC+XC6JMBuxh6CUO5kp802ygWtM2vkAoUG
	 AA/UEKJRMvrKwpQYCTh3DBRz5rG/iSX6BScmtiifXH6KnOX/Xcvk5D6AG7HQnwNdPJxq3
	 Y0KCvhdXqxGVMcl54+baClA9xTwLLxX0v4H+seZe4IN47EAVqdvpxeU9RSq4YnOntoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=oeYbuWA3;
	arc=none smtp.remote-ip=115.124.28.171
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72814606A326;
	Tue,  3 Nov 2026 03:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72814606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=oeYbuWA3
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793676578; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Ss1QRBiOdnr9UcY/nCSTQQvqTaweAfZZQDUzoYpDMUU=;
	b=oeYbuWA30U41w3rtaAKRcPt5wdabjBxKNMyJEZNG4DvlLOP/nh/QYDGTdtYnmOm02knA6r1/4z7fCPz3nWBwzj0e9yTJiAotNiXesEGAtBaPelpWT3sl2zrRVIUvhoAV3sX8lDg4LzqtIzjZdoayJstQXr8JoxiftOqNhJU5ZCs=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06301045|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0205256-0.000483592-0.978991;FP=18268939574164468826|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jvDbLeN_1793676576;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jvDbLeN_1793676576 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 11:29:37 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] vhost/vringh: reject zero-length indirect descriptor tables
Date: Tue,  3 Nov 2026 11:29:35 +0800
Message-ID: <20261103032935.58823-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261102122942-mutt-send-email-mst@kernel.org>
References: <20261102122942-mutt-send-email-mst@kernel.org>
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

Hi Michael,

Yes, same fix - sorry. The October 21 posting is a duplicate
of the v2 I posted on September 26:

https://lore.kernel.org/virtualization/20260926160755.21485-1-fangxy@xiaopeng.com/

I resent it as a new patch instead of a v3.

The !len form is equivalent to v2's len < sizeof(struct
vring_desc) check when combined with the modulo check -
zero is the only length below one descriptor that is also
a multiple of the descriptor size.

The diagnostic change is to pass the byte-order converted
len instead of the raw desc->len, so the reported length is
correct when the vring byte order differs from the CPU byte
order.

Would you prefer that I send a v3 on the original v2 thread
with this diagnostic correction, or should I drop the
October 21 posting and leave v2 as is?

Thanks,
Fang

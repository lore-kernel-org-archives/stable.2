Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716186;
	b=h2hbHC4AA+fUm5j/Z4z/d5SN544hm4y7xAbIGazEQfRiX+8PdhK41yOpZhaotucDpq8e
	 CdkkihXFO+NdbjTXaxRCCxk+ORO82Vq0HIM5E3q7/f6LJPA9yX1m8aaTeWZ9rJSXogk1K
	 C6Xn51XLFl7G2AU84+0jTPpK20hsdJNUAyUTXFdh06gUZd+4Td1U/F62hXl2/Aw94HPav
	 N3xhBueizu08x4ES0I+Inwm89C6wP9AiGCRADPCOslDvpkFC3qa3G6KWoTdL+mOXot8T5
	 yF1k5zXzsEiF/fyyhm19k+Nsu6ZV6WFkL8aJMc48T2UTXHe1I1657jP0KT/ZC3Ih2Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716186;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n/GZUP2ZsjOuhhEd/klWEvvXLu7voLybiNnp082YBt8=;
	b=ULF6mYSHZC1cqhi956tZVUwzghYWxa/BLcgdYBWRD1OGRVb1DNGOYfsG+C9NjLZSfIbZ
	 iSJFn/ahUpUa1dv3KCvlx09J3HPPTYODova/RraZ0woAhLtOuJEXZivkO3YCiaRiwS9CG
	 p5AAYeKwIJ1STIo3MObismv96bowWnWdqqnoCCk+ZsllMOBaMn9cKTX8jd7dprFhy0agB
	 A4PcVnliF7x0ZpwANxgceJxRaqYYKY1qP5Eb41WaUBMxiOEeC+eGITeK+EHmSLVzCm0tQ
	 DqhFDALtS3QU8fC2TOwEuK/IDxYXF+hwuA/nIt2ERyUmSaLFUyzrpOWSI6AW+EevH6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=lycISWbw;
	arc=none smtp.remote-ip=115.124.28.122
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16726606A324;
	Tue,  3 Nov 2026 14:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16726606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=lycISWbw
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793716175; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=n/GZUP2ZsjOuhhEd/klWEvvXLu7voLybiNnp082YBt8=;
	b=lycISWbw5HzTTpeAPheAB7FhQf0XGx9b+yFlGISP2Y46AoBMnFJ8sHgJ2fP+s6b2ufndj9SFDFWfDCeqUCiv+yufbWudAImvL0C/RA770TBSUO0gd2QttzkZ7wjLHWLrW61pcs4bplaJdbwuuu5Yh1gmpn4xzBgYNkrGdEtEAgQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1085895|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0253143-0.00086085-0.973825;FP=3442595331818532187|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034138;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jvr1CsY_1793716173;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jvr1CsY_1793716173 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 22:29:34 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] vhost/vringh: reject zero-length indirect descriptor tables
Date: Tue,  3 Nov 2026 22:29:32 +0800
Message-ID: <20261103142932.65745-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261103055650-mutt-send-email-mst@kernel.org>
References: <20261103055650-mutt-send-email-mst@kernel.org>
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

Thanks. I checked the applied v2 (60a792b97933) in your
vhost branch and it looks good.

One small thing on top of it: vringh_bad() there still
passes the raw desc->len, so the reported length reads
wrong when the vring byte order differs from the CPU
byte order. The October 21 posting had this right; the
rest is fine as is.

Happy to send a one-line follow-up on top of your branch
if you want it; otherwise fine to leave as is.

Thanks,
Fang

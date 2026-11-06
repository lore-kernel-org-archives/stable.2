Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962486;
	b=yCWem9AI8siNXEue3G8u+Lv7RLhEvUSux0At9Du9GH0+ta9paWCgIwfQR0aG4uhIOA7v
	 5XctAfFjC3P4xW3SYkq+tSkYSPizb9TML45yqCq38Fv1F2mVsBwL2UZR+1O/msM3YIQjb
	 SZpbZChdJVO5v9mfOcAOyIELqcTYqcaPI44vBNjiH9nIrkiqV8YkpuAod1tr/FkptgS2O
	 H/w27gzyWunINAOJtvuO5I7OqCYbKX/6HKUaF3CliXorQghfpMYpfstVwAftpwUUQMWTH
	 9TcoT2Id+pCsVeEsqk1jP8SYDi6hmClOKj1rLtMS1T9D/xdAOpL4+aL/uLwdkG4xhdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962486;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=zpHxO48Hcdkozl39mid44eEhHNKjhkzsWRO8v03EMDc=;
	b=xlaWZvaiaxgCLHFgOc8KTGtpR9hz/FcN+J2PHTbbcHtOn5rBkVckz81LJVxlQLO4SDnl
	 CRxynjSZ2gZxxYKHWrMA6e1LgjOix/nXinYNyygGNv4n5B8EHglyMyq0clbE6W+m0PMj/
	 lkSXuHWyYwsa80F6W3HqR1QvXw+8Ow8rI1Bsjt1jLkOVfrr30m+ZNbHKh77Z6itpwiQZF
	 YvQkbm9ROU0+WCIMxSIkBg6LKF+YFQg+ZnKQOR4Rc3qconDpAXcMyhWRvLXUdlmKHkrRi
	 DJ9hljL8axa4turee3i7ICGhY42uJizRvwvpBU6iBCqgcBu4OFOHHPO/eME0+ckhtIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C73606D83F;
	Fri,  6 Nov 2026 10:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18C73606D83F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLbfV65GDz8XrrJ;
	Fri, 06 Nov 2026 18:54:42 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6A6AsYqd091181;
	Fri, 6 Nov 2026 18:54:34 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 6 Nov 2026 18:54:37 +0800 (CST)
X-Zmail-TransId: 2afa6aedb1edc44-66d0a
X-Mailer: Zmail v1.0
Message-ID: <20261106185437698kfychwPHz53w2DA9qZCRr@zte.com.cn>
In-Reply-To: <20261106104012.GB5633@lst.de>
References: 20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn,20261105215800734URR7v0vyg8xZ8t5d0qzIb@zte.com.cn,20261106104012.GB5633@lst.de
Date: Fri, 6 Nov 2026 18:54:37 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIG52bWV0OiB6bnM6IHJldHVybiB0aGUgbmFtZXNwYWNlIGxvb2t1cCBlcnJvciBmb3IgSWRlbnRpZnk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A6AsYqd091181
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 06 Nov 2026 18:54:42 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDB1F2.001/4jLbfV65GDz8XrrJ

On Fri, Nov 06, 2026 at 11:40:12AM +0100, Christoph Hellwig wrote:
> The fix looks good, but please write to the point commit logs instead
> of detective novels.

Fair.  v2 keeps the code unchanged and rewrites the commit message to two
short paragraphs: the done label overwrites the lookup error, and the
fix returns it.

v2 follows.

Thanks,
Shao

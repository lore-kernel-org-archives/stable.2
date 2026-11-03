Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732849;
	b=x55uFfsUJMDPjdDp3UBx5YDtugNUrcV12lQvVr0XNFzNBy2habSCynuUKO12k2Wpqimz
	 nO1GbDn/RJ4qLd7DcFQquA3qmJSyW8mREsWlwkT9wS0mJj0p1Sma+9U3X+p2BrI9GRhV8
	 MA9qvF791Zx6ID+aJB/K/Evi0UXikAEjYxFlYKLL3SDQI3dSucDYrSbufVRIR1Zx0bbSh
	 dfQ5+OJWvjW0JpVZftME3TQ7T7ZmoDTtLm9F+kWwh5zrZdLVshRqgMj4QHzwJOSfypWyu
	 cFcBteXVlVHPd9paHrOpfoWdeZtWqwBFp/6+tAJxpOYzp+kRWuxstr9SpJpeVMJYD9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732849;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=hy2HpfDzx0MMaiYvTIIcjQt++tjiJ+pJBZshdZSr9VU=;
	b=M9Ol0rWLSwgtwrfm/rsc+qvGWvLWWQ0l4e26yUR6geSIWXxY0UXrnxz905amldEWkKqq
	 yGdf7ahL9z7B7KOZ8foVCcrk9OtuFFfdv43fqgmiT/8ZumjF0LFzQq3Nu8E378vstc5k4
	 hvKt/wdi2/08KQ+ZJkAYNiPBAgcIffvA5jdcABPdoiXVC+vAXxprMyprNS+9Pe44oPpcg
	 mTgEjmbYwaEtxKtQkuVqldZQK/5WEw2dsT4EG2DAtrD1wM3VjMw1n5W9RGztIplQTnm/U
	 d/DuhCGxYZIrRwTajJy2xRQXZizLp02nE2mfQy4O7PVNrUhztYuiEx4o93PpkC4c7KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93804606D80C;
	Tue,  3 Nov 2026 19:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93804606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJykQ6y3Dz8XrrJ;
	Wed, 04 Nov 2026 03:07:26 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A3J7HnM024262;
	Wed, 4 Nov 2026 03:07:17 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 03:07:20 +0800 (CST)
X-Zmail-TransId: 2af96aea30e8420-d6962
X-Mailer: Zmail v1.0
Message-ID: <20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn>
Date: Wed, 4 Nov 2026 03:07:20 +0800 (CST)
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
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvMl0gbnZtZXQ6IGZpeCBjb25maWdmcyBhdHRyaWJ1dGUgdmFsaWRhdGlvbg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A3J7HnM024262
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 03:07:26 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEA30EE.002/4jJykQ6y3Dz8XrrJ

This series fixes two independent configfs attribute bugs in nvmet.

Patch 1 fixes a use-after-free when attr_tbkas is written while a
controller is going away.  The store callback walked subsys->ctrls under
nvmet_config_sem only, while the list is protected by subsys->lock and
nvmet_ctrl_free() does not take nvmet_config_sem.  Take subsys->lock for
the walk, as the qid_max store callback already does.

Patch 2 fixes an off-by-one write in the traddr and trsvcid store
callbacks.  A write of exactly NVMF_TRADDR_SIZE or NVMF_TRSVCID_SIZE
characters was accepted, and the following sscanf("%s") had no field
width, so it wrote the value plus the trailing NUL one byte past the
destination array.  Bound the scans to the array size.

Both patches are independent and can be applied in any order.  Both
carry Fixes: and Cc: stable.

Testing: both apply to next-20261030, pass checkpatch.pl --strict with
0 errors/0 warnings/0 checks, and drivers/nvme/target/configfs.c builds
with CONFIG_NVME_TARGET=m and W=1 without new warnings.

Patch 1 was reproduced with a KASAN kernel: hammering attr_tbkas while
loop controllers were continuously connected and deleted crashed the
unpatched kernel with a general protection fault in
nvmet_subsys_attr_tbkas_store() (KASAN wild-memory-access at a poisoned
list pointer).  With the patch the same 60-second stress, about 39k
iterations of the store, completed without any report.

Patch 2 was also reproduced and re-tested in QEMU (7.3.0-next-20261030):
a 256-character addr_traddr write cleared tsas.rdma.qptype (addr_tsas
went from "connected" to empty) before the fix, and is truncated to 255
characters with TSAS intact after it.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322997;
	b=yVRU336iDsB5Gi0sJvvGGUA0IS8Zg6bPPuyIARl4juGPw6gXRYgRi1wqcxFJ/HX94TdS
	 BCFH5JITCnuqxzWYzZefLnD/5AklLr8Qc0gI/bCSrCfZwF6DSGSxQ6UNq68yNryypUXRE
	 e/vHXWXM+VqpxfGKABLaD5VZs/cUJjJ4IaCkO8dDQLEHt0eJ+MDr3tVHSbHWrUY8nGule
	 dY92s9LMZmLR3eeGjFtoRzXa+DJVNmyjFmRHv1UkbHUrjeQJWwh1kgGO8t6xYYjvhDAD/
	 XF2ghgVoJgD+ABJDrBrd3mJebrDjt3Qi05qzh/dptcD2c5JDeXMq6V2TJvQiv8KRtrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322997;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=F0CMn0G18tWa/Iz5/6L3Q85B7oHt15XFmTZTtpw7n8Q=;
	b=wuDJywis1EsxoCjXlhpi+kE2tPKPjf1TFBK3nHSAIFdzggKf/rUwvv8jftYCT6R6GDIx
	 SXxhD8wz1GgnHmkG+zBhEyivRWZFfftrzRoh62Vr0+3A9Q3WRBCXNLt36hMfw6eEDVbUJ
	 RSGPBzsKXNOFGD0g3H4zppZJBl1jM/JTaOunM0sLu1D+BM5YJB15lmPvhx4PD9WJ3ZBXw
	 zq2R8jXEyNYsWBRSzlKelBmtPKVW0iNbTtrdLuLCUwdwf77iOnLGh9JWAVY5s8Cu8mqID
	 jYBIH5Fu3kIOn/5f7G8PojUtFK23N+t5G4a26qKmkfYcyQ1a51nH307l7DLz8XlH/iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="Z8kdV5w/";
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4604A606A336;
	Tue, 10 Nov 2026 15:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4604A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Z8kdV5w/
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP8zJ5lM4z6FK1f;
	Tue, 10 Nov 2026 23:03:08 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794322988;
	bh=7X663BhplGetURYCfC415YTYFX63LQtL9sJ7Cgul2HU=;
	h=Date:From:To:Cc:Subject;
	b=Z8kdV5w/6bExDk7KHO4RMqUob0T2F56lmdrJv1yHH78vYH6bBmpepHXcC7xIeB/ao
	 A4o57fq2obescz2XaI9UVcsyPGNZkc1M6naxzsLEveF1G+b0LZwXv5ZnEk5b4VYkmd
	 0ViQZrPAZikSXJUHFWbzwQcyW1OlXXy9j+BmxSXc1LAXX722R6fIh3WFnOvDVl5Ypv
	 DQlsMFZ9AE/oZxd9bJuzEYSMLx+24zmshKKF8QXS6QK6WgCVNhAVpkHXkXfqdf5FKH
	 gaaOD0jBGq1GLjnyWcBCWk/Bqj7weFtxFda6W+fHRBDOfNRGlnobnfR5ILFwdbUf7l
	 wjvbg0xaHhrYA==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AAF30um030610;
	Tue, 10 Nov 2026 23:03:00 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:04 +0800 (CST)
X-Zmail-TransId: 2afc6af33228054-01698
X-Mailer: Zmail v1.0
Message-ID: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn>
Date: Tue, 10 Nov 2026 23:03:04 +0800 (CST)
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
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvNl0gbnZtZTogZml4IHRyYW5zcG9ydCByZXF1ZXN0IGFuZCBxdWV1ZSBlcnJvciBoYW5kbGluZw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AAF30um030610
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 23:03:08 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF3322C.000/4jP8zJ5lM4z6FK1f

The six patches fix independent error paths in the NVMe transports.

Patch 1 releases the target request in nvme-loop when SG setup fails.
nvmet_req_init() has already taken the queue, namespace and reservation
references, and blk-mq retries the same request, so each failure leaked a
set of references.

Patch 2 makes the TCP target wait for in-capsule data only when the SGL
is really an offset data block descriptor.  The old check looked only at
the descriptor length, so a transport SGL of the same length was treated
as in-capsule data; the same check is used when request initialization
fails.

Patch 3 requires the R2T offset to equal the number of bytes already
sent.  A larger offset let the host advertise an offset past the data
that its next H2CData PDU carried.

Patch 4 frees the fcloop LS request when nvmet_fc_rcv_ls_req() fails
before taking ownership.

Patch 5 publishes an FC target queue only if its slot is still free.  A
duplicate Create Connection replaced the old pointer and leaked the queue
and its controller reference.

Patch 6 rolls back the SQ binding and the controller reference taken by
nvmet_install_queue() when the CQ is already bound to another controller,
and destroys the CQ binding when the transport cannot install the queue.

The six patches are independent and can be applied in any order or as a
subset.  All carry Fixes: and Cc: stable.

Shao Mingyin (6):
  nvme-loop: release the target request when SG setup fails
  nvmet-tcp: only wait for in-capsule data for inline SGLs
  nvme-tcp: require the R2T offset to match the data sent
  nvmet-fcloop: free the LS request when delivery fails
  nvmet-fc: reject duplicate queue IDs on Create Connection
  nvmet: roll back queue bindings on connection failure

 drivers/nvme/host/tcp.c           |  2 +-
 drivers/nvme/target/fabrics-cmd.c |  3 +++
 drivers/nvme/target/fc.c          | 13 +++++++++++--
 drivers/nvme/target/fcloop.c      |  2 ++
 drivers/nvme/target/loop.c        |  1 +
 drivers/nvme/target/tcp.c         | 35 ++++++++++++++++++++++-------------
 6 files changed, 40 insertions(+), 16 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592975;
	b=H9K7Cfx49idg4ntChjmy/3MUmd4CtctqWy38eRNiLvP+3YPL1quDx15b5lWzWuqRuUMe
	 BQMnaa4vcKE5PSsOZ7f/uIqZnrMYHjvblHuknVYFo7bd+GuiSK8/OgAJWuBA7Flt3ebJx
	 fvN1Tw8x8y9hiZq+cbL/8DytCwRwsWftGqlj3xZWa3K7Y0VT+2v7YCimtLmfvvkKZKDa0
	 NQPy9QRjZyjoRQJ0vrAp3JkYCG+VWLp8fLMI9GiKPp6KI91NNtTR6I4OKa3chew/net9d
	 aiPMwLPv1mLDgkYNK8ykWGqqo5NNNsW4OnOnq88DAW3ObPuYq9JtXdjmxCqyXccaq0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=ANh5UK6noVZGLD9w5kx/R7lFUKUoFzVmCcNxyJmNIX0=;
	b=t2Bpeasjit6dzPrPcWuB3BrCOi8057blqGdrCyL5wkJ8JtlHwHvndOAcR9RFqyOyfMne
	 YQ435UzdwmdcQ39dkAFMp/j+4JUHjYXffEcF12rwG1JCo7bWKEOWsN1p9GyTXt4ykeCTY
	 0BgdrwIRW843BnzLXOkZJFKMMkROjqTQ9yAzlq7D3kD+GIdnu4lDPOalIa9fN2nOiDAuz
	 gFMaWjJBoihCv3abaI10yBZdpdlth1sT01cddtgYy0CxYkvO9bqoy1BgD5sSUcGrelDfi
	 jtzc1w2Y9yCWu4+S+ZudnfUXInzrlbjPlX411dC7ivZJpozZqZ9IwE1zU6mOZkd2IWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=0oLsZefA;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC5606A337;
	Fri, 13 Nov 2026 18:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55BC5606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=0oLsZefA
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4qJ2b4Jz8XrrJ;
	Sat, 14 Nov 2026 02:02:52 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592972;
	bh=/mmJp2/7ZvLGi0H7DjG+tOzdug32dAenCcTvKKU0me8=;
	h=Date:From:To:Cc:Subject;
	b=0oLsZefAeUDYxoQY6cF4i9jH/jQZfmI529malpsK33S9T76uU1z5tQweJTjvaeDI6
	 esKV1+XlR6b7vOX/v9PV7Wnu/1N1KU2sMK1UbDZAfJS0zBt6tVTliQVkcqeLg67H5k
	 7v6voQ0Tb/5H0igxcCmcV9HYJoIc4kSFb2Em6eJb68lko+vC1Wg/+HBljSeVfgMbbn
	 B6SITDwXMze+IqDrCnlbGkxzTTAl5QxsieEabrHiGrkk5FqgKGIg/mTJehxyb7Vong
	 9ODykUWB+Iy2qf7+7LBQEOzp6v/2kP3FsgvNNmcr7sEmfBixy+q25JFwg8/zgkUMv4
	 xK1LlrWCQNgIw==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6ADI2hYc073469;
	Sat, 14 Nov 2026 02:02:43 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:02:45 +0800 (CST)
X-Zmail-TransId: 2afc6af750c5e97-1bdd7
X-Mailer: Zmail v1.0
Message-ID: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
Date: Sat, 14 Nov 2026 02:02:45 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvNl0gbnZtZTogZml4IHRyYW5zcG9ydCByZXF1ZXN0IGFuZCBxdWV1ZSBlcnJvciBoYW5kbGluZw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ADI2hYc073469
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 14 Nov 2026 02:02:52 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750CC.001/4jR4qJ2b4Jz8XrrJ

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

Changes in v2:
- Patch 2: split the inline-SGL helper into separate conditions, as
  requested by Christoph Hellwig. No functional change; a compiled
  comparison of the old and new helpers found no mismatches.
- Patches 1 and 3-6: code and commit messages unchanged; add Christoph
  Hellwig's Reviewed-by tags. Existing runtime evidence remains v1 data.
Previous version: https://lore.kernel.org/all/20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn/

Codex assisted with the review changes, descriptions and validation
scripts. The updated code was function-tested and build-tested.

Shao Mingyin (6):
  nvme-loop: release the target request when SG setup fails
  nvmet-tcp: only wait for in-capsule data for inline SGLs
  nvme-tcp: require the R2T offset to match the data sent
  nvmet-fcloop: free the LS request when delivery fails
  nvmet-fc: reject duplicate queue IDs on Create Connection
  nvmet: roll back queue bindings on connection failure

 drivers/nvme/host/tcp.c           |  2 +-
 drivers/nvme/target/fabrics-cmd.c |  3 +++
 drivers/nvme/target/fc.c          | 13 ++++++++++--
 drivers/nvme/target/fcloop.c      |  2 ++
 drivers/nvme/target/loop.c        |  1 +
 drivers/nvme/target/tcp.c         | 42 +++++++++++++++++++++++++++------------
 6 files changed, 47 insertions(+), 16 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732840;
	b=qp0ecpRmuFAILot6/iGjdEzpdxrV3vaBKKkIWMBx1s9/y8T0vKJR5hxyp4S1z+mboxOy
	 HUJMegbMjL+R8J28sSVjmO2QnrjU95+eYJJsCQBD/52mfXfXP0BpDjY4Dq4FXMfmSXXEO
	 AO1RUbI8v7o4fVd6d+9FEBtYa2J4Wbu77b9lhtC48PNqQZq8BtH/AYrBrzFVkGdvI6h+5
	 +2+eeqbM0Ln6fJA4TvkmojDqator+rgpE8aneBkU7RxrOgTUaYRCNUniMbjIeCXJjuSEY
	 R2Fo+eQ4nnlxrm7yHxSYg7VJh2M51jHpSp5Nlmq5LL/n++MtcbPZ0xNq+8b7rTO9bbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732840;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=YKxG32AxsufUd7YchK7727X8TY3T1MC6mpG7My++UTg=;
	b=Nkumtrs4y0ClaxaDbSc9UydUSDuYLr/m1LShrhkdeNerTX9NNZuOwpnS6NUg3UXln/VZ
	 q/5d50XTk0FhwE0pb9WFIkaz3JnAsUYSTSKmg+Iqj9EVWiissa+I1xgGznL2sjNSwz+WN
	 mGrGk/hMRKwjfSK68MBCq9IB305p/f+LppjdVFyoZIPyjrI8UnbkR1tvecy0Zwio17+n7
	 LBvWchtLyFDrTsohdnZu2aTSLrSRRYMDFJLBBdpUNI2F7Xc2D3PfyD6LltDsDWGKiU41M
	 JHSOsV0D/R7lt+/7zsNwtxO1FdZLZBV5nr5LZ0/SRDnJHfMpmXa7eQT9seyei+Mkkjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69078606A326;
	Tue,  3 Nov 2026 19:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69078606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJykF5hzRz8Xrr9;
	Wed, 04 Nov 2026 03:07:17 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6A3J73md084144;
	Wed, 4 Nov 2026 03:07:03 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 03:07:07 +0800 (CST)
X-Zmail-TransId: 2afc6aea30db9b5-d1efc
X-Mailer: Zmail v1.0
Message-ID: <20261104030707567QiZNPqBVEESVbvpNukFkY@zte.com.cn>
Date: Wed, 4 Nov 2026 03:07:07 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDAvMl0gbnZtZXQ6IHBjaS1lcGY6IGZpeCBhIGNvbmZpZ2ZzIG92ZXJmbG93IGFuZCBhIGZhaWxlZC1yZWFkIGhhbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A3J73md084144
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Nov 2026 03:07:17 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEA30E5.000/4jJykF5hzRz8Xrr9

This series fixes two independent bugs in the NVMe PCI endpoint function
target driver.

Patch 1 fixes a heap overflow in the subsysnqn configfs attribute.  The
store callback passed the length of the configfs write buffer to
strscpy() as the destination size; an NQN longer than NVMF_NQN_SIZE
therefore wrote past subsysnqn into the following fields of the
nvmet_pci_epf object.

Patch 2 fixes a hang on failed read commands.  queue_response() completed
a command with a non-zero status directly, without waking
exec_iod_work(), which is waiting for the transfer of a DMA_TO_DEVICE
command.  The completion queue work could then free the iod while the
work item was still waiting on iod->done.  The work item now waits based
only on the data direction and length, and completes the command after
the wait even when it failed.  This is a follow-up to the recent fix for
the use-after-free in the same function (c9e9bb757971), which moved the
wait decision earlier but left the failed-command case from
746d0ac5a07d in place.

The two patches are independent, have no inter-patch dependencies and can
be applied in any order or as a subset.  Both carry Fixes: and
Cc: stable.

Testing: both apply to next-20261030, pass checkpatch.pl --strict with
0 errors/0 warnings/0 checks, and drivers/nvme/target/pci-epf.c builds
with CONFIG_NVME_TARGET_PCI_EPF=m and W=1 without new warnings.

Patch 1 was also reproduced and re-tested in QEMU (7.3.0-next-20261030,
configfs pci_ep framework, no endpoint controller needed): writing a
230-byte value through the subsysnqn attribute stored it and clobbered
mdts_kb (512 -> 4276545) before the fix, and is rejected with -EINVAL
after it.  Patch 2 was not runtime-tested: this setup has no PCI
endpoint controller.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c

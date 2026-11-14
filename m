Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677277;
	b=Rzjy92vIMSiZHMtX6PJ9AMNJ21hj2G7LX2smBpC6mM+5uqD8csH0QI4ri5isCedtNNyC
	 +IXOUi6/RLmBOdUrqu9UMkLOF4xmPQBZVAedGapsueUBsRRrMyINy1XQBNivk+8nvBn7h
	 KSRSuWgepJUgWEwUqd3AMGoy9Feg4648uBwFrOc92uQdWSHm4KVTv9IaBHe4bdwfnxz4l
	 nFVm1f92kINgYMx3CRmezgTHszIaaShbWqeDmtPJJrz6P5FxPikRynJyh0oTVe698/iTY
	 z/+2UwDbDXebfFSf7NXY2Jio/FTIe4cGRw6NYaT3go6aQeBL63khcUR/OcYh1kFWDLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677277;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=eV5gvD8g6rP63zZKtoi/003rCWCBtrbvCHoBYlTmejE=;
	b=XppDqtLUwPvVO+XD8i8M6JF/8qV26uTqPmoZ5XzWEDswTB4KSZQPRRIG57UZFO6Yngt5
	 v0RqCLkM9w9BcxnjlZh78vLJFX6ecP6X36+nPNfz3CJl4h4CqkDoGT7dJ35VLtOYNKQeR
	 U0ZwNdTOpwGzb6dDmpJs3SlhmlUMzP3qwQnyxARehj0wI164pgV2i2IDg1TaqG6kir9sg
	 NRjAjAO/A1O2kdiZazym1CK/LYZRhqEEu41bN1u97EfqzRs7RDqUzbmAT9GUKRx2OeGD1
	 IUOIz3ORkwZhCFTfCLVDa2hB6OzDYsBml++twFV5AJEDvpx/Ly1xsbvmDP5upCoHp2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=fjY6u7l3;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8A606A327;
	Sat, 14 Nov 2026 17:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72A8A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=fjY6u7l3
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRh0V0fS7z5BNRx;
	Sun, 15 Nov 2026 01:27:54 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677274;
	bh=3egreJUevVK+tZ7LxFQa1g7uHV/m0ZzjKpKiKJVETok=;
	h=Date:From:To:Cc:Subject;
	b=fjY6u7l3VyaRkw2WjylKDLfTvi5evyTig9RZ08g5XXBKVqhHYVGkpWyGpHVxmvJiX
	 WQ9HJZGZB7NS3qZGV478zaRJiTGpfMaF1vc7E0UUFRHgtfZembXZBe9Q2ME3WxsQQx
	 SGWSR+U/buDmwwb8ZU9MUa/ic0PLxQet8QzWtt31YEgJRvVYMLr8r72/LbcWXx4Fep
	 mx3bjj0mAaf/6UrMkPMeAIAYaCWAu7ROWvLmGrKv4A+vciVbKhJZNiNi6cH8Cvh+PM
	 j3DYE8En5DYbKFTYthtRk7CK41nqS6BPotbQhXLIq8tJt6EulG+S+VOk7EeEmDydod
	 WqMAjdSpvcI2g==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AEHRmi0016753;
	Sun, 15 Nov 2026 01:27:48 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:27:51 +0800 (CST)
X-Zmail-TransId: 2af96af89a17ee7-57e90
X-Mailer: Zmail v1.0
Message-ID: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
Date: Sun, 15 Nov 2026 01:27:51 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDAvNV0gbnZtZTogdmFsaWRhdGUgYW5kIGRlY29kZSBjb250cm9sbGVyIHN1cHBsaWVkIHZhbHVlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AEHRmi0016753
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 01:27:54 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A1A.000/4jRh0V0fS7z5BNRx

This series adds missing validation and endian decoding for values that
come from a controller, a backing controller or a user request.

Patch 1 rejects an invalid ZASL from the controller.  nvme_set_max_append()
shifts 1 by zasl + 3; a value of 29 or more shifts a 32-bit value by 32 or
more, and the old code also used a signed int for the shift.

Patch 2 maps the user data buffer whenever the ioctl length is non-zero,
not only when the user address is non-zero.  With addr 0 and a non-zero
length the command was submitted without a data buffer, and the target
rejected it with an invalid SGL status instead of the host rejecting the
user buffer.

Patch 3 rejects an Identify Namespace from a passthrough backing
controller whose nlbaf does not fit the 64-entry LBA format table.  The
old loop cleared fields past the table and returned an inconsistent
Identify structure.

Patch 4 decodes the FDP Get Features result as the little-endian dword
the controller returns, instead of passing a four-byte structure to the
u32 result pointer and reading it in host byte order.

Patch 5 bounds the reservation report retry loop.  A target that keeps
changing the registrant count made the ioctl loop forever, allocating a
full status buffer on every iteration.

The five patches are independent and can be applied in any order.  All
carry Fixes: and Cc: stable.

Testing: all apply to next-20261105, pass checkpatch.pl --strict with
0 errors/0 warnings/0 checks, and zns.c, ioctl.c, passthru.c, core.c
and pr.c build with the corresponding options under W=1.  Each patch's
--- notes describe its QEMU/TCG A/B test with a test-only target hook;
no hardware was used.

Shao Mingyin (5):
  nvme: zns: reject an out-of-range zone append size limit
  nvme: map passthrough data when the length is nonzero
  nvmet: validate the LBA format count of a passthrough namespace
  nvme: decode the FDP Get Features result as a dword
  nvme: bound the reservation report retry loop

 drivers/nvme/host/core.c       |  6 +++---
 drivers/nvme/host/ioctl.c      |  2 +-
 drivers/nvme/host/pr.c         |  4 +++-
 drivers/nvme/host/zns.c        | 11 ++++++++---
 drivers/nvme/target/passthru.c |  5 +++++
 5 files changed, 20 insertions(+), 8 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b

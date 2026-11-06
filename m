Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977221;
	b=vrZBFPHDBCYO9hVwmZu2ckjt2V6QTEUEqOwsHY1WUf3V0wmb9s513nNxBy3PS9BK+rlc
	 vOoAauk7yOcfPGTKsI9tURN8GI3DJ9ZQMAN1M+Q/20LtXuxa9av/bg8TJ+gaZnFHOTdTV
	 UaYwpdkG73y6L0WnkGC2IQXp2BlRR/G6P0dm1+zE5tXyKPzt4GWbubC6rXwSoMoQk+WMp
	 Aa8m9AE/h2ot3hLXSYs7yrFugEyJZPTruEd+OjoP5/Y/c2AJ9vHsDXrpBbe05HhydzO87
	 yWKwQYV6YOQ6NdgK/en8avdzgr7e313eETOPjSfUVLdp+9lTwMe8Hm+a56b497Om72A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977221;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=eN6LWnipXuoEexdXCVhAwlc1F+53Q7OMUS9FkrpAFjA=;
	b=soNkCTeFw3IkI9W0KRW3n9tNfNi6unRtfhejHBxWnC1kOMBIIa4rhacchWSwKzbaVr3H
	 5cguRhMfPRuqgKX3nhYKBDMGQg65klS8C9KZ89B9HOQCwVR1b++qKFbMDsg6UQFXNN39Q
	 rqf85vR2AB0OqTwmBfLmWB6Ke6Di466UNcwfy0PINHE5kS3iX7lNXDfK5vBhEQFx4pQ5g
	 86TNFElK/mHewh01nuhAzJqIEkJygHhlkipFuCDdPO29ETdbixZLuyUllC5uyPapKQiq+
	 Hl/5PGuUOKXZ6ryFHW0kOFZ0RLIBk4HrZDOjZcY3gTiYfMbk4C7QT2wdAM06zb29uhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E72606A32C;
	Fri,  6 Nov 2026 15:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6E72606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jLj5k6Pkgz52Rpb;
	Fri, 06 Nov 2026 23:00:10 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A6F0Anw036321;
	Fri, 6 Nov 2026 23:00:10 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 6 Nov 2026 23:00:13 +0800 (CST)
X-Zmail-TransId: 2afa6aedeb7dd90-76d47
X-Mailer: Zmail v1.0
Message-ID: <20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn>
Date: Fri, 6 Nov 2026 23:00:13 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvMl0gbnZtZXQ6IGZpeCBzdGFsZSBsb2cgcGFnZSBkYXRhIGFuZCBhIFpOUyBJZGVudGlmeSBlcnJvcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A6F0Anw036321
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 06 Nov 2026 23:00:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDEB7A.002/4jLj5k6Pkgz52Rpb

This is v2 of the two-patch series.  Patch 1 now follows Christoph's
suggestion to zero the whole transfer buffer instead of only the unused
tail, and both commit messages are shorter.

Patch 1 zeroes the entire Get Log Page transfer buffer before filling
it, so a host that requests more bytes than the fixed structure no
longer receives stale kernel memory.  The Error log also clamps its
ring walk to the requested length instead of relying on a zeroed tail.
Patch 2 returns the namespace lookup error for a ZNS Identify on a
missing namespace instead of overwriting it with a successful copy.

The two patches are independent and can be applied in any order.  Both
carry Fixes: and Cc: stable.

Changes in v2:
 - 1/2: zero the whole transfer length first instead of only the unused
   tail, as suggested by Christoph.
 - 1/2: shorten the commit message.
 - 2/2: shorten the commit message; no code change.

Link: https://lore.kernel.org/all/20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn/

Testing: the uninitialized tail was made visible with page_poison=1
(CONFIG_PAGE_POISONING).  On the unpatched kernel a 4096-byte Supported
Log Pages request returned 0xaa in bytes 1024..4095 (10/10); with patch 1
the tail is zero (0/10).  The other log-page changes and the error-log
ring clamp are not runtime-tested.  Patch 2 is unchanged from v1, where
Identify CNS 05h/CSI 02h for a missing NSID returned Invalid Namespace
after the fix.

Shao Mingyin (2):
  nvmet: zero the entire Get Log Page transfer buffer
  nvmet: zns: return the namespace lookup error for Identify

 drivers/nvme/target/admin-cmd.c | 51 ++++++++++++++++++++++++++++++++---------
 drivers/nvme/target/pr.c        |  6 +++++
 drivers/nvme/target/zns.c       |  3 +--
 3 files changed, 47 insertions(+), 13 deletions(-)

---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c

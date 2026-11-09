Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236365;
	b=PYzSoz/ZOrlRHER4P8EVHy9YRhfQidqb4l49JKOH0P3biNitu+NOrwsB1icp5EFDCCJs
	 GyPiWF4JEjceQK7oJxTXv0LoZH5cl4XG999q2wBIPqQ5UYh6B0NHmcBWIrEhUT9XbztqY
	 DXDx5IhwaKvTvmzcQhrq9sg87C59buU9vO0sKEHCOZVsTZlIxrWFfkmiN3Pb92LvSBO8r
	 Ak5+O3C//jEn+2iVl5nzEqQcdiYW1z8TwHxXLvm9QYECB1fOEkXjs/dd4YJBXWfNP/Mpj
	 KQTMidL1mkEq2awvxsykNBTKjn5NKusc0JMkV3K+DrpfRgNXhLhRb5U79+OnnKEEKJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236365;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=/uGlgNaTZ39GNEO0DIFkGDDlYQv31NwdqtqlJEOxmcM=;
	b=1cFzfNSc5IFO99YJdFFaf1hBOsHhS+/R3sxG3JV6EcGN7bkIUmYWECEAWisNppsGKQ1R
	 nLrNscY5eoNAlo2waOiKgUe5OgQ+S+KuxEt2AWX1mGGOHYg9/D4pnAguTrakxsGl8ewUw
	 Zk+G2yV8VNk/6tpDq1dRng2HqyWXw59twmtxfaHlf6htonLdSG1Z6e/88lIc+2fn5pjIa
	 ii0gACFXBriiMx9vrOgryEnOgQRbJeSemdIVshvK7izMq3DqwRtKWaDN1hL8JYqO/hcTX
	 8ob4B3fuZ5kWfTQ8kpZ0ywdxL054YSv0m+hc9vSsdncS9kqHSkJ3G5t1xoJV/DjYT4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="mlp/MgZL";
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378B606EE96;
	Mon,  9 Nov 2026 14:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D378B606EE96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=mlp/MgZL
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jNXxR0phdz8Xrnt;
	Mon, 09 Nov 2026 22:59:23 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794236363;
	bh=TpIfpB47CwmdgGId7W2SupsJewo/qXQ10cq1sQ2P0/w=;
	h=Date:From:To:Cc:Subject;
	b=mlp/MgZLj/qKsvH/znv5+c7+5DM/vL4lrryDnmZRuIB1CP2pTyKnwCC4DnLgkWl8u
	 Gh7LoEX0owZ2ajvyDTvogqdttok2Dk8RGB2A7kN9mZUeOdL6rim0m/xhZ+JeEXOUN+
	 EOZb3vWCQqepXVbWm3IpTn9SkYN+3ZhexE8tuXlm1T/f8MZYuWq7LFOpxG6EE+7azQ
	 AvunWP5upJqO+ZBkR2hjWiLL3i4aOXZKyZj2yNCHvSyVHQTOzZvQEIyT66bLyssxF2
	 WtxiRt2w/l+EEH/rQMdslzlF1BaR6ondORd55anuHREG10z/JHk1lBqSftf9mkIiZI
	 48OBYWi8Q8tfA==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A9ExCXn067527;
	Mon, 9 Nov 2026 22:59:12 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 9 Nov 2026 22:59:14 +0800 (CST)
X-Zmail-TransId: 2af96af1dfc28e3-656bc
X-Mailer: Zmail v1.0
Message-ID: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn>
Date: Mon, 9 Nov 2026 22:59:14 +0800 (CST)
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
Cc: <hare@suse.de>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvMl0gbnZtZTogdXNlIHRoZSBwYXJzZWQgb2Zmc2V0IGZvciBESC1DSEFQIHNlY3JldHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A9ExCXn067527
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 09 Nov 2026 22:59:23 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF1DFCB.000/4jNXxR0phdz8Xrnt

Both the host and the target parse a DH-HMAC-CHAP secret with
sscanf("DHHC-1:%hhd:...") and then skip a hardcoded ten characters to
reach the key.  The prefix is only nine characters when the hash
identifier is one digit, so a short but accepted secret makes the key
pointer point past the end of the string and the follow-up strlen() read
past the allocation.

Patch 1 changes the host-side parser to record the offset of the key with
%n and use it instead of the constant.

Patch 2 makes the same change on the target side and stores the offset
with each configured secret, so nvmet_setup_auth() no longer adds the
constant to the stored string.

The two patches touch different trees (common/host and target) and are
independent.  Both carry Fixes: and Cc: stable.

Testing: both apply to next-20261105 (`ddfe51b0a0f5`), pass checkpatch.pl
--strict with 0 errors/0 warnings/0 checks, and the affected files build
under W=1.

Both were also reproduced on a KASAN kernel (7.3.0-next-20261030,
CONFIG_NVME_HOST_AUTH/TARGET_AUTH): a 9-byte "DHHC-1:1:" secret written
through the host sysfs attribute, and a target host entry configured with
the same key, both made nvme_auth_extract_key() read one byte past the
10-byte allocation (KASAN slab-out-of-bounds in strlen/strrchr). With the
two patches the same boots produce no KASAN report.

Shao Mingyin (2):
  nvme-auth: use the parsed offset for the DH-CHAP key
  nvmet-auth: store the DH-CHAP key offset instead of hardcoding it

 drivers/nvme/common/auth.c  |  6 ++++--
 drivers/nvme/target/auth.c  | 17 ++++++++++++-----
 drivers/nvme/target/nvmet.h |  2 ++
 3 files changed, 18 insertions(+), 7 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b

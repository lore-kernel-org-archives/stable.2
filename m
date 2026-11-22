Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795358920;
	b=Z+g0J0neoFUrpzEszlaN8xrGKpi5t6ewLMsmqJ1SjwtHk5oPtVl+eVRqu7dHjLGkwYzt
	 +S1/l7Wbasn6NZJzhKdnz1g3A19OBO2WyJORgTuArV4WsUQeaiiMQHGk4J16U6EkfwBAq
	 dfa7NXH5kkQWeOxKO+2NEkSJK4WW2jAGgxSUQge6qySHRZ2bVi7yXWYYfWTHqyVos77mw
	 Ur4DpAyvA+cwuRFpLiQdL+oR+48RvyZfpSA9PsHCdQ4k7uF1W9B5xr7I1SwRT9tG9EZ9a
	 T3i4RiWh0mobTJQn4ILfZsw5u7MdADItlLsyBnMMPOSF+Fphkbkl4vJKXlZWPV/exVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795358920;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=OrcddJ5pCwdY9QU+zPNEcBVg2Z0fI5gaTBEgEYuNhEg=;
	b=pLBQxLA962J60xKyyPnsNXdBn9DEBf9NMJmGGkHyUZOWEgj4McVc4SCRWVYb/IwYRZvI
	 DNaYw7pq+SAOpi6MBOmCx9DLi5VLy2YMEkkHu/nigpArsJ9vPM7E88ibUxw/rEb6yAGSz
	 VCgo8MvGu1R/L6YKkQtdoAy/UpdzZpsTUN3D7t6lULM04z/iTg/8A3/4CXowSQEFIWat/
	 zzD9XLqH/jDH7+hbIpUw3WSy5ZdlzJxB6K3mKSYuwB4juWL7vIuyA23oUGa1QrSHBVCo8
	 8onXHHa3Ya29pQYEaKe23YP6rhtYgcZYeersW1AmUYMqH0PsGXEMmJrfYY/6KS1WlHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Qnnh+QRb;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18089606A320;
	Sun, 22 Nov 2026 14:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18089606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Qnnh+QRb
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jXX5258gfz5BNRf;
	Sun, 22 Nov 2026 22:48:38 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795358918;
	bh=vTX/aGbXYNWAw4/qQGfCC1kEAb8u6nryzk/sdB56V/Y=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=Qnnh+QRbYHKtgh6vdxEBMJpnFo3cq8EhyCznkhKdEI6buDP9/LmCNduh1m2pYTLIf
	 HYfREfH0ykpw5ZcKSt53Tues14ZpJfMLZLgpGKY7B6XOBn/92M2BUw/+hrrBRtUOat
	 a/OsBz5s1XLLuKs+08JGbrGAgnXx1KndxAGvXfHEDQWZLqIkJtEkuVnApj87GZA4f7
	 64ic+Q58WxTsvmw2PWgWaqMrKu3VX7rQwYuGsGLKXgZhbo1PG/7ruArSMTRC+CIj+f
	 tj6T/qS3cLqLtMyni3RikVzUi4ybK963gn8hvS2jyd0iFvWolvwazFCa6mY9+3yi/r
	 dA6yHEvTvf4qw==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6AMEmU5m029187;
	Sun, 22 Nov 2026 22:48:30 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 22 Nov 2026 22:48:34 +0800 (CST)
X-Zmail-TransId: 2afc6b0300c2944-4e4fa
X-Mailer: Zmail v1.0
Message-ID: <20261122224834044bbU8YIyVINFDqdSezEwkG@zte.com.cn>
In-Reply-To: <20261122224829803Cnc907ditjVjp2YzW1gmE@zte.com.cn>
References: 20261122224829803Cnc907ditjVjp2YzW1gmE@zte.com.cn
Date: Sun, 22 Nov 2026 22:48:34 +0800 (CST)
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
To: <kbusch@kernel.org>, <hch@lst.de>
Cc: <axboe@kernel.dk>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvMl0gbnZtZTogZGVjb2RlIHRoZSBGRFAgR2V0IEZlYXR1cmVzIHJlc3VsdCBhcyBhIGR3b3Jk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AMEmU5m029187
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 22 Nov 2026 22:48:38 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B0300C6.000/4jXX5258gfz5BNRf

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_get_features() returns completion dword 0 as a CPU-endian u32.
nvme_query_fdp_info() reads the result through a byte-ordered structure.
On a big-endian host it reads the high byte for the FDP enable bit and
the wrong byte for the configuration index, so FDP can be skipped or
configured using the wrong descriptor.

Read the result into a u32 and extract the enable bit and configuration
index from the dword. Remove the now-unused result structure.

Fixes: 30b5f20bb2dd ("nvme: register fdp parameters with the block layer")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
- Remove struct nvme_fdp_config now that its only user is gone (Christoph).

The v1 QEMU test used an emulated FDP target over nvme-loop. On s390x
the namespace gained one write stream after the fix. On x86_64 it had
one stream with and without the fix. The core.c change is unchanged.

v1: https://lore.kernel.org/r/202611150127572887TC7vHzVUFLZ6nyW1NuhU@zte.com.cn

 drivers/nvme/host/core.c | 6 +++---
 include/linux/nvme.h     | 6 +-----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f43582e5f6c4a989669f8a92343467932a80b820..eddad69a4abee0322111fd8784898a658cb42bf6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2339,8 +2339,8 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	struct nvme_ns_head *head = ns->head;
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_fdp_ruh_status *ruhs;
-	struct nvme_fdp_config fdp;
 	struct nvme_command c = {};
+	u32 fdp;
 	size_t size;
 	int i, ret;
 
@@ -2351,10 +2351,10 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		return ret;
 	}
 
-	if (!(fdp.flags & FDPCFG_FDPE))
+	if (!(fdp & FDPCFG_FDPE))
 		return 0;
 
-	ret = nvme_query_fdp_granularity(ctrl, info, fdp.fdpcidx);
+	ret = nvme_query_fdp_granularity(ctrl, info, (fdp >> 8) & 0xff);
 	if (!info->runs)
 		return ret;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 6248711784b37030e82c8a1ff8579c2d669da0ba..a75f3e5f6210792348d34bdba38b20a24e54202e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -701,12 +701,8 @@ struct nvme_rotational_media_log {
 	__u8	rsvd24[488];
 };
 
-struct nvme_fdp_config {
-	__u8			flags;
+/* FDP Get Features result (completion dword 0). */
 #define FDPCFG_FDPE	(1U << 0)
-	__u8			fdpcidx;
-	__le16			reserved;
-};
 
 struct nvme_fdp_ruh_desc {
 	__u8			ruht;

base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
-- 
2.43.0

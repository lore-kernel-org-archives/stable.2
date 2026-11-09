Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236365;
	b=z5YkQ8Uc6eBUCkZVqpT7NvksFfpVrw1Xc1JIbGuitaQuSvSzaNPbsHP05cD3v8ll2UCB
	 3M65LYNf7AuEFjr4Ls0IzTseUk5Rit99Y2/ga1bpiFCWqNvokEDP39Do8nyV5FC+cdoZd
	 3UjmF7PZtAfLas8pSb6dAM3K6Xp8eSe/ONnlgsTkC57Cg0CKiKcrVS0FC3KXG3NObVAhl
	 7AG9NHE0ZlCaN+6onDq5uuVO6dCrB5SI3yzUiJGPOLiw3VO9TYkrM8g+3VpkcVwLTZUyE
	 /zHqWhLwa6qauP+sXqdgzs6jD6uaMYqo/ON9s72luOCXID9jw5Cp1vwZ5+4LaT9gwhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236365;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=PgCg/UbfSF4Y1FceeCMsI+hOq/EPutTDQs5k6Ln033M=;
	b=yG9AzgQaCJ6UpFrQGT4Uy3EgP9UGwLuG0Tv6kk4bYgBJ8sUH7xErIX4J/jY6229uuEla
	 kZIW5sIq49iqbt+Drjb2WPcGUhVaIa9SpHsOVR/ocvl/jALWVB2bMweV9JgfaB7ssPTin
	 5AV9wjh0ieUDV1ae0VtptvTfY7OIU3RAngeg6TBcu4Q9UtpTu7BcvxjWdIYHnHb9o7j7h
	 kL2iHw557bLWFnYf2YQt8lUgbrmczGrSqCqd5mwYRWSoO1WGBL8QQ/L/QlQAm4iZ/B7LX
	 BVByVk6u/wimqVmpYmOF5i15WuNkbeOHk5CQG05UotTetdF2zB/YQqnovhZ3ElU8/bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=FtQneOuQ;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5AD606EE8F;
	Mon,  9 Nov 2026 14:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E5AD606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=FtQneOuQ
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jNXxJ6l7Vz4xNtl;
	Mon, 09 Nov 2026 22:59:16 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794236356;
	bh=VyzFy1x5es8MPjdHAbjHFFb6uwYxP6AKzrLvrgEJcko=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=FtQneOuQk7O9zoipD+DRh3k+7+Lgm8xQZ2yBMAh0b33ZB8sKWA3EowMtwZS9av1WG
	 8KfwGMoHWPzP7iDJEXFSzJRazhNaUvEhQUoyNNFcLxNxBsYdVZSu6ldoHBYFfU3YMJ
	 DD3Yx8TB9fiQigyBYFmlMG3t59Fr7QJmHfXNCR3KgGkqekLOfF/2rXCbWrdHN/ONlf
	 KSWJGOrWiwzX7tLS6U0Nbl32akzVbcE6sleg1xShaI4wL6pE8NBuHSTLt8znoyJLYy
	 ekoYNGQr2RCSptfQ6m/sFgUC11tlrDS6YvILVRE20K2EJ/YnHZKo5yBmp7fypEQVS/
	 dqtmQg4hmtolw==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6A9ExGLY093656;
	Mon, 9 Nov 2026 22:59:16 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 9 Nov 2026 22:59:19 +0800 (CST)
X-Zmail-TransId: 2afa6af1dfc75d7-7d398
X-Mailer: Zmail v1.0
Message-ID: <20261109225919740-DfVem3ttLxIAe7wl3Puh@zte.com.cn>
In-Reply-To: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn>
References: 20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn
Date: Mon, 9 Nov 2026 22:59:19 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDEvMl0gbnZtZS1hdXRoOiB1c2UgdGhlIHBhcnNlZCBvZmZzZXQgZm9yIHRoZSBESC1DSEFQIGtleQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A9ExGLY093656
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 09 Nov 2026 22:59:17 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF1DFC4.000/4jNXxJ6l7Vz4xNtl

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_auth_parse_key() accepts the DH-HMAC-CHAP key with

	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
		return -EINVAL;

and then skips a hardcoded ten characters:

	key = nvme_auth_extract_key(secret + 10, key_hash);

The ten characters assume that the hash identifier is exactly two
characters long.  A string such as "DHHC-1:1:" still makes sscanf()
return 1, and secret + 10 then points one byte past the NUL terminator
of the buffer.  nvme_auth_extract_key() starts with
strlen(secret), so it reads past the end of the allocation.  The sysfs
dhchap_secret and dhchap_ctrl_secret stores only require seven
characters and a "DHHC-1:" prefix, so a short value reaches this code
(even though the nvme-fabrics option parser rejects secrets shorter than
eleven characters).

Use the %n conversion to obtain the real offset after the
"DHHC-1:<hash>:" prefix and reject a string where the prefix is not
complete.  This accepts both one and two character hash identifiers and
never starts the key past the terminator.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest, KASAN) with a live loop
controller and host DH-CHAP.

Writing the 9-byte secret "DHHC-1:1:" to the dhchap_secret sysfs
attribute makes the driver start the key ten bytes in, one byte past
the NUL terminator:

  unpatched                            patched
  KASAN slab-out-of-bounds in          write rejected (-EINVAL)
  strlen/strrchr, nvme_auth_extract_key

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index e2e0c736540a..1fdc4e4ed0b9 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -489,17 +489,19 @@ int nvme_auth_parse_key(const char *secret, struct nvme_dhchap_key **ret_key)
 {
 	struct nvme_dhchap_key *key;
 	u8 key_hash;
+	int offset = 0;
 
 	if (!secret) {
 		*ret_key = NULL;
 		return 0;
 	}
 
-	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
+	if (sscanf(secret, "DHHC-1:%hhd:%n", &key_hash, &offset) != 1 ||
+	    !offset)
 		return -EINVAL;
 
 	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
-	key = nvme_auth_extract_key(secret + 10, key_hash);
+	key = nvme_auth_extract_key(secret + offset, key_hash);
 	if (IS_ERR(key)) {
 		*ret_key = NULL;
 		return PTR_ERR(key);

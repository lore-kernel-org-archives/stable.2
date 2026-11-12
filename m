Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492071;
	b=kEXbTqGGuwBbzGCrpU5iF+hsJkyKv2sEtKNBXF5l7QBvivflTxYjnUK3m1VehAqp+vyP
	 tsj0YImrjdf9BO3jvhPCzJJ0+jsq66Sd/nJIT63yP67Qi3/ByIBSE/NjEyiaTRSAgWQNJ
	 jZKPI4hq33NJuAty80l7W+TqbfRoo1E+eTf8l3Nw7CDhEFkkoHUy3glKiyz9K9JaSMajO
	 fG6fg2PmHiInDQ26CND2EJ8DRVN5hollKqaWZ6vLrIYZKZSuCOcx1sRzVBKSaUBnUX2ZQ
	 chpGXaQFtyOowatY85gKYSd9F7G3tBdeqB8DLiuWgiZ8oGlB0q1vHbpRukGP+O0/zHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492071;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=ehMAux4zPO59WGmXjV45w0rvQhEn3+ok2cfsvTCiEm8=;
	b=XYvHQlWF0xA9RIf/dyEC4GMzm6G9GfSlJdIFbeAnR6T+XPyjPt3N2liHcKUtl4HeBadR
	 gUNRc0MLMNeo7QY9tprxDY0UatH0Eadk3m16SFJ34GIIXX8vuUPovRU+tgLe58bPbCn32
	 JsEPauwFa5zEtwnRkbvLggSuGDoGaXdvnGV2F0t2y4CNJGV74CnwICk6taxbq6M2tiT6F
	 er5sHTY4933+6xh9nRPmnGbDRTiSz3Vv3Rd2l6tlZbT7mkHeK//1T9h0u7EZyHqllWncm
	 3VdX1RBTVcCrk70o3UfpwJP5f13xBlnYei0Gcckf3l6YopGtZb6PLK7yksdbl+DtsDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=FInfaeEA;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C9560A260E;
	Thu, 12 Nov 2026 14:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12C9560A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=FInfaeEA
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQMVj6LXNz4yjjF;
	Thu, 12 Nov 2026 22:01:01 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492061;
	bh=2vd7az9105wcSaW62eUNl1HKGlFkwj5Se2CmMaZM/+M=;
	h=Date:From:To:Cc:Subject;
	b=FInfaeEAsyzxZEXYqHjivnoIpff+/7/yIUXlruzPUln8QVtJLfRNOwdqlaXq9KzzV
	 YHyVQDnVQnkFcicoF9cW/7HfbygM1EW961hX2XjqC4vcTc8yOtSj3T2frbk/PiEr1s
	 XfbfdviZ0C3fqbzS71AhBMlGp550PT0xdGNwHtf/rWhIc0pSgXIywVJpN8LjTa4EiW
	 QldLmqE/IKAtDFXnEKvt+5bvo7Pbhl2U+bjdCn2eE52D6clytFKB3vUyJsiPHUmn9H
	 rzVI58rM4/XqC/uBTdojt4vTS+/KGPaZDmVBHzaxP9EaykZfuf9UA1/0no/wLRZgyp
	 Ax9cjAct9hDwA==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6ACE0t93045249;
	Thu, 12 Nov 2026 22:00:55 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:00:58 +0800 (CST)
X-Zmail-TransId: 2afb6af5c69a44a-d4bc8
X-Mailer: Zmail v1.0
Message-ID: <20261112220058755zQhw_h6UkcVSjRnu478lb@zte.com.cn>
Date: Thu, 12 Nov 2026 22:00:58 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvMl0gbnZtZXQ6IGZpeCBmaWxlIGJhY2tlbmQgc2hvcnQgSS9PIGFuZCBMQkEgcmFuZ2UgY2hlY2tz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ACE0t93045249
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Nov 2026 22:01:01 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C69D.002/4jQMVj6LXNz4yjjF

The file backend computes byte offsets from the LBA and block size with
unchecked 64-bit arithmetic and does not handle short reads or writes.
A host can therefore make the backend report success for a transfer that
only covered part of the range, and a large LBA or length can wrap the
range check and reach vfs_fallocate() with an out-of-range offset.

Patch 1 makes nvmet_file_execute_io() stop at an incomplete submit
instead of advancing the position and eventually reporting success, and
converts a zero-byte completion on the common path to -EIO.  Patch 2
adds a shared overflow-safe range check and uses it for read, write,
discard and write zeroes.

The two patches are independent and can be applied in any order.  Both
carry Fixes: and Cc: stable.

Changes in v2 (Christoph Hellwig):
- Patch 2: use the shared LBA range helper for reads and writes, with
  pos64 local to the helper. No functional change from v1.
- Patch 1: unchanged; add Christoph Hellwig's Reviewed-by tag.
Link to v1: https://lore.kernel.org/all/20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn/

Shao Mingyin (2):
  nvmet: handle short reads and writes in the file backend
  nvmet: use overflow-safe range checks in the file backend

 drivers/nvme/target/io-cmd-file.c | 47 ++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 13 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592977;
	b=p0QBDWWu02zo8Sq8OjFOAlQUlvPuwUZtyGA8PHx3SvlUirvyJv/icLC3f6rlTlg8Yy1I
	 laYjw47U+iIUYYijctjwBJOg6YkB3YO12zuTTGht3FE+1mhmyeQat4LLAh0ZwZj2DKvS8
	 qu3zuFM5aTRsXkN+eZ2xhelEe57w3l85rArR7T9fbP8Lg0ICMtoXqXG1HQ3HoETeBE5tU
	 hm/FDzGp0frB4zP7vKqoO7IS/4nqEO4YD/HpYazqiWGt0PB0m80+hRSzP5swpbGR+8fjX
	 EnVVvKvx3+sLfjsZhP5NrZ6acpeFewCP1GgTFHPGNjpO6Jz1CWsTex/7QfufDy1THJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592977;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=0tiw501LQlDT/C/vtvjmBBlL6OpfGScC/n0wVEWEnzo=;
	b=n8/iDliCgYztdll3KmI0Y5D2REmc4oCjhYU29v2DbGb4SP/iRbL3VLgiBuVsgIQ5tEUU
	 jQEb9IGxy7N0QajCs/wqj1xkgOa6+t9trN8UGuQ87bf0WzHtG8eB4LRTA780vwrEpDAHH
	 Or0/bFErZHlURn9CmZc3tRT+XfkkqVFm6MwFmKccof9QeMbTfqVALeNQM6/yAwl1IJsC7
	 Y7RkES7icr6XpJf+9cxlXL8uy/yAPFGf3OtS/ZDSBWdftZrTTjwFcDhQINbhZosd+2o9w
	 RIwViUKuEfD87a/aXupt6S8tjgwY0h+y+6j20aE2gMDlSB0AuDdBDy2WVPG1w+SMFXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Mw2jAWKW;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168DA606B44D;
	Fri, 13 Nov 2026 18:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 168DA606B44D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Mw2jAWKW
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4qM2R50z5B0yy;
	Sat, 14 Nov 2026 02:02:55 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592975;
	bh=o2bgXvusxuIZ0pl55yltht2SatK+daXQrJdQ1UvZbdM=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=Mw2jAWKWk1vYg3Kw2Hvvo8GZT2/gUJeFUsxH9/FYLSxd8JDWDTjqCetiYiXt1WKmX
	 YhMweOo1RRv3EihvwikLHJuSylZmbNkFShChYrbOcl5rJ3lI3MzG9Y8zyXT85HaETB
	 Cjb//FdSVocplwNJDlcAjVlptASiiilbQdu98Jg1/5+TLV57obUXXxfNKcuZG5fKu4
	 RUkPdFoU9dltvrM3MY8pIfG4xYXZ7CUPXKxwelZ8jRxtASO7zkpD9bIhuVxOyfFN5h
	 YMXvPpnYmyTp1Ze+8UUvt3mLSMSC+up3H4ZHhUkt4+qmqtfczQPNDDYMe0r175CgeR
	 1WnI2w1Q+1mFA==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6ADI2nKc099801;
	Sat, 14 Nov 2026 02:02:49 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:02:53 +0800 (CST)
X-Zmail-TransId: 2af96af750cdd92-15cd8
X-Mailer: Zmail v1.0
Message-ID: <20261114020253302taupmFxThUvQwCc2ab2CI@zte.com.cn>
In-Reply-To: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
References: 20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn
Date: Sat, 14 Nov 2026 02:02:53 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDQvNl0gbnZtZXQtZmNsb29wOiBmcmVlIHRoZSBMUyByZXF1ZXN0IHdoZW4gZGVsaXZlcnkgZmFpbHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ADI2nKc099801
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 02:02:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750CF.001/4jR4qM2R50z5B0yy

From: Shao Mingyin <shao.mingyin@zte.com.cn>

fcloop_h2t_ls_req() allocates a fcloop_lsreq from lsreq_cache and hands
it to nvmet_fc_rcv_ls_req().  That function only takes ownership on
success and returns an error without invoking any completion callback
when the target port is shutting down, the LS payload is too large, or
the target has no free LS request slot.  The error is returned as-is, so
the fcloop_lsreq is leaked; every failed LS during a target port
teardown or an LS slot exhaustion loses one slab object.

The target-to-host direction already frees the request when
nvme_fc_rcv_ls_req() fails.  Do the same here.

Fixes: 772042dd38ee ("nvmet-fcloop: allocate/free fcloop_lsreq directly")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
- Code and commit message unchanged; add Christoph Hellwig's Reviewed-by tag.
Previous version: https://lore.kernel.org/all/20261110230313720JCGXeTg2zOideed82vWy9@zte.com.cn/

Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the fcloop
loopback transport (nvme-fc host + nvmet-fc/fcloop target); no real
FC HBA is required.

The -ESHUTDOWN error path is otherwise only hit in a sub-instruction
teardown race, so it is exercised with two TEST-ONLY changes (not part
of this patch): a debugfs knob that makes nvmet_fc_rcv_ls_req() return
-ESHUTDOWN, and SLAB_NO_MERGE on lsreq_cache so the 72-byte
fcloop_lsreq does not merge into a kmalloc cache.  A stock host sends
120 Create Association LS with ctrl_loss_tmo=0 (each failure deletes
the controller); the cache is shrunk afterwards, which only reclaims
empty slabs:

  unpatched                            patched
  lsreq_cache objects 0 -> 120         lsreq_cache objects stays 0
  slabs 0 -> 4                         slabs stay 0

 drivers/nvme/target/fcloop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index b63af3b643a648dc6878ab5afaa711b6294bf5c3..a9cde536c33ba11ced49bf74314aa5eed714df48 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -379,6 +379,8 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 	ret = nvmet_fc_rcv_ls_req(rport->targetport, rport,
 				  &tls_req->ls_rsp,
 				  lsreq->rqstaddr, lsreq->rqstlen);
+	if (ret)
+		kmem_cache_free(lsreq_cache, tls_req);
 
 	return ret;
 }
-- 
2.27.0

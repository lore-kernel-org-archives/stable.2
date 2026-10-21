Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564183;
	b=Tq+i+8piMtYPVF8MZ1NnWIRO+BMPF9fRKtepq/zcVbZqGN12LvC7HdYTPEcLQcp76vMQ
	 xB4hj8SN1VqzW8s39NgbONr1xoLC0brxJlNzhH+FzNOtNGQYIwrUxJam/06lZaGX35s67
	 D8cht3aVXZ1ZAXx+TwTmCc8osRtHKf9pzeus+kn4i3vmCpasaRlU2lYjjcs02eBhshe8R
	 0s65fXVwcy1VgN+/cCeukkbtrBEoXXRf2xRXmlt2UsYuAykWV6ydoys9Qb7RGPSumIhjG
	 RZP9lkoO9Ejg+wzqWK77tmonQmFY3YhmZ5DV/q2hmiofDhko19AHuhStng4r9sVE0zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564183;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cImbtpNfundq+E3LlfLcouDSeDujPioiDvq3a3prxXc=;
	b=yZcrAAuEMGU+MQcNZuG1XdLcNgZDePlJAl81gjziyOPERt/S+AuTSRvOPqr0Ham6Ldxv
	 sltk6RpVBqwd9+QZdrEc66UZkdm+7qYdZObr6yzR4Di8swTgrFbkY/sPDJZ4C4Eg+FFjf
	 pF4+7POe8n9I8pCweL2Z0RXdx44dOAYceSrDRp1c4hTvCZKoScotk2DlYAg/p2JiRFxWL
	 5RWIgAM0wlm9rD3FpXxzvP6VPeP4h4JWZAN4Ikb5O757XqprpD2V5XNloTmwczAvNiM5b
	 Q52Sae57hDCleMKgJrt1D1vI0Y8opE+HNSYklp0+4OF7kBa6n77IHcd4Nd+fu6xZveg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=V5n8pl7y;
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F84606A319;
	Wed, 21 Oct 2026 06:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F84606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=V5n8pl7y
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792564179; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cImbtpNfundq+E3LlfLcouDSeDujPioiDvq3a3prxXc=;
	b=V5n8pl7y9DlXOoTZy1xd4Ma8tol6zq/dIlw5JAm2HvgtcibWX/VfKODCcO3Fh4svjUXgQvbjezfRUw5eJPeiByz3QXBQAeCqQMP3p0juTBFItNuE8EGzVZpf8iWRT5MkklD9gLLD20bnveZivTCX+ghNCAlXLdmF2nEQYB5pEbk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=tongweilin@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XDFZBif_1792564167;
Received: from x31l07246.sqa.na131.tbsite.net(mailfrom:tongweilin@linux.alibaba.com fp:SMTPD_---0XDFZBif_1792564167 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 Oct 2026 14:29:38 +0800
From: Weilin Tong <tongweilin@linux.alibaba.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: [PATCH] EDAC/amd64: Fix double free of private data on registration failure
Date: Wed, 21 Oct 2026 14:29:20 +0800
Message-ID: <20261021062925.1838750-1-tongweilin@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If edac_mc_add_mc_with_groups() fails, init_one_instance() calls
edac_mc_free(), which frees mci->pvt_info. probe_one_instance() then
accesses and frees the same private data, causing a use-after-free
and a double free.

Clear mci->pvt_info before calling edac_mc_free() to leave the cleanup
to probe_one_instance(). The normal remove path already clears it.

Fixes: 0bbb265f7089 ("EDAC/mc: Get rid of silly one-shot struct allocation in edac_mc_alloc()")
Cc: stable@vger.kernel.org
Reported-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
Signed-off-by: Weilin Tong <tongweilin@linux.alibaba.com>
---
 drivers/edac/amd64_edac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 0c0d11c72925..edced7cbe83f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3975,6 +3975,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	ret = -ENODEV;
 	if (edac_mc_add_mc_with_groups(mci, amd64_edac_attr_groups)) {
 		edac_dbg(1, "failed edac_mc_add_mc()\n");
+		mci->pvt_info = NULL;
 		edac_mc_free(mci);
 		return ret;
 	}

base-commit: 2c455ddca7827ad8fa3a64fdbf5a60efb928b46a
-- 
2.43.5


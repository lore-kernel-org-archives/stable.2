Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258775;
	b=IvRulzcegqFvB625JPUpKIN1YOw0XKuHD/+DQ7aGvR5VlSNsxZOP+EpXc5IFAW0q13MD
	 XvKKSz8PFQbJZ3c7U3tbaaI7LdQ8tbql6096SYwuFCJ+LpwQ5EUCbq2Rs4EvDjT9TMzlC
	 Sv7wtER3pzXiukfZyfxY+khUENjkeN11WaHfFI9/M6ieL9IheGFeUgkjdtOKbiXO2bS6V
	 Bh9eAvauhV0GBxrz3lnnbfMECx4+K84abIplSMPKaLvOVREBObt5YONv3rm799sF50Ya9
	 7dbSIzitbqcMvEXp/ZrZUIexjurkEtPy2NEM513E8RuL9HAxZeB/P6B4Ww6+xHp26Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258775;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fR3gUo6gbt+rTe6quZfvAkmemOu+thOKC6uqOWBnj50=;
	b=1hHnUmLkSyG5sMfs4d6sTN06XE2jHFi4sGEfcIcfnaDzBhxewJOmff7kK3lu9N8QiRqe
	 /PrwZjCrn9FsHjhgC5ruz0Mj90BRzAJwQqxzuvNMxaQs2u19mHQFaLz8ITNsKW1EodmKy
	 RqRlCEfxur+Q6XXrJabQrnzwqnjWGMkDxnPRA679BMiOeZG9+G7YIC6zAiz9XdVAUdK5R
	 WWkgkoOwI9051g+LtkKsFIZ8TMOouaDySnikmrkt2A0NR7UQ8fmX44O0YcrIZJ3J1IpJT
	 Xn3rTjcGVlUVopArzr/H+Ki0jySVOPIx7oiU8COTeBXzn0QKhZw1eeSgZ85gTyMnVcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="vO//suvr";
	arc=none smtp.remote-ip=115.124.28.77
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A7606A31A;
	Thu, 29 Oct 2026 07:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED5A7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=vO//suvr
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793258765; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fR3gUo6gbt+rTe6quZfvAkmemOu+thOKC6uqOWBnj50=;
	b=vO//suvrL4MfcDjNo3xxAmaDaIBt3DGkO/FF+Aua8pA3u0JsTBmqgz1ixNAsO01xfoH3kKmOQtv5XBzFjveDP+0/da+R/x1o5ypH++dgRz8Ftu+JJKyRHOodkocFR5LURcrTOtPLRLatBKMZxXwTLnmorlCRXkQs0n89w+5gH1o=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2440847|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00326124-0.000502231-0.996237;FP=14374540439058058531|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.js2f3ue_1793258764;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.js2f3ue_1793258764 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 15:26:05 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: "Igor M . Liplianin" <liplianin@me.by>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: dvb-frontends: si21xx: validate fec_inner before coderates[] lookup
Date: Thu, 29 Oct 2026 15:26:04 +0800
Message-ID: <20261029072604.4135019-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

si21xx_setacquire() indexes the 10-element coderates[] array with the
crate argument, which comes from the user-controlled DTV_INNER_FEC
property.  dvb_frontend_check_parameters() only validates frequency
and symbol_rate, so the value reaches the array lookup unchecked:

        coderate_ptr = coderates[crate];

The enum fe_code_rate range however goes well beyond the table: the
uapi header defines values up to FEC_11_15 = 18, so even a perfectly
legal code rate request such as FEC_9_10 (11), set through the
DTV_INNER_FEC property or a legacy FE_SET_FRONTEND ioctl, indexes
past the end of the array, and arbitrary u32 values overflow it
outright.  The byte read out of bounds is then programmed into the
VIT_SRCH_CTRL_REG_1 register.

Verified with a userspace copy of the function under AddressSanitizer:
crate = 12 (FEC_11_15) reports "stack-buffer-overflow READ of size 1
... 'coderates'".

Reject code rates beyond the table so the Viterbi search is only fed
defined values.

Fixes: 04ad28c9916d ("V4L/DVB (9017): Add support for Silicon Laboratories SI2109/2110 demodulators.")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
 drivers/media/dvb-frontends/si21xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-frontends/si21xx.c b/drivers/media/dvb-frontends/si21xx.c
index e64ced2d6..67d644b7a 100644
--- a/drivers/media/dvb-frontends/si21xx.c
+++ b/drivers/media/dvb-frontends/si21xx.c
@@ -651,6 +651,9 @@ static int si21xx_setacquire(struct dvb_frontend *fe, int symbrate,
 	dprintk("%s\n", __func__);
 
 	status = PASS;
+	if (crate < FEC_NONE || crate > FEC_AUTO)
+		return -EINVAL;
+
 	coderate_ptr = coderates[crate];
 
 	si21xx_set_symbolrate(fe, symbrate);
-- 
2.50.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967682;
	b=EZJVARTOICDoAW7bA5hdTy3l0i/lr1AdNdQ5bBguYnVSzw79iRe6RFwajzbVQyfi005u
	 8zO9E40VdVO2U7Fqb4D/ufySU7Sr32uSu29s/uxQLEs7QhO5P56I1UDG9ZBjf43Ud2Hyo
	 KH5d5u7K6SRukbzWRDpmojQKTlxF5eMOmt+NjMozTJ6g1OqvcF7vKpxHWnlUSAZSLycT+
	 PbIHXTss1bBmy5yiGHhjmYLQ1PncXUb9tC/JgCU5pz9HGfL+HgFdEUDT+EWK7a4ETHEEP
	 h++5qaqAhyXUTuwFV3iar+0DFU6AHpB9H8ZGrhBjQHR+vp3rYJvuLmpsWP78879lONg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967682;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vUPmyTuUzWWeEug5UoL9wQXbXmMqziYU0ZCDFkqjrPs=;
	b=YD6r4p8nUI4h7uSJaFJmod2QkT60ZNHFL805KUfQ274eKW3rHVQbTJN6X3MQ/PaSj1Nc
	 2grfJsyJM/CRT/Hng1CFVrOlCYERg0vUmmW6v4QgYf7b7QOWjbaj0n6Xmsk8Mr7NOGSVy
	 SeVNcjKhGuSPbcgrrDxRC6X3uIECxZzgQHw4yfSB1IPSjM3fsHeR+k9qEYbNm2cMPz053
	 Tq8kdB9ywAm1DFKrElbzf5iGTTclav0U1PO66Fza2sEjc/PeuH/kslkhxJNm6H1rWy1CC
	 tNrWY8eS2v41zpu1ZXqK4QxCAfYXJS/GXkaimsjRA12dMXIjTkev5MYjOsOrhDx7q3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=IZoPMmfu;
	arc=none smtp.remote-ip=115.124.28.98
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60F606A337;
	Wed, 18 Nov 2026 02:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D60F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=IZoPMmfu
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794967672; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vUPmyTuUzWWeEug5UoL9wQXbXmMqziYU0ZCDFkqjrPs=;
	b=IZoPMmfuDcOzVv+EvVQTMZWBBL1DQ7+JkXimg7NIK+nKC1qzw/OBuc+fH9uPgyerDJVl6aMPPfhJXiDJpM9NiDuUiq6NP72omTsXt05bsmgohwVsSw2Fdxej2lkMQ4d6rIMSv8dSc1JqDitcECu91nCNkVO0ZcrXl2K+HZhwKME=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08588208|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0022107-0.000197108-0.997592;FP=13709710654647639744|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033071099199;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.k4NZxVQ_1794967671;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k4NZxVQ_1794967671 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 18 Nov 2026 10:07:51 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: paul@crapouillou.net,
	harveyhuntnexus@gmail.com,
	miquel.raynal@bootlin.com
Cc: richard@nod.at,
	vigneshr@ti.com,
	linux-mips@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liuwb@xiaopeng.com,
	zhugl3@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] mtd: rawnand: ingenic: validate BCH error index in jz4725b_correct()
Date: Wed, 18 Nov 2026 10:07:50 +0800
Message-ID: <20261118020751.1833498-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <80f1ef9dd605d16df2add0a9dbdcdd5f9f508174.camel@crapouillou.net>
References: <80f1ef9dd605d16df2add0a9dbdcdd5f9f508174.camel@crapouillou.net>
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

From: Weibin Liu <liuwb@xiaopeng.com>

The JZ4725B BCH controller reports each corrected bit error as an
index into the codeword it was asked to decode, in the INDEX0/INDEX1
fields of the BCH_BHERR registers. These fields are 13 bits wide, but
nothing in jz4725b_correct() checks the reported index against the
size of the data buffer being corrected:

    buf[(bit >> 3)] ^= BIT(bit & 0x7);

With data or ECC coming from an untrusted flash, the decoder can
report an index that points past the end of the data buffer, and the
above statement then flips a bit outside the buffer.

Skip the correction when the reported index does not point into
the data area.  A bitflip in the parity bytes does not affect the
data, so rejecting the page for it would fail reads that are
perfectly correctable, and an index beyond the codeword has no
buffer to update in the first place.

Fixes: 3e6ac2ad90b3 ("mtd: rawnand: ingenic: Add support for the JZ4725B")
Cc: stable@vger.kernel.org
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v3: add Cc: stable and my Signed-off-by as the sender, matching
    the review comments on 2/2.

Changes in v2: skip the correction for an index that does not point
into the data area instead of failing the page with -EBADMSG.  A
correctable bitflip in the ECC bytes leaves the data valid, and the
early exit also dropped the error entries that followed it.  This
matches how jz4740_ecc_correct() treats its indexes.

Verified with a userspace replica of the correction loop: with
params->size = 512, an index of 4099 (parity area) followed by a
data-area index of 100 in the same BHERR register is now corrected
(v1 returned -EBADMSG and left the data error unfixed), the field
maximum (0x1fff) produces no write outside the buffer, and in-range
indexes keep correcting as before.

 drivers/mtd/nand/raw/ingenic/jz4725b_bch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c b/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
index 2d0e0a2192ae..9b1c3d4e5f6a 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
+++ b/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
@@ -259,6 +259,10 @@ static int jz4725b_correct(struct ingenic_ecc *bch,
 			bit = (reg & BCH_BHERR_INDEX0_MASK) >> BCH_BHERR_INDEX0_SHIFT;
 		}
 
+		/* Skip indexes outside the data area. */
+		if (bit >= params->size * 8)
+			continue;
+
 		buf[(bit >> 3)] ^= BIT(bit & 0x7);
 	}
 
-- 
2.50.1

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704651;
	b=eigpZeAdRc4WeHUfdhZrmYs0cNa0QQzdvZ+cK8xBJNy86UUvwuXXHr+2o7mzXC+aIJT0
	 +EypkpULDk/FC6/d/xO+716djn6bTtVFp8jioq6gGYDv7ZiEg5gcfBGY+EUBjps10Hjdi
	 wti/sNSuiZjvs8lpq5s94C6JyTpD8FicU5PBH2euMJhKG0Q5oWtWPhueoFCKmNgLQny5l
	 EdviFXw0AuuQTrOXXQIFI9CjeB3DDLVScG53BGIAq4MhyGkrOyWU9u59MK4u/EoD4deBk
	 YDs7Zu8e7TvMieG9GpjP6ZbBXUmB22Ur9TX9LGBQXplVGY40zjvKAS7BFmHlFwF9OAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704651;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PHgr1LHm7Xcha6AWPRlmKOmDfNatN6pJnVJpXcSkCQw=;
	b=Yh/w6C6aMCBVvFQjF4QuNxZzmj3R3i6oMTGsOhrSasYrlEM9OGTYNTWzm7fU8ACVMmBR
	 iuYkEcTBjbHG9GxHTgA7lu1qj15gBona1AvfnpaU00zsUf+chRr8kQc6T7C9aAKnKhr/X
	 LBlJPzFl9Pg1E0Lm48Vw66v5Q74LjoURFciqwk1aTAdZUBojQwqvxTFR8W3tLi3f3AzcY
	 LroJFOLSi1+aK3LvMKuQ+gfm6BEfNYEmfQTg1ITwKNnLiezEiJdvTzr44OFgPc0+cU4X6
	 kM+x5VXEHb9BayrrQ6wpY81kC5mC4KFxwR2PxMTLmV6MqNWZdObrVDrg44dnfdzJyAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=QcUVqop9;
	arc=none smtp.remote-ip=115.124.28.125
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7836606C592;
	Tue,  3 Nov 2026 11:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7836606C592
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=QcUVqop9
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793704639; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PHgr1LHm7Xcha6AWPRlmKOmDfNatN6pJnVJpXcSkCQw=;
	b=QcUVqop9s0xtniBdh2HvchwfbrTi3C6mDaQ0h/ST84WRMSLmu3SXV6xYUCleNXM03GJj2BOctF5w899BWaQc/OzPgZMCPJRxWd2AX2Wf4Rr5B68SvOJ31vPsozoE/5D3gIab6x9m0xutU9jjl+xVNd2XGgi3J7ddGOZNQziAt4Y=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.4216508|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0572168-0.000769457-0.942014;FP=11345945774640399411|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033071099199;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jviw8wa_1793704635;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jviw8wa_1793704635 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 19:17:19 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH v2] Input: adi - bound the two-stream packet merge
Date: Tue,  3 Nov 2026 19:17:14 +0800
Message-ID: <20261103111714.472080-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103084135.426629-3-zhugl3@xiaopeng.com>
References: <20261103084135.426629-3-zhugl3@xiaopeng.com>
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

When a second device shares the wire, adi_move_bits() appends the
second packet to the first one at an offset taken from the
10-bit length field of the ID packet:

	for (i = 1; i <= adi[1].ret; i++)
		adi[0].data[((length - 1) >> 1) + i + 1] = adi[1].data[i];

	adi[0].ret += adi[1].ret;

Nothing compares the merged packet against the size of the buffer:
adi[0].data is the last member of struct adi, and struct adi_port
holds two of them back to back, so an oversized length field makes
the loop write over the second struct adi - its device pointer, its
length and its packet - and the inflated ret later walks the reads
past the buffer as well. The connect path also calls
adi_move_bits() before the length has been validated at all.

Reject a merge that does not fit in the buffer. Use >= for the
combined length so adi_get_bits() can never walk to data[ret] with
ret == ADI_MAX_LENGTH, and invalidate both half-streams on the
rejection so the unmerged packets are not decoded as standalone
reads.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v2: per review, use >= so a combined ret of ADI_MAX_LENGTH is rejected
    as well (adi_get_bits() allows idx == ret, and data[idx] with
    idx == ADI_MAX_LENGTH reads one byte past the array), and set
    adi[0].ret = adi[1].ret = -1 on the rejection path so the
    unmerged half-streams are not decoded as standalone packets.

 drivers/input/joystick/adi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
index e07b719..41262b7 100644
--- a/drivers/input/joystick/adi.c
+++ b/drivers/input/joystick/adi.c
@@ -168,6 +168,11 @@ static void adi_move_bits(struct adi_port *port, int length)
 
 	if (adi[0].ret <= 0 || adi[1].ret <= 0) return;
 	if (adi[0].data[0] & 0x20 || ~adi[1].data[0] & 0x20) return;
+	if (adi[0].ret + adi[1].ret >= ADI_MAX_LENGTH ||
+	    ((length - 1) >> 1) + adi[1].ret + 1 >= ADI_MAX_LENGTH) {
+		adi[0].ret = adi[1].ret = -1;
+		return;
+	}
 
 	for (i = 1; i <= adi[1].ret; i++)
 		adi[0].data[((length - 1) >> 1) + i + 1] = adi[1].data[i];
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258780;
	b=x8c6nusyd/QC5jnALBREWzAdEpU6YUy7VGycp6Fp0z8H3x5Qv5SJ76SkSNtAaIyPAOQQ
	 Cvv36870zvRp9S+daZhHQxZ/X3pU6aWSbFKw7AT9ReUIweDmOPLvB/+yQ/qDnQoKhrYJ6
	 mMtgAwFfpgBXLD28wwX3J1ANbyl/3zNpIYYMuGNWxbp4+yl4rJ+cgHrio569qb2g8BG8G
	 kD6Ojz8H/9foqRdpIdDOEdP8QmQdDNgKpm/zVKPP4KEBeSCqsl3M2RAu0VbKB/lYhCbW1
	 XF9zoCwYt/lfKbqSU8fzrdgV+tLD2iurel6TaDRo79e4biJ/wGHWO2u+ItXChYzxcxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258780;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pqGf7TzgONNCw8lKYpkLElcBFjt1PPT5AcI9ojNr/dM=;
	b=Fe0PGVff6A/61FHNhWx6bf2EbIbamKmIYI45pl1LigVg94uhY4+KZrdOHoFQP6defdPG
	 ba5GdOXJI1oTisMg/SRtjp28EKtaNBmN/xA8A4O/60Yw83+hSJKcqzJhrcLxpfK2b0TzA
	 0HU9V5RvF8Zm8OzSR+l6vXCLgyw3GZYZIb62t9Jt36siNKQmxoFOrTIm/5QcDKjpNQVdk
	 f4kqNUv1HRv1Dc1Y9zRJ8EHNIZ5j3bak7xIFtXmR7nSI01i1ffzR0sQX3djXJr9iHbIEF
	 o0N/kjD3ParmVVgGj0lwxAFaOUR2YnjwGPs9L7rg+LC1AYJmDrCL98SKZSJJa0o3ptw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=QG227V7o;
	arc=none smtp.remote-ip=115.124.28.97
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3D5606A325;
	Thu, 29 Oct 2026 07:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD3D5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=QG227V7o
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793258771; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pqGf7TzgONNCw8lKYpkLElcBFjt1PPT5AcI9ojNr/dM=;
	b=QG227V7o2c25yrTryCoG8WQARTry6FfR7SQLc1CeNxBFFGSctw3ZygYz527KwOnpH1MI2IARF5RmU0EWQiRSIdEoZz9MdaR8JKSHA52uzqK/ZuzB2BFNgxcHPhGSsimZ43c/G25TWctgpt9gZmMYqxRk918RvdiVtdAe82aZwpk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07550469|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.068659-0.00107601-0.930265;FP=12679159466549576950|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032065030;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.jsBQt5q_1793258770;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jsBQt5q_1793258770 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 15:26:10 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: dvb-frontends: mt312: reject negative values in SEC callbacks
Date: Thu, 29 Oct 2026 15:26:10 +0800
Message-ID: <20261029072610.4135820-1-guozh23@xiaopeng.com>
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

mt312_send_burst(), mt312_set_tone() and mt312_set_voltage() validate
their enum argument with an upper bound check only:

        if (c > SEC_MINI_B)
                return -EINVAL;

The arguments arrive from userspace ioctls, and the DVB core does not
sanitize them: FE_DISEQC_SEND_BURST, FE_SET_TONE and FE_SET_VOLTAGE
cast the ioctl argument straight to the enum type, so any negative
value passes the check and indexes the on-stack lookup tables
(mini_tab[2], tone_tab[2], volt_tab[3]) out of bounds, reading
adjacent kernel stack memory which is then programmed into the
DISEQC_MODE hardware register.

A negative index reads below the tables; e.g. tone_tab[-1] lands on
whatever precedes it on the stack.  Verified with a userspace copy of
the three functions under AddressSanitizer: passing -1 reports
"stack-buffer-underflow READ of size 1 ... underflows 'tone_tab'".

Switch the three checks to explicit whitelists so only the values the
tables are defined for get through.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
 drivers/media/dvb-frontends/mt312.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/mt312.c b/drivers/media/dvb-frontends/mt312.c
index 8fe850a8d..0c91b20cb 100644
--- a/drivers/media/dvb-frontends/mt312.c
+++ b/drivers/media/dvb-frontends/mt312.c
@@ -374,7 +374,7 @@ static int mt312_send_burst(struct dvb_frontend *fe,
 	int ret;
 	u8 diseqc_mode;
 
-	if (c > SEC_MINI_B)
+	if (c != SEC_MINI_A && c != SEC_MINI_B)
 		return -EINVAL;
 
 	ret = mt312_readreg(state, DISEQC_MODE, &diseqc_mode);
@@ -398,7 +398,7 @@ static int mt312_set_tone(struct dvb_frontend *fe,
 	int ret;
 	u8 diseqc_mode;
 
-	if (t > SEC_TONE_OFF)
+	if (t != SEC_TONE_ON && t != SEC_TONE_OFF)
 		return -EINVAL;
 
 	ret = mt312_readreg(state, DISEQC_MODE, &diseqc_mode);
@@ -420,7 +420,7 @@ static int mt312_set_voltage(struct dvb_frontend *fe,
 	const u8 volt_tab[3] = { 0x00, 0x40, 0x00 };
 	u8 val;
 
-	if (v > SEC_VOLTAGE_OFF)
+	if (v != SEC_VOLTAGE_13 && v != SEC_VOLTAGE_18 && v != SEC_VOLTAGE_OFF)
 		return -EINVAL;
 
 	val = volt_tab[v];
-- 
2.50.1


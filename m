Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695326;
	b=PXVOU4YlNnPYmj4NeM+bvLTqdEQm7IFWbW6C54q6QWwIFFFNxNzIXrlzTlUcuPooIvuB
	 DeJeCvSzESRBPe3dsPzB2Yfh1zDyh2rd/mNpmn9bW7H3zh/QrISLNvPPdoy2dfEDhp6EP
	 f/nzZXV+/gYC2li+0QA0EEz7O9DKqlA7zz8FOvzlSNKUWBx9FjMxpCJhiNXlbN9QOIxfi
	 YzfLY40xI5MX74NJiETd1lz72lhtFkvP+HkDiTxt1uMomj2jYNQv3lutYv/L9zorui4P3
	 8R4DJxDB4ysqvtYukr4fNENmp/MdTtXc2+NGD4jnzBYlBXG5nOTa9MFncYnPkWSTxfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695326;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LQtgJbqMUtgTAOSiSBIZQmE3kB6GQm4rRSSxiylbZ2Y=;
	b=HEwUVBUuW2NfOVLEKoBSav/nhmzCf2Rgd+BSp6RRVSVSaE8GtwVm/OsvPqJt2DzCJRZ5
	 2u2NEwV+08Lck9Q3ll/w5C6jXJneFKhQXhQY12NLY1FdNC8rOc1hPaUrZaLB3lsDhTUlO
	 VsFufgEZvD9Ncy2NVUqCHuF1ean2T5igrYbP/KZPBc7Myu0J3vuYA/Wod1ytrNIcSynfo
	 uqEsWiTDikbgxredLeV6d1/o2uLRRhQAQ9YZ+x97YwA7Axzf/S1KJNfCFzJILuAIJKSwA
	 hnc97NaZfNQ/q+FKmIAJLhEMkPQoGbqqF7Xdxla+SNTsnozoMxQ8GMubXaX6Ri4sYzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=goJHZ4CD;
	arc=none smtp.remote-ip=115.124.28.170
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8EE606D830;
	Tue,  3 Nov 2026 08:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC8EE606D830
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=goJHZ4CD
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793695316; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LQtgJbqMUtgTAOSiSBIZQmE3kB6GQm4rRSSxiylbZ2Y=;
	b=goJHZ4CDH/fnhmAV2iPJaj0rxe4lydyoSDjHcYdXW6UKp+cbe32Shn6iwFaQpyNJqG0NLFRcDOTg9NBrJtrIA82t9/2ofJmu2+7n60d/Q8CRak9TrOQ0t/kN/oi8ZMYDUMzq32e087j+QjZ3uZf+DNkXhTuz/B6iCLAWDAAmgto=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08949134|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00814184-0.00866965-0.983189;FP=10179339250055005936|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jvSBmFI_1793695315;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jvSBmFI_1793695315 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:41:56 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH] tpm: eventlog: check the payload size before reading tag events
Date: Tue,  3 Nov 2026 16:41:55 +0800
Message-ID: <20261103084155.426783-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
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

The EVENT_TAG branch of get_event_name() casts the event payload to
struct tcpa_pc_event and reads from it:

	pc_event = (struct tcpa_pc_event *)event_entry;

	switch (do_endian_conversion(pc_event->event_id)) {
	...
		for (i = 0; i < 20; i++)
			d_len += sprintf(&data[2*i], "%02x",
					pc_event->event_data[i]);

The log iterators only verify that the event header plus the declared
event_size stays within the log buffer; they do not require the
payload of an EVENT_TAG entry to be large enough for the fields the
branch reads. A truncated entry makes the branch read up to 20 bytes
of event_data[] past the end of the entry, and, for the last entry in
the log, past the end of the buffer itself.

Skip entries whose payload cannot even hold the event id, and skip
the 20-byte digest dump when the payload cannot hold the full
tcpa_pc_event header plus the digest, so the branch never reads
beyond the entry it is formatting.

Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
 drivers/char/tpm/eventlog/tpm1.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index 0397e3361020..f93a358a706e 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -178,6 +178,10 @@ static int get_event_name(char *dest, struct tcpa_event *event,
 		}
 		break;
 	case EVENT_TAG:
+		if (do_endian_conversion(event->event_size) <
+		    sizeof(pc_event->event_id))
+			break;
+
 		pc_event = (struct tcpa_pc_event *)event_entry;
 
 		/* ToDo Row data -> Base64 */
@@ -203,6 +207,9 @@ static int get_event_name(char *dest, struct tcpa_event *event,
 			name = tcpa_pc_event_id_strings[do_endian_conversion
 							(pc_event->event_id)];
 			n_len = strlen(name);
+			if (do_endian_conversion(event->event_size) <
+			    sizeof(struct tcpa_pc_event) + 20)
+				break;
 			for (i = 0; i < 20; i++)
 				d_len += sprintf(&data[2*i], "%02x",
 						pc_event->event_data[i]);
-- 
2.50.1


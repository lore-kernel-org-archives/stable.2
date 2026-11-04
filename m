Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791582;
	b=HpMrzUq8rKA7FMr/QOZVr+oXUlbXrmaRNifJISsbwpurwyHYIoyRxOgqYcjRUffEErZB
	 AACbuBftS0fL6GopTbRoZtUNReJVKVVGDDjfLX/NuhuydLMz+NvkHlUnhLVTpcpH6QT17
	 FrCqU156no4QDKpusCChhlA/m11V+vMl/ZQk04CNa3SAPdDOsSztaefnpFok9mNmubgxK
	 wNVJ0TtTqIYOcdYoysnwaQlDuqgkxXQssL/vw7w6pnSjJSBdT+jJZUtrwbiDh+3p33unY
	 yrzn7pdBGRb2cjhXo4xcINzPHxTYNXF72NI4lvgbRmSb1FN+SZybC3SO4tglrciogrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791582;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BRUvR8bERFluoJz7SlfIieeBNJFya8f/PQSjh5QOrdo=;
	b=rkwVFQQMNNnrGPWBNpIwYvmEw82ee1CPh4ylAkMfLLMpy+ZPJSjx+hi+BzVmosM+bO5W
	 gwUTtLGm51TKsg/k6WZahprmIqMDWtJ6ymJa8IO/M/RVUFE9oQp1jEGMwlLa2VVaF+oiG
	 YFqdVvMfpe4HaX7NZHsV6zRkOmQGZNWLc9zkyO+sxDxFOXavOTbJx2rHMsW33RNMSPgS1
	 KEO81av+8+jgXnH390QTk8XPOy2pQ7QgfLnIBrVq9DPc0GrA9BlIv96CgNmXFd9bWsEN+
	 6bLJRTD7xS3muNk+iID1lrGXFO306buISgmMll45zfmB/DKhTA8pG2If2qN16s6pfxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=HhPCNqfL;
	arc=none smtp.remote-ip=115.124.28.4
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F45606A328;
	Wed,  4 Nov 2026 11:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8F45606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=HhPCNqfL
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793791575; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BRUvR8bERFluoJz7SlfIieeBNJFya8f/PQSjh5QOrdo=;
	b=HhPCNqfL0G90FIUlb1aHPtUfMKIYyXGhAc8F1DIqqbRKmdXP2cYaHrG9yQZQXXczvd+E4pCtzKHungfWmpD4DKlTBITrwt+sfASzUxPP4HsMdshGooYU8Y10FHWJO06+x36EhsNV+Rpm8o0J+jcCeMxygga0hJj0g44aVwbeEVo=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08114079|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0805209-0.0665188-0.85296;FP=12488014602245263088|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032065030;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jwpn148_1793791574;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jwpn148_1793791574 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 19:26:15 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH v2] tpm: eventlog: check the payload size before reading tag events
Date: Wed,  4 Nov 2026 19:26:13 +0800
Message-ID: <20261104112613.58589-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ausQu4DY8WARe_2j@kernel.org>
References: <ausQu4DY8WARe_2j@kernel.org>
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

The legacy PC Client spec defines the EV_EVENT_TAG payload as a
TCPA_PC_EVENT - event_id, event_size and event-type-specific data -
so a conformant entry carries the 8-byte header and the hash-type
ids carry a full digest. The log itself, however, is an ACPI table
the firmware leaves in memory: the TPM never measures the log, so
the kernel cannot tell a conformant log from a corrupted one. The
iterators already work on that assumption - they stop once the
declared event_size runs past the buffer end - and the readers
should apply the same rule to what they take off the payload.

Skip entries whose payload cannot even hold the event id, and skip
the 20-byte digest dump when the payload cannot hold the full
tcpa_pc_event header plus the digest, so the branch never reads
beyond the entry it is formatting.

Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v2: fold the spec rationale from the list discussion into the commit
    log, per review - what the legacy PC Client spec defines for the
    tag payload, why the kernel cannot trust the log to conform, and
    how the iterators already handle it.

 drivers/char/tpm/eventlog/tpm1.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index 0397e33..f93a358 100644
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
2.43.0


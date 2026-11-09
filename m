Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229981;
	b=agUcA+FpgOQYoUgEwXKConPg9tr2zAvJ5PcpY142JUoqdJjWLxtbqOqtEbiD451OSviS
	 UvbDCpM4zkvUrnxp4ULPuV1VeN0ZoalxX1H1m34YbwpE/OvwO7V5JyJQ4x3o4LeU45i+L
	 viDhGjcB9NUm1fY48YBQozi2GdVKG2KxFwsIm5OXXJX/fvIpvPDAI3oNpV+SuF0VTit3Y
	 bGv8DUFQZQoTRog7CDafj1fwcpRYI9ZRgyOOYuY8lWZ9rUzHcTy8y87F00r3WUpw0PQxj
	 KsS3BxR3o3H4t+YlZ2nrwmFQ7h8H75DVBrChhfHUB1oNKnIENVJiFZq809Wj5uEjvHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mO+ZxTuBmnc8jJlKf0wnonLOScSpxc0ZUKDgd09SjV4=;
	b=pk4jnT2KOxpE7kIfTK+kq0jWWmdG2ClX5kYv8g+HAR8IgjyomsFgSa79hPCA8ugyUjKf
	 aaZPED5ETlZXpFSKxrrAP7va9eB4l15twhjrWVGSJARrk8qq5dFaYJerjAL5+bATwbqnW
	 SePoGxSk63FZtRSnEWiu3fwVy1u9uWviFcY0p9EE4MZzz2uMpRa+ZER71qhEmlhs6ScoG
	 bPlLRuInaZR4+I6/2+jJ7bpGg7+GTayTDhf6VLsbs6EnZx6/AGCpXq2fKxesrOcIg58OL
	 mZyZnddhF69N8vyJpJApwPrZeNOFJjyCs0UqrC6hlEItmDccMdadB3MVmR+XyxsQRFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nKqKZZ2V;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B2606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 13:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A01B2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nKqKZZ2V
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67990a45e02so764770d50.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 05:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794229979; x=1794834779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mO+ZxTuBmnc8jJlKf0wnonLOScSpxc0ZUKDgd09SjV4=;
        b=nKqKZZ2VtNpRZKOtwZpCpL+YPvDECCxCgrGBSez7I3kUEdT7DLPLGj16VmXBE82vRX
         iUCiNvRDxFD5dnjg0sbuBCQdWTMkqJ6yuH59zcBaj+F7rtA26Md11G6jsJTeaVIJkbAG
         A6AhMWn+G+ArX1J+bS8qz3Guv7iv+M3VQgpSV6I//K+QwC+g1EUeoVTtPxlqv1MeJCrA
         ZWf4wQRLLgUP7VIHV8H9cRGSyyNw6YskoMQeb9RnOW8dlwLcD3LY8DIMl1rgkysP17mw
         bm8nlX/Em6kWDo2YHjo1JDa0GOInX/ZLq2OwHrI427Envj0yuJdxF2ITDE/LWSeV6Iju
         1bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794229979; x=1794834779;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mO+ZxTuBmnc8jJlKf0wnonLOScSpxc0ZUKDgd09SjV4=;
        b=OD4C7RYSoVUUCp5EnrBs2al1JVUuGV36tjgO/nAOkFxiiHiVVVXhN9R2i/ZpaPeP+W
         /mE5kYXcwa1ugDgCyBNZL91DZOc2k3jOktn0/l0hlius5k74KyiW/mItHKYjlTgtiZpv
         /LC60HTj4tjAPzZtxtrD2/tZ+Jvq9njyjDZZobZgA0JOfa/4hk8rW7ja2QS/yr5LQAAo
         2wNas2MIRRe5EYZRsftrCXo3VBGlu5z9agczUXR7EnZnNyKSorY2iftF5evCOZBQQaE0
         Vr9VJy6cYUej74fP9CSjVxA0PHloZHgGqRLKAGwginmLXfkrn0Q9wpsmp5Q81NVGalrM
         F/+A==
X-Forwarded-Encrypted: i=1; AL+hErGC39QVKHtTUr0WAzcsl7FFAArRYlexTI9ah6rd3KAMMivc8TTDkTChKzObOgMC9YLJyVvdtZI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MigsYyFtQOsZUZgfcJeJuGIiMJ1HA79paTf3wmpTNew+AkQXw
	XEYWxb2rNvI4hwJzlIJq1AyZo0M5zlB4krxwwc1XJJr79aUmY5ezfGQU
X-Gm-Gg: AYBFou0vMhjEz6pxX579A6q8noFAt0ojKuBj3IZ5oG9Q4vWPi8texV99DGLavvUs9IK
	bsbe1RgSJtyiHFKgVF7qNKc0rFAvdCx9bWMb22apnW8zpYqCQtnCen+A5UJnLLxadiTtGGutoFS
	NjiyoC1aOsbJqqTwHu34q86uaI/E0K1D+q6/1eM2DJ5lK6mxG57ZJaJEycuPpwvr/CyBGe2a1uq
	Ld1W4kKt/1mFaRWMKa0khKBVHJ0vOAUfF+SQNh7AQ2jsbd0sjl7S3teQIPOqC2UexyU34VAgmBn
	NQsXhI6iX2xgo0vcw3+LiboleRngM5m39J7Khb+p1RaTIdpJLGrWDpAeAmhwF1GIAp7H0e75VZv
	ctNaZ/pUsMTJzTHiC7fkQFbgxN+Zu8WQgmjJgGvYlL80G0f3etzIX0LziWBUUt67uqsrB5Dt+OV
	zkF41O+K24llW5tLYbUBnIx8TLunKEGmUYU2l7Dd1zJsMLCvRGxKZ5OCmoasFbbpPbYboJDmP8S
	feupPgKOga6j5fr+/92kn9LHZFkeyMHznevAhQDOVAxgSQSKTsr/a6s0Nhgy4E8PcJqi/Eg+7yX
	3yAqboRAlrUXbqTortxSJBuulbGQD6E33fqsH5zoAkRdURFJUxlfypGc9mLhaa5ZvuBftZL6qQ=
	=
X-Received: by 2002:a05:690e:1446:b0:679:bad8:7dd0 with SMTP id 956f58d0204a3-67c3d966913mr2937912d50.27.1794229979471;
        Mon, 09 Nov 2026 05:12:59 -0800 (PST)
Received: from nb-x1-03 ([181.120.144.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c3b83e8bdsm3945927d50.1.2026.11.09.05.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:12:58 -0800 (PST)
Sender: Ciro Iriarte <ciro.iriarte@gmail.com>
From: Ciro Iriarte <ciro.iriarte+software@gmail.com>
To: "Martin K. Petersen" <mkp@kernel.org>
Cc: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] scsi: target: compare all six ISID bytes when identifying a nexus
Date: Mon, 09 Nov 2026 10:12:53 -0300
Message-ID: <591ac67a-fa1e-4395-9573-2d9405cfe0b6@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

lio_sess_get_initiator_sid() reports the ISID as twelve hex digits, and
iSCSI TransportIDs carry the same digits. __transport_register_session(),
__core_scsi3_do_alloc_registration() and
core_scsi3_alloc_aptpl_registration() turn that text into
sess_bin_isid and pr_reg_bin_isid with get_unaligned_be64(), which takes
the first eight characters, i.e. the first four ISID bytes.

open-iscsi ISIDs start with 00023d00 and differ only in the qualifier in
the last two bytes, so every session of one initiator gets the same
binary ISID. target_scsi2_reservation_check() and
target_scsi3_pr_reservation_check() then treat any session of the
reservation holder's initiator as the holder:

- after RESERVE(6) on one session, another session of the same
  initiator can still write;
- with a Write Exclusive persistent reservation, another session that
  is not registered, or registered but not the holder, can still write.

Reproduced with two open-iscsi sessions (ifaces default and if2) to a
ramdisk LUN: on v6.12.113 every command from the second session
completes with GOOD; with this patch TEST UNIT READY and WRITE(10)
under RESERVE(6), and WRITE(10) under Write Exclusive, return
RESERVATION CONFLICT, and READ(10) is still allowed.

Convert all six bytes. Text that is not exactly twelve hex digits keeps
the old conversion of its first eight characters, now copied into a
zeroed buffer so that a shorter string, such as an initiator_sid written
to res_aptpl_metadata, is not read past its end.

An all-zero ISID now converts to 0, which
target_scsi2_reservation_reserve() took to mean "no ISID". Set
DRF_SPC2_RESERVATIONS_WITH_ISID when the fabric reports ISIDs instead.
Also update the TransportID parser comment that referred to the
get_unaligned_be64() read.

Initiators that relied on the old behaviour, reserving through one
session and writing through another without registering it, will now
see RESERVATION CONFLICT, as SPC requires.

Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.1")
Cc: stable@vger.kernel.org
Signed-off-by: Ciro Iriarte <ciro.iriarte+software@gmail.com>
---
 drivers/target/target_core_fabric_lib.c |  8 +++---
 drivers/target/target_core_pr.c         | 33 ++++++++++++++++++++++---
 drivers/target/target_core_pr.h         |  1 +
 drivers/target/target_core_transport.c  |  2 +-
 4 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/target/target_core_fabric_lib.c b/drivers/target/target_core_fabric_lib.c
index ad024009d..f720fbce1 100644
--- a/drivers/target/target_core_fabric_lib.c
+++ b/drivers/target/target_core_fabric_lib.c
@@ -372,10 +372,10 @@ static bool iscsi_parse_pr_out_transport_id(
 			return false;
 		}
 		/*
-		 * The registration code reads the ISID as a C string,
-		 * and its first 8 bytes with get_unaligned_be64(), so
-		 * require 8 bytes after the separator and a NUL inside
-		 * the rest of the descriptor.
+		 * The registration code reads the ISID as a C string, so
+		 * require a NUL inside the rest of the descriptor, and at
+		 * least 8 bytes after the separator: an ISID is twelve hex
+		 * digits.
 		 */
 		if (buf + tid_len - p < 8 || !memchr(p, '\0', buf + tid_len - p)) {
 			pr_err("Incomplete or unterminated ISID in iSCSI Initiator port TransportID\n");
diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index ca1a2802a..c59032228 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -19,6 +19,7 @@
 #include <linux/fcntl.h>
 #include <linux/fs.h>
 #include <linux/fs_struct.h>
+#include <linux/hex.h>
 #include <scsi/scsi_proto.h>
 #include <linux/unaligned.h>
 
@@ -30,6 +31,28 @@
 #include "target_core_pr.h"
 #include "target_core_ua.h"
 
+/*
+ * lio_sess_get_initiator_sid() prints the six ISID bytes as twelve hex
+ * digits, and iSCSI TransportIDs carry the same digits.  Convert all six
+ * bytes: reading the first eight digits as a big-endian u64 keeps only the
+ * first four ISID bytes, so two sessions of one initiator that differ only
+ * in the qualifier, the usual case, would compare equal.  Text in any other
+ * format keeps the old conversion of its first eight characters, without
+ * reading past the end of a shorter string.
+ */
+u64 target_isid_to_bin(const char *isid)
+{
+	u8 bin[6];
+	char raw[8] = {};
+
+	if (strnlen(isid, 2 * sizeof(bin) + 1) == 2 * sizeof(bin) &&
+	    !hex2bin(bin, isid, sizeof(bin)))
+		return get_unaligned_be48(bin);
+
+	memcpy(raw, isid, strnlen(isid, sizeof(raw)));
+	return get_unaligned_be64(raw);
+}
+
 /*
  * Used for Specify Initiator Ports Capable Bit (SPEC_I_PT)
  */
@@ -285,7 +308,11 @@ target_scsi2_reservation_reserve(struct se_cmd *cmd)
 
 	dev->reservation_holder = sess;
 	dev->dev_reservation_flags |= DRF_SPC2_RESERVATIONS;
-	if (sess->sess_bin_isid != 0) {
+	/*
+	 * An all-zero ISID converts to 0, so test whether the fabric has
+	 * ISIDs rather than the value.
+	 */
+	if (tpg->se_tpg_tfo->sess_get_initiator_sid) {
 		dev->dev_res_bin_isid = sess->sess_bin_isid;
 		dev->dev_reservation_flags |= DRF_SPC2_RESERVATIONS_WITH_ISID;
 	}
@@ -674,7 +701,7 @@ static struct t10_pr_registration *__core_scsi3_do_alloc_registration(
 	 * save it to the registration now.
 	 */
 	if (isid != NULL) {
-		pr_reg->pr_reg_bin_isid = get_unaligned_be64(isid);
+		pr_reg->pr_reg_bin_isid = target_isid_to_bin(isid);
 		snprintf(pr_reg->pr_reg_isid, PR_REG_ISID_LEN, "%s", isid);
 		pr_reg->isid_present_at_reg = 1;
 	}
@@ -866,7 +893,7 @@ int core_scsi3_alloc_aptpl_registration(
 	 * SCSI Initiator Port, restore it now.
 	 */
 	if (isid != NULL) {
-		pr_reg->pr_reg_bin_isid = get_unaligned_be64(isid);
+		pr_reg->pr_reg_bin_isid = target_isid_to_bin(isid);
 		snprintf(pr_reg->pr_reg_isid, PR_REG_ISID_LEN, "%s", isid);
 		pr_reg->isid_present_at_reg = 1;
 	}
diff --git a/drivers/target/target_core_pr.h b/drivers/target/target_core_pr.h
index b793c9963..4debfe4be 100644
--- a/drivers/target/target_core_pr.h
+++ b/drivers/target/target_core_pr.h
@@ -72,6 +72,7 @@ extern void core_scsi3_free_pr_reg_from_nacl(struct se_device *,
 					     struct se_node_acl *);
 extern void core_scsi3_free_all_registrations(struct se_device *);
 extern unsigned char *core_scsi3_pr_dump_type(int);
+u64 target_isid_to_bin(const char *isid);
 
 extern sense_reason_t target_scsi3_emulate_pr_in(struct se_cmd *);
 extern sense_reason_t target_scsi3_emulate_pr_out(struct se_cmd *);
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 927861c30..4629c9343 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -419,7 +419,7 @@ void __transport_register_session(
 			memset(&buf[0], 0, PR_REG_ISID_LEN);
 			se_tpg->se_tpg_tfo->sess_get_initiator_sid(se_sess,
 					&buf[0], PR_REG_ISID_LEN);
-			se_sess->sess_bin_isid = get_unaligned_be64(&buf[0]);
+			se_sess->sess_bin_isid = target_isid_to_bin(buf);
 		}
 
 		spin_lock_irqsave(&se_nacl->nacl_sess_lock, flags);
-- 
2.55.0


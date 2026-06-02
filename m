Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F8C70836
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 03:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780370218; cv=none; b=aUh1EsUU/CwwT5YH0cDwzcIBT0LurhM36Jo/XUOg5P84ItdsJuJ+M+2VMzvWsISwcVTguzYarwKA5kZLT2i++aPLFWUpUHDQV2koALaa07hetqCIPwYS58T1Vf1v6VQs0fKhChtGLkEgPpog1fTF4PlL2RvDQj8p4bcVMEUxebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780370218; c=relaxed/simple;
	bh=cLRlkManztla3hkrQwphKDvEJLPU7dof2kesfO+g/bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AQJCzKE6iPlNoD+/HCl0Cmoiki52AHkdlfqAoYsxkRpz5tsulv1PNiBqCKbH6/VuqbS6Imk5qis63lkIGMeZEIfz/+Z188mPqi2zuLv/oCP/mI0sfIpD5U5Au1LyJDNT5wYfWINQq75Xt0pU/miiI+W0y3oVyT3d5sDbvcA4v9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hF5NBcro; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF5NBcro"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ccf0fa0aacso49168926d6.2
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 20:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780370216; x=1780975016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2rvp4uMJYJLjkVFMFUq0IQ2nbL1Lu2+k0H7Lh2NiUUU=;
        b=hF5NBcro3Bp0segdLi6nKgC8nt1tqTxB8gvDcvi11c/UA9xyW+EBPotcymZDjzfSTp
         9NYZ2qcCs8X3qVb+14o4+aSYiS7TS0LVjZT55V8sHPUyEV0Y3h5ntCXfA1uYX2j4cUpk
         OvjNyNVaA/oD/R0LYFhnjhaPkYwehvVKbBQuUxIU9wltmjPAq1g/MxFL4ka9eGWVPEcq
         XA9n3tCIKEw16NvkGjoys+lNlLpKbyeEOpyBN6HMN8skvj5Oo6AkYuqbwXY28iZt9Xwx
         uHMLnM6Q7cvGV0WOnATsQBU+dfJ+PFGxcZERq+6eYNU3XKyTA6+V7NnfeUelt7aYxk1h
         IWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370216; x=1780975016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rvp4uMJYJLjkVFMFUq0IQ2nbL1Lu2+k0H7Lh2NiUUU=;
        b=QrVbDHP8i2jk+juCpsvaKbGEaWvXBChFdvyKgZrA/Stq/nGYqUSbuBrvcanywV/Z/i
         Vr65xgM7PvIBb3H/MJwms5TQipUHA67eIU7/69dZngB/B06vWCCrupMAih3yV4ShW4C+
         SszhysBNFmSYDBx1Vtx8gvVFClJ5Qaf/fn2C2yOeM+vn3mMq07O1a6+HunvOZ9nF9zwL
         I3hP4lJzfRdVgrzsJU08VamSQUCvTcJT8Wij9TBfkOmYS2+tDFZAYZnImd5x6HfFoCSo
         cziKbHD5PDeJ8aqd/lnL/DbZLuY30H0EqXRLH4eD8HU30/4HPS7rFHC2UO7ocyi9gB8p
         fQkw==
X-Forwarded-Encrypted: i=1; AFNElJ+dQveRYEBkUOh1WqTv1mNjy9XhKxgBEWxhJzTtedsdqUIFZ1+ZNwhi/bJBHsV8RM/otAAWI0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9zR5Hidn+Eb+fO9lUdWD/U258V8mU+GYG1Xs1ZEXMpoOx6o4M
	sjMAR3ik6kUeeJW/ZAnBq71RAU/V4VAAgSnbYl4Y6us/UL+R9fG8R4Cz
X-Gm-Gg: Acq92OH9ZqioBfONxx9fUwHH9B+0BhiuxoE0EBZ03xsgoOE+SFDwu/9EoMrcFD0PKaS
	Pu34yBeHcerBSTtXG5H65Gxsmc2wqwNvCd+69cQL7vhCZwGkKa+Si/jFtn15Nn/efOgkezXrfjS
	aNs/kmxdIgirjNbL0EJ0ufE9i1iEOclQXTh5vr0p+6yBHHQWTQPfY83uOXEYdrif1va3PYiwgK3
	S8hgDwvY9igCeBEjcQWuy8ndIH5xttBZ6x4GJ1dlgkiZPD+unajC64tGdL7KkA8xJ/WjXWTsoLe
	9TkcQCd0XwS42wwDVE2H/InANlU/WdMkQsJ4OJvTdbVZGNh/iKwFMHy8TYWjUwiBaRBhfHUmlXJ
	bqB4F9ZQ0XdMmIjOqt9PPkzDRjLmd2x0gCarMFNt9gZ5I444UIIgTegQMR+4/lND3XBGHPOsHzr
	u2nindEQciFdCbXSHUhm5py0brAGck/l/xfwG0HlV0mtya2+MKLY8kVWSWlXX15xcRFVPB/Gfbv
	3XsRWOGhLT4Ffl8modN9/CaMw==
X-Received: by 2002:a05:6214:5404:b0:8bd:de6d:c340 with SMTP id 6a1803df08f44-8ccefd9355bmr243183826d6.26.1780370215578;
        Mon, 01 Jun 2026 20:16:55 -0700 (PDT)
Received: from jeremy.kali (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea231e12sm108881986d6.41.2026.06.01.20.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:16:55 -0700 (PDT)
From: Jeremy Erazo <mendozayt13@gmail.com>
To: target-devel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Christie <michael.christie@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] scsi: target: iscsi: validate ECDB AHS length
Date: Tue,  2 Jun 2026 03:16:54 +0000
Message-ID: <20260602031654.3462944-1-mendozayt13@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

iscsit_setup_scsi_cmd() processes the Extended-CDB Additional Header
Segment (AHS) of a SCSI Command PDU without bounding AHSLength,
despite the long-standing "FIXME; Add checks for AdditionalHeaderSegment"
comment a few lines above in the same function.

A SCSI Command PDU sent after iSCSI Login with hlength=1,
ahstype=ISCSI_AHSTYPE_CDB and ahslength=0 reaches:

    cdb = kmalloc(0 + 15, GFP_KERNEL);             /* 15-byte alloc  */
    memcpy(cdb, hdr->cdb, ISCSI_CDB_SIZE);         /* 16 -> 15       */
    memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb,
           be16_to_cpu(ecdb_ahdr->ahslength) - 1); /* (size_t)-1     */

On CONFIG_FORTIFY_SOURCE=y kernels the first memcpy is rejected by
__fortify_panic() because the declared destination size is 15:

    memcpy: detected buffer overflow: 16 byte write of buffer size 15
    kernel BUG at lib/string_helpers.c:1044!
    Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
    RIP: 0010:__fortify_panic+0xd/0xf
    Call Trace:
     iscsit_setup_scsi_cmd.cold+0x8c/0x224
     iscsit_get_rx_pdu+0x9ec/0x1740
     iscsi_target_rx_thread+0xf7/0x1f0
     kthread+0x1b4/0x200
    Kernel panic - not syncing: Fatal exception

On kernels without CONFIG_FORTIFY_SOURCE the first memcpy fits in the
kmalloc-16 slab object and execution reaches the second memcpy whose
size argument has wrapped to (size_t)-1.

Reproduced on Linux 7.0 with a malformed Command PDU sent after a
completed iSCSI Login.  The trigger is reachable post-Login by any
initiator that successfully logged in (anonymous on demo-mode targets,
authenticated on CHAP-protected targets).  No claim of RCE, LPE or
controlled write is made.

Validate, before any dereference and any allocation:

  - the AHS area received from the socket holds at least the 4-byte
    iscsi_ecdb_ahdr header,
  - AHSLength is at least 1 (RFC 7143 §10.2.2.3 minimum for the ECDB
    AHS, which carries one reserved byte),
  - the declared AHSLength does not exceed the AHS bytes that were
    actually received.

Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.1")
Signed-off-by: Jeremy Erazo <mendozayt13@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/target/iscsi/iscsi_target.c | 33 +++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index e80449f6c..de291eb6f 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1100,6 +1100,16 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 	cdb = hdr->cdb;
 
 	if (hdr->hlength) {
+		u16 ahslen;
+		unsigned int ahs_area_bytes = hdr->hlength * 4;
+
+		/* The AHS area must hold at least the iscsi_ecdb_ahdr
+		 * header before any of its fields may be dereferenced.
+		 */
+		if (ahs_area_bytes < sizeof(struct iscsi_ecdb_ahdr))
+			return iscsit_add_reject_cmd(cmd,
+				ISCSI_REASON_PROTOCOL_ERROR, buf);
+
 		ecdb_ahdr = (struct iscsi_ecdb_ahdr *) (hdr + 1);
 		if (ecdb_ahdr->ahstype != ISCSI_AHSTYPE_CDB) {
 			pr_err("Additional Header Segment type %d not supported!\n",
@@ -1108,14 +1118,29 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 				ISCSI_REASON_CMD_NOT_SUPPORTED, buf);
 		}
 
-		cdb = kmalloc(be16_to_cpu(ecdb_ahdr->ahslength) + 15,
-			      GFP_KERNEL);
+		/* Per RFC 7143 §10.2.2.3 AHSLength counts the bytes of
+		 * the AHS that follow the AHSType/AHSLength fields; for
+		 * the ECDB AHS it includes one reserved byte, so the
+		 * smallest legal value is 1.  Rejecting 0 prevents the
+		 * "ahslen - 1" memcpy size below from underflowing to
+		 * (size_t)-1, and ensures the kmalloc(ahslen + 15) below
+		 * is at least ISCSI_CDB_SIZE (16) so the first memcpy
+		 * does not overflow.  Also reject any AHSLength larger
+		 * than the AHS bytes that actually reached us.
+		 */
+		ahslen = be16_to_cpu(ecdb_ahdr->ahslength);
+		if (ahslen < 1 ||
+		    ahslen - 1 > ahs_area_bytes -
+				 offsetof(struct iscsi_ecdb_ahdr, ecdb))
+			return iscsit_add_reject_cmd(cmd,
+				ISCSI_REASON_PROTOCOL_ERROR, buf);
+
+		cdb = kmalloc(ahslen + 15, GFP_KERNEL);
 		if (cdb == NULL)
 			return iscsit_add_reject_cmd(cmd,
 				ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
 		memcpy(cdb, hdr->cdb, ISCSI_CDB_SIZE);
-		memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb,
-		       be16_to_cpu(ecdb_ahdr->ahslength) - 1);
+		memcpy(cdb + ISCSI_CDB_SIZE, ecdb_ahdr->ecdb, ahslen - 1);
 	}
 
 	data_direction = (hdr->flags & ISCSI_FLAG_CMD_WRITE) ? DMA_TO_DEVICE :

base-commit: a293ec25d59dd96309058c70df5a4dd0f889a1e4
-- 
2.53.0


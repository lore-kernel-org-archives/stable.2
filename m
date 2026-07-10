Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6533121F
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712000; cv=none; b=O26YLEthGkBHaPWRPaRJmV4AfRM/6CazbJHSx3ZzG0L5lT+bvpRmRCjRdmu2I7Sy22W0zZNKmh18vDIncf6iomjmObtp92g10n6xha6TG71g6kGkA631xgzoP5DtUKcKasEcpjZtMKrFCRjCZ+zAJVcCpQacChHr5nvZsILcRqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712000; c=relaxed/simple;
	bh=l6UU8TEe6v/tGIxxhz4rWfT6LTe5NVZdKP6Yb0onB+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feZ8r+VdbJx/n+7mLhgBL99WBTsgxDEntNKn/NkqOzup4/Irw+2Ua5ZEK9cIFKxaHrv8R6SgZfmmcayp+WAC3/0rPKODZ1u31Ra5lnLzs27jdz10lFzpOKIYJxn4IvWJlNKY0GimPngXwCUqFmzfFYnuK25ymF3qIKbKhftk1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YK2rBzLV; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK2rBzLV"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so125227a91.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783711998; x=1784316798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TssTRJO0fXBThfgUrtYHXO20oypHBi4O7ZKAdkQip+U=;
        b=YK2rBzLViedpVd2EbBdRPr3cHe987h89exTxft/yXtEZSgaqx+tU8DJOW+CsAzkT8s
         wrX3+D6Lve+/TU2Lj38M/oJR6K92xacbRPofi/dCInFrKihx1tblZK1b09zhU3wdT6g/
         zN8n6CqAwOKqkjGpkhozaV6pxXdjxkHcoDmUo1JyqYKcuN7G9kxEzFOzyLF7gn5bNonL
         R18Zb3hM84LZWprc9hgh6J+o+h2v5t9JK8EjE13BuTsswhPvHVWacR5TzHLIcN11CeKl
         1tXLCsr+tfdn3ayV5Z7+BGSIXSykBTysgrh7xfWIJHk9iSKIkRrEU1x3b4bVBU/rkB+u
         UT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711998; x=1784316798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TssTRJO0fXBThfgUrtYHXO20oypHBi4O7ZKAdkQip+U=;
        b=glrs+wucmVOKpKA3TNFJiDgxuZ9Z9qrSc1z985WkpY41j1jlyH2wvTffGzJY86/eAG
         83XxmwFJEBNigeVw9N0rbGnL16W10Lpnf0WCwse4eHS9wueXET1Jh4eu+sMXini09odt
         AzbX55z1rL5j9R7TwBoqowlmyzhwMLvwxrzoXOOAxMJH0KhHk3Z11wMaxcpTzWXcMGTD
         LyDp44DF2Mlxfsxc30Lvp+NruPXGkRLW/VmGye/B/MlC9CwVRNHzu70hFjx3CVYHsC4x
         W++LeZqas0Tky8X9FHquxTC8zyRhAWZObhO7G9TLTed2ejQrVfVN2Xcr7/TQli6/7w3I
         sn+A==
X-Forwarded-Encrypted: i=1; AHgh+RpRLEYzv5HeV6IcNv5qSBf0Co18G+0tpjwrktsMfTNrpvn4uaedS/RJrZ2lhQ+vqe4ni29HGS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhvTVwunRdPBkus91FG1nsQnaZmqfaeOFBydYaXvWUi+KFe1+
	k5mhKC5quak14+FNe+a7gs53gdchFOx0KhVdFVKGj+KZmQMh8JcmCD09
X-Gm-Gg: AfdE7cnL9vBLzFMq6fh8zTWalT1jDthwK9hojgS07v/me+sT3kWYc6+eMoinOdfeND4
	k9bwa7ujvhlmicVUU9sawsfxW+rSxdVBpLhJRe1UR7AFoDj+Qs0Nl1KAI3S/YEIo7F2BJeh1gAk
	8jfRlqq4bZJKFGB6DfwNlzEOEhJIE1QdH652HUVO5OX345E71Q2sySVfjCcTmKg/EVUMw4MP8vZ
	djPxM6Eu3IXbcRt2X27URzFZEkS0C1w6U/pTm09AkTHwPt2whWoYD3/qjucSzpOQv5O0oA73oTa
	nS/7jBp5MN4S4Jw8dVQquOPGI2iWDXlrBUoPLx4olQgbAbF3btREFRg84lUkGlhVOnviwIerG2/
	eGClqWtOPCp6gc/rC/+aGHbpf3QQgMWCNqFUvptHuJD1KZc9+d7Gyxh32nmKzWqGB+O5p8f2lbk
	Bo/qrsU/2VMdK1kcBcy28LuMIjQoC7k5q3GXFMuWGjXekvvjoYgnrQdIDE7YMku1QWEnjhkn215
	fXIMfkYrA0mt6is
X-Received: by 2002:a17:90b:58cc:b0:380:540:d499 with SMTP id 98e67ed59e1d1-38dc78224a5mr252693a91.6.1783711998273;
        Fri, 10 Jul 2026 12:33:18 -0700 (PDT)
Received: from localhost.localdomain (116-91-131-11.east.dxpn.ucom.ne.jp. [116.91.131.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a55b413e6sm3186273a91.8.2026.07.10.12.33.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 12:33:16 -0700 (PDT)
From: Shoichiro Miyamoto <shoichiro.miyamoto@gmail.com>
To: Steve French <sfrench@samba.org>,
	linux-cifs@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Pavel Shilovsky <piastryyy@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	linux-kernel@vger.kernel.org,
	Shoichiro Miyamoto <shoichiro.miyamoto@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] smb: client: restrict implied bcc[0] exemption to responses without data area
Date: Sat, 11 Jul 2026 04:32:02 +0900
Message-ID: <20260710193202.76314-1-shoichiro.miyamoto@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260707112358.2375494-1-shoichiro.miyamoto@gmail.com>
References: <20260707112358.2375494-1-shoichiro.miyamoto@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smb2_check_message() has a long-standing quirk that accepts a response
whose calculated length is one byte larger than the bytes actually
received ("server can return one byte more due to implied bcc[0]").
This was introduced to accommodate servers that omit the trailing bcc[0]
overlap byte when no data area is present.

However, the exemption is applied unconditionally, regardless of whether
the command actually carries a data area (has_smb2_data_area[]).  When a
response with a data area is subject to the +1 exemption, the reported
data can extend one byte beyond the bytes actually received, yet
smb2_check_message() still accepts it.  The subsequent decoder then reads
past the end of the receive buffer.  This is reachable during NEGOTIATE
and SESSION_SETUP, before the session is established.

The resulting out-of-bounds reads are visible under KASAN when mounting
against a non-conforming server; both the SPNEGO/negTokenInit and the
NTLMSSP challenge decoders are affected:

  BUG: KASAN: slab-out-of-bounds in asn1_ber_decoder+0x16a7/0x1b00
  Read of size 1 at addr ffff8880084d67c0 by task mount.cifs/81
  CPU: 1 UID: 0 PID: 81 Comm: mount.cifs Not tainted 7.1.0-rc6 #1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4e/0x70
   print_report+0x157/0x4c9
   kasan_report+0xce/0x100
   asn1_ber_decoder+0x16a7/0x1b00
   decode_negTokenInit+0x19/0x30
   SMB2_negotiate+0x31d9/0x4c90
   cifs_negotiate_protocol+0x1f2/0x3f0
   cifs_get_smb_ses+0x93f/0x17e0
   cifs_mount_get_session+0x7f/0x3a0
   cifs_mount+0xb4/0xcf0
   cifs_smb3_do_mount+0x23a/0x1500
   smb3_get_tree+0x3b0/0x630
   vfs_get_tree+0x82/0x2d0
   fc_mount+0x10/0x1b0
   path_mount+0x50d/0x1de0
   __x64_sys_mount+0x20b/0x270
   do_syscall_64+0xee/0x590
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>
  Allocated by task 85:
   kmem_cache_alloc_noprof+0x106/0x380
   mempool_alloc_noprof+0x116/0x1e0
   cifs_small_buf_get+0x31/0x80
   allocate_buffers+0x10d/0x2b0
   cifs_demultiplex_thread+0x1d5/0x1d50
   kthread+0x2c6/0x390
   ret_from_fork+0x36e/0x5a0
   ret_from_fork_asm+0x1a/0x30
  The buggy address is located 0 bytes to the right of
   allocated 448-byte region [ffff8880084d6600, ffff8880084d67c0)
   which belongs to the cache cifs_small_rq of size 448

  BUG: KASAN: slab-out-of-bounds in kmemdup_noprof+0x36/0x50
  Read of size 329 at addr ffff88800726c678 by task mount.cifs/89
  CPU: 0 UID: 0 PID: 89 Comm: mount.cifs Tainted: G    B      7.1.0-rc6 #1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4e/0x70
   print_report+0x157/0x4c9
   kasan_report+0xce/0x100
   kasan_check_range+0x10f/0x1e0
   __asan_memcpy+0x23/0x60
   kmemdup_noprof+0x36/0x50
   decode_ntlmssp_challenge+0x457/0x680
   SMB2_sess_auth_rawntlmssp_negotiate+0x6f0/0xcb0
   SMB2_sess_setup+0x219/0x4f0
   cifs_setup_session+0x248/0xaf0
   cifs_get_smb_ses+0xf79/0x17e0
   cifs_mount_get_session+0x7f/0x3a0
   cifs_mount+0xb4/0xcf0
   cifs_smb3_do_mount+0x23a/0x1500
   smb3_get_tree+0x3b0/0x630
   vfs_get_tree+0x82/0x2d0
   fc_mount+0x10/0x1b0
   path_mount+0x50d/0x1de0
   __x64_sys_mount+0x20b/0x270
   do_syscall_64+0xee/0x590
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>
  Allocated by task 93:
   kmem_cache_alloc_noprof+0x106/0x380
   mempool_alloc_noprof+0x116/0x1e0
   cifs_small_buf_get+0x31/0x80
   allocate_buffers+0x10d/0x2b0
   cifs_demultiplex_thread+0x1d5/0x1d50
   kthread+0x2c6/0x390
   ret_from_fork+0x36e/0x5a0
   ret_from_fork_asm+0x1a/0x30
  The buggy address is located 120 bytes inside of
   allocated 448-byte region [ffff88800726c600, ffff88800726c7c0)
   which belongs to the cache cifs_small_rq of size 448

Restrict the +1 exemption to responses that have no data area, so that
it still covers the bcc[0] omission it was meant for.  When a data area
is present, the +1 discrepancy instead means the reported data length
overruns the received buffer, so the response must be rejected.

Handle data area overlap separately from data presence.  Since the
existing overlap handling clears data_length, retain the overlap state
so that such responses are not treated as having no data area when
applying the +1 compatibility exemption.

Fixes: 093b2bdad322 ("CIFS: Make demultiplex_thread work with SMB2 code")
Cc: stable@vger.kernel.org
Signed-off-by: Shoichiro Miyamoto <shoichiro.miyamoto@gmail.com>
---
v5: Track data area overlap separately from data presence when evaluating
    the +1 compatibility exemption.

v4: https://lore.kernel.org/linux-cifs/20260707112358.2375494-1-shoichiro.miyamoto%40gmail.com/

v1: https://lore.kernel.org/linux-cifs/CADAuDAPSq+BUcB1SkHqkZsF364mShyE6jsaB+vk9zm=5Q+LHFw@mail.gmail.com/

 fs/smb/client/smb2misc.c | 52 +++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 2a7355ce1a07..5c1ec38a28d0 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -19,6 +19,9 @@
 #include "nterr.h"
 #include "cached_dir.h"
 
+static unsigned int __smb2_calc_size(void *buf, bool *have_data,
+				    bool *data_area_overlap);
+
 static int
 check_smb2_hdr(struct smb2_hdr *shdr, __u64 mid)
 {
@@ -145,6 +148,8 @@ smb2_check_message(char *buf, unsigned int pdu_len, unsigned int len,
 	int command;
 	__u32 calc_len; /* calculated length */
 	__u64 mid;
+	bool have_data;
+	bool data_area_overlap;
 
 	/* If server is a channel, select the primary channel */
 	pserver = SERVER_IS_CHAN(server) ? server->primary_server : server;
@@ -228,7 +233,13 @@ smb2_check_message(char *buf, unsigned int pdu_len, unsigned int len,
 		}
 	}
 
-	calc_len = smb2_calc_size(buf);
+	have_data = false;
+	data_area_overlap = false;
+	calc_len = __smb2_calc_size(buf, &have_data, &data_area_overlap);
+
+	/* Reject responses whose data area overlaps the fixed area. */
+	if (data_area_overlap)
+		return 1;
 
 	/* For SMB2_IOCTL, OutputOffset and OutputLength are optional, so might
 	 * be 0, and not a real miscalculation */
@@ -247,8 +258,13 @@ smb2_check_message(char *buf, unsigned int pdu_len, unsigned int len,
 		/* Windows 7 server returns 24 bytes more */
 		if (calc_len + 24 == len && command == SMB2_OPLOCK_BREAK_HE)
 			return 0;
-		/* server can return one byte more due to implied bcc[0] */
-		if (calc_len == len + 1)
+		/*
+		 * Server can return one byte more due to implied bcc[0].
+		 * Allow it only when there is no data area; if data_length > 0
+		 * the +1 gap indicates an overreported data length rather than
+		 * the bcc[0] omission.
+		 */
+		if (calc_len == len + 1 && !have_data)
 			return 0;
 
 		/*
@@ -407,19 +423,28 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_hdr *shdr)
 }
 
 /*
- * Calculate the size of the SMB message based on the fixed header
- * portion, the number of word parameters and the data portion of the message.
+ * Calculate the size of the SMB message based on the fixed header, fixed
+ * parameter area, and variable data area.
+ *
+ * If have_data is not NULL, it is set when a non-empty data area is found.
+ * If data_area_overlap is not NULL, it is set when the data area overlaps
+ * the fixed area.
  */
-unsigned int
-smb2_calc_size(void *buf)
+static unsigned int
+__smb2_calc_size(void *buf, bool *have_data, bool *data_area_overlap)
 {
 	struct smb2_pdu *pdu = buf;
 	struct smb2_hdr *shdr = &pdu->hdr;
 	int offset; /* the offset from the beginning of SMB to data area */
-	int data_length; /* the length of the variable length data area */
+	int data_length = 0; /* the length of the variable length data area */
 	/* Structure Size has already been checked to make sure it is 64 */
 	int len = le16_to_cpu(shdr->StructureSize);
 
+	if (have_data)
+		*have_data = false;
+	if (data_area_overlap)
+		*data_area_overlap = false;
+
 	/*
 	 * StructureSize2, ie length of fixed parameter area has already
 	 * been checked to make sure it is the correct length.
@@ -442,16 +467,27 @@ smb2_calc_size(void *buf)
 		if (offset + 1 < len) {
 			cifs_dbg(VFS, "data area offset %d overlaps SMB2 header %d\n",
 				 offset + 1, len);
+			if (data_area_overlap)
+				*data_area_overlap = true;
 			data_length = 0;
+			goto calc_size_exit;
 		} else {
 			len = offset + data_length;
 		}
 	}
 calc_size_exit:
 	cifs_dbg(FYI, "SMB2 len %d\n", len);
+	if (have_data)
+		*have_data = (data_length > 0);
 	return len;
 }
 
+unsigned int
+smb2_calc_size(void *buf)
+{
+	return __smb2_calc_size(buf, NULL, NULL);
+}
+
 /* Note: caller must free return buffer */
 __le16 *
 cifs_convert_path_to_utf16(const char *from, struct cifs_sb_info *cifs_sb)
-- 
2.50.1 (Apple Git-155)


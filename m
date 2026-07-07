Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B43AEF21
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421194; cv=none; b=WQpsq3WzMF20rs6fecyyYBnJsjQKE6cOPXLKObUtSWHTHKgvOJt800cTed1xLvCI3B9E36bB5P5e1sFpCkRdAS6D6aoQyIl0bCLrdhWiZLmG6HL3gTCDd0FNtfXsvHG3fWMbOnvFUenLyoYfVyf9qDPOjyJJWWZZuY5Gum/siFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421194; c=relaxed/simple;
	bh=Bo9oL/C2y1aYLxBhHb5rf7zJZmAXYfSvTuo+3FjKYNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZiVw1AEuyqH3QNgSaULjgNsL9FIJZBiIpNtiuS4DjwxCrkyZPXVVKGP+b9tXIRC3Ryj8tJovZSp97/zDymStZcKBkzIluABQZeOyK/XVSet1o5eM3euP4xvSQ++oN2+pjD8DG/Dw6J1945dgXqLTh7AgXC49IqDDZQeCYMKiZ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cye+qnmY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cye+qnmY"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84592b55832so3974823b3a.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783421190; x=1784025990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gnLbIBcEZuA3LS3sX2nuUnV5rtpwTIPyf21YklMdLh4=;
        b=cye+qnmY/0vvkIWQhS+wuXsbV912OtAMRGGb+UpKbv+7EUzxNzy77X504DffXu6nuW
         wsdcpNgo6HMI0Ch5HnRBnKw0d4kceRgvjLija4TV7c/lZbhFkuQabtAOPk6SmJE23POw
         P7jBwOmbj0w7BvEpbNcfugYrEtNCEqiHTRjWecfTu4CuAu0dSEIFr95M7E2BvciXl4qH
         PZWkYK3Mu1zBnl4rvC0BymAGzHs1yvRCzRYxvf6pCWYckwNFmvpjTAYmCKbdHxdC2jU0
         hZz+zqYs3s0Fg4i0vI47GMhyvCHI2EWl1QU9mVORZoexGB1WlFuvmFjnoxf2V6rVBnTK
         UWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783421190; x=1784025990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnLbIBcEZuA3LS3sX2nuUnV5rtpwTIPyf21YklMdLh4=;
        b=gXqIfFiO6gul9wSI0GuPeXrlHRpXmFVw5fwRwEb4Ef9aZqvrONETrv1We2Am4rHepC
         TYxHTkJdiij7M9XygwdNAJKhIvECBNG9beMRPy9OcfYvEMoJg2cJdkxf9Qk1l9DxBD6w
         4Vf8siWYZrP7aymiCmUkaWu8h8UxcQD2fGwt7NM7OVpS0D5WQ/vou6dPdcrk2uCDYMw5
         Ma1La64kdSiViPICGR757q8WzCzzs90IJCgw/V7/NLfee0CqWo3JGEU5INYqCIvCUxRy
         4YwRFFTE5YEuD6LH0cLEo9nQ+LtmcAlXO2NjwBXspfaEZyAcQ8W88H2GbyRT6X1Gw405
         cdfQ==
X-Gm-Message-State: AOJu0YzIrwyhQO7uaS7Enh7wD4tpA6k5DoB8Kkavz39KDAI4kZuETiFi
	ftOvj9LaOGGfdMDQYE8BaGOclNxDb0+JBp9BKC779fJKa5sWY9rEAMHLnntIovwq
X-Gm-Gg: AfdE7cmAZZWT7U94JjHxN8OsI32UzdxL7FalBGhAFTGUH5U33OkUJ/1yAfo7xpZ66u+
	mCEW+49deizw4hP+jzU8XELLS4MXmHgbZuyy+yGu2KkhiSFqmSr9aQ3oQOBaNYM24J5hMzKj7r0
	ZlAubK2A+5xKI8G0wkI17xxDp0p9HfoNOfTK5tq7R279tuUheFep93NwQx8wLKYRGF6kP9sHr7G
	9w6Z+GBDEAiSyjdZmDaxcyNqlLY1s2jL0QUGdheH3ugDjGMJ6rIwm6YlEUl4cnm2HeCyGl6nhu5
	BTPCfruvODcLlxEKLV3zwpU0frucR6KhTU7Plct6hcmGURuKTatMnoJn0NTKNkmr4zl9ZGXo5pR
	eN52wJJMCAPwRqILwr+BLjgLg07U/Ilu+Q6lKoIlIYdS2RoevyzHVqJGI9ASvIjj45BdxpWLcq3
	exFc9jXPUZo3sy7X9m3tDUjq3RO3EpCuTFb5Dn7CoFv8dJB0O8x8K0A34RRkA=
X-Received: by 2002:a05:6a00:66dc:b0:848:30fe:da34 with SMTP id d2e1a72fcca58-84830feef4dmr1551647b3a.45.1783421190080;
        Tue, 07 Jul 2026 03:46:30 -0700 (PDT)
Received: from miyamoto-pc.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d498dcsm5160031b3a.30.2026.07.07.03.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 03:46:29 -0700 (PDT)
From: Shoichiro Miyamoto <shoichiro.miyamoto@gmail.com>
To: shoichiro.miyamoto@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v4] smb: client: restrict implied bcc[0] exemption to responses without data area
Date: Tue,  7 Jul 2026 19:46:11 +0900
Message-ID: <20260707104611.2373884-1-shoichiro.miyamoto@gmail.com>
X-Mailer: git-send-email 2.52.0
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

Fixes: 093b2bdad322 ("CIFS: Make demultiplex_thread work with SMB2 code")
Cc: stable@vger.kernel.org
Signed-off-by: Shoichiro Miyamoto <shoichiro.miyamoto@gmail.com>
---
v4: no code changes.  v1-v3 were corrupted in transit by a broken mail
    setup on my end (long "@@ ... @@" hunk-context lines got re-wrapped),
    so they did not apply.  Resent with git send-email from a working
    setup.  Sorry for the noise.

    v1: https://lore.kernel.org/linux-cifs/CADAuDAPSq+BUcB1SkHqkZsF364mShyE6jsaB+vk9zm=5Q+LHFw@mail.gmail.com/

 fs/smb/client/smb2misc.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 2a7355ce1a07..6270b33147d2 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -19,6 +19,8 @@
 #include "nterr.h"
 #include "cached_dir.h"
 
+static unsigned int __smb2_calc_size(void *buf, bool *have_data);
+
 static int
 check_smb2_hdr(struct smb2_hdr *shdr, __u64 mid)
 {
@@ -145,6 +147,7 @@ smb2_check_message(char *buf, unsigned int pdu_len, unsigned int len,
 	int command;
 	__u32 calc_len; /* calculated length */
 	__u64 mid;
+	bool have_data;
 
 	/* If server is a channel, select the primary channel */
 	pserver = SERVER_IS_CHAN(server) ? server->primary_server : server;
@@ -228,7 +231,8 @@ smb2_check_message(char *buf, unsigned int pdu_len, unsigned int len,
 		}
 	}
 
-	calc_len = smb2_calc_size(buf);
+	have_data = false;
+	calc_len = __smb2_calc_size(buf, &have_data);
 
 	/* For SMB2_IOCTL, OutputOffset and OutputLength are optional, so might
 	 * be 0, and not a real miscalculation */
@@ -247,8 +251,13 @@ smb2_check_message(char *buf, unsigned int pdu_len, unsigned int len,
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
@@ -409,14 +418,17 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_hdr *shdr)
 /*
  * Calculate the size of the SMB message based on the fixed header
  * portion, the number of word parameters and the data portion of the message.
+ * If have_data is non-NULL, it is set to true when a non-empty data area was
+ * found (data_length > 0), allowing callers to distinguish the implied bcc[0]
+ * case (no data area) from an overreported data length.
  */
-unsigned int
-smb2_calc_size(void *buf)
+static unsigned int
+__smb2_calc_size(void *buf, bool *have_data)
 {
 	struct smb2_pdu *pdu = buf;
 	struct smb2_hdr *shdr = &pdu->hdr;
 	int offset; /* the offset from the beginning of SMB to data area */
-	int data_length; /* the length of the variable length data area */
+	int data_length = 0; /* the length of the variable length data area */
 	/* Structure Size has already been checked to make sure it is 64 */
 	int len = le16_to_cpu(shdr->StructureSize);
 
@@ -449,9 +461,17 @@ smb2_calc_size(void *buf)
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
+	return __smb2_calc_size(buf, NULL);
+}
+
 /* Note: caller must free return buffer */
 __le16 *
 cifs_convert_path_to_utf16(const char *from, struct cifs_sb_info *cifs_sb)
-- 
2.52.0


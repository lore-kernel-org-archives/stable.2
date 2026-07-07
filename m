Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCDF332EC8
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415943; cv=pass; b=XFAXpqZtwKQDLvWvOf9s0YkdLDVetcHlsS26cMgL+MzFpPWTmsknA0Gfyl41Z1pmLkZnHUuVlHegEcNb49dMp+SlUmy1oBIvpEbP6shXOjNeApzI5oRPZdtk39DaNejvFJSnXNN2z21B5a4a2sPFu9n/L/CvhcyaGlEEiK948yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415943; c=relaxed/simple;
	bh=pSd64mFkETPz/MmkpP145EUsLdJKzqKxGCoke+zlCKE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pm0n25sz7AKrevcjIGi2gc5/4FqV7JF0hbt438PpjPJ991xbwXcGs8B5fQ5Q9MX8t8Z/UG1nwJVYxmzECyaSMsrqi1uh4cbGfN2FWl19GrIBvfDF+c8TNBMzp0hfJMjgr/zYkYdjczXkpKtaIvyHkg5mPrxhZkHCzNQM4wio8S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjeJbs0m; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjeJbs0m"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso2816238a12.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 02:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783415941; cv=none;
        d=google.com; s=arc-20260327;
        b=hkL1yLl3Ic+GZkLZQ2/eROKv/3f1kF6FClTrd/XRqi0+U7oXz0dRSuT5rBm6FR96o3
         r8EHs90SrFc6XhutzLH9Q3hs8FjIwRxvREyQnHbJSAtnDGGw/9DQ3mcA5R5TRUL23qOS
         QHvcRQ/bmePzoy8OKr+4Xd3iZ8UOSSuikIvjX9gvYgmDHmwUzMzBXsNEdiv46iug/gtx
         Qx+BYCW9qk+3MljsIEoR3om0wleDla/hDdHuDZv9gogbnWt0jwoB6yJcT8nzGHXFTdN+
         oboc8JF6X8DUCDv+xWONZ4YDssCePu47JLoI1DmOXzEJ+D6RwG0d4IB768vFzCn0NOQE
         ivzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Mk7sCV2lRX8Z9CZB8ugodH0VtxCF5gMmq7qCUu2fuEE=;
        fh=hNzdhBOI8EKIXkmgtq1clZg4QogCRnt6Z4E/UxR19L0=;
        b=s/d/AxJDA2PaW+nxPz0PLpXDNHSFAkohDGU7MPTRxpUTPoPoUFJnRttsRjWipnRkds
         g+AQoZlCd2YQw/aYTYXuist/rqBcoLvRR6JAgt+RMe03L7QiMHeusUbOvzgcDHocNXs7
         LkQvo3Go7k+yG4heJUQ6q0GquX7UgMtTwWq70zkfO2RyMhDPUN/tgW4jmqFMQ32mecUG
         Tjcf8/8cnABBURTM6suGJ1S62oWi2Ezt8HpP1SyWC5UKS7NbpLeDx3cidAYwcBGNjTgx
         8OPmVtbO5AO1ghaV4h+0dD2f6bLpoRktU6CfZF7kx641ihqhSIbd+KtUZFz5d4H3om7O
         CLAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415941; x=1784020741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mk7sCV2lRX8Z9CZB8ugodH0VtxCF5gMmq7qCUu2fuEE=;
        b=KjeJbs0mX/SwQC2RPFpPYfRYgZYroFvbuotvbx5ettiOWFyno6u8J42MMm7KoKRJgk
         +6YW1ucpqShjmI7mGjhGtxq8Ahfol2WwOCG8lqNbAX8e3B9fRxK4BroofyVWVodDw0Y9
         msvSV15K74+oozYi6mqVVl7uEAFeeN67aFtJlaYImLI+4dwTYaToHtlgDue9ZJ5+CQjN
         2ob70DfpK/2bXagzf1mW+B0OcsGqgS4TkYxjp9/FEpMwdFECu2hrFvX0RiGtII2axvg/
         TYhoZi1z9ffbQ+EHqAoLceA//OZ93b6BmPWWIR3qHelv6//qwxdo1+qoV7e1HhZi2X0R
         kH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415941; x=1784020741;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mk7sCV2lRX8Z9CZB8ugodH0VtxCF5gMmq7qCUu2fuEE=;
        b=hmh+SUR8uIQkG6Ev1JOGxoTkJkG8ckAivMbqYUB9J50pJJJ6ob6G0B38bJIRBEZnby
         5ChNIceV/OaC06v21omHSUnfmbrmL81hEqiRTd50bjFm1f3zhWM0Kod6uT03m/NTsP5c
         GB4kXqFvNSzDymxnedjudxhpVkM1o/nD+t9uCECBoy0eyiXtCSWhfLFmSNSWywzuqUjf
         oHuRi599neep5o9YRrPjf3ysFI3JC0VfaeOdmhJ3N893SIwuwFy79kS2BhA/RYdrH9C0
         1JIzyKspJynIbX21dq+vX0bV+LPigQCqrz0ulzLgc49E8Rrda58A0bmdWyi6QuBMCMDT
         LL0A==
X-Forwarded-Encrypted: i=1; AHgh+RqEtfNGqwchw6shWi1inLhWbo+iDd2+EY4FaEM2HMqCb3X+FNG+ggOvCQE4CqAJwO/OGRGg6WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLzCg+tm3esXnOBsL/0XI2YFNKO+kf86i3YVKSJAg/7hwO9uhF
	nqBM1hm3Hsp2kexXIEribgRkH5fdvCeYZShWtxhffnrQ2Gs3QZa45uuLW2cBE9HrX3R/L4oougI
	m6dA+fIaeW/83U85sjFKCt8dVIizkebY=
X-Gm-Gg: AfdE7cmuZM8O4/jJLRI7kIYeXdgb3vfnvgSj25PEGfZMyoEEP8SDm1wTee6gy7hEI9T
	lmOqAalT7h/RPdvJIPS+L9yXy2zytbkXRfLXs+souRyL3d6a93kzsseGEqEApUrsJW/h0OSRjCu
	jxk1VLIYVc4AbWe6emQ7xVDOAndyYhX2PjUMV1DXPfHG0FEZaFGuOjt5JQckWrzFL+9y/tz0Rn8
	cjIUNQXeypikVdtSGx7rdRECBA4hW75MIZoAcYKzC/8d/YofzzuBMHeMi1wN4Xvj04g+GCaPg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a21:3987:b0:3c0:9c19:65a8 with SMTP id
 adf61e73a8af0-3c09c19675emr2371138637.64.1783415941055; Tue, 07 Jul 2026
 02:19:01 -0700 (PDT)
Received: from 1092881822491 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Jul 2026 02:18:59 -0700
Received: from 1092881822491 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Jul 2026 02:18:59 -0700
From: Shoichiro Miyamoto <shoichiro.miyamoto@gmail.com>
Date: Tue, 7 Jul 2026 02:18:59 -0700
X-Gm-Features: AVVi8CcFUPi6-5Q9lBA6uBGTYSWzDkVZQwYpWeNmDNhKSigRtRUQofRTtavL-v8
Message-ID: <CADAuDAPSq+BUcB1SkHqkZsF364mShyE6jsaB+vk9zm=5Q+LHFw@mail.gmail.com>
Subject: [PATCH] smb: client: restrict implied bcc[0] exemption to responses
 without data area
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>, Pavel Shilovsky <piastryyy@gmail.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
@@ -145,6 +147,7 @@ smb2_check_message(char *buf, unsigned int
pdu_len, unsigned int len,
 	int command;
 	__u32 calc_len; /* calculated length */
 	__u64 mid;
+	bool have_data;

 	/* If server is a channel, select the primary channel */
 	pserver = SERVER_IS_CHAN(server) ? server->primary_server : server;
@@ -228,7 +231,8 @@ smb2_check_message(char *buf, unsigned int
pdu_len, unsigned int len,
 		}
 	}

-	calc_len = smb2_calc_size(buf);
+	have_data = false;
+	calc_len = __smb2_calc_size(buf, &have_data);

 	/* For SMB2_IOCTL, OutputOffset and OutputLength are optional, so might
 	 * be 0, and not a real miscalculation */
@@ -247,8 +251,13 @@ smb2_check_message(char *buf, unsigned int
pdu_len, unsigned int len,
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
@@ -409,14 +418,17 @@ smb2_get_data_area_len(int *off, int *len,
struct smb2_hdr *shdr)
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

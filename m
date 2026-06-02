Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1F3019AA
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 23:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444613; cv=none; b=hYzeeCiRjwRLAsYthy/CzA7xIvqhhR0Q55PpdrOtwrc/g7Qb43HTfKHRqJYv/keJ/LbnJpqv2v5j2nWp3hec7balLEPticbMBAQpOJyhwXVPX90Qci/vvSDFR9vaYLd/zb1oasUJFdb4r/PwkMiubPDHblHY5keBx6E8hE49zq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444613; c=relaxed/simple;
	bh=sep4V0SjjMM5AxsPLB1KhRivWls906n1Sgx+OoHi9cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DD4Exfgag1j6U4lFNtwckSV/GrOpQdG3fsOJWD7WXs418xIbO+uoqKqGN7Da3i5izAOKvbD1CpktctMVjYfa2hmxOkUVb1mXwrJL3Rq0wcMUlkawxaL1Yw9B22DfGpg5t6fP35VZDpiihhuEv48bJjDCVO8Prr5tyLqSBt33/Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAqoM0cf; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAqoM0cf"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c858d69bde9so1601773a12.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 16:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780444611; x=1781049411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0xHIqJkwJ2SbbPlEp9EiveDRo0m8mJTT+U3xdWCxDh8=;
        b=bAqoM0cf122ph8l4Kp32OIwNngy7b8d4jMf5JnoJckgx5hjgsxEqZ2KaebsqugQwDU
         TJAYkWdg8Ba6XTGPSweaBRCPR5DJjdWjp2I+1sazzGUMtcMsuAo7h2/DRdwxYXrmmU03
         V24+YMbQsDNjdxsn1EPiZ7s3PpmPNX/idhC8cg9UHOvWT3niOJx8oAXKvWswBsri+tBW
         m/JvDcdjP7OuHxplnWq32AgKLWoDC7npleglUwNnyPHtNCqcgQN3k33uCIQmEkZLsuY0
         N+J5wS7LPCizzNM8CkFj4igNd5s8/IEk7lM9vn6iUB4S2ap6hFGTbrlTzY9tX3yQ7feZ
         Jp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444611; x=1781049411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xHIqJkwJ2SbbPlEp9EiveDRo0m8mJTT+U3xdWCxDh8=;
        b=nwVzPhX4nJU//aU1Fxg02lp5QasVFMijjvmiU/ZdmbSfhiymGVXT9N/d8QGwYu62CJ
         aDKGnJ8v6P+oP5D9J67TDE+OU/efZd9SPtTfENj9QJ7X/AC2aEEswhJ4fmVRXfD5Ej8V
         51F2S7R0WfZaIpd0UMry4bOa2HqK20Gxdh2ZkyhEcvCH/C+RzZ6+wRkbe/jLWzPVRf/W
         SQNhTDs4Wujl2U8nKZiy6YWzL1ehq5KoUdImdRrDGy8xFarVI1twC3mU33AtgwUjXcsQ
         26EvaZ5ji3aqCjOzXqrrdonbHzcNubbwCkFVbTTeMKGxfi9PHSejAphG3btrLQb3pXm3
         sZYg==
X-Forwarded-Encrypted: i=1; AFNElJ+l6Cl0Rc7PcHb8w5cUutdqeHwho/ExqHV7m5uH36HhiVpi4AsMRhKM8mJywd7uWuMtVSgLwXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Z2K21xe3LJSf4sSKaGXa+wMk7IN8KBogrNRRs7bgfNl1mHzf
	Dj1Wn5S0lFPF68oaka7W9jtA5EZJ9MsGLwubtauX05LQl0APwanAEmto
X-Gm-Gg: Acq92OGvCF5Hai2kIa01NIw0jgOvnXVAKQJ2udmpIQC5+jo4aGy+k0h08BsucproU6C
	qC1AQyeDpJQfNP7bh5bwsZSPmttqdHzdLKKg06U5u7xqjdVmQajJdhl3nsM0P5uXJPJ0x8saPHO
	+ybNCYkpn1DvFb2iMO3ReoTe2xxsR+tRArJ/wI6kMcg6GQITfvPsP0dCUqAWmDiAMatO6xMZXrj
	mk1PngyXpn3Aab0JsnxP1noKDuw1lcJDLiVSEnmQ/ECIhYxSqZovMVSkwc5yZAq/wdLLP5HF4be
	9bapv5oI2/VK5//ftPVsz33V5x5EjBTML++5Un5SdSpO8W1t3p8dco3l5od2UFrjieGHq7wJEUN
	89o+jZZd4Jfx6gqdrki55llwW+UyrsVEEI7+UwKRdpfbDPiSdRTKdj+u+LeyxwdRqeiDSkr9Qji
	UtGJPwDJRVU9MoU45aQzhko1zI2cdDAlJM3xb4/3wty3wt5iZ3eNJNZDtQI59JrDjbbSUXD8F8C
	c0=
X-Received: by 2002:a05:6a21:6906:b0:3b4:68e3:f14f with SMTP id adf61e73a8af0-3b49731f75fmr1063489637.1.1780444610458;
        Tue, 02 Jun 2026 16:56:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:807f:1ae0:c98d:5eba:43bd:375])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a63b3sm352301a12.21.2026.06.02.16.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 16:56:50 -0700 (PDT)
From: Hem Parekh <hemparekh1596@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	linux-cifs@vger.kernel.org,
	Hem Parekh <hemparekh1596@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fix out-of-bounds read in smb_check_perm_dacl()
Date: Tue,  2 Jun 2026 16:56:46 -0700
Message-ID: <20260602235646.23581-1-hemparekh1596@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The permission-check ACE walk in smb_check_perm_dacl() validates the ACE
header size and caps sid.num_subauth at SID_MAX_SUB_AUTHORITIES, but it
never checks that ace->size is actually large enough to contain
num_subauth sub-authorities before compare_sids() dereferences them.

CIFS_SID_BASE_SIZE covers the SID header up to but excluding the
sub_auth[] array, and offsetof(struct smb_ace, sid) is the ACE header,
so the existing guards only guarantee the 8-byte SID base, i.e. zero
sub-authorities. compare_sids() then reads ace->sid.sub_auth[i] for
i < min(local_sid->num_subauth, ace->sid.num_subauth). The local
comparison SIDs (sid_everyone, sid_unix_NFS_mode, and the id_to_sid()
result) always have at least one sub-authority, and an attacker controls
the ACE revision and authority bytes (which lie within the in-bounds SID
base), so they can match one of those SIDs and force the sub_auth read.

A crafted ACE with size == 16 and num_subauth >= 1 placed at the tail of
the security descriptor therefore causes a heap out-of-bounds read of up
to SID_MAX_SUB_AUTHORITIES * sizeof(__le32) bytes past the pntsd
allocation. The security descriptor is loaded by ksmbd_vfs_get_sd_xattr()
into a buffer sized exactly to the on-disk data (kzalloc(sd_size) in
ndr_decode_v4_ntacl()), so the read lands past the allocation. The
malformed descriptor can be stored verbatim via SMB2_SET_INFO (the DACL
is not normalised before being written to the security.NTACL xattr) and
the read fires on a subsequent SMB2_CREATE access check, making this
reachable by an authenticated client on a share that uses ACL xattrs.

Add the missing num_subauth-versus-ace_size check, mirroring the
identical guards already present in the sibling parsers parse_dacl() and
smb_inherit_dacl().

Fixes: d07b26f39246 ("ksmbd: require minimum ACE size in smb_check_perm_dacl()")
Cc: stable@vger.kernel.org
Signed-off-by: Hem Parekh <hemparekh1596@gmail.com>
---
 fs/smb/server/smbacl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 664b1b4a3..340ea98fa 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1477,7 +1477,9 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			break;
 		aces_size -= ace_size;
 
-		if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES)
+		if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
+		    ace_size < offsetof(struct smb_ace, sid) + CIFS_SID_BASE_SIZE +
+			      sizeof(__le32) * ace->sid.num_subauth)
 			break;
 
 		if (!compare_sids(&sid, &ace->sid) ||
-- 
2.34.1


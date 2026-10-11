Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137BF3E450D
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699549; cv=none; b=alUY7ve5+6H5ai3mOEqkI/cz/TsSysHgb96NTfB78CtxI8dfL01tydTbMicxiKn94UsbtOwV0le8wTdiTxzVhokKGYELdPYQMD1vPvdZGXC7kSTUgvJuq6r0voU4sl7FqgARJxtjrQZtcJYLMilAL90AffrrsaHuIZ7TkW3Wh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699549; c=relaxed/simple;
	bh=Syvtv5TU8G84sqxZF16vSthDh1pVvlT04GZe8z2on7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vv7hTdZhzkoEf7Yj6BeP/OWWaqjeoO+zf3yxlKStmtNHm0wrSN5GsnSKrLmW9kRKiALF/uqvMMoUfboDYXj/IfXQ4QBjqVCSVP1eZhlhqToBG64q0fyCoHXPH2JlxJaI25mlQPnvanue3Ie3ga4V7hjKs0zmHyCHVyqTy5BzFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0ra3FKk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0ra3FKk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2dd76b1361dso5094955ad.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791699547; x=1792304347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hKqO8U0N9KUIsp9WaO2HUaajoGpB7Ld3fzjtW+oaxw0=;
        b=h0ra3FKkgi1bntL3d93K0eKvQM2MwWYC4UQu9EB+4Km2asZQ0pmPW+aA6FviLqV8nc
         moFoGLC8JZSuGbAP7tH2eya8rD3me5xKVbtHKP/LXBBtYIVOSPlD4nCdvsLiETTPzQAC
         XCPEy5Sf7RnWDlKrf46AA+WedO3gVrhqEtHpxUjP4H1Hab3fy8Hc+Y83wo5Qxr+2gIfE
         bFSyzSi8kExWtPBdZacV5bSgeMXRQQ+FG/VEbCRT+Jukd7xaf10Id4LGVcnP0DX4qVJ6
         qWVD8YHV9QlFB1vGKleVovj7Vs1HCr2K/LtlshQq7jog3U/7jQvWeFv/t2deC9plsHRw
         c6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791699547; x=1792304347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hKqO8U0N9KUIsp9WaO2HUaajoGpB7Ld3fzjtW+oaxw0=;
        b=sTkRBXyqrl+szwgP7COQBkXfe7l4VFGOxHTq0zgbTKsE9USRav2dyrbEnwVVW+jNPm
         V5n/KOhndX8W6RoZoq4QXyMcCJIvzBV5DjR9Vb5bzM/3qwXVoN9zsO7pTzhgmbQOU4SB
         6XC/uf+M0ZJAnCru0QUhLXBXIpCR3SppyVajG8m/mmLGTQ5YvmduwRjgvsOBl5tuCT7/
         JpCM54srmQ4sjkV734FxHY61AJLCksxY0VM5TcoQeZxx0xcA3Q/25XkITSrlL5b+V+vC
         MgxI1PcO+Z6v1OtlkXKhKtAc1IWRP2hcmXqjPyvY+4S7vY2TS0OlDUySpEIQ7YAF01q+
         gB4Q==
X-Forwarded-Encrypted: i=1; AKwUvBx9i4IUTiJ56Nj8MoQ1myyBCpN06BZEii76aiMeIAT6k5U4s45vD3Sf6+oVJklVaNmfpDaeb8U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIzMC1tTMlogPIN0Ltv82Rn+9WiAUAGuI5Agssfuw2Wt8m3Nkz
	sCuJo1j5dgd5tLn1t1BhfQJo8ZaowSbY4tqKGon+3tHz8pQudDupxmBX
X-Gm-Gg: AYBFou1MMjPntB6ilrGHcUGOUeZi40iD3jO7UUqwuPvRkl2G+D53/zTd3GnpElHs7Ar
	HctRbxikSNVLoXojgSubgDREmIHxnz6NhgkH+4/LMjaSUWv9b2YYeLhw2gB+/oFdIgIpLm3p2cq
	uNfMZi/OhC0Z/2jpw611ReZfJR9SQHi4UJdUzAmyJ40BEjtUQpEse2CVuXC746ebc09e0IAgKLC
	Cmx1V2+k9HUzEs82jzunAbB8qqLIOv/Lb11wMxbD9ww+jeFrrSaBx2TAYV17a8kg0TYc+0LY8Xd
	nB1CUVisJi+dFv43QjD34kzcciA0VoAOmGTJhSpyu0P0UWg9RcrwuNjJMkq7F64ZaguI+bKDQTz
	tu2R5AiKR0A6PkQsB8olAU9fUi8mdg+8NchrVe671mFmWeMx4TIwhoMv4l4tRo7+7/3sH17JWmG
	4VqKg6LQiBTsoI2eI5Wb4lSj9CrWirNuBy7glZKaoE3pYsseT2IE2s5ohz022VTT0uYQojvyyn+
	A==
X-Received: by 2002:a17:90b:3c04:b0:39e:6c69:f472 with SMTP id 98e67ed59e1d1-3ab3a932622mr5820088a91.49.1791699547210;
        Sat, 10 Oct 2026 23:19:07 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45a:16c8::245:79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38dd5864sm10789409a91.8.2026.10.10.23.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:19:06 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+dc50906b100ac7a1c34d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ecryptfs: validate key payload size before using it as an auth_tok
Date: Sun, 11 Oct 2026 13:19:01 +0700
Message-ID: <20261011061902.144716-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ecryptfs_get_key_payload_data() casts the payload of a "user" or
"encrypted" key straight to struct ecryptfs_auth_tok. The payload size is
chosen by whoever added the key, so a payload shorter than the struct
makes later accesses run past the allocation. For example, a 712-byte
"user" key makes write_tag_3_packet() read the password signature beyond
the end of the kmalloc-1k object:

  BUG: KASAN: slab-out-of-bounds in ecryptfs_from_hex+0x18c/0x1d0
  Read of size 1
   write_tag_3_packet+0x145/0x1430
   ecryptfs_generate_key_packet_set+0x7ae/0x1880
   ecryptfs_write_metadata+0x590/0x930
   ecryptfs_create+0x393/0x550

Reject payloads smaller than struct ecryptfs_auth_tok with -EINVAL. The
callers already propagate errors from this helper, so mounting with such
a key now fails cleanly.

Reported-by: syzbot+dc50906b100ac7a1c34d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dc50906b100ac7a1c34d
Fixes: 237fead61998 ("[PATCH] ecryptfs: fs/Makefile and fs/Kconfig")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Notes (not for the commit log):
syzbot reports "KASAN: slab-out-of-bounds Read in ecryptfs_from_hex". The
reproducer adds a 712-byte "user" key whose description matches
ecryptfs_sig=; the mount succeeds and the first create makes
write_tag_3_packet() read the signature past the end of the kmalloc-1k
object. Tested in QEMU with syzbot's KASAN config: base kernel hits the
KASAN report, patched kernel fails the mount with -EINVAL. Fixes points at
the initial ecryptfs commit since the history here is grafted; happy to
retarget.

 fs/ecryptfs/ecryptfs_kernel.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 58165928ed1e..863761b3847a 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -88,6 +88,9 @@ ecryptfs_get_encrypted_key_payload_data(struct key *key)
 	if (!payload)
 		return ERR_PTR(-EKEYREVOKED);
 
+	if (payload->decrypted_datalen < sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
 	return (struct ecryptfs_auth_tok *)payload->payload_data;
 }
 
@@ -124,6 +127,9 @@ ecryptfs_get_key_payload_data(struct key *key)
 	if (!ukp)
 		return ERR_PTR(-EKEYREVOKED);
 
+	if (ukp->datalen < sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
 	return (struct ecryptfs_auth_tok *)ukp->data;
 }
 
-- 
2.43.0


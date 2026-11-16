Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794787543;
	b=bxwl6psRAm5Oi4fWETGgzioHCmLxA+hz1R8wen3A6MWukkkUwXEnogvl7+RLw7H9DBN5
	 GsJNIJ/Wkzp8wsrgBimatHAINdxrUbDhxrV/gUubMPhFpoefb356tcZi1jdpjn7mfnkXs
	 AQIMs7DX43eKr2NmGLwHEa+O8Z4rF74XqoBCAnZj7rais5bBSu6CU/ZevywCTgz60Mtut
	 1dB/vcOnAJNSi/QddYsGOfVe5dJzTLsqTbmf4LbPoeBdGz8zHJURkJ6yltultfYPPhb2Y
	 A3HsVaTd/NL01Qs0P8wDWsIzl9Tbn9X9mtSK92BTK0FZlblzn1jw4zELua7qtSzYZOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mu33zRxTLj/T8n79JxXB0QUEhj/+4hEOSMdZCp71jRQ=;
	b=UNOtd6cV3Gcb2Yqcwt+LZhxhfoVWj/KP2Rgs1AXj21ZwVNgRBEIobELsrNMiER0DTLT/
	 OU0sRDRY3+DsR/L3O4wJxU+DpQ3O3CEDQZDSNGdceBsdNFfLBLtLj34YyHaJ0xrS2kWhN
	 pWVSVPQ3AL32BpElVEVzrAMw/4JpH3TxZ4I7zsEA5dB8i6U0c5p463hN1kk92NHdXo/i1
	 m9czlRAeJ83j7dUFx2K3aVRLtO/gP5UqIgWxdVsf9ZfX86dOLIbV5gPtOzcpTr76DNGMI
	 G1DcRhJ99DQehi44QNkPqZiqYK6gxtB3CXMHYcodLPhvoaftBIyFPW0hN5KB1j4L82A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z3yZ+C3Q;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36CD606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 00:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B36CD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z3yZ+C3Q
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso1279906a12.3
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 16:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794787542; x=1795392342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mu33zRxTLj/T8n79JxXB0QUEhj/+4hEOSMdZCp71jRQ=;
        b=Z3yZ+C3Qk3CDPvXN1vKdfJ8BvM371EFzMjM80P1CxjYY1iRxmdMBSe6JGD5Ab8CAIQ
         ePvcKCO8Y8lM9S82GZqQNEHE+L84vMZmnHaRixdWUO185ZxDIUlOyZL2EeAA5pVlpXHA
         flaYQw/yjSLTj5w7XEnkFh30j4zBNhx7FtONBAFXbYrEv5HW0tlqqprGST8OaDN1Hxbh
         HI6PpBf12ovSbET6hFNTFbXxwjFZBpp3kfQ3M0xXkgzdBBD/mZ/VWNyiQw3KkbFF8x36
         ugx/7XK2k47KC08hdGSqbMYM3mthr7sCT214Qs5xhf1Q0sSH0NT4EyvYGR8e+ISzNWEo
         vXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794787542; x=1795392342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mu33zRxTLj/T8n79JxXB0QUEhj/+4hEOSMdZCp71jRQ=;
        b=t1FCM+J6otwo4m6vMjjdYNcgecj/62hCF4RTaSGj094MGz0PmBiJSVuXJZrq8onuo5
         c1SBg2GP4ldiluW42faMjbozC7Z9S6uZNmMpz7PnzFMr3il5sPpqPBhKF9bQdqCTTzwV
         kughtfLZyOinGuEfNcZYF6m/OzIK1e5F9qbOTLQvTIX0nnYzkMw9K1VBtBYjjihyjwq9
         VQVPGDTfRh72HdqG6nNoSW+J1vhAs7CjBDlU6wOPXaVyvYq/IzhMJAs476U2IwiBZqXy
         tf/eB9PDZRezlk3gshWU0bdCHVJwfllm1IgIke3moiDdhiSnxJdPEyIEk7l2mCJ4Lcwe
         aF4Q==
X-Forwarded-Encrypted: i=1; AL+hErFj7OTVdYhJXSbbVb8nKtqSeUnOFKN+oVMz4zTywbuSPkeMv1gszTAyv6lVL6NFyTlzTHIc5y4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/P4LF20asHpDtmon6RoRZ0sG4/ysVG3Fu/sivuCI1ba8QHWRc3
	01Fp7ll70TCmp7LooOdaQWnDbJecx8oDeYkKt0dEBup+u6PG/p7/w0TlPhF5bw==
X-Gm-Gg: AYBFou2JfPaMPAN7w7ZCj/qeV50kdoHQen4V+4X7m8evoGjTbMBt8cuqKOFqPK5Sm5O
	ujJmlotpoOkX1t5bu7gHzzrIswTiq+ZZ+K6qEtK349wjcvbQkGgZ9y/CvuiAGx09yoKM8DfH9YY
	qo1YwJ4Mkl4Zav6Y9FxZM80tZP3pAQm/MrgYLylHNVCRmGE7pB3IE1qDS33jftUHE8ftd3WzD8Z
	96fP4f1CjG5BAgkZoBMw4eH5cgkCS2foY9fZPABg/GH02WULgsmdg2jMKHT8Y/sYj3BvbKWW+8r
	aFkexUSn4+9Ku4/jV6zSRhpg31ZHUbEjPu6g4A1VRqD5MsOVBJMkCiVO76zkf5xlzYQ/PlwomPi
	9Ltwwn5cCBpY71hQcq0VRWoLxEk+YE8qNCjDYxc/SRl7lePlfgtEnlHgM4SCBDyCIt0zhNqsSLD
	zmya291o3tNc/y45kSU8tcSmQamHICeqaKIkLX7DIyZKG+KYTv8jiDEEQMWKqwFaSyaV2FZeLGC
	Pk8FY8EbATAjGmy88qPtqtH2fyk8n8Y9snYtMiMTWN0YF/4BVaXjhjwZrwdSmRSP8+7XPHCDas1
	D9rPz0oIu2OJBCI4QDKoTmPFdrKGA86EXFT+JVTFxDA+ZHzcXmUJoWIz8s1tuU1zTLBODtFuPzR
	De9/CG4Nq2/gV0TRwEjmWLGAiVsIgrDtycjvJxmJHyZTdDr8=
X-Received: by 2002:a17:90b:5585:b0:3a7:8350:3f7e with SMTP id 98e67ed59e1d1-3b1b0b88263mr8081903a91.44.1794787541921;
        Sun, 15 Nov 2026 16:05:41 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c6c9c5sm18881187a91.1.2026.11.15.16.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 16:05:40 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: don't skip the inode update for a size grown within a block
Date: Sun, 15 Nov 2026 16:05:34 -0800
Message-ID: <20261116000534.2303800-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
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

From: Daeho Jeong <daehojeong@google.com>

f2fs_skip_inode_update() lets fsync() skip writing the inode when
FI_AUTO_RECOVER is set and i_size is block aligned, relying on roll-forward
recovery to recover i_size from the position of the fsynced data block.
However, do_recover_data() extends i_size only by a block that starts at or
beyond the recovered i_size, so it cannot recover a size that grew within
the block holding the old size.

For example, on a 4KB block filesystem:

  write(fd, buf, 14KB); fsync(fd);
  write(fd, buf, 2KB);  fsync(fd);
  <sudden power-off>

  - the first fsync() writes the inode with i_size 14KB.
  - the second write() makes i_size 16KB in the same block. If it is in
    the same timestamp tick as the first one, the timestamps do not change
    and the inode is still clean, so FI_AUTO_RECOVER is set.
  - the block is already allocated, so the second fsync() updates it in
    place and writes no node. f2fs_skip_inode_update() skips the inode as
    well, since i_size is block aligned and equals last_disk_size.
  - recovery finds i_size 14KB in the inode from the first fsync() and has
    no block to extend it with, so the last 2KB is lost.

Repeating a 2KB append and fsync() up to 16KB and then shutting down the
filesystem left 117 of 1200 files with 14KB on a 4KB page kernel, and none
with this patch.

Set FI_AUTO_RECOVER only if the old i_size is block aligned, and clear it
otherwise, so that fsync() writes the inode for such a size change.

Fixes: 3a3a5ead7b6d ("f2fs: do not recover i_size if it's valid")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 50a5f845176d..b328e678d295 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3676,8 +3676,9 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 {
 	bool clean = !is_inode_flag_set(inode, FI_DIRTY_INODE);
 	bool recover = is_inode_flag_set(inode, FI_AUTO_RECOVER);
+	loff_t old_size = i_size_read(inode);
 
-	if (i_size_read(inode) == i_size)
+	if (old_size == i_size)
 		return;
 
 	i_size_write(inode, i_size);
@@ -3686,8 +3687,16 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 		return;
 
 	f2fs_mark_inode_dirty_sync(inode, true);
-	if (clean || recover)
+
+	/*
+	 * Roll-forward recovery extends i_size only by a block that starts at
+	 * or beyond the recovered i_size, so it cannot recover a size that grew
+	 * within the block holding the old size.
+	 */
+	if ((clean || recover) && !(old_size & ~PAGE_MASK))
 		set_inode_flag(inode, FI_AUTO_RECOVER);
+	else
+		clear_inode_flag(inode, FI_AUTO_RECOVER);
 }
 
 static inline void f2fs_i_depth_write(struct inode *inode, unsigned int depth)

base-commit: b9d7379d10d43386b59082da8c9a0b111e054781
-- 
2.56.0.611.g1030f0b940-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436010;
	b=o8sUSl+UWaQVKdFVyT3iIWwkBBMbrxlPCxWP3GIQbg3N9lH1ISW3eI/JznJUiDI7KMXA
	 kSAnQLrhUbyUCTe/0m/OJTfI/Uu0W+egClPQTwYFXWcfQyV7EGINe4ThnNGdsYQw+PakM
	 jtgL0y5AmWsfxp/9tE6FA42ufl6sjtqwhKFFOuak+Cl73yxPixecLFoDBqkfw1GHDj0zo
	 zjz3YKEqDArjx2qh+Yu7t1U5r3sjGVaVh8AMWLB0Zu6zLkmgbvKvHtilZlKN1CAF1eWGx
	 ou8Qgyh0AN2mUiHU6hffVC34j1+vEp91UKdGrrQvyWEjtKQJA/odIEFyfHb/y8YN0rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ga7jzUYmGDL77fNJVq4eVL8ok2xCIWbQIcFmq+e+3Uk=;
	b=HDGXIDxMEOCSW+Z7mmTKaMWvxM2AOzeeyekQC7U6byUlb936EFvTC6x83HqIv+pRp12s
	 BxU6pKAThDfEOq1KnpiuNm1CSKk32cm7gZHSIC58uDrB1Hso/tDFtnEohd56a/tmcAmCG
	 fIqdwVPZxpKYMlDm8n6b9LrjXzap02U3d3RtgJAJRBGw1i3RxorRMxxMLoFT0gH/OUGiX
	 lzZkUZcn9itf36DD6gFQf0fZo5fYJIuzTceYOKhp/h0wJEeRU5oCQBvg6O54VTadgAw9D
	 EoyjKelLMHLvwL/0SnriBpW/j2+KXr9IfR5hetWChTWNULAIbtHhb2d2ftz9eROPBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bywUqgPe;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED1606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCED1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bywUqgPe
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso38553565e9.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794436008; x=1795040808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ga7jzUYmGDL77fNJVq4eVL8ok2xCIWbQIcFmq+e+3Uk=;
        b=bywUqgPejZ8cEXqsOHexBd+3E7SGspGOsYd22CFk2rtk+C/DQDZhxK3obhUp9ZXIyd
         hHYgXckMvEeSdS7s0EvVOOQObe33dIA1inOgEGP78GhpWETBG9gNmyNqXKx7kjnKHMAy
         b2Tz1/AFs90lFd0zfJ7t6Ymd4n37pJEkM26gx+irGgH8iTwNOaZPB04XgZnvW+Z6C1g7
         XQVzhdu8CgVXUMleJwAJ8YGZ3kPv2vY/i/c601BR+pw/xwIbYcQDgTcxMXPDBp40pZDr
         zNJsxTcDTBJzhrJ+BtjQrJWvN09SXwiueeVLakL4bkR6Sk3teIrwzMk7BOKUn7PcLQhu
         V08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794436008; x=1795040808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ga7jzUYmGDL77fNJVq4eVL8ok2xCIWbQIcFmq+e+3Uk=;
        b=LKWhjOgKL1IcEiXye0XBdabtF3GKGyV+F8waQmf+P6rmfpxlY79SW4FdV+Q4bk4fJ9
         SNbRa80uTYCmag5F61I/VZbrCrfcT14IGhgjrGLmxkeim9F01tMcRV4GiqNELdqZ3Ats
         GKHo5R9QYK/Q5BagaepT64WSNOVb4PmGTtCG6p6O6OMt69IRLqKVPcyCaHsDWgLjTCS8
         V7alDuDKXRnbehXP0TxkfwVg7Gbp8mN5Wb+dXwHigAO7Rl6aa8HzJ0BzTpX8Ag8IVxmF
         aLd8dplnkP2o//b9SlXQAMk+BNWUSdIgl6mSj+c2OYZE8b7DF2PzCgnkf44rgvm6CW+g
         vpFA==
X-Forwarded-Encrypted: i=1; AL+hErEzy49YjV0qrb5IfhwRl7S/9ZAG7ZQyP8spgJJW5bCzIi93U7Ecx3PqSXZDn/zwOXMkvMgmiJ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TkrNnMMgWaNjjOItLdcRymqSDpN2mH+tcWcDkeB5waZiztMtA
	Mc48y7sMeRjO90S1fxFdwjvP3hPFavrFGZXNTMc0dr7KrhEsgyx40icV
X-Gm-Gg: AYBFou37ZJjUGysI+PWkpavMZj7f7XhhVuMF+EYgNiI366ytn1zEMHjWVXENHAWZwpD
	Artp7DWfBneVwN6HGxCJ0m3vwZ3RHanAqyWcwQ1SIuzR/GK50adFjsvOpxwFOzzuDop24+iT9f9
	au2xoSPd5DNWoXBNUaYsZIGnxMP71Tz/uVjFhq4uBpP464nYLOvz2SUkHUskPv5kGdZaUTt3V3Z
	L4xjO6VwlNwlDXHHmuUVLBaEmUxlKEVsIr86120eV9DdUNrGbk+1a78tjVhBharCaGmbvWtXp2f
	xF0rxpgEwiTKae2efDUJpmIzt/n9HplGVYWGkhNt0xmz0RAI/buu5cp6lxDa/3QKLj54MJWUJDb
	Lrb6w+pbnX4NFyBGvwcKcg8F4oyGZhN4wx+2idYP7kS2lTs5tyQaWZL8FGHUp3c3FJoWrep1E1K
	Thhq4zKu9WRffS8Hhqy9k5vFwnWdzm2m2exKrsNTr4Rk1ddXLDPvcNPekuHqioGbcFZhnq+d0T0
	BWmbha8QTCUWWEFew1Qypk1+bKklNkVPj2U/zmpnRrarbYasXm4gtBlmPg0c3FXS+Ogn3/MY5j0
	MGDGom6yxtRncMhpzZeKU3nedQ==
X-Received: by 2002:a05:600c:4f84:b0:4a1:e92b:ae4a with SMTP id 5b1f17b1804b1-4ba093b9a3cmr64193365e9.21.1794436007944;
        Wed, 11 Nov 2026 14:26:47 -0800 (PST)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e251491sm20204945e9.2.2026.11.11.14.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:26:47 -0800 (PST)
From: koraynilay <koray.fra@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fix timestamp corruption on special values
Date: Wed, 11 Nov 2026 23:25:34 +0100
Message-ID: <20261111222534.839117-1-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
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

When a timestamp is being sent with "-1" or "-2" as its value because it
should be ignored, as specified in MS-FSCC 2.4.7 FileBasicInformation,
ksmbd would clobber it in both the xattr and on-disk value by setting it
to -1.

simple reproducer:

echo test > file.txt
smbclient //127.0.0.1/test -U user%pass -c "put file.txt repro.txt"
smbclient //127.0.0.1/test -U user%pass -c "allinfo repro.txt"
smbclient //127.0.0.1/test -U user%pass -c "setmode repro.txt +h"
stat repro.txt # the actual file on disk behind smb
smbclient //127.0.0.1/test -U user%pass -c "allinfo repro.txt"

which would show, respectively:

altname: REPRO~MQ.TXT
create_time:    Wed Nov 11 21:23:16 2026 UTC
access_time:    Wed Nov 11 21:23:16 2026 UTC
write_time:     Wed Nov 11 21:23:16 2026 UTC
change_time:    Wed Nov 11 21:23:16 2026 UTC
attributes: A (20)

  File: /tmp/repro.txt
[...]
Access: 1601-01-01 00:00:00.000000000 +0000
Modify: 2026-11-11 21:58:10.145349236 +0000
Change: 2026-11-11 21:58:10.206350216 +0000
 Birth: 2026-11-11 21:58:10.144349220 +0000

altname: REPRO~MQ.TXT
create_time:    Wed Dec 31 23:59:59 1969 UTC
access_time:    Mon Jan  1 00:00:04 1601 UTC
write_time:     Wed Nov 11 21:23:16 2026 UTC
change_time:    Wed Nov 11 21:23:16 2026 UTC
attributes: HA (22)

This patch also makes the smb2.timestamps.freeze-thaw test from
smbtorture pass.

Cc: stable@vger.kernel.org
Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Link: https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-fscc/16023025-8a78-492f-8b96-c873b042ac50
Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.3
Signed-off-by: koraynilay <koray.fra@gmail.com>
---
Another small-ish fix I found while implementing ptime[1].
(And probably won't be the last one :c)

Thanks.

[1]: https://lore.kernel.org/all/20261101015551.786044-1-koray.fra@gmail.com/T/#t

 fs/smb/server/smb2pdu.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 92843d2944e4..5b046f10e2ce 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8867,6 +8867,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 	const struct mnt_idmap *idmap;
 	__le32 attrs_mask = FILE_ATTRIBUTE_DIRECTORY_LE |
 		FILE_ATTRIBUTE_COMPRESSED_LE;
+	s64 crtime, time;
 	int rc = 0;
 
 	if (!(fp->daccess & FILE_WRITE_ATTRIBUTES_LE))
@@ -8882,21 +8883,25 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 	    (file_info->Attributes & FILE_ATTRIBUTE_TEMPORARY_LE))
 		return -EINVAL;
 
-	if (file_info->CreationTime)
-		fp->create_time = le64_to_cpu(file_info->CreationTime);
+	crtime = (s64)le64_to_cpu(file_info->CreationTime);
+	if (crtime > 0)
+		fp->create_time = crtime;
 
-	if (file_info->LastAccessTime) {
+	time = (s64)le64_to_cpu(file_info->LastAccessTime);
+	if (time > 0) {
 		attrs.ia_atime = ksmbd_NTtimeToUnix(file_info->LastAccessTime);
 		attrs.ia_valid |= (ATTR_ATIME | ATTR_ATIME_SET);
 	}
 
-	if (file_info->ChangeTime) {
-		fp->change_time = le64_to_cpu(file_info->ChangeTime);
+	time = (s64)le64_to_cpu(file_info->ChangeTime);
+	if (time > 0) {
+		fp->change_time = time;
 		inode_set_ctime_to_ts(inode,
 				ksmbd_NTtimeToUnix(file_info->ChangeTime));
 	}
 
-	if (file_info->LastWriteTime) {
+	time = (s64)le64_to_cpu(file_info->LastWriteTime);
+	if (time > 0) {
 		attrs.ia_mtime = ksmbd_NTtimeToUnix(file_info->LastWriteTime);
 		attrs.ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET | ATTR_CTIME);
 	}
@@ -8915,7 +8920,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 	}
 
 	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_STORE_DOS_ATTRS) &&
-	    (file_info->CreationTime || file_info->Attributes)) {
+	    (crtime > 0 || file_info->Attributes)) {
 		struct xattr_dos_attrib da = {0};
 
 		da.version = 4;

base-commit: ffde0bdfc69a0f01a081d9c1a213e63d5719e625
-- 
2.56.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612150;
	b=lR8n6AWyx90EYxd/pIKFsuLHqPvoACbmBX8rGTUEyxAbQuDZkzRLqF5hXk4Lzl/Cir8f
	 CPg9xr111Pg6jJPugAZ7TnavD+jQvqMwIQzLqX2HLy6JDPh1TcXtktgPufvrEvWblFuwm
	 fY0LDGADxEs8N7T3GpE9dpxDPSXayN6qMdqKTa8ubstkR0UTFlPDLiJJD1WBWfI5oyV4b
	 xE2IBrcJTgrmZ+8pRiEcT75z9gtSt0RGy3+mYDaIAwIlOjGPMz0hfU7YX30piOmTX8T+E
	 IAXM/28BIgVtw9CRLXzV2NGafhYnopI7tQvgiIax2vqBA3HQvKhrPeMDO44eruJeKtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nvbS9iFrs32HLnd2NRpzXjnfEXZME1jnaetqHlPZ2Dg=;
	b=Us5xuiwiP9l477ChzZUYny95sIcgvH1vbJm3dmF/TBCGjXnG2LbCn7seD8yg6qS8JEBr
	 NAHVYfQgQLhmAVl6sNbRd9i3t8pJ5H7QWS9ohIdBtQJibtQx0Dc4Hsfjt3+ROga1NLCYo
	 OIa5PNjcHAIO0QTCWUv3NFQZVJXmsErWhK2En1T3WQkhHqmtjug+u6yQfg9nwPE2GkpIe
	 scG/X5zfOo4rtiaNPfjIpDtX1qRs0v6Rm2nW2PiwVR/cI1a4yOFWNo6XiY2T7qhdypvPR
	 HEtQk4CO48UdISD+JdvDhR0abtlOyPA6rKDHGBwNqgcx5N10BojkoAiezcjiF6jlRbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="U/BO/xBj";
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965D606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B965D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U/BO/xBj
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a06210b29fso1053166b3a.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 01:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793612149; x=1794216949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nvbS9iFrs32HLnd2NRpzXjnfEXZME1jnaetqHlPZ2Dg=;
        b=U/BO/xBjL44xI3TvofHUUDLRyHj5x3r7UKaogyLGXKB3+cA+7n6GEHfKh5XRPM2WDh
         kA4/xqdZPgAmvRqIX4RK/p41OCdjU4KM94zP0EatJd7oGP2WwvDhIdmbdG98li53TBVM
         UpTY2x35UArSlPTSTk8SLzdypo6YVp+ziC4butgH459ocIJaSNyJK+vgu6MMRKnGl9sV
         hO0CBmuLhQSOHMpXz0+NYY4LjcePr1f4zu+jR8HQVk8DiAp5cazorrGLAYkC38IRszLV
         9BwGp4wq6Prft0okT7AjZkVYSYRUggkO2Q2j2m0BlxaaWMpaf8gFSwD1YZ8H0s0LExRn
         zQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612149; x=1794216949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nvbS9iFrs32HLnd2NRpzXjnfEXZME1jnaetqHlPZ2Dg=;
        b=ZoBV4Tr3/OvKwHNSHhrk4VkOutQ4qG8Bu/FbmrMCdxUHH/gJK5OTwCw/+9KqsoEMRw
         1mcBanb+FTlFCcZUkL3uxdedhoz79Hgneq4i8+/F8P7WaWtZsnvVMM6t9L0cw39Y/zEd
         fPBAfA8O8LCiAbSqkF7Y6EBPbvQwE5bWKxvMTIm2jsBx+KuJWDonOo3NO4BUC93T3nNm
         Kn/sFp6EYjG7IcO6UDIj5rC0gnxdsuEWv6JB7XkrQerpe3e3FvUECRnuW5f6fC9xoDqs
         iDtz9GInWaTREwIMPY1535U/a0BxG45S3aOdGUWUmtieGtcIv+U/JOgr20GWgaerxyCW
         yEAw==
X-Forwarded-Encrypted: i=1; AKwUvBzr3lMpyjrZ/DNse0L4IYBmZQQ9znRlf0xU2WGbt2oKNbYCZVGbewjrZwgecCaPFMxvJy/7y4s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGD3evUa0qlK/At+wWC6hENeXurIj/l8Hl93RRCj/xAvww+Npb
	ybZ9ulo3f3og+0RLka+Wm5I2fGu2xGIFI1hdqpZqGWTWe98IDDGEypHS
X-Gm-Gg: AYBFou2DLAoJ54FvFmGf3Mx7DyjEjovMV/pKb2qq/RSVxngDYrj6QUw5qB0G5f4eaHS
	arQH43FIEmc9M8mDyk/l7yrN/sg4hWFfHHeMMzIIaXb+uNrH+aqT5OaCqIfgej37DcXNAWcioso
	AZKNNYZPwtZTHchqLA/KN7u5pDJ6nsm3Nn6hC5M647qWIvgCDcqpdQzV1WkMecvbuJVk7eY1eYk
	r0iH2I5gLWwetGhOj/jbn8kj6nqPe1E7i7xiSuy/qMXG3uaoLLnnlB9o2h1drIaaEy2bRZV2tuM
	Gky027Gqx38uy/f60d/n00yd5jKB4silDboBprulst8j1KQfCZnIa8vAlniSqOiDC1zT0ccPhR+
	7rvzt2JRf51tNppoatfC3fSL/YF7Tc+JvcGQZzYN8GvuOvpKx/Z9/jjU3F/3O4wOWP1BrVdFDGA
	dQzBZMkdopUrZdUTJ4oYJaOugnoX+NmLh1CrEkDCz9zYS3Z4B0i0AtjkJEl2kbov90mZxOs714y
	/wRVpbtO5PzOrfL13h9ok91Lr1p1colZGNpE7VRpK7DbeJ1vZgrG5PfHfPzhPba8mQnZBgYskRm
	2E9AUPpwdbAy+tJs4X9n4vmKVxwlXDl/BjGwcP1DLtegoTKqrNC4vE0HgggT7BA18yY=
X-Received: by 2002:a05:6a20:d81a:b0:3e2:3392:53e7 with SMTP id adf61e73a8af0-3e92885cfb5mr9195393637.0.1793612149040;
        Mon, 02 Nov 2026 01:35:49 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad963d6acsm1773626b3a.18.2026.11.02.01.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:35:48 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: don't allow compression on volumes with clusters larger than 4K
Date: Mon,  2 Nov 2026 17:35:43 +0800
Message-ID: <20261102093543.1199671-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

On a volume made with "mkntfs -c 8192", a user can set
FILE_ATTR_COMPRESSED on an empty file through system.ntfs_attrib.
Writing to the file and reading it back after dropping the page cache
then crashes:

  BUG: KASAN: slab-out-of-bounds in ntfs_read_compressed_block+0xa2c/0x2040
  Read of size 8192 at addr ffff88804355a000 by task dd/106

The read path only handles clusters up to 4K. It copies each cluster
out of a single page, and a compression block of 16 8K clusters does
not fit in the 64K ntfs_compression_buffer. Loading an inode already
rejects compressed data on such volumes.

Reject the flag change the same way.

Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/ntfs/ea.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index fa5c5c625751..68397b2a4e43 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -721,6 +721,11 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 		goto err_out;
 	}
 
+	if ((new_aflags & ATTR_IS_COMPRESSED) && ni->vol->cluster_size > 4096) {
+		err = -EOPNOTSUPP;
+		goto err_out;
+	}
+
 	if (!a->non_resident) {
 		if (!(new_aflags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED))) {
 			err = 0;
-- 
2.43.0


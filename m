Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883725;
	b=gKJIIGa67q6yBB1DNKHIbBgwAdTV30lftaaETBZf3vFM1ZCmyfbT/LUQWZlM+02ceJ4Y
	 QgB5GBhd812xZGtC4kaK+LWgwU7HZv7xgino4Qs5EFpWiphtUGMykmuQCho2V+Zj87f2k
	 AGdqUshQmU0WmjtYJTbYKgRoOQ7lhmJWV6odiV4HtH7jjsHB0XKzoGy3OXOnXxHgeCFFW
	 N39uxdfmoZ2xEfA9k1FLr1+wt8a2UPWbIIJC1slOgTa7kKHId4Vxz4lwZ+0h2dBMy22qV
	 EjFejN22JgOdKSoC5Pofha8LND/luZuS8vbIi1tw/uiIRPAFF6XfZx9ppslgxWj6g4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zaZo2IN21mSc8I602pjnEtUM9ME8C1zumOrQwc4EBXg=;
	b=ekiOlvxB2VfHQkmzg0h3ozIkx+Tt8abj8rj0iGPHqYtIyIQozVPdd2qTJ+qhBeLBUN8E
	 2ELuG+0RPok8ImCqAfbbutjANGIPv/fGVcLhKUNEHylZwcyovpPblxanY3S07cVa+re1v
	 qDQA+GQ7QjPX6SGJby7AQ4NpEd2Wa6p3Dr6V5WWUmn7KYyAwOeS1EbF5o38v7yMS30djT
	 yLfooH15Dr86nEDrFP62ozmnWVY/MhqZRJFDgRlsMzY3cJ0CRWWAOH5NgR8M3ro1XRDAQ
	 HQ7CNerSYHiTP8F9roPIagia86IT4IeyjG0h5WehQFyl209oVRWe28uwSaMb5VTMbjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m+tYImds;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92EC606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A92EC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m+tYImds
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so840601c88.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 05:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793883724; x=1794488524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zaZo2IN21mSc8I602pjnEtUM9ME8C1zumOrQwc4EBXg=;
        b=m+tYImdsezX20kVdwFNj0aEjTmSNl3p15jSLQYzYGLiYSGLmHOjVJ3QFR1/qtErwd1
         KZmx4nZTMvd2i384pcUvltSn7sMhP8OIoGbpw7SnAHeFOeCbcUuM68pF8gGjmN4psxZA
         bXfwga3YaiWayJWyA6OhZfyikHzg6XLlH1vYNEwNYSDDe8+mUDkiQTZL/UbyireZT+mj
         6k4toHQBztg21XSEEe9SeGKDIM7avmm4pHlPci7wLTUYOc54FKt+F9HepRfhjEBYIUTu
         XdqBKVBN2U+wfvAkukw/rjSy0PBRKWGPqInTvtyTIsvSfLondcHCDd/xXUNWpfHJCdEQ
         LNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883724; x=1794488524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zaZo2IN21mSc8I602pjnEtUM9ME8C1zumOrQwc4EBXg=;
        b=j5RvMnN1fvGaEo+p/NT9+2EKAvXvJu79kYsqjv54kgaytXQK2JMp6opJw7xbwnpI99
         j03IKMK6mctlFbf1ywAc90FrfLXekrBzcsORRLxMSsDUFJQ9Gq8neAWnW4jtz1/zZVfn
         gvMZgWhYnA+q3J3GP1K7Z+S9zpSFfFHWVILxBS9O8rsyh97IQdr12/8V3Pl8cwFBSzcJ
         +olRxUXqM3QrnodcAqbdK478MYvhxbdNLdNsf4sKc+U8Jj5VLQ0yievOyXOoRzEg/5lF
         eNl4HUL235QG5sGkpLQWjCt9DZESQLl8KsTQgssCyp7wIwZhtuB9j+gC18HWw5toQi3A
         wDCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGtt5k9rGLKA5LRIZecH+ebqSdeQvORJMvkjsDyPaT5xxzEH9x8HqZZfpSI3iGW1SyOQspk1Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/W4iciw6ht4dZj6KRG421q1Mngf3sNDoxvxxpATW6AKrhCcwik
	l+NTzZVrUtPsL80e5XHxmz0Ssmr8oXV/ZnBuyBdcCtPt7PAJw8u1j+Sf
X-Gm-Gg: AYBFou1lMp76VPkgH+smUtb8VBOTPss7TVrNtSMqtxVWQnOzM6d10BILNEppPmChn3a
	uZvogtdceKBj1BtoPwTSr+p7nWCcVez4tSGVcqgavqge/bxgM9ayc8PgSsrEdLyuiac+aPf9DIo
	WG5rlugQK+N0/r4xGdzTKFPXGMgSn/KieDw3tYutGpAkU8PeZt70aERgK1ss+7S0NCALJN9hK22
	jVB+pcfA1B1TVvxxVZXNyBC/K9957Dj2xDvjcg+4CW+q0nOIProY9/kearV0XOnirNGjczTw5JZ
	6c4FdCEEK/2oCqP7nAj5iUZVcQNs22DRuKQu310XFc3LkZjpQeOmcyVOMyv+Y7whNQtYQ1fNJJi
	Y8OoNRwcbc5SWHHbhdvcsWexYVFd8/OUYHh0u+PwA0kHozYMRxvztW8smYAK+sH6ci4DEdGlZMv
	WuSw4T3M3yfR07moT3mc1tmGWCKuomOtBM20F9DXN8NV6NebAXufHSUrgAttvfZbLf7EYAASJCr
	G8eVECtrmSM2eSzxlo24mD9KHE94KzcsdZY1vujuWwPDuNQFrs0qims0FiB+cULixE4tHcvYFhM
	Ef4/8Rh7P9yx6BP8bGTwrWXUpdI+Oa2YcedeJ/0GTBf58w==
X-Received: by 2002:a05:701b:4512:10b0:181:73fc:e53 with SMTP id a92af1059eb24-1ac5b7e21fdmr29165905c88.29.1793883723317;
        Thu, 05 Nov 2026 05:02:03 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm22945048c88.21.2026.11.05.05.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:02:02 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ntfs: don't write a compression block after a short copy
Date: Thu,  5 Nov 2026 21:01:58 +0800
Message-ID: <f385711f8772132f64462e1d6c13efadadc51bc2.1793874221.git.zhanxusheng@xiaomi.com>
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

ntfs_compress_write() does not read in the folios of a compression
block that the write covers completely. If the copy from user space
then comes up short, the rest of those folios still holds whatever
the memory held before; ntfs_write_cb() compresses that to disk and
the folios are marked uptodate.

The copy can come up short after fault_in_iov_iter_readable() has
succeeded if the source buffer is unmapped in between. On a volume
with 4K clusters, writing 64K at offset 0 of a compressed file while
another thread unmaps and remaps the last page of the buffer leaves
61440 new bytes followed by 4096 bytes of another process's freed
memory in the file. The write returns -EFAULT.

Treat a short copy into a full block like a copy that made no
progress.

Fixes: 5b676a77f3e4 ("ntfs: skip reads for full compression unit overwrites")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
Tested in QEMU on ntfs-next with KASAN, 4K clusters, page cache
dropped and freed memory filled with 'Z' before each write:

  before: 16 of 41 writes failed, 3 of them changed the file, each
          time bytes 61440-65535 read back as 0x5a
  after:  286 of 731 writes failed, none changed the file

The same loop on rootfs gives short writes and no corruption. I can
send the reproducer if it helps.

 fs/ntfs/compress.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 82c7c7d29073..287bd47282d9 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -1567,6 +1567,16 @@ int ntfs_compress_write(struct ntfs_inode *ni, loff_t pos, size_t count,
 			}
 		}
 
+		/*
+		 * The folios of a full compression block are not read in, so
+		 * after a short copy the rest of the block holds whatever the
+		 * folios contained.  Don't write that out.
+		 */
+		if (full_cb && copied < cb_size) {
+			iov_iter_revert(from, copied);
+			copied = 0;
+		}
+
 		if (!copied) {
 			err = -EFAULT;
 			goto release_pages;

base-commit: 564c7753647731d19170914c1c637d3b33d88d3b
-- 
2.43.0


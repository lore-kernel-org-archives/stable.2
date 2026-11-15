Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777009;
	b=F33klBlV++sfxPntINx2x/FjTsKgvWuut+99/uEJqiL2VwDK5BF5VmZa7PlcrhGiCQlD
	 DpKZpj79/S5fSnfBiAteHs8rFjZ+MxSofBs3g/GKUq7lo5If6fDz/ftGeuP7iHxM3uV/G
	 a9Ha6FlDhEfB9Lz1ync6PXbEThYMb8au8ivwKpYfPB4u3oad2KmKlr0YDUJpr8Fclv4dC
	 h50FeGnXCCYJ32ZwvmGG9/gbFpLOVKE1BTDzda1VZgQq8Xr7PnAOqAAnhTv7ozUhfwXlh
	 sGByivJRrA4eyQ3Rwm5IZI1jfA+KzYRJxjr/7BIjAunFjG1fNPNFBhgz4MnROD5UpdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vlAOOqvdVdKcDhX1498cVDfr4IVfu30LnqK+9Pi/SVM=;
	b=oEfuzzVdbJYffnvAdGbuGuhvqKKxVm29iFj8ILLBe0Zm9TzTuehM0F03ElfVD92okGvS
	 wQ4mxosG6GbwjBjDi3jKJrtVhkz8wG/y+mTBCrc2iFzApDGQAqpG/xKT3j7OyJjR5AV1Y
	 nnnoqaFdgyd8Irb3oZky67y1kUB0i1POcfaBgmqFjhLGXPf8UKTaZ/3BzyFNGr6VJqMeC
	 cwIHW9mQYrt30L1FrmOR5iAT7m8Yko0X2GzBKZpNUZiT1nZOvs7CrgTianFdSrsguvfaI
	 D1x9rlmLY9BJmu1HpDOLecFez5WmAYQ1WYEIjkLOSeKIL8BfRTqz3mikRBLz4FaLqrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guaYaNZk;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76E606A334
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 21:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA76E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guaYaNZk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b904d10882so1049454b3a.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 13:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794777008; x=1795381808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vlAOOqvdVdKcDhX1498cVDfr4IVfu30LnqK+9Pi/SVM=;
        b=guaYaNZk/CmHtjGyoHywjpKtBpLnajf+xotGjJMBqKnv9tJF/WAP/XxAh2lIXjql12
         v5eZ0DcJH5Vo12/N1BcnGUd4HeA1hV+JHp+X8mUYNawbcYJLEEsA21POdvcRKGYTmUfO
         vo4nRJgc9USgqxoflly8wARJdpLkqVgfZatztMQNDojWjG/c8wEitj2smbnshnN5P9mL
         k/zIvzjdRSO84V5F26gltuIoQxZfdGvPn20gPynkxO/RWCH5I3vEUKie2A8qj9jKZYQF
         ehaMi/hZTeXyKJ2eGgY29MF4JyF/AjTSgNVVIk99n6w5epG6FAe3nWuLsSFXt3Ty/FA/
         QA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794777008; x=1795381808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vlAOOqvdVdKcDhX1498cVDfr4IVfu30LnqK+9Pi/SVM=;
        b=g9plBG1QfdcGDJ2OTPvsar81hSDojkjn3Cwrx60yOpkMxIerSy6ogLDmkAPTv2e1U8
         0TbmgepWsesuYSaeJc4rh2d7Zkyda5ngv4E03R4mfZz2IRo7XP2KsRI9rTGmAHTq27m9
         Lro+cjWsiAonVjePCHCeOys+IhVC2g99nGK7wpms8SKlmfdgK9yaOLhPkOxtMqgOnC2r
         nVy1hWIJV8t61Yp/ijGHMBdG/wu4Lja2n6jxc5QJKX/suxgnzFX5BZ1L6o5w1QsnoiW/
         F4pl14YfFzvx32p0XsPOkLg82Xcb3ttnU5x/8jcLHIJEw8e0yd1YGObaDk7nlsKetmHP
         3iQg==
X-Forwarded-Encrypted: i=1; AL+hErHnJ/ga9l2UYPwv+16Qxi6KMSn2q64mXdeioA3l0GAZH4z7QfpDz/jPYj1PW+uxLPcrEmfNpVk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LHQEwHyRXQ7w5Z9S+jE+ygOk5knIK5b6PM6YS+g9iYlWiBM3v
	Ym0efDYgAfP+wKNYVbSiBISu20HlEtLeT7uwOZWe/YB6ps98y9LQEdy4
X-Gm-Gg: AYBFou1fDtuQJV6FpVS6DBBqEqcuyKpX6PPHzCrxqFEUfnElzf4WhECSIjccxcXzFQU
	w18mz2x0pmqgKbO0HBjtitxIPhfDJvHwmLL9vLPQXT6p4m7565Ou59lgBEA62Vs2lDjo05J/b47
	3hqy3AixIMtaXgdmWbUG2FNYf/0EH5FVTWhKPRb0TNyKqH6JR8+tBhH2QeJl+RPtx5pCMQwsRuP
	uNoy3m51f3sZ81T/mML0jv0bzyrl8khD1o2ArPAseZlk0+81KhEEKiQN/LoxFTgMCenLDn5jo2v
	j+e2LYvKEQX/CR0FbmQFjBId78OW4ecekXE/AxcsfMhCNPj/DIpmFpuqadwAxjwNmw/vAmKfBd8
	Q/+gf7zKosfZWAhKwmqrsgxcQ3E/Tuh4V136E3vzg49trIaEWq9w3jchtJEwd/dZnRxaaAmnLtu
	8r2AdNVzAH1dJKWMda8P6YOStbu4VeMqePLXqy2zn1XyVxa9PrWllnLc0pigcxpKhUY4gJb35mM
	FLOpNjYT/B6SKYkC3f64ZzGVZzZGZAlHVuy/t4wESU0HPTCgTAM0rDFomSF0h9qh2+HZydK/LMC
	VYzqlAPtbGECVKZeIOAvU6kljcu2+XbD/MygeWrMWFQ9APGBFQ==
X-Received: by 2002:a05:6a00:369a:b0:882:2b16:c314 with SMTP id d2e1a72fcca58-8beb7d18ac8mr8266410b3a.52.1794777008100;
        Sun, 15 Nov 2026 13:10:08 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1a6e7f5sm2892615b3a.25.2026.11.15.13.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 13:10:07 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Matt Bobrowski <matt@bobrowski.net>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] fuse: reject embedded NULs in readdir entry names
Date: Mon, 16 Nov 2026 06:09:48 +0900
Message-ID: <20261115210952.2140036-2-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
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

parse_dirfile() and parse_dirplusfile() reject '/' in dirent->name, but
do not check for embedded NUL bytes.

Unlike plain getdents() buffers covered by verify_dirent_name() in
fs/readdir.c, FUSE READDIRPLUS passes dirent->namelen directly to
QSTR_INIT() in fuse_direntplus_link() and instantiates or aliases live
dentries via d_splice_alias(). A dirent name containing an embedded NUL
produces a dentry whose d_name.len extends past the NUL terminator,
which allows callers such as inotify to copy uninitialized kernel slab
memory past the NUL byte to userspace.

Reject dirent names containing NUL alongside '/' in the FUSE readdir
parsers.

Fixes: 0b05b18381ee ("fuse: implement NFS-like readdirplus support")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
 fs/fuse/readdir.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 1f6cf565477f..e8b47c2a9103 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -126,6 +126,12 @@ static bool fuse_emit(struct file *file, struct dir_context *ctx,
 			dirent->type | FILLDIR_FLAG_NOINTR);
 }
 
+static bool fuse_invalid_dirent_name(const struct fuse_dirent *dirent)
+{
+	return memchr(dirent->name, '/', dirent->namelen) ||
+	       memchr(dirent->name, '\0', dirent->namelen);
+}
+
 static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
 			 struct dir_context *ctx)
 {
@@ -136,7 +142,7 @@ static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
 			return -EIO;
 		if (reclen > nbytes)
 			break;
-		if (memchr(dirent->name, '/', dirent->namelen) != NULL)
+		if (fuse_invalid_dirent_name(dirent))
 			return -EIO;
 
 		if (!fuse_emit(file, ctx, dirent))
@@ -307,7 +313,7 @@ static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
 			return -EIO;
 		if (reclen > nbytes)
 			break;
-		if (memchr(dirent->name, '/', dirent->namelen) != NULL)
+		if (fuse_invalid_dirent_name(dirent))
 			return -EIO;
 
 		if (!over) {
@@ -461,7 +467,7 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
 			return FOUND_ERR;
 		if (WARN_ON(reclen > nbytes))
 			return FOUND_ERR;
-		if (WARN_ON(memchr(dirent->name, '/', dirent->namelen) != NULL))
+		if (WARN_ON(fuse_invalid_dirent_name(dirent)))
 			return FOUND_ERR;
 
 		if (ff->readdir.pos == ctx->pos) {
-- 
2.43.0

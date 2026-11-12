Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482211;
	b=FWdy+g78QIk7i0YwvaufzfDWW/xVAbrAylhjlUp0+m565HpaifknLH9Jz4kZMtX0tbCw
	 /UkZFW0tpTIwNWaEo1HUI+IK+Q2W++rcOg7bKpFqX8xF+7ndIDS/ktqGO2PkiOXGnGe+T
	 YAjWaLL8B+TPbn5ZfRzTww2Q+6mKm9VSc2Cr05/YHV4eEJ6UmztBAtlvkn0ONyx3nJFGX
	 /3+kZ/vr02RUJ/4fZv0/EMWJnFIzzx6RoZaZJ2+lPZxDyaGb5TvO6qnYMz3nHOKQSV888
	 X/on+xG68dWa2lxUY4+TCxBAWc5UtyXFciO3fWlGLNwjeLy4SGGb0lZKFbLIbDu42bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LzgHZsF/GUPFeF0jr1Q/JcuDmVc0PSDFgb7N6enWNZo=;
	b=AID/sSLCSNKUf/eKsqX/3+qlwzq3RNAWjr3WgdyLL+/1ne+Eb1jNHhDDP4RqaDBFkkgt
	 wgpWcRVM3kDq3v7SumW8nt3Es47DuT4rUBCkxp8i5R/M7VVwnZyhvqARoPSMjSji+2Yt7
	 pVepsljff/j5Uab+8FWmjVJpyABuFsYrNn7tgYzG2IYLIr59x4RxFewDsZeyh9JnYH71T
	 OEJZYIy5nRXvf9giWCLfpDeZyEGQwosapBWBSEAPwt0qHw/Zr30D+WR/KoOw1PE6tFeDd
	 XKjayfnCYdUkxekMHOgTSrQmcOPEFLeDDfuhTaIjxY4ZXFto1xC53L+m/TkynDh1Siw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHQomRVw;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1763606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1763606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHQomRVw
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so36288135e9.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794482209; x=1795087009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LzgHZsF/GUPFeF0jr1Q/JcuDmVc0PSDFgb7N6enWNZo=;
        b=CHQomRVwCSPYaH/BkKwRL3qf+wWr/OEG0tXSF1x6DN2/QdB9qC1uiaehRQvGsg4lXV
         9/j04JVSUD+gsFAoIEsuvMXIdP/vDGuqDlHr5K54kcxr4AOhJU9wbLV5zMDrBcNeQzuR
         3XDTqXaBBOOdjNzCdp7P/PbyMCbawYOt5ADJkfxH1ZqQu9MpmzQgE2QSvqWnQamKxmLZ
         toDY/jycducA0YdDTex9f2Mo/dAteNB73flbr+gBk/OPA+PI3kloLCks+A1wJyMB9TEk
         aPg4EhiOcoU++hg4otgXxDKxYs+Hkb+BZrEdJeX9okLKeLemDn0dRzObnDWGinzfFrfv
         ABuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794482209; x=1795087009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LzgHZsF/GUPFeF0jr1Q/JcuDmVc0PSDFgb7N6enWNZo=;
        b=JRDTPvbO8edJt+S3qcHP0mO379g9tWW4ImZmLnqAiCip+GWEwEuIKLImO7gQ/r/4vk
         ds3IY0nV4KLjzZ8FtyjlRkpxgOExuM/hyj5ThXxWseiUUmabkNmBaJA1lQEEI8oxdu73
         z/7MjVJ50sQous5rI2PA3rfQdl2L3SDEWV3fDoqg2HF9n7Xhkk1IojjIYi3VJ6O/hpyS
         yeWraU7ybcjltgPwViO1ESnfpRSlrGTctJQJ7TndJS1M/Sa6MD0kiSTk+/tsZer/piL8
         ReKwLhAFuieu9PP8grf5fQub9ChA3HK1VG8XINBHl0ProBvs37ggrlHS4kC0bV7cIbHw
         CNrw==
X-Forwarded-Encrypted: i=1; AL+hErEOvCAZnQaBxKhpZdCXM++BC7O55I/RqT5K7SljLx3TsK0/zbab9BSLjOv2HVNqgO7BUFysoxI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pOttdOsOMZxJjNFXsbwPR8Oabe4BomA2hyj7fZP72vxAlYBCR
	IGmuM5TaVhIUrpLBLmbzU38FaRjaNqBcdY/yl0l2JobNLJKr/Ajhoeac
X-Gm-Gg: AYBFou0ZL707WIL/ccHSb1FiL+QlZ0RMEQ2egVGQVdjKsn0QG+LS2WoupgeUPFGw195
	mznrsrD/FiVfej008YzQXiQwU34Ja1iqic6IRBcjNxb//zo+kGoQPDSL/TzIu6EyD/jN2vOg8g6
	IQcG/MpnIT31YSHapT7IueULy4f4Dylsr47U8tj1tKqtr2J3ZZIutLE14ZHSMK84O9lDQeEwUP4
	yZw0dDFZy5ykxXN3/pexPaoZjSk7247c67NAkUDGXzv33kXLhho49oFNNkIudpyFH+RIiYBm3oP
	qCQ32e27WXFCxMCQNhOzvwAxztBRvGSX4niWdSlT+o01rCHSq74jJz1t+NP7JZu7LiMFOiEDHk4
	3BPvl5coXI/nJmTjwpSF82TFtZnmSxJjbPD4AfQcVaEH5nLoY83795+abm+vFBbXvvwR1jajY/H
	fF93oHuFniSB9ZmrPOgUebgJd0WZw5T6Qh5/VwAoQ3fGHLeZ1lv+6lCC99hDVC/25YmwbEdPfpP
	xdSeJk7NtysY4WBVyg+i1ugW3vyjru1JmWdhQl2yyhX/oQV+jwKEqeQ/Sv+YGF8ZubyDRALUGwp
	w7sZNphD8ib2OyoD2aKoP5nzDQ==
X-Received: by 2002:a05:600c:6994:b0:4a2:150f:1609 with SMTP id 5b1f17b1804b1-4ba09364b87mr99533965e9.8.1794482209235;
        Thu, 12 Nov 2026 03:16:49 -0800 (PST)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e267dcdsm59120225e9.11.2026.11.12.03.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:16:48 -0800 (PST)
From: koraynilay <koray.fra@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ksmbd: fix negative timestamps being saved to disk
Date: Thu, 12 Nov 2026 12:16:36 +0100
Message-ID: <20261112111637.184045-1-koray.fra@gmail.com>
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

When setting a timestamp before epoch 0, ksmbd converts it from NT
format to Unix format without normalizing it, leading to the nanoseconds
field to be saved (on-disk too) as a negative number, which leads to a
garbled stat command output and a reported +4 seconds in the timestamp.

This bug also violates a struct timespec64 invariant, as documented in
the set_normalized_timespec64() kernel-doc:
[...]
 * Note: The tv_nsec part is always in the range of 0 <= tv_nsec < NSEC_PER_SEC.
 * For negative values only the tv_sec field is negative !
 */

Reproducer, with /tmp as the local filesystem folder exported as [test]
in ksmbd.conf and /mnt as the smb folder mounted with mount -t cifs:

  mount -t cifs //127.0.0.1/test /mnt -o username=user,password=pass
  touch /mnt/test.txt
  touch -d "1969-07-20 20:17:40.123456789" /mnt/test.txt
  stat -c "Server local (/tmp):   %y" /tmp/test.txt
  stat -c "CIFS client  (/mnt):   %y" /mnt/test.txt --cached=never
  smbclient //127.0.0.1/test -U user%pass -c "allinfo test.txt"

which prints (stat output is garbled because of negative value):

  Server local (/tmp):   1969-07-20 20:17:41.()*+,--00 +0000
  CIFS client  (/mnt):   1969-07-20 20:17:45.+(/+)*/00 +0000
  altname: TESTT~K6.TXT
  [...]
  access_time:    Sun Jul 20 20:17:44 1969 UTC
  write_time:     Sun Jul 20 20:17:44 1969 UTC
  [...]

Fix this by using set_normalized_timespec64() in ksmbd_NTtimeToUnix().

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.3
Signed-off-by: koraynilay <koray.fra@gmail.com>
---
Yet another small fix I found while implementing ptime[1].
(Still not the last one :c)

Thanks.

[1]: https://lore.kernel.org/all/20261101015551.786044-1-koray.fra@gmail.com/T/#t

 fs/smb/server/misc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/smb/server/misc.c b/fs/smb/server/misc.c
index 5037f37c9226..94781246b4d6 100644
--- a/fs/smb/server/misc.c
+++ b/fs/smb/server/misc.c
@@ -336,8 +336,7 @@ struct timespec64 ksmbd_NTtimeToUnix(__le64 ntutc)
 	if (t < 0) {
 		abs_t = -t;
 		ts.tv_nsec = do_div(abs_t, 10000000) * 100;
-		ts.tv_nsec = -ts.tv_nsec;
-		ts.tv_sec = -abs_t;
+		set_normalized_timespec64(&ts, -abs_t, -ts.tv_nsec);
 	} else {
 		abs_t = t;
 		ts.tv_nsec = do_div(abs_t, 10000000) * 100;

base-commit: f4692d0e3b5e16d32d4ec7b1e0e58d7dbe74aaf4
-- 
2.56.0


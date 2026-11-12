Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482213;
	b=vjf6D9wNuD1Ux1JjqkoVF9XgQYCsl996rfj/yA7opYo+D55Yjhh6gY1Lohqw29jQz6ZS
	 5pdcp8wY7DdrcqurW/QvCjrOtNfX5m3KMTywv93r1RR039YbW4LjrtlpfqxHBQQRPndsh
	 c+Cfbmx6EeiukrOaOPQILTXDDIMIaRVVCXkEnT3CJwOjAW8BwEpC7T6vXNDgTveWaE/Xm
	 rkDILta+XX71hZRp+EVWbAukIbwVpWk6SaTGTN5G7McszrV3SHYGGUHQlX/Rfk/Zpra1k
	 Sy306pRwDuU6bpu3NOLG95HxmapURY7MXSP/c7pre5+zZFYGQPNlakdhyqzI4iDPnGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CWU2vsXjhQLUV7+EejFdv1HbsrszlavQIA5htXshp0Q=;
	b=oe+uEekQ4s50voIVFYkZ8DNLMyos4k+lG4UiOMmnfDOC4zihJu9MmzrZFwVa27A5RO7d
	 yCTUzjiR20Gj7QyRDMtLFOwvj8twdyBNkicNpGMy/PqiAEO+y0fYj6AlR/puL+7KT5GGh
	 gDgV9O7bMnc0SyzvIe+a9jEN6tBh7VPk0Jl1IJBR6MU6PjphME4A3b6jVc3iKGasoksAK
	 g6Ed+72Gkm91cqhTc073/lLDHMjZnYBMgEMRSpmFVo+XYmTbKr3NtQN1r+/dMhvokCa8L
	 If7T0scfqSzcCnVaD4WhVwaE4NuemwcGBDOOSNTuakOaVuFQfyxfCcQggAoD1HXj7Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b6Ax5ZCp;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83BC606A339
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E83BC606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b6Ax5ZCp
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b467581b98so38366335e9.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794482211; x=1795087011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWU2vsXjhQLUV7+EejFdv1HbsrszlavQIA5htXshp0Q=;
        b=b6Ax5ZCpAV4B8xdNDZ3RpEpa+f36xdvmSa51GnfoTRnLjn6WBeMPdDNgu1PTeAL1q1
         Eu+kZTi2XfCcqWV5kkVN8+//JqlJw6UhXV8cMk6TXLnQzbtI0A+Hu3p8Op3r2ykWKBtf
         /8V2Ii6fblkEkGNiE0ZoE06oMtsJSQQqt5XbhndJruw5eV/WaBSsqExMyNxlEV4Pghnl
         ckYv7TW4mxTBLFNnztBqXcwuP5whZr9hJ5kLh2qLI9qVpkQMH5Fi2yPS5it8oCZComXQ
         OYllba5gW105m428aZBrf5cL+1k+y1YJmzglU6wETkW695Va78i8Eu35yH5VPjGbWUrq
         ahsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794482211; x=1795087011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CWU2vsXjhQLUV7+EejFdv1HbsrszlavQIA5htXshp0Q=;
        b=NjBRFNs4Y3y6NGtUCKBCS1ppgH9O3NZOxb/38+h3cYYmn7X7xMnrF8KiNBwUufFT15
         F6mASoqyx30jE5Ky6a7MRu0X+3ML7Ib/SX+oAPigg6tTaDzY1A1tDaKh9UFKVTHXz/qk
         b6zFKYnB6r2MPdeLfELLPeR/zdmhSkEUHz9GPT9S1RhWezU//zuBvNf9SHaR8n5ou97M
         4BnxJCBi3cVs5gCgUFZYaf+mehQphpq+QrZktouS/P99XLzIhRzcMEWKVVijTfviGR/y
         IhXJ8mbFRG++Xjxgl2TEbNp1km1t7+Fm6OEwAwK1KBNhlJy09BHHxTRf9r5NVLebTJoO
         xuYQ==
X-Forwarded-Encrypted: i=1; AL+hErGrqRKaTAEDWH/Gvkdo/XGzBpyUlB8oVJ/es/Tk4BJ7vgeKUkWix7f6u4M6HbqtGftiaqSeL3g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xbSntYIwoXZzwZU4U+vNT6LrdPaB9Lgw4dR541+0qa6fcVBkS
	WcRSUZX+j1j/+2NzdAP96n+1wRMbFOcaTwRtY4/BIwzv5YMQKrW9g1aY
X-Gm-Gg: AYBFou3lfNun+boJNMZiWqm2TaDIw0mN6wFvda+2CXV+NZXm5K16wxtJuQCLpJheYF5
	draJwDwwLbzVSYQmMBAXDK/Yquzg+zogk3DMJJYeRnZSXMwhL15ZOyVjyHbC/JPG/6WZ3LZdZ1B
	8OfHTQIrmHFBIXb933f9d+4mtp0mxmDhxpEoKumCNl6H14mh/2Rloq6uPbxSaBws6xE6O8SCRfj
	b4ydhdbWY+bmDrUODkk0QXv8Fb8xLnLbSum893igLKTxV4AsE0hlSIlBlhpnnfCNFeyNgRqDF6C
	CUEovatKlY3wOPI+VhX/KeI2iqSPJ/39DTVbsI/QjPoNXsd7bRxPD0mj5kNfRWJEIJfEDPAtgeE
	9iJevDvnJSxsyZzo7ut4VN9DJoASctvybjdB5RSDZC+kMz30WaC9/2j9GTXwVexTHnF4eUWIXmY
	6vKP6Nh7zpJZ2EcDXCoT1G51dt/lBL4u0EcHLTE4DcvLYKPsMGIxmjWVDIGgRW30lnp4WfKVp7Z
	p7UEaSJRT9cYECY3b7HG8i7jakFSnDe5RDKMKtD6bcvvFDLP8DRpIRDzO3hP95nP32mQ1pH+RHR
	wu6DktXcypvmo14GpqxSvXiECvg+GBlEd4m9KSjTZERJCZY=
X-Received: by 2002:a05:600c:5246:b0:4a2:a9:ed5a with SMTP id 5b1f17b1804b1-4ba09381133mr96434635e9.8.1794482211259;
        Thu, 12 Nov 2026 03:16:51 -0800 (PST)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e267dcdsm59120225e9.11.2026.11.12.03.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:16:49 -0800 (PST)
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
Subject: [PATCH 2/2] cifs: fix negative timestamps being read from smb
Date: Thu, 12 Nov 2026 12:16:37 +0100
Message-ID: <20261112111637.184045-2-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112111637.184045-1-koray.fra@gmail.com>
References: <20261112111637.184045-1-koray.fra@gmail.com>
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

When reading a timestamp before epoch 0, cifs converts it from NT format
to Unix format without normalizing it, leading to the nanoseconds field
to be used as a negative number, which leads to a garbled stat command
output.

This bug also violates a struct timespec64 invariant, as documented in
the set_normalized_timespec64() kernel-doc:
[...]
 * Note: The tv_nsec part is always in the range of 0 <= tv_nsec < NSEC_PER_SEC.
 * For negative values only the tv_sec field is negative !
 */

Reproducer, with /tmp as the local filesystem folder exported as [test]
in ksmbd.conf and /mnt as the smb folder mounted with mount -t cifs:

  mount -t cifs //127.0.0.1/test /mnt -o username=user,password=pass
  touch -d "1969-07-20 20:17:40.123456789" /tmp/test.txt
  stat -c "Server local (/tmp):   %y" /tmp/test.txt
  stat -c "CIFS client  (/mnt):   %y" /mnt/test.txt --cached=never
  smbclient //127.0.0.1/test -U user%pass -c "allinfo test.txt"

which prints (stat output is garbled because of negative value):

  Server local (/tmp):   1969-07-20 20:17:40.123456789 +0000
  CIFS client  (/mnt):   1969-07-20 20:17:41.()*+,--00 +0000
  altname: TESTT~K6.TXT
  [...]
  access_time:    Sun Jul 20 20:17:40 1969 UTC
  write_time:     Sun Jul 20 20:17:40 1969 UTC
  [...]

Fix this by using set_normalized_timespec64() in cifs_NTtimeToUnix().

Fixes: 2ae83bf93882 ("[CIFS] Fix setting time before epoch (negative time values)")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.3
Signed-off-by: koraynilay <koray.fra@gmail.com>
---
Yet another small fix I found while implementing ptime[1].
(Still not the last one :c)

Thanks.

[1]: https://lore.kernel.org/all/20261101015551.786044-1-koray.fra@gmail.com/T/#t

 fs/smb/client/netmisc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/smb/client/netmisc.c b/fs/smb/client/netmisc.c
index cf737ede1ab3..033ca8f7e151 100644
--- a/fs/smb/client/netmisc.c
+++ b/fs/smb/client/netmisc.c
@@ -133,8 +133,7 @@ cifs_NTtimeToUnix(__le64 ntutc)
 	if (t < 0) {
 		abs_t = -t;
 		ts.tv_nsec = (time64_t)(do_div(abs_t, 10000000) * 100);
-		ts.tv_nsec = -ts.tv_nsec;
-		ts.tv_sec = -abs_t;
+		set_normalized_timespec64(&ts, -abs_t, -ts.tv_nsec);
 	} else {
 		abs_t = t;
 		ts.tv_nsec = (time64_t)do_div(abs_t, 10000000) * 100;

base-commit: f4692d0e3b5e16d32d4ec7b1e0e58d7dbe74aaf4
-- 
2.56.0


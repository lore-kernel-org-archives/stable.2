Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057845;
	b=uFwdMD9qMlPBmb+0HoBn1vSrIp5vDhDc9xTt3lOnva0oWxCQS6ujKy+x+SSlIj7Rai/U
	 w6NOBDHCPx5ahAjloeDzaQ9E32Psn5hM9EMCvJgusx8JDKprnRAk/0NpT8m85s0AFOQer
	 PWeUN0pjbUK0n7YDtD/j8Z7wLv02/sRLn7SksGBTBlrPvpx1ndZmJarUaWdJzPCVqH1gv
	 xqeR25U7SOzSm9cuRZmrWMlCiFmFzJannf32ACeRc7aTAKxhvwiGaFP2teTHzz73skJYm
	 vB5/SeQCMy+KoiKAFusaeYD6V3q8IWFKLf5pscJ+gnSlhdbP1kWmVO5qFqs9KeIJUsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=76T73ntXs+yFh0/soL0doyAQtKkRUjwBVbAjN35jhWg=;
	b=HYxMu/iO+79fUE6+Mx2jRsX0LNnuKI2ItakB2bXwdy51kruDBD9b2jX+EcDV+q+tjB8u
	 3uiU/hwnzMp5VwgcTRNrn7ruPfTTi1otg2D5UaFeQyOsLkideD9c5Zv4x4Ou/FPNWxoKx
	 GhyIhMSiMfOUccv+4NCaMUk5R/erK8rszAn1MxDcwDEg8wHT+oyLNI/X1lljVZ7my/H10
	 TxAumtO23ryBaXD26BqfC6aRpT9LWWHBLxTQNPIe0qGwdlTq46zCFfiqhN+ttDwaMymye
	 1VY40bKGDXtrsmBUjkVtIo95Dn6FDdRmUR0rRdzHgAeyelL4jElLmAxHofjRVu/I/pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pyIkvM1c;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936AF606A33F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 936AF606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pyIkvM1c
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-18818daa3e7so211831c88.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795057845; x=1795662645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=76T73ntXs+yFh0/soL0doyAQtKkRUjwBVbAjN35jhWg=;
        b=pyIkvM1cCQmG+tfLh9i5xgpgkf2EEA/iG1+0t5rfHPr9VHhnVsCvw06LkdiYc6qkm6
         jhXToFdHUXGWs7Qk/8WGfOVmdPfsjpKMQCfeOWNAsBl7lRR1BLIB6mQ4TWScF2g7lo+L
         Am/YgbEkLxTIqrpa+MlcT8OEEaP1LNsVHcPQUch0CwuijiXRe/KJUtYWHg/xANpWfeq6
         SyAm//DHptUkHjGS89uxMTleKeaZ1gAKc9G5S9FB3Vky709JgcxtzU0Y6ZAtC03vE47y
         4CBlwULlois6tLC+o0Y48JeaX8hmEN4xSnp4G7mThECMTQ6KBrLnYsaQU9o8Q2z/HFF5
         NfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795057845; x=1795662645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=76T73ntXs+yFh0/soL0doyAQtKkRUjwBVbAjN35jhWg=;
        b=G5jQnXBsaVINOQ4sX1CP7ywvF1Dn52P70DDFcIy/qkbXHHNB5A51I0sDs+nBIAhv1H
         wV65dr5YYjVWhihVfdgpjJsFeKnAhcIBwhK1Pmp1gJze4Noghu1RtbqEQZmL0vuVFBjo
         jTvbfk2sk6vToQ9ZSdWLr5idO5f4pqVoFV3Rz4QA8bh+oIdSpJpt6oqVl3rYwMSV1kn2
         Jzcqtq+Ebn98lX6He6IkxwWMBCm/pXH7wSOz0yPbq3lpv6wIwp4N5fRg6Ss4JWXXEIjK
         6lWIOqXMsIsE4Swrpga2qUvB2D7I8D6ASzf71krJG6LI8rXljabsf2KQocJUT2T4EJH8
         ynoQ==
X-Forwarded-Encrypted: i=1; AL+hErGAf92HGz+EoRuhNVVkkZTRLPKOcCEDEvZtrQPCIBVG1T/caTh22EbQ+2C2sSNPBytjB8UP+H4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RTA9uouLy0qzINjO/BdTHSi0KcX9hSOUbMKupXNYoTNx1YAXO
	8gYroCWzP6UkHu4ZpXrdAp1R8QFtpnXdABwjG77eXa3uTB+XVWP5nYfa
X-Gm-Gg: AYBFou26w1oThIS0l7fOeLh2iDg/OZyAvKoLpVeuvSjESrNr2zt4luZdiXz7waG1FFT
	eWuNXnVZ3i9Cedwcu7k87Cdwf288rnsF4MMHkV0KxpIaxEkGwey7YlI6376c52Zuk/5x1H88YSO
	ccY7f6UuwG47uuffyqzKPSIXN9FabOriaqZ2QMx4asWh59JlFsyZRcCgLdp6PGAPKGwU3stZJNL
	V5A7rL76fRnudEy8Ls2fPvtVtzdGyYSjKPk4uOAoaVgED9Vqk6GroEcP4LqR4m5P6v/6Pg8uSgL
	NL2nEUAEDB1HJmn5iwOutXa7C0G/xyL0ruDsrD9krzlYetKoUfzeoKHSmY5fGQPMwebs+9ZSb6q
	lOMf2v/a3uwKr43cCcKdU+h0BNhz9CdQNaKGmlZpmMOSTLKEAdu/Y2WWW0A6nG38qGpY/Do/0LR
	tNgvfdJ1NVQ8wh8HA6WLkm4UY1/UMtmzrysEahN4vXOVmPhJckG3KrJiRZkV7RnqVyb+HgQLohc
	2XJ1Jp08Cw53avabWow8OOaE3s5lN8ftatHtawC9PLTBeIai/5chwSo08pv1Ii2L546WS9FSRPq
	jDuRazlxmcQD5lER1ZUyDP3ONFtSPY4hVhWnOmyRxNaN2S0i6T8TavIewmBAbg52lMZ76AI=
X-Received: by 2002:a05:7022:e886:b0:185:6c8c:d860 with SMTP id a92af1059eb24-1b54e8894eamr777303c88.5.1795057844676;
        Wed, 18 Nov 2026 19:10:44 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447f4e19sm15028118c88.13.2026.11.18.19.10.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 19:10:44 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: Ding Feng <dingf3ng@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun-ichi Takimoto <takimoto-j@kba.biglobe.ne.jp>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] fs: ignore RLIMIT_FSIZE above LLONG_MAX in generic_write_check_limits()
Date: Thu, 19 Nov 2026 11:10:25 +0800
Message-ID: <20261119031026.7985-2-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119031026.7985-1-dingf3ng@gmail.com>
References: <20261119031026.7985-1-dingf3ng@gmail.com>
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

generic_write_check_limits() stores rlimit(RLIMIT_FSIZE), an unsigned
long, in a loff_t. A soft limit between 2^63 and RLIM_INFINITY becomes
negative there, so "pos >= limit" holds for every position: each write
through generic_write_checks() or copy_file_range() fails with -EFBIG
and raises SIGXFSZ, although no file position can reach such a limit.

Reproducer (bash counts ulimit -f in 1024-byte blocks, so 2^53 blocks
is 2^63 bytes):

  $ bash -c 'ulimit -f 9007199254740991; echo hi > /tmp/f'; echo $?
  0
  $ bash -c 'ulimit -f 9007199254740992; echo hi > /tmp/f'; echo $?
  File size limit exceeded
  153

Before commit 9fd91a90cb98 ("vfs: strengthen checking of file range
inputs to generic_remap_checks") the limit was an unsigned long in
generic_write_checks(), and such limits had no effect.

Keep the limit unsigned and apply it only when it is at most LLONG_MAX.
Smaller limits keep the existing loff_t arithmetic, so their behaviour,
including for negative positions, is unchanged.

Fixes: 9fd91a90cb98 ("vfs: strengthen checking of file range inputs to generic_remap_checks")
Reported-by: Jun-ichi Takimoto <takimoto-j@kba.biglobe.ne.jp>
Closes: https://lore.kernel.org/linux-fsdevel/8F9EB913-3AC3-4D89-9DA3-427029F6D211@kba.biglobe.ne.jp/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5 Frama-C
Signed-off-by: Ding Feng <dingf3ng@gmail.com>
---

Notes:
    v2: hold the limit in a u64. As an unsigned long, "limit <= LLONG_MAX" is
    always true on 32-bit, and clang W=1 warns (kernel test robot, Damien).
    v1 was applied to vfs-7.5.misc as bc0dc4379463; this version replaces it.

 fs/read_write.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index b15522c..9786dfc 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1693,14 +1693,15 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 {
 	struct inode *inode = file->f_mapping->host;
 	loff_t max_size = inode->i_sb->s_maxbytes;
-	loff_t limit = rlimit(RLIMIT_FSIZE);
+	u64 limit = rlimit(RLIMIT_FSIZE);
 
-	if (limit != RLIM_INFINITY) {
-		if (pos >= limit) {
+	/* No file position reaches a limit above LLONG_MAX. */
+	if (limit != RLIM_INFINITY && limit <= LLONG_MAX) {
+		if (pos >= (loff_t)limit) {
 			send_sig(SIGXFSZ, current, 0);
 			return -EFBIG;
 		}
-		*count = min(*count, limit - pos);
+		*count = min(*count, (loff_t)limit - pos);
 	}
 
 	if (!(file->f_flags & O_LARGEFILE))
-- 
2.55.0


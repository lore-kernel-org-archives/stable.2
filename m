Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900564;
	b=0007iJWbCzrbE2ugBHxX8OgT/m7m3OLtjc5cTjzh8YnPrdr1ouQ2Ia2Mt5b+yopzz6xF
	 XaKtUnwzuoCeH0YnbiXGpez44L1VSuhQRcqCqrCNkUbPe3pkMveOoDy2mgqJ7FgCGTNAB
	 RyTSaZ4Y0N1xs6c+SLil7xijcGM0LpORABcc/Y7wS17X4RCqBxbtj694cVpM/qQchF8zK
	 dDBCyN0ZYYtq480dnJLROuU+z/PQUVQ2CwO1ZTBn6fU5bWQ9evRTCqGUSlsSOH1xEM6qk
	 OISu1BBd4sCpxi7+1L0v9ZzICZgWmPuIM7lNeVjjdY7sLZvIEkVy9EINmCxhWTOulBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lkKAejhpVXm9seL1ehybdpNol6UMeDxsIrY79fbHsys=;
	b=5RnMl3xNKGmh3xSZjID1UKb7doi3woPAh1zrHJjsWX/x0oZDrRZRdbgv/cS5sGlB5rFG
	 G9mTEjYElVqNpSPE3H1BHNkSUAMU0pF2xj/5LjK5/eTy4m8HqoYRT/oB+HYjEBnhnn61y
	 I5oxT/AbOIRDfrd58Yx1ZdsITp/LHtq2FIDHyPaHMxAf5POJd7LvET+c2rJhnqPi9XVtm
	 AlV/EGlk3d/Q+y9aMaUKIqaEvTUBeQQtcGl/RFbpCjm+DKw/q93UohRGxBv4y8+G8a8vh
	 MAU24zUHVuytYwEgdOFglM/g4RJRQ2DEFF6QijzNAfYLTE8Fpqueq1jotkiLFaOpFkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cCpBXcz;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD460606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD460606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cCpBXcz
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-14394530ec6so2984115c88.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 09:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793900563; x=1794505363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lkKAejhpVXm9seL1ehybdpNol6UMeDxsIrY79fbHsys=;
        b=0cCpBXczFYatbN465cchPeAyHME4783rqVh3+kL78PzF4IlkhKFBfE5QUc6pCUThe+
         p4WXpGfbMQ8mn8FpHx7MMTutgqAqvxPCVDJo9FwfTet0dJOYWpVxzkZX/UPxIsoCMuaW
         7zUEND9WP7c+PNDLfyL0V5Zr8Va+nAaPgI5xke5C5zjT6zZmNZ5141TVUikpJlNXh+tm
         e+A6AxIrh++VB6UJ2mgMHkfQUHhO4qPFtKv5ynToDcG+gYHr52aihGwah8BvrO40fgiz
         Krhff2dntNB/rAgijFx/fP1Zdw0haDcXxuF/yP6Od5kjUsLelS/3tyPYexfEotJ7bIe9
         KHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793900563; x=1794505363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lkKAejhpVXm9seL1ehybdpNol6UMeDxsIrY79fbHsys=;
        b=LFtStAo0maSTxgNJvuPVmAEVCp9b5UNLQXS9M9njdXCIcDf9yBtgu0H4TmBYVqM3U0
         wT2h0C+HFE2RqJGG2d1c9R+fqRn+IGO9bawWv8rG3V1Uvwq4M6OYVwePVPkmb/NI5DkC
         S9HCI5ev8apuMW/rZs4EfKR/VEQNEJrbYC/mZF0T7Tl/Ue9LQ0HWkNPnuAKgHYM0QKgm
         TsOTDR9E5xcZVI0J3HKEE3p9reWbTiuMvOb2+y2390wCtpZuIEGBWXqdCeI5yqCHkVOI
         LU7VM6EWQCmJzG8DqQt5CEiHe+GmbYFXegaokK3WuUFqC0syOHh+Hgk2wfDuZ9SV/OVe
         HN5w==
X-Forwarded-Encrypted: i=1; AKwUvBz6lVBwvT0YWJInGYj3n4o4Tx+4TflOGonuVxBW1eapW65q1a2OwNDmxI0bJ0eEo4Qseecz7Co=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lPXRehTbVEQ6G2AZ5dPx9Qw90tY8EdcvBqECBLpNgqRU6LSXb
	23ain0ORpIk8dCBu1oT/qQxuQegy+izs7dML+iW4AAXCy6cxwiR67Buz
X-Gm-Gg: AYBFou2S/UZ3krAgYJ/y5Zo5o4FvgIA20IXdtSnojgqppPRFtRi9s1ULqMTHpTpOkvn
	osgtPx+0EGgsHR/JQyTlCRLJ7Jb0zwFpoEGoh39rJyJ1K1++n0eayRIM1deu95Ifp9VRpvk15tk
	gyQH/meV9289qN38NYZJIOrv5bEsbPgQHRK1wwlxyIhYMlzwM7KU7qQAYoDvMJkb9yX3gCFXfQ4
	dLTJITENP/2RM+o8eqr/JO7PYk602KRvDsdl5h5zxrui1Nw7ZjRXhDK1gxJig8EqZ3KrSN8qSGg
	VTipib6vfcEC+iSBhjRFA62LDCUiR7whFkLtFqNHsvseHc4d3N06RYCdkwmFUd2cZH81KFS4pcS
	V+5um8bLc+6j099hku3knaShm67fAvdcKPvCngPxWaNAmaDKGpiU0vQc6BQv08eDvo5ENghU7l6
	xMr6pkTPi/dfj76/BXQofsjYcrL72hO4YKS7l+wjZt8fGAE4w1v1mPaKRDRiQ1xFDP3aF9uGoUT
	+bTwyZGAA4AIwpMFB8xh5u0KXfH6pTsZhPCZUZSUy8AQkWh6cqaUzA3XHe3cRD48E5ovPBFD5lf
	ftK+UslTKliOwxjluDMD19A120hhBcPnpnTlWKHegvSq4krc84wZW2l6Yr2MkNGw0A==
X-Received: by 2002:a05:701b:4550:10b0:1b2:4da6:bccd with SMTP id a92af1059eb24-1b24da6bf63mr5381543c88.34.1793900562754;
        Thu, 05 Nov 2026 09:42:42 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm24291014eec.27.2026.11.05.09.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:42:41 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: refuse to read a handle that is not open for reading
Date: Thu,  5 Nov 2026 23:08:38 +0530
Message-ID: <20261105173838.1882328-1-wahidzk0091@gmail.com>
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

smb2_create_open_flags() picks the open mode from the read and write
bits of the desired access. FILE_EXECUTE and FILE_READ_ATTRIBUTES select
neither, so a request for FILE_WRITE_DATA | FILE_EXECUTE |
FILE_READ_ATTRIBUTES opens the file O_WRONLY.

smb2_read() accepts FILE_READ_ATTRIBUTES and ksmbd_vfs_read() accepts
FILE_EXECUTE, so a later READ on that handle passes both checks and
reaches __kernel_read() on a file that has no FMODE_READ:

  WARNING: fs/read_write.c:518 at __kernel_read
   __kernel_read
   ksmbd_vfs_read
   smb2_read
   handle_ksmbd_work

Any client that can open a file with write access on a share, including
a guest session, can trigger it; with panic_on_warn it takes the machine
down.

Return STATUS_ACCESS_DENIED when the file is not readable.

Fixes: f44158485826 ("cifsd: add file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
 fs/smb/server/vfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 1f2bc76f0..cb3f4f5fe 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -367,6 +367,10 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 	if (ksmbd_stream_fd(fp))
 		return ksmbd_vfs_stream_read(fp, rbuf, pos, count);
 
+	/* The access granted on open can include FILE_EXECUTE for a write-only file */
+	if (!(filp->f_mode & FMODE_READ))
+		return -EACCES;
+
 	if (!fp->is_posix_ctxt) {
 		int ret;
 
-- 
2.53.0

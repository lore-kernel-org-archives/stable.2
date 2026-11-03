Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690600;
	b=Zq3kaYTc+ndUWibCCAufcNPTYLtlWJfcvUqr1owauztUzeGKrhW6WVM9EVtE7vvHFB8U
	 IMEVsQR+qCcSU7n5oVUp3cNUOd3+GCO92dq4vrj7HgL/xTnFHyFxNi9baWsd1MSAH0tF3
	 f2DOpWZqv56NsVcg/H5pLRMsL5zGYgcIpalJiPF5D0YK72qbRsMcFx7A4Hjb+ynml5qhr
	 zlm3FFl94t+ZpUMgM7Up/HAiMJOPRC//iFQcJn0Im2mI3Slaz5+md2/Nyy++KHK7hPag8
	 SjnplaFiE7Gahd6SjkioQga9o90L9u92zuSwIXGo9gKlwj8qG1FCHP9Xq4LzU2VGCCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p9jXNwa699IkdxAM2a5EMXt5gcZr4wwka5kn1dl+WNc=;
	b=PdrFAy9bIk3Upo67X/fhawn5Bc6zLH1Z22XQsb/npqI32uTByVWNuITia+tz/gV8R6yG
	 eCvf15HqacZQW3ZthtvrPbOvMtPv2V05lNKL/Tu32iJwUxwxGuQjlPZOUJ7fQA8X2ns59
	 VljgMUtPhQ4YVmHTiLgA2+b5MVxBx0VZAkuxLW/AWYti+lJqhIRK4EKCNJz0aJCgAD+VC
	 aKRlT8eTtsZljNEUOtt1Vx95ieemcrMz7drVhRJVkN2CvxeBnPoZw8Hs2a/JQKKGsREZw
	 tn/5Ts0UzJmfdLkVEZYPOdBtm0QedqxPWjlxdxCZreootpJBr5GdfHe3AsmV9xwCAvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7vmWaUo;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B6606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 07:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC5B6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S7vmWaUo
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ae93a86008so2284257a91.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 23:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793690599; x=1794295399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p9jXNwa699IkdxAM2a5EMXt5gcZr4wwka5kn1dl+WNc=;
        b=S7vmWaUoyslEfTjkDmZaSctew6UQ4i5PRtOOuyCzM7AgFpelmq58vuA8N6zvfnNGe3
         5GKfoprGk8jrR/28uvvos3Kem8HmxNs352a1343rJLf38vwB9YML6h1+CrfPkpnRgYGT
         hhtLUnsu4fpqtKUvDypt6zAEKiuz6rmeFkoOUpn8eDlHx92KlXo8W4w/uSUcxqK9NH2b
         BEwDQTwyJFKwW+xRo8v4UER8narutqHKkjB1vXxSWZ5Srjq4iBaIOBvrb07j5A3j7w4G
         eWX64gV/H5Egx6cFoYKRGfyfmMqN1v5z9G5WBmV8+EMksIF5wPl5I08kLUN/KzVQ/aTR
         N9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690599; x=1794295399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p9jXNwa699IkdxAM2a5EMXt5gcZr4wwka5kn1dl+WNc=;
        b=YMqkAmM5VnQ9eGdKLQ5KvNBVTWA6Bx1q1U10V41UBVmSy7Zns0sEScWB0DMgQLSgE5
         XMp3vmwrR384aLuLA0NsrILWRlu71W4avrNlcP99WvcnOstjlHDJOA8GSIY6/X2+2DWw
         qxQng2t0QvIz1SN4fMVCRLFUFHAxt9Z2Q/F5jEm+/t/5iRJBll5Kpcfnbz7yCUQUc4Pj
         Cu5Nz8mfeZFW5JyxKoFpsuTFfdjmUKBzcJx+8ssPzicRB+WhscTtd+djjTnGJLzY+F5f
         6M7+TPavJDn2P5O588FWPYVl3haMaQg+h1XxcdhMfvRPo8lDcJOAzkWNLq9PPD+WWW6t
         dIoA==
X-Forwarded-Encrypted: i=1; AKwUvByy3AtCGQmeLFZrkXjHEd7UUak9MhLEX+VySkgZdHXm7v09knNu8bQJFHQYvSSJM/Q48Buhz6w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AWcd7vt1m5petVF4/6RVQomFb83kVvmrYKeWtVWrN49bZ5sly
	5/ssWf7R3FpNcQCx9cIpPsc49ZId3VFqmyG4vwKuO5SNwlup/nW3CkoL
X-Gm-Gg: AYBFou1yXYr+LDovlGfmk9NvUoyV0/ZhBdreTWDUYPvDgEcDLE8XrbjD6d2KLTsUaXO
	gDTe7Yvr3RF8iqT5plumw9jNDj7DBMORB5KXzN0V2nmHsdecoEAp+oX/ZHvrQ+RBB/MatbLPjl9
	YlaBIUP34mbwo0iLHsL5sOF43SxNvELXFnMEy/wWm6nKEY74sK0CXyVrTl2oVqwV+L5NEQ9zKm6
	jEmXj9HcdWNOzA7bdpX8Bte9FLxosN9PcAZuKjSMJWc/hyEjdwjycJwtdeKI/Rx5hm+nIEVAVym
	dDmOVNZ/xY63mKcYd6yKbkweXh1g2qEwJWQy7TFMVOxT1b0qOFXB7WxSbwg8idn65fP1e7oWBSQ
	8Ew9R1Sarrra1EqzgmkYmOU0Y6Br+mh1S0KJt6TxfKGl3YqEZel27nXWWWNH0jUaAGIAPliMq5o
	tcKGvMYAAKPtQ/+PgvJluA1JWW6l98cDUkCMt5px/pe5LbebCRjH9YKkn8tNpyijZNss3luHjs2
	oJHod3D2qWODTNLgKfvGaSjMgbRKo0sbbymxv7btsJjYivTc0VEAiuszeawrIMsuAOA0BuCI/kV
	C8P1NxPZhfcCc3d9EFdBTloGPcDHfT552n+9vpAvrbp8ke96bZ17niEi6XiJFDNJ2A1IEnJzW3x
	7LQ==
X-Received: by 2002:a17:90b:5686:b0:3ac:9c37:9430 with SMTP id 98e67ed59e1d1-3ae89724b1dmr10286440a91.21.1793690599284;
        Mon, 02 Nov 2026 23:23:19 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f662basm8638824a91.1.2026.11.02.23.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:23:18 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	willy@infradead.org,
	kas@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] buffer: avoid extending i_size after failed writes
Date: Tue,  3 Nov 2026 07:22:34 +0000
Message-ID: <20261103072234.55611-1-dennylin0707@gmail.com>
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

generic_write_end() updates i_size to pos + copied even when a nonempty
write copied no data. Since prefaulting moved to the slow write path, a
pwrite() past EOF from an unreadable buffer can fail with EFAULT after
extending the file to the write offset.

For example, on ext2, a one-byte pwrite() at offset 4096 into an empty
file fails with EFAULT but leaves a 4096-byte file.

Require copied data before extending i_size for a nonempty write. Keep
zero-length write_end() calls working, since generic_cont_expand_simple()
uses them for expanding truncate operations.

Also call pagecache_isize_extended() only when i_size changed. Otherwise,
blocking the size update would leave its endpoint beyond EOF and trigger
its warning.

Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Reported-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/linux-mm/at9xXRhD2xZhszEj@thinkstation/
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 5d3852b726d6b113542e9761315cfdaf99f14587..f88ca7c079bee3462288fdebf57131da60b74798 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2203,7 +2203,7 @@ int generic_write_end(const struct kiocb *iocb, struct address_space *mapping,
 	 * But it's important to update i_size while still holding folio lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
 	 */
-	if (pos + copied > inode->i_size) {
+	if ((copied || !len) && pos + copied > inode->i_size) {
 		i_size_write(inode, pos + copied);
 		i_size_changed = true;
 	}
@@ -2211,7 +2211,7 @@ int generic_write_end(const struct kiocb *iocb, struct address_space *mapping,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (old_size < pos)
+	if (i_size_changed && old_size < pos)
 		pagecache_isize_extended(inode, old_size, pos);
 	/*
 	 * Don't mark the inode dirty under folio lock. First, it unnecessarily

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

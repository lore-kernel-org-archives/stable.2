Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708829;
	b=zI/v5Re6/KlhY2sMJ1nG3bp5gpis9rqRPxI4OzquhBz975FsKVwl6eME2/Vf958c7bOK
	 +6eYUi+vN2OrhOnhl8fK7i6XbiEs2YoqF4hDNrv/Ob0DA86BeqK+/oFAk3qwi287DNLZY
	 avtTYgoG7fRVX2V9EHfQduLA8YaGVseXba5TeCAUj8sI1TiGqZeIPUWM7iti/axUaaSUf
	 hrD7WH/wlo3a70YSy0DLL6s1UEwN0JNmaIV991HP42QBwNocziLE2er/SgTxBjjNhCHq3
	 MtDq/9w6x5x5jZF3klWx6Tny7nTdIZLiECckjRuGXZEwsjtkzCcE1ZWfxqw7s4L/cPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dpgzsurd5/xcAqQNY8m4SztexczNhtYFtRWAJE5g84I=;
	b=sjlTvK+GdMM8oSDw4O6rTbGe3cO2jd8Wt0crQOXW0t7+IIgIJijJZq5JIAZTMUH2wumd
	 K3KK7Pcr2V/Fh9+UaW3vqrwvpTo6Hy7W36srtWe1cdzh2fw6LIE04znz1OV5HQWTe+lSO
	 62UptsUzU4KvdQfUibWOxsBnBDHvnBZfhSvxOUHG5ARm9y538Pp/hxhrT95lLSD+/8izs
	 vwL54pzKO7kQQQeh0KQBoUjM2N8rghMnVZbpejRlPV6iMVJEwx78CIqg2F7Ju7phofwBp
	 AN0I73KsI014+cxAFxGwwNh6tjQr6U9UiYKcqAKpGYchH4RhM0zEEBhiGnc4EJAztqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wZyfed2q;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCBA606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 02:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BCBA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wZyfed2q
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4919a880834so1067945f8f.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 18:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794708827; x=1795313627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dpgzsurd5/xcAqQNY8m4SztexczNhtYFtRWAJE5g84I=;
        b=wZyfed2qCeeBfHWG1DKaL6asdZzlFwUXPD75qJl4GBTpM7Xu9PbPFAZbXXiqS2j3jA
         9gEOT4s0AnOmDrli3PlV276OK3KvyXfmxU3H/PHlbhK2dJPpaNl2U23novqmIbAAv2l1
         1GFMFATx4514ZRKZL+V6ayPLwzLxoIelt14oHup+eAlOREpSrpF3Kb6Lz413p9ZED0Wx
         3z0qbWcPLETiy9lSh58IwxnEfF1cTaOB6gR2ODWXmsoQtK0ukOE3i9kwdy7E+iiO4GjX
         pR3orwAX5rikKleDpbVgje49wBieqR0/bZvr6nf+YOvPWeqIX0pNj0ysIsCJOEk3uj7Y
         +zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794708827; x=1795313627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dpgzsurd5/xcAqQNY8m4SztexczNhtYFtRWAJE5g84I=;
        b=Er0R3srhmPGozthKhYStKyyXFr2j54NOJ/ZvzG9WlbQGU6uO7XupM4nH/GJi/95J5K
         LE+dclhgBGIuOwylRrtFp3XS3CgX5s2UnLwHvh7XatV/FLcwVQ94wSk2Unh48bth2b4P
         T2TUYjx56cInvJ5MiblF5uBVJo4lMjL+kzhlgGZGo2pjIiRHNvh5G0AHBAyLDWZoUjjw
         5yMu5zJpOXjeKwv1nmxfZB1v7KwgPnrgpFVT+RDd7wcFZn2fcyyHSrDznEME8mZ0qsgK
         6EEz0pL35dn774Cf1Wx7nToc57zz2Ru0eTeW0iHd3+fjWWKBCd8rOYbuCT8BEha1cj+Z
         m8HA==
X-Forwarded-Encrypted: i=1; AL+hErH3tXEn7o2oyPaxOZVgf+loTPrBno6r5vZlM+HIaoMpHzwynne7AHf5S4A4AcGVc2nU5TPVtBo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/l3NnvJenFsCLsoF5xpj7z8ER3NjcX02rlZ66Hspk5mWo8vRu8
	BoishD2fo7a00lzogs2sC2etPO6oVzTyTWASCkxcM3LdWF/MlGBhOfTJGEH/+9v5GfU=
X-Gm-Gg: AYBFou2xVltj82TnOD33rarN8bV4TWB5o+VXYSi1Irtd07KttGJfFBTshNFh5ybKl1w
	L6nVIwfM0PEjVefvsfAcMIdpqV4VICwKMhpt3CEyRaxKzT/5CHqRfv8gn3kMANEDZI893DYX3bM
	JxPpj+OTc99sKbUChkuiRl+gtvpJzIXmukp9OyMxeNIGvTX+2CrGhMAqHGsEol/JRrA6LMSvSNT
	Xr0WHhF5gn1F63/BGP7VqGImYPaihFsK52R1Ah5R0uDdRx4ZJhsoaXQNpMtFGDAyTo1/M8U3VXY
	un8YeV1itAvIVYde/9gnGyGHHQQRCPLmgEjNe2V+yCMNlfYI58KWpB7+1ra13SaIm4SY35SpAw2
	981xmhUlKtw4xR5zQkJw3kIDjg05V8YNgb9yNV3vTEWog9Q49OKcqd7+ASd/TTXTJb5UwFxREv6
	NqQldDkyzdlaRMA4mxpD+3AOdpfoTHqVZ7JVUPNI82GiBgUwTmEXYBC5v8h+GwQkvF8Qf3JpP2v
	lqqxqIQVoMM66lEZAjahaFNM4i+3SLwT39gdPytlpUD7HMpDUNltvmC4q9qDxutMTXVBsOAC6Nd
	qQtvc9XBoJsisTNa0lx5nenbERn2H0HQwLsaHa8B2Yd6i/ZSqGdBKlSz/rX73Z3zUojvgDPCvzI
	NDcFdN3hI5Kak7vLOGABD9FEfmFaqL85W1A==
X-Received: by 2002:a05:6000:4a07:b0:48e:10a7:438 with SMTP id ffacd0b85a97d-49c725e5f59mr14233599f8f.36.1794708827120;
        Sat, 14 Nov 2026 18:13:47 -0800 (PST)
Received: from localhost.localdomain ([5.195.38.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm13226402f8f.21.2026.11.14.18.13.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 18:13:46 -0800 (PST)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: linkinjeon@kernel.org
Cc: Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: refuse EA names that contain a NUL byte
Date: Sun, 15 Nov 2026 06:13:40 +0400
Message-ID: <20261115021340.17611-1-mike.michalo@gmail.com>
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

smb2_set_ea() checks that an EA name is followed by a NUL, but not that
it contains none. The xattr layer takes the name as a C string, so the
name ends at the first NUL. An EA named "DOSATTRIB\0X" with EaNameLength
11 passes smb2_is_private_ea(), which compares all EaNameLength bytes,
and is then stored as user.DOSATTRIB, the xattr in which ksmbd keeps
the DOS attributes and creation time of a file. A client with only
FILE_WRITE_EA on a file can so replace them, which commit 4ea46ea602fc
("ksmbd: protect private extended attributes") meant to prevent. Any
other name with a NUL is stored under the part before it.

An EA name is EaNameLength bytes followed by a single terminating NUL
(MS-FSCC 2.4.15), so a NUL inside it is malformed. Refuse such an entry
as one without the terminating NUL already is, with
STATUS_EA_LIST_INCONSISTENT, for both SET_INFO and the EA buffer of a
CREATE.

An AI assistant was used to draft the patch and as an independent
reviewer.

Fixes: 4ea46ea602fc ("ksmbd: protect private extended attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
Namjae, this gets around the private-EA check from 4ea46ea602fc, so I'm
sending it to you first rather than to the list. Please post or apply it
as you prefer.

Tested on a KASAN/lockdep UML kernel based on ksmbd-for-next, with a
share on tmpfs with user xattrs: setting, reading and deleting a user EA
works as before; an EA named "ab\0cd" was stored as user.ab before this
patch and is now refused with STATUS_EA_LIST_INCONSISTENT; DOSATTRIB is
still refused with STATUS_ACCESS_DENIED.

 fs/smb/server/smb2pdu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d17fe9f9ffc6d..066d30b4ec281 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3441,7 +3441,14 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 		if (!eabuf->EaNameLength)
 			goto next;
 
-		if (eabuf->name[eabuf->EaNameLength]) {
+		/*
+		 * The name is EaNameLength bytes and a terminating NUL, with no
+		 * NUL inside it: the xattr name ends at the first NUL, so one
+		 * inside would also get past smb2_is_private_ea().
+		 */
+		if (eabuf->name[eabuf->EaNameLength] ||
+		    strnlen(eabuf->name, eabuf->EaNameLength) !=
+		    eabuf->EaNameLength) {
 			rc = -EBADMSG;
 			break;
 		}

base-commit: f4692d0e3b5e16d32d4ec7b1e0e58d7dbe74aaf4
-- 
2.43.0


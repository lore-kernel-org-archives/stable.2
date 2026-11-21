Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795262134;
	b=jt4K0avuFPOgwNSTxaSgWxAeQDYLh0M8J9XzSI6s70iTLsshYJ68p+aBkx3AJYNe+Pk/
	 35im1bKJjB5C9rgcKYFfsFWIIO8xW19an43mujgrWxcdqLTKXXTLbKAPMzEoeo9GE7h0n
	 pfa/HUt6v8cq/XKh4d269fsqeKvynEAdQqgKRvB4D2ZQAUi360pmfUSFgxmPhAzsY8H3o
	 3sy8jNf9pEaWSAyq5xr6VV9uUiB0O2mEXaBvafY8qWbX8lHMs5qMu8RwOkIF2TmdWCBeo
	 oSypXWe66jFdEKvJ+QIGi+eeW2IGpr1qeGJjpJZ1RqYapebHcWv8MIA+2esE7W7+xLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version:Content-Type;
	bh=Udl+/K1uwpei4wEZthYxSyLuxFRGO3vhDmEacUQwYcU=;
	b=OPUmEyxay0UhcxcujcaPfOzfd1NVaROPVftO3ysJuQFIPk6B2q1LwSoBKKOIpdzjXRd9
	 fH0KbnNE7UW/QkWFT0eMLancXZkftolJqKVMSeQKwS0hddLSPRz8hHJOXwsYWF4xWoDFa
	 puklzPAjnjbdD88YsbFVdu4hCWprrcsZxdfRhih1vYuoi/zwil1I6SYDy1Z9JsfYdgL9s
	 +K/6EzWh+PbVVH31qMLnj7op2Lg1JlW0VRf/SHoEjU7QabmJBCc8goT4T99UNMXryfILN
	 RjFhtxpnfCTc8WrW4Z/kMOkIq7XLFVezL+7QXmbLDGcYp8D79+gsgl3Cx0PvV7PpKeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0k+YJBUH;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CCF606A332
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 11:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0CCF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0k+YJBUH
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a3c08d6928so2446606c88.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 03:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795262133; x=1795866933; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:references
         :in-reply-to:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Udl+/K1uwpei4wEZthYxSyLuxFRGO3vhDmEacUQwYcU=;
        b=0k+YJBUHmdNpld/JWXvrBrKQuGuyaLGNv3sxg43FeN8rrDSQ4s066Skzh/9L7bR3yC
         1IZqCBZz8ikuGIAebBgi1vCiSPFarzz7syzVNBvi3h4KusKVoQryvGBmPxJHnseTA/WL
         Dvl9WLqU4BcUiaFeEOe54dbE5E4cpDXgsHc5cvz72kSnPB2WFbkdF4eEAM1c6+UMWn9w
         6zu8kPnFmVmhe3iCdCDm6JEflXLETJTrW6NEhHuZ2ui1LXOUpC1KIp73tXusjZkTq7E5
         /nJGiiJR3ogrKwP0sflp2r2J4DXc3TDupzRJlONF0NTg6yTWJ6jrzG3NIOumNQHSCeDH
         LNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795262133; x=1795866933;
        h=content-type:mime-version:content-transfer-encoding:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Udl+/K1uwpei4wEZthYxSyLuxFRGO3vhDmEacUQwYcU=;
        b=jYFsjcI+Edsf1XJ4ozS4aF88HaosIu1jzp5DNcUfhaC1PFX5bU7eY55s77sHBGhG7d
         n89w4QL1JLSBWv1mUzPmuakcALwdtd/IJ1TihIZ1wKTZeCzrYi8G2Gs9rv+apZOAnhoV
         xmEsIgbIhW9O6piFD0b0YHtqTq/N7FYe6hMBNHhmvEyUjVz78ow/q3YaG8JPPu4smcO0
         7OH0XsegN3ZhE1TeFFJw83Ukoms2rxuvVx7Em+y6fvhf1QkBuS6RSl0h7zSXKPi7VTZC
         X8llgdQ8fqC49yENrtDTez/yvFBqLXMV5KFooRvbSXtCXTRzaNUoVCMi5WxvcHztHEyD
         ixwg==
X-Forwarded-Encrypted: i=1; AL+hErE1NhANHmT1fqqg36FZfmT6qTauPmw8OXBrEGDuXBTFJI0xPNdfWgMkBCWWdb7gBf+H9o0INbI=@vger.kernel.org
X-Gm-Message-State: APuU4Z91u1fGKwI8IFLk15IuICx6nPL6yCdJwWROyD51SXQ6ZdLet9V0
	+8gzpOAFY5ejKsaWR0/pIE3Aq8LHdcX8cBHfh2IGdPYq9e29mBuke5b0
X-Gm-Gg: AZFdTZda8BIJsyPtQ1l1TAlYQBRdfCayRxZY5LcFsYj2izvPtOnAYHCH5B3FNFNbEBd
	zfULPyOWMa2ICX1RDTTvDYwYzrHg4lkPbuynW+ORWfWury8e/MJ8akziJRGUXBAeOip2J0FSnos
	rBys30jTjkfCWIk5oBsfLAyiIlsRGH9kQPvbACT84o2I3KPWMSDuFCBrhixgce2gB3uWHFZrEPh
	RBxyxAOT7qprHPyXhzax8d7+iQB4yHttdeBRLlmsuQKw0ModC/lhVchCWHVjiT1faQzdjf6A5AZ
	XjF0tA0YJ+NMzwxFm1fBAtMtXaberX90VWXNNotbf4UBu4y5dOMkHzOIJxaBoDgYCit/qDV+I/i
	MNHH8TiKXoJ9mddcHlNHaxuUVMMTL/uGgg1Um04wlq5RuSfYzODIElP3NeC8cVF22jOkFw6Qr35
	isdq30Ud0NPjZMnzKPPibs8YMHLBFN3dIGiG/RWzHBtexywb6D8P9AVpidKXD5cJuei6sGke3Yy
	/IjuDeJBzaG8zuE87h3GZAJwFwSOd1rgsH2kPQaqaw+y+50icJ8Ynvyq44djrljEVdAAI0NsUI4
	/SSO599ZAAPMvwBB8JYa0Oy3ck3OZQhuS3MBYmOy/9mOELSH+Kk=
X-Received: by 2002:a05:7300:bf11:b0:36a:15cb:30bf with SMTP id 5a478bee46e88-3856fe5971amr6534175eec.13.1795262132618;
        Sat, 21 Nov 2026 03:55:32 -0800 (PST)
Received: from ip-192-168-31-150.ap-south-1.compute.internal ([2409:40d2:10d7:e30e:302e:83a2:5a33:afcc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385665f21aesm22261925eec.4.2026.11.21.03.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:55:32 -0800 (PST)
Message-ID: <6b0186b4.6dbf942f.174087.451e@mx.google.com>
Date: Sat, 21 Nov 2026 03:55:32 -0800 (PST)
From: Tanuj Sharma <ertanuj96@gmail.com>
To: ntfs3@lists.linux.dev
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, gregkh@linuxfoundation.org
Subject:
 [PATCH v2] ntfs3: fix out-of-bounds write in do_action() bitmap operations
In-Reply-To: <2026112159-sampling-unmade-c123@gregkh>
References: <2026112159-sampling-unmade-c123@gregkh>
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"

In do_action(), when replaying log records for ATTR_ALLOC attributes,
the buffer is allocated based on bytes_per_index (typically 4096 bytes,
kmalloc-4k) but bitmap operation bounds checking uses lco -- a larger
value derived from lcns_follow << cluster_bits (typically 8192).

This allows SetBitsInNonresidentBitMap and ClearBitsInNonresidentBitMap
opcodes to write past the allocated buffer into the adjacent slab object
when processing crafted NTFS images with malicious $LogFile records.

The bounds check compares against lco (the full LCN extent size) but
should compare against the actual buffer capacity. For ATTR_ALLOC, the
buffer is only bytes_per_index bytes, allocated here:

  if (attr->type =3D=3D ATTR_ALLOC) {
      t32 =3D le32_to_cpu(oe->bytes_per_index);
      if (bytes < t32)
          bytes =3D t32;
  }
  buffer_le =3D kmalloc(bytes, GFP_NOFS);

But the bounds check uses the larger lco:

  if (cbo + (off + 7) / 8 > lco || ...)

With bytes_per_index=3D4096 and lco=3D8192, any bitmap_off >=3D 32768
(byte offset 4096) passes the lco check but writes past the buffer.

Fix this by computing the bounds limit as the minimum of the buffer
extent (cbo + bytes_per_index) and the LCN extent (lco). This ensures
bitmap operations cannot exceed either the allocated buffer or the
on-disk extent, and also prevents a crafted bytes_per_index larger
than lco from weakening the existing check.

Found by code audit and confirmed with a crafted NTFS image that
triggers the OOB write on mount.

Cc: stable@vger.kernel.org
Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Signed-off-by: Tanuj Sharma <ertanuj96@gmail.com>
---
 fs/ntfs3/fslog.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 1879d04e3cd05..85590f56587c2 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3751,10 +3751,16 @@ static int do_action(struct ntfs_log *log, struct OPE=
N_ATTR_ENRTY *oe,
 		off =3D le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
 		bits =3D le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
=20
-		if (cbo + (off + 7) / 8 > lco ||
-		    cbo + ((off + bits + 7) / 8) > lco) {
+		{
+		u64 bmp_limit =3D attr->type =3D=3D ATTR_ALLOC ?
+			min(cbo + (u64)le32_to_cpu(oe->bytes_per_index), lco) :
+			lco;
+
+		if (cbo + (off + 7) / 8 > bmp_limit ||
+		    cbo + ((off + bits + 7) / 8) > bmp_limit) {
 			goto dirty_vol;
 		}
+		}
=20
 		ntfs_bitmap_set_le(Add2Ptr(buffer_le, roff), off, bits);
 		a_dirty =3D true;
@@ -3764,10 +3770,16 @@ static int do_action(struct ntfs_log *log, struct OPE=
N_ATTR_ENRTY *oe,
 		off =3D le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
 		bits =3D le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
=20
-		if (cbo + (off + 7) / 8 > lco ||
-		    cbo + ((off + bits + 7) / 8) > lco) {
+		{
+		u64 bmp_limit =3D attr->type =3D=3D ATTR_ALLOC ?
+			min(cbo + (u64)le32_to_cpu(oe->bytes_per_index), lco) :
+			lco;
+
+		if (cbo + (off + 7) / 8 > bmp_limit ||
+		    cbo + ((off + bits + 7) / 8) > bmp_limit) {
 			goto dirty_vol;
 		}
+		}
=20
 		ntfs_bitmap_clear_le(Add2Ptr(buffer_le, roff), off, bits);
 		a_dirty =3D true;
--=20
2.43.0


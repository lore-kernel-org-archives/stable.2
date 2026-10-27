Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114206;
	b=0TUgSNsrhs6X/ZwYted+UTL4mYI7uDcsPQAECRkLXr7YBTTXGSnTbSV9xvYy80jocupk
	 M6oFL8iKgxZH4MUyWH2lyYyuyUGID5gRUK2iSmkjHzjsDU90K2JtzSBeTbSgSyqfXamrr
	 R2rN9ustsyUMCou2Va0J1Ia54uKc1/3KbyLOMtK0IcE8bLaVBUnptOhb/oYwDtVlW5N/s
	 36LjlPIExSSJ8vEE7gB2rTt4tH631fEqfmDIXONF7n1JYxkLMi0MdByBg4gccURItFHc7
	 lteOiQJS3ccSqZ7J1/iBBEG0LEVBs3ViiBh0H468mDtwDt73vtMczFAly8mQBGErPvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IFHTFkFZHATvDyA9vMl3gA5TnmzEIZlmMLjprD1MJL8=;
	b=JMbaOkycO06hLAO2PWeDqrA/c3fI+MWArZjE7smvs9rnZEczkO8CzTzJghFsx95YWBuM
	 NMdGKM27PB9vONbQQk0LP3sgmTLS2sTjtWgVj3A03XpA8OxIga+pw7DH8jgHK6DMhpaDE
	 D8GF4HaX9FtJK12tenD3xeyqVNZuKrOOwJnCx+XAEo783sdzweptkrhOOSBXdMGSPFEzp
	 XvgHqjyzQhlKOAnjmM5PvU5uoz0w/ymL8xpEhuCW+KP4+Jb4PJClVqJ20iRDGAsvpoEYt
	 7KxlSDXprV4DeC2gRwB/8QJxeghoCibVqfd5n0Ar/NoINRTbewOJzwXkGjvg9fReADA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMwJSw+M;
	arc=none smtp.remote-ip=74.125.231.131
Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420A8606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 420A8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMwJSw+M
Received: by mail-oo2-f3.google.com with SMTP id 46e09a7af769-8459f7bc7c0so2215654a34.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114204; x=1793719004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFHTFkFZHATvDyA9vMl3gA5TnmzEIZlmMLjprD1MJL8=;
        b=EMwJSw+M91PgzAQaQPtBgZc95p/uQGS/T6PC3FZEOMTygnc1uk0gICdyas7ooMBwTQ
         fcIBKDuIB8fG3rqCWQVtuBedLeb3c0bcPs2vEMH4jxIKvS6Wb106lFSoj6Ujv9soiH2S
         4KGUMy1GNReA0DdFg5zRiViC77yBwkL9/YY7hS48bT+jU2A2WTC8bbblKYRiyaW05Qq7
         jYcAVYo8qkCDYd9WnDWK+p6WVOPz0o54JpvUpqJUgal3cFP+0b7TbGlQExyi883vtJws
         obRvHzujWHoWuAFf3jqpkjUjsgrEz9nmBGqNiPvav58KydrmsngXxi6/3nSte7+5B9zF
         LiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114204; x=1793719004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IFHTFkFZHATvDyA9vMl3gA5TnmzEIZlmMLjprD1MJL8=;
        b=Hz50UumSxhofFqv/UyFttjBNZUmQfy0d57UyNfQEZIYmgX9UfRlqE31CKnR5AWK5fF
         nshipv1HtYjkCDGwf5IBWekBJEuyEk6c3LZmOAe400XtAHgZ4mN2TsN58zF8+l3Inm9S
         wrRs8lf3VyMD9pm5Y6jqssCkOk3JszFJA13gajaFOFs7gsGgIM8Q5mIOQBtQs4PU7gwW
         mzjvlChuZ3ymex0yzRN3W+2//OAC9/8a3C2rX3HjpBlsKRYZ/Q8vzisXN6ifaXe81J1v
         c1LieYWxT/ZRh7zhW78lreEqoe/0ygLbTjmDMhjqVyOVr6d7eSjaYLFH5WMRvcn7AMR2
         JYGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVNIg+w1A78zV0G2yYk58eVflcbrz56524XApFR6WC6fOHd4cC4I1YZNq1GnKCLVaMpv6U4Rg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKg8X0N7XTkpLpEs96N5Mjl8Tc0z5zzHt149G7rtRAxLFujhjXL
	uWbZJCoriz9xaIkwgYoXPwJBX39VOSy5vSgpbxW36fFAL9CYeyyP/p4f
X-Gm-Gg: AYBFou0kztXeretIFD5NPj59ONV/hfAdKmdT6uif5vduYHp3K/1VXbJKvnPkT+Scfza
	bAcT0f08oJU75/QHyQlARcWdn6ctglkmc9e631jpak2k+Iyo/qpbzLuBC4Sz83rCV57Jbi+VSUL
	qIjp0YgQKgNGdBis0zl7rdOP7CpZjXCR5K7mmuN8Bn5MJAslA9XQVgX040d3ASMH7AW3sAthTMV
	6PK+4a7OF9MFDfn0SxldapUNUE7jD35wkloTLnk+NktAjz0FLQWpyK3z+pJKlWQIKk+//A90WRM
	5aFSPgRg+B5FNSZ3oxmrJkZrn+OOxDDQ+qGJNzwtnakUonVv+H7zccthJbdf1jsBg03jYSm16MD
	iMO+njak9iFt5IQnOgQC40RgulGc5XZ8RxqOfFlL89PDKl8bmTZnzsoDTmq+tz5yAoFdp5p/6K1
	b72k2hRA6eR9IlRUj17/5tk+EkOlPzM13ZKpg5XZfzVSMoPYbrTn8piEwirOApeIJis+hgNLYET
	X/qPv5biLM2aUZXK8Yyy+qaGja7zvNCFA9P4ZzxscM+VMaDSBr9nk72ZYu9Nnw/Lc53w7VmxnA+
	bfhNpCZqApgccarUSt4WAK7i8x800207htbOKFpp7A==
X-Received: by 2002:a05:6830:2b10:b0:821:c75e:5309 with SMTP id 46e09a7af769-850fdb42781mr8911434a34.7.1793114204118;
        Tue, 27 Oct 2026 08:16:44 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.40])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850f8458d7fsm10768970a34.2.2026.10.27.08.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:16:43 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: fix NULL deref in ni_std5() on stream inodes
Date: Tue, 27 Oct 2026 23:16:15 +0800
Message-ID: <20261027151615.971171-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261027151615.971171-1-bsdhenrymartin@gmail.com>
References: <20261027151615.971171-1-bsdhenrymartin@gmail.com>
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

ni_std5() looks up the standard information attribute in the inode's
own MFT record:

    attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_STD, NULL, 0, NULL);

without redirecting to the base inode.  For an ADS stream inode,
ni->mi.mrec is never initialized (ntfs_init_ads_node() in
fs/ntfs3/inode.c leaves mi.mrec NULL), so mi_find_attr() ->
mi_enum_attr() dereferences rec == NULL:

    BUG: unable to handle kernel NULL pointer dereference
    RIP: mi_enum_attr+0x18/0x180

The SYSTEM_NTFS_SECURITY xattr path calls ni_std5() without a guard
for stream inodes (fs/ntfs3/xattr.c): ntfs_set_acl()/ntfs_xattr_set()
reach it via ntfs_insert_security -> ni_lock(ni) -> ni_std5(ni) on the
stream inode, and the stream inode inherits the base's i_mode/uid/gid,
so the may_write_xattr() ownership check passes for the file owner.
The default stream-name parsing (colons) is enabled, so an
unprivileged local user can open("file:stream"), set the security
descriptor xattr on it and panic the kernel.

Redirect stream inodes to their base record in ni_std5().

This issue was discovered by Tencent CodeBuddy Security.

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 fs/ntfs3/frecord.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index bead01a953f3f..dce6400195aee 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -89,6 +89,13 @@ struct ATTR_STD_INFO5 *ni_std5(struct ntfs_inode *ni)
 {
 	const struct ATTRIB *attr;
 
+	/* Stream inodes have no MFT record of their own (mi.mrec is
+	 * NULL); the standard information attribute lives in the base
+	 * record.
+	 */
+	if (ni->base && ni->base != ni)
+		ni = ni->base;
+
 	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
 
 	return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO5)) :
-- 
2.43.7

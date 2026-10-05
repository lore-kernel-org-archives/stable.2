Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCBE154425
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221811; cv=none; b=i3eXIEDfb6HcXpLz2bY4ByRVTL9p1xX4rm3z61VPkcrei0WH6cHT0Bppe1vAZOYD1Um2KojdY3xDd68wCaWsO9PQ6VwvTnj+mL67EUQpfYq3TAut/TwV/c9fAt7a/67vmP9zTYHKlA5AiurjSZ75pId1PaY5+84jOlbzPsziCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221811; c=relaxed/simple;
	bh=XoedcnvEByiO6Ue4C7Sa2xm7ySepRqPE0C/WmvAKWPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGTcJGsWOd+RbYCDp49hfF6aemY0WODCmwFPTc9sFYo/h85f6Br5g44w2rjcMWO4w0lFw3fYmaydnJ6p6ri+UZmj6Ep04zxr815uhDwvDCNYUsO/D4oXm58QLprAatO1t/EhiHSHUviS/rAqLUPqY8id/LQUsZ4IEhIYeB1FIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Js30NwwG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPbRRKDi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Js30NwwG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPbRRKDi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791221808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2Wp44NbU1QyUaWTk8PHRakrGbyxmmCjcBgG8pe391E=;
	b=Js30NwwG6ejhtJhhA9tO0LUrLuBINnn/P99C+u7rt2N2Q0MSnrnwcve5g+YiMPl3EKy+uB
	yAx7qeEXGeqJo4vrTS3XGotfjXSikag5yAJOfDwa0Pknji7Wv3jOKtrH4rR5224jSMGmUb
	MyBRow508uUrFnHTuaPivWYVnHopdOA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-2D7o4d-9PrC_-E4oqlyJkg-1; Mon, 05 Oct 2026 13:36:47 -0400
X-MC-Unique: 2D7o4d-9PrC_-E4oqlyJkg-1
X-Mimecast-MFC-AGG-ID: 2D7o4d-9PrC_-E4oqlyJkg_1791221807
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5352436cd78so16094841cf.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791221806; x=1791826606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y2Wp44NbU1QyUaWTk8PHRakrGbyxmmCjcBgG8pe391E=;
        b=QPbRRKDiDIdBhykgwPg8tgi7A09d7RWEoFWQYb+PAzHQRBsdtd8JzGYpqTslit3zgZ
         wQS4xT4FuXOUetOa8M7xqOn1OflgCQ/q4TvXHzhVQwKgIj2aJSlt3eJ+m5RSL//azQ/a
         NV3N5WWFj8qEjF7Hbf1OlIxPyHobYwRuv0KRmw963i3BeR7BCvCaV5axKLoWysPWt1Ye
         VgZT93smBaZhRlfY2LRgpFej6wltEPNL0+XlwIaAxdmQxaei2fy/xtftFJ2/DH8FhUcj
         sOH7F5FkbwlsO4/I5ojVL+WjfEvExKesMaBMwcgbch19kHX1TciiGP3dtwfrWNOC+OAN
         t3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791221806; x=1791826606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y2Wp44NbU1QyUaWTk8PHRakrGbyxmmCjcBgG8pe391E=;
        b=opulWJ1ulf+H9HkA+QQSgVt2NELi6E8JmWrmrwiN+F26KqJnh3pgSwIzo9kSY32FBW
         VuuP95XUjtCL562j3wcBLVaF3mCftH76pPlJacKs1Fmo6emL+3AI/XRAcc3JZ8Wr+SkI
         9tab+60gW8K7x7hwM577NDvgBdJysvwo0oi1f4lxBPl/TVJStI3dJyL6NqMRz6UxBkn4
         vV4tmL6j5Piy0aMXikbk68XMChmfSpF9q4KTsH1onLPLe2LvfR0xh/HFdNTzhGsa18bb
         PP2sUTL43yRwdkaHA+dV0sj9Qt51maV+OGqGth83HYsZjp+CPNLU9NL1ivJ0N4fkFxDZ
         PGkg==
X-Gm-Message-State: AFuF++mr9ezos7LOafxHRks4uvuospiWPpays/x2C33uJFUsH+GihLOF
	Y4kjg6mHdOKgf8k6OmVjGjMTLWqua39T7NZjOJH0mZi9O3Tbal26ZOzbZJ9FVo12FqAahxTRSzj
	TSDfBfD0r7akweD3yQof52G0iJsx404Mz0mzssb3OQu9pG26rqOmLp12LTisnm2Mc/UTkKKzE+E
	K7T0U0GbqpAdyB128cLZXReuf/BZzi7ma51FLque+2IA==
X-Gm-Gg: AYBFou3STF8ca56AhFNqe0nWCARls6cSPfNXhYEJmRTskCNIoxisUm+Ro8xW7zp+xXM
	4T/A1m6GyQgIVGHt4yYEPE8yE0Fg7a0I8/j9j/9H0+HFxUr/UIlhhRt31MduSjJKCEWDdYBlptj
	4AWAQ+LDVyAHC5k2nPCi7SMi0Sq3ued5DXRJ3RuuMV5BwofPy6JLYSDmDYgObHTcrwfoQrHbnGB
	kqMqHfueFygsGRdlHka0zukHebhDEfDmEN+OKQXTyO5r9gOj5lzixkz3WhL2JBqus9wmU5ApY/l
	oV+9shD/F9bX7RK3UqtHttP8HpZmBtu49hme+QzGDeH00+eDjgS2JRhmdTAcC7BI0sUszlsCYwt
	JerOeRSKcp14HVdebaf6LIFnYGc2XXVp4P3xICkazP0FfcvD8sMGEzfoM0/ACEthU
X-Received: by 2002:ac8:6f0e:0:b0:532:af50:8d7d with SMTP id d75a77b69052e-53511e71255mr148403691cf.33.1791221806463;
        Mon, 05 Oct 2026 10:36:46 -0700 (PDT)
X-Received: by 2002:ac8:6f0e:0:b0:532:af50:8d7d with SMTP id d75a77b69052e-53511e71255mr148402961cf.33.1791221805624;
        Mon, 05 Oct 2026 10:36:45 -0700 (PDT)
Received: from bearskin.echidna-sunfish.ts.net (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398a5c100sm100121791cf.7.2026.10.05.10.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:36:45 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.1.y] smb: client: split cifsFileInfo bitfields to avoid shared-byte RMW races
Date: Mon,  5 Oct 2026 12:36:38 -0500
Message-ID: <20261005173638.3905008-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026100537-childlike-directory-22a4@gregkh>
References: <2026100537-childlike-directory-22a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 19465a9aeb664f1d710d0d22c07c31bfb7c85446 ]

The invalidHandle, swapfile, oplock_break_cancelled, offload,
and status_file_deleted fields are stored in the same bitfield byte
in struct cifsFileInfo, but are updated in different code paths that
may run simultaneously, and are protected by different locks.  Since
bitfield assignments generate byte-level read-modify-write operations,
a modification to one flag can overwrite a concurrent modification to
another flag.

To avoid these races, convert these flags from a bitfield to
separate bool fields.

Closes: https://lore.kernel.org/r/7689764e-c0f6-4016-9557-b54cf4a3de4e@redhat.com
Fixes: 3bc303c254335 ("cifs: convert oplock breaks to use slow_work facility (try #4)")
Fixes: 4e8aea30f7751 ("smb3: enable swap on SMB3 mounts")
Fixes: ffceb7640cbfe ("smb: client: do not defer close open handles to deleted files")
Fixes: 173217bd73365 ("smb3: retrying on failed server close")
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Cc: stable@vger.kernel.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
(cherry picked from commit 19465a9aeb664f1d710d0d22c07c31bfb7c85446)
[ status_file_deleted not present in kernel 6.1 ]
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/cifsglob.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index a5e9f79c10f9..c37f10eedddf 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1337,10 +1337,10 @@ struct cifsFileInfo {
 	struct dentry *dentry;
 	struct tcon_link *tlink;
 	unsigned int f_flags;
-	bool invalidHandle:1;	/* file closed via session abend */
-	bool swapfile:1;
-	bool oplock_break_cancelled:1;
-	bool offload:1; /* offload final part of _put to a wq */
+	bool invalidHandle;	/* file closed via session abend */
+	bool swapfile;
+	bool oplock_break_cancelled;
+	bool offload; /* offload final part of _put to a wq */
 	__u16 oplock_epoch; /* epoch from the lease break */
 	__u32 oplock_level; /* oplock/lease level from the lease break */
 	int count;
-- 
2.55.0


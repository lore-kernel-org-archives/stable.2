Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65A3B2FCA
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477015; cv=none; b=luLGt1di1zO45lirGb6QbHSj479DBwOzzNl0pt4Ab90iktw99W47KDEDn5DrViK6u/gUACg02YaehJkNAIKbKbN2cxlfMKRV5uCmtGY2ltgcqQsYHvfheyt8BrM4YTInwoTyY8P343G7ljBRElGuZpF2q0KsHo3jUxmFquWCNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477015; c=relaxed/simple;
	bh=3x2XNScpLA7pdu8iUE5GPOaaChTsijxgHbzAPrI9O+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M4QFTxKXW8P8BB049wtAccJQLOlU/DZfJUS+RcivXPXmmSlNCfWB/CwCwl+gMEI5OOPykrafIeYJ1md5ceSeZ+qAfTlWTI2oQe318oEMTt9NYEASAPsnqCDDNMs9/R3bEm5CJlqQY2G1WzLeMmVMtBGNDQCwfmKXpVwr9xGHUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHK+461N; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHK+461N"
Received: by mail-vs2-f42.google.com with SMTP id ada2fe7eead31-7954fbd0ffaso944214137.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 05:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789477011; x=1790081811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bDZF9JSId7CCV6qo5hkoNAYzi1vRwU33Ad5zVuVmN2o=;
        b=kHK+461N4eamGh90QLwK5yBx1QBIaLqgqDpYLw4IofPRhk7aS8e6GMSlw1jmHHZqQe
         fc42e+JrJIi3JkDOvqQetv7rQB0GnwP17tPIZka5PpX8gGkmeXxpgj9egY8FQfjIyaSc
         OvQsIFHZ14ZdxjhaePA5VsIbyswtUycFjL2eRuL9aigSTX5tGURxT4Mo3vRiHVRAzZy4
         U7x7GRj3+97hF76YF3xL+fEMcmkP+etDw/kj2CdTPkmn/tckGO5UU72rpI3IPiRt29R9
         FDI2MDVnigBy/mWLOcpBd408ZroW6Styr9iIxmd5DM19WhCg5P1y91Sx8OFAd1GjtaQ4
         jx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789477011; x=1790081811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bDZF9JSId7CCV6qo5hkoNAYzi1vRwU33Ad5zVuVmN2o=;
        b=RtbQmeslQOeV1i0YzQ99ZVbAxp/84HwTaYT353X5X7u1j0+dwK1kPiTpbHaGTLSAn8
         8Ds2wE8M9xnPHdPW4KluUVjOZZXr2R9LwRhoLH9dqWI+OCUqHckd/ss6z3dKHJuuMvds
         f0JFaIQqmdx4Toe95s9vJE0dLnBA+UHjpSmRLw3fKCYFs29YEVfTjlDyQ7GpcUf/FXap
         fWePJEFkWxLbGGVFKPXZgN5AK/7ZfoVceV9l4CIxPKzn2PXWp0pp1c8W3RXuvTsyvx/U
         K05xGVwyS2os8J/ux5F5C8xxn5BoL8wI0ZYIOeaU6PCWRdkBeZ0hgj2nLDMskdRqqTAY
         eDRg==
X-Forwarded-Encrypted: i=1; AKwUvBylkjI6E0yrLcXQfxAFHrbnGxc3uOZOp0iTe5JWrXvmyKILQu/azpT3X35/DMl3bFIbT014WIE=@vger.kernel.org
X-Gm-Message-State: AFuF++kzZHHF1gtWAiZk38t09QXKwP+qKeGbw6WfGWKFrHij/1MYsltt
	Avhj6JZKZ4KuYhDzHTv9Tnf1DvnwI34bnzEkqqbDF4ewjZuz0yPCS74V
X-Gm-Gg: AYBFou3XEJdxpmVsC71JyQVDPeoGu8rRPsdjqPDhnIlk801d31r3Wht4Id2pukuv6KI
	ZVsA3AG+w1fbxkoasum74X+h6/N10CTc9TfHUeGaec/CxGt3DxhirHXQ8brKHW+KSBYURr2Gq23
	RtxXR/4u1uA+aX8e/EaG7KSj9SFgZmRmyLHuUJW+5znWigjFtf+IyFtJ4lVUfgJ4MukeI43flam
	ePmp6zCDjEH2Oi+l7jI80sFq8u+p6XtJXxedLUA+MFeVGO+G62NI41auqaDIVbG3KpDMjJPfoBK
	ueLEEIrCSvlAMCbfldDudIIR7uD/tx+UsITZS09JgsfJ6zihFN4YUmcZEmlPkhrAmwjf5XGPiQg
	SkfOwoMoZLkg/le2igqAITvP+hTi1AKWuA1NFu3rrIFb8sUCtr6CsxrvO4hzslsBx0BB+8PxVug
	n+R6y7UKTzz0IqVLbhyvpHKz5XDwsakFYCic6nglJ+xa1dWRQOiATr/O2Ef0xhRsil
X-Received: by 2002:a05:6102:3f0d:b0:79d:5bad:4c7a with SMTP id ada2fe7eead31-79d5bad6c78mr2752414137.9.1789477010891;
        Tue, 15 Sep 2026 05:56:50 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7927eb824absm13220097137.8.2026.09.15.05.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:56:50 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] nfsd: propagate SETXATTR value decode errors
Date: Tue, 15 Sep 2026 09:56:36 -0300
Message-ID: <20260915125636.2849626-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfsd4_decode_setxattr() stores the status returned while assembling a
non-empty attribute value, but then unconditionally returns nfs_ok. An
allocation failure can therefore leave a NULL value buffer paired with a
non-zero length and allow compound processing to continue.

Return the decoder status so that the operation stops on the original
error.

Fixes: 403366a7e8e2 ("NFSD: Replace READ* macros in nfsd4_decode_setxattr()")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e17488a911..27c1b42384 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2435,7 +2435,7 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 						&setxattr->setxa_buf, size);
 	}
 
-	return nfs_ok;
+	return status;
 }
 
 static __be32
-- 
2.43.0


Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498E353EEB
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787279350; cv=none; b=nk0d8POK0BPw2uTKcug/4EUsUr3c3EaveCKafCmj93UT4PbKglelqxLfg0L3wwtCLlV5b2piRjbYnRvhQuwvrrQStkz3p48iCJFJo865VfckYqTShP4EDNglzXBzLXOwl5bu4PTQKLEG4a5BJNiCdte/0e+Sg4P4vePjAtt7G1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787279350; c=relaxed/simple;
	bh=vry3klap9u4GjQNVsbX+2L8vo2NtkD7sLGYczUDYo14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g/P0wBDft6R1Vgoy9nXTjwI1mZn+6ZmhTR3YrHhPZ2UhSz043Gc4RoTeum2RyqVJxcgQbDpnMYyY2UWKOIXEyyuntL/xA8S3yNedfjp7WdFltg7fphmRR62a80za4arrlAjC+b7Sqy09vOZPFGU08gT5Zk/ZsnpHSGXMFzoZ4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0SEWAHX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0SEWAHX"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d58efc7356so6433695ad.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787279348; x=1787884148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=45NBjTXP85L2NWWZj0GIgJ+kRVkTLutBHdaU4FJg9VE=;
        b=o0SEWAHXsr3fNSZ+/Ut3M1/tTfe4xNFddBn4aGuvyArZTEGK486wHuQIyI8Irb/WDU
         NG1XwMdF+1ndQzRdtHmGzOEtwbXerNvex2m3Q9w8CpDF18rJwiiHMnzl8EIXLtWhhhv5
         Smu5npESZc/D03KeLodjNIkuxQT5VeUewyxQX2AyFE1OtPgm3qhn1HwpocUoY0jqxkaI
         3RbSFofv1E7WBRMt3XNcooHcsHOYZU91qmmVzW17WzxA7CML3Jk4+dd/A3nQmv65Sa8m
         7VBC42P07JRHx1Gu0EGFgEtFaihyD+c1hKAmFcfsuxjLL5Q4gubAys1TtZSfOph8wRgb
         1fDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787279348; x=1787884148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45NBjTXP85L2NWWZj0GIgJ+kRVkTLutBHdaU4FJg9VE=;
        b=W1tnzhyHGoAk1PZtCgTmwV7x3EUm+pY/cGpEEmCfwhX+9d6tPmCPu4mIfvVsU7SVNP
         rc2KVRpvDvP+KMBsywWmmnzMlZzTuXpjgJz7PA2/LhPXCFnfP2iY2eJgsid2il6ftZSw
         KB+GZnPszKiw7pOhqlEJkbiw7adGNAgRWmS9zAbTQv8W0ufnTaWvYW6OdcYVR1TfZZit
         gMPMpYVuHjfs3O+Sf6TRN3DVg4eNkeBaSiZeT2TiTHEJ7VaoTHn8kK+mK93FhacY3MXb
         V6VDfLlcSGGk3IBwzIE0hvJm3xjQ/YyRc753c/epstmcoj9yQiYjPXNRmpZGA7OLdd8w
         UFmw==
X-Forwarded-Encrypted: i=1; AHgh+RqihpDEPvd7XwYSv9SeG8O8qTuw+wrDw3jpyzEX9vBfNLvWf7ZPIcoz3jIGCrHXxsBjNAwuNdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywLw89CfO7us47f+NxVxl2IAmJiIVdjdkBV9bXY13fuRtD76Sb
	tt86XAkKcRKhdMf9sb1Uw4s3+PFNDxezpp3J0h7ZKq/BiaAhBOvqJZr4
X-Gm-Gg: AR+sD10+8s0Zbhoe5P69A/HrxffLPio4FDT+txgFQEPQFs+NnbPvljVZ9qZTtDwnzDv
	DLLVMQfPXLPDL+yvMSzeJsbR8alevXyRD57DvQeszCNgNzwIjxlR2L6UNe0WTOtCPbzfgkngEpA
	d6KzGAhKg5zbyeqfdeSB1Upn9O37OhVOBU/diRfA1z1bQSubW0CExs8q10vOk10hCndbGu+/FDz
	M8RD3JmrikGksaVy/XDKPxtIEp8X39MlnW1W6dMycuLkfQn5FIBBqaqHU0V3BO2UFKfjxgRWb3K
	RZbbG0EchyqNt0l+lsBIXtZZnEsNFG70KL8UUOg4gT1HK7808/RYxAbYvL0ms7B7Cx3ICNqoKPP
	BKHQ74vc52K2VV1gb54oUgsEYdnDPn+VxAi01sypLNFxk2lz5ueb+f2TebQWj5DERHmfg47orG0
	S6KHbssq16s2I5n5+y8rDec0zpPCRO3lClh5d8O/FV4CocUncSdoNbwh/ipjGW75xYim3ZRGISs
	0mnrlwX1RMkv2hdoiednbtVTB4=
X-Received: by 2002:a17:903:388d:b0:2d5:c099:16e2 with SMTP id d9443c01a7336-2d64b0b8244mr63255175ad.13.1787279347785;
        Thu, 20 Aug 2026 19:29:07 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3a19a7sm13135725ad.55.2026.08.20.19.29.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 19:29:07 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: gfs2@lists.linux.dev
Cc: aahringo@redhat.com,
	teigland@redhat.com,
	linux-kernel@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] dlm: fix RCOM_LOOKUP length underflow
Date: Fri, 21 Aug 2026 10:28:42 +0800
Message-ID: <20260821022846.56812-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

receive_rcom_lookup() derives the resource name length from the
peer-supplied 16-bit h_length header field:

    int len = le16_to_cpu(rc_in->rc_header.h_length) -
              sizeof(struct dlm_rcom);

The 3.1 receive path only bounds h_length to the range
[sizeof(struct dlm_header), DLM_MAX_SOCKET_BUFSIZE] in
dlm_validate_incoming_buffer(), and the RCOM case in
dlm_midcomms_receive_buffer_3_1() performs no further length check
despite its "length already checked" comment.  A peer can therefore
send an RCOM_LOOKUP message whose h_length is smaller than
sizeof(struct dlm_rcom) (48).  The subtraction is evaluated in size_t
arithmetic and wraps, and the result is assigned to an int as a
negative value.

Both consumers of that length only guard the upper bound
(len > DLM_RESNAME_MAXLEN), which a negative len passes as a signed
comparison:

- with rc_id == 0xffffffff, len reaches dlm_dump_rsb_name() ->
  dlm_search_rsb_tree(), where memcpy() converts it to a huge size_t
  and overflows the on-stack 64-byte key buffer;
- otherwise len reaches dlm_master_lookup() -> _dlm_master_lookup(),
  where jhash() converts it to a huge u32 and reads out of bounds.

Drop the message when the computed name length falls outside
[0, DLM_RESNAME_MAXLEN], which is exactly the range valid lookups
use.

Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 fs/dlm/rcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
index be1a71a6303a..14d5ab658f60 100644
--- a/fs/dlm/rcom.c
+++ b/fs/dlm/rcom.c
@@ -385,6 +385,9 @@ static void receive_rcom_lookup(struct dlm_ls *ls,
 	int len = le16_to_cpu(rc_in->rc_header.h_length) -
 		sizeof(struct dlm_rcom);
 
+	if (len < 0 || len > DLM_RESNAME_MAXLEN)
+		return;
+
 	/* Old code would send this special id to trigger a debug dump. */
 	if (rc_in->rc_id == cpu_to_le64(0xFFFFFFFF)) {
 		log_error(ls, "receive_rcom_lookup dump from %d", nodeid);
-- 
2.43.7


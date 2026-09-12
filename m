Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D717BB21
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171743; cv=none; b=o6aBq9trBaOxW7vGH9Czjd69xWoOdJBSBwbf9r66tLGnYlaW/RJVSQhWgrwWJv6JwBrBuIdOetWbl8kJ9iNkHhgXOe+pszTgv2pQL7FuXEHAnfchCTqO/3qfT49D/B9/liLM3Wa80qIFW2t3XHm1LTVi3GK4rx/9Fim+K/3zqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171743; c=relaxed/simple;
	bh=ygMKCEBw17w2TvFNF0QvzIbk38ofcVwwZgG68di1PHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QTNXojRRebsr6Gzcos1K+Rhium/UfdyT6QBeNG71KJ3qfOHP9T4L46wgETypaKpoH/SLMeXC8zD9Hr+xJ4+XC75pqP/kn9dHS/dBbQmuceDRE+R4RzWCkxPadbVeFSjY8gXSdmX0D5fm5kOftfm1sSMclVZW9dycDfhbYiHYmbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=YjI0ZWIB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="YjI0ZWIB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso15423005ad.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789171741; x=1789776541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+jg78uCdmO9sMjETRRr5TwWNFlS1xhamjhV2nUNuwjo=;
        b=YjI0ZWIB/nGMOm0UYOsz2fholhMeS08SmeOm964A3eryKyRbn4LreZzE9jKdS6DJKB
         tIJNRVZrPbxR89kUs/uWbWIdrsuhl3xn+PrWlGL+6vuzZCP1J+FsPqczOtrQy+V7hXzm
         e6/HgSVGD35LN8vnwvAWQsedFerHVmyXcQNfzN78diSInYBVBNmfqHMyOXVUqTMareM6
         PanPVU0nL/KVnf6VrVlsv2g0d9hXVIqOZEGRMucwswD9ZROAjaYqxTIZDxuEt108KC+K
         OSzSNnzKQm81lnhRaPwenW9S9BlvL0ibn5WdcKNHWqYpngn//l60mxpBaJ3DoJOie6HB
         psuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789171741; x=1789776541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+jg78uCdmO9sMjETRRr5TwWNFlS1xhamjhV2nUNuwjo=;
        b=brdI132+VW+EobDnREaPOG+teRkX8vsWPW7s2nuUtkapru8tlY2Eo0O2acKFVVpx+E
         jIhVez5y5C3TER/PQbPxJDxriXZR3lPQuLHOcodwt3R11sQ9mXDqYGs62AkOlInfgsgR
         RhUXmIiH4n7rEH4BJTCw0RWddP8472rDMRGSdNGKrwqQG2vDfBGw5bv3DRqvBFrYyO+S
         zOW4lLTb5choNiLaP1M4rs3tB/Cn6mLpnrDCXFRGQ+3yU5NT4AT0fkJtYSATp2qaOcN6
         YO03G09R8AK5n5ziV+N0pdnshY2DBOS8/NqWi/9/uxdU51CINtwzt135UShHjnT76gel
         Xe5g==
X-Forwarded-Encrypted: i=1; AKwUvBxvBYoeAblZkRs5+fNLyBlko3IkPp+HDr71cQY0aZNXs2/7eKNRmTtcy2HJAIGGn+RaWCJuD0M=@vger.kernel.org
X-Gm-Message-State: AFuF++ko7LuZBo3i0tBI5CdaM7V76MWhOuz4p5tDiJmxdE8wep47BcOG
	4f4j11LYm5XXsN3k9hnT7dyBID6YWKqOlmuEHSu3Hgtchc6ANoRUEt4UdhGBDM8IRQ==
X-Gm-Gg: AYBFou2lLH7ablef2pKqq/wWDnlkHgTvtIz+CRYo1ZOA4L9NMrYbRDdaCP3BefU57bP
	DjpmPVFHFfoRRX/u9asQwgz8P/shBS4mZZA6j3Z/JliGkloOHM9nrj/8ViwrWimcqhvQoe+dwfh
	lQNVlDPn3HFDBCgrwl7Ri0dYLzfOdNfdiAJNuaP0BCm+958wWgmkKR9ondpkmhBSCf7NFyRRSAH
	A4bmHTUT650t3SAw7xPMZRzMthE3juG/N7Oa+SroWuzMmXUZuoqiAxjxHrmBOjTvZZyaT43Y7Gc
	gOnL89kqbxZCKUgTnohh21ZM8j/2XhkH3kx5NP/Thf5UUqLS5JxL7vklOtN6ywD9eR1laL0qRRi
	3TlWBUcpLOBrRTDc4xbXJkMu0oczQQS2OttoNt/s1Hg4nS/UnuOju7n8+B3UShPTGOs7BdPDV0v
	xHjBehI1WpVUOikDD1Rp33Pwi8zFIu7wcG6Suj6MxD1XzhvqzQBS780IDgAK80/25pYSjAK8oxV
	U65ElOTy9I0UIzuwkv4lqitxyH0Jh6S9A==
X-Received: by 2002:a17:90b:2689:b0:398:9bd1:3211 with SMTP id 98e67ed59e1d1-39d9c21eb06mr10344323a91.18.1789171741006;
        Fri, 11 Sep 2026 17:09:01 -0700 (PDT)
Received: from gio.scai.dhcp.asu.edu (209-147-138-31.nat.asu.edu. [209.147.138.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e52a60sm9199756eec.6.2026.09.11.17.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 17:09:00 -0700 (PDT)
From: Giorgi Kobakhia <gkobakhi@asu.edu>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	Giorgi Kobakhia <gkobakhi@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH ksmbd-for-next] ksmbd: fix overflow in dacloffset bounds check in build_sec_desc()
Date: Fri, 11 Sep 2026 17:08:17 -0700
Message-ID: <20260912000817.763001-1-gkobakhi@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the large dacl_offset is provided, dacl_offset + sizeof(struct
smb_acl) overflows on 32-bit builds and the check is passed,
Which makes le16_to_cpu(ppdacl_ptr->size) read out-of-bounds. This
only happens for dacl_offset in range [0xFFFFFFF8, 0xFFFFFFFF]. So
the oob read is max 8 bytes preceding the allocated ppntsd.

    unsigned int dacl_offset = le32_to_cpu(ppntsd->dacloffset);
    int ppdacl_size, ntacl_size = ppntsd_size - dacl_offset;

    if (!dacl_offset ||
	(dacl_offset + sizeof(struct smb_acl) > ppntsd_size))
	    goto out;

Commit beff0bc9d69b ("ksmbd: fix overflow in dacloffset bounds check")
fixes similar checks in other functions. But leaves this one out,
because it is only valid for 32-bit builds.

Reproduced on 32-bit ARM with KASAN, by a client sending SMB2
SET_INFO(SEC) with dacloffset=0xfffffff8, then QUERY_INFO(SEC) on the
same file:

 BUG: KASAN: slab-out-of-bounds in build_sec_desc (fs/smb/server/smbacl.c:1105)
 Read of size 2 at addr c2a273fa by task kworker/1:1/35
 CPU: 1 UID: 0 PID: 35 Comm: kworker/1:1 Not tainted 7.3.0-rc2+ #5
 Workqueue: ksmbd-io handle_ksmbd_work
 Call trace:
  kasan_check_range from build_sec_desc (fs/smb/server/smbacl.c:1105)
  build_sec_desc from smb2_query_info (fs/smb/server/smb2pdu.c:7676)
  smb2_query_info from handle_ksmbd_work (fs/smb/server/server.c:160)
  handle_ksmbd_work from process_one_work (kernel/workqueue.c:3401)
  process_one_work from worker_thread (kernel/workqueue.c:3473)
  worker_thread from kthread (kernel/kthread.c:436)

Add overflow check.

Fixes: 8f0541186e9a ("ksmbd: fix heap-based overflow in set_ntacl_dacl()")
Cc: stable@vger.kernel.org
Assisted-by: LLM claude
Tested-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Giorgi Kobakhia <gkobakhi@asu.edu>
---
 fs/smb/server/smbacl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 7c60520f3b63..e75247915c87 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1097,9 +1097,12 @@ int build_sec_desc(struct mnt_idmap *idmap,
 			struct smb_acl *ppdacl_ptr;
 			unsigned int dacl_offset = le32_to_cpu(ppntsd->dacloffset);
 			int ppdacl_size, ntacl_size = ppntsd_size - dacl_offset;
+			size_t dacl_struct_end;
 
 			if (!dacl_offset ||
-			    (dacl_offset + sizeof(struct smb_acl) > ppntsd_size))
+			    check_add_overflow(dacl_offset, sizeof(struct smb_acl),
+					       &dacl_struct_end) ||
+			    dacl_struct_end > (size_t)ppntsd_size)
 				goto out;
 
 			ppdacl_ptr = (struct smb_acl *)((char *)ppntsd + dacl_offset);
-- 
2.43.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51E6314A90
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758346; cv=none; b=TqR6A4/smDVJoDaewNjEg8V75XarkG/ZHePdV/0w+4Qse1RQTmYmhZ3pm8QwRx/YtapE+WpmYK/4tT+TT893GJX8iAQ7vDfOg5Gyj8fpo9szQyF/0GZjaj2SVNpnDBD26RqWG9zkJqt5zCxQdX88RyT8j5FYZKmKCFp2E/T9a9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758346; c=relaxed/simple;
	bh=ymkOB8UMUk5U/Tsy8K8fpcj6cIsBZ2uNEJoBCL7v9V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBghgCEYR58lJ9SqZZ9g9DieIKlV1WBSvar1zxBjqi02WwI8FFZ/wJk6i2ZOUpKvz+aSQxqepP8Z/+98w1kWGE2S4zEfFtEocwUrE/aFCeAhFYqRnMFLYxKV22tNw4r7GM/rHqfezXGjfFEMIHvDtg3CP+wQnl5YSoDLWe6V4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUrC7ViD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mmc1a69i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUrC7ViD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mmc1a69i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787758342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00oADfE3L0pXKHn0B52AvTIT7U/c7rXCUL5afdTYVxk=;
	b=DUrC7ViD3HKpwxSySSfCMWD2+zej46uovWYcaybNV3IwdZnbCXMXLD4RgcFsCymP3VZLof
	QNPpoZWwsknElZYJ/nhKBkIXHXhK3JLG/IGwJkPnL1Al+0GInWfSdPyhT/Epr7qeDz+7qI
	qFnVUFNNz/YJiRn1k7rpa08HnO+d/+0=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-L763RCkFOQOcX4JSIjAgAA-1; Wed, 26 Aug 2026 11:32:19 -0400
X-MC-Unique: L763RCkFOQOcX4JSIjAgAA-1
X-Mimecast-MFC-AGG-ID: L763RCkFOQOcX4JSIjAgAA_1787758339
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66cefa68580so2100562d50.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787758339; x=1788363139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00oADfE3L0pXKHn0B52AvTIT7U/c7rXCUL5afdTYVxk=;
        b=Mmc1a69iCb5ESpjA5C9OZCIObEZaZKduLaFIXjod68Z+VsZ5Q6w56JMCdz8gc930Vn
         u4/zL6SYRygTs9lRKvTS8ZX/r0r2mfu+SuWLPWOz2D2jYoTBWCNMw9tYVYmO4XNm2Yor
         5PFADmOEILL7FYQjom6vD6loL/rBltWK+kI1serwbPFLW9O0CR6TgG172eHdPlPgrnTI
         FpVh4J/IWkPZh30BbgIEGuLOkjn37gKkk3DVz4rtiS9/diQ8XyJVrT7PjdBvtmS+2CtV
         dy+C7L4JJiiDeOQi+DV6oWN4EQTxFKhQE+MrQSMmGdFQY4qW7glPs7zqF7Z9DO01qTd5
         n0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787758339; x=1788363139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00oADfE3L0pXKHn0B52AvTIT7U/c7rXCUL5afdTYVxk=;
        b=jk+omC+RT4r9lsl6HfJOx5lFO8DfTInc+3lAKRaU/KnEtwlyG5fWK48SJ4TfaINLJe
         zJDIk6tu/0tRCddEBEYe/IPwInWJ0JGgmszRaB7aK1A1IlEPfBvi3DbgDovIoVUqsFcI
         hFYJvarNwqB4k6JG7xxTTUZdfao2MC0sKl0lD7eOa2xFBnK5KoLzr9xry3+cYisAVtpu
         fhi+cucK4oYeTL9ohyxeCJ5GSN7qVqIafq/XIZtGIGdzbW0ohT8wJ6L8K0VU31ermHkt
         LStB2k48y2PTQ3K07FUnpwobw3UAtmLmhcOGrKRf7tu4I+L7ItGiqTMqXZOHRGt2Y5nf
         N4Kg==
X-Forwarded-Encrypted: i=1; AHgh+RpUDWyum3L3s9CooafcXCG/I97p279ZdFgz37HbTcDq237CFTWltKZSRxNyEw3TVNolUWMaUH8=@vger.kernel.org
X-Gm-Message-State: AFuF++k1Fkj3E480yGMGc4/oA5Rd/4NnD9DdsQyhlRZRkjqFCW7qxK5g
	uvnyFK0qpH23K5YPckPNiMKY5duw4w7S4XIuKP3zi9FO3SfFWnZToZozFby0GJ78YFjYe5qlkyu
	wjcvB1cukrUWRUnU2aCywQs1JRICv/ALPw8ZsjfpHaEy4OhHbCNZ4DRVYNg==
X-Gm-Gg: AR+sD112ZwOWrrFUmWKUawFzQFdXY0w7PtlifsIg/55rmx0TELChJGwYX+Vmqerk1A0
	YVJvVXE2rXiJCZ0uQwFEwnm9QuC2l+hy7IhgHXT316/G/i3D7+O+DPFN7+JZ26JHnmoezFwiWR7
	TiPTV7RCkxJQ/E2D2DhP6C6S03AhjAV/JPKu0jlxY7wIvoa0USGWOl6ypl0Kl2IueNH/qGMzuyW
	jAB5f0rz4s9+GetsS2a+aNqBQPlQZ+2ALUzogWx30k3C4B81HBVYM7N2Rqql9SXuMQcqCpMnc/c
	u3ankdbhftkZ++oiSskKZD/L/2hxYzMfmKn1bQxMPJIVfdYsSDnWfHxZQieS1sAQgwqg9tPaMa0
	YtlovPU18TtEqLPq3kH3gXsn/Ury/N9gLS8bCQLpNlARsv3feKeMV4YpgJD3VArAxCg==
X-Received: by 2002:a53:cd11:0:b0:66c:bf45:bc0a with SMTP id 956f58d0204a3-66d25666916mr2085821d50.11.1787758339184;
        Wed, 26 Aug 2026 08:32:19 -0700 (PDT)
X-Received: by 2002:a53:cd11:0:b0:66c:bf45:bc0a with SMTP id 956f58d0204a3-66d25666916mr2085774d50.11.1787758337244;
        Wed, 26 Aug 2026 08:32:17 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d24592f24sm1598209d50.6.2026.08.26.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:32:14 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 04/11] smb: client: fix missing lower-bound check on DFS referral string offsets
Date: Wed, 26 Aug 2026 10:31:40 -0500
Message-ID: <20260826153147.4112943-5-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826153147.4112943-1-sorenson@redhat.com>
References: <20260826153147.4112943-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_dfs_referrals() checks DfsPathOffset and NetworkAddressOffset
against the buffer end but not against sizeof(*ref).  An offset smaller
than sizeof(struct dfs_referral_level_3) places the derived pointer
inside the referral header, causing cifs_strndup_from_utf16() to read
struct fields as string data.

Require each offset to be at least sizeof(*ref).

Fixes: 4ecce920e13a ("CIFS: move DFS response parsing out of SMB1 code")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/misc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 46e1382e8e04..bc7cccebf387 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -787,7 +787,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		node->ref_flag = le16_to_cpu(ref->ReferralEntryFlags);
 
 		/* copy DfsPath */
-		if (le16_to_cpu(ref->DfsPathOffset) > data_end - (char *)ref) {
+		if (le16_to_cpu(ref->DfsPathOffset) < sizeof(*ref) ||
+		    le16_to_cpu(ref->DfsPathOffset) > data_end - (char *)ref) {
+			cifs_dbg(VFS, "%s: DfsPathOffset %u out of range [%zu, %td]\n",
+				 __func__, le16_to_cpu(ref->DfsPathOffset),
+				 sizeof(*ref), data_end - (char *)ref);
 			rc = -EINVAL;
 			goto parse_DFS_referrals_exit;
 		}
@@ -801,7 +805,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		}
 
 		/* copy link target UNC */
-		if (le16_to_cpu(ref->NetworkAddressOffset) > data_end - (char *)ref) {
+		if (le16_to_cpu(ref->NetworkAddressOffset) < sizeof(*ref) ||
+		    le16_to_cpu(ref->NetworkAddressOffset) > data_end - (char *)ref) {
+			cifs_dbg(VFS, "%s: NetworkAddressOffset %u out of range [%zu, %td]\n",
+				 __func__, le16_to_cpu(ref->NetworkAddressOffset),
+				 sizeof(*ref), data_end - (char *)ref);
 			rc = -EINVAL;
 			goto parse_DFS_referrals_exit;
 		}
-- 
2.55.0


Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B323E764C
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498582; cv=none; b=hVPD3l0opBupOUHJzRrNMV7KwIvdscoL94tM+QwUXc1HPf/VvEsYb6ffh6Jyc1vNu6MEcVUgfHwpzNstsD6ha7etCU6pYiHB8O90Oz+AfKg4Dbr/msTrmnUHZFE/aoexuB0WYT01mfwfZpr6bnD+9N21HfABJQBu/phZWuG3yPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498582; c=relaxed/simple;
	bh=MMkFjdCVMG5VlmQMbxTqaxCN0UUVNziiQoEjmEPy7OU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nrgyxp0nxQkv2XU+Ok/yhigKFRV3WkC9UCNLwZhNrPJdLynLcrpyGFBlmP02PoFCQkazfvSF21CKRTZ3baUC+4g8TC7oKplQh01Kf6PSQNGRxQxBIAwYaYFuS+e3Tsh4dihpLqCnAa0+edyGvsL7zUOV3vET1TtZJFs/qGV0yYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=r3ELd5KY; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="r3ELd5KY"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-823e4047037so3407287a34.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1791498579; x=1792103379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fXHi3/KeYOzGlvHrMQmcR6EwJ6rahH5N/eWTDsqU4mE=;
        b=r3ELd5KYh+ph7WvPnW3eDjqD+R83vkIzNIx9LMbwxhDI1xkpMXrL9OMr5aULjlEYfa
         U+ML5WXLyWEzaVjQD3S9P3hZdfd72qBvWffJIZvdWhsQmBchRKU6EWOXhiPNQmhYadCS
         UlBs0eY+ewls+RTLmtQbH5wCQIyP0v4r5vkO6U440d4TVR/56XBUF7cOhZfP1ebU2lG+
         +uhom1xPYw2EecL9SyRRfnb6CtuJ1YLypjFHaSeNB/pMX7CFuJzsfiW4uE3bQ3soLA7x
         n3xjApCKVwFPBJwRjYrMRgvvpb09iX2CWV3iFVCOfCWd5TCjD82U8CvSrQ6D0JMaaxty
         mbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791498579; x=1792103379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fXHi3/KeYOzGlvHrMQmcR6EwJ6rahH5N/eWTDsqU4mE=;
        b=PyY3swUMRUlwf0bPVv2EXy6F8yYsJRTkRLCmmRkxxBbv2x4cVauzRinK/bJs/tBcEr
         DEtgAQFiyBWLJ8nR8+RusXAaRQnEAzgbCVLl2O3+afMXuTFlRdC/fdH7Q/04LShkC8kY
         o6hxMa8dbY/x9w4tLq0UlOK1YCA5vGq7spptxNPaXXbmoqUX61hQn6yD7skewmgrNtn5
         B0yE/e4ir3zDOzNONePfuQcy2iBWGYa28py02bGaqgrUXAQ6j9ycRd6OQsxa2ekU7kiT
         YMl5XZ63GZQZUqwhlszFXrPi+maol18uO2ju9UXJsWsY3Vj2SefGPdiZNBL6FNZzRUXF
         dL1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwdJMfeE7P1XLgnlWHYMpNBQgGsJiRysKemvn+nwfxBpV0e8PjEz/wAZrkBN1c4zwV0jXy4dpo=@vger.kernel.org
X-Gm-Message-State: AFuF++klQayEB2oS5x8V4u2HysTqTOR2yUK84g+6lXHpQ7cM150hcOSl
	DvFmpkAs4Tq5qtkowXxURHc86RtsSLpPDu/XLg1kv0UEGrpeQDozBp+KrJMp3VXI00AEimCgJyf
	00r7ilJQ=
X-Gm-Gg: AYBFou3jX+XftCfeExWyW+ooznqiYaPtvbaC4UaG2GKrljOK7WojM1RHv9Pri0fMY5F
	vkdIbRB1tU4NIvZFHs4L48Oloei5lql4i18rGOBAM/XQjCayQWRv1bTVazSuFzf2aPMypJpwInV
	4eYW9p9qNtkNQQf7kHCrxlrGsthJY4v2GuLHMLSureBIcVzhuplNgJwdc92vbzr1YN6O+Q75SuD
	p15p2Y65R9JFabDglwiTdWxxFv0LJJunjW5eVVN7AU1SzUslYAvoqfRYc1islYj8maar9vOasvT
	4nNnwDxYp3glxO9NNtaPvbnb7cZ8PjrnKngHPf1OS5u7m6DbWch47nBbapapOCraICcAuSticmx
	e2WNm4U+V9xNmZ4ysWb5JH0ZKLrMxF9dM7muSokKbiXjidNt3MtqACOIDzNOT7bqQykEV09+ubQ
	gjwWnBCUgurKF00xQch1pjtNcEAFSyS5KtLLtgJ2PjQ3+SHYz+EmYwSZWwSTKfp9DgaaLhY4uoT
	nU+gDjLPQKF9+ipgrK8SkZhc7RHwnvLxlU/
X-Received: by 2002:a05:6830:410f:b0:81b:c6da:c351 with SMTP id 46e09a7af769-8302ae8089dmr414913a34.17.1791498579523;
        Thu, 08 Oct 2026 15:29:39 -0700 (PDT)
Received: from irdv-lubao.dev.purestorage.com ([208.88.158.129])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-83038f82468sm278874a34.11.2026.10.08.15.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:29:38 -0700 (PDT)
From: Lucheng Bao <lubao@everpuredata.com>
To: linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	tmenninger@everpuredata.com,
	jcurley@everpuredata.com,
	Lucheng Bao <lubao@everpuredata.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] NFSv4/pNFS: defer LAYOUTRETURN after an unsuccessful OLD_STATEID refresh
Date: Thu,  8 Oct 2026 22:28:43 +0000
Message-Id: <20261008222843.63319-3-lubao@everpuredata.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008222843.63319-1-lubao@everpuredata.com>
References: <20261008222843.63319-1-lubao@everpuredata.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c16467dc03db ("pnfs: Fix handling of NFS4ERR_OLD_STATEID replies
to layoutreturn") made stateid refresh fail while newer layout segments
remain busy. The standalone LAYOUTRETURN handler still treats this as a
completed return, potentially discarding a pending LAYOUTCOMMIT.

Set rpc_status to -EAGAIN before the existing completion handling so the
release callback defers the return for a live inode. Leave successful
refreshes and inode-teardown behavior unchanged.

On 6.8.0, this change applies without commit bbbff6d5edd1 ("NFSv4/pNFS:
Retry the layout return later in case of a timeout or reboot"), but that
commit and its prerequisites are required for the deferred-release
behavior.

Fixes: c16467dc03db ("pnfs: Fix handling of NFS4ERR_OLD_STATEID replies to layoutreturn")
Cc: stable@vger.kernel.org # See commit message for prerequisites
Signed-off-by: Lucheng Bao <lubao@everpuredata.com>
---
 fs/nfs/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1ae047a062b8..9993e4d29d72 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9867,6 +9867,7 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 					&lrp->args.range,
 					lrp->args.inode))
 			goto out_restart;
+		lrp->rpc_status = -EAGAIN;
 		fallthrough;
 	default:
 		task->tk_status = 0;
-- 
2.34.1


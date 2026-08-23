Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACDF388866
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511526; cv=none; b=FJlMzlH8RS1CW8E2O6PveRpL76IoPSjS1M6vJkzUjtdgd8tVoYE1VliNLPU4kZKQzeLiS07rrVY0ofOs73kWPn+U2TVovmmNMe5+/6vxlvSojwpaRDmINasOKVb8Z+rC3vdSowzIBcxa61NMZ2vd8gGCqLN0WBWlHgpx+wmhcWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511526; c=relaxed/simple;
	bh=EhvDNaCN4ln1V4VGK64WbgDj53Eqm+A//1Pik0bbpSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzP6Dw8bVOYJw5KYzmw5Rx1Ys5x2AfqU99HLNIMGqwlCttz0CLAUyZd4kJjdiCqSstDaUx5crSdW7UgzVX7EwEpUrU6trOreZJYPasNfwcXhZUE5mftt3JnpfnRAh8FPzkOfr/bOss+UqSW/3ljrQAYu7vX0WjK+eFo5IVrP5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iE392Z5i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pjS2ireH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iE392Z5i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pjS2ireH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787511524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIVhAaiWo8zlaMZvR5jj4DeJp4hplmxQu8aOHpcJh6Q=;
	b=iE392Z5iB6lUB9e6A482BYgET8aWTs9ZeM2y7Svddy5ag1e/6zxosY9sR4cMxr+ZuqVwSp
	w5iJ0KANIiX9XVI6PB5TiAavIt/HZnVf5NCQhFU1fSnq86IfSr6i942tVe1BKtyNVUCp0n
	wLNEzJgGjQ20Kz/pvjFu8Zu40aldAl8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-ohPpvOCLPpuuaDCa6YyggA-1; Sun, 23 Aug 2026 14:58:42 -0400
X-MC-Unique: ohPpvOCLPpuuaDCa6YyggA-1
X-Mimecast-MFC-AGG-ID: ohPpvOCLPpuuaDCa6YyggA_1787511522
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7f1ddcd241aso6305125a34.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787511522; x=1788116322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PIVhAaiWo8zlaMZvR5jj4DeJp4hplmxQu8aOHpcJh6Q=;
        b=pjS2ireHtnP5aFLmoHbqCumnqL41dtMlglCI2tV2sPg4jmq2A+ixWdRFHhVhJbzm/x
         u0uCtPXOEjh5THN0aO+hsJBLSWLqK7qOCgKxMsTub47CE7kC0YATYrTqc1tGk5l1yu2A
         UVpnrnbXTnNwDrqz6CInAlAuSZ0rpcUtykH4FI8yHCATypuhdBxvxL0WK5874XgHi3Jk
         glSrUE1+9em8yp0jswJcB95rpkKDvHJwjfcFpcXW//r2aTTDg++zkJSfs3vYoXSfBpEV
         SpwmTVXR/WrxD7viaKdJY+Ls7DdYTuQEEFTIuK7/QqV8JGmb6XN9ScCtXjl9100Up03I
         L7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787511522; x=1788116322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PIVhAaiWo8zlaMZvR5jj4DeJp4hplmxQu8aOHpcJh6Q=;
        b=Ndew9aEV9HegI2PQSTtrwDiwmDJUavNj3/Esg+uF0XKYQCRrDodhxdTYtf+zofcIt/
         DGpDRNsgmzzpRUihPZdcyBqv6A2PZlEZhXjcsYY1TGE6zeIWTYzNfb/Pr9Xhn2BMn6up
         7l8vVECmFclJqSrWcfh56Dxa+SGttVbh+Cv4Z6N+qpcXXn3jkRlpsO2nwuAG53DbVV/W
         ezliKywyCQuiHrNbIdkrMphjnJ41i+KLTY5JLJA7eFiUeUN7aLaqb/lFrDo/a6Cw+E8J
         yPqg7qcq6HJlbqVllSuhxU8JfPES8c0lVcLkl4ZDJF4WrUjp8KuXIr3pBYEAkiKdx/WW
         6yYw==
X-Forwarded-Encrypted: i=1; AHgh+Roe5w/zVMhA7tiLIUg7qPg0OH1HBce1LTfK4OGazI6YWpBENwqbaSpQMKSWRbt1BiJ0Ha2VL5A=@vger.kernel.org
X-Gm-Message-State: AFuF++krI+GJ8lYEoC06/Yxmd92HlMWlVhixd1FVLPiTrwOjFUfvWhs5
	V4thZ19TRDMHq6vlsY3Z+oMK+ZOtxn+J/0ZL5LoaCcUUFKs2r1hfO//doNBi8lx2/1uWF5mxXFG
	+yuge3ont2T72pXyefMAZAsMUfyokWfjfFybMrBmLQr2pDTauEUEJctqi4Q==
X-Gm-Gg: AR+sD12VJa0ie80+R+oXJDX/wUz6kjswrov9Cg/kpuJWaekVCxSjHGxi+U8KaY9kIpw
	l6101anYjHYGsQM+9jRIn4EkmjkRS8DOEXkE20CRw0y4EsYWw2vmSAwYFx0t+Y6E2HLDQle37Nb
	C1PeKIHfS2JprrMwWtOk1UGuNqupd6CHMshkwZt0/H/3IFppjn8U4pbarrxGmnpyvKpG7TthmI9
	4FfRg2L3/YiEH/jyLsFO8muXGEMLEQy8kwQavCzYiDuyxfE109TCvVE0iU5zM78P0XkarHOKw7n
	yLFctFKY1z/e5iCeCLg0XSKvT5Yjqhth8vThM01XP7lTQHgMHspltvQHmax/OVwzQVoFf4rD/3Q
	AxVw83YN455BOweXNf+qD1jLrfregarQzP+raBv7v1vAyJizguLBl39UtR9v0Vuhu2g==
X-Received: by 2002:a05:6830:4995:b0:7ec:6749:f38d with SMTP id 46e09a7af769-7f46132209emr22697911a34.0.1787511521765;
        Sun, 23 Aug 2026 11:58:41 -0700 (PDT)
X-Received: by 2002:a05:6830:4995:b0:7ec:6749:f38d with SMTP id 46e09a7af769-7f46132209emr22697876a34.0.1787511521340;
        Sun, 23 Aug 2026 11:58:41 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fb1db63sm2518710a34.12.2026.08.23.11.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:58:38 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 05/11] smb: client: fix missing lower-bound on Next field in parse_server_interfaces()
Date: Sun, 23 Aug 2026 13:58:01 -0500
Message-ID: <20260823185807.3115901-6-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823185807.3115901-1-sorenson@redhat.com>
References: <20260823185807.3115901-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_server_interfaces() validates the server-supplied Next offset
against bytes_left but not against sizeof(*p).  A small non-zero value
passes the upper-bound check yet advances p by less than one struct,
causing the next iteration to read misaligned, overlapping fields.

Add next < sizeof(*p) to the existing bounds check.

Fixes: 7d34ec36abb8 ("smb3: fix for slab out of bounds on mount to ksmbd")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb2ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 1bc3f8266eda..9065c94e5ec6 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -785,9 +785,9 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			break;
 		}
 		/* Validate that Next doesn't point beyond the buffer */
-		if (next > bytes_left) {
-			cifs_dbg(VFS, "%s: invalid Next pointer %zu > %zd\n",
-				 __func__, next, bytes_left);
+		if (next < sizeof(*p) || next > bytes_left) {
+			cifs_dbg(VFS, "%s: invalid Next pointer %zu out of range [%zu, %zd]\n",
+				 __func__, next, sizeof(*p), bytes_left);
 			rc = -EINVAL;
 			goto out;
 		}
-- 
2.55.0


Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7F36B905
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734035; cv=none; b=qNSfeAqqg2m8NB0YhB7Sa1Oxj6c9xkVcBs/pRtgqDoVlkAAmy6vUjLL1QefNrGIFIdpEI6Oy3DtvC+2nN2NibC/yDfoDKWlo+fhewhoDaAKW/YovQj1TIJUcClFZhcxqdo8KCnk4R/Kow0HKSfmmB06WWS8o/z+yMNRiA8ZQLfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734035; c=relaxed/simple;
	bh=SahaqTYujkb8uWiEjHesvmnsDrkgl3h8uFSzuw7Gx5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9BCQzHoGfpVT8yzXFWw6sZpTfxM02kiK9y+hxiaCJ5h87XLCKjZSY+oBaxf+z25oCHVwPABqcC5m/1K6A9wzPFhEmw3dTIjBlMtzvRXTcWVzGUYKQDrJ13iaMl6o2CVf7cd3us+4EJtu4HITYmXKsJOddLCpI3rrpCLUcD5Ico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rneyclS3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rneyclS3"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93695893ac1so100342385a.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734031; x=1787338831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDsc1xS4FWzL2UlZko8rXMKKZH8FnkzYTI+gpvfXX+U=;
        b=rneyclS34C/n29SaJKWxGwhqIV1f3o7hJCXC3tpd3qfMdzGoRKahNLTohxGoium1+l
         UKmooXCoBrqQxu9fOnF8o0X5wP0H21CcrIWMv2glxxGgUTwsqkdvrkp/vJSUZfn6PZUG
         C4YyO75IX/MOeq/IKj8SEd+avbg6IZRwAck7mPCTKxm6akUhxYcMXu1YETXk50hPV3Hf
         SE8CdNFGNHA4Mcr1V5tcoR4nLIDJkC8Igv3QOraGNwD7X4Jqh0B1Na9tAPP7NvJQo+PR
         EYs9L6AKWmem6zxqcJfgo+OmjE74nMc2QD7dERT39+WDP7g2LT8lyM1rsNUl6PsSHoIl
         ml/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734031; x=1787338831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZDsc1xS4FWzL2UlZko8rXMKKZH8FnkzYTI+gpvfXX+U=;
        b=l8HEZ7OeTFfodPkXomLsa+skc4bwtB/rEQLQAKq4DJex6UrtbgCKyJdC+9jJbA7xMF
         nFQGnhr+FF31xERXaXsDGa+i09JuttYBe9tzPDgK5lh/+XepXJysRbOfwScuyMTQyxSO
         ghNn2JUtNhCJenq/0syatE/tVT2cO+47EeqM4UJWEvTKTJ5cHQCgoEq+HlXUcfAglciJ
         Kufg1m7WOwKFNVbCg49YSWTvBYUX7Vy1KggNiRXfCdSqY4Qt/cu20dgL+bwvg4KSQ14p
         bJ+9Knc/N42BdNUUHecxfcU76pCPsWa7QZqRCr7KoF370mMNTQvwjPrQVgc9qJbUcrlc
         AZSw==
X-Forwarded-Encrypted: i=1; AHgh+RphMY4aSgkhiK2row39Xfa7VXcXRrPtQd6MXKP5VMf3bl6d50YHfkDZQ6lw0DphOnU71+EUFuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ThAgE2BIDxPTYOPMvR6A83EtoWm1A5CpE1f1VaQR3xLjo0+N
	aaptdaEdvzpztCVuENvfOiG/khxLop0cdbO9fHx+kFDNIvLcjvcf+oAA
X-Gm-Gg: AR+sD113gOaOwqaQedpEUk1rJq2B+nxKtBEJlyhIgpIekkAcviAaH1LnzKFD8RThyCR
	fMI3zweSMplHungYOoqPqFFk+vCVaJiyzQwFThJJYQhBBvfos8ca1mm+1LCD7H8I8KtJIEgdEx1
	EfRIm+1GfBk22Q/PxR1WgQCl68dnc9Qi9toJPDMsKmTXjFDnXoxM0aK6A65LlyB4jO0e4rdl6EZ
	06sR/yysJ5kDZJeei7bIwBQ15LXJ2BK1yE4q9r0zIG07b+ydmhwXQc3KMYk7COhi9YjEesY+nEf
	1t+d8QKy9Ourw+eolafd5LpdaCKERaTETKtskfUTn0Qzf/Rlvmop28ZWDXAldIoa4wYQC8FwVl8
	oKFSQ6puF1ohg2oWSr0tnk5tgjVKORBFyEjLXSYbglW2ieKWL1RhsUNE0zeVgV3kO4SrYobw0Ug
	gdwW7cTgfgXlK14UP9Y394iKwPJQ5Eh34A2htPjTvufGLZ6Krg9rcYuileQLDzYHtpBbqKv1I78
	9bpca9gEVrrmSfITR+o5UZRsQ==
X-Received: by 2002:a05:620a:3998:b0:92e:4859:49dd with SMTP id af79cd13be357-936d235fb5dmr604811585a.26.1786734031224;
        Fri, 14 Aug 2026 12:00:31 -0700 (PDT)
Received: from shivam-EliteMini-Series.syr.edu ([128.230.213.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce0b23d6sm328700285a.18.2026.08.14.12.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:00:30 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: security@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	kumar.shivam43666@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-tcp: fix NULL pointer dereference in nvmet_execute_identify_nslist()
Date: Fri, 14 Aug 2026 15:00:22 -0400
Message-ID: <20260814190022.1531236-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081423-enlarged-dribble-10bb@gregkh>
References: <2026081423-enlarged-dribble-10bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvmet_execute_identify_nslist() handles the I/O Command Set Active
Namespace ID List (CNS 07h) with match_css set. The per-namespace
filter in the iteration loop tests req->ns->csi, but req->ns is NULL
for this command: nvmet_req_init() clears req->ns for every request,
and CNS 07h uses the NSID field only as a starting filter (min_nsid),
so no namespace is ever looked up. The intended value is the loop
variable ns->csi.

A remote host that sends an Identify command with CNS 07h to a
subsystem with at least one enabled namespace dereferences the NULL
req->ns (at offsetof(struct nvmet_ns, csi)) and crashes the target.
Use the loop variable ns instead.

Fixes: 61c9967cd634 ("nvmet: implement active command set ns list")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 01b799e92ae6..ab6a0a98dd5d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -958,7 +958,7 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool match_css)
 	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->nsid <= min_nsid)
 			continue;
-		if (match_css && req->ns->csi != req->cmd->identify.csi)
+		if (match_css && ns->csi != req->cmd->identify.csi)
 			continue;
 		list[i++] = cpu_to_le32(ns->nsid);
 		if (i == buf_size / sizeof(__le32))
-- 
2.53.0


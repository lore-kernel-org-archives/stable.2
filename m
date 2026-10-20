Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493711;
	b=JQz+XB8N534XcCmRiy6k2kUv92rBNARvs7GP/sQ8Ouj5Wu3QKAH+127bosUTRfFczqJv
	 SJfhpt/8pvXgi5PjZFXj1Yn0dDxbpytYnegddgsdPxQYCiTbn7ZN2IBRribNC83+lYbBw
	 RNR6KMH5O2m9+HcJdOJ6AZyvU/xVsoLPurj7e3XgrEtXeDcm09BAfQs7w55EgXVpe0nAm
	 YYVlYBqWLRzF4JyBNdxuMAYgAu5VlkV5260QUQnQAjCLSPmiX3L2khbcH2JbLCpEtUqUT
	 JurUWws8baW2bKk/m8ONPUUUio4nkjAK+A1ntpExDEtwgMj0vgjY8YziYgfnTzEdrUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IstVKehuob5ZIhaaqjFytiIbVJXifuNQQEI4PdRRqKY=;
	b=1J5k2E2BVyK3gh7K6Wxl1lrA8IdMrsZ+xelADhaD6gGrmO/Goy5A6mAv8EXdDxXpNttb
	 /L2EELUF1Emm0Z1wdxtHXJAJbzaWuhMXgpZH5fmtfE+tx+yE4pq1wJfVkCdTCmIUvANI0
	 ICDB5OKBSbbEgNEAsGSmszSzVI5ATykjsPjJ6uJiuqjUtD4Lgmh3TcpLv4jk+Hph0AXRz
	 82q7eEIi7k4gx0KU2jfawc5G1DLau5tf7egRoUuTH/tVFqK4IROjirIhYMEPS6fCDAOiY
	 kY1JCyYET2I8Hjg8mI9pUldWfDGGGCfv4oAQir4rdEVg2AjR4VlYai23Xh5xihMH8/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=JaPrsPrj;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45A2606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A45A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=JaPrsPrj
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3514b90bb89so8172717eec.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1792493710; x=1793098510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IstVKehuob5ZIhaaqjFytiIbVJXifuNQQEI4PdRRqKY=;
        b=JaPrsPrj9GeCZwISZw+iAJEdGZ7REpTUqAGwnwGjWOb6k9c/wwwAz6Rq6F2uUefBAc
         LKS6bBcL3OQX/xiSZwHT/pUHnAhPrM6+DxEt5Nso7+hZbwfpG1NpNYydJ3d9Yb7le+6P
         fsMGnofCnV5OwyhACJmu6Fdyxti6U4ydv2S1SIKFf7Vm68PHKiZjmpsrimUmOvty8b2O
         2qUoglClmTI6RPq6j9a+oThKPfZJvcP4rS/K7ejovJY+0qmTXcpspDrNMQIQUaJRMC2k
         H/6G8eh21X8pxQ00Y1A7TNPJoUJjczCIls2mgvPzxWgao3uzbyyThrmE3iPKPgGfMLQq
         ViHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493710; x=1793098510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IstVKehuob5ZIhaaqjFytiIbVJXifuNQQEI4PdRRqKY=;
        b=ovwSmU3gcjTBdd2BdfSOSGPAyalqn88HE09isKk44ZuEfbTZ8wDMhbpEKzoevj3fod
         B8orqkfejQB4iPvy+AxaP+VrTrLcWtzn7jvARQAEBNfNO/tukVFqNFEbY9II8AduPxZo
         KoVkdwCuGtjCr/EGuueneRfDdc5/8b3vBLWGl3OguKCpkdkWN2G7/8GQKwmBmIWuaRLT
         narNnqE7RKZMFAEqEujCm170KxOAzmYpcqv3JsSJpUNbq+HnH+K9HUnPi/LYJkfbie4W
         GRaJIXbYsCMUe7I+D+4rflYW2b3Ag2QvNlUqOHmz5G4WWoQtwcPfnz13lWdDbTllUXqr
         bX3g==
X-Forwarded-Encrypted: i=1; AKwUvBziHdYTOtV11bV6m6RWT3O75XzthQk0X5g2fLATdauk0tBThPfgukIK1ycRmRWgPSR7FSoGX8w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRhz+Xy3pmRI5rGJw9OJPfKLlqJlZHw+xgHOYU/f7f6txDuecP
	5LpN/MDv9j4iOHFg9WuYRy2sz7r2ZUjdaZ9mEj2tYXM0KNhXGRcj+rkf/H+8U5nQ3KY=
X-Gm-Gg: AYBFou0UC/ktUxPlXmm9hutaUZmJ71BvzE1F/psbhgMGmIJZGPoj63GMDVwf/MYMdGR
	TERp2O8PWNWMFmEXPzfYid05FlswKlw3z3RHdeUcD+Ye++TIe+NVD3MByk3eEJyjXrAzaYCeN3E
	M12s7l/MYyNLKBpqtZZwgdfqKufrSj9ePrKsdfs3KQ2JgnxK4P1FWlYN+r68A2nEvrtuc75LsWr
	Mep8z9Lib6hgNG+XFIFEOLzUEljw3MCl2wDzdWG/cz3HdUtm43jZw0RL2tKWmKNgaAhLsf1zGR5
	qWWjFfTb1nTsNRNWpR8r7IF4kQjAPDsNYVjV9pSqAKcjTc0egOP2WHa+3E+G/iwH3PSZQVESqMm
	jNa4Dnp1uRhZD6rFifoQcsclUnp84lkm1Xrv50D2dfixs3LxxsG6zCjbctdkzc/WhmvqS9lnUhT
	L6Puq5Uep+AG1a9yonNnF4gZI13ZrHANR6IsCMLnjZ9aL9Eu9jJulweT8GgM13HNcQH31ZwcDtu
	0wuz16Gba26V2FOxYFjPQ0Ocm4JfpCL1vkBy6Nod31VtZtWnsCjNfwSLLLCXzHc+zOR4qgue+bp
	4D0MDBL8iYDjUaNTTsS8OtgwbcQjGA==
X-Received: by 2002:a05:701b:4550:10b0:150:1cea:31a8 with SMTP id a92af1059eb24-185125790a4mr14974157c88.19.1792493709497;
        Tue, 20 Oct 2026 03:55:09 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm42255592eec.21.2026.10.20.03.55.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 03:55:09 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>,
	gio@octane.security,
	stable@vger.kernel.org
Subject: [PATCH v3] vhost-scsi: zero misaligned I/O bounce pages
Date: Tue, 20 Oct 2026 16:25:03 +0530
Message-ID: <20261020105503.75904-1-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
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

The misaligned I/O fallback copies the full bounce scatterlist to the
request buffer during completion.  If a data-in command transfers less
than requested, part of a newly allocated bounce page can remain unwritten.

Allocate bounce pages with __GFP_ZERO so all bytes copied during completion
have a defined value.  This path is already the slow fallback for
misaligned I/O, so the added initialization cost is acceptable.

Found during an LLM-assisted source audit and validated with a QEMU/KVM
vhost-scsi target using misaligned data-in commands.

Fixes: 5ced58bfa132 ("vhost-scsi: Fix alignment handling with windows")
Cc: stable@vger.kernel.org
Assisted-by: LLM (OpenAI Codex, gpt-5.6-sol)
Signed-off-by: Shubham Antil <shubham@octane.security>
---
Changes in v3:
- Restore allocation-time zeroing after review confirmed that this is an
  already slow and uncommon bounce-buffer fallback.
- Keep the change minimal and document why the zeroing is required.
- Drop the transfer-length copy-back change from v2.
- Add the discovery method and the requested Fixes, stable Cc, Assisted-by,
  and Signed-off-by tags.

 drivers/vhost/scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 885fac5ed042..8493a372de6c 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -937,7 +937,12 @@ vhost_scsi_copy_iov_to_sgl(struct vhost_scsi_cmd *cmd, struct iov_iter *iter,
 	}
 
 	for_each_sgtable_sg(sg_table, sg, i) {
-		page = alloc_page(GFP_KERNEL);
+		/*
+		 * Completion copies the full bounce buffer, including bytes the
+		 * target did not write. This is already the slow fallback for
+		 * misaligned I/O, so zeroing is acceptable here.
+		 */
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!page) {
 			ret = -ENOMEM;
 			goto err;

base-commit: c69023b5e16e5ffe9368603dca76d85bd544ee57
-- 
2.43.0


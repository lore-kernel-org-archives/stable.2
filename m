Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE951A75B
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752305; cv=none; b=RM96FvURRt51uLQOLBjjTo4ZyYP5wfQvvc5PFNA9QaXfwGHClXHBe8bs+A680CX+EFpWjYdz/07+vLTS+VT+zgPWDbbmTcnMpBmlPgO89BwVIFnK/9/AiG+aoFI1lvEsqA84e5tJgNpxHuryCA25U1uOhn5lxBJsiCg3+S3VWIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752305; c=relaxed/simple;
	bh=nRfKlU0JdIMS7pIyYOtNbNNL4qpg+eZ3q8lelnV3/Dw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L/NFgw/jHDtPfRui4Zh6XtCV80gTUAmPjIH6pJthdaDcXZXaUWbuz0pevJhzZCD2G7lDiE9BS1yzkQSBJXh6W1M0X12CyzDxfQDwQoX4QDw7fES3+Dp86yDzlDFfCN4a0g9hIM9nWqMS7PKCN/kLxlqqlBLQyrpCPD2OU+6oam4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPZtFI9U; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPZtFI9U"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e3dad7ab3so1432251a91.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789752301; x=1790357101; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=72PNOxgvBxEa/OyDxE8+wmcHMjmCVv+wNt0o6l7GD3A=;
        b=sPZtFI9UvGlBuVl0YFIBiV3HSGFDTjN4k0jifAQJLlSSLvxHJ0crOFZqrSDA2kTt8B
         dqR5qdzoIaO7svteRzThvMEr/YUXqDMDiYbh1dIc2UICHX6FrQ8GzWd7CH/FQveFIrH9
         CqazQnxkEQaWLIa/2Mr9n0PpqKg8XFoGFZe9YQVh6KTODbX4RhIA5p/KaUTWiVhlv+pe
         oP/Z1TQTSl6dqFQRPvrDCAV9wy+7BS0yhXfx0r9ufMieeiYTyPB379JYf62J+E5GGqFM
         UPKQhZgql1BVIMEo1cJcYIztN7pUP+feRFV/7lBZN86LDnvWPNqVhV0aInSGN8adBHcx
         k93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752301; x=1790357101;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=72PNOxgvBxEa/OyDxE8+wmcHMjmCVv+wNt0o6l7GD3A=;
        b=VQ+Y9Yg64zX6DHqRiYH69BmeGB9jLscUqkgx97wm9Wdwg4ztqI0cJIrzNkPg9rOgyA
         usEPp5/mHPAAjjf5MXc5kCr6GauZYIHwcYG+N0ov+NnBWj/Q15i3MBkZILtefboHz+D+
         erfU0oRv5TfpoJ/zLMvKzHo9pT5sQlWza/JHBpyR0ma4xhC2RGeVMjpiJ/0y2NRm0Nvy
         gFNsCVNDJw5yewl9Ac9USti82lEuVHyBHlIDY5xDPNLXVhV8/INc+AsPLuq3OmKROsop
         M/WMypN2DrORZv7sEmzYcsI17w013EWTiMgcHpfaX5c8P5tN2519F2plQb11d9mkp7dX
         t2kQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5gDsDQ2ikZUqk2g2sjkh5icmEywnucOrTaGB9L2p8EWKpIdacpHtK0zas8D0ChM53FTnWIRc=@vger.kernel.org
X-Gm-Message-State: AFuF++kMHnETSiSi0is/1ywfGW+SH62x08ANTKjX9ZJRwOZd07euNaY7
	NR1wZOAilZWWdN7ifY3hpud3BrR3VYwsbhhMMf/LaQxa99ine1i+T+sU/RXZSatZd99Pur6zYl4
	iPauZS84MHYlYerohazOA7ewaRgq2kv4yqA==
X-Received: from pjue21.prod.google.com ([2002:a17:90a:e4d5:b0:39e:6e36:d13d])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7c9:b0:39d:f615:725e with SMTP id 98e67ed59e1d1-39e54bc3a8emr6915187a91.13.1789752300888;
 Fri, 18 Sep 2026 10:25:00 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:24:59 +0000
In-Reply-To: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260918-b4-fix-aer-memleaks-v4-1-f0a2c21ed1d1@google.com>
Subject: [PATCH v4 1/2] PCI/AER: Fix memory leak in aer_recover_queue() on
 kfifo buffer overflow
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Priyank Rathod <rathodpriyank@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (aer_regs) from ghes_estatus_pool and passes it
to aer_recover_queue() to be enqueued into aer_recover_ring.

If kfifo_in_spinlocked() fails due to a buffer overflow,
aer_recover_queue() logged an error message but returned without freeing
aer_regs. Because the entry was rejected and never inserted into the
queue, aer_recover_work_func() could never dequeue or free it, leaking
the allocated ghes_estatus_pool memory.

aer_recover_queue() returns void, so the caller ghes_handle_aer() cannot
free the buffer itself: ownership is transferred to the AER code, which
until now only released it on the success path.

Free aer_regs via ghes_estatus_pool_region_free() when
kfifo_in_spinlocked() fails on buffer overflow.

Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data has multiple sections")
Cc: stable@vger.kernel.org
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pcie/aer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d8dcd238fda1..b013b853b555 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1415,11 +1415,14 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 	};
 
 	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
-				 &aer_recover_ring_lock))
+				 &aer_recover_ring_lock)) {
 		schedule_work(&aer_recover_work);
-	else
+	} else {
 		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
 		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+		ghes_estatus_pool_region_free((unsigned long)aer_regs,
+					      sizeof(struct aer_capability_regs));
+	}
 }
 EXPORT_SYMBOL_GPL(aer_recover_queue);
 #endif

-- 
2.55.0.1082.g2b9226bbc0-goog


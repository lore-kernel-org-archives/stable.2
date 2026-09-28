Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6D4DE72A
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617236; cv=none; b=epaVBj6KOnL1atlcvmoNFEKsWqPWxJ102O9eKGKBVHAahJGdKP9QSu9fTFVHRkaOeXzbnK6eVfFRs/YGqoHtyvQbGlMYltO3+n8YOjvijak+tl0/YIEoSOw7RNRXn6Wi6uqFghxFbwp3de7ITKupZsc331j4NCuli50zspSK4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617236; c=relaxed/simple;
	bh=bhpyAU15yC6QPGadz4JxsbfOGUa1ye2WK8iafRoSRFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RIjByNbiILH7A7/8Fh7NJwCXrXZscgL/umsaFx/Uy216lg0F2BzX4/bBCrsa10PGgJ5ANT3p+NHaa2OOhokSSBdMorwAejsQOAvAQERxI0UZ96BtjYn699y/xL+Ymo5B5hqHbf1Net2UJvhOY/K/l0pVc++GBAnMkXvGQVyJG1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oFFw/qtm; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFFw/qtm"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a47617a0b3so1066428a91.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617234; x=1791222034; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sw50tyOgJDy5SizTNDQpXrNC0JD8AqhCQeUwJLrCoro=;
        b=oFFw/qtmkPcaAdDhrUT5O3OKP1pPiLdlkXUnQWEkCnpfSnvmQ4mKhOQTryU1BlQYUh
         WvSCFj5VZVY6FQr7ftU2w4p9LC2JMiew04+IT97ZsM+M8Ab0ESNZ+vbgdDbvgBQS6JnV
         S9djDEag7sU7dmZD14OmkRvzAlgtWNepeV7HjC3sAZGJLCzRjD2Mq544g1HvQT/oVIGO
         i/2M9RBU8xL03m8QLIhxQ2juNBWO75WGenLWGMPOy1ZrGrOJzFZGyWz1juvnoMq7o7yo
         xGOAsnVMheqlCu8Tuf/NQ59bBfeSGVqSzBSzT3Ef97qPTzMKQrWJPdu/OIkvhg1OF4Cd
         PYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617234; x=1791222034;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sw50tyOgJDy5SizTNDQpXrNC0JD8AqhCQeUwJLrCoro=;
        b=yGy8XCSWQnixUbqDUPfi+cNW6HFsjnF6rNAD2Sj0NzreydI84XrXVj+P1a04dezOXU
         1m9eSk1lL8v9sFe+cY1cu9MCV+6sHczziFtBiv14rpIc6m502+X4WhgX5AekYY7ku5Ub
         Gk1Yep4g9Txc5W7EhEpiFzoLQJPdNOoaGXRmJlOKNJeJ1UqtNO3OyKirHQvA+56j/9SU
         QMo2yrh8gRqFKklF+DXl+GwQOMRSIluKoZ9Rk+d5Dh4oGffZVLR8cO4RSC8vfmmX19/G
         lPYgai0IVlR+1egZUBHv9OGWeFiUJ8d/KEA4MwKmaPOJ75wOK+ASGobcVQgu4PrnrYT7
         rKCA==
X-Forwarded-Encrypted: i=1; AKwUvBzy9TkCX2B0i5Xcw8EXvBqLqURp5DgsT3+7zeE6WjKHr3mlKtB+6uU1s8L5l4kmM7Fcux6xNsI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRO+L4b0dVzhlDWTSiOjCaIqMup8yvibhlgBbw1qXAgT+iQ/on
	yMdLeWP+SIN59miUqx3N+lkSWM570LAUjLU1tnCpPq23zlspmVkMRneKeDQno+qLNymCuvBIc+9
	cQJAlvs83g5Nkx2AX41XeQvchOpmxMBoNAA==
X-Received: from pjyo13.prod.google.com ([2002:a17:90a:eb8d:b0:3a0:dfb1:6c07])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3a46:b0:3a2:b04e:8086 with SMTP id 98e67ed59e1d1-3a2b04e8389mr2449084a91.44.1790617233471;
 Mon, 28 Sep 2026 10:40:33 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:40:12 +0000
In-Reply-To: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260928-b4-fix-aer-memleaks-v5-1-ba6b94c9c9a6@google.com>
Subject: [PATCH v5 1/3] PCI/AER: Fix memory leak in aer_recover_queue() on
 kfifo buffer overflow
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Shiju Jose <shiju.jose@huawei.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>, 
	stable@vger.kernel.org
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
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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
2.56.0.rc1.315.gc6ed9934b7-goog


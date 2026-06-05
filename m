Received: from mx-lax3-3.ucr.edu (mx-lax3-3.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961733E367
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 04:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632772; cv=none; b=hUGg3JlH46lKxDWG5dYzRwCAhaM8XDTJtcwAEknrF++vqBjnr+TSOIQ7BbLh/F9R+4O9/gdaRA6NNr5QqojyFypLqqrQaJaJ4YlZiWfLjz/Bjl4Vvl731DE2oG5ZBIurgm9DshnNQpmpUYOIEC/8uU9IDD3UKtd27pcZgxO5OIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632772; c=relaxed/simple;
	bh=tF4VCUWMwA8I4mOEUXGPkwnpitmDIcvOstPj9/un8WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOJJ52whS44POHMNPbN8ONWtpZVmg/QebDE30E/xrfoQCc/cam5ibEbmD3IyDBcIhPosipVMVjZCJPPRzpHB90fgkrHnwlNYyrrPI7dGTrCjk7DLZ8E1bYfNE2gFKiegbwqBPbGvrI1M1jzrJuLQuR4Y8KXCZ9ZP5myWq+XXkO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=mBRYUpAr; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=EomgBQkz; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="mBRYUpAr";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="EomgBQkz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1780632770; x=1812168770;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:x-gm-gg:from:to:
   cc:subject:date:message-id:x-mailer:mime-version:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=tF4VCUWMwA8I4mOEUXGPkwnpitmDIcvOstPj9/un8WQ=;
  b=mBRYUpAr6bAiYhVRmHwv5V/H1SYHi2kRqkywyPUwy3r6M0o+rfHABovL
   5igUODNQhZytDyQjRzNzS9g2yMBwhptGXyuzekeHt1dqahAb5oYUcTCJc
   xNA+Ph8a/nL7tAs8QEZqABnaaHD+NpIMI5oHR2CAmwRMY+8UKD4ElWM2e
   5f+0bcAbCSjWKr1S1Pxv9RsznG7ifA5WUCGm59KlnqStNmPWL/dtOf1h7
   PPMeQPdfmyitrivGpHdrvBnKd50Xs72yoT916t31VENXelDqtrV8xAkFn
   /fddhxPfOKxXzCFKS8W20p2t5wl8uGz0yjfuLeacVSZgfQmte/4TWjIWP
   g==;
X-CSE-ConnectionGUID: 9AUzBcetRCOtgXjT06Bn0A==
X-CSE-MsgGUID: oN3oYU7XR3mpwBNA8VYXeQ==
Received: from mail-dy1-f198.google.com ([74.125.82.198])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Jun 2026 21:11:42 -0700
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304d0d0b28eso3973177eec.0
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 21:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1780632701; x=1781237501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n2xSodZLUd/O6lqqf8zgeCW/DSEP+QUBHBJ8tI2sjPA=;
        b=EomgBQkzelkvvbCa7b6UIhyco+Yog1IP8fhNBWl6wMNyn7I4p3ePUlwfaYRoqgzhgg
         1ykredmk7TeA6UZN98wueKhZOaxw7cKM2v08S5ZR3VfhEYzydThcypuOLNLwj/Hoot7i
         OnogIavNtptH1oQukwTvXLTIVskgeuVX8a54s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780632701; x=1781237501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2xSodZLUd/O6lqqf8zgeCW/DSEP+QUBHBJ8tI2sjPA=;
        b=QbMN0Sh1UNic6eh83Hw+LkO86rG1VsNdtApDXwLQlnMV0h4hwL6QIl6yqXlKXSYXbT
         qy3dx959xmYJE6aBtp9RJmhAzTrxUI3Z2qqeww7YxMYzNxNSjk5EGsdCpZWdcxzS1mrB
         ZwrWw/moN14aFAaiOuLLmrb6b3fqjZnqIr+OuXuPVi2VAFaVoS5i/A2HFF0in+QfVQ2u
         yPPnUoOWqXoN7tYQ7OjtIH5ZdnH/5OZQpK/P+IDKeTA4yqOZDxbc3XK4CZUe3HZJNSNK
         vrt3S5MEKrroBa2njh8b+XN0/GhULTHmorc2GWNgQx8XfWo5Dd7TEktfoo9GiWJUnHPJ
         9wJA==
X-Forwarded-Encrypted: i=1; AFNElJ/rmk2h6Z42Qj5oYWp0xXcZ6RRxQXbRut6jjKyDURfiJF0kQwDFja63jpGFbwIAUlMWEUXvqj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD4Gql+xyhJ9ga6D5Ry8vzXQtEZ0Dk9fUe0mGZ1aFli3i/t9z6
	FfozseDFKNGs4lKuHEl2qkyRfEQfebZoouQxHqAuOnFF4Cupd9+2w6/j2mD/dUHV4N4N3GTJ2DP
	JGCMNX5QlNmTynZTgq69Irq95Zbtcrm0eivPTI27w/9sXqNVfFNqqlhEKevY=
X-Gm-Gg: Acq92OF6uG1+iAJH2K6Jcfe59ml46mL6CFkVbLcWcj16a/KvZR32Wi/ecxMu+tmDlvq
	2WJnY/JRvNu34XPBm+iH55rIvWEh5L3TaxhzxHVhIIe8ptoLSC688n3YBPxIosv7A+SWpdUeGkM
	YP4yg4CMvdYasRb2qc0vaW19Qp/cgaOmxAYLCA3Gah4ADnYxftOdipnRbj8VwPTDxrhSkkFCJ6m
	I4bhKIrE5FNJuqjB5RC9BVwZd3gTWFv9xJ0C1w/DezigZPkkOzOtVKf+gNJMG+qvXpeBwS3dEyM
	Weh9GR5zu7SeSycmZ3k1294DdT0r/9hD16Xa6bT4qRqXXTNtX7VuJ2F+mWFZniIhaMwQu5xv72D
	wTzJ6uDTlTvHv89w3xgHenMTq085jnBB75W9SJUfuLJp1tJv71B0BF9FfoyKm7OXD5XL+k2wcJX
	59pg9KnUGRMH7zPmbtzP/8mx+kZDg0gx0x+WelCLOOp8cdP2wee4TCmsgz9fj4zYyQS35KFuEOe
	f9RIEKnxb8N
X-Received: by 2002:a05:693c:69c4:b0:304:cefc:5fdd with SMTP id 5a478bee46e88-3077b7595demr498042eec.20.1780632701223;
        Thu, 04 Jun 2026 21:11:41 -0700 (PDT)
X-Received: by 2002:a05:693c:69c4:b0:304:cefc:5fdd with SMTP id 5a478bee46e88-3077b7595demr498034eec.20.1780632700764;
        Thu, 04 Jun 2026 21:11:40 -0700 (PDT)
Received: from ucr-secure-48-10-13-243-195.wnet.ucr.edu.net (ftd-border-nat-ucr-secure-v348.ucr.edu. [169.235.95.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8e8csm6723500eec.16.2026.06.04.21.11.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Jun 2026 21:11:40 -0700 (PDT)
From: Yuan Tan <ytan089@ucr.edu>
To: ojeda@kernel.org,
	boqun@kernel.org,
	rust-for-linux@vger.kernel.org
Cc: zhiyunq@cs.ucr.edu,
	ardalan@uci.edu,
	pgovind2@uci.edu,
	dzueck@uci.edu,
	Yuan Tan <ytan089@ucr.edu>,
	stable@vger.kernel.org
Subject: [PATCH] rust: firmware: return empty slice for zero-size firmware
Date: Thu,  4 Jun 2026 21:11:34 -0700
Message-ID: <20260605041134.38290-1-ytan089@ucr.edu>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware::data() builds a Rust slice with core::slice::from_raw_parts().
Unlike many C APIs, from_raw_parts() requires its pointer argument to be
non-NULL even when the length is zero.

The firmware loader can represent an empty firmware image with size == 0
and data == NULL. Passing that pointer to from_raw_parts() would be
undefined behavior.

Return an empty slice before constructing the raw slice. For non-zero
firmware sizes, the existing firmware API guarantee that data has size
bytes also means that the pointer is non-NULL.

Fixes: de6582833db0 ("rust: add firmware abstractions")
Cc: stable@vger.kernel.org
Reported-by: Priya Bala Govindasamy <pgovind2@uci.edu>
Reported-by: Dylan Zueck <dzueck@uci.edu>
Signed-off-by: Yuan Tan <ytan089@ucr.edu>
---
 rust/kernel/firmware.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 71168d8004e2..5e22a574a91e 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -106,10 +106,17 @@ pub fn size(&self) -> usize {
 
     /// Returns the requested firmware as `&[u8]`.
     pub fn data(&self) -> &[u8] {
+        let size = self.size();
+
+        if size == 0 {
+            return &[];
+        }
+
         // SAFETY: `self.as_raw()` is valid by the type invariant. Additionally,
         // `bindings::firmware` guarantees, if successfully requested, that
         // `bindings::firmware::data` has a size of `bindings::firmware::size` bytes.
-        unsafe { core::slice::from_raw_parts((*self.as_raw()).data, self.size()) }
+        // For non-zero `size`, this also means `bindings::firmware::data` is not NULL.
+        unsafe { core::slice::from_raw_parts((*self.as_raw()).data, size) }
     }
 }
 
-- 
2.43.2


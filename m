Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313062;
	b=OIR1kL71x625Yz94EcCnpQT7/fBDKm7JMO25xZfjqjiYFQVT1+/DM+2+Ua9CmxHA94WZ
	 Hgv73uAlebMWWKRaCSM6EmZXLvbHrvZxACNXZpfvLo/YswCTmbOWtZCBdjevZRtGFZCH0
	 aLkXBOMg8eVgMPmSuamQ4DIrbxTfVGBL8+lUTTw4F1YDFkXZdTtTYZbisMXilY9jS6Ybw
	 dd1s8otcwQEwQlW9Z+60XPuv3CyiiAleO0VIu/ef8JIzFWZPCFcp7qztlLFjb/VQZlPUA
	 aqd2lx39I8QoaDDR46b8056QaIIiaa72FecPQsFYDx8vukOCJoQq2qI4Q6qlRuZ+27Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=PjRDWUymC+7EL3JaTKRije1yqTzPKOHWaJhKCJD3MI0=;
	b=R7h/KNkEGn2Xyej9FGCEPwNRrI3kVoPg0y7FJclV0EQW+06Wt6oHTE7++FLRYp/A423B
	 Ix9WEaqk6DMaZVn2KVmpfBGoDntNOQBFGjqZHF0Ayt8bndlE/iIyEodL7jLA/oGMws1GD
	 xl2NWFJsMEMUlaLI2qK3mL30zqLSs/+gABwIUclgtU8XZ3pjKlS+tAV7heuNZkalts2HX
	 bdWn6ypQ+01mUXEjWX7TqLZIti0ep+VLnCNFjyupy2Y4rYJtkQ3O6ll6KWojUwIR3FsW0
	 nU65HQG3RQKjR0tWb4KbkdWBhEreitj0sAvoN9Q0TAXCdXFE4CCnaG+WJ1L1utyEZow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ardb.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VfPDp6es;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B6B606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00B6B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VfPDp6es
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4ad3d35e899so16400995e9.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794313060; x=1794917860; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PjRDWUymC+7EL3JaTKRije1yqTzPKOHWaJhKCJD3MI0=;
        b=VfPDp6esFbTdostXxuwMiec3e+Z8+8kQ6nssx9aJVdMDef9+XEmhv2R/Kn3swT1R+/
         GIHpTG/Zi5S13Kd1XMGTYtV6xgOYZiT8R/fIL6uVR+ILe8wSBA0Jtip5Qep4fA0QSigI
         K0PmNjv/eJe6bDSB/X1eKAkD1lc5xfDzJiiwSHjiy9S2IYIeB7ZJ5oM0tRhUoCpWar5T
         H5ed7LJSnCu5RDjaNyKxZkNggbdlECs7f87ik8RWvIZKJGs1De+pC7C3rG8dsYYQxpbE
         qS+Z+9iHvm33hxtA77l58grbPVc5AI20i8eOtHZ+Bq0BJWv1MfyUB91apTfOW3mX+7uA
         XPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794313060; x=1794917860;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PjRDWUymC+7EL3JaTKRije1yqTzPKOHWaJhKCJD3MI0=;
        b=RDQoCHhdNQv/+ryJ1GTVy8e88N3G4xpdtMjKQl7Iwz3DOhUYw+CPMbBPbU4tfVVx7F
         ekIOuGrv3UI36Jht9FjzLUnUvAByBKVlQvF9+wG/kYIaIaNC1kMMDZpYlkfqD/wn0R2R
         k66dINfEbRAPbPMKTuh/Ai5Xlcp7oq9czmnuPLYgwu4sQr8w4n75zy5kVSUKyaf4oRVZ
         TzjYsEl8ZNNZIl7gc1cPBCfPRgvBU5jqbwuHHYmUPy0cKilTXWl2s99s+MBwDFwRImGI
         oyeWNKH4vK85oupCmsrzeHI59zarVoT8b9v0VoCX67UDkNeIJyH8R7MW+YFTka5f3rND
         UFag==
X-Forwarded-Encrypted: i=1; AL+hErGD4doQa0Biy6ny/3IGz/xNTPvwDzQ3bksrWK3NUWC0ryLKfRsptVd1tqLS3gPZjx5GHwQP0vs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AHYzdVGn3GaTyXs0IA1ww6zS2P4p7jsrrZPt273a3t70MfyMh
	Ww8tmmQjCempQvLSu8dEld11YvpS78u0S2Mxu/GRWJMG6Kr0y7kBDNA+DB/t6IC/Ulh4NMmxBw=
	=
X-Received: from wmbc22.prod.google.com ([2002:a7b:c016:0:b0:4a1:8bbb:59bd])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:19c9:b0:4a7:c366:d791
 with SMTP id 5b1f17b1804b1-4ba02308537mr40596315e9.1.1794313060140; Tue, 10
 Nov 2026 04:17:40 -0800 (PST)
Date: Tue, 10 Nov 2026 13:17:33 +0100
In-Reply-To: <20261110121731.2728824-12-ardb+git@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110121731.2728824-12-ardb+git@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110121731.2728824-13-ardb+git@google.com>
Subject: [PATCH v2 01/10] efi/zboot: arm64: Add missing barrier after cache maintenance
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Prevent the I-cache from fetching stale data by issuing a barrier after
the data cache maintenance completes but before performing the I-cache
maintenance.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm64.c b/drivers/firmware/efi/libstub/arm64.c
index e57cd3de0a00..62fc8e53c8a0 100644
--- a/drivers/firmware/efi/libstub/arm64.c
+++ b/drivers/firmware/efi/libstub/arm64.c
@@ -107,6 +107,8 @@ void efi_cache_sync_image(unsigned long image_base,
 			base += lsize;
 			size -= lsize;
 		} while (size >= lsize);
+
+		dsb(ish);
 	}
 
 	asm("ic ialluis");
-- 
2.56.0.542.g3ef89b7020-goog


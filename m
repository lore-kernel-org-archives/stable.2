Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B734443315
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390837; cv=none; b=U5CDsxLZRBypQuhx4ULP9wrnLyIkMRPqpTAtcKAfVzkzb22FJh4/MzmNrucpg+AUjXlVEPg+J2V1gBe6AKzQ0E74p3Ta6+hig88CmoILBd9MXspDvpTqNZyK8tFcpWAMGBC04So05cGtdWN/+RGM6lE5x7JXbnlABjO+DoNzPys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390837; c=relaxed/simple;
	bh=hYk+xarhTPEsRWdAy2yebQ28Z4YDVkB5v5kYWMkVqds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3mXLaEz2WPcaCMqsVs0YAAmthgU117fz5e6uvRPm/URMprjrhnTn4KPZ1cgX4F5sgyzojSZTgutOulZ0GysxgOtAOJ2WIXw2uJoZCoR0knfnhwp3dOCNWVkDIC+Gz/lMTF0d7TLyumo5pcrO3dLiBFcB29ChlZ1YLKuzr2O7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEGtQhsM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEGtQhsM"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso3032434a12.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390820; x=1786995620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UZlUEzCrTPRBX1FvFK7zfpZyojdDsTGC8+EAFkSxizE=;
        b=ZEGtQhsMx080qLIVx228RzAeqAhZwwhwkciWUOCi8Eds45zxKHdNFM3vpAgnhcXvzX
         ZxNLa80y3wPFij9MAX7Vo96OI35FN3+cAXTinp6ZzUsvZQFAGRLGGq/GmFoxdSwvbb5y
         5qUrdJNZVEbsp3FzRmG/p3zee4+QDtMMn3bByZcQkkPKPgvjXvxSO8uou/rbcE++oAwx
         5f/5JBItDXRmPYTpTnGNVjq+FxCnlbNtkRmRJFDT+jN7Os53P6L6TSd23dqF6RgB2lwW
         yH44JlI52b2Rw3XLULM6izxR7nllD1t+CCiDlAn1F1OR5vYZyB3SHvVfl2DY7NSvW+kw
         WBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390820; x=1786995620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZlUEzCrTPRBX1FvFK7zfpZyojdDsTGC8+EAFkSxizE=;
        b=sWgXO5Z80/DlRdJF3de4XmhzUB6ly7KVTWAOiy+KavY/cOO4XLpoXKRx4e20tG5Q3E
         W3IiSjegAjzdOzH/XJbWM+oa5Dse2PojsUGTZZQKjaeVfJbVmv/FUbmItN8qRN5yjo4E
         AVZQMA5vUBNTUd0HgQDkACvP/nAGmuad9MgK7CvYAn0WWmWZMwAtaNrDzKqfnsggH824
         Ir3YIGdigoVbup/1ZNBynOOcLLvztRcRfS3sPFaOukF+YuRykx4Jjz86O7GK1qQJOTvw
         4Ky5VKlvzrypmEN14syWObtjDYYMCxvZfgBi5x87MEcglS5tS/+iU4+Id8SxThA2u46L
         OW2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrEP5v84Q7WkbNgIQZgwWb2pKB6uUPv+uReZLgGXTqm70vep9TzgzspSpi3v/oki5MhW/teZvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRXgAKWhN3c8seblkNaY3ndN6Hi5UDF9W8bog6VZ/2ucX7yAZr
	YDnOuVoUQVU1cp/ZJrJeg2Sx0avIortpsX59yjBHo/c6gJU11XRNKJ8p
X-Gm-Gg: AR+sD105gxOvqqakZZ2AZMeM5SSlGw1xvW0QGwksa+aA/AY8baACxS6189k0IQo17P8
	5aWC4qCXI6aRoOqZtmtTMTPH4wZgaU4LFdmGogUHb9aRUjvSjVSfuMn84C8hb8ma68pvKj7Mz9L
	WKwAELn9fsOUja0OEg1pV1cUiJ4vSnYKU1gGPyAohdQDZYHHwZu2EQGQ6cWGN3locNL1YxGkM9N
	JcJ7gKfEnfSMVAeGnLhw83lAIm3qv0CUUcyEY3aBD5P4wUML/RYgiveoExEWPHNE9hb/hONSkgA
	iWqnf2bp9dXozkb4PVJrNh6uQvh9knwvrgK4yzOrpDSyfVIpkC/8Uc95+ziTEBIaIHMGRdYS+ZS
	AO6XMe8o9HG3CDlzajdEyrEqzW4ipKnnCOkASq1NnjXHHSpFhCNEwe7ZkLVI6C3qxCpve5ySO03
	xZe9Br1cPYfp7BMIvsZnOs/09hs83h0EFvXt7iPyGdxnqyjzNhyuMKBpgv1PUjm5lLlSVMN1wL/
	ZbSfde/S/K3l7uDm4PzuBGN5my3jW0=
X-Received: by 2002:a17:907:c5c3:b0:c1f:1520:4de5 with SMTP id a640c23a62f3a-c20c67fab2dmr191394366b.1.1786390820261;
        Mon, 10 Aug 2026 12:40:20 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a29a84sm449928966b.3.2026.08.10.12.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:19 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de,
	mcree@orcon.net.nz,
	ink@unseen.parts,
	macro@orcam.me.uk,
	Magnus Lindholm <linmag7@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 7/7] alpha: invalidate the local context in flush_icache_user_page()
Date: Mon, 10 Aug 2026 21:34:58 +0200
Message-ID: <20260810193902.3286353-8-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810193902.3286353-1-linmag7@gmail.com>
References: <20260810193902.3286353-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flush_icache_user_page() has the same caller-CPU omission that the
previous patch fixed in flush_tlb_mm(): when the target mm is not the
calling CPU's active_mm nothing happens locally, and smp_call_function()
handles only the other CPUs, so this CPU may later reuse the old ASN
together with the translations it still holds.

This matters here in particular because the function exists for
operating on another process's mappings: the comment above it describes
setting breakpoints through ptrace, and access_remote_vm() reaches it
through copy_to_user_page(). The calling CPU is therefore often running
something other than the target mm.

As in flush_tlb_mm(), the uniprocessor implementation in
asm/cacheflush.h already has the missing case.

No imb() is needed, here or in ipi_flush_icache_page(). Alpha's
user-space I-cache flush works by allocating a new ASN rather than by
invalidating the I-cache: the entries stay, but they are tagged with the
old ASN and can no longer match. An imb() is only required when the ASN
space wraps and numbers are reused, and __get_new_mm_context() already
does one in that case.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 988e397b0b8a..e21bc3920bec 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -758,6 +758,9 @@ flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 			preempt_enable();
 			return;
 		}
+	} else {
+		/* smp_call_function() does not call back into this CPU.  */
+		flush_tlb_other(mm);
 	}
 
 	smp_call_function(ipi_flush_icache_page, mm, 1);
-- 
2.53.0


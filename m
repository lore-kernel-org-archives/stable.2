Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD339022E
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257608; cv=none; b=t8k58hfLbR68eyjaZt5/2Zx7p+qsf1SqadYj4beWgl4tzba0hXCRuenM+N/wDAVcoVp8JBkHslMeOx8CqUwO22i/ENPZWrFfX0wThYFeu9cxKNNYThl420kySgcBnVe7VyHv5NRnRXyi/lsabbH+ZUI8ogHIKCUm62ZTFicqnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257608; c=relaxed/simple;
	bh=kTJ8PG13VccAf/UnFEdjF6pIKkjG29SPsjujryYhJgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJbxHHxgbicGa09OoCCWW9aIZPBAmleYMY2dqF0yjTbbbAj3NIahiQ5jUdFNv5kuU9AN5Z+4JVrPeMpt9BTCfNAHtRt3A6MlDuwmYL9lQYeIdqQv8qiVkiztusiWqyma75qBzTwfWPo6OFdCzAhlFkqfBMpcqUcP/TPI/BB7qCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0dbk4nf; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0dbk4nf"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3811f512167so29200a91.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785257606; x=1785862406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HhYWZOa0HkN7WiWXxoj866N4nnOOceoPTUkPqNFCddo=;
        b=h0dbk4nfUHfQl69AmWiQx9Fys8nYOx0HENHrjXVohXqOdRL89Osiv4OwIky9lMrQG8
         H15pdDicMlwjisp04f4o4I5Bshj0nFGUsSm2k5wf6Oq6oQ6PQu3xcTBbFlRlip2FcxKt
         xkue4CbxHVMF7o8U5ivPTTlXsbCpR7yxv0HHXFak9l7sNoFV2Rg8xflohue0VmDxlE7e
         3iIoKyqVv3UN/BIV4hqnHGEbW+X0zSRw04r+BfkwoNyIGk+yjwv0mUoK1Ar7iX8ufImx
         Ls5GX07Xku47aBxfb4om1e1wxs6C4Vnm0azkA4t61RYL2K45Sj8laV7TO6mj97DW0X6b
         PnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785257606; x=1785862406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HhYWZOa0HkN7WiWXxoj866N4nnOOceoPTUkPqNFCddo=;
        b=LYyUQbZeKKBmlEBmol4eHsa+AVtZCKZRD5u6POsBhdO4OkJF0tlLvBMdf57QJGn4ra
         e7j63d9Sfm081Eehk2EAhVl59noPojhFTSFSiniODDAhPGAj9zfoJNWVL7TR6NegZPsb
         YnWCaEZe4AZkARtK1diy8i2B1xmYbzqtPgDB+Aj65arVEqOzfFh9DWkhW7hurQtts9wm
         zZvs22e9Ncy0/He321BGp0t7GqV2HwyoVKqUUvWSTkNakRcz3puSf2fzv56emr+tue+P
         WjXX6haVGawFQHGb/ho4V/GDcyjvPmiOzEN8xeFZRzdxyssbomzhOmuzMSW9FJraR8BD
         YO4Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq7HUhjoQq0SJa5oNrGYBUVJiBUpCDuqgl+1fy4x8Qtq1E8av5IgLPPVoAIiFNTrBPyqR4+FJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvwNjTBQpDDHbyakgB+TkGZBIXij8aX0AnV4AFf9VPtDR4r4bY
	2JQdY7oi8oC3mcE3h4/FYNO5sbO2qrk16vlfZksdWHFN4T7qGz1LpgaR
X-Gm-Gg: AR+sD1204KP5x72UZQjn9e8ev6N9QX5DrGHlKDvhFbZJrASIXsISdD7fdIun9LbLoyX
	0JQiTNYzA/w+iEGEV1h4uBrzwzZq4M0c5FaYcUhg58Ag1+39YScwD2Zp+8NtE7i8UvxoYTRjxlK
	Wl333jUpRRJRKjdOwFwdqypY8NJYaerxoK/JhPXGY7OU/eQPxQ+hAjJudjOBdO0DwXE4uvY04zK
	ySzkIo1abSfXdKru4O/H99gb7NyZGqn8G1wgAnfmwyK4UGDoPkL4VaGqZFqbpICMBVFGS9aW7S1
	XbwXmakBgVZnOdTlGVIiqXtvNsPDqU0DSbLjH8eOB0YJOWawvntNWOz/VdxAz+/wGo12/ZkJzdC
	Ouu4HorKQHr35tsj4ZuRvRD7zk7yH3yyLLE0mQ11ex6LHzQotZTDklX0OusMi27JyHN0uGGrLlp
	cNV7Tk9HWUVQ8lOPdp2Q9OHsd81eEawFZkAx4SSJNP3SP3WncQqeqsMC8OmK0e9js7WWyNDBeTZ
	++VUdD2nReYwL924ER3n/p/YGagc1SK8hw6uQUPrVpakDQ=
X-Received: by 2002:a17:90b:3886:b0:38e:8021:2ea9 with SMTP id 98e67ed59e1d1-38f6a36245dmr3663482a91.19.1785257606006;
        Tue, 28 Jul 2026 09:53:26 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:9d5b:e192:4a0c:2079:ffb7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b15f77sm618980eec.4.2026.07.28.09.53.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 09:53:25 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] cfi: Ignore non-allocated module trap sections
Date: Tue, 28 Jul 2026 22:38:04 +0545
Message-ID: <20260728165304.56449-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rewrite_section_headers() initially sets sh_addr for every section to its
address in the temporary module image. Only SHF_ALLOC sections are later
copied to module memory and have sh_addr updated.

module_cfi_finalize() accepts any section named __kcfi_traps. A malformed
module can therefore leave mod->kcfi_traps pointing into the temporary
image, which is freed after loading. A later CFI trap would then scan freed
memory.

Require the trap section to be allocated before retaining its address.
Clang emits .kcfi_traps with SHF_ALLOC, so valid modules are unchanged.

Fixes: 89245600941e ("cfi: Switch to -fsanitize=kcfi")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 kernel/cfi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cfi.c b/kernel/cfi.c
index 4dad04ead06c..3ee67b723ab4 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -74,7 +74,8 @@ void module_cfi_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
 	secstrings = (char *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (i = 1; i < hdr->e_shnum; i++) {
-		if (strcmp(secstrings + sechdrs[i].sh_name, "__kcfi_traps"))
+		if (strcmp(secstrings + sechdrs[i].sh_name, "__kcfi_traps") ||
+		    !(sechdrs[i].sh_flags & SHF_ALLOC))
 			continue;
 
 		mod->kcfi_traps = (s32 *)sechdrs[i].sh_addr;
-- 
2.51.2


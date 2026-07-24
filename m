Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B83546ED
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784861624; cv=none; b=XiJfTBf4ISLMcL0FMG2cSXTNaPF2qX9WQHKbdwqouAgOn6Q1WJ6n66sniBNL674zvPL9ziW8H/eWLPqLSsQELUVlhPQb5zYJsucUFlij5lbxWY3700+hnojdLeYjtgNaWeDZmRgR+eLNzsnLvfX8dV/4pBg8FlL5vhjZ6dcYIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784861624; c=relaxed/simple;
	bh=DGOO1mcvNX0DhX+uMlETQcvcFQk+ownCZdf4bRPZ0hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQIOU05TflLPHB1x9cEJD3rnc4sAJhHZZUKGGPPDc8AAgauwSCcMFr6qhBNMj3GP/Fe7lNU80bQymDkd0yDaAodMpQf5gHf2voRWGW5Vds/y1V6qOriW9CuAhxvxT/1LqTzTuLBv7JuATN/tF9CLsYksgIaGgCGRy+LncryjhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoVzfG6C; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoVzfG6C"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so14562565ad.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784861620; x=1785466420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u5g65N8OjtzmKwoPoPbEZAl8O7MsJ2czZFXaJNHfPiY=;
        b=SoVzfG6CZCTvGU6m3GScPch0etDo3sztCdog0JHccW9CWfVkWz1Jv4SfnfXDQQgwAE
         EXoWMLk3kE5bgr9dWd/MTw82uA/XSGfDlT3Z2+7GUMvHjCkZxgsZq7Zy2l8coQtxg/PR
         N1f2Gk6gIroCMFPPjZ2sULjJ6lUHlJMnxlMggH9537Fe5G/ORfOqpPpJin3ukj868Bqz
         a2Df5KdaslniwzAsm+SOobmo0bjnlm9jMFG8ZKT1RNLnMRPqKLmRlYwQKgLSyMaWmV1R
         7xmNfNFbcUWZHRYeuQ21KA0hMdcrutOSmNAozrux1zPT5q9+VTkLzFnKzx2pEgPYJiAB
         0uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784861620; x=1785466420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u5g65N8OjtzmKwoPoPbEZAl8O7MsJ2czZFXaJNHfPiY=;
        b=eJA9RMW4eL7QSrH9GwLaB0xtWfPllsSTxe5gyGnRhTta5iC/k4glPpyigjZALgHuHL
         yr+quA4e3hjoBi3My/UNs2egP+GHVN2xDVTxLLpnEubQRjWGflbkVa6h7p2rSX0ppwUR
         O6wQK1iEeOpMaAhu4TMDfdoRQPNQaDnr4RqhcUqfPsw5f5AiHJffTSLCJB3rbdhB417u
         v1taRhV6Ls4VRl+1BkS1gSh317XGATwHI1CYdDIFXZz25d97XDID3dbQqz1D0Mj4rbCV
         +r/JsGBP1SRZQzWM9Fk5RfwvcrqCncky8Fsrdy0tpCeA93MkVolvEG5oVCcBOia1PKJK
         0yiA==
X-Forwarded-Encrypted: i=1; AHgh+RoMuz+/g4wbJje42AK2uZNK5zKXB579rh3BPb2MCJamgeL42zlPHqCwJBAvdZ80BzsP/yUEozc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJK3Q0x9Pb0847YMh7WKgAy+gtlEUrwkFIcJoNRaylUJBUzmJ0
	QsQKldZvRB84rGB+avmAVmipgPTKWwlCGFRd+5v/A9B+66la2sQXsOUB
X-Gm-Gg: AR+sD13jZegZ92hkiBsrqxT3Pe5g5vJgj9rsZiJBdiGaS3+o2FF4IAWPipY0nN/blMG
	Y0bk+M01mdBhIojKTNUyjDCFRyFToRbwDRIfY5xOCxZoxCPHJg2CkjrnyXmnASmqOSclvTZoyL2
	KNwikBj3reNqcgnezXKWu6MkB890Cto/zli0TJ+PGeJ6wC1xbfNXOgg9aHI1osewSSlIlNhG8mg
	D03gVlTdE/xXfTPOnHkmipFgGfWRr3isus9prOwWzAFLmSzSbdHR820+QHekk6gMqEVvNOjh/2s
	poxAsZTk4QIqUje5SaAnUzs2lNNNhU7FCdT/8t71NQkDhIcyRDnS/m+aHWUGKa/KsZv8FcypOME
	Cq2zBy0Jo5ED4jgs4OksnxKQOVimeyxtksBGbN1H3kfP8piZKjBa2C6fzCl6t55hdjYQU76yDzq
	nVJspULuZNmVcRudtqPiYHQrBnyjt+EsSs2EZXqYtTxNM8sSkUfyM2JjY+SGpEzAkY8AQ=
X-Received: by 2002:a17:903:3847:b0:2cf:b68a:2050 with SMTP id d9443c01a7336-2cfb68a395bmr38478795ad.15.1784861619575;
        Thu, 23 Jul 2026 19:53:39 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efae5aesm42664585ad.15.2026.07.23.19.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 19:53:39 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] remoteproc: elf_loader: bound the section header table
Date: Fri, 24 Jul 2026 11:53:22 +0900
Message-ID: <20260724025322.2341205-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rproc_elf_sanity_check() only checks the image is big enough to hold
one section header. But find_table() walks e_shnum of them, and first
dereferences the header at e_shstrndx to locate the section name table.
Both fields are u16 and both come from the image, so an e_shstrndx of
65535 reads about 4 MB past the buffer.

The commit 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read
past the ELF header") added the same check to the MDT loader, and says
the header "is sanitized beforehand" under remoteproc. That is what this
patch makes true.

Check e_shoff against the image size first, so the two bounds can use
size_add() without an e_shoff above SIZE_MAX wrapping on 32-bit. The
bounds are separate because e_shnum may be zero while find_table() still
reads the e_shstrndx header.

Fixes: 400e64df6b23 ("remoteproc: add framework for controlling remote processors")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 23 ++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index 94177e416047..da3cddbe7d4c 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -46,8 +46,9 @@ int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
 	struct elf32_hdr *ehdr;
 	u32 elf_shdr_get_size;
 	u64 phoff, shoff;
+	size_t shend;
 	char class;
-	u16 phnum;
+	u16 phnum, shnum, shstrndx;
 
 	if (!fw) {
 		dev_err(dev, "failed to load %s\n", name);
@@ -90,9 +91,27 @@ int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
 	phoff = elf_hdr_get_e_phoff(class, fw->data);
 	shoff = elf_hdr_get_e_shoff(class, fw->data);
 	phnum =  elf_hdr_get_e_phnum(class, fw->data);
+	shnum = elf_hdr_get_e_shnum(class, fw->data);
+	shstrndx = elf_hdr_get_e_shstrndx(class, fw->data);
 	elf_shdr_get_size = elf_size_of_shdr(class);
 
-	if (fw->size < shoff + elf_shdr_get_size) {
+	/* keeps shoff in size_t range for the two bounds below */
+	if (shoff > fw->size) {
+		dev_err(dev, "Section header table is out of bounds\n");
+		return -EINVAL;
+	}
+
+	if (shnum) {
+		shend = size_add(size_mul(elf_shdr_get_size, shnum), shoff);
+		if (shend > fw->size) {
+			dev_err(dev, "Section headers are out of bounds\n");
+			return -EINVAL;
+		}
+	}
+
+	/* find_table() reads the header at shstrndx even with no sections */
+	shend = size_add(size_mul(elf_shdr_get_size, (size_t)shstrndx + 1), shoff);
+	if (shend > fw->size) {
 		dev_err(dev, "Image is too small\n");
 		return -EINVAL;
 	}
-- 
2.43.0


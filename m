Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF01DF73C
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429273; cv=none; b=UVylVQRVEiMqwRleGE+nZTOdZRVnZ14YKQnO7NJVtFv6bb4U0v+no3w+mYfZNsMyWy6cbU6FLTUGA0F4f6/nQmz1tffTY93nSVo6zL5W4HUd3Wl7ZFEBnIl0Q9CwGpuM9oP0DoolId2l7no1Iq81/HjQkSuR1BxcqDNwoIHC7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429273; c=relaxed/simple;
	bh=AJdHoyojkmqpt1uYjgFWBxyVjingxmsKD+KwiQx7mu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZ129xUkpNiQdaOddnORJgFjoFEr82U9vosTCZo72TuTO+ubfqO3ZZFM8faMDT8by+cfHMAAr6JWdPTy3XZkrY1UREXFnP7UcqlUzpNqQygKKkWKEEsl+4OtGs+bSswq4Wv1Wz0FrzUgp3WrI+hAsmyuxt4ZRdFH7P4pRwnWBy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5qJnNM+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5qJnNM+"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so5089415e9.0
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429270; x=1781034070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKPOaxdysm0puIYS2BPIpBSBqsEXSwsXYKBr0iQP+/0=;
        b=r5qJnNM+nUN1is49bPnUeDWLHc13cavwc6SEH/Bc+Hjj6bnHArP4ELy2+kAoPeZswc
         3GAPe6UJH53CY0YaRfGrwFiMllwy0muCret0mXFdSVpIKGL9phZBouLGqiwnaId0pF3T
         61hBxI8bVvhzpLBK6I/JOK21TVTgPjlbSbEfagPun0WdfcB73Wtoj1AVRPxvDnh0GZSS
         rUzc3nEPeTLvSWR8WFOfliv56yzOdPCqAwPwvDyPzXv2PXbqRCdwXUe1Yy1ek6IHI/Su
         R18UExm81WAB+UJMXYvCS+eOJzUQlvr8E9TJaa9uKV8e+Wd8xW6NXGYrsqSqr/sQo3gl
         49ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429270; x=1781034070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKPOaxdysm0puIYS2BPIpBSBqsEXSwsXYKBr0iQP+/0=;
        b=tMY5mzryO3OvX/09ARz2+c6zdM0KqnxCyqcovZLRz/Vmy9jcJi9A16pXOx2v3bqeR/
         +w4yBWbPVLeluI5XI5BkdiTKUPxSjcVJE51FaQzaFmr1KNa6Bf40xpWmm4RTdLcuCFAv
         hg6wBiD2FwkiBh39P6Zz8zUR8nAbxF5kTeoCqf8GJaPC4opHi5IVB0YOPT4FwBYw8Ihu
         SgTCESIGVA6ZHmYUYKvVGj5eVIg+4OOLnzntlDaamWHvzet5VNMXFARICkAYNxRKaELl
         hfRAnRzIsg+SXzFvWAzLVSNFKRQAv5JV03QcFqm9yDd3bUMkNiryib89cQyiyR6RPUbA
         JGMw==
X-Gm-Message-State: AOJu0YwOehK2XLqA2h1uDZVZ3eJ1/EF+NGstCvv4aeWYNZAoS/dEbOGO
	rPaoPxucaWjEX86STg8zG4Xd/Pm3r3hqLpBkoK6dfacHskvRLMY91tMvaiAGXlqn
X-Gm-Gg: Acq92OGbqSqX6XVtULrqQR+6rGczfV05CxMT+bgGAGC33Stw5+NAqO7spliHFJGq42b
	bRewEs85SVqvFXokcYtR9q3dI9pIHr/sFD9SoAK6Sch3uTSM7KhAJasg/wgcnScsUo9aKOlC1RC
	2pKBdxkYSgV5/CKawHKyVfDdDYigLgWdJaLBCGSilyBypaz2vkUIugKJbHocypJ2o1Z6FWJVN/o
	5CaCQJfdISlPPlZxfB0VjJbJ+ll7vok85aQK6LK9DVdEfMWash446+iVZZNVgCHK25keouDUYjC
	zI9xWcovCaZH0YO/1G3NaYYeomI7Tik14KCJe9kwfjdlum62Vo/2iAsAe84EQmP58ZrmNwSp9jE
	ayYm1SpGUUujbXWiHw4STj9WQ5lt+OaJ/Zp5znFOLZwtuvAn6YCd448FCxUfSbXi2+4H+/KUb6U
	nlkfEEfk9FNjcmON76emd3TWaqL4JLzkGkbAHM66qSkJjGjy+ykRJKAQVvZjAOUdKibWf0LNH+u
	SN0xLREGVIR22rWvHghgYnfks0gqa9acxln0FnWRDv0xKelI1i/H+6Au/S2ClKdCM9YD2ukoOcH
	cCYkrMdKEzhs9o2/jQNHmzRp5nNeZ07StcMTLZlWrebm7KyIC0Zw9g==
X-Received: by 2002:a05:600c:a088:b0:48f:f64c:c2fe with SMTP id 5b1f17b1804b1-490b5ee1983mr3252925e9.22.1780429269778;
        Tue, 02 Jun 2026 12:41:09 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm2390223f8f.27.2026.06.02.12.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:41:09 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:41:07 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y v2 05/11] selftests/bpf: Add read_build_id function
Message-ID: <5ea8ed0a857940931b2468270cb369a06af9e2bf.1780427227.git.paul.chaignon@gmail.com>
References: <cover.1780427227.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780427227.git.paul.chaignon@gmail.com>

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 88dc8b3605b38a440fba45edcc53a6c7a98eee3b ]

Adding read_build_id function that parses out build id from
specified binary.

It will replace extract_build_id and also be used in following
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20230331093157.1749137-3-jolsa@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Fixes: be4e85369e5a ("selftests/bpf: Replace extract_build_id with read_build_id")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/trace_helpers.c | 82 +++++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h |  5 ++
 2 files changed, 87 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 9c4be2cdb21a..afc33ba36ccc 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -11,6 +11,9 @@
 #include <linux/perf_event.h>
 #include <sys/mman.h>
 #include "trace_helpers.h"
+#include <linux/limits.h>
+#include <libelf.h>
+#include <gelf.h>
 
 #define DEBUGFS "/sys/kernel/debug/tracing/"
 
@@ -224,3 +227,82 @@ ssize_t get_rel_offset(uintptr_t addr)
 	fclose(f);
 	return -EINVAL;
 }
+
+static int
+parse_build_id_buf(const void *note_start, Elf32_Word note_size, char *build_id)
+{
+	Elf32_Word note_offs = 0;
+
+	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
+		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
+
+		if (nhdr->n_type == 3 && nhdr->n_namesz == sizeof("GNU") &&
+		    !strcmp((char *)(nhdr + 1), "GNU") && nhdr->n_descsz > 0 &&
+		    nhdr->n_descsz <= BPF_BUILD_ID_SIZE) {
+			memcpy(build_id, note_start + note_offs +
+			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr), nhdr->n_descsz);
+			memset(build_id + nhdr->n_descsz, 0, BPF_BUILD_ID_SIZE - nhdr->n_descsz);
+			return (int) nhdr->n_descsz;
+		}
+
+		note_offs = note_offs + sizeof(Elf32_Nhdr) +
+			   ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, 4);
+	}
+
+	return -ENOENT;
+}
+
+/* Reads binary from *path* file and returns it in the *build_id* buffer
+ * with *size* which is expected to be at least BPF_BUILD_ID_SIZE bytes.
+ * Returns size of build id on success. On error the error value is
+ * returned.
+ */
+int read_build_id(const char *path, char *build_id, size_t size)
+{
+	int fd, err = -EINVAL;
+	Elf *elf = NULL;
+	GElf_Ehdr ehdr;
+	size_t max, i;
+
+	if (size < BPF_BUILD_ID_SIZE)
+		return -EINVAL;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	(void)elf_version(EV_CURRENT);
+
+	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
+	if (!elf)
+		goto out;
+	if (elf_kind(elf) != ELF_K_ELF)
+		goto out;
+	if (!gelf_getehdr(elf, &ehdr))
+		goto out;
+
+	for (i = 0; i < ehdr.e_phnum; i++) {
+		GElf_Phdr mem, *phdr;
+		char *data;
+
+		phdr = gelf_getphdr(elf, i, &mem);
+		if (!phdr)
+			goto out;
+		if (phdr->p_type != PT_NOTE)
+			continue;
+		data = elf_rawfile(elf, &max);
+		if (!data)
+			goto out;
+		if (phdr->p_offset + phdr->p_memsz > max)
+			goto out;
+		err = parse_build_id_buf(data + phdr->p_offset, phdr->p_memsz, build_id);
+		if (err > 0)
+			break;
+	}
+
+out:
+	if (elf)
+		elf_end(elf);
+	close(fd);
+	return err;
+}
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 238a9c98cde2..709871f32852 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -4,6 +4,9 @@
 
 #include <bpf/libbpf.h>
 
+#define __ALIGN_MASK(x, mask)	(((x)+(mask))&~(mask))
+#define ALIGN(x, a)		__ALIGN_MASK(x, (typeof(x))(a)-1)
+
 struct ksym {
 	long addr;
 	char *name;
@@ -21,4 +24,6 @@ void read_trace_pipe(void);
 ssize_t get_uprobe_offset(const void *addr);
 ssize_t get_rel_offset(uintptr_t addr);
 
+int read_build_id(const char *path, char *build_id, size_t size);
+
 #endif
-- 
2.43.0


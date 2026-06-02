Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69E427F19F
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392626; cv=none; b=Guf9s/baV9NBi5DXHC4b01n9Mxao5HCTs82bABFox+ERRpomuEcgIpMyrFp+dXyfmB++aqJYGq1P8MsJMKxBf5nTejp21wOIEvkR7ETrMIcZnolxXtGZp+7EIUQvtb/HZHz8o4EX+oNXofanYyUifBNUBDxBh+LBx2bhqQ8gSL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392626; c=relaxed/simple;
	bh=AJdHoyojkmqpt1uYjgFWBxyVjingxmsKD+KwiQx7mu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3mNiKdHNrv1xyv0f01R9Hv2d+Fj1h4li8aQ/Mysq2n/yuFyldMhexQUoMi3PxmTmMBIVuA9NvqdQcpdJ9cDfT6wEDiVuUQRz4wxsi7w2w9n4W2qiBv6p3Wb5fiqAKZ665DRSEOfLLWItlbd6Zy/S2U1AxITt+PeNfKhScYklA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQsvIrmg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQsvIrmg"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef82204c6so1736275f8f.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392618; x=1780997418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKPOaxdysm0puIYS2BPIpBSBqsEXSwsXYKBr0iQP+/0=;
        b=cQsvIrmg8PEGkvxhST5ORPfBX1pCV6WDiJQKM/ZKvFW+r3e/criAtO/GPxiyR330+1
         Duj41HVhS8r+L4gFydDYwqKBmGb/TnxBPewRomeYgkXk2anmqbmgTHp1s1ITRQEFFSkK
         xng8W9rLRMwJvATKIN4wsxyTa1M9Gnr2k5qBV89aZxvhzzlbGugW1rRXCQv1RBbFEC2K
         yOmFRcGZTh1zumGV5sn4/gsTFs/m1kFm/76aaELR5KcvLp6GS2WvR5rdFC22ooNuAYbQ
         q7SVv/bgKElSWVEZevTmrCmM2idiwv1eApjHmckzxVh6OyP26ZjhEjvHoJSa9eExo7OL
         pHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392618; x=1780997418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKPOaxdysm0puIYS2BPIpBSBqsEXSwsXYKBr0iQP+/0=;
        b=hc86sOJNZ8DjoTuFxS2Um2EqwjTidPo8XHZxT/SbAq4fz+xpaE9uan9TF6E5A20Tcc
         PblGjEXj3OGjM4vNuoWoEqqvdZv6euNlyuwrJZh890rNzoRL+meSGVmXZwhaJbUhyduH
         JFyUeSeGXvvOPqG6RLC7J8IYEwFVJ+TSyCdT6O/zV6LnCROGcwnQmWLKN1f41EwUsQUD
         eS0EqP9Q1p36rgbuHjSz/4plnhBNDK1vlMFilpQZLK1igru7vKxKlONrrrtNOXzirWcI
         MCsFJp5Uo3Bd4r2JjCvMpmJMg/BKTK7nhkBiEYkYPJeXrFb7926/G97UER3irboucO4h
         hMkA==
X-Gm-Message-State: AOJu0YyjQRfm3x+2crnSbaosIq3WBUhyx9SUcuy4Gj2g1GwGcPq8T8z8
	4IOMP93Zffnhp+djIdR1fKmjewz122JyNCzecEdLvi26fkQXehYMZ1TXHKpIPzeU
X-Gm-Gg: Acq92OEwLWn+O0jNudOmmnqcoLTgPQR/hBKjf36V3UwYovNz8oFeGK0MF7pxv4xr6Hd
	3ma1Ndd6dCM+N33JCp105hhZxSkugZ3v6XL8Ie1nLLqAgqmM7osvp9FXaL9SZn/OWItrQCXHntw
	VzMOYP4BGODw63P2vRiEekmr9RqITHC8+bTJzZbDV9+AHKYw5D+7Iv1vuSw4sABGsUWDGWzY75C
	TKrOH7TheEIRU+xsjuksHTI6VVoNg+iLJK0Sv+tGyuAHOVyBh8zZvErI3Itbt0pxP+arK9wzQpv
	NkpUfbgsqzl2vi2SP3xnbp0CGbb8QomH94UKCziNPZWxbTJ7XGHh87kl59obgP1sOGFu9GtarM4
	iFbqUvwFP25T/DU3pxE8Re1/i08FacFWyKbsBm6tq/jOy4UoAhO5qtwTQwY6baQ0xu3WgETSD85
	Jo2+E49QtrWLm1x+7GYXAk4Qmve41X5BLmHUj5vHMMZAosJ1ByxvQwwr+8OuFWN8+qHGbA5aab0
	paXOo2HdbvOkJByUYHU/t6tcXZ4qgQMEjso/Ohk6MFAAeGHkaeu6l4dtw3Ho3/IXQvSm5NI/ihh
	19lAwd0JmjBR9Y77WS2kO7Xx2J+nOTGj3fR4UUmGeq6oBm5LlEBgYxcwBFC2ndNo
X-Received: by 2002:a05:6000:4606:b0:45e:da57:be33 with SMTP id ffacd0b85a97d-45ef6b7fc88mr27879047f8f.23.1780392618009;
        Tue, 02 Jun 2026 02:30:18 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a0374sm28933417f8f.2.2026.06.02.02.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:30:17 -0700 (PDT)
Date: Tue, 2 Jun 2026 11:30:15 +0200
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
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y 05/11] selftests/bpf: Add read_build_id function
Message-ID: <5e0a372880ddfd651884ea02cd5b067897f6c41e.1780392093.git.paul.chaignon@gmail.com>
References: <cover.1780392092.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780392092.git.paul.chaignon@gmail.com>

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


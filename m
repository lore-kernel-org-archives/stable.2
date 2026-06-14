Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832740D570
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429194; cv=none; b=FBJENesmtMRl2DbP4zxbuPkY5Lwk/28ckt3Eqc0Yy8qQHJ5EwKvxOXqcXvdJivzPPJCzXKLQCqVEYSyNx9kfU1x1EsMZUJTqOLHIatW4iSrcMx4YjjvKFw8WHRtt7lkU4pL9G7dVnUi1f4P6loo6xE0la9QWxffVNae6xak+As4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429194; c=relaxed/simple;
	bh=lhowr9EjwPapIm5LZ9CUvqkGMBmfsnVS9rihubPA5e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoKZPG+vsa7Fjp0zcG5SWkLs3GGn//xwal1LJEbv853Colqt3Qcmahdg0mD815wQRz9AqogoQiZ56fiynAm40CYJCdxF6+3XSmi7apAmLW1/BtP2ajcnIKTdQXWYJgvyRgvUFoMF1DKB2JrZucuZf3kpLUzaeSRT7yLGr0XwOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2qrsybh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2qrsybh"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8419ab3a297so995610b3a.2
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781429191; x=1782033991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT1UtqM2AmX11NcJjNv9n62UrLKyvxdMBYbCsYRy7Tg=;
        b=R2qrsybhpG8zS5xtDIWAsro5G+GDlQjIRuaZ9LuEoXyb1e3EzXKHCl6LDL9gegkaeq
         Z1/O6/DL56G1edjEaLOjuJOywShKh2nScTQ13ZKbfGTVj/q8xk6tpyDgDEz0VlFD1Mka
         AEitCfa0pqWyUDV2GoQ06P6yRwenUQqJDxKJEhrM6PsCRLy1dj9MdyoJ4ZmCLQNg1JP2
         r0S7Eg0SuuC94fT7pdg+730X3Bp1T/i4KIBiMA38XzIaMoBRXExDHovyQdrT/c/ZDSSu
         TX0CMuairgljLvQ9POq+wuVD6mT4Q/ZvlNGPRAQYwkA/b8qy2rTULQKSggOwh2Oq9m6O
         YRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781429191; x=1782033991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NT1UtqM2AmX11NcJjNv9n62UrLKyvxdMBYbCsYRy7Tg=;
        b=hZSLitELCj42V7n4TRWadDYG2GFBIWhiTULYSECnh4jRocG2QeU5qOSTrjdLNOSMZC
         4vE1yBMYTGBiDwTRtvWYkjjdcNa+NWchJ2z/ylR8ijdzd+CK/ggvoubv6XtyQRyPqiEC
         PIhauJ0n3HfXuxtTPx9I0LbW8idTyumXrVRBRMrE0KkUjjOpUgiH073Meydaonc1X4NE
         R53XyQKP1jJFaS5PEqcYNe4b+0fVkE0yEVqag2CQnTnr859wWDFln2f7XzYpQGDj+lBx
         MdQVvvKZR/E+DzmsPWc3enaOpm7mmXGnoT+Pamh0v6K6/YgiRl3csUwVnGlB0Fjy76P/
         sRqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zjEtbK8z9pAU4gUplLbR7xNdhkBZGb/fuYB9/LHSNaiN8wFcWag1Zc1KUb462YY5G8ulOU3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFj25X874zNxzqPWpUfFNqAEtNnZEIwIJ6GnXO/l0nnRQhguLk
	8wOcxOjyQJzfs4tbE6+9GvIVxdTgw/vN3tEofLQixeiDZoud4NnqdY0O
X-Gm-Gg: Acq92OHhHt8B7NZMVOx23mkvxnLXmljsjuT7z3n+eR+0tkOJ0BzJvnbKcBgd4IAIO9w
	/VriV+9dJ81Yb37hYXoFRnP/7zRY4o/xcN+Em+0ZMKu+hZ+566U1IIu5uk2ScImlUJMg/T6FMGu
	V2kdAyoEnBLRyJ0YjIv5S4BX0cCXNJmJX7gA7/YoNIFcQ29cBVXW8gwHbOFsFYTIvgM6dAIAOXm
	ospyBvBoP4u8ZE17AOSL+se4QVXiz90ex1pE5/spGLWqsXgC3JTdwTy/wjReMe8ZuMl+38u5FUF
	QODJE19sky52YYZ0D3TjGGTEiJUtrdkw0NKQCuhB987FNGbmrEKZyPjlD0j3FMN0BbcpWcaGGaH
	4hOVVrq16670QkhCriO1WbVXtChkeFWoIGMSQYdzq2rVKTDVDyocaHyRiUvzAOM6UlUHXRtjAVn
	zOiu8G6nSpAoN19cS7a0+pmJFDQoyEpbHwl7Vx0+kL4Kxbm8p+sB36xerhjTZE0ni3pACUWh+DN
	jbPoPgc+Be/YV+C
X-Received: by 2002:a05:6a00:3c8c:b0:842:688f:307f with SMTP id d2e1a72fcca58-8434cf0e0e6mr10983905b3a.28.1781429190897;
        Sun, 14 Jun 2026 02:26:30 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b057461sm8198423b3a.58.2026.06.14.02.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 02:26:30 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v2 1/2] libbpf: Reject out-of-range linker relocation offsets
Date: Sun, 14 Jun 2026 18:26:15 +0900
Message-ID: <20260614092616.165337-2-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614092616.165337-1-sammiee5311@gmail.com>
References: <20260614092616.165337-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The static linker sanity-checks relocation sections before appending them,
but for executable target sections it only verifies that r_offset is
BPF-instruction aligned.  It does not verify that the offset is inside the
relocated section.

A malformed object can therefore pass an out-of-range offset through
linker_sanity_check_elf_relos().  When the relocation is against an
STT_SECTION symbol, linker_append_elf_relos() uses the unchecked offset to
find the instruction to adjust:

  insn = dst_linked_sec->raw_data + dst_rel->r_offset;

and then reads insn->code and updates insn->imm.

This is reproducible with bpftool's static linker by crafting a BPF object
with a 16-byte executable section and a relocation in its .rel section
whose r_offset is 0x1000:

  BUG: AddressSanitizer: heap-buffer-overflow in linker_append_elf_relos
  READ of size 1
   linker_append_elf_relos
   bpf_linker_add_file
   bpf_linker__add_file
   do_object

Reject relocation offsets that are outside the relocated section before any
later use.  This mirrors the normal object loading path, which already
rejects executable relocations whose r_offset is not inside the program
section.

Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 tools/lib/bpf/linker.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 78f92c39290a..3eb23da167d2 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1048,6 +1048,12 @@ static int linker_sanity_check_elf_relos(struct src_obj *obj, struct src_sec *se
 			return -EINVAL;
 		}
 
+		if (relo->r_offset >= link_sec->shdr->sh_size) {
+			pr_warn("ELF relo #%d in section #%zu has invalid offset %zu in %s\n",
+				i, sec->sec_idx, (size_t)relo->r_offset, obj->filename);
+			return -EINVAL;
+		}
+
 		if (link_sec->shdr->sh_flags & SHF_EXECINSTR) {
 			if (relo->r_offset % sizeof(struct bpf_insn) != 0) {
 				pr_warn("ELF relo #%d in section #%zu points to missing symbol #%zu in %s\n",
-- 
2.43.0


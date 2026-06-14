Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0A29992A
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781415596; cv=none; b=WXTh4OEIvoRa07LV39IUTpM+WXWaDBCoDMRcLQCogncKrLP1EnFjhC1Pdjh2azoNOBEYYV48tXdouFJ8geGcCcfJ/fcHX4eBiydIxB35EJVvGWNOukwb8ftY5XKQqn7Yqf1YP/bSK1UDT9+0Wo8f8VXoyJYQjts7KkLWYz7rfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781415596; c=relaxed/simple;
	bh=lhowr9EjwPapIm5LZ9CUvqkGMBmfsnVS9rihubPA5e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFFrmfL3XEoDHswaiF69ruN8qg4RmUkLeI7bkgbdgHmjKOR1O0YMqh5cyCHF5Qn8Q4p5IK+rJEwTikhQ5bUHM374NCccQv1W1e7LuaiQ6hqHmLB451W1xoXuDaJeFk9JiC8VFlqA+adp9GQm91rXGQ1uCAaWcuZjri0RcNoj+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7Y+ZSnn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7Y+ZSnn"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8419ab3a297so965368b3a.2
        for <stable@vger.kernel.org>; Sat, 13 Jun 2026 22:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781415594; x=1782020394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT1UtqM2AmX11NcJjNv9n62UrLKyvxdMBYbCsYRy7Tg=;
        b=k7Y+ZSnnWZdZwA16LI1jjwiD9wmD/pD5qjRx+SZt0TGO6PL2TosKf3zQEYuBOOo3jl
         IXJ4DI3O4DDszR3h7L9hsel/+bPebrxhlHnILMSml/PubyVW7QOXg1OZ1IQjVxyYLYvL
         G+GTWiX5utKgMFP/sZdfS5XtLxR6fJRhBnqIpJ+HfwsYfQCgvlHQ73MoPZHw+4V973cM
         bQv32r09k21FrpEdUOr8k2FRrQL48VY7QkXDDHHv3/r8R+9EEDheSZEmL9oDq4sQXVAR
         0qnaR5hyIdLRgKWW9t4bFk/tV0M7f1t88wCinuopPv37POBxtYYjol63QqGanP1jEGSO
         g72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781415594; x=1782020394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NT1UtqM2AmX11NcJjNv9n62UrLKyvxdMBYbCsYRy7Tg=;
        b=pbyEYEtczgVWHs15MKq9OzuraqcNXM8ACLs/jACcO74CpJMCYSo2r3ka4RFOEqn6eQ
         6q3uHxHEQptEp9uAPfBNPd019J8jHNTkpJTsOQgPTH0s37byRPNzgT1oJRKfbsDMPJui
         kcCJtd9F4bkthTm58l8UIiiL6de6ub/RLvTntm3kak9C/owrEopBxqMiSRlQLF5I7IlO
         6liAb8J2N8H1/9q1ZWbjNl4CfzzGZmuaLsZZUufd6GiReJOB/0kzDtHpHkdDvKT0Scfk
         5plVb42rGQ236CEdgkrE0U4O1BscJDZ9YUK6PHbWDOcWn8pklYXVblYN0a0XYOZQVPDz
         nnFA==
X-Forwarded-Encrypted: i=1; AFNElJ/EUAo72f+0Vt1ayvsYNNpAhy3lTNPYg9xIIJ7VGUs2z7nkittAYBbW5gnOvEE92CEic8HlQds=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5sUUbIwBGS1/xTvswjsqq9cVc5uu8QXK0hzNxFAwDKVrCAjR
	xQZBPovqXaVOXnwIkH9+c8yaaZU0pkGDNVWJ69w5nLqesE7WeAZqR1iT
X-Gm-Gg: Acq92OG1lv7GfXUU0ViBij/yQqjLM9YwcSBip7R28nL1KSCKv3advUxAtaM4NIo/RS8
	cKVB8mZF8usQcPXm8jAhHw6Pog2998rT9EUH+z7UI0TGYQgqVch9l/xzDt5CS6VaFKQRqbeim0w
	RXQ9BkVM6g2Ck73F4khMQlhBsvYVbGnKUwYvfirpWqPujsb+wmt/Hog1OXBp5GwSp34D61ewOyb
	/Zu1rINOwPufouu3hzGxzH2axBfieOPiP3o9FFqrwSsdpGEMnuYicoFQZe70FsvnsrRYB79ZM+b
	yk4XPYX08cQKVC7TWhUq47wtBSZbDVBX5U2MU1s1mqefNBOgl8orm7ZNp79ZpLWu4l6+SuJiCS1
	oN8m3QHCOPd4XAtrwqAVXR7eBlSIiyHJJ3aOzLiCft5rCUEUi6nJlxCWAcsJnMqYep5+am9qXR2
	x/pmaaCMonbE7gS2cNdFM3u0p6XCcLejFNcVH0KeQxLEFmnP636H2dO/Vy9WEhXlOmuBJATiE5I
	xjkln/FsNBjXTqg
X-Received: by 2002:a05:6a00:4fcf:b0:842:5711:9a2f with SMTP id d2e1a72fcca58-8434cf4f362mr10259911b3a.36.1781415594241;
        Sat, 13 Jun 2026 22:39:54 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acffd04sm6387078b3a.26.2026.06.13.22.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 22:39:53 -0700 (PDT)
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
Subject: [PATCH bpf 1/2] libbpf: Reject out-of-range linker relocation offsets
Date: Sun, 14 Jun 2026 14:39:26 +0900
Message-ID: <20260614053927.160566-2-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614053927.160566-1-sammiee5311@gmail.com>
References: <20260614053927.160566-1-sammiee5311@gmail.com>
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


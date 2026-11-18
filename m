Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794980381;
	b=RlIVowYiV6tjOeIKPCYKCVsgNwnmu0Nszh90JaEbcmeLzOQ2gl9tN6pk+uS92zzH19W7
	 NHSq/26uY5ZeP+mENjL1esotGCbQguG/Io+bpWXA1Iu0XJz1tsr6OvzaefQbesgt1h4SW
	 WxxREim9id7Vr0EOf3QciG/yygD9BdcBkblSHmM3ip+ejk5UU44oMyHiqK7vtDKwrPFTy
	 4zwkW8r0aJvcKissMAf8aNQG+MN3KkmWzTB0o2u8O34191l7B4wzDUiH0zKQiT6FsqtAJ
	 TvYKWTDgN3t3yYkls3rm4IJivcw/aSq9T62Reks4sdaOWpCjhc7GMw9RyH+eGDkn45Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794980381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OnTUX3RjpiKuBl0z2oMbfZLXj9pzVhSggONPVZAXlX4=;
	b=jp0jgxryKolWUDLiO46/l9lztsLs+TTBQ0kFHGPUsZRvbQdAFbCaX+kwOxSlRKpvVAwG
	 luTopHPYd3WNYZpUYnke80vnqz9mLhF5FJGWkf3qruSb2lY8brVe1YDmUW6ugwPZPM+i1
	 xF5RvAaPk9bBYFajEKoA909WgWZCaQX6uLzEN82M/r0w5IooMR1zwCN38R70B2yau63+5
	 r7A891MB7pduIJEDGp0p3ZWWaJduIJGp7pEPpbJiVi8ckdh/B5G0smIqlPiXS1Btd+Sgw
	 2GFdaugUsvYFhbp9DQwPzC/5NP86Q0iZoHGtUec4b+Q5TDeSoUEaQJIJYTlBKEA4AiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BsqEWE6v;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F5606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 741F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BsqEWE6v
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b600fae14dso277870b3a.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 21:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794980381; x=1795585181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OnTUX3RjpiKuBl0z2oMbfZLXj9pzVhSggONPVZAXlX4=;
        b=BsqEWE6vbtgRQhBkSqqEVTG6v7UxDQmKbkDbb3LW6/nP4/UP2hmD1pv58B02QjGk9h
         HNg09iC5CLtDEZ6Tifo5elk094LsO7/ayo/cJ9Y1lRfPJvjwCKMZ15M6nvHtr1NAAc/q
         7jPi6bi2n2hUCNc0UaB4b0x4I5YrnhTW8WI5g5SuV4tcbM7CkncKc2VF/4r3nAI/Q1BM
         eVTR0Qe6bya7Vqn0Rg++B2/x2pO9MizH4gj0UWrqg/RFJK7IDeGHJ5RdCZDUae98DL/p
         oWnfdv6X2IfNQUsldegcY/CsA22Mtzxcz7PQJdYwJeNoEXsrz9SBmAVSFT+y6w6oV7WB
         0kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794980381; x=1795585181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OnTUX3RjpiKuBl0z2oMbfZLXj9pzVhSggONPVZAXlX4=;
        b=K1qJwiYJuO3oUD5q7aw7d001PB9FQQVUWX34e7LZ1LjcK8WyWJLNaBcrZws4QaRvw4
         trsa0wxDoiWq6FvCkCh8gM6b059oUL4wXZk5oHmmzl9u3k/LhcDK2r2vc+l9lNBnfoL1
         dIUqXJsS9uN69No38aiP3/1hbC34PfKAGiAn2oWsE9wLKb3aNs8BAHCrlBByZxTDF3hi
         LHGZ/hJTxMaMHKxgjzavxzyMAVvYxjpKxwYJ5b1znesxM/njrigNVxEQshIfdeeA69QT
         ylsHpwt+01jECtHLDtdOu2ZD8s6Bq/1ohBxshwnKL2ltAOmS6NcO3wKioL6faV5HpDOa
         lSSw==
X-Forwarded-Encrypted: i=1; AL+hErEPAZAQUPnYxVuTf1nYCwPFLS5FT4nnpJzXByR+HwW3kyhMz4RNQ5EnCDdDo6qSqVzX3a1vUGQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+4i6RqL9qqFT8FI4ifI3CKC3tWMu1ZvoBUp9CG8Zz01DtmtZ4
	m8A4Nb4VAtmps2M/7fdEHaApJBG8anoIV21aYv3PEQJCJPDS7wF86EVV
X-Gm-Gg: AYBFou2q0DYuU7fo0mO7UdGunkMgSe9ggI+LwXzeuRY+auwALvot6ObQtt+Gt5tE/cR
	gRP+EpAK3x4/kdHixGiZ0OzTNuiiU8V3uQiy572MRFfF+eINLmcOhl8pnilqOCyqZd8YsBkJrqv
	IJ1UxXpBPrKfhvz9Nqk4AxaQZ6+hj4pNxbsWdCkUj3fMgBlzX9sDx/jt5q0k1qrkhnxUcmLNd+1
	xyhGKRwT4RdaesmdLUK56SC+sWPToU61FLVcJVY3wkRz+kvH/JaYJaGgNuQ5bo9b+k7RSL634Rq
	LMPSeEXUdNcbLFxWdMrOW6SYXSKln6QnoRLkff9LnROk+dvuUmRY0VUpwGWSITfZRV7/Q6jJ6hK
	Zi7JMp3HX1E7+i2FKjVrn4bStfSpjX7lQ5plPx2dw18zKzW+JRkdylzQNd2Okegcs+0U3UTP2uX
	GLPDorQO0RNEQbQDgw4HHiSwxorvy+hgq1vYWlhYJlIMbpJq41tahj5kmJfNFpGn5x9p3dFeU/Y
	AUian1ch/8sLcJLWVive6yCwrGZym+dWMolkecrWhLzTDwWeP+p4CdRtMShdMWAnP2ZeAbTqwgV
	LfQeuWibri8LeysKxIr2EWC43odbIAcl+DB/87qXpCqbX6tO
X-Received: by 2002:a05:6a20:430d:b0:3e1:9071:acdd with SMTP id adf61e73a8af0-3fe976e2b70mr1561308637.35.1794980380746;
        Tue, 17 Nov 2026 21:39:40 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde3c4a314dsm503249a12.22.2026.11.17.21.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 21:39:40 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] riscv: ptrace: Initialize cregs before copyin in compat_riscv_gpr_set()
Date: Wed, 18 Nov 2026 14:39:26 +0900
Message-ID: <20261118053926.845109-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

user_regset_copyin() only copies `count` bytes, so a PTRACE_SETREGSET
request with a short (or zero) iov_len leaves the rest of the on-stack
cregs uninitialized. cregs_to_regs() then copies all of it into the
tracee's pt_regs, where the tracer can read it back with
PTRACE_GETREGSET.

Fill cregs from the current register state first, so that a partial
write only updates the registers it covers, as riscv_gpr_set() does.

Fixes: 4608c159594f ("riscv: compat: ptrace: Add compat_arch_ptrace implement")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index a005574..32227b7 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -584,6 +584,8 @@ static int compat_riscv_gpr_set(struct task_struct *target,
 	int ret;
 	struct compat_user_regs_struct cregs;
 
+	regs_to_cregs(&cregs, task_pt_regs(target));
+
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &cregs, 0, -1);
 	if (!ret)
 		cregs_to_regs(&cregs, task_pt_regs(target));

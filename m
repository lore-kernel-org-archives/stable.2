Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623029;
	b=XELcA0cd7MdxsDZI4rKFQyXQGhVGSCNF0f2t6/F7iyMWJ8mJBraywbKgwjRnV23TqozH
	 6qkkNbDF84cZjgEdY6nhLvSjE4EPMITBvamvfVbKno/62WTu6VE9zlMNN2XpYpcTbqA9x
	 CvFk/ECywbY9gl3ULv+q42uFVQo+ydiSOzLs9YetZLC0HZzcT1sTSaO3e3cyBhKhhKkTO
	 TS6Z2z5ZEkzli3Go+/+L4Y3e4Fjsn9gXjK453BdVAzY7khoYm5HOOkcPJEtSdHgy/18XR
	 5nEUUxYt8itwaYE6kL+XLbiXBXABXOPHuw2qcnvbijqEDQMph8M37l2423Mns18wKlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer;
	bh=jiUaz4f9o+mDn4Avtd7lFhAHvXfThjVzdbQTeYRRX+0=;
	b=sVQack2J4kSXeD5e/72V7jV4VmVRvW5betc6yItBoHB6ZNaJ/hxTSid0Icp5chCIRw+K
	 +XacmTnvmXmjMHBgbmtO4it50mrPs/UH4+IbK2wXL1nxKbJc0sABwBom66uFEGi5fZPFz
	 qIz2oEbMD7+gGr1lLHXz7ITUm+dRaoFOOe7mOej87mg/+Mc7hw+hmHCydubeot4i4A44U
	 MAjqOK5qYNdZYeTCY+IzAVrF/hhljJiEox1F+QS5aVdrkq2eG9GPV7p7rfzupiwsyiqYs
	 kKtoxn4metcTz80h04vXkFngIaoGTO3XLkC6zQHs4IgJA4FMdF6rSTD/PXVgfRr68CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UvfS7rY5;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5732606A32F
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5732606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UvfS7rY5
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so5521608eec.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623028; x=1794227828; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jiUaz4f9o+mDn4Avtd7lFhAHvXfThjVzdbQTeYRRX+0=;
        b=UvfS7rY5xoMCyzIjp8URThf1WnyL9SRo3oRA9q6a4+i6rBO3La1sR1ZLXpsw16dUtG
         GQ7dv4C25qefwMqVETPIyu7hwbbUxrBICSY+fcT4RF32ADFhrzO6ORqoBa1hZhS8W1zU
         wtp+bb84P5Q4RZPpp/DjQEDrvQiXExSMtaCypR7TzKBcggo+wnXWRyAkBo8CtnJiCvTy
         i0Dk/8C6JkxYz7ND5HvqrJoa0AFFPda7JEw+iggns4Lp1HL+zxX5ZpRZaUDQx/oRgf1j
         zR8lYCMDavas7noWIIgsKpxiGty8ygKH5ygr6B1aBoFkb8cm87pqbArjWSniQm/G//mg
         PQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623028; x=1794227828;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jiUaz4f9o+mDn4Avtd7lFhAHvXfThjVzdbQTeYRRX+0=;
        b=R6Q4p5n0BsyxirOCHE9CBRLvG85aZvFuQPxHdPxnjj4VAWLNE7qOqnBuFHLOaTYInL
         8qPgaXxcB/M2h+fV+CpSDXi+YP+UPl+AJu7sgwf6SbTqHblxrnH+i9iothfaQOYMdaBV
         RWx/pjfk8R9kzl/YeLpd4Swo89tuIqiLielY8VYxLU22iH1Wh7Hxgno32V+OZlcPMCfo
         +sLh92F51CDhn5DchD1zYm7orKAVMpXQ+ZMLIH7P7bSW/s5ed+uzaq5FrQ85ENLkkmJQ
         5u11HaAH/5T+NPJFUekXT8ndgCFyDYJVWwkWA2GkMu9W6n8XEKWUvH+ZPBAhdvQpRB4N
         uGDw==
X-Forwarded-Encrypted: i=1; AKwUvBzuvK+SWgbTSWH5LccOCQnvFKMLo6KPGOOjtyoWGKGeMq4UmDbcKLlMjIysMCPf2JhIGp/DTao=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2emIFogP+lpmJyHTBe0ObjQDiwnINCM02oajhigek/0ArNCig
	DE3D6XXIK3+QjmET1/C70l0z8gbD54GoFNoW0bneyKNzxkv0GkbXAT9o
X-Gm-Gg: AYBFou3t3mPfVo17RQunc/Zz9jaGtSsq3u4B+OW8xCETNit0TkK4sCX20rJ7L7ncWyh
	BdfCv822P6tkgr+ebYi/IS9JwQWYTnvM+GhNPkMJQY9Er7/K0Ar1nfrJ628w85xFFg3QqzSLtJE
	UiA/kejr3TR1uGwrgtNWNEMb4Aqy0UTDBvM/ZMtKKr4cFb5+ZjBLTVrqUKLpul8LCAmVpOCQbCj
	sA+GqoIe4EecAK+YTB5pzoRUq4WobIrXCDWerCCbs+yfWk/Sy6i+0MuOBozb3YYNQvlJJrW3ZLS
	t4dbr869k39Zn3j9XULmHPQSwHJLzV5RK3krDmrB5dXoLgeoSx/qFtM0BqF1rrc4PhT8pLCoWX4
	FCvsHuXG29Mf/sX4NDqXD09naK1tQGmzC/EAAqL0vHss1FAZml0zn7uapf374ZxlRElg5LyM8cw
	/5fLkEr5QRx7leL3XHB/GmtbkJFGyzOAGy85xEAh5WtmeOx4ebvE8GcGkx+cZrT4NRy3XZhPhPf
	6K1bSuY9vEBlTbZfW7IYcXYmC7ZooPq0pqwLyziZ5Qyna0utfgl1W4xGiAFNWS4ukswh6C0+fY6
	dd2x+3GxxtqFQwxoSA03Eyv4
X-Received: by 2002:a05:7300:c8c2:b0:36a:117:522a with SMTP id 5a478bee46e88-36a423bf71cmr15537738eec.22.1793623027994;
        Mon, 02 Nov 2026 04:37:07 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm36326095eec.6.2026.11.02.04.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:37:07 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH bpf-next 0/5] bpf: Fix three bugs around constant blinding
 and nop removal
Date: Mon, 02 Nov 2026 07:37:00 -0500
Message-Id: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOyD6GoC/x3LQQqDMBBG4avIrB0wobHoVYqLan51oIwhU4og3
 r3R5ePxHWTIAqO+OijjJyablnB1RdP61gUssTT5xrfONZ7HNPP4EY2sWzKeZYcxHgGdi22YnoE
 KTRn3KPJFl1DsXxrO8w9Md1K1cAAAAA==
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Luis Gerhorst <luis.gerhorst@fau.de>, 
 Henriette Herzog <henriette.herzog@rub.de>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Hengqi Chen <hengqi.chen@gmail.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

Alexei listed three bugs that were in the tree before the patch list
series [1]. Each patch fixes one, the last two add tests:

  bug                                                  fix   test
  line info stays blinded when the JIT falls back      1     -
  removing a nospec jump as a nop drops its barrier    2     4
  log_true_size misses an error from blinding          3     5

Patch 1 needs a JIT failure behind blinding with
CONFIG_BPF_JIT_ALWAYS_ON=n, which a selftest can't cause, so its log
shows a run with fail-nth instead. Each bug shows up on bpf-next and is
gone with its fix. test_verifier and test_progs show no new failures.

[1] https://lore.kernel.org/bpf/DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com/

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (5):
      bpf: Put the line info back when the JIT falls back after blinding
      bpf: Keep the barrier of a nospec insn when removing nops
      bpf: Finalize the verifier log after the runtime is selected
      selftests/bpf: Cover a nospec jump that becomes a nop
      selftests/bpf: Test log_true_size with an error from blinding

 include/linux/bpf.h                                |  6 +++
 kernel/bpf/core.c                                  | 29 ++++++++++-
 kernel/bpf/fixups.c                                |  3 +-
 kernel/bpf/verifier.c                              | 13 +++--
 .../selftests/bpf/prog_tests/blinding_log.c        | 59 ++++++++++++++++++++++
 .../testing/selftests/bpf/progs/verifier_unpriv.c  | 35 +++++++++++++
 6 files changed, 138 insertions(+), 7 deletions(-)
---
base-commit: cd5bc55288d4fd999595c8f2af6a5408cbe92a52
change-id: 20261102-bpf-blind-nops-fixes-e45e91d65c75

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


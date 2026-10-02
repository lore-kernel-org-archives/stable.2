Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0793FD969
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969428; cv=none; b=hbXeFcA2v1Ti9sr8wy1xlCAU1iLxFgc2d4CnvrO6fr+lJnCWJQSGHzDfrApCawYITxuOXKKtcBSLHHVmXncADqKY1aJtOqSPhW7HuTwTcCqVH0nZKvBlLtVXyBCfqeySN9fHD/266+R/VztjZmawgSoMnolSZnjCibwiicK3Txs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969428; c=relaxed/simple;
	bh=pLVNaTP9L662KDxDj0b3v3iNYRp0+xOAOWs+AVXQFYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfK9iYAh5BMGjZtJf+j5OXQVlC0uOyEsJBNMkirMSuuEONqB4jedU6AUJkfTc7tlOaLQk8VBcdolkRXaFCNipz7WfaYqqsiyfRs/ADAIHN/Fv5WkkJBogNKI4pE2a4m8Gq/olL2Bii9kX9AIJhs5f582JgBXtJM6REnnCbHegs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=AypcrKKS; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="AypcrKKS"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so6676804eec.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790969425; x=1791574225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bp8EWYscaHenCl5GeCUCEIO11ZClZpcPuAQp7e588A4=;
        b=AypcrKKSdwDrZaMCBdZ5LLLGkCo6T5Q185BHhiy5AA6Xuae4D1ub8dAdecycjD1V4w
         sdq+HjICmovro/C+KpH/dpmoMwYBVrLqORmzBxQSZvbd7W9FNVzOBWJavnvITPvnkHQd
         WMxasEL+LUHdgfla3Yjmss656q1yPPFtJW+a4MMHzmSPbI+UHUSvtKWbQdlOsr1OUScl
         txDBKuQwXqZGbf9iABULBIJniY4Nu/UVtGUw0HnAAFevlA78Q3Q12F2iAJ1BmDX1PCI9
         46LlmH8RLDMbL5Li4WTG4MLGhlQj4G9yyo19t4SI26RvP49o5DLSt4aCxPM27y7/GVdb
         5YoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969425; x=1791574225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bp8EWYscaHenCl5GeCUCEIO11ZClZpcPuAQp7e588A4=;
        b=E3yuAAVfbvJezbDrlcAU6iOlYJJvQyo+qX6hKGdRV4GL36yJbE2kv+MsQaILzcgBKe
         dOaTzLV6+Cshh4ejoZ/8djgwQyMS9C9g2mlHkqRSelHXib+hJqdR1Vd285zoGKdC9q0E
         ncjpaBaBncKVWAWy3svcm1Z3itpAcLK9PZ8aB/wz0U750wf2s8KYDviAboTCvpYc2ed9
         sYpn1k+28RTzU4m7glGOnT8ipNngEAOLsNSTl14+giPAON3ZvMH3DK0KLLclD9O4vqWT
         hquSwTyifR6w5G2dsdMb1Jx0fxhCIFssrBvysDmPu5srajajVDak+av1rVaobDYHgAuo
         23Ng==
X-Gm-Message-State: AFq9FYJUKEL82zLahC/IdShIotKgpXHXzYctyMJuQnm6/nwfHqhiTryk
	mLv5QqRwywPsG7qan3SDLiPtJ98O9GATPcPWAOGQEg5P9kEtrgHToBaxHitKPK7R6mApg/vSEBQ
	JlnxwKNa8zQ==
X-Gm-Gg: AYBFou2m9g3aqduNlUZtyztPo0xm3R5HDKX8OzuiI9gmbNCTJrcyMCurFD9rwR6/2y3
	+dqObdCa43kqOYV/1DOuu7usNCnp9hyuMgKZLvJNw7fDHGlu2x6IBdDOnB8QWOf38kmR8WCZ0P6
	2W6kWGAXqpuZsiCTWCleuSSX7vNhB0hfUW3w2RvcffhFr+vsDwDkzEJSl6gLQ6AO8IdA3fnEAFC
	cxQdeNgZvViAvW9N6SFM2CRQd0VXO1H911n8tQsWsjOtvhCrhU+jXzx1dP6NzVVyeNdPjzU3qDH
	Ynvhd1GjMlenKLw8HwTd6Dg2gnTnF7uV9ecqw/ejIwfnftCgYcH5gNW6OVfGcWyU7P8R3L+QL6F
	/CLNLX1bQoaEDhlNbjMH6iwbPl4Fm6Rg/Rmt0fah21bobB+xT74deLevB5+AmvmMC7LwwwMa/IE
	Vj3hyHuT8p8cpXpSIPoZrpfJw5WFqmlyE7Z3JxwrahJeJGPTSpbPDX91OBTZYN7vciV/x7XO9/A
	lahO/XDi350NtbcgteMIF0a+XKkSGQIPHAPJjW+EEZ4ev1CZJE0W3JcJRit2r7hA9v1pZrz
X-Received: by 2002:a05:7301:2203:b0:351:1282:3e88 with SMTP id 5a478bee46e88-351128240c1mr293459eec.20.1790969425493;
        Fri, 02 Oct 2026 12:30:25 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f660f1sm8427448eec.13.2026.10.02.12.30.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 12:30:24 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Dohyun Kim <dohyunkim@google.com>,
	Neel Natu <neelnatu@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	toke@redhat.com
Subject: [PATCH 6.1.y 0/2] bpf: backport CVE-2024-41045 and CVE-2024-42239 fixes
Date: Fri,  2 Oct 2026 15:30:15 -0400
Message-ID: <20261002193020.19392-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and bpf maintainers,

These patches are the small, ordered backport for CVE-2024-41045 and
CVE-2024-42239 on 6.1.y. The second patch depends on the first, so I kept
the upstream ordering instead of folding either change into the other.

The first patch is already present in 6.6.y. The 6.6.y backport of the
second patch is queued (6.6.158-rc1). Both patches are already present in
6.12.y, 6.18.y, and 7.2.y. Could you please queue this series for 6.1.y?

AI assistance: An LLM helped identify, adapt, and validate these backports;
I reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

Series:
  1. bpf: Fail bpf_timer_cancel when callback is being cancelled
  2. bpf: Defer work in bpf_timer_cancel_and_free

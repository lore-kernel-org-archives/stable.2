Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F030E821;
	Mon, 24 Aug 2026 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566624; cv=none; b=uiTbnAxsVV/LRR6DfBBima5rx/bO7OBKXo9pPCa6E1eUH33FwhDuk5sWaEs0JNdxT1obUhMmsgFi/yoKV0yD3Ez/EwHntGgw809OS9E8xSpYNllgBZTWGFRYFmfSEL5HH1NyRo+v1HkI7oHcusXJ6k82LNBjVa1VsyB1fG2Wwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566624; c=relaxed/simple;
	bh=8TEDn0L9YJc81TjqcHlJYZbCeP9SnSOzlsd8ZIQVikU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=asbCrM1Bt+bS/LdD9VyBWIS8TBxw1I0QslCoe9w6YT8tVQQS5LTXQ6ZN9nQ3bPM+JPRYrg5NIH1fLb3XqV9h+wQ6uqxX0Em86YHT1dxU6WchXi6kdZmJkswU/0cpXz83uA0juMtNbvBs5uMOxctpYdoCdzNn4OuhTqLxllyxzMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hMbjnnov; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hMbjnnov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787566550;
	bh=8TEDn0L9YJc81TjqcHlJYZbCeP9SnSOzlsd8ZIQVikU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hMbjnnovXuqUXIrPS+U0fmJb5QaVsqp8KpRNyRzNYOhBIo3DR61SJlaH7Uckj35gO
	 vEuHh7OYMzDoep2OlHp3AB1ykEcb4TgyytgNEmxqMAvowNs9t8pwI+CFHj8b+ZN4oS
	 4je03shnjFuTyxqifcSxBQSTBf1dxcq/e4/rkZj4=
X-QQ-mid: zesmtpsz4t1787566533tf085f725
X-QQ-Originating-IP: GsJl8b/moBOILElwvEn5lFB1pCOHyvYgMWRUTSbLMxU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Aug 2026 18:15:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1917715364105345114
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: chenhuacai@kernel.org
Cc: guanwentao@uniontech.com,
	kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Subject: Re: [PATCH v2] LoongArch: rethook: Do not restore percpu base register in trampoline
Date: Mon, 24 Aug 2026 18:15:30 +0800
Message-Id: <20260824101530.3827834-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAAhV-H7dO4V_McOvX-KyPXEwGHvu8n1inMcdVFyKLof7_Qfh3A@mail.gmail.com>
References: <CAAhV-H7dO4V_McOvX-KyPXEwGHvu8n1inMcdVFyKLof7_Qfh3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OTnfJ5NUztydNjUc3qG8ywIbebaoyu/UtY+e9cX9QWm+C4PBoR0SEcSq
	/HJXi+h1TvM8FwGMu/bxJERphCz+2+CkGpUrh0zmXVkhchRTN951MuPldx3sGzjPppxqnq+
	p3qHUf0oL/5LzsLJHv44XpjBVtaVXCJNutj9GXBmr4Nx2JJYDOGXLSEuyu7TLs2A3/JjkhP
	NiUJWN/bNdRR5rLXBegQbVqDblcnpER1lcamOkXQZVePL7jfyAdhllYO2GYcz9lRpb/yd1n
	Kir9q77fQa0XvaupS5AtqPJJgaUGnK4UhoQmnDcKJZWSxZ5TnJGj/8dYEP47yDbfIKpTiZQ
	8EHnMSfQeWksbKdKxRwuIIFErM7vCiBiFdq2+O9SXtjaaU4p4/LpKDwx7jx0G0xEIOUvela
	aCSs9Xu+xplcHZHQdvmalWrQanTYSE9ibZkc3pGrJCKuasBGxGVUEtUHuHTz7aWEq8WbKg/
	3nBjrL5IGNPSLLsDOFwWKxFmos3LjLj7441BLAiCN+V2s39xlYPylj1qZwvU3PrH10+h7CI
	m2YV3sdQZ7jnzu+M5tVozvwoNwztsvGbz/3epYJaWTxGmISWjc/+LDt9MqdDHyUqDsRAtGm
	S6xYZsoOWvhlJIXdmd+x41XKiwTZAbhPVWvdZS9EgEUE0E26ZCBqw79wNszNiTOPUq6EzEE
	EBnqd2278wiLW3erDreemC2qcOKomnk/fOTw9VHmiuQaSR1DaipZJs7sSOIo2ZAYYCjhlTP
	mPtBUzApDxyh6rx3SA8hhZdsPgeR3JiZFVBVfqMaQ7FQ9IEwtWyT4E5+5e1ctry9fpWxp7b
	9FZXeNhz1SWR95UPUDj8eebqyGmIPvDS5KTZjnI6L73BljCyohc9EtCR9IVyHRwmLZfN0Ty
	0JZr0yJWg5eHjRvJO64ATwA3Jl+yCMBINuo5PClGzmnEQy5TWdWQHrXjsgBN6ROSeIvgxDT
	ohFvR0wBJ6YjOxhC3c1FgwV+4nYBwnflDCxnxbPDSOB9uP0V6qDlPGJ13BNv5iQpCIVs5b6
	FGa7e6fm2A9yEA/o9vmoOTUs3t7ZtswdyIxuNSlpA5A8tcPqylz16LJtYDwDlwpw2AV/dsN
	E8C2uqkcfXmTDfMpZ85p+kcMJopkZOLrqma496fAMWEwByVBI0yazFncMia9yKVhehUFgS3
	nK6rGAnYhMLQUbweHGOOThbBH9a1Dh2yjK1d
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

> > ---
> > changelog v2:
> > according sashiko report, keep cfi_st u0, PT_R21
> > Link: https://sashiko.dev/#/patchset/20260824082524.3801394-1-guanwentao%40uniontech.com
> I don't think AI is correct here, if "leaking" a random stack value is
> unacceptable, then "leaking" $r21 is better?

So, 1. v3a back to dropping both or 2. v3b keeping the frame deterministic
via st.d zero, sp, PT_R21 or 3. v3c keep store RT_R21 for just a completeness
stack image?

BRs
Wentao Guan

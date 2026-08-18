Received: from sender4-of-o58.zoho.com (sender4-of-o58.zoho.com [136.143.188.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF4B67E
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787012515; cv=pass; b=qcbYF5EdY7E4semn8YP/FRhusd0Xhhl+zjT1gAbmBHBZGJ0ijtKG63TemZNT8T+INbcbh189dnG3dwUJ+W5XFbMtuXUW1vGw3Gnlq6YrLIrTyCE9Js31+GCWbK3Y9L6DpCu0AfQDY8vfhPp3EjxFcD0MhUgZy5c0YlCG8EPAez0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787012515; c=relaxed/simple;
	bh=vSoYmiYRRcXXelA9COg2QH6CJ2K3afbzpvVv8IzaTYE=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=QOxKzTu0GUoRgyQQbebt3BuYbRwc1e6yEzMKMsyhxxkPLYvUv71AwhjWlqPS3UNc1ODRrp75ZiI8RAFNy8fgliGopzGsrsIQjBFoM/MrUmsLGa79WW3jfr7+AL0VcbTwlSWpnfyYMCBUFcbfUxfN63zqzKDSSZKj3DdgHqeTxDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kunalganglani.com; spf=pass smtp.mailfrom=kunalganglani.com; dkim=pass (1024-bit key) header.d=kunalganglani.com header.i=kunal@kunalganglani.com header.b=Ud9qnVFb; arc=pass smtp.client-ip=136.143.188.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kunalganglani.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunalganglani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunalganglani.com header.i=kunal@kunalganglani.com header.b="Ud9qnVFb"
ARC-Seal: i=1; a=rsa-sha256; t=1787012511; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nReVkmSIPBNKSuRdordv/x8q4gStIaN1NL8PFX3tn0IVSdynd77yB64k2oeAplAQB+7EFHTDNcNHdAmsKPRDIdzSilz8WdJr9IG7a2L2QUDNlNf1ZCZ4eFj0hl3wzfmM+7HSjZitfDEJPQ74m+JO0H0imIcQYm1eWh+lHzziTRQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787012511; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=vSoYmiYRRcXXelA9COg2QH6CJ2K3afbzpvVv8IzaTYE=; 
	b=kwmtbZYxU3/4uVuHLcitH0t5VsrsojYfRtwmGbdVd4XV8/SZwt7RbRLTflDZkAgMR4LK1HgusKBqJwYFmTL5rocHBXy8Hoj0+7/MN/Ny4fAy8m//kZDHuICshoqgx0tYRdcK+CBA8QpGa1F3w+ZONZZR2/R+mhtFjCHWMc6LnrA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=kunalganglani.com;
	spf=pass  smtp.mailfrom=kunal@kunalganglani.com;
	dmarc=pass header.from=<kunal@kunalganglani.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787012511;
	s=zmail; d=kunalganglani.com; i=kunal@kunalganglani.com;
	h=Date:Date:From:From:To:To:Message-ID:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=vSoYmiYRRcXXelA9COg2QH6CJ2K3afbzpvVv8IzaTYE=;
	b=Ud9qnVFbu23POmxhZS2ZrupZ7Pxob6B4X832wJ5vvoUAiC6Kq+KGxnLLlv2DlqNn
	ScICxmnehCcB+XfQEKCFikGVQGnZfd4BbJAgXqfDtdfbfsY1Hz8xiAV1XYPYF/x1J5Q
	j5GYIGzKDNfb1Ylei7Z/Is0Me0AlNB2F3ixDe59A=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1787012510818709.0038323896017; Mon, 17 Aug 2026 17:21:50 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1787012510242516.0211957839647; Mon, 17 Aug 2026 17:21:50 -0700 (PDT)
Date: Mon, 17 Aug 2026 20:21:50 -0400
From: kunal@kunalganglani.com
To: <stable@vger.kernel.org>
Message-ID: <1a0123ef221.380b89e6957335.3107400625328507001@kunalganglani.com>
Subject: Guest post pitch for kernel.org: 3 ideas from a hands-on AI
 engineer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

A hard lesson from production: in a crypto accounting engine I worked on at=
 Bitwave (Zealsight), we hit a scalability break where ingestion lag accumu=
lated and downstream consumers fell behind. The fix wasn=E2=80=99t a single=
 =E2=80=9Coptimization=E2=80=9D; it was adding clearer queue/backlog visibi=
lity, tightening batching boundaries, and simplifying the data path so we c=
ould reason about throughput and failure behavior under load.

I=E2=80=99d like to pitch a guest post to kernel.org readers=E2=80=94ground=
ed in measurement, hardware reality, and systems constraints=E2=80=94from m=
y current work benchmarking local LLM inference across Apple Silicon, NVIDI=
A, and AMD (ROCm), plus prior distributed-systems work.

Possible titles (choose one):
1) Performance: =E2=80=9CFrom Backlog to Baseline: A Practical Playbook for=
 Measuring and Regressing Throughput in Production Pipelines=E2=80=9D
2) GPU: =E2=80=9CLocal LLM Inference on Linux: What Benchmarks Reveal About=
 NVIDIA vs ROCm vs Apple Silicon Constraints=E2=80=9D
3) Distributed systems: =E2=80=9CDesigning Backpressure You Can Debug: Queu=
e Signals, Batch Sizes, and Failure Containment=E2=80=9D

Writing samples: kunalganglani.com

If you=E2=80=99d rather not hear from me, say so and I won=E2=80=99t email =
again.

Kunal


Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C452D3CFF5E
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932554; cv=pass; b=kn279zVcvBD7Tjz/3A7gzlBIoCBuhAxCb0w1n1DPz3+d4va9T3UptZzCEyTunh01zgS5l9AUxi723fHxInxWd1G3wuxYfUjTtsG74MFEKYyn6rUnDdnzuALQu6Ts25Do3utqi2nbagl3fahZn3L2QF7z6EXaEWZGfkZGoY0HFfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932554; c=relaxed/simple;
	bh=OI9kyY/eIXiwDJQlkP1NTCz1k8ZUsmR6Qz7FiRC7tgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otuQMhVXIgn2LZxOgt70WJdU1HZ/mvQkV4+zF6BC+jMVdvcO+rt0KEysnMh0L8eYvTl3R6p5jvKi4jCOS+ubHAaqLAvRzJudU2Va+vzdPEPJfRIcQ8+BnNUB/XQJU1SAf7xYi9FSiwUsQZZPJCe+KYAIAgkEqV/+EOKxAD6mkNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VA4SZZxk; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VA4SZZxk"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e5d6f35c1so227832885a.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 01:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783932550; cv=none;
        d=google.com; s=arc-20260327;
        b=BOxYAulwsbb+nNDCiT/I5iy10Bv1Ph3ULr1kOgRhLAgV9PashDcuu86oPZjAH79H5p
         fCdjQtmeQZCffugIZu7FFSECeRpzcGEjDpuBCJdjTyUkFyI77X1OTclW+pnO9Bw+6NkJ
         pCRJX2gJU6zf+6kXfFS8l5H3y6ekmXuj46o75m64E8vjlo/SavsfsC0hBhW3fidBrMZm
         lAOoAHXaVHwzfd8lTS80XrTSWdgHgooCgRKh5mag2o3Az2FnRRimKNRuZ4mWqyYkxgxi
         Ykkm6D3EX7GhAilMkafdB3bDevQDTfA5GDNOxNypgKvq8Z0gw3/RL4t0GWUZS7O1MEGu
         pY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3QeXRhEeLsJ9M/v/PCGpg6ym+QyLMSFbz+fam7a09/Y=;
        fh=PtDCivluNSIhSZc0gBnZ2cJRYUs9mOmMwkJ8wzhWFAg=;
        b=ZZlyiHDvmvcjNMGU5lvmByMa5eIvPbPj1lqE7K27cVojbbCTT+J6lyyo52YfXyV1Hc
         9jES7BgkjZY/6eTCCqNEYeH9w6HIzJATn/E60JMHAk8ETgjVT50BX9Sty1biNLgFoU6S
         RVtR1VwsGp5nnDtYE1OURzIJvB388A3WSVxCGquv9v+IQlbVeko5r6Th3aIUJJxnud5s
         lsQnEB3+hPSvyjS7NCUUTPpmRVTyn+Je5prXf7D4UGmDID48XSEloMoWHwKwQdjHUEz9
         /r0bmrNHt41dL4MP6yHCN6p2BCk6YRFzNBqevjsiWz9MDbUGKcRtP8/vdJ5zlvYsQoQg
         2xtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783932550; x=1784537350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3QeXRhEeLsJ9M/v/PCGpg6ym+QyLMSFbz+fam7a09/Y=;
        b=VA4SZZxk68B31TJJyObJvL1CLRv0yrADyCT+wZYvYP3J21FtjAg/1ggyjIYf9YJzY+
         YdDA1kMzBRwTBIvNyauUHP9433qfTnjQrCZc6SZHuuzXJ6cIOV+1PgpWeZKQdq/itCkX
         TUFias1/p8r/eXMJzfz3PN0M1S7XE8ieh2ZFCEMxnbDbpf5b4diVDfi8g/bqs5bMHIWI
         AJigiB+G+35TIRgNppxs7AzX+iHjMlEMG57vHhhCXIbPvL1IaaHSxObtc0vrmTFx12a/
         4WFYkeWjrl5Agh2yT/27E0VlldCZY0d6BHMcoHMbIX217v+bou6PqpTd+bN2mkFOoE+C
         lgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783932550; x=1784537350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QeXRhEeLsJ9M/v/PCGpg6ym+QyLMSFbz+fam7a09/Y=;
        b=TV+y58bdkEu8qsT7R/P0vFiEbe4ib6wubGL9FiBr5xPIPISgIKVpa50Mhja3zny6VI
         yy39dTJGfquKgSC9TlmV0OYoVE2f8/X2esp2Srz8vH+ubPdyLCfL/6TZMTClzTgTu+Kn
         ZRUF6lmtVdOhVOQpVWz5Rnpmnc95Ck/xZlHxzlfAxUaMyX+avUQast0IWb7LnZPeS3Se
         1+7JgFhWGtOL4w2Bkvdvrj67z5AykBf8ESVCiL/ltfv2AaS6ddL7TOpNQ4cg3AkvCjZm
         JVH56SKW3ejRMkASvqhfpVCs7HCMBvhmSWPuC+KmKmO2FiNPrqjIcPp6IlleWqQiz8RK
         0qWg==
X-Forwarded-Encrypted: i=1; AHgh+RreC+WwQJIy7TFeZ8Fa9xSZAcQ2yDaGr1gy2zs6GQ7ClvAWvDvWCYgCN+JX5Wmr134N5v0hdHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmAgSqDoTZsT7BarEREVBZJUwGo7aLEbQt1+V77t48VFRaFzR
	rwPLBEg9cl9LbkI29ut/AD+aLvjFugBKHaC3pxfA7a9kTatbfr5kWYc5+NDELRxdiSCUa46Zkxo
	VOWsea51HNO6aDXhBeF5YiTORRRCsSnznqoleUDCX
X-Gm-Gg: AfdE7clXX0uHjyzy6hGGqg2VP9LVJbzZqaYU5HINW1yt+k5ElzLhzBl24BU+D1ZpA6Q
	wIhgmYXBp7eCrEC4VgT9Tze2umOO5NK4cRi8nA4P4j35l3bSIJh+FTqQCeIrjZI2E9N/yYBq5gV
	LfUSPz+LCprAjmu2sqzokyDBf54k1SZpz7x9w4jSavsTpn4nKXTdteAlhM5TUcSTfAZEFeFGS+U
	14qVMfeVyEXprJPU+7LKTkQusp66C+J75G5vaZZetxXCzBWk1ViAmpROJ2gpYVVKQlT0zVnodAx
	qS1g/xN33tErKixJP7k8Zzf8+M9Q4BHveDsGOSDjCiXN88uPKDL6JUinDuvXD7342GLivsPX6zB
	4E27VUpU/luA=
X-Received: by 2002:a05:620a:4056:b0:92e:cc01:a67e with SMTP id
 af79cd13be357-92ef2ccac2emr869849485a.76.1783932549214; Mon, 13 Jul 2026
 01:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713081842.3119-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260713081842.3119-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Jul 2026 10:48:55 +0200
X-Gm-Features: AVVi8CcxvHiV3rBj-_RY-o3IkJxjxcn2RPOT44y0K8E6bAHhf_6ECXqv5C1bz7g
Message-ID: <CANn89i+jA5kPcZrjXfsY1ic_LjeEwPHi-U54kYmZdkBKHB+vTA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: initialize standalone IPv4 ACK options
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 10:18=E2=80=AFAM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> tcp_v4_send_ack() constructs standalone IPv4 TCP ACK replies on the stack
> for SYN-RECV and TIME-WAIT paths.  It currently zeroes only the TCP
> header, not the accompanying option buffer.
>
> TCP-AO options may have actual lengths that are not 4-byte aligned, while
> the transmitted TCP header length is correctly rounded up to a 4-byte
> boundary.  tcp_ao_hash_hdr() writes only the MAC bytes, leaving the
> TCP-AO option alignment padding in rep.opt uninitialized.  With stack
> auto-initialization disabled, those padding bytes can be copied into the
> network packet and sent to the peer.
>
> Zero the whole reply structure before writing options, so the alignment
> padding bytes are initialized.

Please fix TCP-AO instead of slowing down TCP (almost no TCP flow is using =
AO)

Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6833F493627;
	Sat, 22 Aug 2026 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435656; cv=none; b=fU8c1ZFBN/+vigYFiakcS/N/3uv/bIKNKgucS/nnuDGEgiMO7eYM8lIYLPV+SdvTkbjHHF50wXZBJDVsG54eedVg5fXoI7dttlUuJcZk2M/R7ENhzjMIlpDpDVxMpwZi9GPKw/XlK6nqE3aCLv5UNWoCU1RlE3IdGIbisEEsBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435656; c=relaxed/simple;
	bh=Rsfi6VTa1cx4QP58MMZwnaeJqvXHCHt8CIYSlcjy8iw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Zf6JNQGolA1ttfNmWt/8i189z+r1bRoR2PJg8pjJgv5u4Dc1p9tLHKT7Kv2aF9Je1AOG3pdcLguAbgc9/MaDmN0VODoV8oyHtK3SIS8tQgZM297GqpizRCfIZpY2t/3nUoqzqTwNajwB41Qx0jkctgNykYWu1P6hQo04LxRUSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=bpXu1Tiv; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="bpXu1Tiv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787435258;
	bh=Rsfi6VTa1cx4QP58MMZwnaeJqvXHCHt8CIYSlcjy8iw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bpXu1TivueVgiuWxWyhE2TO/X4SN0GrzlrFLdJgepUqBXxwdA6bOyaMGU36gn4Ozh
	 vn1tyN99d2OQ957rhrm8hDPq/ja3DmGnCcW9nDHVl70yvbwwuXn6HfxfFTY6un1gqJ
	 IKeLeXfnPaoKJsm2GDZy3ovGu+tHS1cxNKODvvHk=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hS9ky3nRkz6vKn;
	Sat, 22 Aug 2026 21:47:38 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hS9kx67P9z4y6W;
	Sat, 22 Aug 2026 21:47:37 +0000 (UTC)
Date: Sat, 22 Aug 2026 22:47:36 +0100
From: Bradley Morgan <include@grrlz.net>
To: Steven Rostedt <rostedt@goodmis.org>,
 =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
CC: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, mgorman@suse.de, bsegall@google.com,
 dietmar.eggemann@arm.com, kees@kernel.org, kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, vschneid@redhat.com,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_fork=3A_initialize_functi?=
 =?US-ASCII?Q?on_graph_state_before_copy=5Fexec=5Fstate=28=29?=
In-Reply-To: <20260822174053.26aa2f56@fedora>
References: <20260822195321.962383-2-Jeremy.Jean@oss.cyber.gouv.fr> <4E2240F5-1211-47CE-AF04-24E1F0BC4707@grrlz.net> <20260822170928.1acba2cc@fedora> <603183e5d6abcae2229c61b8e266e60c@oss.cyber.gouv.fr> <20260822174053.26aa2f56@fedora>
Message-ID: <B701B25D-C39D-46FB-982B-5681B3D45CC6@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 22 August 2026 22:40:53 BST, Steven Rostedt <rostedt@goodmis.org> wrote:
>On Sat, 22 Aug 2026 23:12:35 +0200
>Jérémy Jean <jeremy.jean@oss.cyber.gouv.fr> wrote:
>
>> Oops, I did not know that, sorry.
>> Do you want me to resend once more, or that's okay?
>
>No need. It's in patchwork and I'll manually add Bradley's R-B tag and
>start testing it.
>

Will you merge it to one of your very cool tree(s)? I've merged it to my
friends distro tree, not maintainer tree or anything, but I do tests, I
guess that's like future learning! ;d

>-- Steve
>

Thanks!

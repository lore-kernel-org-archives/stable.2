Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169237B022;
	Mon,  5 Oct 2026 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235291; cv=none; b=BeffZqt/syx9LaEgxXw2ab0aV9YmvXeNVTLqkpdijCvqVhH1kPq1ML9SYaHPs+crxdKHSr+f9jH3cpY9Th6DwXwxMFgGUBQaAI3E9gi0wFfpaHKO3xDfPIw3aAcOOStv31wyBxLEXWKA5yYQ2547bmktAFL56ODEcF1JoptMTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235291; c=relaxed/simple;
	bh=thdx6/Tpa0kdL9sBRWX8zSc2G2OSo1LDXdbpbRaiO30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcsTtjDNCMDCRjR0upiErgAA7O7wcH/a04/ELPJOv6tpY0nw9/KolX/xCkwBjb+ouX+GrOmea+c1ZjsQJXTwqSTu7ZpqWLOcECgdeQYydNkNxdv/s21LA5BY55oCmg2MH9qVLMKLTmAEfv/VQYW29g5l9KKTmALe72fVNnE8IQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBA8PLkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBA8PLkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E641F000FF;
	Mon,  5 Oct 2026 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791235290;
	bh=thdx6/Tpa0kdL9sBRWX8zSc2G2OSo1LDXdbpbRaiO30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QBA8PLkPqSJSp950kcjaLgOMRvgZf6jra9tnaq9ySSYHZoQtNwaQEOCqgUQMsfoes
	 3yCqaxVDCn6E6GdSndHK7GAWLMvz5w4hYp1tREz2ATEtDo3eWe10FP4tOaDA/L6GmD
	 FdY/gOwfAODqGgC7o6v2FFoS90s8LpgbP6Sz33w10H9G9srezEJQOOzBBrX74wezPx
	 JzSQa9Gd5Tf0LMGpzpfwHXYXJYPa4dYYOVbxZA1t5GCME3WKgnA4TVVLxsiYon5lYX
	 F2qZwmSeJm8frmTO+dFm6u1spnqI6NNK9sVAFDog368TqxERYXqTDrT0nv3SLzExlC
	 KPKl0EH2P9lWQ==
Date: Mon, 5 Oct 2026 14:21:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, "Miguel Gazquez (Schneider Electric)"
 <miguel.gazquez@bootlin.com>, stable@vger.kernel.org, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, "Samudrala,
 Sridhar" <sridhar.samudrala@intel.com>, John Fastabend
 <john.r.fastabend@intel.com>, Benjamin Robin <benjamin.robin@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, Pedro
 Tammela <pctammela@mojatatu.com>, Simon Horman <simon.horman@corigine.com>
Subject: Re: netdev LLM review for backports (WAS: [PATCH 5.10.y] net:
 sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode)
Message-ID: <20261005142128.30f80c5b@kernel.org>
In-Reply-To: <asOtjgd0NMXMjCCZ@laps>
References: <20261005-cve-2023-53733-v1-1-d716b944802c@bootlin.com>
	<179119639380.1402591.2155637888002963@kernel.org>
	<asOtjgd0NMXMjCCZ@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 10:00:46 -0400 Sasha Levin wrote:
> I started seeing these reviews on proposed backports of net/ commits, and while
> they are REALLY great for upstream commits, I do not think that these comments
> make sense in the context of a backport.

Blah, sorry about that.
Let me add a regex on the tags to exclude patches with 5.x/6.x/7.x

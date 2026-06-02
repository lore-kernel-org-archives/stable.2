Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79EF390C8C
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424502; cv=none; b=HFueSIW1U1s6eyZGq8tI3jaRpgEVVn6e+d7bJC2VQqTrNrEiivKcQxhZg4f4GbU3+uk9AXxo2g5XfFsmR29ziXxxxJEFT+OXmLRoQJfSwyrPaOnp2L4uaEmJ+kE3b37oEYlXOLGNP+ak35Hz7bECKGcTi4YPZcowNUXQWxGeVZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424502; c=relaxed/simple;
	bh=bLNk4YQ7V0aWh/ltmKyQ1PTzjeephg1z5nvy8HsGpmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYu5K7aCzdpHFzy/mDwTw+g5cU4NWZxADkhEgpGT5+CkZRNHxpgnlgu6HiwukMiM/4R42qN6zSFZnWo261QPXV00EDT34Im8bbXf/6QImE4aF+c+cfYypMCbdgkt43bwmerjqh4AgIM8n6wsusQ+OxRSSEYR2ia6hs+aEJbhTRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvkizhFI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvkizhFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1495E1F00898;
	Tue,  2 Jun 2026 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424500;
	bh=6s7r+T0XeSz8PrDRUBCZyebkpWeWHzvIPR+oIDL9M6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QvkizhFI/c4HbC/P//4+C3AfdSyFJUaYFlYl4t8Yrmd+u0aTdb7F+IEFwsE0rZPMU
	 xqr5KJ9py+3WdkYvPDf0/cvRGxIiCJMW9wlLdIw/gPqpY/46mFbLwgwI5hgOlbSEr4
	 vRRsdN/UxiWuBzTSGeB7rsDq8Sm/bRYTWo4szfRNCwXc3hjgK5VPgdCmpkLwPIYjLH
	 jhtCKnqZn64XG37fn8A8RPsOTrE2jTFxU/TARRXaizC9xChHsfU1r4891vsncFSCNx
	 a75p1jwLQL4YxHHUHXwOx242kgwvBHPNTh09cXGRRJcw5+3u0jAiNxhI9hlwJrvusx
	 a/fXxcNaRBaXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: Re: [PATCH 6.1.y 00/11] Fix BPF selftests
Date: Tue,  2 Jun 2026 14:21:19 -0400
Message-ID: <20260602180500.bpf-selftests-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780392092.git.paul.chaignon@gmail.com>
References: <cover.1780392092.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jun 02, 2026 at 11:28:43AM +0200, Paul Chaignon wrote:
> [PATCH 6.1.y 00/11] Fix BPF selftests

Thanks for the series. Patch 1/11 doesn't apply to current 6.1.y: its Makefile
hunk context references json_writer.c in TRUNNER_EXTRA_SOURCES, but 6.1.y only
has cap_helpers.c there.

-- 
Thanks,
Sasha

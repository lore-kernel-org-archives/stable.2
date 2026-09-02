Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF8435EFA;
	Wed,  2 Sep 2026 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788391869; cv=none; b=M8Nr48IDEgvmhU/a4ts1z/WC9mu1XBQ03mZsJBTU4sZ7QmPQgkYlW65vs/JQC4htBxi6qoPHeyKWY4jtD+OMXyKiHd0mfboeGNfbnuJMHc8nE96HKLHp50uHT3KW4WDBH+/caplHgUjA/+dR4AUfBK60bm27FntihTyyTYePXtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788391869; c=relaxed/simple;
	bh=0UhbACsDU2oTOq62/abzW4HiNU8D1H1dkcEJ9tGhcGM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jCuQzN42y+yeOMZMfm7BXLgTlWt3YlJ+ACZx3Xv1mDrrh2Gc6HNGmzGbVkZnh51HRyz/nzr/f57FXT+8MOqFdpoGMFB2Pqt5T15jLsSYuMBBOouC/SsR6XLVE5PaePnr+rBO9KBaeZ4U24BMOJ5/ZNU5pcWp0Qx6My8OSakKOMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcco0RIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcco0RIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678DE1F000E9;
	Wed,  2 Sep 2026 23:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788391868;
	bh=PQnTbzQPDgQn+uw5+s+AabTrlNKO2/fQMYubYNkZ7oc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hcco0RIbqfdmKAH3pHYGL3A4DErnrVcNqWCtHBPt3/UG67rPPEOb7iv28x9iu322L
	 TAeA355Oe25j0aG36PZ2Fwj4USUmhm0gHH9wTFupMnWCbVmEH5/vvA0U4tFcQ9kaLK
	 M17KFNStu2Cl96zbJ2lOy8hQeVf3puBNi4E0DO0nbfdjRQG9OWFOlAp9Se/zJJwQ9P
	 g885bNZQTb8rbIFDYYwElMZbUAhY4DLFaCxV8HxWQohJ5qq6fRcsI2bJ3znmAIzd2y
	 3xTQZ2vf83+jJjhiWtvOqIdf/ZO6R2wj+lRy0BLFJxvwFRLPdi7kYzHDQ3txASnpSy
	 7zAw0j7RtPmug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5695A3927053;
	Wed,  2 Sep 2026 23:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5 0/2] bpf: Fix queue/stack map u32 index overflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178839180989.3000007.9654555502617060828.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 23:30:09 +0000
References: <20260831063226.621309-1-chenyuan_fl@163.com>
In-Reply-To: <20260831063226.621309-1-chenyuan_fl@163.com>
To: chenyuan <chenyuan_fl@163.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, chenyuan@kylinos.cn, stable@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 31 Aug 2026 14:32:24 +0800 you wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> This series fixes an integer overflow in BPF queue/stack maps.  The u32
> head/tail index is multiplied by value_size to address elements[], but
> the storage itself is allocated with 64-bit arithmetic.  When
> max_entries * value_size reaches or exceeds U32_MAX, the index
> multiplication wraps and push/peek/pop operate on the wrong element,
> corrupting map data and leaking stale values to user space.
> max_entries == U32_MAX would also wrap the u32 capacity counter
> qs->size (max_entries + 1) to 0 and permanently break the map.
> 
> [...]

Here is the summary with links:
  - [bpf,v5,1/2] bpf: Fix queue/stack map u32 index overflow
    https://git.kernel.org/bpf/bpf-next/c/802a30c5db72
  - [bpf,v5,2/2] selftests/bpf: Add regression test for queue/stack map size limit
    https://git.kernel.org/bpf/bpf-next/c/33576bfee5b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



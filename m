Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED4390618
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952901; cv=none; b=ul8FYgyQjbUZXmNFpXMY98dS24JmWKAI7Es/OBJv2bKI9wGRmcry2XpnHFfvbd66ZLYOSZR099XVyOw1wfZpiCtgGyMG4b+1stOGvmCQ89QMkH6wyKmv1miaBYhiKrvNm3BzPf+GsGP4uwci0bs4LHiPRlgQYGlejtzI57P1xRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952901; c=relaxed/simple;
	bh=KILH+OOA0ThbcblvuVAEgdGql3C398mPUD66caEU0As=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hc96HijE+peOrQKEnY3ooi8iHS/JEACH/ohEcrxLrg0tVfD9R0uvK80Vk/ZWKiIGlcAwg3V3TMJD7M54SqH/dNfG222fEnZvA3WkszathvRA+La6DswzHUxNGq7pYsnmMIkVvXZO4Pp3ZaC2bwxd3YXWTJdeA6uYAIIdzZ6z30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gaHeCdnG; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gaHeCdnG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786952895; bh=opBOpwT3kb/x2ZnFUUpehu1KTMBnLjc4UIJXivfi+oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gaHeCdnGuYmztEDFcmHnBTNxEGYhmQfxk2QHybFUPC7a3j3dxbHb0sRnwy9UEHV6H
	 5X8hr9z7kEUAjHdgaJtD0Hm9/5H+4GHJ02Ftz+Zxc58yNa8hCF4XvllDJOMTWcivKH
	 r0LEMHnzpJy5IZrMMSYKUo2wu2NNXAHYPmO4WdWY=
Received: from localhost.localdomain ([117.88.121.65])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id BDDA2646; Mon, 17 Aug 2026 15:47:29 +0800
X-QQ-mid: xmsmtpt1786952849twq2brmki
Message-ID: <tencent_EC328062C381CEDAEF690B8695F7752EC105@qq.com>
X-QQ-XMAILINFO: OMwdwY5aSqdOMlMuSIs48YkLCwzCH044VrrUv//fr+n6gC6iDzCU4Yz6WO7GTt
	 eiYZG1YBhEsl1DDOo9PLrubCyj4VE9VjvdhoC82rXZM3IN+JclzmKRJTHAckHVdywZrspCeViuJU
	 Z9w929d5sdAM0FthnFsCmhilNoOTGoYoVkpjT2asRNy3+pPv3B+ysx+1X4hA3Ch8TrE7W4u0zSxo
	 hsHJCpH5XFBA3CI854CWPxXqlRDNoLm3hihiLEPwxLkHlrSE5J477YqOhOMnVyorHtKCsoSu1Vac
	 X+tAYTeSmcFxhwcfoTidPFOhaJJn7JZ5UvvDjzptTiv5VJzs0y50HchLweio8Eyny5MNW6AxzJe3
	 RmId2sV5piDDk8x1apJQbwk7joV04s7ACNxqvqaZ8Clte1PqgPrFHqHnqw2zq6B43a86mzpuk6rr
	 tZzwtxJYcrBCbpe1RfUNMKF+lj6ZeR6x4n+03ntQwGyYisunZgLinIXCle1mL+gbf1Rm96v275fJ
	 OCiSkIkzcxseCq3E4FgI0el8Ul73Pqs7kHvyir/jlbQjvG/5VYisD/NiCgJpiPWgfMXvKX2qnI2o
	 6pMbRDsbjRxFC996BhatyOW5pUbUJscUxsa9EP2FVHIRZmD7fmneq/WBRtV2R97WDDQKUTxCjLHG
	 SKndVsM2RtP1V+gBYE2w5tXqBzNaYAfBeFUciH8TeoPZwQB64M865Lc+GJENlR/hpb05Ff4V6cSY
	 8MFXtU17ZyNGZ8TYUtE9SWdBBRKrxk4I80U/Xny0qKp8UpooY/1Yt0MKB9iNZKWUMQaMUSKUQ+7b
	 IMrOG/niU7RYRGdUIQfPjCVq52/vw5R90Rq99z4QWWUcmdgqFbgox7+R7TWwuyQg6BsFHlqKEk51
	 2W7X+h4jepif+Y77Uo4JAQgo9Rdr0ZAb8KXRorruibIVwAG+9fOv/mWBw/Xb1pmBvllpSlka9Xti
	 0a0i4a0fBhGsDGR4MV2V3u4WW6xuk91DpYS1Jluy0r3t50YdBpE2e4ybY976p9yUYwN7/QMow5M3
	 3HiI7Ebh1JMpeiI/Y1WRO4P5Y/ZnMbPfyB1RZu6NORmvHVkZpxc+WGBLyyWUH68W1Scxn5UQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Aohan Mei <3472274613@qq.com>
To: bot+bpf-ci@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	jolsa@kernel.org,
	zhuyifei@google.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	corvus@tencent.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 bpf] bpf: Enforce cgroup storage map consistency for freplace attach
Date: Mon, 17 Aug 2026 15:47:19 +0800
X-OQ-MSGID: <20260817074729.2888421-1-3472274613@qq.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260817062306.2707661-1-3472274613@qq.com>
References: <20260817062306.2707661-1-3472274613@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Aug 2026, bot+bpf-ci@kernel.org wrote:
> Does this Fixes tag point to the correct commit?
>
> [...] should the Fixes tag reference be8704ff07d2 instead to direct
> the backport to the correct range?

The analysis is largely correct: before 7d9c3427894f, the extension
could already observe the target's storage. bpf_get_local_storage()
resolved the buffer through a per-CPU pointer set from the prog array
item in the run loop (bpf_cgroup_storage_set(_item->cgroup_storage)
in include/linux/bpf.h), bpf_cgroup_storage_assign() enforced 1:1
map-to-prog binding so an extension and its target could never share
a map, and be8704ff07d2 made EXT programs inherit the target's
verifier ops without excluding cgroup targets. So the freplace +
mismatched-storage combination was technically reachable since v5.6.

I kept 7d9c3427894f anyway, for three reasons:

1. abad3d0bad72 ("bpf: Fix oob access in cgroup local storage"), the
   analogous fix for the tail-call vector of the same
   verifier-vs-runtime-context confusion, uses Fixes: 7d9c3427894f.
   Identical tags keep the backport sets of both fixes aligned.

2. All currently maintained stable trees (5.10+) contain both
   be8704ff07d2 and 7d9c3427894f, so the tag choice does not change
   which kernels receive this fix in practice.

3. 7d9c3427894f introduced the shared prog_item->cgroup_storage
   runtime model that both this changelog and abad3d0bad72 describe;
   the pre-7d9c3427894f per-CPU mechanism was superseded by it.

That said, if maintainers prefer be8704ff07d2 for strict
reachability accuracy, I can respin with the tag changed.

Thanks,
Aohan


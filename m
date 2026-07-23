Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D544570F0;
	Thu, 23 Jul 2026 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828698; cv=none; b=pPUwMgun+FgB0m1lcblu/YPcwn7IwoxQjavfuE0S8VE7bjCq2j85qzUvgCkGMdBYbwdXjw5WMcSIjlVTclJp+GXF03ACpUeYtSeVab8hq2/lt+RmU3O81kTrfqoEtNLPwFQ4aTaRq6QOx1tQGWUE/sdkwGu5YgxkuSeSxWwsMFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828698; c=relaxed/simple;
	bh=Mc0ikpVE4D8T2nhcDILSX5EXSuUsW38c1YxRpHZKpHI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EoQl1rRYgBMbZuTOMP8qiLS8Yye0V9UMS1m1q8P613Bp/qfceKDU6B7V+kLjotvMtL8LmWirQWAhbvj3Jo9NqgpzNfIM4dBiw70KarYWhiWbes2IYOOgjQfGG261coThf/6CV675I/6TpReOAb4jR73iGEHSSnLqSc7R3RJlxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkmFPgxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkmFPgxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FAF1F000E9;
	Thu, 23 Jul 2026 17:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784828691;
	bh=c+Bq8pXLI9TzksCSFH5Ox+fpIA7C1MgV7GUSoySUM8o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jkmFPgxmmPV1KVNkY/96Zp4o1QfAReJhEntneNojUfGgPpizTUqrxUD3HHR0UedVj
	 eJ226wArYC/RG+9wEa1B8g0YA7iRqmXcyPa7Blljnmj+Fg1r2pBiZuEU8i4SoevJ2n
	 4Vz2Omr/ppOvZ9K16t5LfeRK8UO0cuQCTeoBkfKDD6BXqWzWKE60gBN3wibWSbM9Iy
	 zThCE9RPkGu+4hzSf6Gu9d5hICpgEIYuReUBbtL/u1TrAuJpJEm3BvlPmV84EEV00h
	 uxpAimeaewWOKnQSilyDz1rCbmgxVP0unKTtr5I48pflKOqsOSogBsRu336tl+DJcE
	 05nsQVMVxW0ZQ==
Content-Type: multipart/mixed; boundary="===============3424481302002438739=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f8b1d0e654a631e4c2b2cad033ac2a33f82bab2e13b0b415a17cec2970543813@mail.kernel.org>
In-Reply-To: <20260723162602.3275661-1-nicoyip.dev@gmail.com>
References: <20260723162602.3275661-1-nicoyip.dev@gmail.com>
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
From: bot+bpf-ci@kernel.org
To: nicoyip.dev@gmail.com,emil@etsalapatis.com,edumazet@google.com,ncardwell@google.com,kuniyu@google.com,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,nicoyip.dev@gmail.com,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 23 Jul 2026 17:44:49 +0000 (UTC)

--===============3424481302002438739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()

The subject line is missing the [PATCH bpf] prefix. This helps netdev
CI correctly categorize the patch and prevents CI confusion when multiple
versions are posted in quick succession. Could the subject be updated to:

  [PATCH bpf] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()

(This issue was raised by Jakub Kicinski at
https://lore.kernel.org/bpf/20260723100030.3eee6d51@kernel.org/)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30028532303
--===============3424481302002438739==--

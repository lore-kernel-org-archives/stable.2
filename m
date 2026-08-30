Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4A2571DA
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 03:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788058909; cv=none; b=EMBqRM3sXOLF7Yztwhp5xD7jWOY8fKVZ5RUqPJGpPgYDfWl069yNVyxUmeggXWTQnOJcEgRnDka05S1ribnDfUDlX/NcUm81UpV9A4oiYbY9Fj/hRW/10w7yVuBX9UVg8RUQAzwOLBkhfVOuxLAlZtVm7l7OkyijDyXOw00LLxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788058909; c=relaxed/simple;
	bh=NKkeB0ohd4FUT0+mrPNa5H2C+7750YfXakMa3qiB4ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=og+mgg+hCgGPdxvARBW1RxBvZ78At7OUGVarHtuBsIt+/bDbQP5JQe9SrzDpG09n6n7nhBnKNiD0diyIFFC9wsUf9y0q4N70z7H/XkotbbSKTB4EUgjq9XRryNNR1eQrobh8LrZkGOeH8V8EkSENMw09R7u1aTmaixnGwvkqIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqPu6KTh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqPu6KTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE651F00A3E;
	Sun, 30 Aug 2026 03:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788058908;
	bh=2Amj8KCs3OFtlhL1wzk2nZEPqya5YP5mxzg08CC3Moo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NqPu6KTh5qQqDimqvkeKWqUut3s533OZRAAOFei5+smMxdbdMkkj1a9kHS/Mt9cpW
	 o4fSxKIX1TFUAEQfqr3IdKspvYLixVz84sIBSTHSA/GC8T2wwwwd/x1fguJB3YS7Q7
	 Z7jUs16xK3qbHhbqzvXDHaBMFSl8ty+NetTEuQO/QrNVIMW747nF5o4VTD5wKMaPS/
	 KG5oio+i8AGSBduImiEDNoI+kkxkRFe/JG3GUeU8YzOQArNaorQUyjH5lhDcV3qye4
	 j2T9u0kTqdI4XEmVI3/aWXwoAqTT4AKKn/FDMfLY9IPlu0SaYZwKT7hwepAffAFms9
	 9owVDLVjmXi/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re=20=28SUSE=29?= <ricardo@marliere.net>
Subject: Re: [PATCH] selftests/bpf: Fix test_maps sockmap failure
Date: Sat, 29 Aug 2026 22:56:45 -0400
Message-ID: <20260829-stable-daily-0005-selftests-bpf-test-maps-sockmap@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828-7-1-y-selftests-bpf-test_maps-v1-1-6ae8132a451d@marliere.net>
References: <20260828-7-1-y-selftests-bpf-test_maps-v1-1-6ae8132a451d@marliere.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Aug 28, 2026 at 03:29:18PM -0300, Ricardo B. Marlière (SUSE) wrote:
> Fixes: 22a0cc10dacb ("selftests/bpf: don't modify the skb in the strparser parser prog")

Queued (only) for 7.2, thanks.

22a0cc10dacb ("selftests/bpf: don't modify the skb in the strparser parser
prog") first appeared in v7.2-rc2, so 7.1.y and older do not have the
regression: their parser program still calls bpf_skb_pull_data(skb, 10), which
is what keeps the verdict program's data + 8 check satisfied. The fix would be
dead code there.

-- 
Thanks,
Sasha

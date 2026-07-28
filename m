Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ACB459AF6;
	Tue, 28 Jul 2026 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255015; cv=none; b=U7xcE5c2IV/EiRBEWApS5mPefF2jykeQxUMTKxuV9MObsfOHrj3SEd7bEltkSJopAq20YNYeVejBSWtw1aavVhew5mzy5Kq5eO9yuvVNIk7csZCgXnFB8MFF5yP52ookPTVpet9+cQxkG67hgx9NfHF84Plwq+lBm/4edZlQikU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255015; c=relaxed/simple;
	bh=g+49GWDkUA7AslpNXM8pkLmxISsoFdvNosSyn/vfU1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeQYQDYRJ+VkcOTM4n2R+bEro/qm2DziZ39FGL6zc6ye3l/qd2FtU3e+lD5m572L6pxWWPbAy4kOMb6GRK8e0Iu8x2/cNihAKVtl1aNM2F1wRuKipEf5oFW3w2/sC1gJYmK5TwKwXrd/Fgyd5KIP/LhGlhdI9rpwhoUeClaCOQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWD8+j/W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWD8+j/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B05B1F000E9;
	Tue, 28 Jul 2026 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255014;
	bh=YbKmpzHeUje8oKBI4yv1fVQ7kk8mYKNhcgkzKeCeccs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iWD8+j/WCZUKgJ0+0hLQC7iE34gYjcPDX2jTTHb4qd/MYhiOexsyoEckTI2iIaT87
	 TLIhoKIy3LjJMJGP66N5q8hpZtWJ76UHPdZH9Z6N8LcsQXPcB64L8JpojPKt+zcTOv
	 CB+y2bWETavTdY0DOfjjgbj+hjdGEBZB8aHyAdvNQRq7+0MCYBqz/vio4pY+OI3CM/
	 HGNZtiGYPXtp7a6Xc6dxTrF1I6iYY7fspyuhqABpsVXfPzjPZJByQpqyI4ePLKPImQ
	 p1BemgeMz9aXrRrNmpuQl7FS+mhJNjFxr17kO1cS9/zMSIiFpudVj8QgPwBFnsttm6
	 l7pkdibdnM7fA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH 6.1.y 0/6] cBPF JIT spray hardening
Date: Tue, 28 Jul 2026 12:09:58 -0400
Message-ID: <20260728155654.stable-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-0-eb80dcf1eb6e@linux.intel.com>
References: <20260727-cbpf-jit-spray-hardening-6-1-y-v1-0-eb80dcf1eb6e@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> These backports harden BPF JIT against spectre-v2 class of attacks. Without
> a predictor flush, execution of new BPF program may use stale prediction
> left behind by the freed one.

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha

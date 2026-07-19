Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4BD3955E8;
	Sun, 19 Jul 2026 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473259; cv=none; b=AMPgq4oUliFW7Un1Vf/3fAjKYR/RVaAdML+8MztWQuWJZ5y3NR8F8hHmfc4444cvv2GBahQA3VuwdzQ+A7tPWl1UgrAJHEy5RPLZMIV8F/xUXuzN6LXv48bQqrdydls4c/v2d7I0pVlYFBynGhM377H2pOd7c4mXPHtKPnnYEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473259; c=relaxed/simple;
	bh=X5+IXpPqY1zbP3m1/C9qLGVxUdpy8v8Ufdc1UPRXyr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJLhnJUKyB7Sy4xIs4z8KVUcti0ZfCMIYWxICK6CbOuIwMChF69BG/OKMpj+Zm2YqFrZgoQ/UVdMRp5d1t/+zYGMI9nncbQHrV0vdQDHqATDgdxxbkF4g+NOiYYeUFyaZIWAsIdfSfMu0HP5ZpKwjWbRlwJjNylJQWrV67QFcV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIcXzbQv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIcXzbQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E2F1F00AC4;
	Sun, 19 Jul 2026 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784473258;
	bh=7XFHPq5doombv5JpyLz/Wpbmjc5CVKs6Bpy3BxDsQV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eIcXzbQvV4Wy2N1R2hRKBwzyf8X5lOFVNxdhJVOZcffsmctfBv1TEGtarCMq2Wpyv
	 f6zfyHuSzqs/hRqLhDnAO9rI4SVPD9DND8BxAEuCDWWF1HHxU/axoUMhnhwXJiTkwg
	 VGl/igeMHvs5mJh6OTVFdwVO+k/roXgUVmPhC8b7FEXmiJjhbH7+lt2zKouM/onmCW
	 hCliycS0AIgF7/bS9topBdEFwGcbw11pb8TiayDFlQXLOYHJqUEgnmd3c0XB9Hqz96
	 uHYIoJpcpY778ggUsU4H9QzevesVT+LY/3wUUJgihizT9j2TEXQoPDEbTQ8jOI7GMj
	 1efSimmyFQySQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH 6.6.y 0/6] cBPF JIT spray hardening
Date: Sun, 19 Jul 2026 11:00:30 -0400
Message-ID: <20260718192718.0016-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>
References: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>
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

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha

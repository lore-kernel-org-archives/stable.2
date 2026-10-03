Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1583038DC74;
	Sat,  3 Oct 2026 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791066982; cv=none; b=ipCPjFM6fVyav/l7frHoyx65SkLHqOkr6j6bt10VspT4cBt1PaqiNMyDTJGrNb5BkAwoEjJIyB8vuvA+7rnc5FEoA0LLIinjrclSFlZ9MYRmcps7sm+v7ZjEn7Je72FbD9/D5oCSqi/G4zN3Ah3qRe5TMrN5G99eZOyogimvL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791066982; c=relaxed/simple;
	bh=W4SVRElZrDmmG+ifFcEC2DkXKRHQfl6ocijlO4Qyqe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQF64gvUPpxJkHQSbKLgDHjgNbSEDWx3LQIN/1EgdX5PRk54d03gWe3/5EsCQQOhNy8RnLDclZx/BWFSuZjeArLNNtuO9PWOUhoVQSrqBJnxBPd89Kzi9L2gYzNvup9Nga0bJKE1bmEHpLbk/QsEmxXo/EN4zv4SYsjvFSphLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiCcp1IB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiCcp1IB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416591F0089B;
	Sat,  3 Oct 2026 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791066981;
	bh=O6dz4VdAVwnPNax5I9Wfm9RzDO7CrPpf+R3OMAPxNns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QiCcp1IB5oW3jOKSfe67TDkVEsvXYYeAZdgPx6LjdKMpIxs8i1S9EWn4KhPMey3QM
	 S4KfyjtScbgFYBIpz9MhQAnfzbKFqfCri3UZ8x/zv0xJGkAh5tARPphmUOpJoaLPC7
	 JCNkJQcp/7r2GhgQ0dLGagjXT8GkuCIwvWRDBxAm7ex2N7YN8imt1rHcBbQwqKnsFN
	 K2qU0XjR4Qr7UysIp3b5f7rMVdhN6ed9FB/eSJn9Kd96aeQGKh5v6IMM12Cix4jaTl
	 DFvM3bmE26uUUpKEaiA/W3GzxoVugyZBaWKGm4nyLZMSzp9rkApsexCh8d8CyNDH3Y
	 Ali1mfr0wbPjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 6.1.y] x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client
Date: Sat,  3 Oct 2026 18:32:53 -0400
Message-ID: <2026-10-03-1-daily-reply-0012-re-amd-zen4-vmload-vmsave-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002204737.26561-1-artem@trailofbits.com>
References: <20261002204737.26561-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit a5ca1dc46a6b610dd4627d8b633d6c84f9724ef0 ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha

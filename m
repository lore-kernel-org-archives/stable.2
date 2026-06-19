Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A2331A41;
	Fri, 19 Jun 2026 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842043; cv=none; b=d38TuiqyDZeEZ0Rnru8rrD/T96MWRJofB1nuaYLKJx8QyRXt0ny0Qmv8aAtymSeeQ7vdHLw4Vh0mFH6X3nLrB3EqcTpkjXsSV/QVtcCc3TKMAqMFM49GC0R7Y3SWadslZDfhjbrlKcoF0U24dfYzloPG5My4XAqNfLFQBUQGwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842043; c=relaxed/simple;
	bh=Qq6/scxRH8LN4ENqxLqr50HO3tiN0w3lM9YMfEYvpQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5rKvkFbme1xsW7N3u6yElnIvzNYG2KiAuQC4A79XgwsOcD8CJYFkvLZu8kQofIhCVrq07BOIfmYV/UAayWoBjn49j4DgfwBeqnxk9ktHukjzAcvQPn7h+2i6xBDntMNqNvUJBNfxoGB7d1kF1LNOEaM8ooEEg23UuwUmtxQ26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBwUE5hD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBwUE5hD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457E61F00A3D;
	Fri, 19 Jun 2026 04:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842042;
	bh=rdcTqmfCuKfPjCcRjSCpSo2Uk21zVEBX7IDtO8K5gAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bBwUE5hD6n7mrfLMrLGCt6t6LsbXow8OlBGRygHEIJ0KqEDDQGMqgFWXG9sHk7mVO
	 SxgiVns2luxUDKe0Ydply6g/1fBTyauycv+MtRLXK8Ti1eq1RqeafP3AkGtSrkGN+i
	 SxiUyWYsl0qG2FzXov94YnCxuGYGsvDlP7bawqa+VBygGRfNyBB2tyw+6XY1GxKwED
	 IAwhJZjRcrEprIAFhBdZLfz84Og8I0OFnFgA92ZAx/bn2bxlFRCQ3Ri5o8ArAZnq+O
	 0vJVmq3qlXwV5419W6R+QOqyzPYzIRE8hm2Rg+fygPMnhqGHsvRPs6KldDcn0bsf8Y
	 IrYFh5wRPA7wA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	Uros Bizjak <ubizjak@gmail.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: Re: [PATCH 6.1.y] KVM: VMX: Make vmread_error_trampoline() uncallable from C code
Date: Fri, 19 Jun 2026 00:07:04 -0400
Message-ID: <20260618-reply-item034-kvm-vmx@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617105100.22094-1-hannelotta@gmail.com>
References: <20260617105100.22094-1-hannelotta@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  [PATCH 6.1.y] KVM: VMX: Make vmread_error_trampoline() uncallable from
>  C code

Queued for 6.1, thanks.

--
Thanks,
Sasha

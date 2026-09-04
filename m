Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D63AB26E;
	Fri,  4 Sep 2026 02:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490395; cv=none; b=kZGGeJZwkzTPcXWP1/vEqxWjTohZiOKLuCCak4TqEJSJKguxeRkSylcltg0qkz11mZrsaZU9ISlBixbFHWiktNHWQF+nhMzSBcQAT5APNbob0TnAx19mxuvOAlICFN0/13AxzvoYjwPM0wDMgc3YoYMv7jfjaUxPj/dh8JZ0m48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490395; c=relaxed/simple;
	bh=qZ8I4cSzzrJJAD5gV6jjshV4RlJxgL/lvrDkFHQKxuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhQdS8UnSIXfQCbRdMxBVoYxufxgdaP0VlSFZScBZJMbXzuW/AeSjzOYG41B8O94K6oVdnZwy0KpbjyzVYf/HF6Y3+w6OU3CnX3PiXI1k+XXvLvxbOggDRDaXaltc6psiBSgYx0GM1s8ibtbRzqLY+g5B5KgB2TA+P0l1+WzIrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0+oJDmR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0+oJDmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D56C1F00A3E;
	Fri,  4 Sep 2026 02:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490394;
	bh=YvGc3J9BN54sAfD34/YSE/Xy/I5PpMqtCaWwFNC/Ai8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h0+oJDmRsgmqC9meNvC2JX6K+dz8WJCbk03jwi3lkSDMagpIRQfWU9+3LssidnnL+
	 tUtGEJ1H6GI0cU1fM9F5X3zxDc1PyOjQJ4JXwlxRpyQWmkZTfYdinW6S36eTUA/rKq
	 mLozaUI8dlrIdjiqExUI8K/G8UOxfO3KfdPRy0onraM/6xlQrOwpYg5mayjf19T491
	 VmT+tAkU229LtpKnh9TVZ13RMqoKwBfyXM9MbpkhvqxIUFjLvlNejOXkP6lCTzKFJb
	 O52S/+4tB7548GvpscwwBBNLY0z6T3+/TYSFfMLoMGNhBve90xknGwU5lISdSbB2R3
	 p6TcIlly9Ny4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Gao Shiyuan <gaoshiyuan@baidu.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sean Christopherson <seanjc@google.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6.12.y 0/2] x86/sev: Make SNP usable with KVM=y
Date: Thu,  3 Sep 2026 22:52:51 -0400
Message-ID: <20260903-daily-reply-0002-re-x86-sev-snp-kvm-builtin-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902191321.2644150-1-seanjc@google.com>
References: <20260902191321.2644150-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Tested SEV, SEV-ES, and SEV-SNP, with KVM as modules and fully built-in.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha

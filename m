Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E566356773;
	Fri,  4 Sep 2026 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490407; cv=none; b=CehrCZIiSEe6WsiSqCOCoE98eaU4fjS1I1YQxETXmo78c2lADI5CA4J74ulBgBbfqdMPUy5C+CWFSGYhOX67xpHNrpoxX0r28Gs3nd+rFHzJF5r2ifdiFZZjjLDNSNFlNkACfYVRKiScFX7RLSMqj30fd6xF3T5/hcQ828TE4Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490407; c=relaxed/simple;
	bh=TlWPIgsmJknPpKo+6H4EGkVXqppLfOLF2mXB9w2x9iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MADfCUOCLgWZQDrwOGjzA/JEGX1acJ/PTqTVtItIDytzHxPVEMO0exX/FfjOHsj/dC6eqaf2uE9veHVkeueylDdDsa0Sw8iAwB65Dol2+KBvFIEW18IO5VqAwCQ011fXZg7tH28A4jcajgMgFclQP2UkmHSvPmtyajP6Zbpz9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLvRA7QD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLvRA7QD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346BE1F00A3F;
	Fri,  4 Sep 2026 02:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490406;
	bh=ehKRlA5rLeMNgp3In3fl7Hj3qvBsOtDKuO2QpxbvVss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lLvRA7QDt+bn/MuK37OsAmWONy6UAFNWrK8/67in2YBbibbi0ualU9sN2TD64JVbX
	 xkngDTMS2peUlkE/1MCrK0W52MFBnPmnu/kpzFAJi41bDX9rDbBiy9lvfQsvuR+sLD
	 JBdrFaIdYBx3hg2xebbDhjcFeydeF/9ydDcf/cGv9Osg0FhGuqCwfbcetF5VphSAh+
	 DczvTGeYOJW0x78PZifg9a7SH4aqrwyK8vAaGt2z4bcMYiT1EeUSB/vKchdAfBn4ae
	 XkAIFNiflvHzWMIZv7iuw43vFkZ/yMh3vmivFpcIsCWl4Fz7GB01dfxGLfkGwakIe4
	 BEXcelIsUoMzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 6.12.y] KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA call in SEV-ES migrate test
Date: Thu,  3 Sep 2026 22:52:59 -0400
Message-ID: <20260903-daily-reply-0009-re-kvm-selftest-sev-es-dup-vmsa-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902191950.2647091-1-seanjc@google.com>
References: <20260902191950.2647091-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Drop the explicit KVM_SEV_LAUNCH_UPDATE_VMSA call when creating an
> SEV-ES VM in the SEV migration test, as sev_vm_create() automatically
> updates the VMSA pages for SEV-ES guests.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

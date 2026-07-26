Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEDB37A832;
	Sun, 26 Jul 2026 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101101; cv=none; b=Ni+gLYgjFT0otXOXBnT8CyhFbymqtSbNMupgEjV3jR7hhCVQu30jUlUcILHbusVVsBTF33spNeEiJsvoJJRqdKcnVm1vYVAIOphtz/QM9z4BKgPRNCU+qlyvJIb9JD1KOyZ1kZaeWUwEauTKKHxLreOIsfz3Mbv/fATgA/wuhsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101101; c=relaxed/simple;
	bh=uKK5p3hQoqO46NOc5A4WS4rRYRBf8cigjEBrta9Nz08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrlXxdE5EMK4pVH4s4QKrct4NOqlz2gBUiizDWJSbZLGtehFqkd8bHKzASI6oQjIKEoZvh29Qg5XlEiTLrYq9wZ1EGAaO1stPLVWPgzDKpqsB9Epng3RnhIQAORXzm6W/MXv0Q9/eH3PSRIEispOxdAu0HPt/VL1nMUD1LCy1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM0Gg+/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM0Gg+/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9230C1F00A3E;
	Sun, 26 Jul 2026 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785101100;
	bh=+/PN2yD68zGGQ+oVfUByD3xEtTOeBbg5Znu+AQkp8nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lM0Gg+/10KFIrLYeAijdqiUheywC+gOAyUhT3XsXlcpkBDQVN0etDYevRGB1F8Yhb
	 1wnJIE7DQ9jKgi5I67Iu7Sk271Gfh8gOrTdkXe5Gz21Ugp+WHgjcdiu+hKwuDrMHWo
	 CIWSxbE3/VDHlwYxWyViqgC8P43B9cv202krCe40f+GZ+wA+kN+wRKw+43sA3s4rrB
	 i7qT3gNGh3sCQMyT0WuWmIZicInjdViWTY/xXDgGgNiwoAWuJymsLRZFLzJ+tHP0Sj
	 0Krep9xxEcx6nMEGyaBUITSC9YWC382t8aOJxrVX5x8lhk+AGgF8akTvsIZQqOQx1i
	 /YOuY7gxJSt2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Jim Mattson <jmattson@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vivian Wang <dramforever@live.com>
Subject: Re: [PATCH 5.10.y/5.15.y] KVM: VMX: Make vmread_error_trampoline() uncallable from C code
Date: Sun, 26 Jul 2026 17:24:51 -0400
Message-ID: <20260726195203.stable-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <OSCPR01MB13468557BE10B1EAC08EAF183C6CD2@OSCPR01MB13468.jpnprd01.prod.outlook.com>
References: <OSCPR01MB13468557BE10B1EAC08EAF183C6CD2@OSCPR01MB13468.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Vivian: Adjust context. Remove check for CONFIG_CC_HAS_ASM_GOTO_OUTPUT
>   which does not apply for old kernel. ]

Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha

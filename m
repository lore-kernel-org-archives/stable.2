Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9473A7F66;
	Fri, 26 Jun 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496503; cv=none; b=WHFoUYU6IaKcVWxBEV/Ctyd3Ybc4AjSONKVieFX1cAfbeKdyHIbyMqgaDV/EsT7L3lG83xTKYsmiY7BlvGMa822nADMCypWdZqcKUVEq76amZHxwcv0km1ZkFJxjXNtFQDZO1YgDZKL/W+cF7RQkz7PHQYSjFtuMlN+37Ds4iS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496503; c=relaxed/simple;
	bh=LuJz7qmlTF1YJ2xgiYxnz5Dv/hWesqiDlDVM2K3h6HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvAJ22WqpFaw6/g73z2LYxMjOcHkJPPaIH6IwFuqdeahH+lNbzWF1wnYXkqQItVpahAqUotUE2pQQcQynZw4IKo/0dDaKZEFIAvltf3RGo5dfxiZseDWeqPUlsy5iHP0puNTKB+BOealbgQpz+ayliyA3DJT9rr4CtqUAW81mAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXsICJXM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXsICJXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744951F00A3A;
	Fri, 26 Jun 2026 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496494;
	bh=kCQGmQCiPt8POPSO8VVlYjKlurk3/QBY1u2pmsWTY7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EXsICJXMMFRJOyh2ft348yKY5OlcxsssI2rseOwWYc1CCL2kNtttih/e8/uFl3U9h
	 zk/xfD/T/noozZZFD6CjLmTJWI7yln1etnM70i8E4DR/bDWscPUkVGXPVJUGGpD6uH
	 WpGLKC4pZKkvDJa1mvGiX9u/6vZZXhaUPOcQXHLLvdJ95RKRrvEwXJlKyiK4L5x/T2
	 N/COqrGnXjGsBwaaJ88d266TBEasN3x6pCetQKNe0VOKkc8yIblsj/kHVnJiMRenls
	 1vI5dkddOTpSHrjPtFmMAWF3aICPJ7ESlSokR1YTlu9+2MZcnqapLYHr8eIK/L05xD
	 xn4lbTGdoc9RA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	James Houghton <jthoughton@google.com>,
	Alexander Bulekov <bkov@amazon.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Alexander Graf <graf@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Filippo Sironi <sironi@amazon.de>,
	Ivan Orlov <iorlov@amazon.co.uk>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.12.y] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Fri, 26 Jun 2026 13:54:25 -0400
Message-ID: <stable-reply-item007-hugepage-612-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112405.1777340-2-pbonzini@redhat.com>
References: <20260626112405.1777340-2-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

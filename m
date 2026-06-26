Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA103A7F6E;
	Fri, 26 Jun 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496503; cv=none; b=OLD7akWfC8M0iXMv4SuKlss2lAHeT6EERaGmosl1R77hfBfFlAIOEPyJO7I/Yq/39JDL+/vFG3SimzryrbS2tM9tBuabnp1d+B/Q1CuQ67G3LeWKAd5ukZAvt2Nr1g5yF/a8+t+Pxi3PIJxqIUpuDpeI2K3fp1E43B5YMVxQNN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496503; c=relaxed/simple;
	bh=Jg2TlGtVz0m+rZvTPiVKfKC14M/U4mgFBygVo76eHog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efvo5g4HLhzuaxLlYw/6Oz8UGZx82oUobkmhLkwsrBDjzwoBecqzLxY80GPk1rGJbaEXhnND5nSuYgJRSGZ14XAiFwneikX8yKDoeBXd0HgoysElHauVcPJQSReMsEdzHg3ie9lS/DbKcmaGN+i3OJNAwMQwCb2kjcR6Qu9NqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nln8U2kM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nln8U2kM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ED01F00A3F;
	Fri, 26 Jun 2026 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496496;
	bh=4VIulwJUfa0xQa9hP/IddMMtjm75/S8X5O+aEMj+3zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nln8U2kMFfugG2XE3t1ypfc8V3inpQU5HK1aJlDDcjWJ4XNNaneZFwU/Z5Zm03/a8
	 NJhK9QX5HP2q8cXUnH8ccI0fNWiW8Xdd+n5Im7GcG73PKe6VMF6Xt3mnauJhowv4l/
	 iRAImJQFFxp+icVX3/OO9fA2VRc74lYIuxV6DZFnOHQsKAHTJho5aEmZeD5hMqKwbU
	 zKpSh3ZvcOWis51xL6waTLH8wiNnzpQMSPiwTavBJvfzbYL7Uxx2zhg0G0gud3GOXt
	 xiuU3NYOTaAjdvaLytD8rAmE9SXjrCnLeRvGF1o959RQ1zxLmq9Ri2zKXEOX9I99j7
	 KEAWrETTU2nUQ==
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
Subject: Re: [PATCH 6.6.y] KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level
Date: Fri, 26 Jun 2026 13:54:26 -0400
Message-ID: <stable-reply-item007-hugepage-66-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112425.1777712-2-pbonzini@redhat.com>
References: <20260626112425.1777712-2-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

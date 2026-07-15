Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBBD42BC48
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074374; cv=none; b=YIxtH2lojHIf3KuZnCeU2qfJG7vCvCtmKG4bOjx0JEXbnqALv2HxmroFYJPFOE8f3tbV0JnueqKAJWqrLUm60p5EhCGJYpwVwxScGfrfo3lJ/pJbJPdc1vymFwzIKu1DK6C7BwuPPrGNVIN5fiDXtCZoP2ZLMUWrVTAeCVBWa44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074374; c=relaxed/simple;
	bh=woSGkl4EfmH+Mn4QaXImYEag0X3HLdRamaWMqgbUh3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rN80InFxxN1E55fqIYWQkGSA+VKMEMnXYOfjyzOdD+alRZx7tEogtH/x0X+e079VNS/lWgKxfgaWLLz2WAcosQ+OLSKniF2UQi7SL2ebP3jKhF0CpSWbWgrTzenKEi5Db4bgD+J0vKwsMnmy40T+5fpawAk2NbR777JU/G/2n8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7sKMhkF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7sKMhkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019421F00A3A;
	Wed, 15 Jul 2026 00:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074373;
	bh=ZqNNHN1/7qz1XsKZ+9iXwkMGFx33d2imyxFlSKdRclU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7sKMhkFgqXT4yYtTVQ5hv3xe9I/SQrAp2d/6jpiWbGGzlXl4lEgrBCQ3qTY4XgNO
	 ggpOGi5KbmdpNBFWJgYIDdG8BMVNlmmpUzzClK+5DtHnqdX3PUO4zSaU9knnFausr2
	 drYEgixoROkeKupnHT+6I5gc+ZtYAO0hk+OKSB3x/jLGNAqgJMJJrTdBaKiIyR7z37
	 EqY3cRVe+VCrWNXlqBuI9WFwW4KKLczFV7nz7i66xv+NdZtBdVD660CgtL1fx+B70l
	 6zTjbS9/j8BXQ4QGQYFa9kbOXwOdl+YuckqwmMBV666h/2pzfC+hDY/2v29NOFQcQj
	 YgIr4Nx8am0oA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH 6.12.y] PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining
Date: Tue, 14 Jul 2026 20:12:38 -0400
Message-ID: <20260714200600.stable0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713222549.28006-1-macro@orcam.me.uk>
References: <20260713222549.28006-1-macro@orcam.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Discard Vendor:Device ID matching in the PCIe failed link retraining quirk
> and ignore the link status for the removal of the 2.5GT/s speed clamp,
> whether applied by the quirk itself or the firmware earlier on.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

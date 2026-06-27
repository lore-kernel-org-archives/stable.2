Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8452BEC2E;
	Sat, 27 Jun 2026 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578138; cv=none; b=UXIRh5p8eIcH2YooEmAR9Zvcf8GdJdf7qaaaEbuBY+dfuF1BUNwinTqGz6PG73q/IQQZ0d5MsD4w5PWwYQMmY4dl4Lngk99hfJMo8sLeecAGm2mlzJjyXM29RnpY+lsIPn+QdGX7Tk9e18D7MOIvmdeFoxDTu/LJ8kWwPXgnaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578138; c=relaxed/simple;
	bh=kOWX5T5MM3vuhQ9tOzaxdl18xLGzacWSoSkvEVLl08I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dop+BYOJmo8wzby6YW//D9HRP3WxApY6uftF12VznRtq7t6MdlbxrDx5l7vc5D11Twr/77zEbmmUejf0q8v+QJnOmep0eFzdq8/QvRQPQVCBPsNDTkCMytIvcyZkfE8HVvfNjoqIdm0mUf/edQpdnFmpOEY6VAA1BNOEEUzEmx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLUPRvBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLUPRvBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758481F00A3A;
	Sat, 27 Jun 2026 16:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578137;
	bh=hUj/9j1/bvY+P3doiDH0AIBXoKxdi9IwnN0sGstE66g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eLUPRvBz6N4kryV6ipVlEXbswKFjsltTHHhlir8IvUt5XRaLeP0tt/rfNfTrXstNx
	 mQQ/U9t05ysnc5hJ1Pd3n44IzzmzXrICczVI7SPqb2hNDaX2KO+5/GlV0g84Ka1AR8
	 6mpDAcQ7SnEeuU6VnRJZpP4sPXrqIG4bPMonpNNd/pJ2uVqC3UnPDDWY9Oaib4J0N4
	 kG1cWUxPi4YdiyG10fcT6lwHT/1MqVR0IV/Vwr0MGiw3nlqAjBJVVEtCi72npPTE4f
	 VTOFYd0C4cAB0tZDFIbLaZ+z2na/OA9RSbnwXJyXfGAQOlPCjy69LY/gzm4OTYnMle
	 +lb7j7H4OcMFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related issues
Date: Sat, 27 Jun 2026 12:35:25 -0400
Message-ID: <stable-reply-item009-kvm-515-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626174620.1819772-1-pbonzini@redhat.com>
References: <20260626174620.1819772-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jun 2026 19:46 +0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
> [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related issues
> Please apply this instead of v1, due to a missing line in the last patch.

Queued the v2 series for 5.15.

-- 
Thanks,
Sasha

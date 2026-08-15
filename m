Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33E27AC31
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761211; cv=none; b=GjpJ6JnzXHEEVYrDyTLPijlH3UjJW9Bqxsd0W2YnPYja9EFmHwYN9G1PG5/8JTIhk2eF6DgG5fFbE9vLqwf89YahXiPtVOcoyqCDetbxwzRd0OFRMRPfNW42Rji9CveaxTPpbgY8aDHDtPzMVmvrsWQ1Pv96l9mGD4HfHnsxVRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761211; c=relaxed/simple;
	bh=y5vVjx6gvDdgjOlaZqokF31rHHvk8PlViwH88zA755Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FU82rgHftoUFLmQ8xhczN08Lz7kf7PMvj82DjTaTad31EAA6NBofpJeonX90ZLeLF+Ncds6OF7AWtWLSsS9Xn6F0V81lA6yEsketPokJsQPCKc58eR2yqgvMCWLtS+MqsmODUWq3a4Nb56Fvuv6poxq/3CuCI2hsxRMrTKbwWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlCLr1/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlCLr1/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AAB1F00A3A;
	Sat, 15 Aug 2026 02:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761210;
	bh=zMo5g0oW5L/BYtLrVrZ+XRpd1OrOWIPgD5VJKUsEESc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UlCLr1/qYiDVozWdvV66wbaqHofd6YtRrvePSCwGbmiBo7juevWXmHRQtBJLeW+CF
	 Jl7gPKpifHxyAdYdD2NWzql/NCODVys8zs1Dg/r9MLqtbo4RHHOudKVIszRtUpmX1+
	 h0c7sPwWLlyu26oXtR3loqiVNkk9C2ohsJk2nJhr0Xzzi9/1SRVua/fZ7xG51yEoMB
	 u/15dkEBR6yFvUVi0DW98AxRD0XKk+k77BB4mOTlP3rg4RWtUaFVIIziunpjs4FkjK
	 axn2bivDPPlfpsL3nJPjSwIRpTjphxeU10nyI5C8wMGfWbtI4pzz3JGiRpATvEY15b
	 MnR996pjWpirw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	alifm@linux.ibm.com
Subject: Re: [PATCH v3 stable 6.12 0/4] s390 KVM PCI backports for 6.12
Date: Fri, 14 Aug 2026 22:33:05 -0400
Message-ID: <20260814193000.5@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812204043.2536-1-alifm@linux.ibm.com>
References: <20260812204043.2536-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patchset backports the failed commits to stable-6.12. I have resolved
> the merge conflicts and tested them on s390.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha

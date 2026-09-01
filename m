Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32A19CCF5;
	Tue,  1 Sep 2026 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268605; cv=none; b=QTe1PIBxFBiNBa0LucX95Wa1HjcEcyGYAVlImcQDJskqV7/Q9YcmrzW95DnitvH3wZ5QJdQ071cSSLDrNZxnLTQd88W0NgNOLaIi+yvAopyt7j4qo+YJYYeLlloNzAcgnzVTjzD7PfxgnsN9hva3MiOpmITPm3ZE/S6Vtl/S2+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268605; c=relaxed/simple;
	bh=LEeNU6JQDPcL1HRkJQefcxRUk4bQ6Kiw3T5XfHQM+2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yucf2P0uiZUcMrlBzswpu9L8dM90OTUeqJe0iAhbN1DauZl5XMOxkhGm6bgt57aAQKP26rgxayHiCWc3e6zUGcHaJpDXiqJmdrv91MvcX3MDBAZ+Qrp69Zw/xXqewLl5Hlke2DjXufc6OoQkism9EY8IMSDoXNpQQzu7EUPKrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtTwl+4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtTwl+4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5C51F000E9;
	Tue,  1 Sep 2026 13:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268604;
	bh=q5EmtEOOlMI9psXa+ZJ0NAX7+WGqzKLkS6oODj7p3dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PtTwl+4Le/oUwNPL2xjteGiti4F1x1HHc9wwCGXpgWjTVrjtGPRsTuXMQvnXjWmGW
	 u9h8WS4PcME11LPib67j57Q/872pr3OoI5lEGFsp73QIxGL0eMDCbx166NRlPApGdF
	 fnbp2Tdsswjae7UNXTU0jBZymTa4CtxD159TD2Vo8sbVLiQU6/K/m6BxK3OBW1NIRr
	 SL04j1yUAV2uKJN5iapJegu6xFsXH+CHOnGaSJ6TvHRoIL5VUH613YHxLYbapx+JpJ
	 E99tuL7mwb3b2yx7d6EJ3S9dlJH7Q75JLID22oQHkMBhdrn7mp0BQxPaPW8XoZS2ix
	 4DATqmrQz5xkA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>,
	Yueyang Pan <pyyjason@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] damos_apply_scheme() splits a region and apply the action to the
Date: Tue,  1 Sep 2026 06:16:36 -0700
Message-ID: <20260901131637.97711-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901131326.97615-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I sent this series by a mistake.  This has wrong cover letter.  I will resent.
Sorry for the noise.


Thanks,
SJ

[...]

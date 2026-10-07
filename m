Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B973D333B;
	Wed,  7 Oct 2026 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407063; cv=none; b=s/bs5THIzneC+5oPc+EwbxTJr3QgwaUBMU/d9E0EprZGcGfYVCSxgzmcnwJQ4j7X7eLAfwlCsYe7OQqwgTyLuVCcPrSlJuL9cXLEYO66Czf9H7czqEc7UDwzKvXoo2z67b/hmuZ/zmzSRpqPOL0YzM2TQU9Piu4oMDmWHfpyPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407063; c=relaxed/simple;
	bh=z0awGquHq2rndJIKfwXfEWocwd+diss0vLVYEtFASvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2d6FNabriRE0B5NpyzXzPI1G+ErbuVrbN9skQ2wblB8Tq8zagdOhU+asdZgDyAmgTI1OTxcthEHBzuVCRaVrgJiPH8JsXWHOT2QKFVGcWs2dkTnqABz+m2gaabpRsncrdnH+C1ROBnsy6tI+lv/T2mw8kpCVoc6YpX617CUQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2eqAqV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2eqAqV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3981F000FF;
	Wed,  7 Oct 2026 21:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407062;
	bh=ivSMrdcusqcWE1vxpm77GBODZKS6Cnp32OVSJIGDwgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G2eqAqV3pxzwqxwnsqQlkSh4J6Xo8DlrmVuB43jF/KOsHeqayx3EEtazBBBWbfNTA
	 INauVJI/ZQMUNTlBeJHS4PkV33ibsCDI5Antj3b2vcgX72+5Jo15ZvCPBdyL4CbkhY
	 Knm//2LvLGcfXt0/5UpZ42MC+s1Dfs1Vz/FOSg0QTfsrwUEq1eFDODQa4Gj8WUMvAS
	 PJB3ZARxyyvLMmH6d7/lM1US6SAnf5HYKew+MNJLo/84lAwLT63AtsYcl0KrIpP40q
	 JsWQM3vU7ajY8xOBmgn160W1Zd9/5X/tGXc0yqkGxhpAbdXJHzqsuidb42EMz/esm+
	 XmJKGKFJlAXZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 5.15] fsverity: add dependency on 64K or smaller pages
Date: Wed,  7 Oct 2026 17:03:38 -0400
Message-ID: <2026-10-07-1-daily-reply-0021-fsverity-64k-pages-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006215801.58604-1-ebiggers@kernel.org>
References: <20261006215801.58604-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> For now, just disable support for FS_VERITY in these odd configurations
> to ensure it isn't used in cases where it would have incorrect behavior.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha

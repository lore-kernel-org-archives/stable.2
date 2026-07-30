Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9D837F8D7
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379245; cv=none; b=DDP66Z0hHKNSYIu0oPGHR8WuC/ZDDvPsjZ9nR2ptrf7PbLtiycBefAFmnUmmU0Fmpl9tIFFvj45fZNL6Bzrb2A2zQ+QDvN3Vm5X4P3oTN2+0N67CVPVvNFA5qjw+tY3Er7vxe5y+LSv8BFRN/rIiLSRjTOF9trh71s1Vu4/DiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379245; c=relaxed/simple;
	bh=YoSDJLdJh751OUnbUtbKRxMcqJ2dglbKKUyOlp9625Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiBperKST0wLwvcKHK8PFYJ6VzZ7Wn5WH7DGslePT7RUZZDyBwbkTjgIQvnILol+PCEwYCknHvMNYj7McbDImyB+lnU02xkfB2gLtbyIPKhxVywMoEwF/rpPrtxkiO+P37ME7+14kcTCnD3K59NPOSox3kMEkvz/rvQNe79P33o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWHnkSYA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWHnkSYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CF21F000E9;
	Thu, 30 Jul 2026 02:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379244;
	bh=skL+n3uGBffHEE/C/qezlZB3zHIiQ9cfNzYiBSb8QVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KWHnkSYAu9+tnO5Rn56EcfJj83wqdEgEcd07ipzJBpXKZMmmiTDkv4u7gO94+r3HV
	 +0cCh5siY7IA3tRuIwoDIBOQNUXOXzCK75BepPdZna1KaItZizhfe360s14LwRCJUn
	 vTIHhSfDv6XovrghoPQYF3YtIKWD7LsCo2zSX2AMUa8TF3jnhP/n1Z976PlOX8IxZb
	 +c6EiY4kwmFRCAvVaPHOaG6Fhz2WxFEPz/or+Ql98kXqXAk/wns9j9lQbvRHw8frz/
	 tDYCnAmTYhWAi8uw2CBtWnVxt/gadfwndEoRq5pLwAHIW+As4YS8IvYfDZ4DrqVMeO
	 mWPlMLO2f4AhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH 6.18.y] net: qrtr: ns: Raise node count limit to 512
Date: Wed, 29 Jul 2026 22:40:09 -0400
Message-ID: <20260729223316.stable-0013@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729150211.3884880-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260729150211.3884880-1-youssef.abdulrahman@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.18.y] net: qrtr: ns: Raise node count limit to 512

Queued for 6.18, 6.12 and 6.6, thanks.

I'm holding the 6.1, 5.15 and 5.10 versions for now - I replied separately
on the 6.1 patch with the details.

-- 
Thanks,
Sasha

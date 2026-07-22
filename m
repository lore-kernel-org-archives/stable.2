Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BD33630BA
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681653; cv=none; b=Nx1lTnR4iEfRWCBI09Spb3BTcaAwzWhzSe94dMuZ8Jd9wAfE7rmfwHT+3MyPIrAsaBHFXXSnUiqTDsO/lwbb6WLANygrKOW8fD2ZjeKGLSH7y/T97KDnt4MMkc3g17R6MYjQRPd6/jFWDtiaQwAwyq1OOba0tS7sF6CwaHrtTAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681653; c=relaxed/simple;
	bh=qZRFpGmJF8slJVbLGzrGwp68H+5L6Xw1U7FsE3F9mHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdV+7MPbd15u+3Rzv5zFhwnBqbDmfnO4kHEKTY+fo49Q9+E+o0VBD/xoYlItEMOtl+mzSiKZeH6cgqjPdc/LsXDhfDhge0RLnMYE4kArGhxo7GeJmdxIyhZTKOBGWzmr5PDvs2z0b1+nJIjlC74atJDd4ecfqq35rimH/ZKxV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDa7oMaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDa7oMaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0611F000E9;
	Wed, 22 Jul 2026 00:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681651;
	bh=GtOlK403kDgxwDejO0rtWjGT0UJKy5OVu5W0Rx6SV6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RDa7oMaES/wDUjF+RuhYgJ/+6VkOJvOWP0as/sZZ/g88jSiCy1xe92oN/cXvKH2kU
	 A2U5jvbkGueYfmMHOOU1gvd5+117xGZ+L4tz3sFaQ5qwIWIGro0Y96O98xBCvh/rrm
	 WlFpwxImGTbhlVu86sby3kbhSj5IwKFH3nTfWkTBRJFX6YtBMPh/RLZt3EbewXaq1e
	 wCF/idwB8dLDM8NSCyoKKjjLUuaCODMST5qs4FNLPEwF2R+LUt9z1edv4THLz4DZPG
	 G+TOZGlSbQFWAktXAP081SXvfV27eiOUbIbmUFcgnQAlACde8HA6hX986zsZmp1XC7
	 Itb8sCbLpBgXw==
From: Sasha Levin <sashal@kernel.org>
To: win847@gmail.com,
	joe@dama.to,
	kuba@kernel.org,
	lorenzo@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: FAILED: patch "[PATCH] net: airoha: Fix skb->priority underflow in" failed to apply to 6.12-stable tree
Date: Tue, 21 Jul 2026 20:53:57 -0400
Message-ID: <20260721201114.0010-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072154-partly-effective-6632@gregkh>
References: <2026072154-partly-effective-6632@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Queued for 6.12 (the driver still lives under ethernet/mediatek there,
so only the path needed adjusting), thanks.

-- 
Thanks,
Sasha

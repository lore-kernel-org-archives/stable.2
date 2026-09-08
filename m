Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583272F7F15;
	Tue,  8 Sep 2026 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907178; cv=none; b=F8jrwPLxmGx2aSuA+cot4ISBPr48Ii+PmyLS2vE/Lk/5XnWXWMg1en5Fo6sWvdlXMxTqsoFGM+YpCsirBzvRHo+8OStM2zZU6amc8P/0dlblWnVKCt8fuqdeX1nWEjQfHt3r4lFBbcRoiHGQJ5edXNC/GQg5pGzGCuH/gwUaswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907178; c=relaxed/simple;
	bh=7efqSBazc38m7zcxk4sBpwQBLIZ4YW0tI7AwmdS5wT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEiITjF14zDV4Y12GWtOQlLALILCiY+eD5v3pYxFsVvrqiC8CZatszhj/hpMY24DB7cKvCB0pZqzfU8astrM/KdYzjLjkU08+wNDKztE9CjHqR3N0vNJAToB1dGYl8WYn0hDEL36fHZZ00WHsTLVq0njyGLVsBN95MRXZpGQl9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCwJW7Wu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCwJW7Wu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E4F1F00A3E;
	Tue,  8 Sep 2026 22:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907166;
	bh=dFSP7T7Ib97/Gf2BrcwZAaE9QRfSr75vr7lwPQvOJcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WCwJW7WuvsJXE7PluM4C8dim856+k9MZ6Hg+pJ+cUwdpBwrIu1dJzCsBZecz+/gHC
	 IcFjNeR/pZzR0zdY2QoVvi0a+ge6G5SVrEGgUTuqP64HbfW6y+JZkeMdotm8Bx9AxJ
	 APj/IpMR18PlnDTinIAZdDJY3LeFMjeYHehwMDJVECQ+qsO4Nsgj/uqm4aHAOi7wtt
	 pXL1IIrHQb1L9Q6Uje/3LLKS44G7CuKOsiLFNk8eDXGoWfRpnVs/f8FoER47bqlz6B
	 T0hfZPInQOfxN5Z0Lb3LUR0oT4ryySiuVmMHdy7057drJaMysqwOEXY+iCcJCC6Ygl
	 VRhbNiPeAmZUw==
From: Sasha Levin <sashal@kernel.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?HE=20WEI=EF=BC=88=E3=82=AE=E3=82=AB=E3=82=AF=EF=BC=89?= <skyexpoc@gmail.com>
Subject: Re: [PATCH v2] fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()
Date: Tue,  8 Sep 2026 18:39:13 -0400
Message-ID: <2026-09-08-daily-reply-0006-ntfs3-oob-write-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOC0qyKG=RG=7Nf0OpTYLQ5QZLhjNUMd2=YGQc4+S_SCoRBbcQ@mail.gmail.com>
References: <CAOC0qyKG=RG=7Nf0OpTYLQ5QZLhjNUMd2=YGQc4+S_SCoRBbcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Thanks for clarifying. Since the upstream commit did not carry the
> stable tag, could the stable team please consider backporting commit
> 7c4841e2a627 to the applicable supported stable trees? This fixes an
> attacker-controlled on-disk slab-out-of-bounds write. My v2 carried
> Cc: stable@vger.kernel.org, but the functionally identical v1 was the
> version merged upstream.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

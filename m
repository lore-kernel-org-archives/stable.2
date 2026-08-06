Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878546EC8B
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016207; cv=none; b=kD9r0l1uQuw+v+f5w32ZKjJ8OA6EoK/HbyuDqcV+Bglj7fQJNf2lv1d0yrRggsvfuSUv8am2RE3B3p1EjFI+uO7HtaK+YVUFP61tQ35qn0biuFWFS3X5Bw/dJw0FMGwYna1tPB+f7aj7BPVniWX4MuCXBhu54k8YqtYoy7zKLGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016207; c=relaxed/simple;
	bh=yR+/7yAGXqgUCtWIaBouUt5hUfjFvwhzOlnYvuvP/4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzZIg4FfH0RVN9kle0r1fks4T1W27UUXQIi6yGm9gk6o2czbBwLc7v7OKbpPfECW1wsxggZveHGmRmVIKEb0YyN9vLz0UoOQ5Iii9nAGqGD5LgZPVMdGBj1yDFgSSZvOamb3MSgp9VtdYIUIfk7WjgaGgeRPBMnyskXMDCXjwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNP+Pf3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNP+Pf3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED35D1F000E9;
	Thu,  6 Aug 2026 11:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016201;
	bh=KVadu0BtIMWtIre5calukpCIzOpYbejNQsFw9QOLEnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XNP+Pf3vFyZsY4gFYVC2aSLlSjkOZcpbOuQiGb6dwpFIqO7wfyUgwSHjFE9WI+Yhp
	 K91FH2ppgx9exhguhv1u/kACm1OSoqsSFm42swxK0S9IsLGQgcCFH7zlWDvJVC+1Sq
	 rzunWoJbuVpA6W2fBmHH9IYbTD2a7lgRRx3QVKiLvk/+hzt4UtNXAbhGR60/m3po7q
	 /kU/97G8z5Jf2k2qESiNq9//VBZfdDml8tWFYq9gZJySdHmREdxUe6qSTmI8r0jmIu
	 LinapvEtLNhyZcHmyi7zh+gqimRUXRpouerCyCswd13g5GYJksHXBxdg48OSUk1dNR
	 gYXnqOPwDblgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Leo Li <sunpeng.li@amd.com>,
	David Weber <weber.aulendorf@gmail.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 7.1.y] drm/amd/display: Exit idle optimizations before programming
Date: Thu,  6 Aug 2026 07:36:12 -0400
Message-ID: <20260806021809.0021-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805163314.214623-1-sunpeng.li@amd.com>
References: <20260805163314.214623-1-sunpeng.li@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This doesn't apply cleanly to 7.1?

-- 
Thanks,
Sasha

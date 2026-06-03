Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5343B6350
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499683; cv=none; b=jnUNuYEqreQ/hsvk80YrlBG44yeieAeeejFFdOirGRFdru9MSdw8LofixriTaLt5MBQfKKfyv1sdBE8aSoV6zMJZeFYgAbS/agnCEcmr5+Bk8w1qFB8OFSscOXk39tVWyeYQQ8cu77Mla2yb7jLFSeVNugFxSgLheEzeK1m9p3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499683; c=relaxed/simple;
	bh=Ezkm9ZFBBVj0vhjm1nG9S2DHF83wuqcJfconYjhLc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9tVzar/hyMPYOfML+aqyNalKpgqgeRHCcqWQ5gR72kFrbVgb2QT9q1DO1U65ydoS0tzliebUjSCqqizDkeR2vj0TZR0b1l3yVTEAlGbHHABFFk5M0wX1LATf9clVtBdQYagrn2mAi2HQjP8yK4mC36GyRM7Mu5Wa9+92M638bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Moec8r/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Moec8r/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E511F0089A;
	Wed,  3 Jun 2026 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499682;
	bh=WYJwWG4x16zLRsI59FJuAW/F/qyAzcv4cTVACN48lso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Moec8r/lEi3IR+ji89e7ZXL1X3onTB1eONpEHev7p0EclOh06NI5Z/0vaLZilarsJ
	 I0C3FVBmOSGSNw/WyaHH57aK7vCm7CGU/fCwWssQ6CIcrQFyNPrg9Kz5oK6rNvk5Qk
	 J+XNw0w9sWG6s0E3v5HHBLyVFxOtbhO38Sq1YycE6t3xTqgz93/NjUbdDnirdXFOXO
	 fk6ib7oiwXErjsD8cl+NubIdWaPUFVGNvUWT4OSDXx+bi5YXYKjPRB9sQD5ETUaXNN
	 acnLr5JI1i0mCzlJRwt+MuB72zmUCBpJ+xZyQj0eXoiPGyXhh0tUOeNCgz4Em6peQE
	 EfJ4/0SOfdQ9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>
Subject: Re: [PATCH 6.12.y] batman-adv: tvlv: reject oversized TVLV packets
Date: Wed,  3 Jun 2026 11:14:07 -0400
Message-ID: <20260603111500.item017@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529180804.414401-1-sven@narfation.org>
References: <20260529180804.414401-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y, 6.12.y, 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha

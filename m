Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5746026F28D;
	Tue,  9 Jun 2026 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966332; cv=none; b=OwCWyA6y0zUk57CH4rLlCbNCnP+UpELE/PXfqGUTagNbBuvgzv06vlBZ5lKMPqljRN4GIff3/sU8/vKWXiFDRBZ2jhK3OX7XtMP4/KWNGyaceN4IiPpSVlTaA42m1GOyHwxkuxbDq/VLthZ1EF/bbNcavNiRE699R3e8C87kF+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966332; c=relaxed/simple;
	bh=jUJHKdlItZlaQAfQ+r+MRLBGNB0vpvVN4DN0OgTVrUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRTQ9623DEPk9e24OkhVMf+9AFDvD472p/HVMSNJYYVYv/c3Fm5qa0osJdmOx3m8Ik6DpOrPxCv0e8JboUJZk03hOFN/hV9eIXeF5DmNDMaKlC4IpEL2rgbGLyhiIsCNZwgsw8UPv9ccecMAAJS74DAvX/nOpm4vk1HHxB6Gb3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfK0iNrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfK0iNrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208831F0089B;
	Tue,  9 Jun 2026 00:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966331;
	bh=jUJHKdlItZlaQAfQ+r+MRLBGNB0vpvVN4DN0OgTVrUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IfK0iNrwOE5jJKovA1vj1sxtcqIr4liLlb0b8OgUUjTH9LXf7/eEoyyLciJUcn5nE
	 PBIPxhIycQbu+y5muvbMl/VmlOt4KQi3PUnffKR3Jn2E9l0M1NTfcoF2Y02Kt3Ohom
	 TBfFQReAbqf9VhSKWm9us9XFhxNHbDreZFfGGQvz8Dkjoo5O+vsZVtPUZkD0ryCXQB
	 OeTlR29YFzuntLFFFevGFc07F4c5/LlT9QJgiA+l1USixbI8p4IkY6t/o6tt/BoYho
	 YIignphwkcfrnz5lfwgyDep4wPMh8sWYsEkyyHSAdIHSTnFrqYUMGiVv+h3a8qKVKZ
	 TepzFuIkWnxMw==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: Re: [PATCH 6.1.y] dmaengine: idxd: Fix not releasing workqueue on .release()
Date: Mon,  8 Jun 2026 20:51:50 -0400
Message-ID: <20260608-stable-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608095510.97742-1-jetlan9@163.com>
References: <20260608095510.97742-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.1.y] dmaengine: idxd: Fix not releasing workqueue on .release()

Queued for 6.1, thanks.

--
Thanks,
Sasha

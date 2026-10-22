Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634646;
	b=tkeBG1WQghNjEAJKSTOZDgJbrQ/G3dS3VfnT2m14D7/RfzhDILJyyCJTG1bUrZCceyd7
	 jcIb0mG/ihVqCm7m0MlKqm3yvUrInG3n6cirPlBsFoUQDQNp/lXsKp/Iwb0dgOPspheCN
	 FAf3mn1WR0ET0s2imOY53MS3pj/zhPiX7XrJe+zfKgES6JfEsr/XueyEhDhY+74ctdYna
	 2pEQgiAUAvm8hMrwrJVdlWg+kD06/YNvZFz2VcUctlkggUs7N7oBIEmzBv8OJ+j1erDkF
	 khr4DWxrcnQG9NLSe7WRjjuA3Q5CkpMtOflUKSMiGXu78iIQyqYHY7lyi5sssiDAFOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634646;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uUBgXk4jqBccfsC7JmIUEYoS4BLLqojxubZtp+zoEkY=;
	b=ZCtaNhfYEjaaOwWmKusrfui0hYrKcDsMhVVqj0+VcP+Kh+G6au+4+YBeqN2D+eYlso+D
	 5S+UBNkcMpkCe92HOEV6IuLCHbvLxRtyU93G5gUg5TSfo6bUcnB5Xv8dsw/J1Kusw65jD
	 0CmY0dekYpQYfhix2b/5Ztd+naX2XWwcq72I+5kQce6u/cNZQryfvb390ZEgeRGe8dPVS
	 ox53HMR1BzV32FXUL4FIf0o6a8VwQ+fZTmAYQ3WzeXFuGwKvtmc9sDTdbANZU+sjbja4R
	 h3tn78i96l9ON2Igtn7VTlLopTVQFl2feydCxzG0lQligKhh5YOMG5pPZPRaaG21GoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdUKWlJ8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A2606A329
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdUKWlJ8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023A81F000C6;
	Thu, 22 Oct 2026 02:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634646;
	bh=uUBgXk4jqBccfsC7JmIUEYoS4BLLqojxubZtp+zoEkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jdUKWlJ8mZpRcC7i8AkvZHhBhmkQ4epFgJy9B/IMpK28md9dVSOcot5fOtWw3iqa4
	 52HguOJBIqt+EeGyUpUCHNMHqobqMQqxquSf4MThnn9zLCj5rubUmg7FuV45zWpq3c
	 y3XaxW/+K0r48uoCyuEPE4o/xbYpOkE+UDvcsxk2ePXo32c8ANIK0lpcwSB3NazerO
	 27b4gMU1OkvT7/QNDL8d2/Kwxc5EFB9Q5QJMySH4pxMWFVYFk95TFD7pS9rKzEV1C5
	 GAN1y1LduaZwEniQRKKV9nQoycF+OgygxoAOyDvviKM3Lc96zmuY8XaDlYfY/jl3EC
	 XFDk6nZ/Cx15Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linuxkernel+co@alexs.space
Subject: Re: Request: backport 2ee9836545e6 ("drm/amdgpu: Fix VCE 3 ring align_mask") to 6.18.y and 7.2.y
Date: Wed, 21 Oct 2026 22:03:33 -0400
Message-ID: <2026-10-21-1-daily-reply-0008-vce3-ring-align-mask@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <18e055c816c88bcf-14970a90@a-workstation>
References: <18e055c816c88bcf-14970a90@a-workstation>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider 2ee9836545e6 ("drm/amdgpu: Fix VCE 3 ring align_mask") for 6.18.y and 7.2.y.

Queued for 7.2, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks. The older
trees have the same bug.

-- 
Thanks,
Sasha

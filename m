Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055365;
	b=vEsiIAojp7adPVd6HhqdsOGbFFhAkKuL8tiCcjpfw0JeELOfJSOwviNtQhgzzIZaUMCr
	 4VAFqDgdvysgnhmZEjozSo2L39oskCwHLs84R+MT82VJuavg9VrOvJpU+nTQsnR16Jhyq
	 CpFuxdiEPw41Sl4DHxTiQCl8+cX9qFYQZbLdNe0qqHH8XOjQGhiC0CHOS3ldoQkmt9rp8
	 3d0yf2/PExLejsBQHryefcLN4wkQ+Hs2w8Xi7ueK6sfofxmZiPIatbC1qTrnL2La0rjCT
	 FzriKxWuNuKIIui5l14gX7fkZzfglf9eNt/Yys5+cyGLbQV5ADnJ/3/jnYCSPa7eKFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055365;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yGgehokgBc2F/RaJ+hNQuK2OK/0vAQhJK7E1qy+O4vA=;
	b=Xlvg71KXXuYuvJIW3iXJPXCc6IpwD/7gipISSrbHvX5Z3r4gYkXWH1MxUPOmKC+LI0Hi
	 a8vkq1V7bCYdJJZVeMqPEthA3vZDWfLNmNuhdyeXkkaLnKDQZWnLAhStpZX11yx05OYMz
	 JeseAPBnFhEd9IxdtHNBeSDL8GYf8Hs4SRM6ncsCkNSvW+hF0IGJRWZT3YBQSTSpBswhx
	 zwTUsNZlNf9f/cnkTuzmET3JYVdF6psUfKjqkc1iOkfQpaoRZQHL622q7sFlsmb73fQQq
	 de/j5dz9Pl8D++29JOtkL9YOWscuHFQHo8Dt1kHGWIdLrrQfWPtyxATxNOvVZnU1n6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Up7HkJAi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A396606A31A;
	Mon, 26 Oct 2026 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Up7HkJAi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0254F1F01825;
	Mon, 26 Oct 2026 22:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055364;
	bh=yGgehokgBc2F/RaJ+hNQuK2OK/0vAQhJK7E1qy+O4vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Up7HkJAi8B9N5VFVRj/Criek5nK53w4fPLNTR9yT1AkiEaKaHmKperkAbTC3Zh7G2
	 eSN1O4JPelHLQW1eXcaYTmNgxZ7YJeANdjtoF4drLV00I1opMlP0Toe1r163FRqok7
	 +PJqTPHxqtqGH/FdTa9O3xDuK9iXQ8geGPj9XkCAVwt+pakUS8M2ItSQrJK/GyzL4d
	 x8xkTPU1g665l/fI7wvQo1ELq9KNe1P8mYcqUUBF2vy/MKJKTObh4/zGOQBRil2DYi
	 x4NPBbZl0Gxs6KLUp0l9ENjiOJJyOVema7VYWqToT6nu2lKTk+oBqUwot5CL23W3Aj
	 xLIkjkli6SGFA==
From: Sasha Levin <sashal@kernel.org>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: Tinyconfig build failures in v6.6.y and v6.12.y due to "srcu: Use irq_work to start GP in tiny SRCU"
Date: Mon, 26 Oct 2026 18:55:52 -0400
Message-ID: <2026-10-26-1-daily-reply-0001-srcu-tiny-irq-work-revert@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <49da816c-8082-46f1-bb12-f0d6187bb06a@roeck-us.net>
References: <49da816c-8082-46f1-bb12-f0d6187bb06a@roeck-us.net>
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

> Bisect points to commit 58dd6e92725f ("srcu: Use irq_work to start GP in tiny SRCU")
> in v6.12.y. Reverting this commit fixes the problem.

Queued the revert for 6.12 and 6.6, thanks.

> Adding "select IRQ_WORK" to "config TINY_SRCU" also fixes the build
> problem, but I don't know if that is an acceptable / desirable solution.
> If so, it should probably be added to the mainline kernel since the code
> only builds there accidentally.

That one is for Joel and the RCU maintainers to take up in mainline.

-- 
Thanks,
Sasha

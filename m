Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795140557;
	b=gAWvJqGwdvAjYbX88wPeQQsQJYNcRqE+buxJP4Csg5BWqQyy9IC+/nv37w1YkB/dH0JW
	 FHIGvAVTzp1A38zgINJnnuoBuSmAp2NYtJc9gpjTST28lkpOe1+vRs8EpzLR/X8UhYgre
	 +00L7aYufr61bjdnuv/a/JyINrUSWG4Q8KTCm64hfX3DOVqemsnsv+krM6blIgxFbUMnM
	 fgjsQc4GWQB+a2KMPF08+MSz0wZHW9J8mnWZqfZpgIIc04YoTz0Mzr6VMrsxr4PbLQJ0t
	 FroTpYCFd5wlAoYSGlxypqR5m/a/CetPdWdZYK+hGF3r5eWk2zwcOD9RhZoIb+1RHtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795140557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=K6fI0HFsjt/fJO48dPLjvhkuysqoszcjucMuUDNU0jM=;
	b=2wVMPbMS9RRurKArplof8LvUNv3R0IMPOLayrZmhR0dNPnPLG7YUshGK1PC5Ti/iT0Jx
	 PldUJqDBxHrhhKU688HbgZ22VYzFSRJ9e7bhJ6JyTs3WFbP6j6yEBxwRRyF+g0qRFvVqn
	 FPqDrEC3riK1JFEYoAhDhB1fhGYjaGznWUVNvih8Ku5brKYUnq9w0gLzsNfBV2V8A0FdO
	 JvO1yncuvSONOQvl1p15+B73z66rhuqeeC7PXwNXWOJPS9KNvlHZ9QrQ4reW22yP8YxVm
	 wwLolMcAltVA2hS7+RdXm7rsabYmV+USgxOeoMiNhmPa/KVdyNuUpMgBeIzlnsNiwZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jjjk0NxH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEE60A260D
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jjjk0NxH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4941F000E6;
	Fri, 20 Nov 2026 02:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795140557;
	bh=K6fI0HFsjt/fJO48dPLjvhkuysqoszcjucMuUDNU0jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jjjk0NxHKvkhrbHpJMM7zrN4+4VbIzn8trytZNUUKncRQ5qLmU6aMtpUBsHhO9wL3
	 vSM4djWQU611qBihppFyQrX1gXiFthNYl6XNtGQm9pvZaR5Z8XxsvzJoAiKwCgcUMi
	 u0fxcFlO6iD/+GNwf8+oW5AGrjNoXiPTVyfrJkjG5QPHAyvNdsS6neG2ETEla6H8qr
	 Uwi/e130JhsjHA79zqlDplibZEamYYgIZU9ZiRnwOd5/dREZZvQHQwrUrbzHWHEdUQ
	 9vrN4DvOSCR2ehJK6CJLGGTjpQ6X7iNBo4gD6O2kPrRLwfV2tscdGKAEfCTkwv8Mwq
	 r1tMv1hEqh2Iw==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: =?UTF-8?q?Re=3A=20=5BREGRESSION=5D=20stable-rc/linux-6=2E1=2Ey=3A=20=28build=29too=20few=20arguments=20to=20function=20=E2=80=98pm=5Fruntime=5Fget=5Fif=5Factive=E2=80=99=3B=20expected=20=2E=2E=2E?=
Date: Thu, 19 Nov 2026 21:09:01 -0500
Message-ID: <20261120020908.2320910-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179500675212.301701.8262514497119491246@kernelci.org>
References: <179500675212.301701.8262514497119491246@kernelci.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 12:59:12PM -0000, KernelCI bot wrote:
> New build issue found on stable-rc/linux-6.1.y:

Update to my earlier reply: the whole queued ste_dma40 series is now dropped
from the 6.1, 5.15 and 5.10 queues, not only 12787e3f2f93 and c96e9f056095.
Another queued patch needs an sram phandle that the DTS in those trees lacks,
so the driver would not probe.

-- 
Thanks,
Sasha

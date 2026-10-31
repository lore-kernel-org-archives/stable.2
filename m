Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793469540;
	b=QOZb72MH9s625V5Sr7uVWRFKGQFyUpm4+W5jn4DpLJBpvBBWSx4Mdj3nZWbFMUZ6W3GU
	 Qn40f+9SChElQ3bsZh19YKAkItqRRqqypbq8LFiDx5DODFmBu7mdgi6Pnsr5CqSlgrZW8
	 jUvVeNCmIZROwob0ihoZQxlmsqe+QcOtwLFNl6RBvRG3YsvO5XeDti6WLXuMayLUdldoN
	 eOYQSkVqyzqYCssv4r/elDuAeIbBLhBnTaODtQ+rfX3Q2vUmqWeirRYw7sJYgCQQVjH6D
	 wIViW7zAdwCyA9TV9s39vm8wT7t4S8lTgy09uxkcrzcXe9KKTkTOEh6IrgO6gszUrXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469540;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=duyv8Sutdvg+rGz3akY7FRwlN6U6aS53AE9YlniCfHc=;
	b=VNokpdmXTWxwHdMrP8HrUgsxC+n1hNETnvH4ASUBlecaF3JEs/pWZM7EgC2cmXGMiI9P
	 W99Xb1aKyOQU1Trl/fn5pBqa/vhYQNA5T2TEOQy2fT9PiPbFMBIVlTVX0SbOV2sORHfoO
	 BycTDLU3a1c0L8dMhebBGD2QoCOMPVOp17TP2T5OknNDw30lYXiwzxmdsCKj2mefnQpJD
	 pw12vpOuotpA+4l3hdf4/YNFHe0I62GElW5s4ujweodAQoUBVIhALFUN+NkZmUku5F0q7
	 ZwPNBxmqxAVfEjUwh0ntreDLyDcWL2831lgEi28nK70XMXpG1ebzRVtRGe3AmtSytqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LktRnM+p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99572606A31A;
	Sat, 31 Oct 2026 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LktRnM+p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBEA1F000C1;
	Sat, 31 Oct 2026 17:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793469540;
	bh=duyv8Sutdvg+rGz3akY7FRwlN6U6aS53AE9YlniCfHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LktRnM+p4xNrGRITRLY4MnIPvUoWB8cKF0ujgqvy03/fX2KSbrRkeRMaW0arXz51P
	 rfYrTpwqUrkcwAzElVwsbjFY6Qencafac3VFq6LBv+5ZaGYBgVNI2NxBMkj7Uku31c
	 rCB7KyIZ1tTlc1u1XIA2yP5yleaO6Rdklty8obFhzJFQqdk5K/LEgWG5heEBxlGsFm
	 hY4owkaCQ7m0XO2uLgZk3FP/YisR8qBeEd1EoCSSiecEo8mSCBjcnUhSGuECHmt+Eb
	 QhwJeB9FiSHxzDDuraFoqsUqYPAdMSGIk/oZrVYtSBgoVcKd2Ul1KPHMFbvAaNm1/a
	 FBQ8VZmT1jZlg==
From: William Breathitt Gray <wbg@kernel.org>
To: Danish Khateeb <danishkhateeb03@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] counter: Allow 32-bit tasks to use the character device
Date: Sat, 31 Oct 2026 13:58:53 -0400
Message-ID: <179346935344.3644513.5332123688446379060.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260929012138.71156-1-danishkhateeb03@gmail.com>
References: <20260929012138.71156-1-danishkhateeb03@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=wbg@kernel.org; h=from:subject:message-id; bh=dbz6K91z64D9tAHpYIL2VehUYeuc4wn8WEQhLXgb2QU=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFnPdBzbZya4a2bunM/n9WXWbKaHMeJfFKTST7qYPNA9c bpz8YdJHaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBEWh0Z/krOMWDa9dhBX66F 859vToFvtoTAjuevXyyfvzFp3tRgFTlGhiZXK1bJN09P3FsZz15QwvMvIPgKZ9UFSZtFjhtcc6Z ZcQIA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 28 Sep 2026 20:21:38 -0500, Danish Khateeb wrote:
> counter_fops has no .compat_ioctl, so COUNTER_ADD_WATCH_IOCTL,
> COUNTER_ENABLE_EVENTS_IOCTL and COUNTER_DISABLE_EVENTS_IOCTL fail with
> -ENOTTY for 32-bit tasks on a 64-bit kernel, e.g. armhf userspace on
> arm64. Without a watch, such a task gets no events from /dev/counterN.
> 
> struct counter_watch has the same layout for 32-bit and 64-bit tasks,
> and the other two ioctls take no argument, so compat_ptr_ioctl() is
> enough. struct counter_event, which read() returns, has the same layout
> too.
> 
> [...]

I don't believe this warrants a backport to the stable trees, so I've
dropped the respective Cc tag.

Applied, thanks!

[1/1] counter: Allow 32-bit tasks to use the character device
      commit: d722f879730c766ed9347352f4b5855a4841125d

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

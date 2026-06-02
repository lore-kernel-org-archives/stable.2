Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF73939C2
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424506; cv=none; b=mh6IH79CySbwJ940WONKdZtRXh74SQdm0ehOyJ4RqO3ETIu4w/MS+pA5CfqkIECF2GpAGWK70uT+Py0ML3TrVIoIkqjf8k1vj/8+oOg0D5RzaHyV3naIljFfJq6QgRH8D0tKg3+oiCSPBQMQSq92He9q3uRg3qDsrq0hvkfAy88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424506; c=relaxed/simple;
	bh=MVvTyIxkIW8kafkuyeT5yHAst+40KPSzQdu4O/gvC9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNEjt7iUkoAqXatGgp3ownelVlIW5DcKF8MtU6q2nngeARmAhhKRULyW6U31oRxg37uEuINysAyD+lMfH6U/i31bPeYVKvjlRLOLahCvwDSlPdkkbkInEgvTR2GNKl+OcK4TPlf8o27QIIX+/1SBthZY83fo0tjT+idtmv8vBPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqZJnlZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqZJnlZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462CB1F00893;
	Tue,  2 Jun 2026 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424503;
	bh=MVvTyIxkIW8kafkuyeT5yHAst+40KPSzQdu4O/gvC9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gqZJnlZv3bckkg9Dt92RNiAfLTrHP3vWDQ2z8n8uMzGWhVzcaOrCgFKgeldrisGyl
	 H+BGMAnNdB56CSpfdrB89jw8W2kyBE1/nmSK/6rTUUuX6IYaW0YTus0Ph2juxASq1d
	 7nKkTodDvc8woZAM17rA7InkP0WZ+agGVL9N1OAFfK8Rw10qW0sVijwUILh4y8A0E3
	 mS4mNFuvtJrnzAjiLH9QEnTMfoHwhwvMo/imuzmzcqv8BjcOT6JXtpsT3d0p9Yh8O5
	 pV5YZUi5RtIcMMfrg7iPYfd84KeGFgH5Bu/+M6v5ydJCb4FD4dONntx9K+6otGVPjc
	 jm4Z03LFXbNMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 5.10.y] ALSA: usb-audio: fix null pointer dereference on pointer cs_desc
Date: Tue,  2 Jun 2026 14:21:21 -0400
Message-ID: <20260602180900.alsa-cs-desc-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531152950.191924-1-kovalev@altlinux.org>
References: <20260531152950.191924-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, May 31, 2026 at 06:29:50PM +0300, Vasiliy Kovalev wrote:
> [PATCH v2 5.10.y] ALSA: usb-audio: fix null pointer dereference on pointer cs_desc

Now applied to 5.10.y.

Thanks,
Sasha

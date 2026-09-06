Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD738DC56
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701638; cv=none; b=NuWtu4FgmRYJdXdK+BCnSsvFfnNCApMBectFslWiYWjkyGbjxfWo8G1eLdU+4bWIdOQnaRIFl1E0TWWN4Tbk+x5ck6DSb7ACJ6cw1AVzvSy69MpBnpC5tRDq4HVgnA3yezTFZV5qTFpd2Duzbqs830roODgqBIvjr8/4y4MEvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701638; c=relaxed/simple;
	bh=H83rx5hytpJI2Da2J9AevV3ZZBneVMo6bHeDJNStW6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzVezfuEIdy8aK8X4QAUlU69FqIgup1CEJIRfi8L0mkM0Dh8h7cP9O3D30jN/YRxirNx/A64FsNpYDeGQ5KuCYLxegc9H4PLHsNz+ACZJX61PLNk+gytxOaVFeDZnAruMdGNj5of5yqujP5fFaDfOeDGg7my1O5xrBYnrA3sedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+yUrOlv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+yUrOlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5A41F00A3E;
	Sun,  6 Sep 2026 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701633;
	bh=/BNOQEleZQJDe3O6/g/RTocg+dUgQcOI7vorARbnV6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S+yUrOlvd1k4HLEMtGygfnC1z6Vm9q59K5lJSQzqM/a97aoylNHkN21CHtiyCIE3j
	 gyP0SNqfMvceobJwJ2kSKuAZjYOWWMC4AxAag430yAxokMefk7aNAmKLqP3KRW4lit
	 lx8fir63XJiQiEPUlBANzSbtHM5g5ntca7YI5Tg5MGxHbS6u7VEUj7WrI/EV1oScfV
	 QePdZRGd+n0bdmsdQYGySFz4IVcIb+fJY2Xc7ANxV+ZYYnN+lfjHcH57S7IXD+h9Ua
	 RqAFYThslfUvv8XILXiskuiDe1mSPuqnF/jU8suYnS0UmYJWkvdq17gzwDA7QXQ9xF
	 6k21MPPe/wDNw==
From: Sasha Levin <sashal@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] ALSA: seq: Fix port lock leak in deliver_to_subscribers()
Date: Sun,  6 Sep 2026 09:32:58 -0400
Message-ID: <2026-09-05-daily-reply-0028-alsa-seq-port-lock-leak-6-1-ack@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904070349.80497-1-tzungbi@kernel.org>
References: <20260904070349.80497-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Commit 46397622a3fa ("ALSA: seq: Add UMP support") mistakenly removed
> the `snd_seq_port_unlock(src_port)` call in deliver_to_subscribers().
> As a result, every time an event is delivered to a subscriber, the
> source port's `use_lock` atomic counter is increased but never

The fix itself looks right - restores exactly the unlock that
46397622a3fa dropped, nothing else touched. But there's no mainline
commit backing it (the actual upstream fix would be 177ccf811df4, which
is a MIDI 2.0 feature commit and not stable material on its own), so
this is a stable-only fix and needs a subsystem Ack before it can go in.

Jaroslav, Takashi - can either of you Ack this for 6.1.y?

-- 
Thanks,
Sasha

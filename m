Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E5842CAEF
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406273; cv=none; b=HwolzbR9SpZR60w76vmdJOkJx939Sva7n/0uXg5HKVyVtCCQYkY1NoVjTpD8qaGfhmqBtQosxSQdvWQSPLdvSNU/ZLj+ywzS6+F+nCYFj9wNanETDgdUL3wPlHT1ejmCjqU6+v7LyrKXWt5/y1ER/6TL4QoWqPLZJV8pZARpfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406273; c=relaxed/simple;
	bh=8m8zR/hrcP9bRXfE/BVR+A21+Z69W9PqeXZzWIwQJ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLzFwvAoOL1TCpdzbI+Fsh09N5rONT6UL8RvcQyRIIY2EAD1A5EYzk9n65jLNupYTCELp8A0BucIvkpMuybfeYcgkhDT0FfhB8i9jwEu8gX/vzIknwaz0KYcJSMYcmVetYcQ4PVRqFlMaznmcq5i24Z+XnexgsHRK3fEyiVnDkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmMrn/Pt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmMrn/Pt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB791F00A3A;
	Mon, 10 Aug 2026 23:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786406272;
	bh=TuHnFnKe0k74CCFUMasplilnjb2cxxwgWt2EqAwnNaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZmMrn/PtPvxDBS6rihRadMgn8VCsVAx+pdtQ/bUPFhoUJbJRNzVIz9FjpL02CPU6X
	 gY135ux75dR6qNHkqsgC2fNUEnC4cYldk6Oj51OUS3584uSHuItAuB+L23L6cebJ0w
	 6KsGPAp3rUav1WbCXvp4c5ACAejROAhMvc1Xx6zr41H5a895a73oJdOYAUBOSkSWeQ
	 wKBROeFrBtFcj3tr/I+8qyG8RMQs5X7o7PwxJ2sQU2/2Pk7FKZ2dfV8QD1uRuZEVMB
	 I0fUc1HGSTMEOqOyVq2JnTAo/C83mMwz6EMDfUri+whAhu9oll0WpYbx0MTfAALXUI
	 uksLIrNcO5FWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	pzqqt88198@gmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5.10.y v1] ALSA: usb-audio: Evaluate packsize caps at the right place
Date: Mon, 10 Aug 2026 19:57:41 -0400
Message-ID: <20260810234738.0002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809074320.1407-1-pzqqt88198@gmail.com>
References: <20260809074320.1407-1-pzqqt88198@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> @@ -953,6 +953,13 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
> +	subs->data_endpoint->packsize[0] = min(
> +		subs->data_endpoint->packsize[0],
> +		subs->data_endpoint->maxframesize);

Moving the cap into snd_usb_pcm_prepare() is the right call for 5.10 - that
tree never computes ep->maxframesize inside snd_usb_endpoint_set_params(), so
there is nowhere in that function to move it to - but nothing in the changelog
says that. Please send a v2 that spells the relocation out in the commit
message, since the diff no longer matches upstream.

Two other things before I can take it:

- The Signed-off-by needs your real name; a handle does not satisfy the DCO.
- An ack from Takashi on the 5.10 placement, he's already on Cc.

-- 
Thanks,
Sasha

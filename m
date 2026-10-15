Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A952745C71B
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096305; cv=none; b=WNDOQ3enh/BKGPC6Zl8dfVRrTLByFv/lvyYa/Q0+jNsOKcUQAWEmYBJJE7QtZRhUHcTK/JjvGewEKFyeLYECzkzfVa36T8GnhwXDk6KSTWRktzvFA408oStbnJjCSOLa6G+P6BM9s1tvvRDnCe4cNWVs9BVuxfdVFQskfw/FJrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096305; c=relaxed/simple;
	bh=qY6dVe7EZDBW01ez4gRTa3wVcl1U/MctK4jvg8AzgQU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aPDNKjuL5Ef9r3bog50OS9kFeo0XqVcrnZg3mhn2N+MyJRW0CbIM6qCwaRiN2F0C6jwYxpRGukOwq7D7gq7+yrNGbWUIsUhTwP5gIrfbkxIHwp9tAbqdwfBmmJMwuDiKvhgKB5LT6XA/aaw3Wr786rcp9qxA2F3LDnbtArLIx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=mRaStVKK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="mRaStVKK"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e8fe8e343fso24322535ad.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792096304; x=1792701104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F5clQpnN4nAGc39KpzbJYzajR/ETjOEzamoYot6587g=;
        b=mRaStVKKsJub52+NORHaSBei1XR1PwYzssYKcx2J5DTUmFXTLvgAYAyXIRDmXYB3a9
         WgeammlqL7AoboZJvJqVjUJOtpr2PuPHFEkGXOrvFI38B/lPl/FriZUoyHZhL2bqE6H8
         Q+IPTkepC5B/GZoeBf6AodnbP2VB8dVD7O9Q/T7cIvYwP7FTFBocd/pAO5PSDxNL8D4y
         fcdt9/WYEaG8sFCcdVWDpsX6z1bYbhBCBomAgVKlbh0OHjjOKPosQ/mpf/Vofamy57ed
         g7K/2AQeC24QwbG5NI71htn6Ek6M3nmOTzhx0P07ES4/6Z9VuFJ5o6jMYKorD+S+DaQM
         8L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792096304; x=1792701104;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F5clQpnN4nAGc39KpzbJYzajR/ETjOEzamoYot6587g=;
        b=CKhju8lck3B20FAaFPg8DvVkHrTQANit9NBXaxwz+Bex4Boh0xS3WdGJElvuxWpMGS
         dkcMT+xmVqF6TpR8ZrpZYtlW65UBXEDuIobdu2NSg+DDbz/Pe+WRwDJeaX8kShvWCpCt
         SqIj/Bl//zHdLHacvfFZO/BKdK0YYdA+NDLsKp9/iTVdXnN58g1mtrpMkF1ZgrtofBQa
         nRoa40VHfxdhNNoLc5N5Pu5oReAc6hANLJ/9//Hy4Vn52lYKQm0tis40KajCqDOTn6kA
         eIi6v5VpFYcaCMihxne2T90kv5Zff2FVa6cUEYB6NMUrIDGHXpm2zHg0uiMSE7VlwTFt
         +1xw==
X-Gm-Message-State: AFq9FYI8ramft+ayXg5J3lDQljPLA8XfbRBzUO5m2qes3Uoysm5nhNGh
	aIu/c7NcuJqzDJ6UJJC64qfa6r76l1t288M7ETY77RafRwstDa6GzDLpjvEfW162w+PyCNpto1q
	EmVhct1I=
X-Gm-Gg: AYBFou2D047kmByXq280v3b+eQCLEnfRojJKNaZVv2xi3WBTwv/A+hMUvC4+67JBGf8
	8MLeZmxpI6IRlJHdyzco+RE1J+p0z6pQmGmZg4KE6W5454l3B74vogJWe5ExDUi2aLSO1Cvk76+
	CdVIFVhvhuEEHyFFq4THKDkOfpXWQ29rCvwJ0wdivDtBMjMmZR1OfJ6DHFmLCo7hH+0DtWkvZm2
	16iU04Zwvmaul/WdyX2tNQUMHLHI5NFTHbW1mcHI4V0opnYzHopF3u0W3Bf6KJ/hj3f9LKY9OaP
	xq3RksrSFUWo/rnKm47Y4O3l+R7boGeQ0b5ZBv2zy/qpd0zC746tBlTaRmmj9cPbv+VLEUDgBWP
	8PV1c1MOqM8PjBkQ2K4npl18sdAfgy3fdTV6Sge/81TxIaNyvosIGakFk0ecBbrcQj6KmPl5h7/
	iZatFffhiRe7R3RohJAlWwjntAAATyN+MNgeKnOiKg0lXq7oeGbGbIA5TZ0vD/Gnyy2JhhyCKKg
	gihXOP9TECtTZb+G5rCJT2IRZOhH/UGU/RQV8QLaNQSsWBCKM03RxKgUg==
X-Received: by 2002:a17:902:ebcd:b0:2e2:c773:a37 with SMTP id d9443c01a7336-2e842ab68c7mr172699395ad.16.1792096303967;
        Thu, 15 Oct 2026 13:31:43 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d98d9sm1060325ad.2.2026.10.15.13.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:31:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Juanlu Herrero <juanlu@fastmail.com>
Cc: stable@vger.kernel.org, Anand Natarajan <anand@meta.com>
In-Reply-To: <20261013-pu-cmpxchg-v1-1-4ddc10fd8a03@fastmail.com>
References: <20261013-pu-cmpxchg-v1-1-4ddc10fd8a03@fastmail.com>
Subject: Re: [PATCH] io_uring/poll: avoid retry wakeup loss when dropping
 ownership
Message-Id: <179209630000.1859568.9804647387852543567.b4-ty@b4>
Date: Thu, 15 Oct 2026 14:31:40 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 13 Oct 2026 15:37:20 -0700, Juanlu Herrero wrote:
> If a wakeup sets IO_POLL_RETRY_FLAG between the owning task consuming
> the existing instance of IO_POLL_RETRY_FLAG and the loop check
> of io_poll_check_events(), then we stall on processing the request
> until an unrelated wakeup comes along.
> 
> Using atomic_cmpxchg instead of atomic_sub_return to guarantee both the
> count v and poll_refs are 0 and no wake-ups are missed.
> 
> [...]

Applied, thanks!

[1/1] io_uring/poll: avoid retry wakeup loss when dropping ownership
      commit: 937d38dcacd675dc0572d6c9b6743960df3128ed

Best regards,
-- 
Jens Axboe




Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763490;
	b=r0T+D7kfRYSN07gsDEh7C/Gz9Y+JRenYXKH0dHzANIwPcWR/vta0Oe2Slbkre7esgFHG
	 hdlNzXFDtSsD6GvYZhcadLXDEpZMNTs4MZIy8K/75deWoFfFxRG3MWhOp+EYcEllBA6np
	 cUixu6FMG7x31i+teEcPwaoBCGThtUNG+MuXrZVp5iY4bHEF0rndO5UpLacxnQt2RwPLz
	 o7ciC5MyZNzWSwcpzbT2czRG6yNMVXeSMyAUoappFN3fNe/1VYYRiY+tURMiOnuZ8eX9s
	 woh3ZRyFRns89mA+YnR49qoB94wnIeGgGHmpKV2R2LpqLITUEhx6SeftNhi52O/RmQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rQJmhMDaRAsTP37CWAcROukZCu5BZelTc8z0YsFLDJo=;
	b=ZrglFOCiPvzclBmxg4p6jTBIWTuYG3zmFr++9PcA1kIWB0N8tiYM8uuzxjyV7N+3wh6Y
	 sRIInjwQ646susXwyBsdN3qJL5lNWdcNzQv3dYTAUOU1XrdcF59/hP94iAPzgsbrqXm+0
	 fPJlri1AJUEexhCpUo9gtmKaRTKHQ9uuz5U9bD589oJqGcUg917NmU5KrbDx4dSwO0Ggo
	 8X/z9YZ6K2+eaDCoCou/LKJGyo8m9FzVGOKs7/NQ98sfcDeL7Fu5ftuyeEAILWzaJQ2WN
	 H95wKDtcKb/X+Om/JoBFrLH7t4vo3njqTuByFTZVFWWJzRXhCNz17BUDL0fryn2cu3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iInoVN56;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444F606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8444F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iInoVN56
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48dee593f18so634674f8f.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792763489; x=1793368289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rQJmhMDaRAsTP37CWAcROukZCu5BZelTc8z0YsFLDJo=;
        b=iInoVN56UL2VtfQF+kbCbg5rcjOLrsexQXa/aZ2PfbOPcY/hGVwibIyX3jKCA5De4H
         xlsWb5JNhqbYmmruGskDCB6YBFepHN8HbJAXXG5DceufWfddc/DWer5BMwUUcuSMVOO5
         mZtenmvjs5m3nEMRbAuVilJTO1Mg208ijSJsJF4Ua/NujxJmNDmGkg5PqfwzE534pkbO
         7EXlSps4a39moMgsm9QiJVakgv7137hXul5tmBXalepv9jN6MmQ4Rb2oa/CjPL6jf4WA
         H97ts1HhekEe9uxNSTmGkH0dkTqlbv4HreDcwjCZyQNO6nqnBBYvrClUIPGFALkDz3Yw
         AV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763489; x=1793368289;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQJmhMDaRAsTP37CWAcROukZCu5BZelTc8z0YsFLDJo=;
        b=1EsJyNB/9cnzEaxjJxeCkc2HEycdifBTPhoTbnVjSw2fcS/mCCRnh2zGwywsoM1B2E
         2wXWk2qL6/GkfPpJiIVzrynfXNXToqoJVsjtuB82zwDjUtmK5kctflNBewbPlh9559yb
         6lpIDzG9LPY0rIiLSyI39NSiMpBCV+azHNLD8PzXkc/pgLcxo8QCG/1vLxs2th4Bz40S
         ++YPWMAz+EKy9e646wb3yeiPQOonj/qjLc+V1oXuU0MRy3QYY77zcWoQusvPZBJUiA84
         R5PKzo6I806W3/MckFYZxVgA4h3vG8oIUChoba3C0pD3NARacWdWAMdwA0ofERlIXm8J
         u3cA==
X-Forwarded-Encrypted: i=1; AKwUvByJRTlXdmljqgtaO3LHVtLat0b3DQ8/Dybg2d6IGoOYGJgoGo1YOcvQI0PrJpGSBzCx50HahvE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQYUDPGZgik1xLx6eoL0uZmnHPLC/ciiVf8dEFffAUqG8Cdx7f
	QKzNqeL9Pwggqy92d2rRuLnV637xzYrMBYrcvel6omDfgvbcZtAx/AaQ
X-Gm-Gg: AYBFou2DGustshdsaZJ+GF3/ThbN3WWVCH5ZoahZ1zebEx/Ycrlntjmwa4sRAZRpMZt
	8jgwbErdMnH3qTRl0hck7gGMpCg7004MqqVwz9bIJFl2R0Sqz7kRAa27/5xhwRT/92sy/BdsFOV
	oN1k6FgkBxmwaNcgg7lVPngGTnJbpACR0Bo1U80o3Nwlw4p7Wv9FKLsWJxJ09gmHQ+8JS8Wdq3G
	pMHWDlJHtFkPq2KHOzv2pbx2rhP2EKPtLMvAYfQxD1nLujDKPi9H/PVPlnpyeEqaJBHv92aELV0
	bP6qYCXrzYkIQn/v4g1e5ZQ0/aUskniGK5n6YgdaZpV7eGyU4qT6cCTLtXckajVHUlJb0rAISKy
	HOaX2rqrTanw1Suwcee1KWyiZVW1n20WSdEe6IYejfx1ZFWHmQfaVKbsNXlcWhcE3cheoW/497D
	5of17AquXx7c/YKZUGoLy1NCKbReP2XTuW0rUiGax4KQ8DMlgtYWgu6xlTt5Wpy7D1BTnxnwkts
	u7cZ09YC/q4DAoZEaoT+WvI5ApT8NyAKsCtqHfg5A/7gXDICc96uEOdZ2U3yg==
X-Received: by 2002:a05:6000:29d5:b0:48d:f025:110d with SMTP id ffacd0b85a97d-48e385a0752mr2736643f8f.43.1792763488617;
        Fri, 23 Oct 2026 06:51:28 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3805c596sm5486156f8f.49.2026.10.23.06.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:51:27 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: "Felix K." <fk@mutemail.de>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: Re: [PATCH ath-next] wifi: ath9k_htc: fix beacon slot selection once TSF exceeds 2^42 us
Date: Fri, 23 Oct 2026 15:51:26 +0200
Message-ID: <20261023135126.4118569-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <8733twsm6o.fsf@toke.dk>
References: 
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

On 2026-10-23, Toke Høiland-Jørgensen wrote:
> Mehmet, any chance you could test this one? :)

Tested on an AR9271 (firmware 1.4) as an AP, 6.12.113, with the TSF
moved forward by up to 23 wraps of 2^42 us. Without the patch the
beacon goes out half an interval off from 10 to 22 wraps; with it, it
stays in place throughout. Beacon count and a connected station were
fine in both cases.

Tested-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

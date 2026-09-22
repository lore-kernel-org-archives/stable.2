Received: from mail-ej2-f31.google.com (mail-ej2-f31.google.com [74.125.228.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020E534443
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 23:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.159
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790120766; cv=pass; b=UopEZBZVaCs27HY8hrzVsISzhuNFPKF+tAypMC0JGZvTIErigNS965C+2W5N0dfqfH9aEmv/grBpauDPRnccibWJMwHr7qc7CN3fiobF/UoKFgM5MA1pN9+kOqTki7PBKoFixI7AnDuzijoYD2wdI7FkvZMKktemKCIPnpg/k/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790120766; c=relaxed/simple;
	bh=h/FQKBX76Px5OlX/uim5VN6v2EtgZzOe2bZfqB/myBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrKGcU4uuQseoD4iw5+Hbr/KltVKMdr4DogaVekMTou21FJDcLEatLV6pORe70Zi2633kxE+8xN8EgPYHBjqWwRPbu7GbZPoqkp6hZZdXoJAfclUozyG9msq1+z7ZHFwNcnWP00dfZ84O/Kf9qrh22PGMpbQiHva+8lL3Evr+NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6v/c2pi; arc=pass smtp.client-ip=74.125.228.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6v/c2pi"
Received: by mail-ej2-f31.google.com with SMTP id a640c23a62f3a-c29703cb796so43780566b.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790120762; cv=none;
        d=google.com; s=arc-20260327;
        b=Hh8xP1Z+TB0+bKF2uDb6J3XwFJRbKw5GzNSp6/4NB6/P7HvPuPyPsVdBzep72G46bp
         H10Wp9rwiAPAh/X0wZi4ZvLGz8Q18Wn5+qa7BOcMsr6v1wLv2O2mHFBsQz2tmn1vrPyx
         2Ww7bV85iKW45srzvsKdLmS4KxMznTYNT5P36KzxMjFC/Hu3LNTQLe8Ldu5erzgR7A39
         2nnBxKKbdI0bGxIUQNijBUD97V6N18WLmRXWJ3Q4UmYtZXX1wHnfRV4WWZ1lhoQCdzZT
         onUzqjPY4VwgiH5XAK7cb0E/d7574dPBb4geZPQxcO12nlgv+sGVs9oEQpqLU1pPSMJI
         f6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h/FQKBX76Px5OlX/uim5VN6v2EtgZzOe2bZfqB/myBE=;
        fh=TyHpKCcPOT9or2ZJFytsjS6wUG1lN5xgYnEy4vDSfqw=;
        b=GymL0TsdaEn/Vw9UdZ/VcqEpEurvf0FQ97coqFqeUW+iLGb2/S0OmjM0IF6f9dlh+S
         DMDteFqh+w4zq0NLPHbtoj6g8AxLKr8FfPZLkycorTLI+sTc3w3JnhrHqB8LYtrBLwQy
         jyWJju1PD9AXXA8lnTSTu2Lu8rNJrvmxpZmezKfa2AtrchpZ3X+7ZUmpmsKYA+s+Q6Wa
         dupMEFzVQiPAS/2EPgFbw1sD2y7wwojgtAwiiUjy6pYwV0t18AXca3JFpv8md6OvsT92
         KcNnro3DZNrv5ev/kETurhclgxrTz2jaEjhQ7DwFtvTFDeyz0IBIFtXKZKobXKLKTbcJ
         NXmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790120762; x=1790725562; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h/FQKBX76Px5OlX/uim5VN6v2EtgZzOe2bZfqB/myBE=;
        b=K6v/c2piZtIsDHbJTO8RYzuzjv+zmveCCQ/c5nSZb/8I2GiVXIcg3n8qwY7mfs7aV6
         8iQV7eYWHmzloIya2F6vYDS16FNWga0rOa7uc4kCCoW46al8gMfbLNO6VdTfX9nx86Dr
         s9PgZN2DAzTSNd6BHlAzeF2U3RgcpxHb1WEkz1HNWcaJi2vbSzr6JtGa6wBxjjuYTsk1
         e0zLibIh1p0XQa5y4KVBRsDUBcN+uH+ySwQjTcTmYakq2qEzvXJ734zzC4ZqUX/U60mS
         Cldo7LPfsM3mW8hhH4ITa5azN/JquNqSYwHO/B3NR/VGJIKmsAJGBsovBceDfswiYV3s
         ESHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790120762; x=1790725562;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h/FQKBX76Px5OlX/uim5VN6v2EtgZzOe2bZfqB/myBE=;
        b=TYLuBTSlO6hKzp4Y6cyH3q9DISvjOC235t/W7q/aRIY3occrFqzaGLCK12i0zyd5dY
         lYNFilwv8iG6K1NtcuO5jgy+L0/lDFP9ZmfVrNx0pjQO1/d4lfSxQf+0aEnbPnF2iAng
         rq03dhuO0yFPmbt7leC89CHJbk5Rbp1aUjIUrzCqlKrDyWS1IXixJQ1cfI58J6eHNXE5
         duVGoIYJGtYfoRh/MBRn58FfRV5i7KfnCuwHth+v7hJjWn2rZZz2OxCBtFeveYHjN8Xq
         dDkoFzg4A6NCXPLCvlvGnpyrCpRlztchwewhuNYMjzSbswv8fxaby9tAt/DeZorhXpcQ
         z/ZA==
X-Gm-Message-State: AFuF++mCb0wRssz0fEE1aSWbCwQbJvvcnWb8fUYVPZi4UclNbyxPQIJE
	DefYjAXCjQy6wPZixl1PEk6iZ/pTOW8RajJ1AdiWC7e1OyNjti2u85DRVw2/4TFsvdzXzGXUZDd
	8RTBP5/Yf2WLjut19/sE/TJ4LtgCHYio=
X-Gm-Gg: AYBFou2UzowyUe2CqMDwfP7WD2XAJYZnGHcsO0soK35XuUQ0UzCjOhm4m2vH769t6Zo
	KvofwPhLnzgJS1ezxkMdiKEu4H2MFEJQ5tg0e02Ntk4EoEwvgameJ9ChH36YjbtHap838Z0gXlz
	K77A6i8qy0s5WsHL9Dt47DldPmI9CK9mmK3n+/BMLfmWSW1w1cMac+hKdz/rB1GgIt9I9voiwhM
	ZKEIdls/EpAhBP8VTbeLpVMkxFRbtHd0LrmYfh9BUjODOdtfbgJA1GThxJDJ47zHL0EowLC0kw0
	WJzwSm+uyiMqxoYL9g5aYuxkSkAG9GUth2WOie4mooOEFrAKfIpuQZS8
X-Received: by 2002:a17:907:9610:b0:c25:23d:5295 with SMTP id
 a640c23a62f3a-c2aadcde5d4mr60744666b.17.1790120762110; Tue, 22 Sep 2026
 16:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <16dd5af86510d1fed6e9dc9aaa4b1e350e0087d8.1789702442.git.jamie.bainbridge@gmail.com>
 <2026-09-18-daily-reply-0010-re-af-unix-peek-tail-uaf@kernel.org>
In-Reply-To: <2026-09-18-daily-reply-0010-re-af-unix-peek-tail-uaf@kernel.org>
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Date: Wed, 23 Sep 2026 09:45:50 +1000
X-Gm-Features: AclHuK8eG9jx-PhwMWsNp6HXpCgqZnmw_ZqxjflwO-tltkNsRA0A5rWLveIKxms
Message-ID: <CAAvyFNjZJJVqivRushxodQ-yDEu27bB9jSC5tU1i-nXJ7+G6GQ@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] af_unix: Fix peek then tail dereference UAF in unix_stream_data_wait()
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, Jann Horn <jannh@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Sept 2026 at 05:45, Sasha Levin <sashal@kernel.org> wrote:
>
> > Linux mainline commit be309f8eae8b ("af_unix: Fix UAF read of tail->len
> > in unix_stream_data_wait()") describes a UAF which it fixes by removing
> > the offending tail->len dereference. This was assigned CVE-2026-64109.
>
> This is a stable-only fix with no upstream equivalent for 6.1, since
> mainline deletes the tail->len read instead and that change is documented
> as unsuitable before 6.5. I would rather have the af_unix maintainer ack
> the approach before I queue it.
>
> Kuniyuki, does taking the receive queue lock around the peek look right to
> you for 6.1 and older?
>
> > Cc: stable@vger.kernel.org # 6.1.x
> > Cc: stable@vger.kernel.org # 5.15.x
> > Cc: stable@vger.kernel.org # 5.10.x
>
> The diff does not apply at full context on 5.15 or 5.10. Could you send
> the variants for those two trees?

Yes, once the fix is confirmed with Kuniyuki, I will send patches for each tree.

Jamie

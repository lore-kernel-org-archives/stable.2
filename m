Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483517;
	b=p8IMDhImlhRnfQucz9r9wfuXQs5n6gBYCUnrXMHuMcXutFYMt4d1AelbYOEZZv7iCnqt
	 lGsoPCiat2vcMFbBmZ9rpWBJwjZ9bgJlmYsdYyJI6EM0Ba9F+ZUwSqPtoTey5bcgYu+V+
	 ekNqBYfTKvMtC5AJk4y8fQ/+Gz0GIfzUtA1jtikGVrhc6kkAjBqjWpyE6XeLqed4nlIxG
	 77T9hiiYIEJ6IHYBtqd1UEXDSrcgd9s9Hic/cvI7UII3P8z7znLHpxBu2q5Ez+IKBP8JO
	 pm/y/U5TEDO4/cckzdqioABLKr9RF7m+0ziZFWw5oxg6xiZMaSWanRWWEWFOTrz4hwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GPg92EprU8pd6RZNS84knIcONGEuxb3GDBAmGPh7pqc=;
	b=1hxuOKHbIAAkDsad9Savh1Le/UtivJfKvAAGub+m+lryFTGrv63+cbL+ZwrLIV71y7cE
	 AutIxBA1jWPgEqRRoXXJtcRTCC531YHM5Y7i0mxTcv8mRbf1OpAr/YE5BZzpr8jqrNCzj
	 RuCr09s/3RJiebC2IApXzPDZTGQlp8iod/0uwsrjlZci3+X6lQE+kw+gpJv6jVBEBQfJy
	 pIYN9JqZjFOtsAF4j/PBidCtwchoTLKKq7qvJ8fjiIFzDLfkhitON7qlPNGjmwL46fAy+
	 CipIUZVM1/trgm0nzeYrYMEj8K1C/SmsVIsOa7YZpCMsye2swaWZ+AsD/IP4NPlbHHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qFKnXVQ1;
	arc=none smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4F606A31D
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D4F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qFKnXVQ1
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso464208e87.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792483515; x=1793088315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GPg92EprU8pd6RZNS84knIcONGEuxb3GDBAmGPh7pqc=;
        b=qFKnXVQ10drmnI4HN5aRXpeaLOJkYq9Tab1fnPYppELjXVdHUSWEp+Dk1VNn5ENReb
         VwzP4JUSbupg4lvvQzvzg/36LSOMH7gG/w2Qar9ZI+ExP48nYy88fQzt3H5bv0FTd696
         eC3KQ4TvONuZEL5tLNguddcsvPPss71h1Q6yJHss3ENVEYtGTHxETQAgx1ETPlL4Purg
         LbiCMljC6M9zRqzNLy6pMf1A8jNVxhOh/w9t/OPaxi76TTDqxbPF0Ez44yM3cxkVvwe9
         Mj6KMw9v9eqeb4tv+TcsTCSqVk0BqCRhIEqNB981XV21I70KGJpxyRNW0dmmwq9//noK
         rvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792483515; x=1793088315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GPg92EprU8pd6RZNS84knIcONGEuxb3GDBAmGPh7pqc=;
        b=RTWNGjLxHtcaY1mv12jwkufBAs12HhekJUtVoC9SgBEZanyy0Pe4wEz8811a9u1PPA
         N3B0XZ/4LcqmPIUoLd/M3Daaf/M56QIgP+o2glvLwbEXvu2wsa0ZwUmw/ONJebyd9C3T
         T8mI52Ori/sb6WuB+YRMPUYQE3GI/VuO2iyiN8lEeQ/NepjBOuqRq9KZrH365oOtkjH9
         qxoRgIHOl+A1LAN0cGaGBBYaBLOk2T5grz40PrSWEmtim+EeCPWcGWYjhEHnf+JhJ7Fv
         hphyZZRl8KiXkFK+0xQisd8mmWWkW3fDpHPb7jtyyFfEqR81uJl8n6uUa61MtvgevgBf
         +SGA==
X-Forwarded-Encrypted: i=1; AKwUvBwfcDYEjnOERyb/kKQQkHqGiW8ztirw1vwcO57Az/b2VDtM4LFPxyA/AeeyB/68SJJ+bCGwe+M=@vger.kernel.org
X-Gm-Message-State: AFq9FYItIfqz8Ty8PnhaaUEfm3pn1Y4oREBOZcZ2NKIKqdbQGrZ08t3N
	wXkL/KMuKn+cXBGO4lnarmvtMMnInM579zUBVsaDE9AkTReHDuag55Bo
X-Gm-Gg: AYBFou17WU2krfL0q2R57MyszfmWM2G2ZzCMCquRSWf1jHGvlZv9+D3xqPno+4wilaS
	dMEKLZSUr2OFPYnVwaMTW0f8xQkKh4OYUuwUIcKWUu2l6kMGGIA7jez29psI5duQQYRaTvB9HwS
	unS+grHj2MuPMCxbtkoty2VfreCt9Q25gFS2TGUu9dbEbQ/5Q1OWMEiPgBHV/aUvr7NaFWwxE/7
	K3W5RhcE+cXAIa1lM0gsoz4ttwabqZGk8uEKIyYJhpn1j0dh4YmfioJmn3wHUL5XJjr8ZpR1ZqF
	h3j4bWyRQkui37FL1Yev6k9YXBOttr7FGh5p531tuegoARdXj4doH+PjYfcC+f0ri084b6T6Ayw
	1uAqbR8/RkejzFZ3QmzgC6xqiZ2JuTo+oO2VxBWdPFZcfC03hWOCEemvHFLH3u2cQg9bZYPtC9E
	VdNEGKHYvp5bLctN4QoBN+/ObDHtdP4v8Y/ZU/O5JsZi7GfeIJw+WQ++8RPlf3+Pe5Ztx5SAg0c
	5OMV+R8bw==
X-Received: by 2002:a05:6512:104a:b0:5bc:f2fb:f4be with SMTP id 2adb3069b0e04-5be66a23f9bmr431809e87.6.1792483514495;
        Tue, 20 Oct 2026 01:05:14 -0700 (PDT)
Received: from grower.astralinux.ru ([38.74.72.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a42b330sm2424863e87.15.2026.10.20.01.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 01:05:14 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: gregkh@linuxfoundation.org
Cc: alexevgmart@gmail.com,
	co+0ea1ac045375cf05@bugs.sh,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	xmei5@asu.edu
Subject: Re: [PATCH 5.10/5.15/6.1/6.6] vlan: require the MAC header to be present in __vlan_insert_inner_tag()
Date: Tue, 20 Oct 2026 11:05:05 +0300
Message-ID: <20261020080505.279102-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026102010-hazy-clear-1f06@gregkh>
References: <2026102010-hazy-clear-1f06@gregkh>
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

>> just a friendly reminder
>> 
>
>Of what?
>
>There's no context here...

Of patch, which is first message in the thread

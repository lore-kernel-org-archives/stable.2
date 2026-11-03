Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793682965;
	b=Q7bHioqkU7vJEAPYuPJrpzpogKID5ROwYLkLbQuMPwsoLzQJszbXTfgYxhjFGewwYyJ1
	 L9hut4bUhD2eVNwhsTARivH9yQlVYcCMFosV6kRpK+0XZErVQHiAkUNcZSV5VpkcmhV+p
	 kbdGZzXuaKkD57P12kt66vy//i2NS8VJzunUmmkt8JhvWThgF9d3a5hxQnNXwd0a2QNn+
	 7HPToTLJTAiukPKdRnrT/bGYqQzDBEx3RKkJEBtnV/7xJ2KCPLTmNFMmH9YOZznjWI4Ho
	 sQmehe+cx051RtYf8ltCqNcw6zD0mdAtvDGYMZPnQICsaY2qZ5BDDhqDS+b9KQAqpdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793682965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=PGFryZNd38Zhqh8hnykXJyIhCnVJvOsmZjjsn+Xx4Kk=;
	b=kxQNPeCyovx1ELVPMk9TB+tQVNLg92pHhfnzo89idMJGzjNcs3JjOh/YLbcdmeMWekH3
	 ane5g68OD0OXRdOCmdN31Rj8iJgx+t6eO6Zn0hqKPDuAFnsYjIKr+FtaJMJ4EYpbmmmG9
	 wqPpglCIoQmCiJ7SWX+8UqYNM51hIQa5JS5eUTo6z4wljidByq+ZWwvSGTjdA6xWeePpT
	 5pZmW007dFRnNWHxG+jHKTgDwGCtRolq/Keci0E8K9z+b+dTn+I01C2UZW0zbUcpimTsY
	 LPwR35fDNtpVYb0IXKW6+F9FRffeghtmAuWA51EMwON+Akq3d7DfXSobbtoz4G2Pdyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=FSGnN9eu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7E8606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 05:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F7E8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=FSGnN9eu
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-53656465d1dso2224634b6e.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 21:16:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793682964; cv=none;
        d=google.com; s=arc-20260327;
        b=eOBsh67rTAK+C1RTrEeNlWj5f5vd6n3oBJQ7OK5tVqIbCjVDr7SRgrOOe+GMshgPBF
         NhSsp11/tV3/FV99P+LgNWMsanpNvlAOkATs+R5SUTuBnCPyuHGDlSgpuYySA/ANxT5y
         0AjfVuPlhQtO86Ua4UqJJ/TZMupQvYhOg3GTGRfSrfk3zcHm/9HD9FUyXqBqN+fiE4dQ
         mSBB5BlH9RyvvwQSAvL+1vLcTU0Q6bSDtu5JeaSyfhwMVlmScm0A2qv903pdnvtpawiu
         YxMlKHprNU4Pl+Py5arNGsOrx7/xOffJH51alNY0UgO+bHbD3Fr/NIVcINHWa5Q+612/
         bspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PGFryZNd38Zhqh8hnykXJyIhCnVJvOsmZjjsn+Xx4Kk=;
        fh=/dKmLzvyZHtoJ7hi8eS5AXj+a0czBJ7mU5bO39JS7dc=;
        b=TI6cKzdofPV7H4eynwzvOE1CzEWZPa8f0qxchDC54gjmAMuTfDgh7MUmaxMCPhfWIv
         LgS11X3GCXDsZoSYrqhD5B3Oy4riPBJFGVLWG7LSDcR0g9uzloF0WGwqEMpoUDQTuUr+
         Z8NE17BWAKm+8dksoJJgkPM9+NaiO7VCPFX9o5Mm427N74c7GqrwPJE91RMqDzuvVQwF
         pRq4xivJI0G8fZBysuicg4twrE8mU6oM6kr/5kQRpbAv1+uN8AxnsbimMMuwN9ce4qdw
         OBTCarhnZ419fGnNUTGIuLCeFOMkQwsPQYUzHeQoUuSh0uE6hQh6+e7HVb+NVpfQNbfP
         L02Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1793682964; x=1794287764; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGFryZNd38Zhqh8hnykXJyIhCnVJvOsmZjjsn+Xx4Kk=;
        b=FSGnN9euCc9ApPpIPO11jVmZ5B0lESa7Ydpi553D8AMywtGLGjTxy80uGxzB5MbGBE
         wsDmxZVI6weJS603WotaUcvaZeercfWdQkLTAvdBWod27m4nX/vh8KZgytWZkkZr9RP9
         aHlZOYKQ+11VD8F63mr6nvqzOTxEK7TD5J8RvG7tZkN3h67kCjHAlOHRGw+YSHKAz7my
         j4Hj2JZyAjzWEoD3IZQV6XU6wIeLzz0CrMdsFB8QCKx4yStdWTmNB9ojG/SYMxlLQutD
         Tu+d4ch0ncnEEfl11kbmXXkuAX0sBOhMVMsWZLtTDrc5s3Gxr03xihwjRN3WCVC6wxNF
         zq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793682964; x=1794287764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PGFryZNd38Zhqh8hnykXJyIhCnVJvOsmZjjsn+Xx4Kk=;
        b=xuEFWafZ7LxiFPwev4FWjKW6wYX+pdo3vX0MqjEs61nNDtSz/vtb77iqSQ8z9C6SU4
         O53I+hauWWC1f+LY8D8rGFwSCNufIoErydxbBAPty7D+YKqBoC8EAWl8Ecph0Jq6J2lr
         tENcKO1JKYpNkDG8Lo0Xhr/7JSaeKBC6AUjAJdPS8a9vhtyYt/Ngyr1WtA4WqjhuW2Kp
         UgSdV5/xQ1849cjIBhqn2o6sFAD72MyxLO6b44yJiJaMHrHiC/z4TX3134JoyF6j52So
         Oif4MwClPOobSSpRxpMTACwEOX+HCDFZGrVLNfB7aO4mFmjL8uikTIbzizzK5H6ZBc7r
         Zxww==
X-Forwarded-Encrypted: i=1; AKwUvBw2QRfneX+3UeROf6AlaE9bN32dY9nUJzwtDGvqLBVoViVxd1nGNOeShdBJD749TQ+PRI+y5KE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1U8Ey2hBx3VIRjcO5nFTmhgwW7aJf9mX4LfcnwlePwxmeZJqw
	8vP09J116lyoOwLlSv9aEkkad6Vrs7z1Gy7bADnKeMbL+U0fdIpdRo4jr7YRyDskGR6+AunwoQL
	Nb/FGexP1xu8rJbo5UJ5f/CD+87/5uusbMxWEKpcI
X-Gm-Gg: AYBFou0Rupo597DAJXuPkV2ag6ygVcZV633II3XholTsr49RgnQ0NBK/QH9EsQ4d86j
	/mEwclBGLxwZbYchZtCXKTDt4iaSc/iaHFiIetTmeCoEPjys4x7zlpnxEaJZzUra5elzk+Rlih7
	ok90yNbuAUjRfuUgUapuPcjfHEFlfisc/DOXge4DlbYgTM8mu04XLrOJnj8HoUG3eyFVKjJ/TD2
	tOGYVdQm9n7eIiYWfeoZHBuUcYlZPxNeKHfSajpp/ZKZGWzWCdDBUpcWzHPAH86jgge6VP7jBff
	XsDsGlQ1NhirvtuoIOpDd83y9Tj1LUdCtBHIv3lwRf3mJgb3gapNTuJCoaYupVPf0dEinczVSc7
	U6UOXOfO4Mf3i/XvHOnFmhqsK3PMNcDx2A0GsGPYgaFa+BK0mZzf2AP6rzt46jCp4gWDBYsM=
X-Received: by 2002:a05:6808:178b:b0:4e9:cbdd:457d with SMTP id
 5614622812f47-5640dcb7433mr8152707b6e.11.1793682964043; Mon, 02 Nov 2026
 21:16:04 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103034932.1790235-1-smish149@asu.edu> <20261103034932.1790235-3-smish149@asu.edu>
 <9b8d9f77-981e-4bcc-9d30-5c53a2c1d1b2@suse.com>
In-Reply-To: <9b8d9f77-981e-4bcc-9d30-5c53a2c1d1b2@suse.com>
From: Siddharth Mishra <smish149@asu.edu>
Date: Mon, 2 Nov 2026 22:15:52 -0700
X-Gm-Features: AclHuK8EhuIqsMApcRe1p4MKz2sF3pCM5QkPwADZCjYjbLoYzLMJZd77Dx7ktuo
Message-ID: <CAKpDGtmMzYinwYLF1AKbA4_kvpWS82Z3yWwsyo0-f0t1QknN_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: tree-checker: reject extent owner ref without
 simple quota
To: Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>, Chris Mason <mason@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 2, 2026 at 9:41 PM Qu Wenruo <wqu@suse.com> wrote:
>
> I don't think this should go into BUG section, but CAUSE.
>
> Again, remove the last paragraph.
>
> Again, I don't think this really counts as a fixes.
>
> Or all hardening would be considered as a fix, which makes no sense.
>

Thanks for the review. I'll send v2 with your reviews addressed.
v2 will drop the last paragraph and the fixes tag from both patches,
add the tree dumps you asked for, remove the comments, and move the
reproduction of the second patch into the [CAUSE] section.

Thanks,
Siddharth

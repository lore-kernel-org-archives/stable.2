Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.198
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793855338;
	b=F5H3Gp5MNuLIwHkUPCxszv5TCJMJjLvEwzxKaB58ShUqyowyl2gdWne1W8yzVuNIQ+dY
	 XsDolfJZGzoiOxMOvqZKuoR4H4YKArwm2BdXYvJdtjAIpTankldotC2mJKo+VfJ682oJb
	 fHLEBB7hi0Nxww+NXydpJT90ibPGZPR/q2N8iCq19Lef2k+oPbzaBUvLTxn6DJcVRTOpF
	 /zFT3tW1zX7dRhK35WP71C8/QMQ/cYMCfoowZDsPrR0vTnVMhKxU5rbOWrPBN9fIfG/cy
	 eopp+w4I0Fu9DrJ2gBdwwT6oANuN2RE9BbWSIrg0QSiYx31KhiTbRiQu0qGuTmlsSFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=F49mRNwIXXKoaU9d1R0TU/cMDFceqYMXuPvzpIRBwac=;
	b=Y0D+tQ1CJAcfhb7wh+2WW/68tHZSbM4pGe1bf2D801yuyUISkpwQZV9QeCi3o5NSkAZi
	 iY+NqylCn5ZgF65sSfA563adDJ1OwkVcRV7voUGDynYqBtUlBt6AsAiBP4HnVf4j9BN1z
	 v4Gi4rO4J/LaT5LLhFTQGggwNy9qO0krFdvqdLmyt2wJ1dYy1BJiEq0UE0nI9yRtsNBSH
	 x3N7c+gE6ybwxZJ3BUtWEeuDMNaI7EkDHqcdAPUw5tZE8B338PrUoccqCwARrhTn196LE
	 ZmYUw0/Vkzg7iTuk6Z0usKs/AJYF5Cd3gi31D/6W/kv+pes/FJZ1DCVcrfeOYrUUQIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZbcVMO+d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.198
Received: from mail-oi2-f6.google.com (mail-oi2-f6.google.com [74.125.231.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A4606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 05:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B14A4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZbcVMO+d
Received: by mail-oi2-f6.google.com with SMTP id 5614622812f47-550f311b527so629521b6e.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 21:08:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793855336; cv=none;
        d=google.com; s=arc-20260327;
        b=JTLaxjiOIEXUWCID480Tb/cmDhlEXyOEqQVLQ13JsQZuMWT9QWQP2qmoY+eQ8zaliy
         3B8ap0OaWn7PHXtp1d2JCaUQi/6E3qWpfv5n7JTVpv2cGcPF0GUVRX3JwzFUDPYeoTaL
         m2bgShMFlKKKEfjsfoCCFzzntItKAQsk5awVpucuPH1e3VZIc1ciIe+4rRIFZG6lMlTz
         My7qVt7exy4Cj+SM4QLkqgwt7+44TyGkO208eUsBWWNT98uJux52TzWr7EcjXdETGwqX
         ce/Angz8oyBEwGFgHZByTDpAqT/PwEeiUyqPUzoi1fuKfKuMJ1oaIHQJfyns1xQyvwx8
         fMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=F49mRNwIXXKoaU9d1R0TU/cMDFceqYMXuPvzpIRBwac=;
        fh=pESTVgf3wAhpqgHOnlDjHmRTLOPbW97xIh1UxBZlOhI=;
        b=eTxOIwF3B/Bzq5ymG1xDMY5LBRb6RO/wrnYF2YKHdk17kBGmPHXAtCd2k1RnKsWqct
         WiuwQ7+CgfZhKAAdUrT/xeDfTSftx282tSVahgGSvYZu18+OgB//6L4ih2wD9xYZrytu
         RT0/lsyT3HSN7bGzD16t3aMWy9VHDOftLPloCMFLvWH193Wy3xqpV6KHMSLq6nIun1Mp
         zsOMW5VMkdDTxPOiIEXwvA8uPrR3KV80wDEfsI2CpE5OUvVsTqvx00aNm0eKn2Yts8kU
         VML6aOrj61rESq1Z9jCX/YjuO+1S/33Pd1jicxyETNpsl2m9aq4Fos13g7ecuQ6mLr1Q
         CuDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793855336; x=1794460136; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F49mRNwIXXKoaU9d1R0TU/cMDFceqYMXuPvzpIRBwac=;
        b=ZbcVMO+d8qwcr+LjKwI1ovUtnV2jtZiGCbR5yVtezS/VbJnmpZgAhibdGeCD+/j+b4
         ROiLVWPNDPF6rQsv1L1xB1tg1yDghKBi/J7RDgR9kIRH9qFjhNTNA/adF0iE88qheNyR
         t8jNAFy2uFAZcrG7qNhqs7/mXem6in/7z92u26l8SqSXyBwrMG9VN3I/oSQr6V7hHe5i
         qCeDReNgvmU5Z26E9wlUDgezEiILY6BVPG2Jv8SftgJfvUmyC0BqRMYna0rWr8LQdyqj
         o3HeLuxcTKSzg+l1U1SHMkD/wGN/t/u6+nKkNKfUxyD7E11Kr/HZFeQN8TrWpZMtQCoZ
         C6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793855336; x=1794460136;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F49mRNwIXXKoaU9d1R0TU/cMDFceqYMXuPvzpIRBwac=;
        b=PnVvb2oNzKx3UwN82uJTmaNI31lgUviQzCa1KAg5BLs/MpHfF3JmtpT918UB4LKuAR
         67HKzHn6oqGULH1XN45q1Vo6Uyw2+FPGkVVqgxmyHYY0gJeGOBuZIEXaE46/vzJP8Mg2
         mkRB8HhBGVLy6DB3ldEK68lws7KCp00QF3lEtGfubCR9IdbIFQ1mrpl77ro5TLt6VgNO
         3jmH4o+eVoshlmeiAnV9Spdnrmv7/Nw2lSjs1FbohWRTs8BC+OeP4l2sYFwe7wovpHRC
         J1KB3wB7ZUjo5YY5xn+ihfhn91ePdx3UFURNvZs83deBqR2hxlt4/lsyVEJPlSTKt/I4
         Ef6A==
X-Forwarded-Encrypted: i=1; AKwUvBy4aMmzFZl1Sf35wyPi8vlgBYKBxjoTshl/+n7WxNAMlmCl/uP92A9ZhWT4pPCKCpl2//8y4E0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OVl0xeKqhRhKHl+74w27G0coMnp3bkn1xYMXpyO0MB2XbiGTW
	EPn912Huy8AYIU00mDDBKUqTcmknE//e3VFCdoJArC5KaL3a/SoQOeWUbsEp+R2GHWzTT4wAPsX
	UrwN9CHuZUMIN7HrKmV+soZAtMPvmkBg=
X-Gm-Gg: AYBFou006k8TBQPvA35IpatUvdy2dkhsrcbAffVqBKVi6AtvcPZCBTpOfbmmvQyy5j2
	kaxjtME4Rvspncy/TTn57vMDBLZy8Ommx4Qi2eqyDD5IiwazWRklk97dMSJyWa68hC5GwhmGx3V
	nLsn3qdQeoDKqa4T0ZNiTBJUNvugE0jEFghu5RG5bIaxpPT8BemmkhyCNCkMNAsz+4rAw4Gd510
	jhFfXdUcvhhTso0zc5YajTrLldNftviEIgDLB65sbF80cBsPCCZX31csADFDXbytGmUhXdJyPTh
	LUjW9Y85MSmihRJ8/UZi0dxpDttW8ddbXRuDkOrBlhVC/SfIGg7Y15WmXpXzXOYp+ZQ97o8RAz4
	zON9tikWSsJs+n3EAehzFlcuEpdGddsCuRuejWq9bRHgaAJTZRV8RkZDuK6c1KovKTLb2MOd5zp
	R0OSS7f4rlFRYlnQau45IlJ6dANAcF8YoTVF9AdRNkIHD1I8oJqK62rIivsYnBzpoif101kgSew
	0s=
X-Received: by 2002:a05:6808:198e:b0:4d6:9293:9b56 with SMTP id
 5614622812f47-5640de2e892mr13926693b6e.62.1793855336421; Wed, 04 Nov 2026
 21:08:56 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104191355.89544-1-dennylin0707@gmail.com> <20261105030304.ukyfkyh7xf66yf7w@cs.cmu.edu>
In-Reply-To: <20261105030304.ukyfkyh7xf66yf7w@cs.cmu.edu>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Wed, 4 Nov 2026 21:08:45 -0800
X-Gm-Features: AclHuK_8naWfPmbeC6CGznX_C73hXCMzOor5rRkYJ7y1u4psfW7icnRznn3rIJw
Message-ID: <CAGEkeHfnyyggAXOUy8MW+UT-B7FrG9sPWcO3CNysA=SwGp0m0Q@mail.gmail.com>
Subject: Re: [PATCH] coda: honor the append state of each write
To: Hungyu Lin <dennylin0707@gmail.com>, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Why do we now have cached copies of f_flags around? That sounds like a
> recipe for getting things out of sync.

f_iocb_flags was introduced by 164f4064ca81. The VFS initializes it at
open and updates it during F_SETFL, but Coda's direct modification of
the container's f_flags misses that update.

> Anyway, your patch subtly changes the container file we write from
> cfi->cfi_container to host_file and I am not convinced that is a safe
> change.

That substitution was unnecessary for the append fix. V2 keeps
cfi->cfi_container in the write call and leaves the existing i_size
copyback unchanged.

I traced the container reference from coda_open() to coda_release()
and could not find a path that replaces it after open. ACCESS_INTENT
does not return a replacement handle. The container's contents and
size may change during the upcall, but the existing size copyback
reads i_size through the same held file reference after
vfs_iter_write() returns.

Thanks,
Hungyu

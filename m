Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794767296;
	b=LaxVKa3i7qkUZaKgFEEAhLhPT4z9wu2iQUoS6Mz0ekTa9TEOWuO+snm99xCnedymR8zI
	 ZCSE51zdiA2NZ7JjDCQ33665hjjH6iYvinv8qR5fYlRjUzD0ckNnzatA3S60OoAN5aJpW
	 +/2YYTklRC2KWtQBLjBz109OvP/OjqrLWz5vmeONXUbyyK+K2wZRmemy+cMFk6YWxrdG6
	 U3PmJoOQc7JAg9R5GSeTFAlXdfDpCHW0r8U63QwCiGXkGJsdVAiKrahCjit1CxM6rVHPd
	 HCvemF7ilsbVgu7LzFECtYlCnxWYWVDO1p1U38X3rQ4iVxV8AWaDi6O/W+8JxhHWW4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794767296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
	b=o7F+d+lWek6KyVvmOrlcwFCBwHb1TqoV8/3AHaEMxLbqtIGzC1IqSDVSQapRiYMJ/FG6
	 KMAV+vPc/9SBQCDqUQiI7oGT7hrgKmReQK4GFf2SayUlqduZU0BfKHaRkH5BjwYdqCgr/
	 90FgI5W6g+fp8YIq77afjDdb29Foa7cKV5Djieitgy/x/xPJDSgEZA/Vtg8LN2sWk5GTn
	 d4tnJFmKjEGcrF2a07JjbtofwVFjISXLr2ic/X3XaLKF/F5pID8XGBSIb4ZQIuBUjk+/q
	 GQSoTyXcu4PIjuQxH3HSziIsoDm9Css2z1+/018HMcsVZtFimyr8Kop9Rr5HdyGdz1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBV5nxYv;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E074606A31F
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 18:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E074606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBV5nxYv
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1223949b3a.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794767296; x=1795372096; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
        b=HBV5nxYvdpLlRvsxsYLbFKr5P34f8mj9a/XJil7dVolrFQomVVkyecHxP6BgFGwDxs
         /19GzczoyqLC7fuxmwJyN2rwUymD2CerKLMnjfS/2CRMvt+ynLs5gkxwuVBuAu3q9J20
         IzB2wBplZLjMFwEGGW7prCWCSa7Aywa/5h22qXYWy2au5OKH6AKODohFFnhhSeGrFYHI
         n+FqPiDDYHHddi3JAW7aghC+X3tcMJhczYrIX5Hp62B1gpJjhhKWZLANouBkWkfFg5wA
         r6zaGmjBjVlFtwZxS8OaoxZbnmYU5uIROK1UqsDLBtdOM41dsZCnP9Jsrl/zETDD4H/q
         kP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794767296; x=1795372096;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2sqyuT4GDnGp9+dHpDjnGTvZCe15TFZq/xtAkotKkE=;
        b=pZWOyncbBYBnMryIlR5wAlP8eckLE0OpDw6wmAd2aZovYuCLD+uP1gWH6c/WQavK4S
         p9c/ebkpBqXUfvVr2TWIHCnZYmPwxlsTXtZKSLCHZ0I0khL81DunroApkSMDnZGOR4Eq
         a4xUHQlZXKFe+ITRYG14d5lBfjH/wr/J5ShLufTMMFSdX+APNSYZkhzJ0oAB3XmhYi+y
         yZlbbbpiq3iOLpV+EMG9pNGj115S1Q1IXkoJ1D4jA1vhATnw97Dcg+3MZkcFNRt/nnG8
         hPllywKUo2Y1SwjBXNzg3FYEDBf+NJG8jcTmq8TCacN9Bc2PYL8VM+iIJYqsvRi9Tobu
         +hOQ==
X-Forwarded-Encrypted: i=1; AL+hErGdVnIMTPkuKpzAQEavUu+u9EyLn29zEsGglCf3JnqY0d/qoFCXPxS58+zS0c0YzPWvwhVepN4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cgefPSFQ4w0qCQs4oPNCvScONd8GwvB09n49adcEdlqGuDcNV
	JXGco+NAbWjWY9/hQjTCnQD1ieCGRHiSXbqj3kU9r5ivOGoxdMco9By5
X-Gm-Gg: AYBFou0UOLwEnVfSDfLEDQ0PDpZDfTBx1ckDJEvPMyZKiO/0ubAAXU7OtpQSckx0iAM
	oH51bgPRHkV6QiF57pB4FH6ACexN/JX7FTPQ0Mj9ykUOLFNLSYUE+KQ9BMWa9kmJ2vZw0LPuzXy
	INmXrC8/mT90ysY8GXcv8UymBzBus4OO02GQ/HMSAEGUOPK5/u4GK5VNgdUPA0VhA9r6FaLtseu
	J2HhzN4WCbBs+RAewN/vOdqbiUJFMTsQ0MnJTNdS3BKrghhnvSYjJMeU7YWLPts3whD7eHFQyo2
	j/K+DfeXmdBTRblrI+1yOd38tdPRhYetSbE18Gm8whpyWuf3BFtJdyZJkxkCve3PHGiUe7nHN5n
	oAtIwNU9HHiwTq1PJ6VQSWx2g3PP5hMmb5Rof5LYW9EPwTapYgWQKsmbNzXc1ZZK9WmbPc/t6lL
	lFXnbNLh9pyajfZGPRUIfuK8tTsvFm20fcEJ4lR1E+muq1ef6k6spJGu2ySF39Q7edwYu425Nox
	xt5/NsGWPbEYr7Q+yjDw6tkXAccrCg3X/QMwscDUx1FFQAT/F+QJplXVOjB+4I+8LxpnKcLdQbv
	m0U+81KnUgVYTM+zACv5j6IPrHGHe7zVldzY8blGuzY1Jwdvyyzs/r8y0UVRucp4UTU27cH2et4
	BHi5XnzAUkWnyZH9oHkNbLOvF1uxSL0nT1g==
X-Received: by 2002:a05:6a00:230c:b0:89f:d620:226 with SMTP id d2e1a72fcca58-8beb619bec4mr7100607b3a.24.1794767295502;
        Sun, 15 Nov 2026 10:28:15 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bececcce6bsm2804318b3a.1.2026.11.15.10.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 10:28:14 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Nov 2026 18:28:14 +0000
Message-Id: <DMVZWOMFDBX6.3HVETC9L8RUEU@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Amir Goldstein"
 <amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>
Cc: "Chris Down" <chris@chrisdown.name>, "Miklos Szeredi"
 <mszeredi@redhat.com>, <linux-unionfs@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH 00/13] fs: let d_real() fail
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 15, 2026 at 06:01 AM Christian Brauner <brauner@kernel.org> wrote:
> As Amir pointed out the correct fix is to teach the callers to deal with
> an error. So d_real() may now fail for D_REAL_DATA and all callers
> handle it: uprobes fail when they're created, IMA treats it like failing
> to hash the file, IPE denies and the bpf kfunc returns NULL. Then
> d_real_inode() goes away so nobody can ignore the error again. The first
> patch only drops the WARN.

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>

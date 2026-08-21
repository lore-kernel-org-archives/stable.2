Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CF83DFC88
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787338206; cv=none; b=J33TQwdM5/4ILvkuvPY9YtIeUGNzs6owOnsjG7TUYLjRBQ1kyYbUxTeHTjXpIp0enyYhpTNRN3PORkRRgcL8n0yE7EWFZTcYXGSv9tlSyL0zt6rYHIG8qkPreOMtMWeEPApwGMmJHFAMB+a67eXWwoKVH2nnDn9EreOXWthwV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787338206; c=relaxed/simple;
	bh=w8OhNYTb3BzPB5ojbe4bR270KT2CKHlLbR/449Zb6fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ul0V/Yeq3DQA70WMwKwHskSXylKc1et807p8Hxwn61kym/vUKmP5Aj46gYb3dEIqLpbisHcRcf1QwTzaCfuPQxX5om4aYaPFw26Q5cCYLjOWLyUFyNWfuUIMc10iKMwpNW5gZQHvPHUfNXvKTcGqfnHP1zVGGXvFdhvQDJKw198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EABabr52; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EABabr52"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38101f85591so1963591a91.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787338199; x=1787942999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8OhNYTb3BzPB5ojbe4bR270KT2CKHlLbR/449Zb6fs=;
        b=EABabr52Z6dwp3O5ofknzIhIb9UtwG8PSiVmkRdBGFIxGHdbEhb8my1sHuSmEMk7wj
         OqMad/QjCK7J7xZ9OxLxDVibiy+CwmPyFWeh4n6TC8zoq75HeAE6Kzd/OL5fxTd0UC+S
         217tSEi8xkcQFb58SE+7CjxekSzBp5ykSJtfAKsFBB1IgclPMV/7z9UCTNbamsUOto9l
         lHOrWbvLrUU3r/wdW7je3tKtlXKGPdrXCSSIMPe3nbmN289GIk98vYt4pocylvV9L7JC
         UH8WPVbLTZwjiVPeYWiyzzZFL7cgQ1G6b6AEqgX+c5mXllFo30MB56w4w07WoZzzR4vH
         Vr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787338199; x=1787942999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w8OhNYTb3BzPB5ojbe4bR270KT2CKHlLbR/449Zb6fs=;
        b=Ecv4mDQgrcsM1v8bQHUA4qhQw7CDxTvSGEhVxtDdBuyaNoknr5ZjTfgbiWRfVqFgeH
         NG0eiVi1cvtazMBanVtbvsH+lAkXXfq9/6KhEoN/NYWZQUdvIfhdS7U2X2hQ1Ix+nzZ6
         DE70uYFjFb7k20cYNneOv1esbm/89QoGcP3LEyRCfa4M64jj1fUVqhnwScl/YLRCZnhv
         8dY3C/NwTDYf+3VCEvrzotEbdQbalxpmno0I7FgXh+VhOIQUJ9w6c2xkDhQ3HQAQ5K4x
         FmUg98HyXQsETCLcC2fYci8BBhlKnmph8Zdfo/XqOeU7Wc21MP3mWr/4Z+VCzzXDGWH4
         b84Q==
X-Forwarded-Encrypted: i=1; AHgh+RrMwJxhwBMdLH5MeeviD8Y107/ssMYt690lDHB2YcCSBahvuCf9TlsLISLu6SPXZ4OXPI1eknA=@vger.kernel.org
X-Gm-Message-State: AFuF++ny17AMjLcO3KBk1+hukKfC1dPvyJJn1DWZ+RBHPC/pkROlqqSV
	u6LbTzVHTAmpfOPfDPyv/LayQvix0aoBp/LQ+KI6L4QtScPzDQ3ZtyVQ
X-Gm-Gg: AR+sD12JYMkefaTA38TjbL4YxL54O3JoFS4+xSnOVeDTsDUuNJFzzCjwvWCZ2XxskCS
	QhMDzomvhi6xvIcIxXyOi5PVK6petvA6Kz32JinKRlVFfiJkfFvGdwbU4ZxEr0Jtwt83yJQ0AIS
	FYd66e4RoFGjxz5Uwze96d619Hbyh9XhxacEsrQcIq48O88lhX2oFz3Qq1nGfdXdNXQfWBLedtA
	wuAXT1LWViuKYN1Pbrv50AlBTAs9XC3D/NMqPdMUhQbpDuiM36NLkyWL0rk4U3EIXeiXhYZLN3N
	HGO9fSfTlhKcp4PuKknY7iHuZVZwHDs14mCqFmvOwbZ6Emp0Yr1F6fnmZ3EP28tgXS5s+ryNUWQ
	7zXMERtl+mKVRL9AR1CGyc01+Yxt76soPSe85QqhsLx4bkEzVnRTZVznrXd4IMiGMfMJPkamY35
	5NzDIc0ekuQi0kkbXH9bESlSN5ZIcq3Y6O2CiEpv9brzpDbbCMw4JIQ+cESV2xRpXDXCd8vQexw
	1cpSccxSoSpgK8b1gehQanO
X-Received: by 2002:a17:90b:3943:b0:38f:657:6823 with SMTP id 98e67ed59e1d1-395c50b43bamr7549988a91.8.1787338198788;
        Fri, 21 Aug 2026 11:49:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:a800:1010:54e5:69b5:423e:871a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e14b4283sm165982a91.2.2026.08.21.11.49.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 11:49:58 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com
Cc: AutonomousCodeSecurity@microsoft.com,
	andriin@fb.com,
	ast@kernel.org,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	horms@kernel.org,
	kafai@fb.com,
	kuba@kernel.org,
	kuniyu@google.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu,
	yhs@fb.com
Subject: Re: [PATCH net 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
Date: Fri, 21 Aug 2026 14:49:43 -0400
Message-ID: <20260821184943.867-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CANn89iKr1ypEFeL+7te3xWoNaK5AFyYQmr+pDh2zSZAxfgNKjw@mail.gmail.com>
References: <CANn89iKr1ypEFeL+7te3xWoNaK5AFyYQmr+pDh2zSZAxfgNKjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review, Eric. I will send v2 with the data races fixed as
well.

Thanks,
Cen

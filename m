Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95B3749E8
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874644; cv=none; b=MfTdhuog30B6/5Ak/Ifmj5ig/eHbsTq1TbX1pTxFejD7mo4SppaHvkdFurRq51hlkT5FOlgRPB2SaSfX6EW6dXf9Tw5616U1Yrj0q6jwzGNRWmigicpJxejeLQcxS8vKKFWUxdvWcgRfr9uD+8BOHkiE0fKHEJFGGk59dEOQ61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874644; c=relaxed/simple;
	bh=I0w28eDwn55wNUcSFkFqUL0WZNi+JsnEzbOiyxoDOZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1SC4LLYvfbaV/XqcHsHmZCy6BOW7DZOR9sTX23t3AhXb92agkxP8cTODcWlXiZJ68fcPlDtkp03xXVmkQL+siVZxkumx37UL1iwxlbRdm8cMprDWpLy4378Yd1dkFs9EjMjEAdphGsr0Fe2/Bd2rYTSFMJ7K4CcqknyUA1RPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2m3tXfu; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2m3tXfu"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66d146f04cfso937925d50.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 16:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874642; x=1788479442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oDf2cFz2MJ91PpGfYzlKTBbzHYxayWBZgz3Ltr8pzsg=;
        b=i2m3tXfuxbRtRkKd+HwICRWj6nH3W+zCDHcVezGriGsdAlrvO1A1fJ6YTqI1o2yxrM
         C16GJDvzrUcQMaZlGLLnIZfnSYibk/aH8hgXPLe9BlozfkuXFEMqwdt08THg5fJEtHbL
         hNlULDQ+pMNzCzO/jiJEHASN5qQu5oRA+BnooZTrRwSenGFbxV/Vs1mKuWEcxXYnKUw9
         TFhKJCIkdTD6IOn6MD92GvwehV9sioXVgOO4NFXq5/Ef3pNStymKNwx8zvb2qteAzD4z
         z5R0snxAVUeRzJaRJs8JRw9ko5HvkjTO3sVovTOhbj7FD7ogq+Bodnsouh2deSv39PmZ
         0ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874642; x=1788479442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oDf2cFz2MJ91PpGfYzlKTBbzHYxayWBZgz3Ltr8pzsg=;
        b=UjKtUveM32gvUpaFRzbCZSjlh4g/OgZ4zIPkj6ivvVWiPwUEUVXWe5cpCEbpj+y+Lw
         rqV1M4tjBvk/y4BYgGzwJV7dBt4HCPTT/MWh3X40gvo9uZXto15FzmOpcJlDX6uV9wyy
         ExImzCAs5eYRYI7q+8/z1H6E9ncxpjY4OXV05C2L4yhTGYf7GFS4IHEZgEFm8kSkb9fw
         8ePCmI11WLdwJGD9VSyzYM+NPWbnOeiZqu+PE20zXEtCFxNVF0ls0/wb1XSDM43Caxxs
         e5go04K0U9MaEKsQbUw0LnTIrius905SboJT0BGz+GWOGXRc1WyYQuQWQ7U3sJ2YP5fX
         uT1A==
X-Forwarded-Encrypted: i=1; AHgh+RrmDZ8OA2mJBdKTwYzhRPaS62H1i3tKjAyP52FZvlVggUIDFaQKeNHX2IIK7fTPDryrg1GF5A0=@vger.kernel.org
X-Gm-Message-State: AFuF++n6sc1tApAwM9eazaMFmCwlahj7CVLl6JNLaY7hJ4zUuyfz+eRL
	K8VHV3LOfWDKtN91ENmMvFG8rtIfms1W3ShWQxlzyhYkbmfv00YZRP+p
X-Gm-Gg: AR+sD11rrlfrCY/8Kbn3PlMNFdgtPlEI5Mv2iDqOZde/paBCwMEOe1beLbSO8VgzaPW
	inLClsh5jkEaI/bjIcW5oZLeV96dsXL0i52cs28e3wxTXNqlDf8fagFAUqKY8IsmBKO1WTBT1jw
	oXF/k/t9WmcN/NBl6tQdSYT2V15QCiwGK4DuCgroKckywfE7am2mrNLR3ZQCQeB0mcpkWVDJjnW
	UvudWIk7Wxtemd11KeEctylNEtf/x3l3pKAQqogVp1HTLktYMIs9jf0SzeTDDJFAO440LDSU/E6
	4xXI12PSCOWoE2qEkol4ik0pS5ncckr4KddbT3giKqOk6LF+LjwL0No/jGDuLaCUNljyxPSJdao
	EPPe4ZgjHX4/u4A3aBUhpNkmtQUlKTO/XDVSZ/WDWgiy+Rax1Hbr7XxrkDuW9uTloGkZx1jRsx9
	W+NQChwpXzPEFl+sxdaNtXKJuox0Zt58A6wmeYy7mLNdW+iwXUp03zfvJWCN2my7Ni6OrrKnZi3
	1Fv9Q==
X-Received: by 2002:a53:bb4f:0:b0:668:43a3:9db2 with SMTP id 956f58d0204a3-66e4c522f11mr741772d50.32.1787874642003;
        Thu, 27 Aug 2026 16:50:42 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4eb3de54sm51533d50.1.2026.08.27.16.50.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:50:41 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: matttbe@kernel.org
Cc: AutonomousCodeSecurity@microsoft.com,
	andriin@fb.com,
	ast@kernel.org,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	geliang@kernel.org,
	horms@kernel.org,
	kafai@fb.com,
	kuba@kernel.org,
	kuniyu@google.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	mptcp@lists.linux.dev,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu,
	yhs@fb.com
Subject: Re: [PATCH net v2 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
Date: Thu, 27 Aug 2026 19:50:39 -0400
Message-ID: <20260827235039.82217-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <1db6cf46-c3cf-49e2-ad97-752afdd78c00@kernel.org>
References: <1db6cf46-c3cf-49e2-ad97-752afdd78c00@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 12:38:36PM +0200, Matthieu Baerts wrote:
> It looks like you (or your assistant) forgot to declare ca_ops:
>
>   const struct tcp_congestion_ops *ca_ops;
>
> Also, I *guess* a 'rcu_read_lock' is needed in mptcp_ca_reset() from
> net/mptcp/protocol.c, above the modification you did, to get the name, no?

Thanks for catching this. I messed up the local version and missed the
undeclared ca_ops. I will fix it in v3.

I also checked mptcp_ca_reset(). It is only called before the socket is
published (mptcp_init_sock) or with the socket lock held
(mptcp_disconnect). The ca_ops->name copy sits between
tcp_assign_congestion_control() and tcp_cleanup_congestion_control(), so
the ops object stays referenced and that read is already safe. The v2
WRITE_ONCE() on the subsequent NULL store is on the MPTCP meta socket,
not the TCP sockets these two UAFs race with, so I will drop it in v3.

Thanks,
Cen

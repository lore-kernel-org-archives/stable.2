Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA43DA7C0
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790722787; cv=none; b=fYpvNdIb8jIFaRl3iTSDVb6r0atrUlFgUfg/opGVirUEWr2ZgA1qChqk8x/xJYwvHx8VcvqGye7pcRb9WUkfkAcibDSrvwaE4bOQXqDu/H4oYCvUKBkv2MegwFiE8c9jZ2AD8ME5GoD4vbjyXTG4eGyofIv2hp2ozx9L8jGZ7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790722787; c=relaxed/simple;
	bh=yciXXgFMGDVOMZPQ+5IrugMojC+KS2xZdRYXVl6T17Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8U2iWOh03NyAPbUSFgJV5aPp66tjrIl/pD2dwoLLWZmbv0zqgwpKfBWbFWqO9Cp8ZVqaDat/NP2G3fk/uVrFel2qx+vpDzB53+fbAaNy5E4L4GNM45y+cQX0qRxu4DfDjC5Ass9hXd0XhevbNfEvanTaaBDX93O2z4P8pXC1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcTI2Fci; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcTI2Fci"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so35625205e9.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790722782; x=1791327582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Gv+PysJI6ddPMh+/2D1kK5GEPdkeF2uLZFjE2FJN3E=;
        b=EcTI2FcitOqfphbCCL7eny8bTwBNKzWtYEszT0bkwhgIHJ1SzSNyf2t8xOg/lp8A3+
         +w5Y640OqMdr3dy1rmVWHd9a/0P9d96H7aln+BuA++Ntuj3yF/8hJQUpdIGZFJB+VWdF
         BR5D+sboZ2cQIK6GLFQRP4dHmE1CLdnqAA3MRxkmMCGWHaempFsFKYTc4VwzyXwbwaQ8
         nVXBahy3dXLG/7G/+Dbw50YwhCoTImDlv/sBu1xpVlQRPGSuuHCd+jPf8W3mJ5yhXsKu
         xxH1W6SFPgq1b+VHd34+EZkZzlWhMX5Nn8fXvXEqLDcUWojQD3BkGZTdb5IAf/x2DZHV
         hVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790722782; x=1791327582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Gv+PysJI6ddPMh+/2D1kK5GEPdkeF2uLZFjE2FJN3E=;
        b=fFsGIoLg8p7gs6rF/gq3SHa9YdZBTbznTTIII4bfzzrDiTHHgGezBDtsGkK/hUFZNo
         gTeSntb8ET8ZQC+YSDCBJbQpAe5UlqleWQsVWb2tCvmOiJQEnCpBQ0ox0pivCik69uft
         ID2gxXyVus1E6vYuaRytGuEwHerSvEBQrcN4Wxatmtjl8Qep15ZNZK9G+3z0PEKSBCrY
         PvVrQhNsC1Ljj8/YE45inlhoSgJLzfvD64YM+tKe4YUqUr9o0sGtpmlcT1YaN8m3xIjt
         d7eEj2c+2fsrwQfup/4iLp7ugKPJW9p9RbqTeGk+Z2BLFZ9ufWw64hETFutkY6th73uu
         Anyw==
X-Forwarded-Encrypted: i=1; AKwUvBy6oodUiS00jnIzUq5KtIk1wN5pqA3Zwb+PN4hnN8cVoEshaKnSxnZeQzMPdJTbKkcuIkUopT4=@vger.kernel.org
X-Gm-Message-State: AFuF++mPwGNA1cyibWh6qSh/+CLAa0veNuEscRh3NqRS0dPTP3vrr2nG
	9pPU9ARmZSngcCq4w6pJDOC6Y+FUJ5eB18XrgTi3hXRqa+EcDU2xpdYA
X-Gm-Gg: AYBFou0G+Zo9C8sjQlf7FNmbXp7N6XVEwhQ83RS027wUcUp2GKx3qgoatO8pzz3479c
	6rN/Lbk1E918xPP0FH3FzWAAGtJF1bRrZRQ8zHwyNl0Y3TfKjzlOG/3xTCpFFfUqLyJYr+k1hwV
	LYBWYy68DNfifW1QPl6y3o6uRlqS9OjG5OscdZR3YH9lglqM+hL88mkSHcjLiS9WV4Jz+8aFdHy
	JizsxHo5p4orHVRThh/40YkBiuPd3xjLmgqeGC/JXv84RL8MlGa3NP/Y5BvfuxsTW9T3e3rFBQX
	ZmJ5lujU/QIOCa28yUf0OMIQlA+Ini4SmikNJduBwhbh2TtDygusO2GA6aXnf/D0VeYSUyZno91
	qIh8z8yBgaTiGd1xiZlReC+3YzN5nkVi8z8DUHr8UrTA/LwHySQ0mU8R4NE60JN5144pD1Sv4eD
	nZmUYOumy2DCjjr6T7BUEZHRjeXb8kdbL1uEUCgvb+SEiBwxCXLMvLr2ltWeUagnz1Xg6kFlA9/
	SHiWDd84FfYwAl0jEYScB3Y2Vdpvr0ImdM6mO2PsJ/A
X-Received: by 2002:a05:600c:8b38:b0:49f:fd4c:cccd with SMTP id 5b1f17b1804b1-4a015146b71mr8103765e9.28.1790722782234;
        Tue, 29 Sep 2026 15:59:42 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0174e161bsm2551225e9.5.2026.09.29.15.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 15:59:41 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] rtnetlink: wait for RCU readers in rtnl_link_unregister()
Date: Wed, 30 Sep 2026 00:59:30 +0200
Message-ID: <20260929225932.349581-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAL4WiioFMQN4troVjQjCmE6Z9kwwb95SnoEupjD=PPSK6Q5f6w@mail.gmail.com>
References: <20260929170444.218093-1-parri.andrea@gmail.com> <CAL4WiioFMQN4troVjQjCmE6Z9kwwb95SnoEupjD=PPSK6Q5f6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 29, 2026 at 08:01:39PM +0200, Eric Dumazet wrote:
> Patch looks good, but I would probably add a comment here, because all
> these barriers without comments
> are a pain.
>
> /* Wait for rtnl_link_ops_get() readers that found ops but have not
> yet taken ops->srcu. */
> > +       synchronize_rcu();

Will do in v2, thanks.


> Adding comments for the other barriers in a future followup would be awesome.

Sure.  I have a net-next patch ready which comments the remaining waits
in net/core/rtnetlink.c: synchronize_rcu() in rtnl_af_unregister(), the
synchronize_srcu() calls in rtnl_link_unregister() and
rtnl_af_unregister(), and synchronize_net() in rtnl_unregister_all().
I'll send it once this fix reaches net-next, unless you meant a wider
scope than this file.


> Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Thanks for the review,
  Andrea

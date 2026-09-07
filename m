Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42BC40E8FC
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764766; cv=pass; b=oxxEHNzisU3rC4L52it7DySH3+W9iHIjGwPS6o2AZhwc4XkzywC4gt6q0Ba8NBNFKn8PTxa0KFMnb/J69iYsd3aeUK1I3LledLTb+jVCzT/GqB04JM0ZUos4aeubnfW5uttxdNyBO0ohYlVq/Aqdb/G6xj3UR3S8eroePPlcrXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764766; c=relaxed/simple;
	bh=J/iKiNhcMgi580dPsKQsRdnOhMrWs8rCz30Zn7cW2ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdFmQELa46ObKddIZBj9FRqg9iddVXRl4gU9/aJALx+ZlRZsqLiFDlPzwDDVtXO9KiVE0xMg7cBKOdCdd3m3r7rl6p7nMc4aEfss5H/v5YrzQkM7iCcE74KeRJgYGSf8tZcj6d9GRzNtYEXSmOjpWLN5kew0Hubzcj9rWXEAtR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JbKLwyC/; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbKLwyC/"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-90cc107c451so19965576d6.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 00:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788764763; cv=none;
        d=google.com; s=arc-20260327;
        b=FlBylxbFqpuuZF0XX4SBabcm4qmkDpP9k432YMwL6a4ArUUM48tE8flHBR7dpq1KDU
         ZU6hpSYjuPijg8dkqzJSa7CQ053gj5CL0dBE7DWgzOLgDbJ3ZkXfQNU1A/dCBplPZNUD
         1sPRzFo2Y9eWjqweKNqtCzRwIxUW9Fjs/lXzECA3r+d7GtvFzWC+loYnICZZTCrOESH6
         gy7q4Cl6pa04VHX7UuO0WhqPKGCrD/xBcOiy//U573W041xO7k7iwLf1Oz17Jcod7JlC
         pyN5e/y/p+eE2Ctw9I0y+nwtTWKfAeBbppYsVqHfNwDAi+XhFy+VZg26Y5vjr8nJD075
         TowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IzBhMBKiowEdTe+IMHog+Eg52EGA4098JFXUESCuu4Q=;
        fh=TTqhb7TI7/Qf+jlmOiH0TbsGeubEDFR9KrI3+g9Ikcc=;
        b=E3Itc44zRIITpPSNLnPvnn1FTaen7qjBjId3AlnH56bhK4swq80Vr6ETLsraAGUUua
         gJuATLBcVOpTXwL0SBODT1vbs/WR2Ttpv2QKfkOef8MfWTCRYIqAIJcGNl0f/6gj9kbo
         wHSX58FPE8OiLfmg7sOxxEc3vqHBJq8XapyeO9aA9IaJnBLyrvyreQV2iP47tWrbRmfy
         j+llNQgaxjfeyZbvel3CykV8F6g2nJeL75nrnmFlk3ng9bRi8E6wky7ZaKBhzOtM4sH6
         9NLKqQyZegNL10OGjFk/sGFpcOddrQw5YRd/w9tdmzkBKwk919W5Wt2zyCW41vN17bXG
         GUzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788764763; x=1789369563; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IzBhMBKiowEdTe+IMHog+Eg52EGA4098JFXUESCuu4Q=;
        b=JbKLwyC/SxY/a6j5XV0CQxBYNRA5SaIrYzjN4sqmd9EUo0dSSVSnviGZf8SO8nuc3n
         QXO+/i+pEGzCxbnWtWgTxPaOBuHUOiY7dejIqMMfgIkzBG8ulW2nOXgdPw0cl0hKpdiv
         8XkiGKmuRnQvQ1ZWHYZ45Z79swxEaDQAn29Q+LTQv4byVvnKYO+Lyp803klt8lWWlFxy
         C4u2THJGYUPtSXbkrTAhpguTd8JQMpjUBKkiWZpdVi/h6Vuqy7KdEWMeQ5vAjTDT47IV
         tAAcC/vsyPe8V2+fr84WHEB5FoAs9/ZRIeGwtsRb78CYOlAt4I5o2iXyCXTl7RL0C9Gh
         tM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788764763; x=1789369563;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IzBhMBKiowEdTe+IMHog+Eg52EGA4098JFXUESCuu4Q=;
        b=aHXOWwiz80Z8Je2VPtReCuLi4gLj9bk2OQkUg1HeIKjEWu6BK/l05H4g/RxwswuFP9
         PNw9cufBYCj5o/DxrHi8MxDb/XpAdmt4KdguwFCAr0wjVmKFJbMlU9FHQQaQEIHfBv/8
         p9kmJD8zlJ04X7ijVX608uNdnpVBpUEQkza/4tQRoW7RR6lpPQj4soxx+abc9Mk71Rw/
         IrbPTqcxQX3ifk9AWSqesP/9El31bwWBsqVUxp3MypnyjRPftWM1iYkML/j1vtNXEOhD
         mC9IrvLFg6uqOKFlu3Fcz1OhZTTpf4Uic3oGfo2KNknOo3j5a56FBWiWAludyLyxjE6X
         H06A==
X-Forwarded-Encrypted: i=1; AKwUvBxPnT9vrh2swNWdtSXriCopT/QLYFdo7f3Y0jN3hk1hzHPay8bi/zJC2EWk/PG0TwKxaYv0YQg=@vger.kernel.org
X-Gm-Message-State: AFuF++nnJXrj5E70/Nc8OkMz3YPoM3Dc+eFJaP7YlF0BxQGu6/3hEJ3V
	hgSOwo/lir89vbjWVSNtKIB6gSKRiR5inoIfcV/GZ+HmeROS1OqtAfgUjUjv0mTJ6uzIW/uhDzl
	OrgZkcOxZH+7jCE6Pfuw1QER6eaGkFokSgQeSOepu
X-Gm-Gg: AYBFou0S1T5ovOmiCgwHKRzfnGzTWZY9e+/PrLju0oP2lV+s10HzUWD87d1VfVhpxcA
	uqsSmiXTBoCCxT336+wyyD5IRsaULxLZzDySF0ZbnMHqXljajrhFVUG70g5I+mBNYDW6pCPNu6F
	nmVraees/Pk0ikIdYCyXErk2yDf3IsUZFM0aSPpvhiOWAnF/tVT6NJhRAk9ZUamLzNdWS7GZIkS
	Ijc0o0QtOHmbykkHRGmJrXpCEjFgTI18yTOvCXZD1jN5bg1gVpcH6PLXGVjXxfFsbVb9p8KhKkd
	XezVe75hoeW5vq9uE+a3slt5n5hbv9ajqWKajrc1T0BJ9ebRMxSF1L4PVmyNCavs4Ij2uKvAK3E
	4Gcq3z0GIAYFSs7U3TBCm52/Qv25ZR+Z69DSq/j+co6TzsQ5nT6Nxd+xmRg==
X-Received: by 2002:a05:620a:649c:b0:937:1b8d:e3da with SMTP id
 af79cd13be357-9398053955bmr2321525285a.42.1788764762921; Mon, 07 Sep 2026
 00:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
 <178875495405.219967.5594821749566554418@kernel.org> <CAANe3eRBOQud=bMgLnPbD_yUYUkJtT=GBqtY+GR0ZtU0_kbzhg@mail.gmail.com>
In-Reply-To: <CAANe3eRBOQud=bMgLnPbD_yUYUkJtT=GBqtY+GR0ZtU0_kbzhg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 09:05:51 +0200
X-Gm-Features: AcwNN1WeOqUEs6cInW9RchAY2pakJxhz5cPcUgFjFoO3v5x7dYx5vG4SQCc85dA
Message-ID: <CANn89iLn+Xi9cEphy3nR4bGnFCownrWa9rTZ=AnijArDFo2O7Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: diag: bound bucket lock hold in tcp_diag_dump()
To: zihan xi <zihanx@nebusec.ai>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, gnault@redhat.com, fw@strlen.de, stable@vger.kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"

> - bind cursor UAF / dangling tb2: valid
> - unconditional sock_hold() on unpublished TIME_WAIT: valid
> - clearing s_num on cursor mismatch: valid
> - lockless cursor-membership checks: valid as a concern
> - commit message overstating bind/ehash fill-under-lock: valid
> - missing note that MPTCP needs the follow-up patch: valid as a
>   backport note
> - endless re-scan of the same bucket head: not valid as a
>   guaranteed livelock; duplicate output after a rejected cursor
>   is valid

I just saw your patch today. This is absolutely insane.

Please limit the complexity of a filter to something reasonable.
Absolutely no sane user is using a very complex filter.

Same for UDP.

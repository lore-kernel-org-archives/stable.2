Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792473585;
	b=I+7LsIDP2L7mIiOJvwikvgK2FsCHF7v1AKI55DNr2nDijy7WROmM5g0tNYtyQQyjX9Rs
	 l1+Fro+4AFCVrQba8gZpHvl8sV8MpwbzhfbH4gCLZlBmrEvdozXz6kzisGltb5UrDITBG
	 ZYY0fBY8ikyJvTqpLo9MOFlLKk8kJeMftujDQG6hdMIeBVRQ+EGMNVbsG2I46sNPCbcvI
	 UThkyQvAr3o8ongEQXne2sUSKRznfdySOOfUX6sdhffqI5vLNcRoJkfXPsQuxplRvFtOf
	 3bdsbjS4FSosw7NRa1jhCyPZNxDUTxt9KUJKVtjtSHmvW5uHiaMARcGuWx40qnjy43w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792473585;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BgiA92Rw3GBP5F1shghCZ2z8YmAbZXNEejKdnMhHo/k=;
	b=Gd+KiSF/Zolbkq+innRnunpcl8t+IshDwlc2sXs9jSn+AFxtZUSWQvsJ3QnS+NQ+xfUT
	 vd3OTQfKUmRWNzY+YK2X+QU+Xu3KF4NqWknAxy0lnVNjWoXFSsmihw6uwGVT/f/ZG4kwQ
	 A79wCHpPatl2rlbBpPug1wQO4y0QnQctSW81JhxFN3XOvZ+sriIdaNI0Bmr/uSLoqnc80
	 0TPYgJRYPnno4xtGJf6Yu7K3PvjOlEEapL6gXNkLaeQ2yrh4DgmfJasSQ1+zFGAXjE3al
	 udsGhIYCtKbs6pCW8RqTRBsRw+CFSRvZS+p049eegpz9Yc5C0wj4nyevJyaH7tj5D8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1C606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBAA1F000D4
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792473578;
	bh=BgiA92Rw3GBP5F1shghCZ2z8YmAbZXNEejKdnMhHo/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UMWCj16OBuVk0U88Aunr2hcNay/tMEVe6sCKWnZWHUOCWlPoZ+vy0CkCwTJXjGBsC
	 pUa8wBJtW4t+MJ5+UOARI4G5IneAjBe77CMR8zJGM4CIr+dqyU8VozbKkWRBrmIFe8
	 kRh3PZFiC3vuGVQLUOI5bEHKdiyjPrCrxfqieh7RDSukTJyaXgbh+kc2bU9zBP8fFW
	 kLhl3q2xpKuk6BKQ4xgCll1VHSTAEO7q2/iQOivJFK6dLVn8mVFgjxsD8u/e30ucyr
	 vt2db4Vol7IA4qF0LV3M9Oa/2F5xtU6I2Pw2FbjrezgNUcvLA3TT/3syeCcMruarhb
	 ThIaMnm7xB3qw==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93efc0452b5so181561185a.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 22:19:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw/ZMqfPDycgkz0mF/pTDXJeo3kqU/xPQcsiCSISYX2UAylqdcguJZ+CRSWmCHHAhSLUfmAN5A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+UC2kufmq7h2aEnftgg17tisdUDnBTjrM2OwXc49VAqm46b4Y
	KVbi32nxrYvbbJ3Fgasvnv5Q1jbE8VUAp82uRwsUQoniXLDrh4+FsoE2xDjCv6cExmOsTCrgxMV
	SeJ6DyPYzvVVskHOsXvnzum8U0il2vVQ=
X-Received: by 2002:a05:620a:17aa:b0:93f:1ed3:a9ce with SMTP id
 af79cd13be357-93f29db7ae8mr1618788285a.70.1792473578195; Mon, 19 Oct 2026
 22:19:38 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017050928.128582-1-sidchintamaneni@gmail.com>
 <20261017050928.128582-2-sidchintamaneni@gmail.com> <CAGsJ_4wGq9oc05=-g4aWptLdCbTwUjMjXk4Rd6KjJ6x=tzMm+g@mail.gmail.com>
 <CAE5sdEhGFtGF6LC4xNkMwGj3vTxLOW=GNBXnk3-JmsgjntXx0Q@mail.gmail.com>
 <CAGsJ_4wmvBvEn_vXu8-c6BRAnRewYmTs8iUd8T7KRx7_svZrwg@mail.gmail.com>
 <CAE5sdEiq3bY1kgMUQ6x7RRJCx0JH4sQ9Z_a9_YQSM5FKNwpk8A@mail.gmail.com>
 <CAGsJ_4yZ3rueVMaRJ_+25Nnab0WH5ZLQeLjporWAFj7xJnJFHA@mail.gmail.com>
 <CAE5sdEjFgVoQbWw12=+AKdCOB9cWm-akxzbX7hJzvyO3vpCtgw@mail.gmail.com>
 <CAGsJ_4yrAosgxnxqc18qXyeJQHszYOdTxJw4TzSJqp10YQWjag@mail.gmail.com> <CAE5sdEj9biuOuXp7aej7pV1Zyjc0kqcH12Oi6gLyJCeuihF6Hw@mail.gmail.com>
In-Reply-To: <CAE5sdEj9biuOuXp7aej7pV1Zyjc0kqcH12Oi6gLyJCeuihF6Hw@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 20 Oct 2026 13:19:26 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yApi_o0HdYokaanRAtQXFQLJ2qiCRfRdBVG3=SZ6MxzA@mail.gmail.com>
X-Gm-Features: AclHuK-bqRkpB4GJrWRBWTc8leo0NsW47GnrpMNZ80hWNmfMyMEJyA6ae-ZLPgU
Message-ID: <CAGsJ_4yApi_o0HdYokaanRAtQXFQLJ2qiCRfRdBVG3=SZ6MxzA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref in get_lruvec()
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org, 
	kasong@tencent.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	yuzhao@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	apais@microsoft.com, rlmenge@gmail.com, stable@vger.kernel.org, 
	Hardik Garg <hargar@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 9:37=E2=80=AFAM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
[..]
>
> If that is the case, do we still need this patch?
>

yes. We need it as cleanup patches. not bug fixes.

Best Regards
Barry

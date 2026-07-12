Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E5B3A873C
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783864291; cv=pass; b=bM6mZP76rlj2ijv1I1+6Z0UTXzvdliNXnHm3SQ6YmJg4acuKqi0n2ACDHHjPqvG/zTG1g1kAH9cN3vZBzQCRHEYNWr7Lgg+HfJL7GxRLOrA8GBcRjDjaSVU3KoSwpiMJpksHKmstP9WVs+1GTu/2DE1g0bbHNliQIVbqvVkRVF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783864291; c=relaxed/simple;
	bh=oDP0mR1EofatT0pur4pCie4dYJKereMksrCnMIlZt88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=np4aqjWQ/yvtXieAg/m2JpQjXstm7gwaBrXi9j+l639roYKgl4tJXTyuc9sPY7a0JiPaqZrtmSL0fzMa8qzfa6/xbPqYSZv0Hv2H9vTPSCLd02Hb4twvmRIExo/Uc+cv/H+PKZlLQPgWNdbdogqjX0X4KnjiShk16pW0/bREgz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6UAqy4b; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6UAqy4b"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8eeb4508f29so20362686d6.0
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 06:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783864289; cv=none;
        d=google.com; s=arc-20260327;
        b=aOopgM+zV6qOp8xmXc9GtanyTx5bqA7aAztG3BFkkKhutcXnTmmhCemRe2d+lewZQ6
         u2shofAlgCRw06+uWNHvv+HvCA/HaJCzR+RdwX+F+DlhQcL07Ms1pyukCvTTklPXmbos
         EpIHyfSrlg6vFGXT6fJ9asRnWA3w11ol5OUluiPdCqHRfSAOjYMRQOxHT1r23ex2L3Uc
         RsugKB7bjcUM7GkW7DaOhB2VUuRm4wgZExq92s3/CNv1s2qZe0gZoTTsJZ2pc6N7f7IK
         +rY4npoWQGvst5LsaQpjL2S9kP2t1BQtIoT2LP39yPFe0sPPPTdqrzfNe4iiDIBmn38j
         UK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KPaDnid7id71L8MuAGH6afuYcqEb9Qc/jYvhMfY03I8=;
        fh=LEyaBktKukBLpkFBWrs51axRnJYAkUuU3J89W97YVaM=;
        b=P4oQ3wxOUo21Si9E2CxhDynZpp4LQNpFxnbbPxVQR6t98erqLJyhEUaR00wefYpYNG
         nZJre/KGUEKTB4tAK3SQkNSaP2ew4kkNO3DnmF1VIuSYPFhE9xgPWzVg8PnDEA14If/U
         A95LQpUOANmVi5M9LYvu6HVHuCzhxCShGpsIDIawNIzKlEROWTjHi3ycZaca2cwsekmA
         tURjyYIn2MJApe+bDnutP2B39D94B8zLff7syt55+SvHedaPVodSCoa/fzOsNZMr17Er
         cteAjYSjUs1l8gs5304jCs4Sy0wkUVo5j8kmAnuQqHZHqF6yQXcZhl5Kq8WjU3XYsljX
         DouQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783864289; x=1784469089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KPaDnid7id71L8MuAGH6afuYcqEb9Qc/jYvhMfY03I8=;
        b=d6UAqy4bD8guehT/2lXLYkhjSaWDrHGdlPua9QEyr6BZBReXdyOdJ2XpyAHFKTeT/0
         a/2g/uH8FxpOYczmZnEYFtrc0+3pk4di3Kgkbim0pKoZAfknpRVTIgtdJeY0qpG+TlGc
         CaloSUDzIxgUbleeqT0wlReexKU61ujeiZl1wjkEG6pSWCnEsZsqB4z1YBwd1f3UTHZ9
         EsfCapkBZ9MMeOx2jCbpfP/5YDBIvj+EXxLvkW6FnhT2hsmqdRaFQw+pOBqoZIhZzT/W
         8YAAVmf/vyuQdA4GTxbKJn7FyHPw5ptLuonkur/SSk49WUeXYFaWPuR42+62LB35zy3F
         +qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783864289; x=1784469089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPaDnid7id71L8MuAGH6afuYcqEb9Qc/jYvhMfY03I8=;
        b=G+R13ikDih9FrZtGND/TZiGXy4Hz6l0pyKLFYOA/4xwM/7MQVIdXCyLvRUMXh3hHQE
         pVbDmKTe28F1kCuefKxWtVPejfy8P9yplHTkthZSwhgBmT/lD7BZukGepMik2fDvvJdH
         9cntWT6An2YRh/orh0sTUDRwiRJmt925/HcfY5ufk6nNRoFZwgFF2wbSaLxY8ZKphLBf
         +Wt9G7/DuEkxMvBN3Ed+XPrcOWhIXFFTMV/98n8gFlXk2Lq9Wf5M9ZpHfuvtUkJfM6mJ
         p4hxW3lm5LJvKNsjl+frkSU/Xf66TMq3AKYSLRztfEYvZKOXxu2fiDqe0Rnl5e2BE3nt
         y3Iw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8wb3UjpmSNhIrO6j5J+4Dia2Nl4rwG/m6ecZvYGWmK+GRxO+4fYeFiM35JKnlHDMOjBjot4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1oU5nc9+gtLRjpn2nD+rdrjnQHUfejYymiFIy/z8qhN8PrNN+
	mAOP6D91xHQWaPgaJEFFj9xvckVms+SM4QqeZrSK9FDzun+HYbaJqq+DJYml6rxdAQZYX5Nc4Vm
	CcJmUlXRjLJkUPH8hih8FZ8h5l4i99PKg6MLVzmVO
X-Gm-Gg: AfdE7clELZyskadlPs4jc47R7rPzYZqyILkZia0oGO2L9xiNNqt4IGHOuvU+kidURHr
	btCSYBKrsm1ZAJlTpH5Css8yW2gQQIK3zLHBotB0eronZ8vZCEf+8hXUAkBgwGY09d1i1UeaBdL
	mFVeOI2O+KXOwuWyTTo6I0mYZr51pw31tS7guLbnBnSgd802lRlpXayKt9XNgUwa6J+sjeXpA62
	mLEbFD3FZGJ1q1ujJ+T2cnuFrcYGpp6lfRXMANbMl/uzTs6cbybh2qdXTo+Fw15dpmV2nA5DmB7
	j+mBE/RHNqYRXFtk1xe7I/G8xtKm01v6heja/NCWvaVMFSB9/H21x6DkS07zicJcrUIARTriDXp
	ToV0fw3sz
X-Received: by 2002:a05:6214:2aa4:b0:905:7415:d019 with SMTP id
 6a1803df08f44-9057415d14cmr22982556d6.36.1783864288356; Sun, 12 Jul 2026
 06:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712132531.33028-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260712132531.33028-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 12 Jul 2026 15:51:16 +0200
X-Gm-Features: AVVi8Cf9v2yHkrh7qafNb_R7r25uOxLYtf7c7-SgvEWHVnZtF95shTByiSnetF4
Message-ID: <CANn89i+X+VQ-4a-qbM1-qmykR9stXo+sEQMOgj9AkhXSHA7LYA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reject TIME_WAIT reopens when SYN queue is full
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 3:26=E2=80=AFPM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> A valid SYN that matches a TIME_WAIT socket is redirected to the
> listener with a non-zero tcp_tw_isn.  tcp_conn_request() deliberately
> exempts those requests from normal SYN queue throttling.  A peer can
> therefore create victim-side TIME_WAIT entries with short connections,
> replay valid reopen SYNs, and withhold the final ACK to allocate
> request_sock objects outside the listener's normal SYN-flood controls.
>
> Do not send syncookies for this path: tcp_timewait_state_process()
> derives tcp_tw_isn from tw_snd_nxt so that a direct reopen uses an ISN
> after the prior connection's sequence space.  A syncookie ISN is a
> hash-derived value and has no such ordering guarantee.
>
> Check the selected listener's SYN queue before descheduling the
> TIME_WAIT socket.  If it is full, account a request-queue drop, retain
> the TIME_WAIT socket, and discard the SYN.  Once the queue has room,
> the existing direct-reopen path and its TIME_WAIT ISN are unchanged.
> Normal SYNs continue to use syncookies when the listener is full.

I do not see it as a threat, sorry.

Say no to AI hallucinations.

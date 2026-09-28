Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD66346FBC
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 04:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569753; cv=pass; b=niKDiCEwBC/Mn71YgXnfXW9yxLAsiJPzO11z2R4jVpLk8bI3VAo6mkPbIMz3QCNaC2/vZL9Ad2+C128QzItd2wFaks4W2uRmDLbYgzY9LwGO427f2vP+NJnjLK+SYkWACdu4JJf+KpwNzLC+0Px8OFwGOQBFAQtL6c/xvWoQZOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569753; c=relaxed/simple;
	bh=Cc3Rs/HFoYxnQJtyAWsDpps4zoIxWHTErRApJAjwabU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kzf3NG9Llq0UDSCtCHzBhvQs9ou0dJbrH+l67mmsuLd6DwdM2g6Zz+e9dguFjB1OsZwFOHxMoaVTt3Bh6Uiy5odhG261eFokTeypFBF9sPzE6Ot6PU/kjWk34n1nHthxGPXmEdOhKpsIvq1ic2eRmW3YQj9FrTarVc8BYmDTJFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXeAuRn+; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXeAuRn+"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aae6345fc0so357264a12.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 21:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790569750; cv=none;
        d=google.com; s=arc-20260327;
        b=CRvXytsPnRSGVjk9tJMtAZSg7R9Qo/KUfHxiknPmtTLY/wE9ZUE5r0/26hU/clt5NI
         OopErbCRsu8GzgOG3YQA6Fxo84mR3uFbf2rVtWpu3E628cOwdc0yycwcy9HQH5qhtzPg
         myyomdeoLrvBbvZe+/CCY1VXRmGZHOgCMabvysIomatXzAOitgzAMmhncdnnbjYD6rJk
         fSmRr/w8NOykKLr0gSCxaxUAbe6emvdpVOCzEotPL+3gEi/cL/58KhYfrvJqVnQ7SZEC
         zcsmiyi8+FDiFYRTGceMM7DGGCfA08kqsTYob0zYSP8MC2gAcRQ+IazxwVRvYmm/p5Pj
         1Neg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cc3Rs/HFoYxnQJtyAWsDpps4zoIxWHTErRApJAjwabU=;
        fh=FVxIB7D1YpDN8lRTalCzTLUjhlm3qaO7JHpGbsRgIQE=;
        b=cduWfNQ2YcL/5WZGdV1M1tNGwAqM/U68JEdr/suUeeSGhlG7bm3SwIhVJCDLDfyMoO
         eVFkTiS8jA3ooVixe/ta/ANazlsX9pL4p++A9TIy8QhhR8w99l9JwUtrkZ793gtwTEMQ
         e3if7KbcCyTMtyU2mY9QRdh5Gm+UB8m23GwPCmfnCYZDrC234nuF3saqH2G57w6VKLMf
         CTAjAvK9Q2v2jYJHiO3DcHTYzq7IUjZWOgIXjDlIXOieTwNLd7I0P1m6qOiMYWXolKNA
         ND0fabaYtAkYhQANh5SEFeu/e7mqov4g2SmI0HJ53fzr0ymtVjoH+sZJ8RUQKMX4gr+N
         buWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790569750; x=1791174550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cc3Rs/HFoYxnQJtyAWsDpps4zoIxWHTErRApJAjwabU=;
        b=pXeAuRn+ddF0PVsymMqgNegnGtg1b4NAlpiPCuZWb0JVmQveDaksMta1+Q44/vX4z4
         NS6HMRtM9oO6PxIr8aU9hrqqfEjpWfV7r7A/mhhvnVHkCS8JUDnz0f1SeHubW+k25th9
         AEQ3+TRnwDhEyqsP85VLQ4MBCQjhGEQ1yvJHBrW02p0Du9YvKmZ3E/r35tAt7PLs1WVB
         oUh5C+nDcI9y3PJiAZ5w0nOZBskz+4ncjzLN9h0VgKCsc32OHgy2mVK5++GsjJME4WRa
         HbdStvGQvFu617YocpzNNzgoiqiBHOWWwYX2sxaiyY1Hn0plWJPNamCVavi4dhMMmU0r
         Efig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569750; x=1791174550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cc3Rs/HFoYxnQJtyAWsDpps4zoIxWHTErRApJAjwabU=;
        b=GQk+proTeC+ZXucjjzIUg/zXoDUkMWb4N0a8qUMrDiM4UvJq1Wax19bPve5AJrVEpH
         y0OoI/5RirUaqUx6opxJtMf43Tbf7FxP0LGKEPTERs1YTnUZatlrv6ucfbnkhEZI1+7X
         RVRPrhyEG0dOgjVU4UQ1kcM54OXAaAIsz1lYyFjP6Q5f1jCxdcpbLJLSw9xrbxghBPRI
         DZTssiZxSJbKnAemGukNhdWVWtmVhpD7MXDAZMFHgouwNB5nuIVXlVQwDWUWgnumr5ZX
         miUfbQwG+koJHudahNlDg8iKYoURiLcFzYhDgjkud/EGd4CBEdE0MZVwVtkfG+AEOgvq
         j5BQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5u6SuDp0ShQaiB/lmCcA+aHiEsA3XmPIrileGIKkQlHZ4WajcpU4KUbmT3Y6yW2tu/gn7Bx8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoK0608jpoVslCimKU1jAvhwrQ2RyYUdqR+vl2fW3AHcBN5bWX
	OlOhkV9u6168LzCNF19+EyHDsKt4Jz4xXw3o8hbbYwIi6GUgRxHRblUv3GDFj2a0pcbEYUcMKrS
	mqpDoTv+lGlKFlWnfRILvX8Lz4O5XpW4=
X-Gm-Gg: AYBFou1kb8YJlvVBKLnyn3ccuc80fQ00O5HVo/TOJK8zc3HfWuX30L5K71JKWApLCG6
	m6xPoV1a/XKVjF+x9x1wlThENv6x9JpYOls10BQ1tabNB7EebJWX9TjCh5BieH7Q0IR7tkbaoLJ
	OWSONP8Dn6YfkFlGRyLP97yMx2EPMSIFh+89hwyZj/QUpyfXA85QyhPLCzwyXDgJepURHDm2Rge
	Hfe2yLbehPLccpNMXaQwzn45XqSPYpu8EChCZHLfZ77E2r6SbEuaUc0GcaTn6PD+buYJESz6/Wo
	uwip8xx346EdgvWGXPe/ovEL0HRebiR1EzNMR++j5Hm05u9lmZlWiM/XSfZFLawOPdFO/Yz5d2h
	jvmZGJW8G3zI=
X-Received: by 2002:a05:6402:400b:b0:6aa:91c2:63b0 with SMTP id
 4fb4d7f45d1cf-6aae1fb697dmr8030974a12.2.1790569750079; Sun, 27 Sep 2026
 21:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927071520.3693598-1-nicoyip.dev@gmail.com> <20260927150704.62c8c919@kernel.org>
In-Reply-To: <20260927150704.62c8c919@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 28 Sep 2026 12:28:57 +0800
X-Gm-Features: AclHuK-9Q4O620Fsh2sXCA3XvsN6P-GhXbVBeaaDb7-HyX3to4btQrRt88NoqIw
Message-ID: <CAAo+4rV+99b1ZaiA6EnNBAivfbpOtq21wSMJNC9OeQ2wLbHqXA@mail.gmail.com>
Subject: Re: [PATCH net] netfilter: nf_tables: serialize offload stats with
 callback unbind
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 6:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 27 Sep 2026 15:15:20 +0800 Chengfeng Ye wrote:
> > Rule GET and dump requests collect hardware statistics under RCU withou=
t
> > holding commit_mutex. Callback unbind removes entries from the base
> > chain's flow_block.cb_list and frees them immediately while holding
> > commit_mutex, so RCU does not protect the statistics iterator.
>
> Slow down. Please do not submit more than 8 patches for networking
> at a time. You can revise the already submitted patches but since you
> violated community guidelines we ask you not to submit any new fixes
> for a month.
> --
> pv-ban: 1mo

Hi Jakub,

Understood, and I apologize for overwhelming the review queue. I had
accumulated these fixes over time and submitted too many of them at
once. Sorry for not carefully reading the submission guideline.

I will not send new patches to the net or net-next and wait for these
already sent patches to be consumed.

Best regards,
Chengfeng

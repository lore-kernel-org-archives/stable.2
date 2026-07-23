Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF4C2F8EAC
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821297; cv=pass; b=HKi3x11A5d+6RBIkAAGAQVcBAlHUSzPK4RMMQyglfYwcKN8z8+CEwrlB8SMLyWGfQl9Ax4oDE40ztyF9E7lDNFLUQ1d2IO2MxQiMpWe/En/C7dJKWyOmStPx4sFEDkkZKM+HoTZnBPHRd0NJWT53IzTLstXjhsjHRo+JM8E5HDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821297; c=relaxed/simple;
	bh=pI+5JI9JeW3qaHsHCrOzwnAwIxbzLeEtKURHX1NItgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYyOllm7cT5k1fzHkjvwDm3Y/ZZeDHT0ToZdsMj6mayq3VpPtt90owKuCT/UqbffT2/4Vk8kBCEimhTzu2qXtVmKPcvlxPDCm/ywX99YCH1YucPIf6k+M5XsgPBL0geTCv8lw7CswLtjF2kjDNE/noo3h7FS0SRWZZd2q2TauQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+eYlhsq; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+eYlhsq"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69f4acf7047so200766a12.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 08:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784821293; cv=none;
        d=google.com; s=arc-20260327;
        b=fz+xNl8Y7mK1HSsEUAR1QwjH55RA22omNc5J5boxthBHfbLnqfMi2YQdyCCkVBxNzC
         eGqePMRiFViM35ITdnOghB9Uur584ZCKZLwb5nDyTog3zXrrRka5P5Qu4DbjK+cIcppS
         nMiHUlpImZYu6bcJSS4JUvVnxiuaaXNql1elGjxZcFTZWQgZ2fHfd+HEB5/lQZ8cIQsw
         4Wb6dfiWteAM6lfQIJfTJbwk3/TvODlTCpDJQiSG+QE70EZMjg/WeGuNM2S7fYQoBw8V
         UjUlIXpRSIE3MZpDaRzYa/mPmJYOBauFCBjfMhilA+p1tXl61fW4UOHmpGKLJ2iFvzuu
         ROlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pI+5JI9JeW3qaHsHCrOzwnAwIxbzLeEtKURHX1NItgw=;
        fh=DGYglyF4LMa770kE+wazuaJqHAnzJd29EfIs/+ZDE1o=;
        b=D/fxkNo++WFco3aqFiJf6A96IVgxoJDXMbLa5vy81Bnt+P2mTa5GFS0IXNakJ58qq1
         ZMuXjN1vXfcN8iy9QGhL4Vrv2qxJ2ztbmFteywpEkX9UnPIz1KhzNjvJkGfAk845CpfR
         w5ohd+leFPzSh2ilN7L/2qd2VC/NPhJEEy4KVrGuwtmqvYyS65tkWS658kb7AcCn1rfK
         caHpnXqHMqjr5QkJAjTCHNQ7vtaDRm0edbCfbqCXJnwG6EkhjPhhAPJqftl6NcXv7mYl
         AR+2tau52cFR+Ln+hOqhQvwZeOQjXpNrkBw+WdP7vfyqY3ZWM5i9iV4Gw9oCfjRfUupP
         ZD1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784821293; x=1785426093; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pI+5JI9JeW3qaHsHCrOzwnAwIxbzLeEtKURHX1NItgw=;
        b=B+eYlhsqcRPCBu2CnkJiqDd9Ev79YYDcM5Q9d4bYMPM3AfSjsmGbTx7a0Ch+kPjJ4B
         CtHqrenwqX7TRGVT03w8/HmZwuk2f/Vx2QnZjJ5pcHxg1QvF7EQgHD50UXl8xxo86Chk
         BVRtyObOl+XVoV4eGnQRb9o+yAHqmNkU3OkOD+tAoCoCUASSeFpuh70JVpO5kBDDmYAy
         DIq3BgtDKEmiGZ0HxkYc9hkoz18gquHZrLSUjUIOAgqdbnJZx91aQtGs0O/byaIIvr/y
         PgCBa2+6623xm09PiUL3RKr+qKAUiDSWYuyMwZ8TkERMRfDu8eiFsWvpopG4hplovR2u
         tevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821293; x=1785426093;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pI+5JI9JeW3qaHsHCrOzwnAwIxbzLeEtKURHX1NItgw=;
        b=fppJooXJTdrK1YajwGFjZDd+H0S5U3YlZY8n+h4Y0001Dsve4L1oiQruuivCfQKHA2
         S+bitNHsxB4RQ913xTIw33XpVyO/c0xF1n/kgNI+CGZWh0kaqEeqXmVP2ojCKR8nAd0c
         zi6LvUc01Pco+7VEsuKgitQ/4nspCZVKucALBuk5CteFbSKZWdeMEy7ElQteTDyOOE/R
         ZUYtcY4cXL8/BPAar8Fws81nUiT6DGJsCtGaztG1YnuGRtG+WrQCMqvpGzLAqVV7IGvp
         vmun51WnR6WZuKtnfniHXRjscs2L88QLfIZzEs7pLAkEraKJ66YIJqY+65DDX4Lly2p8
         zHMg==
X-Forwarded-Encrypted: i=1; AHgh+RriKm/YIgdj78Y8ki3bccGZ9LaLn0saD5vr24QizfF5XYc59eY9g79n8JsOAIIivYZ4vuxKhuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJaiSAG7tLtkrAfax0H60h2AvvjUUjdXnX786SVHUVRVqeZxM7
	3ESjvehY2e4mo2yfku3gGgku7b8yLOKXVwoJ2RFBS1LjTv9wQiSAiKTT5BXkG0ay7yhcSINm4qd
	jrwoNHXfhFLaFIzcDEMphWLIhpxNupUs=
X-Gm-Gg: AR+sD13oIHIX4PI3UhMgvFqXkevnYFuGkcrTAntuUeESO8q8rGEBwJBMeG8piygmDnx
	91fsLObh7NzXOdnS99nHv4dsB+oX1XpV/RiwODxxlOOOgbZ2MtsrEGHsqtMLg/FCaoyhZ3VnHGm
	xCR7Kawqii/lBxKSQj1CwAT1eVA+ykfvcqgzdzdgoD+cvgXlDhljtcl44xzoxOG+Tm1qYFo1NQa
	c16ambj590ionkkAg4Py5z8ObqsUuaSv3hsU2PDOYKUW3SiuUG/0IkoBcjZCdxlVflrA1Z/7SlX
	EFK6ObnN8K0gpow=
X-Received: by 2002:a05:6402:1ecd:b0:697:ee01:9a0e with SMTP id
 4fb4d7f45d1cf-69f6ab3881bmr979483a12.5.1784821292913; Thu, 23 Jul 2026
 08:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com> <DK3O81WR05WI.ZR3AJUCCX424@etsalapatis.com>
In-Reply-To: <DK3O81WR05WI.ZR3AJUCCX424@etsalapatis.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 23 Jul 2026 23:41:19 +0800
X-Gm-Features: AUfX_mwzqO4WBcNnVnNaBug6wKkdEpx8B7ntUhhI5hwB56M1TW0WBGtfi_e10H8
Message-ID: <CAAo+4rVPJMDiX776OHu22KCfL7WnLG30p9r28NZYYgQZya8-OQ@mail.gmail.com>
Subject: Re: [PATCH] bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, 
	"open list:BPF [L7 FRAMEWORK] (sockmap)" <bpf@vger.kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Emil,

Thanks for your effort in reviewing the patch! I have sent a new v2 patch
to address the Sashiko comments on that function. I will wait until later to
see if any more related issues are flagged by Sashiko.

Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B93B635B
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684158; cv=pass; b=dg0LpnkGHOafXizos8TOB+pROKfgi8dZ8SpLRM1htJjVIhiK1RSl97NAXtLdVYJLkr1r/1p074yMYic1Bsf6MdIWyviJOayV9nQHRQJire6Gv4vjl5rVR3pfPeypWvBiVH/ZNtvAAnfONePxHgfI4UymJYWnwpc/WtDzK0EmHT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684158; c=relaxed/simple;
	bh=Oafa7a3hagVsWS8SJ/kkvtcYmScAQTKcHCN+MR5JqiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ew8WEXXH7DiFqkkWxC6fUvrvKkv8VjrwWH5mXgg+7FdFAcI3IS3Dr/sLNZp7VfHW8ZgBSyrdSnK5TtmSEHp8U5ufNh2CPzHyjKcyt1ght7Z7DrOzE0GjTMWOPHrri9bixXoGoRd1cHNGRctRywf5pAtBUzggLecGHRorviZlL/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf1QPyWi; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf1QPyWi"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a5d24ae3ddso13961a12.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787684153; cv=none;
        d=google.com; s=arc-20260327;
        b=qA+VT3oUlkDtt3qSXRTfwcYVIU4oeMKcDVU4ASryJ5a/2BZbSLvy8lDFmwyeYIt8ba
         Xj33qDPpQxr6H6igu1ZTa7tVH8R2ZdwJl2jOiZ72IMjF8avBIRxXE+Ydd5Q9BLzcTBTn
         6lglPTUIyO63sC3Z1+snO7GD8M/cVRc17VlVJE3thM+Lrtq8oQRT4xntOY0A9aLcR3eC
         Q773Gjj8lKM/5BB9d+rxCM83hBa+2wQqKpMA3ITaMhN6aj5ER59q++nvGS1UwPb5nEBq
         +CpFic4LEYsqgZF3cZ/N/fYhLFHqvq/J4LEKygdzC7ZJ6chweibvyeWlKnwQlfJyvB6x
         vczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oafa7a3hagVsWS8SJ/kkvtcYmScAQTKcHCN+MR5JqiY=;
        fh=5CxuMKGeCYehpjcfrudyoklbREkvGF1p5SWxPbKtO0A=;
        b=UanaRxTu02xyhURpYubBCYJkT1Qrnrb5VTW9QK3BmoxNrAhyveLFmMEL7AOzrl6j3Z
         ZD5/s8bub81MdxAJ79+DgZtEERo7axBHe8IdYmBVByg5pUj6hfygf3e2ZHr15fLlOn8l
         JQ4G4j5FkBKyeNF9RuwGkHsGjNVkMIKdIvB/7BfPZJDzS9Rc9eSz23GzgwgHbd6AHHpj
         EeSAJpeDl90VXD5NT06txMwbAy5uqSWQdR9BVaPjLDubCkDLQpAytAEuWsxJu6E33ABP
         NJwTg2DHpVJK9fT2ZQSWZg0m5SzRnzxgE6nifvyj2YmZ2zRipZi3X9APGWkZPztDOz9J
         aZrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684153; x=1788288953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oafa7a3hagVsWS8SJ/kkvtcYmScAQTKcHCN+MR5JqiY=;
        b=Jf1QPyWisWyPIttRGdPTtNtUYSp/tutRZ6N4mek/Z5dvf3sZgfh//tluk1J2uJRAKp
         TybJdLXZev09NrkfYz3OnTUpKujRjuZtdlWOlSJ0lUsKO+Z6gwwLt3fOLBcn9a5Vnv07
         R+G3lSn3/QsMPHTOTri+zYE/iZh6hE9IsKB9ztUjByf1x9ojJbcPUcLL6u2oV76kggsw
         PHBumlhwklx/XDt9jnpvL8SGS9nHUDY+8CCnNHJQhT+D6WH9zXdztrJMmIXXtU5a9+Sc
         uB9kd5FvFGmaooiBKZv06VkSYCkAZ5WoTGd+tjBexljWx+mB0XdIOkixWvDx+llUnPdp
         KD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684153; x=1788288953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oafa7a3hagVsWS8SJ/kkvtcYmScAQTKcHCN+MR5JqiY=;
        b=K9NYhIFOhbLfXyPck44yos4jJlpTJCT/Pghb8XD1Wr/TyYycz9zTvzpGqN8LLqlD9i
         RmBP2eN2iU0RCkSEXo9GUbBwRkJcnFFckj4thYWQMB/yDnr3DuFLJM9Ob3Wafufxu6lU
         OTjC22JLq03u1695mJ2gi6Haf6OpR9ASVMG1mBpCvX6pWx7rnpRi6RzDr/7ThNgYfGQp
         Cyj7ukc87OgIGg7LlHcxnT2pG/9YHP9Md18xAxtZDo73zhsxwv0W54AqFF8BLXD9aj4C
         4974VZo5Mz3wqkLfEUqsKKxhT5ZDwRfHbyAvguLLAyTLVj7jh3GlSjNvv1Txtd/ere2m
         aG/A==
X-Forwarded-Encrypted: i=1; AHgh+RooSj52ryKa93HCie/jU47f6+BMLhiTLlWopWMpLhrp7UeV7kF1zSbR26zSntb0hvk4vNz2jE4=@vger.kernel.org
X-Gm-Message-State: AFuF++l2IDCUO+fYfNjvqHrIyKUFQtUmd12z9lJOtBeSYI/z2KUHmaqT
	/Ca0gZlrHd5WpH1dbsXAScEt0+5HoxY1BoYp7bJx5pu2vBuKLjBj+o3VzgnIP0RtDKei5fzZFWE
	CrdMA0aqbBK89qgX0sO3ZZKSpmlY6sHo=
X-Gm-Gg: AR+sD10Mx8B0TdYqjc2DG5E18vWIjOUwADegpipoT6sUlp+PiIGMuj3DovvGqO76/zA
	KR+07fRT0EpCZf+8iA0WG+riade9HG0VLClCEbzr2i0AmhkRv+QL5xqE8a0ndHQo2vay/ulKXWA
	vQtzgZxHeiH8bK1+n1gUUcqgPUvfK40p1hGlQkSA9K9Jy0bBDBSXYvkFOmOPK8M46bajavQsyFF
	bYwb80HVhnIDCcaBE95YrrHMcDbc73yLC8pU9FYhczZxQIFwYoibgSxkLF/kdiQpL5Wkqjq/fGL
	fm/fWqc3kCPwkuR0kIt64aVWZi7+3Cj1iXkQyIoiObqig2rhF98nyvHzDWXFLScBK3Vuyw9Xag4
	=
X-Received: by 2002:a05:6402:1f0d:b0:68e:4c0:f59a with SMTP id
 4fb4d7f45d1cf-6a5df61ebbamr630339a12.2.1787684152982; Tue, 25 Aug 2026
 11:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824152331.216494-1-nicoyip.dev@gmail.com> <f3a9dd1f-43a7-4644-bf1a-45dcd422abcb@redhat.com>
In-Reply-To: <f3a9dd1f-43a7-4644-bf1a-45dcd422abcb@redhat.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Wed, 26 Aug 2026 02:55:40 +0800
X-Gm-Features: AcwNN1W9SWDArcmcz5-thOMAtgRTEFgcxQnTTIg0FVU6UltdC2HdRtGhOn0lr5k
Message-ID: <CAAo+4rUG_Y_d28bLbQdcmHY5-vtBrhV+D6rzbd3Mb6B3iTSuHQ@mail.gmail.com>
Subject: Re: [PATCH net] net: pktgen: keep device lookup under RCU protection
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Qi Zhang <marsy12010123@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Alice Mikityanska <alice.kernel@fastmail.im>, Florian Westphal <fw@strlen.de>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 6:45=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
> Side note: returning the RCU protected ptr outside the RCU read lock
> safe, as the caller never deference it, but quite confusing.
>
> It would be nice to follow-up on net-next replacing the return type here
> with a bool.
>
> /P
>

No problem, the follow-up patch is just sent.

Best Regards,
Chengfeng

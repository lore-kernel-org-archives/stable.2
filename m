Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E93CA481
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 05:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790658842; cv=pass; b=ZCBlzRwrenk64L64zUtVPwD44pgHueqOXX0SNgFhZKQs2FAguUPpzBeNlJ6LU5SX0WJyf8eL4TemqSS9r/3xj3cbEESASKS87qjfIDghuZ1iiF8Ty8d1ULiWT5ZW0hOCsb5OlamPIYJK/vmdEjtlNTyWzMn/cHMAqjSLYtipDeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790658842; c=relaxed/simple;
	bh=nt1iDr2ETez6hUNqs0WgZtwZnWmFB0cRIaZZaRitIY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQwXq0XEGbJu+VsMJn5PQafgqm9iXlQnwCoCYslo6uID6hPEwChJ2fiE9Rid5QFBJqCrgKWY1Lfq72OyFAGMFYWjEyHm4vDT/m81FgBRo8fDbXSrKIee8UcWEnEVBJGSExjpKX8QH53kgucCEj+Al2wq6V84KJYLO3BxlX5LnTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg659xqu; arc=pass smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg659xqu"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33bc6ff6cadso503753eec.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 22:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790658840; cv=none;
        d=google.com; s=arc-20260327;
        b=DB1IaumLzLytL1hR/zuAowywppOx91SLymUVCWV0VlyPOpnRNTXa1hCMJBDRVvkwJd
         xUbayExwmVC94iInEIB7znr3FshThtuuQBjJDA0L/Zgy70Ypz7GDJtQdvYmZM85v6fky
         9r/LwcRxZiITI011IVZdMGvlYTC4QqkeOGiTbXxvn7yRKpHZPBRkb8oWR8HJjW8x4R6X
         lm80Agw6prD8M+EDpqrjRK8d1oPBnrt7B+t7eEx/Ot88VidlU9Qr/w+uCBKWmyQvFtV8
         ZtTrldmjjSP7Fn5Qhztn5cicZbWOIFZOmsJJXfBYMFyvE1bam+JzYx8VacNFGqCuNXdk
         jVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EAEfNr5sJR9Z3DQLQ0Wzy87dnyw+ZdWq7blTmjddLn4=;
        fh=eht3EymsJTWFxRVjyHXUFA6z0NSG7ThX54v5HorQ56o=;
        b=jZ3/IIClNQ18Arpicmh9p9q4Sixa5/o5MhuiuMuQQ+QynV/Gu32Lfle62Q3VrEmWl+
         nopp8EC+SkcC7RbIE3wZ9cORD1k8DtygFy2BkwH9madLCyLp4PGrTpnLogMsFwezUw0r
         WGLHo+CfNGoI75XumSLrH8fYi/rcHFVTeOMzXBUi79hc8j6QyX9NWAOLAC1dQNDw43jW
         uiQdMlZtPR4zLUk6vpNrr/wh/zy+HKdhCop6F+SNR48CF+bYh0xxmf+lkInwoOyRPzDF
         SVWQWGhRMK9i7TLkoAov4/XAXNp5d9XwlX4cV2Pc1p7fR2+h6T2ACQMtqdAVZru6bEKZ
         TMXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790658840; x=1791263640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EAEfNr5sJR9Z3DQLQ0Wzy87dnyw+ZdWq7blTmjddLn4=;
        b=Cg659xquzh+7wBzdyecWDThdteQsEU9iw9/FdEAejRz7zQcLikP8QlG6SRMufo3ioG
         Df69aCaVQ7fZ9p6BfKtTIOHOe1s6sAlz098JsfIV4e6bftqm14KHlhmO/UUVDNgcOR/Q
         yIkRJbP7UvnJXct6SDgXiiCQJcTPznkpqMMqux8QhqT7rZNNMDAA1wjzp+AWIHbyOFLn
         zgg4a/DlIpz/ksI6EJElXHg3Rdz4Cn2KxqLIbgQAaWilXpCqcVQ4bBdxrzRPRPVnBX3l
         OLC24Gg5pxGGNH5zMK+peCc/6STpCGMaYh4FS2n3M8GXHW8OhQ7Iy7dCNYKicx11YTX7
         KBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790658840; x=1791263640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAEfNr5sJR9Z3DQLQ0Wzy87dnyw+ZdWq7blTmjddLn4=;
        b=iBRV6qkuImctyPLc7BQYCDc6AlilhI3PSANwoiccG29AedIk8k/GrE+hMFQM/x5ymw
         a8uoapx5oqocT/hD/U4Aj05G1WKSH5Sz4yglhs+kmSZyOU3lH8youfNdjQ19keQyzMe2
         vjAv+5fzWeXWv6yf2/6iXB4UKUw6j7wKuIAuZYzrLYOYzMXvS2gVz5khRWVZNdWVQZuL
         AC6H2SxL/+FU7kRKpz9IZ2g1yh5KLG/seKn/e+taupJ99lg6XMXtqv5XDc0VWBYVa2la
         /R9g0GGgJlEAl+To5t4ujbnqEBe/a4rs6U5EMgEEBgfoOTzjt6wqOrMp/Ziak1Rq4MFZ
         PVbA==
X-Forwarded-Encrypted: i=1; AKwUvByTws5i32xcq8jHOd2x4+bE3c7C5C5onx+Ghp8cT2Z7D0Q0p0P0O8V2F/jAbr9gCDVbl0Ya8WI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKv4mEnvFIS+3gW/HJemKW3uEKjTpWnQ5W6L8+NZm3UTc4bW0+2
	Utnuqq3rinqbHM8Q0GH5yEI5tSQydmbVMi6+QakphIksrZrdSRHxLz/xzSsJqzs0Y5OY6/a69H3
	xAyXhwiS2i5ZdNlOA+Ot8FPBzz9u6vBM=
X-Gm-Gg: AYBFou36sYAYtJLh9KpSF558zZ4l2WKW6tnR7jgIFzGLUapKeTDbi2nM4K8wTvnH3YF
	h5Bwu8zgTgf1TOJIMYVmCYrOC4oWRfv8rrnXLog+YDyF7R979yN7AegHMj+QETM08BmdNVCAsJx
	VAdrr5nWxUSVRcKANnNPgY+ihibTzvXIGSta+Xvcs8bqQKnEDowJAmTFJE46pXie08PqPWPoAX4
	wmREbslzmVw3Je2gloR6k+O5fcg4jNmTCgBGvJeUAWy9q8qkbSrItiOoubXchRCoc88xG+IdAhK
	SsUJfRLgHaR2N6zKFlBJ1fwDzHBkkCVZfQeIZot3B4oIZZNGJ65O92Yfeq11THalBVwU2Yd3Pay
	OZ1tnL9agiyLkesMZsqFJVBq4cMd4Kg95hKpX9/dUo0CBHdGSZQMwBXR4wAvy/H0P2QCj9S7hJ1
	XzB8Yz4j3RMbSx/LehOFGwF2zMahnMInVa4HR/F0os5E4T6ucw3sc=
X-Received: by 2002:a05:693c:65d6:b0:33e:8552:6e06 with SMTP id
 5a478bee46e88-3426cfdd194mr20205871eec.0.1790658839924; Mon, 28 Sep 2026
 22:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928102547.201475-1-ojeda@kernel.org> <20260928105443.205758-1-ojeda@kernel.org>
 <SEWP216MB9770115E94C3B65C35C3692830F98C2@SEWP216MB977011.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SEWP216MB9770115E94C3B65C35C3692830F98C2@SEWP216MB977011.KORP216.PROD.OUTLOOK.COM>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Sep 2026 07:13:46 +0200
X-Gm-Features: AclHuK8zhqw4hzXAxQU-LgN3hhSsxqTyet2X0hWMvxsfudBQiH4fkjXMyED0XbU
Message-ID: <CANiq72n6RwJeBo8_fKn5g7LH+kzhuGcTt1Hv3jOE2m5mjLqGVw@mail.gmail.com>
Subject: Re: [PATCH 6.18 210/398] rust: net: phy: fix off-by-one bit positions
 in device status accessors
To: "springbreeze@stu.pku.edu.cn" <springbreeze@stu.pku.edu.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, 
	"fujita.tomonori@gmail.com" <fujita.tomonori@gmail.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 5:17=E2=80=AFAM springbreeze@stu.pku.edu.cn
<springbreeze@stu.pku.edu.cn> wrote:
>
> Yes, that is exactly what I meant -- thanks a lot for taking care of it.
> I re-checked the series against v6.18 and it is correct:
>
>     1d17bf1ae87d (6.18.y today)  ->  bf6272d87a7b (1/2, back to v6.18)
>                                  ->  5963dbbd54af (2/2, offsets 15/14/16)
>
> That matches the backport I had prepared locally, so:
>
> Acked-by: Chunfeng Song <springbreeze@stu.pku.edu.cn>

Let me reply with your tag in the patches to make sure it is not missed.

> Please keep yourself as the author of 2/2, and of course I am fine with
> your SoB -- the upstream Signed-off-by is enough for me.

Thanks a lot for double-checking it!

> One nit, feel free to ignore: 2/2 still carries the upstream paragraph
> starting "Use the bindgen-generated raw accessors ..." and the Cc: stable
> scope line, neither of which matches the diff anymore.  Your bracketed
> note already explains it, but dropping those two bits may read better.

Yeah, I am not sure what the stable team prefers. Normally, I either
do the square bracket thing (to try to keep the commit "as is") or I
send a completely new one explaining the difference. I was on the
fence about this one, because the original commit had quite a bit of
context that seemed bad to lose, but it is true that of course it
doesn't match the contents.

Cheers,
Miguel

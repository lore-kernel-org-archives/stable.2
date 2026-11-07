Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794054560;
	b=zAqb2pbX5bAFpTEo52WBe/N32bJOundBIjyTPxuV89rqnJeyyuEhRvFeavHDqcGDb222
	 F+On/wuSTAl4EInWdcD4pD5AHA9Sse+rAQFE7uwXBJFN4IG6IGk/GlwAGKclOqjotarPb
	 bAncey85w6EP3LqhCRkpRvpkzrg1/ataFDzjlY264xUvM3u9FGl02axPYl286nfl8WI9C
	 1Jm50/SO8ECMoH/0HTRzx7IzzipvprAh/U3RLawZb8IyOxsvapR8N3t8Q0wStYttwbVh7
	 gWQibw3l886DFM6uQLgu/nLIcq6OIKSueMGH80oExAVQQMLH/vyVGf1xO9xpka8eaOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qkj40uhsOANxhZ4wGSiMEaTBr9zceQttstO2ZHHbTF8=;
	b=FNAI4ZDdQuYO7+HHReq2VviiQPC0Zpk3SgSo+OAzk+pfrair00+fjanqn1eskP4Wxblb
	 ilKbmkDMenBSwPToSUjTMcKMi06SKJGEMFgvZwNKO9XQ8u6VH1JNrJjgL5NyF5eM9YSn9
	 bTdgk+vSITKLoMRhh1dmd5FgeBV42kQMN6rw932UsoXQMa5rifu3+speXDJJuxe0VnHXZ
	 iladrFwBglr9Qwe/sed2SXW78CEBgVt6yBYmsW7qUwhFbUAzsrRw5QM6nqPdLhaa0MR8w
	 46C4vVQYkJACwY6jpwgb16u9DmMvU97gBmWZC4jMCjFXnJBfBUPX5ZzUF4Z5OD5iC+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Yg3dgG/4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58360606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 12:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58360606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yg3dgG/4
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36dc4797082so253742eec.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 04:29:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794054559; cv=none;
        d=google.com; s=arc-20260327;
        b=Olr82d3drSArJD0Ka6xXb3q5sZ4tTh8bFdhPB2pNYOT0SZN+onItfZnusqb3OsR8R7
         m6hRTkPtW5X/ndqz5AO6EWCN4/1SQaxu3R5JkwG2H77dREunBYFVkBaeTV5S6bydygpd
         Zsl5U61EbUk8u+6fID100E8bZI3Gr7uT0YnNA8iIG/HNnUY/upqDgBTcwfjKtekh0k2v
         XdDAwHrWcWWw/5kUo6PkhxKMtIAc5nbNoHVDPr5Uy+buPLbl9rpCxVTanKydfz/If1zz
         QJXrMS4553pM9NKQBTupTUMwH7GsT4ogXCEpuvkvxmU8A0YKn9Ti87tXpx3/dfKW9Wc0
         +9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qkj40uhsOANxhZ4wGSiMEaTBr9zceQttstO2ZHHbTF8=;
        fh=6GDqIv955AAc7YOSeVztEsDYVJ4S/zmxWp1oluuFXZY=;
        b=FXVCghvkv1qFxe8jdpuTs2GBlI5E7yFkOxIChY00WTIIcBgjrtTJmc4fJRVBjfE/gb
         SAkjCDkx6qXCt7XLBsXOHBzEuUMs6Jb/9Z8Wl1A732nZ7U4dCmZxJZvLN/Y0GlG72ydR
         44D3VfJ6kOwuGim9F1rrcCQVXo8evuopm73J/WjKxriQf1IdXmGE6UoPjNGnn7OYxi1o
         qqDECDB6IGP0FAYYpPyjD17RiSPBbweHMFi3o3jKyuJS8XpoDq5jO37ZbYo/FyBbNK3B
         7U9sOu6BpXD7mSIeotS/KyDbGCB1pofKZbrEeDkLl9QjT1vL4iwK2jPv/R7omcII0bAq
         5pBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794054559; x=1794659359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qkj40uhsOANxhZ4wGSiMEaTBr9zceQttstO2ZHHbTF8=;
        b=Yg3dgG/4TUGp7Bl3dn+WKvJ8AZ+o2/+xFoAh6xX+eMTcdHr0ZFhNO1VIgUv5MX66Wt
         M1Jqi1GOKy0bCXEUuvvXGsRSDU4p1G7b9FQmcOVjzCf3GCzI29/1lZoBjJrmtfom6FZa
         6EBFTZUO3/Li4cRf7JObjgkZfQP1KxSn8yTuOsVaYvoZ20JUfTSX5gSiWLo4ttT7GbiK
         6lfzrdV2m9apEXbl/zjkpz3vK1IkrSs8HlNY3RKdAyoHCKvJ5k7POguMKU/HlNBa1ZpQ
         edt8yuKxxKlcMsdS5Ngs+ZGDyxUMe61aRLZm2VMSxUkxMxRJHnap07QxEEmPsMvBfb2v
         b6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794054559; x=1794659359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkj40uhsOANxhZ4wGSiMEaTBr9zceQttstO2ZHHbTF8=;
        b=WCSULtBxWMsZG4dPYBq8YxiV+0ERDrqY2/qVy3N4H2DlQN4TMrmmxmfdIu3lmnvXo8
         iHuK9p+Ggm31SXH9juamK2IGVj2ELzg1JWHNohdoSciajcBHUxe02V/TSVPGNwl5FnsW
         +ChJHDFup1rBDnkkS4uGSApukDl18ZvFGyqBnF1VVQx9ejEKxIstW/o+ARSjHA5/ROWw
         USPaAOwpYenF49y4cU303l6+G5jlT+9u/zYhanjXJ7ldY7H8CQTnOLG/V+VJSXgY6RXp
         FSMwvWQ0dx0UOGhe0O5GoZmQkr4CpBJ9RS/jdM/FUsLuSn8MZMEZWeS62KQTIASma8kj
         Bf6w==
X-Forwarded-Encrypted: i=1; AL+hErE7NvNY9G/XuBzmhkj4wGKzSWZelxO3tXAB14jUmMEwivtmyl6NlHOiRvoJn14Po/LcJKN1yns=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zOKpvTG25J9q4Hi0R/SeEOGtPGmap25H8Cwzrrb98QJ1UHI1h
	pgGuasrlMwE5gRZ/WRYotBL3vRtEVpACeI7fEojjkGsSJodFhXnh3NXJKlA1F5BuBtKfbjX50QB
	jzmS1X8RucQmJ5RfucT7CI+lfqw3B//8=
X-Gm-Gg: AYBFou11O41IAJofmcpkwmGSrK5p8DOBJsn09LV0P11xTk6av0SnN+BIsGYcEUdKRso
	tP3ksPFT330zstfTwU47CFpeGTB0JP4G8cSky3CBw5VzL7UtQHgu7MwftKR4G40UqO5GDcwQcCT
	LXYJ/XL4fxRBtyvmkcux2hjNXrZ0Xu63FFgxXRiSWOnFug1IrRlJ5zsFPIxM2kqB/Hh28dlQtR8
	pKLoVUKYuEAbdIfEi/iwNttrshi0sAc7J6J8rAkZS8sgtBy+eY4ZGJcIM1fPMiw6/zEnqZ/pWNE
	KAFUME3vcw61PwfaZtP1+//7t2W8VDivNIsSgKWnYnzCGVJWxnSzyyx4c3psDP6Kgr6qSCsV6Hf
	7Qhr5qsZto+/IKV/D/KX4ufpIIleqLpQ9/zIBKWdwCaGFnkCr6jOLYbPKOX/YyUJh9Vcghn/Nc4
	5HjOzYt3zLZ7M/T8wlxfUqVewAZXDjKq73hpiuSTR7/fETe1Pk1mr65p4f5ZptbUQhPSo6DY7dX
	E9d3sY2zmNjFs0WiAjeFO/3Df10GIEZ/UmL
X-Received: by 2002:a05:7301:78c3:b0:36a:143d:98db with SMTP id
 5a478bee46e88-36f7563828emr10356550eec.1.1794054559271; Sat, 07 Nov 2026
 04:29:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107062700-failed-5.10-6b704ec9007a@kernel.org>
In-Reply-To: <20261107062700-failed-5.10-6b704ec9007a@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 7 Nov 2026 13:29:06 +0100
X-Gm-Features: AclHuK-yP9fczZCHKX43DhpRIuXV9HHg2rXnSP895V1WB1HsuOi5qHtu17WN1pM
Message-ID: <CANiq72=4w75Bmpbh7ahesOiJD6tsct1aMbJydO1pbv=Jw8RSOw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn` Rust
 function for Rust 1.101.0" failed to apply to 5.10-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: ojeda@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 12:27=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).

5.10 has no Rust, so please skip it.

Cheers,
Miguel

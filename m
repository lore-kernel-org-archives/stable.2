Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794112509;
	b=VlNoMHLrqnBWwWZyZ9YgqjGLiCmpPHbEdtwYjJIWmnX7rUUnu85lFV36U7XqaFN33IFM
	 w0zn3JV/N902V1oXZx6ijlWlqGy38K/ftN7XL3JxwObyD0sff01LJuuW72qVceM81X/Hw
	 JVzQjGAGEEVkX3woU0AY0BKvjoXaZEfFfEijgKP70PJ+o7xcOiBmlbPghBo6u86oaaFZk
	 PGW9VQ9uCJtmhb+ZHQK3vA7OUk3WBtn9TKA9FrjPwnPsXk65AT/H+cigGc1rEctCj7+7Y
	 kmz0SWZIviTguKOLrJlVHO2egaiBqCJmCOoLmOxiFD2IOTMACvPuomXH2BdemJZEduQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794112509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PbCHcWeESTk5n28syfBzwW5v1OH8kZxSr1xGSJafMag=;
	b=bPX7K4rYGjnJMfZEaeUQsWl/4v3Dpruv5z06at6nQ1ZLamUfKbDXAiU4dyaXLgpxCftW
	 /A7shkxmQP7MB1Wvaz2YlczvL/HAKNHpISCBYHFLZbr5peUFLildwWI4Y3zzv3fkGe10V
	 01aU19ubq9NlArTv4WV8YNEcQz4SagO25Bt4m2x5XWo2XOQXvowgIY9viiIA/xr99UL4M
	 ZAoudcqiZFfBhFmLR9AafMUACRYiZpLVnLlYqZOMgXoJP4uzoIR2q61FGxDK8uVYpJ8Xo
	 JwyW4jvAOGWuJZXhENNhDnSbvsyM9v70ThVRC/RCgX4rN8RkySjqZvulmOmyglFFPOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7Zv81pH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D5C606A31A
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 04:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D5C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7Zv81pH
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36dc4797082so18561eec.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 20:35:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794112508; cv=none;
        d=google.com; s=arc-20260327;
        b=kkHVyICB4EkoyK2eueveTI8fwRKugtZl34g5HeHBiV8ICBjK0Bg+mwxU8N97RciizM
         kpcZI3VbJRKdgZ5B8BjjfpjKYKkM0VyQWabZPvPWB21+Mx/6ET0/CvXA2pdOZxjlZTFs
         OFUYPCE2AOABWwEL7gcIt5ibkK6hObeOmY1NBdTR1o6ANHoEudsVjSMcP23TExTBa5UH
         we56gz7Kfskx72xQ/1CDSF7115Ns6iLbnUGjsz6HmKpB5XGzGfTLLDccfdlxOer5eVKI
         xbEbiXgKYibFRKKV06TjxOtUgzlVtXqoykjRvtP5LtZCtKyL20LzppZ00xcSkDm6hrrB
         S68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PbCHcWeESTk5n28syfBzwW5v1OH8kZxSr1xGSJafMag=;
        fh=PiOiI6v9EyDJDz+iz0FlpPjzvfgW2nCxKjqT8F+I/Bo=;
        b=WgdV0Ym8lXFZRW34v2K2QGRbPenXqDEfI+J1JY48fuhc/ipWaeI2VpzIZWS4UhRBcq
         OvPipAS42pkZenfG+x6YB+U9VdDPpYV/3dd8DPTy3LaiuQtvLY6pGuHnmLzVDQECNIb8
         W7I5CwS/8s4J4+DJIPueFeqYbKDvRrV6cbCU/XYLu9kV1Z2E9wwz458Sgv04fTN0oH3h
         o26xE1v1pDRzuW4Tzy4M4MLbs1U0QDe1QL1zlDcx7k0AM8oSEAUdvSWZtSfzesfAD1mR
         HS8dVspNSWIu+idDDbosS80pVnq1QMDjm71HE4h58GqiB+bAe3YXab6qGwo+rB90OGYp
         +YGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794112508; x=1794717308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PbCHcWeESTk5n28syfBzwW5v1OH8kZxSr1xGSJafMag=;
        b=D7Zv81pHKaSKfQ5stXp32kBuIUCD1FN4Rkos69g95XbyD0TsrMhLTiHGQ8Sb0xZX3X
         1nIlDmUOAN8PL9EVX0RTE1VkzeOT/Gu6QIjb+UaUq4d/iEbvsTPJ+YV9vNmayU3QOBQA
         HLQQJzT/fWdCgYrE/Ftlz1261kFrK6rxwe53OtMIUDafCW3WGNjRtfgGYsmTl/3/FgEI
         iNJlzwNrh+pstG6DLDfQz1b4IpyI8SI2pnh8YPmViiijMyMcu+Wr7PeZZ1oSzVFN/35I
         zdFoQzSrf5q+Zsh1oDPbdL0vNvrA/Z9kpbMvXcypHBqrh0rShayWsvXJGz/7B3XEt7Ym
         PuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794112508; x=1794717308;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PbCHcWeESTk5n28syfBzwW5v1OH8kZxSr1xGSJafMag=;
        b=ACo96OCPLNtKERkisXLc1h4mt3l6LCzQXLWqn8ODv+xdBnXKfZX3PrAV/jgY1cEhJk
         Zr7oKkTZDIUnJxFF/TNoxuk8++8zNOforXDfSAVUBq+mc7lcB3lAtT//Zd2pjCsdJSjy
         9KoMOd91Wx+86hbiM3odDNBs2AfbnTdGwGp61iRrrxS29nQkLUdXeFw5ew6SDtqiPDIj
         ugQ26PrArWoEWU2ge6t89/XXqvFMHlJWWVlyLK6MtBKEvffTfv8XCphwA5d5/B+6wTXm
         1vVm4LRrixeFU3wYh/Aek54DMMaodadsCGkl+/DCNweAllh7trmr36jOiPlBUbMJn2YM
         rdhQ==
X-Forwarded-Encrypted: i=1; AL+hErEFosgbQF0eXeBNYhshRVWoNropaolCTAIRY6cKO9HY1ljQwukL/NvLWZNeJeJZP9MPN+sitts=@vger.kernel.org
X-Gm-Message-State: APuU4Z80rQn+7v2GrrDcMTx8pJbDxWxtgiqbuvSCDE8kskD0LffwnIN+
	Jn50YcZBs3gF2eFJiEALLlENYTD/Wu2IFipi9UwgVd4yrCT1pmTx4BofINlj+Xc5proF1rl7kgP
	XEwF9vtBUwS9l//mGeWqO7ecCsETZX98=
X-Gm-Gg: AYBFou0KNjPfZJD+NMDCVi1EAxdZB3VNcvnc5di3BbXP9pYD/MhIVtEdoRWGH9byM6S
	oZ5rLRbEuL9NI82HbsQNAh0wsdhyw75QaerdNUvoyagMIPJq1xFFWafRPaVC8B2+SdCzkNOFS+o
	R7TlsJr9qtEfLnJNZbm3EEaATYcgWc3zNCLLTz6RTBWtjo0F3ro6tDUOVAD4zMkgLcJTddpkZ1f
	fBpGvTZqeudtIbaKg0TIlLmajStn18gWXy+TfDpk9qU6nFP++DNFp59GfAChHVxfg/gLf2n1mVA
	RM7W11uW4xL5ppYeDcidMAdfwmbkCr5qrVvdzurPVjmg4xxbBUvKH6DyprxVqHG04jbFCd6Kl11
	PeD2/V1ol7LlnL+ew4YRXy/mQKo+TW0QAguJIAkgpbvMZ4V1Qtgu0IaQ5j/Jw44urh21IUyhtuG
	5cWVWqnwwxvnIqpEFbMv9RFgW9FhQOFGAWAQw2rp+eD3WXheHE+C5mMW3lIyBhObfCdB1yBUEjO
	BsNhMPUMegtoOe29/KZUZdv7FLwG76CbhFF
X-Received: by 2002:a05:693c:62cc:b0:36e:66d8:1424 with SMTP id
 5a478bee46e88-3725024039amr2572045eec.0.1794112507635; Sat, 07 Nov 2026
 20:35:07 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026110456-quartet-gondola-4267@gregkh>
In-Reply-To: <2026110456-quartet-gondola-4267@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Nov 2026 05:34:54 +0100
X-Gm-Features: AclHuK9plMAEHzp-jMM91Owos7-vLwkUH-lHJFMV4atpYn2fR39qnS1VSGLGFts
Message-ID: <CANiq72nR4x7mEN5_AcOY-49g9iRbe6DnC-KsdCg2qX88ijk7rw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: bug: update the SAFETY comment for
 warn_slowpath_fmt()" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:12=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Please see #2 in this series:

  https://lore.kernel.org/all/20261108043327.98801-1-ojeda@kernel.org/

Cheers,
Miguel

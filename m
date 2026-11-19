Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119610;
	b=V9YQma25+rp2WT658x9uqe3EIwTUEKfzGNnjI5iQ9OrIkvx9afaAr8+Nw7edOPuZWQ17
	 hRjq9I8Zq8xddPrwH5Tn1TD4fZd99MevdBGQrWuanfSduDcqTrvb3cj1+0DE0q3qwvM2P
	 Qdd1g/r4tdgqOADACjr8hBfQCayan3/X7cdZmWTtraQ/MElGo2W/hjI65495BJMz1jdm4
	 iBmV0W0yvuuIfAEZPtDXJpb65OU9RP+YGGDMM7nPbS0pIwN3+KEocIa7Oo8U6U8AN/GLv
	 wJK+9LrogRM+W/KOft0Q7WrkakZsmpU/Ei0V/V3Z15jJHMoNz+zoDM6nPW/uDBOgt1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119610;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=TZGb4ZVqzaLyU4XjWLhk07am05sagwuMq8LdwhLdv3c=;
	b=S0mbmgv1n1hkGzR/mUpzHWu/DHZxvmOf8pW1e4HXR+gS748DNoOQ00Z0VaiPqVuKflaH
	 G/S1WOoJkmhslMb4k6cPkhAP00amYDRCx5+C3plie88jF9LYUS2QKOy/naQtIx6uRt8+Z
	 tH/hZV44Ppi8ArKQmsDOYlDpxblfHcU3MQ/VHZGpFXM2OwpVlJJ43/cQstJYlS//7o1wD
	 hgnLnUolTewGclSfaysCPpw0yldSJYuUEQM64xXw7Za/nac5QQW0JvWrc+F8IGB9Kd2j/
	 VtnlncoAphA909/m4LOkaokLLABK+zBVt2NndEdCew+2DDm2Gha5HNpSsYk0jQQ5tdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jyi6zXbL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313F3606A333;
	Thu, 19 Nov 2026 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jyi6zXbL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7852A1F000C4;
	Thu, 19 Nov 2026 20:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119610;
	bh=TZGb4ZVqzaLyU4XjWLhk07am05sagwuMq8LdwhLdv3c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Jyi6zXbLzoB68JxQO7YOPn05POWPNonzuyVnYr00KhpKTmJosnB4ErUH2hFuwatY3
	 civg4+DlTumTaDXmgFvjFFnOGjIPoBC6MR5l4CIM9+BVTZxKaEfes15TFwU5oGMI5/
	 BuR52bqGdwjzylscZlzectn2u7/bEmpDSBJupKBsrjJxow9j+B+5gL6Kg3ukRVpSvR
	 R8ajOhccXTu2FCuUfbBO/+tWpVLfySoxIuY9wA5NYxfrwcfByS8/jhiL7H11xuyHcW
	 s4FZKQ8I7JX56HlSk8VIIcxCYUbWskAnviz/SI4zl7aXi9eO48xcckFdkhuqxKXaW3
	 Z2Jo+e1csXU9g==
Date: Thu, 19 Nov 2026 21:20:07 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Gideon Heinz <gideonheinz02@gmail.com>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
    Edwin Velds <e.velds@gmail.com>, 
    Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
    Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
In-Reply-To: <p6p98p0s-5p97-q584-14sn-ns404p6s3orn@xreary.bet>
Message-ID: <49nqon1r-32pr-19r1-0r65-50494sq350n5@xreary.bet>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com> <p6p98p0s-5p97-q584-14sn-ns404p6s3orn@xreary.bet>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Nov 2026, Jiri Kosina wrote:

> Wow, what an endeavor. Thanks for looking into all this.
> 
> I've finally got to processing it. I've applied 1-14 to 
> for-7.4/upstream-fixes and the rest on top of it to for-7.5/logitech.

Ok, now I see that you will be respinning. So I am dropping it for now and 
will wait for respin.

The queue is crazy with all the AI-generated patches, I don't think we'll 
ever be able to get to the end of it.

Thanks,

-- 
Jiri Kosina
SUSE Labs


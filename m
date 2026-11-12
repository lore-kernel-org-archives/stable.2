Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794524660;
	b=hkjBzyIALtqo560yiabXmihTasMdejcivtZe8Dd7XswHFhW3XbydKIqsxxevTI+4+atk
	 Kpzci9kNcwvV/F1w+hpVvsfT0ZiX/jZ2jxdq9Kn/heA65NxTXBRgoz4F8p0lJFJzNsMmC
	 cEprDW2IHK4W02CV/s3sOtYX6cF6tVnaEMuqOkhySK6zyiG5gdGW9x3IksStKgN6Qgf+M
	 2QfXHUXi0f5gUvA6o6u5oiPExos72y+9cW3mtmHj9nuqN/V8se5vuAcSZs6xjlsY+2lkS
	 VkNVxxAlPRhfveybjFZPGsks4MweTjuxb9VtgPjDWdGT8QFnkQzsHmmW78ZwzHaWLVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=08MDudRooDplOYZuxvUS0XwmDlBnmweFEYBeZu/K8vU=;
	b=Zu1ZsVgVHjOLVwdhCOD9bbj7FW2wg7yS6NdiDz0uXtMez6mfkF7qAPhpodTK0svDekTC
	 RZRzbRdsGK6x8IQTiZsLVL7bEDARG9oExMAs0576jvGNTu4bKihXZHRmTkhOfP+Qq7il8
	 9UTx97N604sF9wUyKKsC88WJHNehiOV+p7MUBDb7346X3cngM8L4Fbq4M6l9c+8Wd0g2e
	 4mbLePUgvZCNGNhTScCA3XkiRY8YH+mAX8IWTvZXDVfesqH4vzvMSW9RqqjiWlCuXwxCN
	 16p8+62apEYuywGHjiBqDkWeC5XwlHYcm3vbqzxrhay5H7xGfQHnxlr67N73S8oIBlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=YEuX+fX5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B522606A32A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B522606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=YEuX+fX5
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so503742e0c.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:04:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794524658; cv=none;
        d=google.com; s=arc-20260327;
        b=RWrkSWkUsclxXcirN5tK8xwp7bkNjRwoBCcESRaIYLm4IH2SYXIwo1xjGEZgx53Sow
         HqQLyda9iz2zUdyQfh3YGqwum2U1DYVfdxWWmACxja86Go+NtEQihhmXZCKN+9T/Z8mb
         JVBAwY2slxwFJtWT3yhQW9I0gjWmQREY+emQcfYYQ1i98sLudBkYreRqf9vIc9m8xVvG
         PVw9dfq42f928ikwiO/Aqagjhw9emiNDh4DDcw5b3NcUwmj2Sduh66JZGMtR5MnLfAfT
         CcSclV0QkSo/c7U6h8USI9hJ4EPQHL1FRjGmp+v2yHl0B5bY0RaR883EP/lAC9CBx5nE
         AzEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=08MDudRooDplOYZuxvUS0XwmDlBnmweFEYBeZu/K8vU=;
        fh=AaScVspJ5r6Ry3qKRC5cYF6kZ4Jg7NPlxa/hS7L7SAk=;
        b=HySObZhGyvdnyp0aIui2fZoqMu1zKHZdWXgqwORvOboPg8WzOlNV4uV/y6iRTJy4rz
         22nJ2KldXaw/xdxk+xNAuEPuqRN1SbzgMZUdPJ1bC6EQsZKQV2/eUWwCAikePHsfyzGe
         f5EycTZRqBjgzwZcJsVKCs2JWbyXwIS7Tpr8Llg/rmG3/iLyoOOBbCbeTr1vOmcyPSyu
         lQmtQT7xdDXI0W88x5B6Vjl9N4QlCCAarTrtFNGhUw8gZeV27mRpdp9pJo6+KyhC6NCN
         8TAPnn6pmcQHFBbPxhSWiZb6OBUpwxX/OYCVoeRqEC9fX+nJ57laj2ys+63Zf6fojsNu
         mXqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1794524658; x=1795129458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=08MDudRooDplOYZuxvUS0XwmDlBnmweFEYBeZu/K8vU=;
        b=YEuX+fX5PVk+ImDaWF906WZy8L87NhbtVg9P43fmC2fewvrznUnbo63wuRLcy59skh
         GnRGKrbyGMz2w/B9lWL9UatD76ON/1KxM2SwCDMcioMTi6MNw5Eb2Wc9v8T/z6fgrIB1
         dvi3Ze6/Q1bIbPMCoQp3ukySEtx7HwxWZsI+gHk9izaRgjvZQvfYAunAsM3L1neAFMuK
         DQ2XXlgNRvgp5N8UaJZk6uUhqBlL2qb2CoOPPXZq6dEj4MQlo4VDdBqosBvbVEfV/GQD
         Y7LbTvm5kcgeC1iQCyQ9Lxlr7GOvxUouAI/iSUf52rUG7Q0W/y6AO1r+iSC93n+cvcoQ
         gcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524658; x=1795129458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08MDudRooDplOYZuxvUS0XwmDlBnmweFEYBeZu/K8vU=;
        b=LXk/prx48heZNls4XX3gUagHlK0GKZBERcl5pLq0CuYkl9YPQQ3aQtMDRom5hEQoHb
         VnOuaWqKON87ZvubZeI6blFxtJcrjQ8Dma3KJIFk7I3oO1gTUtefrwjNiOA7y0ZCVbEP
         5NJvLdr2Cn5ZENKqwg8e8OsLY11Oll+8ZxgbT08yy82SG9AlD0oTRZbBGH5+NbOJCHmq
         O97Rp2emn+e1LlpzQIgSvbnCfrN8UQAHK4HyDH6Ib49cGHyFmm22WqugWRPEj5lMiuz6
         Bd6iKWkozq6+9uDMz2q6Vbh5Af5RYK1uDABDfNDp2pxQGtnDTuDLpjmsvK8gQTKBbX/W
         J5EQ==
X-Forwarded-Encrypted: i=1; AL+hErHm3QQEq9Xpd/nOX6JMC+JEeYfysUIU7KP3T0YOIpqrE1iQauacQtYWvXdF0Cfy62TJFUxNH1E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/y5UK8GK+ANuaDfBjpZA6nR39lR2Y7lV+BqBJWIBBADh8oUYyS
	ePiMLqqfx7nD09B23A9fysKdhW/4roHcULxJ533sQuR8nUHJvMEaRPfUdf2Y7HFQ7zqPlxdY+09
	MpMp7wHvkaq00K3dCsFmSJsjYKGsQ9ojAJIR3E/dEbQ==
X-Gm-Gg: AYBFou3l7k/aBZECOGwAzvJD7gWUdJcLqh1A9XEN9wS1FXXfoBqzRILCXLpT1DHbcmq
	KBxehXOaBFTza0DGmvB6rnU9/GqyO7kgJgFFgooEybR+w6syCRWOxvsWsXUJrGagCCgPYIsyyX3
	FhMY/RMEl/7fqW3I+KGGtcz4XvbZXMI+LcczZygaLEz7YRftjp4JfIpC/dGxPKuj4llqtH2H4BN
	FewC66fQkklKBKrBY25KjPGuSKjmYHikGhkePnRn/iu4U8/rBhtzxFWSU/MjyjpxeKjN7y7r9y5
	dcmRi3vjAIIQ7zEqgrpVLR48s2AmCZkC6THr4/kvc8FYTas2pEuX5rPewqA9W7xVG736mUKIVJl
	/k8e+ftY8mwGj8W2Ypq/WmbKASzfh95vZXDOegY8UkabG79GcKzO5HNUiyF1Do5DG3dkJMhXJIo
	f77VPeGY8QuEWZI9paodRGFymd4CjJvVMy99J5OY2zbnu9ue9V/aR7JHNX0Z17WCI9bi5zEaXkA
	7paVk5qZJgqEln36YuLA0Z/1U4SExQ15wT7HCREWeYK9JM=
X-Received: by 2002:a05:6122:6849:20b0:5ed:c029:411d with SMTP id
 71dfb90a1353d-5ee274efedcmr1175996e0c.19.1794524658165; Thu, 12 Nov 2026
 15:04:18 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104183442.617519-1-rjethwani@purestorage.com> <20261110131222.7e228d44@kernel.org>
In-Reply-To: <20261110131222.7e228d44@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 12 Nov 2026 15:04:06 -0800
X-Gm-Features: AclHuK9qUUhccz7x5a5PPsAmZt6NNNYClixwKS7-w6C5DGK3uR7rry1APfVSnPE
Message-ID: <CAKaoeS0KoGs9mZZZngwh97+8VgphrRxnHdGr-XmKUzmVp4AK6w@mail.gmail.com>
Subject: Re: [PATCH net v6] kcm: reject attaching sockets with a ULP, and TLS
 on KCM sockets
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, syzbot@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 1:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed,  4 Nov 2026 11:34:42 -0700 Rishikesh Jethwani wrote:
> > Holding a ULP also has visible side effects: getsockopt(TCP_ULP)
>
> This part does not feel right to me. It's not a real ULP yet we will
> start announcing it via all the ULP uAPI.
>
> If you repost please try to trim the commit message and the
> documentation slop.

Agreed. I'll replace the dummy ULP with a bool in struct tcp_sock
under IS_ENABLED(CONFIG_AF_KCM).
KCM sets it on attach and clears it on detach; tls_init() checks it
under the same socket lock.
KCM still rejects an existing ULP, without appearing in the ULP UAPI.

I'll also trim the commit message and documentation.

> --
> pw-bot: cr

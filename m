Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582278;
	b=jcok3iCJnkB930Yrv8CRSErqs8wDMuFez0lK1l9VLEO3Xzd0iC0KwFjTc6z9Kt7KqXdS
	 8M6CZsVC6w4gzO7RbyWDCGdBWRPKkzr50MdvSsb/jT2AxyqJzhpd/Eyc6YN7Bl4bLihYl
	 fIP2201cTMP2RY0PN2ucPpcvZ1/a3MgH+tg73SiG2plIOcvGRbUQW77I8C+MFws74xLxz
	 4vTU57hVIl2rCxw1EG7Z9nBQeN9JEaxDU3NNpZ36488SLCclhFDMlTuYaHmqoRXHcLUMn
	 kql0FdJvUfK1eDTcIPyuSc1M0PHOOTu+oLL8FpKORfYHiXXjEsTwfMFox8eONGcdJ9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=GzNf16NNZkizHpuwga0Z0tMlnoHvbeUboIUcXI7KCTQ=;
	b=qkZRaEa69LGNzB4BOr7sCiTctC5OSCY/0afh4RXVVoz7rhMPTbb+FV8t4Y8mbbchIoVz
	 XR25t59FAd3/HQVXaNxWZqM6APXJ2xs29bw6kHMTIJvON41xNlUfeR7lzVtEzxdy5wLQz
	 gsLsM544wTjoeMrG9E2u+zt90ygk9P2IvKoBMFzfd3m02QtS4/Cr97dQ84oa3Ll++l/3L
	 i2zSVLvEPN+4hz5Ed/TKTwYJDXrS6GAFn9WtFV0UfcDDJGdQKWV+LwZGzjbgoko5Bemx+
	 X1xKtnsG+WD3/So54wvjj2ZkBBT1lMQKPWFqspHTazII67Edst0H8zq5WbiUrmUZHhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZMKOppcv;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030D606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2030D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZMKOppcv
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b3a42a4bcdso2223814a91.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795582277; x=1796187077; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GzNf16NNZkizHpuwga0Z0tMlnoHvbeUboIUcXI7KCTQ=;
        b=ZMKOppcv7GMkcWPNGWwmyPziDutU9EquY2Tb1u7CJU/H0ved0KD9S3UTPJTxCiIrYe
         21L0mMIrsXo/BNHU0gbNODCyp2RJpG2SK4n8AIAnKS91M8hxsLLdyOOg2XpqPENqAzH/
         mKbUV9aIE9XQFM2xjMihS38qk5TlTFp02Ej00TjsqMEak6aySorRfUnMTioXp9qxWd9z
         UDJBHLiZM07mXwGvUduKcFvyQtFcuKxey/XDYFDGr+JT3HH1TG/RzvBLFnweghn6bTAn
         NJCf9HY7PXT5mPzSDRScX6kx8poiVcymnaHoFGPkrVh9H7mTlRt3lnDhqX76tMW+0bId
         g09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795582277; x=1796187077;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GzNf16NNZkizHpuwga0Z0tMlnoHvbeUboIUcXI7KCTQ=;
        b=pLHgUXNdpJrAfP6hDz44Ln9RB/G5sPDGYD8Dr7IUJ8ZsaOA72QyGm5BRXzcznFAYoa
         AaR+CNFNy2K9kyO7LJofGeVVAyeM1gF60v6ztH1Vv2t/fnzofKz0s3atopxHeJPgL+Qg
         gBlNKrYzpxjCl8aTDBmSIuJ5gi3766uQ9KL+XKvFs3Pi8+NI21a9kpC7w70m2ovXXMwf
         ygsUtBGyAP1AQIeV22IdqI55/pVtf5smrdDYeim6MK6zS5xaqwtU+DHaPCjRHKJt1Hx/
         BWAgZx6RZPDN1kJOUDRx3+IEEVK5BALMdpXhBjp51hYKapwenoX0eqj+bXjmvBfA5swf
         c89Q==
X-Forwarded-Encrypted: i=1; AL+hErEwVvGMImJ0UQH0WeC+WIGYKDnuzE9reqQFTjh6uBvkiVxgDNsz5fXXHdwBPvYHaFC34NS2+qc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sQiFETvbIE5oaIqHpU6XldllXB3txiDDMPnEicFCRbPbaCxbo
	9Tesx8YkSjZpL/5EPEx72QOTV2vuOgprswPkTA1Rxuhs4PtLUremoSpL
X-Gm-Gg: AZFdTZf59JD9SP3qHsBJYeJFycG8W1dpd6fJmanNJ80Rp/4747WqKuxqf7RuhKebQUf
	J0pGdCXIGSVcvEe9FZxZekjHGNWVUuJRJ1+VYUv7a4S+4k+VECGzcjGzLltQVw4rPWv34r18MNT
	ShyolLEv0PNXFfYhuq8AWKDH1rzIJL6JM0D3oqB8yGJwzA3VvZbtm2AeDSWQBdM4pBg4ecmOuRW
	q4wO9HUlS9qx7jHyoUYpkQDBTXr+0T9CQuxd/5w0Ci2pYzpulJmmF3MiShMxDF6Q5cCrRbfRQvG
	0GyfW7TGiWIkNcSNfeBhqhtvFTVJAABm6awrCEH1Z0bLCXRrwVlVxrc0zCw0I5YzZUB5ahW8V/f
	5Jqvk24mrocaurGEyJxcAHvQZlof6CsFEq/locK7D8y25eLQaWiFIjq+KqjoeASRFnHaFvjOE0I
	uBk94NWnCze/gs3SR70H7PUKy2nO1DDGg26uMITvpnlMdEBHLGWfA430mcFY2t9WsuAm9LDMKqs
	UFHzQZQZDhZ3Y61afDdM4oytWwayDf2Slb0u/RzrHH5aPhTa7afpM70X3vF1/Mv40TRFOQ2l4hO
	XBRKUIOZm9puoX72DFlSWek7voImoSnwr8qmje3MVFB+/SifUpzGLFSfU1JxkKC4QfgCmrNn4BJ
	nkZMlg/90pOAlYDVQwV5OutRYF+OSlXi+AwJfexwki86K4D7XJ93mNvc=
X-Received: by 2002:a17:90b:134e:b0:3b0:a7e7:68f5 with SMTP id 98e67ed59e1d1-3b41c7b638bmr13032229a91.7.1795582276887;
        Tue, 24 Nov 2026 20:51:16 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm30569330a91.8.2026.11.24.20.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 20:51:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 04:51:16 +0000
Message-Id: <DN40SM25BZ6Z.34Q3QLH6PYUXL@gmail.com>
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ryan Roberts" <ryan.roberts@arm.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>
Cc: "Will Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
 <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com> <awAay4FFj1_wQtaL@arm.com>
 <DN07ZMOAD4GP.37PG3XUPBG4CM@gmail.com>
 <a6cda8a2-992f-41f9-a814-ee78363c3a69@arm.com>
 <DN2ALO12MI1Z.3HI553HDMO2FL@gmail.com>
 <85385aae-af06-4742-a39b-5a95e3e73a7e@arm.com> <awRd1mHcQDVNi9U9@arm.com>
 <0fad3d48-54cc-4919-bff9-254347c933c4@arm.com>
In-Reply-To: <0fad3d48-54cc-4919-bff9-254347c933c4@arm.com>

On Mon Nov 23, 2026 at 4:48 PM UTC, Ryan Roberts wrote:
>>=20
>> If Alexei makes the Kconfig change to force JIT always on, I'd be
>> inclined to drop this patch.
>
> Works for me.

kconfig change was applied to bpf-next.

